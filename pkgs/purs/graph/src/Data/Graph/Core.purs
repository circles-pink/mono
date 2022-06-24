module Data.Graph.Core
  ( Graph
  , deleteEdge
  , deleteNode
  , edgesToUnfoldable
  , empty
  , foldMapWithIndex
  , foldlWithIndex
  , foldrWithIndex
  , incomingIds
  , insertEdge
  , insertNode
  , lookupEdge
  , lookupNode
  , nodeIds
  , nodesToUnfoldable
  , outgoingIds
  )
  where

import Prelude

import Data.Array as A
import Data.Foldable (class Foldable, foldMap, foldl, foldr)
import Data.FoldableWithIndex as F
import Data.Map (Map)
import Data.Map as M
import Data.Maybe (Maybe(..), isNothing, maybe)
import Data.Set (Set)
import Data.Set as S
import Data.Tuple.Nested (type (/\), (/\))
import Data.Unfoldable (class Unfoldable)

newtype Graph id e n = Graph
  ( Map id
      { data :: n
      , outEdges :: Map id e
      , inIds :: Set id
      }
  )

instance showGraph :: (Show id, Show e, Show n) => Show (Graph id e n) where
  show (Graph g) = show g

instance functorGraph :: Functor (Graph id e) where
  map f (Graph nodes) = Graph $ map (\x -> x { data = f x.data }) nodes

instance foldableGraph :: Foldable (Graph id e) where
  foldr f x (Graph nodes) = foldr (\n z -> f n.data z) x nodes
  foldl f x (Graph nodes) = foldl (\z n -> f z n.data) x nodes
  foldMap f (Graph nodes) = foldMap (\n -> f n.data) nodes

foldrWithIndex :: forall id e n z. (id -> n -> z -> z) -> z -> Graph id e n -> z
foldrWithIndex f x (Graph nodes) = F.foldrWithIndex (\id n z -> f id n.data z) x nodes

foldlWithIndex :: forall id e n z. (id -> z -> n -> z) -> z -> Graph id e n -> z
foldlWithIndex f x (Graph nodes) = F.foldlWithIndex (\id z n -> f id z n.data) x nodes

foldMapWithIndex :: forall id e n m. Monoid m => (id -> n -> m) -> Graph id e n -> m
foldMapWithIndex f (Graph nodes) = F.foldMapWithIndex (\id n -> f id n.data) nodes

nodesToUnfoldable :: forall id e n f. Unfoldable f => Graph id e n -> f (id /\ n)
nodesToUnfoldable (Graph nodes) = nodes <#> _.data # M.toUnfoldable

edgesToUnfoldable :: forall id e n f. Ord id => Unfoldable f => Graph id e n -> f (id /\ id /\ e)
edgesToUnfoldable (Graph nodes) = nodes
  # (M.toUnfoldable :: _ -> Array _)
  >>= f
  # A.toUnfoldable
  where
  f (from /\ { outEdges }) = outEdges
    # (M.toUnfoldable :: _ -> Array _)
    <#> (\(to /\ e) -> from /\ to /\ e)

empty :: forall id e n. Graph id e n
empty = Graph M.empty

outgoingIds :: forall id e n. Ord id => id -> Graph id e n -> Maybe (Set id)
outgoingIds id (Graph nodes) = M.lookup id nodes <#> _.outEdges >>> M.keys

incomingIds :: forall id e n. Ord id => id -> Graph id e n -> Maybe (Set id)
incomingIds id (Graph nodes) = M.lookup id nodes <#> _.inIds

nodeIds :: forall id e n. Graph id e n -> Set id
nodeIds (Graph nodes) = M.keys nodes

lookupNode :: forall id e n. Ord id => id -> Graph id e n -> Maybe n
lookupNode id (Graph nodes) = M.lookup id nodes <#> _.data

lookupEdge :: forall id e n. Ord id => id -> id -> Graph id e n -> Maybe e
lookupEdge from to (Graph nodes) = nodes
  # M.lookup from
  >>= _.outEdges >>> M.lookup to

insertNode :: forall id e n. Ord id => id -> n -> Graph id e n -> Graph id e n
insertNode id node (Graph nodes) = Graph $ M.alter f id nodes
  where
  f Nothing = Just { data: node, outEdges: M.empty, inIds: S.empty }
  f (Just x) = Just $ x { data = node }

insertEdge :: forall id e n. Ord id => id -> id -> e -> Graph id e n -> Graph id e n
insertEdge from to _ graph | isNothing (lookupNode from graph) || isNothing (lookupNode to graph) = graph
insertEdge from to edge (Graph nodes) = Graph $ nodes
  # M.update updateFromNode from
  # M.update updateToNode to
  where
  updateFromNode x = Just $ x { outEdges = M.insert to edge x.outEdges }
  updateToNode x = Just $ x { inIds = S.insert from x.inIds }

deleteNode :: forall id e n. Ord id => id -> Graph id e n -> Graph id e n
deleteNode id graph@(Graph nodes) = Graph $ nodes
  # (\nodes' -> foldr (M.update updateToNode) nodes' outIds)
  # (\nodes' -> foldr (M.update updateFromNode) nodes' inIds)
  # M.delete id
  where
  outIds = maybe S.empty identity $ outgoingIds id graph
  inIds = maybe S.empty identity $ incomingIds id graph
  updateToNode x = Just $ x { inIds = S.delete id x.inIds }
  updateFromNode x = Just $ x { outEdges = M.delete id x.outEdges }

deleteEdge :: forall id e n. Ord id => id -> id -> Graph id e n -> Graph id e n
deleteEdge from to (Graph nodes) = Graph $ nodes
  # M.update updateFromNode from
  # M.update updateToNode to
  where
  updateFromNode x = Just $ x { outEdges = M.delete from x.outEdges }
  updateToNode x = Just $ x { inIds = S.delete to x.inIds }
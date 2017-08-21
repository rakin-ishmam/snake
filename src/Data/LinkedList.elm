module Data.LinkedList exposing (List, addRight, addLeft, init, find, moveLeft, rightMost, leftMost)


type Linked a
    = Empty
    | Node a (Linked a)


type alias List a =
    { lTor : Linked a
    , rTol : Linked a
    , length : Int
    }


init : List a
init =
    { lTor = Empty
    , rTol = Empty
    , length = 0
    }


find : (a -> Bool) -> List a -> Maybe a
find flt l =
    locFind flt l.rTol


rightMost : List a -> Maybe a
rightMost l =
    case l.rTol of
        Empty ->
            Nothing

        Node v next ->
            Just v


leftMost : List a -> Maybe a
leftMost l =
    case l.lTor of
        Empty ->
            Nothing

        Node v next ->
            Just v


locFind : (a -> Bool) -> Linked a -> Maybe a
locFind flt l =
    case l of
        Empty ->
            Nothing

        Node v next ->
            if (flt v) then
                Just v
            else
                locFind flt next


addRightLtoR : a -> Linked a -> Linked a
addRightLtoR v l =
    case l of
        Empty ->
            Node v Empty

        Node x right ->
            Node x (addRightLtoR v right)


addRightRtoL : a -> Linked a -> Linked a
addRightRtoL v l =
    case l of
        Empty ->
            Node v Empty

        Node x left ->
            Node v l


addLeftLtoR : a -> Linked a -> Linked a
addLeftLtoR v l =
    case l of
        Empty ->
            Node v Empty

        Node x right ->
            Node v l


addLeftRtoL : a -> Linked a -> Linked a
addLeftRtoL v l =
    case l of
        Empty ->
            Node v Empty

        Node x left ->
            Node x (addLeftRtoL v left)


addRight : a -> List a -> List a
addRight v l =
    { lTor = addRightLtoR v l.lTor
    , rTol = addRightRtoL v l.rTol
    , length = l.length + 1
    }


addLeft : a -> List a -> List a
addLeft v l =
    { lTor = addLeftLtoR v l.lTor
    , rTol = addLeftRtoL v l.rTol
    , length = l.length + 1
    }


moveLeftRtoL : Linked a -> Linked a
moveLeftRtoL l =
    case l of
        Empty ->
            l

        Node v left ->
            case left of
                Empty ->
                    Empty

                Node lv lleft ->
                    Node lv (moveLeftRtoL left)


moveLeftLtoR : Linked a -> Linked a -> Linked a
moveLeftLtoR pre cur =
    case cur of
        Empty ->
            cur

        Node v right ->
            case pre of
                Empty ->
                    moveLeftLtoR cur right

                Node pv pright ->
                    Node pv (moveLeftLtoR cur right)


moveLeft : List a -> List a
moveLeft l =
    { l
        | lTor = moveLeftLtoR Empty l.lTor
        , rTol = moveLeftRtoL l.rTol
    }

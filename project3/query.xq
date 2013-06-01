xquery version "3.0";

let $music := collection('/db/music')
let $term := request:get-parameter('term', 'null')

return <search-results>{
for $m in $music//score-partwise
where some $c in $m//credit-words|$m//creator satisfies (contains(lower-case($c), lower-case($term)))
return <uri>{base-uri($m)}</uri>
}</search-results>
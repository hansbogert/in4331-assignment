xquery version "3.0";

let $music := collection('/db/music')
let $term := request:get-parameter('term', 'null')

return <search-results>{
for $m in $music//score-partwise
where some $c in $m//credit-words|$m//creator|$m//movement-title satisfies (contains(lower-case($c), lower-case($term)))
return <result><title>{$m/movement-title/text()}</title><composer>{$m//creator[@type='composer']/text()}</composer><uri>{base-uri($m)}</uri></result>
}</search-results>
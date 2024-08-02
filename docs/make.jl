using Geometries
using Documenter

DocMeta.setdocmeta!(Geometries, :DocTestSetup, :(using Geometries); recursive=true)

makedocs(;
    modules=[Geometries],
    authors="Jonathan Miller jonathan.miller@fieldofnodes.com",
    sitename="Geometries.jl",
    format=Documenter.HTML(;
        canonical="https://fieldofnodes.github.io/Geometries.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/fieldofnodes/Geometries.jl",
    devbranch="main",
)

##################################################################
# Filename  : Geometries.jl
# Author    : Jonathan Miller
# Date      : 2024-02-12
# Aim       : aim_script
#           : Geometries module
#           :
##################################################################

module Geometries

using Reexport
@reexport using Base: +
@reexport using Base: -
@reexport using Base: *




export 
    Diffusion,
    Geometry,
    Origin,
    Radius,
    Angle,
    Circle,
    PolarCoordinates,
    CartesianCoordinates,
    origin,
    coordinates,
    radius,
    θ,
    p2c,
    c2p,
    modpi


abstract type Diffusion end
abstract type Geometry end

mutable struct Origin <: Geometry
    coordinates :: Vector{Union{Int, Float64}}
end

mutable struct Radius <: Geometry
    radius :: Union{Int,Float64,Irrational,Real}
end

mutable struct Angle <: Geometry
    θ :: Union{Int,Float64,Irrational,Real}
end

mutable struct Circle <: Geometry
    origin :: Origin
    radius :: Radius
end



mutable struct PolarCoordinates <: Geometry
    radius :: Radius
    θ :: Angle 
end


mutable struct CartesianCoordinates
    x :: Union{Int,Float64,Irrational,Real}
    y :: Union{Int,Float64,Irrational,Real}
end

origin(o::Origin) = o.coordinates
origin(c::Circle) = origin(c.origin)




function coordinates(p::PolarCoordinates)
    r = radius(p)
    ϕ = θ(p)
    r*cos(ϕ),r*sin(ϕ)
end
coordinates(c::CartesianCoordinates) = (c.x,c.y)


radius(r::Radius) = r.radius
radius(c::Circle) = radius(c.radius)
radius(p::PolarCoordinates) = radius(p.radius)
radius(c::CartesianCoordinates) =  √(c.x^2 + c.y^2)
 

θ(a::Angle) = a.θ
θ(p::PolarCoordinates) = θ(p.θ)
θ(c::CartesianCoordinates) = atan(c.y,c.x)


function p2c(p::PolarCoordinates)::CartesianCoordinates
    x,y = coordinates(p)
    CartesianCoordinates(x,y)
end


function c2p(c::CartesianCoordinates)::PolarCoordinates
    r = radius(c) |> Radius
    ϕ = θ(c) |> Angle
    PolarCoordinates(r,ϕ)
end

function modpi(x)
    angle = mod2pi(x)
    angle > π ? angle - 2*π : angle
end



function Base.:+(p₁::PolarCoordinates,p₂::PolarCoordinates)::PolarCoordinates
    radius(p₁) == radius(p₂) || error("Radii must be equal")
    PolarCoordinates(p₁.radius,Angle(modpi(θ(p₁) + θ(p₂))))
end

function Base.:+(c₁::CartesianCoordinates,c₂::CartesianCoordinates)::CartesianCoordinates
    CartesianCoordinates(c₁.x + c₂.x,c₁.y + c₂.y)
end

function Base.:-(p₁::PolarCoordinates,p₂::PolarCoordinates)::PolarCoordinates
    radius(p₁) == radius(p₂) || error("Radii must be equal")
    PolarCoordinates(p₁.radius,Angle(modpi(θ(p₁) - θ(p₂))))
end




function Base.:+(a::Angle,b::Angle)::Angle
    Angle(modpi(θ(a) + θ(b)))    
end

function Base.:-(a::Angle,b::Angle)::Angle
    Angle(modpi(θ(a) - θ(b)))    
end

function Base.:-(a::Angle)::Angle
    Angle(modpi(-θ(a)))  
end

function Base.:*(a::Union{Int,Float64,Irrational,Real},b::Angle)::Angle
    Angle(modpi(a*θ(b)))    
end
function Base.:*(a::Angle,b::Union{Int,Float64,Irrational,Real})::Angle
    Angle(modpi(b*θ(a)))    
end



end


# Day 1: https://adventofcode.com/2019/day/1
using Test

cd("C:\\Users\\ricob\\Documents\\Data\\Sync\\Richard\\Projects\\adventofcode\\Day1")
ENV["JULIA_DEBUG"]="all"

function fuel_requirements(mass)
    # To find the fuel required for a module, take its mass, divide by three,
    # round down, and subtract 2.

    return floor(mass / 3) - 2
end

function get_total_fuel(masses)
    total_fuel = 0
    for m in masses
        total_fuel += fuel_requirements(m)
    end

    return total_fuel
end

@test 2 == fuel_requirements(12)
@test 2 == fuel_requirements(14)
@test 654 == fuel_requirements(1969)
@test 33583 == fuel_requirements(100756)
# If it reaches here, all tests have passed.
println("All tests passed")

# Read in the mass
masses = open("Day1_module_mass.txt") do file
    lines = readlines(file)
    map(x->parse(Float64,x),lines)
end
fuel = get_total_fuel(masses)

println("The total fuel requirements are: $fuel")


# Part 2: https://adventofcode.com/2019/day/1#part2
function get_new_fuel(masses)
    terminated = false
    final_fuel = 0
    while !terminated
        new_masses = []
        for m in masses
            println("$m")
            fuel_requirement = fuel_requirements(m)
            if fuel_requirements(fuel_requirement) <= 0
                final_fuel += fuel_requirement
                break
            else
                push!(new_masses, m + fuel_requirement)
            end
        end
        if length(new_masses) == 0
            terminated = true
        end
        masses = new_masses
    end

    return final_fuel
end

@test 2 == get_new_fuel([14])
@test 966 == get_new_fuel([1969])
@test 50346 == get_new_fuel([100756])

fuel_new = get_total_fuel(new_masses)
println("The new total fuel requirements are: $fuel_new")

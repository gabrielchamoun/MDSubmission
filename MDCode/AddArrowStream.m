function [ output_args ] = AddArrowStream(num, x0, y0, PartAng, Type, Ep)
% based on AddParticleStream.m
global AtomSpacing x y AtomType Vx Vy Mass0 Mass1 nAtoms

if Type == 0
    Mass = Mass0;
else
    Mass = Mass1;
end

for p = 0:num
    % Conditional to check for first iteration
    if p > 0
        nAtoms = nAtoms + 1;
        x(nAtoms) = x0 * AtomSpacing - p * AtomSpacing;
        y(nAtoms) = y0 * AtomSpacing - p * AtomSpacing * sin(PartAng);
        AtomType(nAtoms) = Type;
        
        nAtoms = nAtoms + 1;
        x(nAtoms) = x0 * AtomSpacing + p * AtomSpacing;
        y(nAtoms) = y0 * AtomSpacing - p * AtomSpacing * sin(PartAng);
        AtomType(nAtoms) = Type;
    else % only add a single atom in the center to start
        nAtoms = nAtoms + 1;
        x(nAtoms) = x0 * AtomSpacing;
        y(nAtoms) = y0 * AtomSpacing - p * AtomSpacing * sin(PartAng);
        AtomType(nAtoms) = Type;
    end
end

V = sqrt(2 * Ep / Mass);

% Total number of Atoms spawned
elements = num*2+1;
for p = 0:elements
    Vx(nAtoms - elements + p) = V * cos(PartAng);
    Vy(nAtoms - elements + p) = V * sin(PartAng);
end

end

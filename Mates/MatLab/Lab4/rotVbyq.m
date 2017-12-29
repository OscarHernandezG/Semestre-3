function [ vr ] = rotVbyq( v, q )

if (norm(q))    
    q_c = [q(1); -1 * q(2); -1 * q(3); -1 * q(4)];
    V = [0 ; v];
    Vr = quaternionproduct(quaternionproduct(q,V),q_c);
    vr = [Vr(2); Vr(3); Vr(4)];
else
    vr = -1;
    fprintf('Provided quaternion is not a unit vector')
end

end


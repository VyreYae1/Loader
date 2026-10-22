local f113 = function(q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    return function()
      local q
      local q, S = P
      local P = z
      if q.activeTween == P then
        local q = z
        if not (q.cancelled) then
          local q
          local q = y
          if q.Parent then
            local q, P = y
            q.WalkSpeed = i[5][i[4]]
          end
        end
      end
    end
  end
end

local f125 = function(q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    return function(q)
      local z = q.arrivalHold
      if type(z) ~= "table" then
        return false
      elseif typeof(z.CFrame) ~= "CFrame" then
        return false
      end
      local y
      local y = P
      if y.Character ~= z.Character then
        q.arrivalHold = nil
        return false
      elseif z.RootPart then
        if not (z.RootPart.Parent) then
          q.arrivalHold = nil
          return false
        end
      else
        q.arrivalHold = nil
        return false
      end
      q:_startHoverPad()
      pcall(function()
        z.RootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        z.RootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        q:_syncHoverPad(z.CFrame.Position)
        z.RootPart.CFrame = z.CFrame
      end)
      q:_syncHoverPad(z.CFrame.Position)
      z.Writes = (z.Writes or 0) + 1
      return true
    end
  end
end

local f108 = function(q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    local Y = q[6]
    local I = q[7]
    local v = q[8]
    local M = q[9]
    local u = q[10]
    return function()
      local q
      local q = P
      if q:_bossOwnsIdleMovement() then
        return
      end
      q = P
      if q:_bossOwnsIdleAltitudeHold() then
        local E, m = os.clock(), P
        if E < (m.bossAltitudeProtectionNextAt or 0) then
          return
        end
        local V, j = P
        m = z
        V.bossAltitudeProtectionNextAt = E + m
      else
        local z = P
        z.bossAltitudeProtectionNextAt = nil
      end
      local z
      q = y
      local z = q.Character
      local y, E = z and (z:FindFirstChild("HumanoidRootPart")), z and (z:FindFirstChildOfClass("Humanoid"))
      if z then
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
        if y then
          if E then
            if E.Health <= 0 then
              return
            end
          else
            return
          end
        else
          return
        end
      else
        return
      end
      local m, V = math.clamp, P
      local j, A = V.config.speed
      if j then
        A = j
      else
        local L
        V = i
        A = V
      end
      local i
      local i, L = S
      q = Y
      j, V = m(A, i, q), P
      V.protectionCharacter = z
      q = P
      q.protectionHumanoid = E
      m = P
      m.protectionRoot = y
      local q
      local q, i = I
      A = v
      q(z, j * A)
      local q
      A = M
      if not (A(E, y, j)) then
        local q
        V = u
        V(E, y, j)
      end
      z = P
      z:_enforceArrivalHold()
    end
  end
end

local f1862 = function(q, P, P, P, P, P, P)
  return function(P, P, z)
    local z = P[1]
    local y = P[2]
    local i = P[3]
    return function()
      local P, S, Y, I, v, M, u, E, m, V, j, A, L, C, w = 4
      while true do
        local n, b
        if P <= 5 then
          if P <= 2 then
            if P <= 0 then
              local U = S[2]
              P, S = 7, U
            elseif P <= 1 then
              local U = q[61](M, 255)
              local a = q[61](I + V[U], 255)
              V[U], V[a] = V[a], V[U]
              local c
              M, P, I, c = q[119](V[q[61](V[U] + V[a], 255)], 8), 10, a, q[61](U + 1, 255)
              C = c
            else
              return j
            end
          elseif P <= 3 then
            local U, a, c = S[3], S[5], S[2]
            local D, r = U + a, a <= 0
            U, a = D >= c, D <= c
            c = (r and U) or (not r and a)
            S[3] = D
            if c then
              P, Y = 8, D
            else
              P = 5
            end
          elseif P <= 4 then
            local U
            local U, a = z[5][z[4]]
            local z = y[5][y[4]]
            local y, a, a, c, D = q[27](U) - z
            a, n, b, c, D = i[5][i[4]], 0, 0, q[105](y), y - (y % 4)
            local i, r = D - 1, 4 + 0
            local o, p = 0 - r
            p, P = {i + 0, S, o, nil, r}, 6
            S, v, M, u, E, m, V, j, A = p, 0, 0, U, z, y, a, c, D
          else
            local z = S[4]
            P, S = 2, z
          end
        elseif P <= 8 then
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
          if P <= 6 then
            local z, y, i = S[3], S[5], S[1]
            local U, a = z + y, y <= 0
            y, z = U >= i, U <= i
            i = (a and y) or (not a and z)
            S[3] = U
            if i then
              P, L = 9, U
            else
              P = 0
            end
          elseif P <= 7 then
            local z, y = m - 1, 1 + 0
            local i = A - y
            local m = {nil, z + 0, i, S, y}
            P, S = 3, m
          else
            n = q[61](v + 1, 255)
            b = q[61](M + V[n], 255)
            V[n], V[b] = V[b], V[n]
            local z = V[q[61](V[n] + V[b], 255)]
            q[12](j, Y, (q[115](q[10](u, E + Y), z)))
            P, v, M = 3, n, b
          end
        elseif P <= 9 then
          local z, y = 0, q[61](v + 1, 255)
          local i = q[61](M + V[y], 255)
          V[y], V[i] = V[i], V[y]
          P, Y, I, v, M = 1, z, i, q[119](V[q[61](V[y] + V[i], 255)], 0), y + 1
        elseif P <= 10 then
          local z = q[61](I + V[C], 255)
          V[C], V[z] = V[z], V[C]
          local y
          I, P, y = q[119](V[q[61](V[C] + V[z], 255)], 16), 11, q[61](C + 1, 255)
          C, w = y, z + V[y]
        else
          local z = q[61](w, 255)
          V[C], V[z] = V[z], V[C]
          local y = q[100](Y, v, M, I, (q[119](V[q[61](V[C] + V[z], 255)], 24)))
          q[43](j, L, (q[115](q[25](u, E + L), y)))
          P, Y, I, v, M = 6, C, z, C, z
        end
      end
    end
  end
end

local f57 = function(q, q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    return function(q)
      local z
      local z = P
      local P = z.Character
      if not (P) then
        return
      end
      for z, z in ipairs(P:GetDescendants()) do
        if z:IsA("BasePart") then
          if q.noclipOriginal[z] == nil then
            q.noclipOriginal[z] = z.CanCollide
          end
          z.CanCollide = false
        end
      end
    end
  end
end

local f1 = function(q, q, q, q, q, q)
  return function(q)
    return function(q)
      local P, z = q.coordinator and q.coordinator.active, q.scrambleBossRuntime
      return ((((((P and (P.owner == "auto_scramble_boss")) and z) and (z.altitudeHoldActive == true)) and not q.activeTween) and not q.travelBusy) and not q.arrivalHold) and (os.clock() >= (q.bossRouteProtectionUntil or 0))
    end
  end
end

local f46 = function(q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    return function()
      local q
      local q, S = P
      local P = z
      if q.activeTween == P then
        local q = z
        if not (q.cancelled) then
          local q
          local q = y
          if q.Parent then
            local q, P = y
            q.WalkSpeed = i[5][i[4]]
          end
        end
      end
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
    end
  end
end

local f20 = function(q, q, q, q, q, q, q)
  return function(q)
    return function(q)
      local P = q.eggRuntime
      return q._primerHitWindow or (P and (P.waitingGuardHit == true))
    end
  end
end

local f8 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    return function(q, y, i, S)
      local Y = q._groundRayParams
      if Y then
      else
        Y = RaycastParams.new()
        Y.FilterType = Enum.RaycastFilterType.Exclude
        Y.RespectCanCollide = true
        q._groundRayParams = Y
      end
      local I, v = {y}
      y = P
      for P, P in ipairs(y) do
        q = workspace:FindFirstChild(P)
        if q then
          I[#I + 1] = q
        end
      end
      Y.FilterDescendantsInstances = I
      local P, y = S.Position.Y - ((S.Size.Y * 0.5) + math.max(i.HipHeight, 0.5))
      i, I = z, workspace:Raycast(S.Position, Vector3.new(0, -(z + 30), 0), Y)
      if not I then
        return true
      end
      q = z
      return (P - I.Position.Y) > q
    end
  end
end

local f126 = function(q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    local Y = q[6]
    local I = q[7]
    local v = q[8]
    local M = q[9]
    local u = q[10]
    local E = q[11]
    local m = q[12]
    local V = q[13]
    local j = q[14]
    local A = q[15]
    local L = q[16]
    local C = q[17]
    local w = q[18]
    local n = q[19]
    local b = q[20]
    local U = q[21]
    local a = q[22]
    local c = q[23]
    local D = q[24]
    local r = q[25]
    local o = q[26]
    local p = q[27]
    local f = q[28]
    local Q = q[29]
    local Z = q[30]
    local F = q[31]
    local O = q[32]
    local e = q[33]
    local k = q[34]
    local R = q[35]
    local x = q[36]
    local T = q[37]
    local g = q[38]
    local G = q[39]
    local W = q[40]
    local l = q[41]
    local t = q[42]
    local B = q[43]
    local d = q[44]
    local J = q[45]
    local h = q[46]
    return function(q)
      local H
      local H, X = P
      if H.abort then
        local X = P
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
        if X.abort() then
          local X = z
          X(false)
          return
        end
      end
      local X
      local X, s, s, s, s = y
      if X.destroyed then
        H = z
        H(false)
        return
      else
        local s, K = y, i
        if s.activeTween ~= K then
          local s = z
          s(false)
          return
        else
          local s
          local s, K = S, Y
          if s.Character ~= K then
            local S = z
            S(false)
            return
          else
            local S = I
            if S.Parent then
              local S = v
              if not (S.Parent) then
                local S = z
                S(false)
                return
              end
            else
              local S = z
              S(false)
              return
            end
          end
        end
      end
      X = y
      local S, s, s, s, s = X.antiGuard
      if S then
        if S.antiHitBusy then
          H = M
          H:setMoving(false)
          X = u
          X()
          E[5][E[4]], m[5][m[4]] = nil, nil
          return
        end
      end
      H = pcall(function()
        local X, s = P
        if X.dynamicDestination then
          local s, s, K = P, pcall(P.dynamicDestination)
          if s then
            if typeof(K) ~= "CFrame" then
              local s = z
              s(false)
              return
            end
          else
            local s = z
            s(false)
            return
          end
          V[5][V[4]] = K
        end
        local s, K = y, i
        if s.activeTween ~= K then
          return
        end
        local _, N = math.clamp
        K, s = j
        if K then
          s = K
        else
          X = y
          s = X.config.speed
        end
        X = nil
        if s then
          X = s
        else
          local j
          K = A
          X = K
        end
        local j
        local j, A = L
        s = C
        K = _(X, j, s)
        local A
        local A, C, N = w, Y
        j = n
        A(C, K * j)
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
        local Y
        local Y, w = b
        A = U
        C = Y()[A]
        local w, b = ((type(C) == "table") and C.State) or nil
        local b, U, N, qw = a, v, I
        if not (b(w, U, N)) then
          _ = M
          _:setMoving(false)
          E[5][E[4]], m[5][m[4]] = nil, nil
          Y = u
          Y()
          j = I
          j.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
          C = I
          C.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
          s, A = y, I
          s:_syncHoverPad(A.Position)
          local a
          local a, qw, Pw = c, v, I
          if a(w, qw, Pw) then
            local a
            local a, c = D, n
            a(w, K * c, (Vector3.new(0, 0, 0)))
          else
            local n, a, c = r, v, I
            n(a, c, K)
          end
          return
        end
        s = I
        local n, a = s.Position
        o[5][o[4]] += (math.max(q, 0.001) - o[5][o[4]]) * 0.1
        local a
        s, U = p, math.max(0, math.min(q, p, 2 * o[5][o[4]]))
        local q
        N, A = os.clock() < f[5][f[4]]
        if N then
          local q, q, a
          q, a, A = L, Q, math.max(L, K * Q)
        else
          A = N
        end
        Y = A or K
        _, X = Y * U, V[5][V[4]].Position - n
        A, N = X.Magnitude, Vector3.new(X.X, 0, X.Z)
        local q, L, a, c, c = N.Magnitude, V[5][V[4]].Position, i
        if a.routeCruiseY then
          j = i
          if j.travelPhase == "takeoff" then
            C = i
            w = C.routeCruiseY - n.Y
            if w <= math.max(_, 1.5) then
              b = i
              b.travelPhase = "cruise"
            end
          end
          X = i
          if X.isFlyMode then
            local c = i
            if c.travelPhase == "cruise" then
              if q <= math.max(_ * 1.5, 24) then
                local c = i
                c.travelPhase = "landing"
              end
            end
          end
          local c = i
          if c.travelPhase == "takeoff" then
            local c = P
            if c.isCarryReturn then
              if Z[5][Z[4]] and (F[5][F[4]] == "takeoff") then
                L = Z[5][Z[4]].Position
              else
                local c, c = i, math.max(0, i.routeCruiseY - n.Y)
                local D = math.min(q, c * 2)
                local c, o = ((q > 0.001) and (N.Unit * D)) or Vector3.new(0, 0, 0)
                o, L = i, Vector3.new(n.X + c.X, i.routeCruiseY, n.Z + c.Z)
              end
            else
              local c
              c, L = i, Vector3.new(n.X, i.routeCruiseY, n.Z)
            end
          else
            local c = i
            if c.travelPhase == "landing" then
              local c = i
              L = c.targetGroundCFrame.Position
            else
              L = V[5][V[4]].Position
            end
          end
        else
        end
        b, a = (L - n).Magnitude, i
        local c, D, D = (a.routeCruiseY and q) or A
        if E[5][E[4]] then
          a = O
          if c > (E[5][E[4]] + a) then
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
            C = nil
            C, f[5][f[4]] = e, os.clock() + e
          end
        end
        E[5][E[4]] = c
        c, C, q = I, I, Vector3.new(I.CFrame.LookVector.X, 0, I.CFrame.LookVector.Z)
        a = ((N.Magnitude > 0.001) and N.Unit) or (((q.Magnitude > 0.001) and q.Unit) or Vector3.new(0, 0, -1))
        q = CFrame.lookAt(L, L + a)
        local C
        X, j = k[5][k[4]]
        if X then
          w = nil
          w, j = O, (n - k[5][k[4]]).Magnitude > O
        else
          j = X
        end
        local C, C, c = P, tonumber(P.dynamicRebaseDistance) or 0.05
        X = R[5][R[4]]
        w, N = not X
        if X then
          local c
          c, N = i, F[5][F[4]] ~= i.travelPhase
        else
          N = w
        end
        local c, c
        if (N or j) or ((Z[5][Z[4]].Position - L).Magnitude > C) then
          w = I
          R[5][R[4]], Z[5][Z[4]] = w.CFrame, q
          X = i
          F[5][F[4]] = X.travelPhase
          x[5][x[4]], T[5][T[4]] = (Z[5][Z[4]].Position - R[5][R[4]].Position).Magnitude, 0
          if j then
            m[5][m[4]] = nil
            local L
            L, f[5][f[4]] = e, os.clock() + e
          end
        end
        local L, L
        local L, L, L, c, D, D = g, G, math.min(Y * g, x[5][x[4]] * G), 1
        if L > 0 then
          X, j = W
          if X then
            C = nil
            C, j = W, l[5][l[4]] <= #W
          else
            j = X
          end
          N = P
          q, w = N.dynamicDestination
          if q then
            w = q
          else
            local D = W
            w = D
          end
          local D, o = (w and 1) or (T[5][T[4]] / L), (j and 1) or ((x[5][x[4]] - T[5][T[4]]) / L)
          c = math.clamp(math.min(D, o), 0, 1)
        else
        end
        local D
        N, q = t, t
        _ = (Y * (N + ((1 - q) * math.sin((c * 3.141592653589793) / 2)))) * U
        L = P
        Y, X = L.carryTarget
        if Y then
          U = i
          X = not U.__earlyCarrySpam
        else
          X = Y
        end
        if X and (A <= 30) then
          w = i
          w.__earlyCarrySpam = true
          Y = P
          C = Y.carryTarget
          local c, D = C.Uid
          N = B
          j = N.LooksLikeFirstAreaUid(c)
          L = nil
          if j then
            U = B
            L = U.SlotKey(C.AreaId, C.NestId)
          else
            L = j
          end
          local D = L or nil
          task.spawn(function()
            while true do
              local o = y
              local p = o.destroyed
              local f, Q = not p
              if p then
                Q = f
              else
                o = y
                Q = o.enabled
              end
              f = nil
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
              if Q then
                o, p = y
                p, f = i, o.activeTween == i
              else
                f = Q
              end
              Q = nil
              if f then
                o = y
                Q = not o:_hasConfirmedCarry(c)
              else
                Q = f
              end
              if not Q then
                break
              end
              local p
              o = d
              pcall(o, c, D)
              task.wait(0.08)
            end
          end)
        end
        q = i
        C = q.routeCruiseY
        j, L = not C
        if C then
          U = i
          N = U.isFlyMode
          if N then
            Y = i
            L = Y.travelPhase == "landing"
          else
            L = N
          end
        else
          L = j
        end
        X = nil
        if L then
          X = L
        else
          C = i
          N = C.isFlyMode
          j = not N
          if N then
            X = j
          else
            q = i
            X = q.travelPhase == "cruise"
          end
        end
        C = i
        local c, D = (C.isFlyMode and b) or A
        if X then
          if c <= math.max(_, 0.05) then
            U = i
            j, w = U.isFlyMode
            if j then
              N = i
              w = N.targetGroundCFrame.Position
            else
              w = j
            end
            L, q = w or V[5][V[4]].Position, y
            q:_syncHoverPad(L)
            A = I
            A.CFrame = CFrame.lookAt(L, L + a)
            C = I
            k[5][k[4]] = C.Position
            Y = I
            Y.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            local D = I
            D.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            D = y
            D:_syncHoverPad(L)
            local o, p, f = J, v, I
            o(p, f, K, (Vector3.new(0, 0, 0)))
            p, f = W
            if p then
              D = W
              f = D[l[5][l[4]]]
            else
              f = p
            end
            if typeof(f) == "CFrame" then
              l[5][l[4]] += 1
              V[5][V[4]] = f
              o = i
              o.targetGroundCFrame = f
              D = i
              D.routeCruiseY = nil
              p = i
              p.isFlyMode = false
              local V = i
              V.travelPhase = nil
              E[5][E[4]], m[5][m[4]] = nil, nil
              V = u
              V()
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
              V = M
              V:setMoving(true)
              return
            end
            D = M
            D:setMoving(false)
            if c > 0.5 then
              m[5][m[4]] = nil
            end
            p = P
            if p.continuous then
              m[5][m[4]] = nil
              return
            end
            m[5][m[4]] = m[5][m[4]] or os.clock()
            local P
            p = h
            if (os.clock() - m[5][m[4]]) >= p then
              o = z
              o(true)
            end
            return
          end
        end
        m[5][m[4]] = nil
        if b <= 0.001 then
          j = M
          j:setMoving(false)
          A = I
          A.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
          w = I
          w.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
          L = y
          L:_syncHoverPad(n)
          return
        end
        j = y
        if j.hoverPad then
          q = y
          if not (q.hoverPad.Parent) then
            X = y
            X:_startHoverPad()
          end
        else
          A = y
          A:_startHoverPad()
        end
        T[5][T[4]] = math.min(x[5][x[4]], T[5][T[4]] + _)
        w = ((x[5][x[4]] > 0.001) and (T[5][T[4]] / x[5][x[4]])) or 1
        N, C = R[5][R[4]]:Lerp(Z[5][Z[4]], w).Position, y
        C:_syncHoverPad(N)
        L = I
        L.CFrame = CFrame.lookAt(N, N + a)
        b = M
        b:setMoving((N - n).Magnitude > 0.001)
        a = I
        k[5][k[4]] = a.Position
        c = I
        c.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        L = I
        L.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        A = y
        A:_syncHoverPad(N)
        N, Y, _ = J, v, I
        if not (N(Y, _, K, (Vector3.new(0, 0, 0)))) then
          b, C, U = r, v, I
          b(C, U, K)
          j, c, L = J, v, I
          j(c, L, K, (Vector3.new(0, 0, 0)))
        end
      end)
      if not H then
        S = z
        S(false)
      end
    end
  end
end

local f116 = function(q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    return function(q, Y)
      local I
      local I = P
      local P = I()
      if not (P) then
        return false
      end
      local v, M = q and (q:FindFirstChildOfClass("Humanoid")), q and (q:FindFirstChild("HumanoidRootPart"))
      P.Humanoid = v
      P.RootPart = M
      q, I = math.clamp, tonumber(Y)
      Y = nil
      if I then
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
        Y = I
      else
        local u
        local u = z
        Y = u
      end
      local z
      local z, u = y
      local y, u = i
      I = S
      P.WalkSpeed = q(Y, z, y * I)
      P.Enabled = false
      return (v ~= nil) and (M ~= nil)
    end
  end
end

local f5082 = function(q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    return function()
      local q = 1
      while true do
        if q <= 0 then
          return
        else
          local y
          P[5][P[4]] = (P[5][P[4]] - (P[5][P[4]] % 2)) + 1
          local P
          z[5][z[4]], q = ((927241 * z[5][z[4]]) + 59880553) % 268435456, 0
        end
      end
    end
  end
end

local f42 = function(q, q, q, q, q)
  return function()
    return function(q)
      local P, z = q.coordinator and q.coordinator.active, q.scrambleBossRuntime
      return (((((P and (P.owner == "auto_scramble_boss")) and not q.activeTween) and not q.travelBusy) and not q.arrivalHold) and not (z and z.altitudeHoldActive)) and (os.clock() >= (q.bossRouteProtectionUntil or 0))
    end
  end
end

local f68 = function(q, q, q, q, q, q)
  return function(q)
    return function(q)
      return ((q.config.noclip == true) or (q.scrambleBossNoclip == true)) or (q.moveToOutboundNoclip == true)
    end
  end
end

local f13 = function(q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    return function(q, y)
      if q.enabled then
        if q.destroyed then
          return
        elseif q:_isWaitingGuardHit() then
          return
        end
      else
        return
      end
      local i = os.clock()
      if not (y) then
        if i < q._nextBodyRecoveryAt then
          return
        end
      end
      q._nextBodyRecoveryAt = i + 0.05
      local S, Y, I = q:_liveBody()
      if S then
        if not Y then
          return
        elseif I then
          if Y.Health <= 0 then
            return
          end
        else
          return
        end
      else
        return
      end
      if Y:GetState() == Enum.HumanoidStateType.Dead then
        return
      end
      if not (q.originalHumanoidStates[Y]) then
        local v, M, u = q.originalHumanoidStates, {}, Enum
        M.Physics = Y:GetStateEnabled(u.HumanoidStateType.Physics)
        u = Enum
        M.FallingDown = Y:GetStateEnabled(u.HumanoidStateType.FallingDown)
        y = Enum
        M.Ragdoll = Y:GetStateEnabled(y.HumanoidStateType.Ragdoll)
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
        v[Y] = M
      end
      y = Y:GetState()
      local v = ((((y == Enum.HumanoidStateType.Physics) or (y == Enum.HumanoidStateType.FallingDown)) or (y == Enum.HumanoidStateType.Ragdoll)) or (y == Enum.HumanoidStateType.PlatformStanding)) or (y == Enum.HumanoidStateType.Seated)
      if v then
        pcall(function()
          Y.BreakJointsOnDeath = false
          Y.AutoRotate = true
          Y:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
          Y:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
          Y:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
          Y:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
          Y.PlatformStand = false
          Y.Sit = false
          local M = Y:GetState()
          if ((((M == Enum.HumanoidStateType.Physics) or (M == Enum.HumanoidStateType.FallingDown)) or (M == Enum.HumanoidStateType.Ragdoll)) or (M == Enum.HumanoidStateType.PlatformStanding)) or (M == Enum.HumanoidStateType.Seated) then
            Y:ChangeState(Enum.HumanoidStateType.GettingUp)
            Y:ChangeState(Enum.HumanoidStateType.Running)
          end
        end)
      end
      if i >= q._nextJointSweepAt then
        q._nextJointSweepAt = i + 0.25
        for Y, Y in ipairs(S:GetDescendants()) do
          if Y:IsA("Motor6D") then
            if not (Y.Enabled) then
              Y.Enabled = true
            end
          elseif Y:IsA("BallSocketConstraint") or Y:IsA("HingeConstraint") then
            if Y.Name:find("Ragdoll", 1, true) then
              pcall(Y.Destroy, Y)
            elseif Y:GetAttribute("RagdollConstraint") then
              pcall(Y.Destroy, Y)
            end
          end
        end
      end
      y = I.AssemblyLinearVelocity
      S, i = Vector3.new(y.X, 0, y.Z).Magnitude
      if v then
        i = v
      else
        local Y
        local Y = P
        i = S > Y
      end
      S = nil
      if i then
        S = i
      else
        local P, P
        P, S = z, math.abs(y.Y) > z
      end
      if S then
        I.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        I.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        q.stats.blockedHits += 1
      end
    end
  end
end

local f2664 = function(q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    return function()
      local q = 1
      while true do
        if q <= 0 then
          return
        else
          local i, S = true
          P[5][P[4]] = i
          z[5][z[4]] = (z[5][z[4]] - (z[5][z[4]] % 2)) + 1
          local P
          y[5][y[4]], q = ((374807 * y[5][y[4]]) + 7710975) % 268435456, 0
        end
      end
    end
  end
end

local f2929 = function(q, q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    return function()
      local q = 0
      while true do
        if q <= 0 then
          local Y, I = true
          P[5][P[4]] = Y
          local P, P = z[5][z[4]][nil]
          y[5][y[4]](61600908, 4)
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
          local P, z = 19457901
          i[5][i[4]] = P
          S[5][S[4]]()
          q = 1
        else
          return
        end
      end
    end
  end
end

local f16302 = function(q, P, z, y, y, i, S, Y, I, v, M, u, E, m, V, j)
  local j, A, L, C, w, n, b, U, a, c, D, r, o, p, f, Q, Z, F, O = q[123], q[115], q[29], q[61], q[119], q[4], q[38], q[118], q[49], q[100], q.kU, q[10], q[43], q[25], q[12], q[80], q.hU, q[21], q[120]
  return function(e, e, k, k, k)
    local k, R, x, T, g, G, W, l, t, B, d, J, h, H, X, s, K, _, N = j, A, L, C, w, n, b, U, a, c, D, r, o, p, f, Q, Z, F, O
    return function(...)
      local j, A, L, C, w, n, b, U, a, c, D, r, o, p, f
      local Q, Z = V[1]
      local F, O = V[2], k(S)
      local S, V
      if u == 95 then
        S, V = E, u
        while true do
          local qw = v[S]
          if qw < 91 then
            local Pw
            if qw < 45 then
              if qw < 22 then
                if qw < 11 then
                  if qw < 5 then
                    if qw >= 2 then
                      if qw < 3 then
                        L = P[S]
                        local zw, yw, iw = Z()
                        if zw then
                          O[L + 1] = yw
                          O[L + 2] = iw
                          S = Y[S]
                        else
                          S = y[S]
                        end
                        A, o, c = zw, yw, iw
                      else
                        if qw ~= 4 then
                          local zw, yw = z[S]
                          if zw then
                            local iw = #zw / 3
                            if iw > 0 then
                              yw = {}
                              local Sw, Yw = p, U
                              for Iw = 1, iw, 1 do
                                local iw = (Iw - 1) * 3
                                local vw, Mw = zw[iw + 3], zw[iw + 2]
                                if vw == 3 then
                                  Sw = Sw or {}
                                  local uw = Sw[Mw]
                                  if uw then
                                  else
                                    uw = {[4] = Mw, [5] = O}
                                    Sw[Mw] = uw
                                  end
                                  yw[Iw] = uw
                                else
                                  if vw == 2 then
                                    yw[Iw] = O[Mw]
                                  else
                                    if vw == 1 then
                                      yw[Iw] = e[Mw]
                                    else
                                      if vw == 0 then
                                        Yw = Yw or {}
                                        local vw = Yw[Mw]
                                        if vw then
                                        else
                                          vw = {[4] = Mw, [6] = zw[iw + 1], [5] = O}
                                          Yw[Mw] = vw
                                        end
                                        yw[Iw] = vw
                                      else
                                      end
                                    end
                                  end
                                end
                              end
                              p, U = Sw, Yw
                            else
                            end
                          else
                          end
                          O[Y[S]] = m[S](nil, yw, nil)
                          L = yw
                        else
                          S = if O[y[S]] <= P[S] then S else Y[S]
                        end
                      end
                    else
                      if qw ~= 1 then
                        O[P[S]] = R(O[y[S]], O[Y[S]])
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                      else
                        O[P[S]] = O[y[S]] // Y[S]
                      end
                    end
                  else
                    if qw < 8 then
                      if qw < 6 then
                        S = if Y[S] <= O[P[S]] then S else y[S]
                      else
                        if qw ~= 7 then
                          O[Y[S]] = O[P[S]][y[S]]
                        else
                          local zw, yw, iw = Y[S], O[y[S]]
                          repeat
                            local Sw = yw % 4294967296
                            if Sw ~= Sw then
                              iw = 0
                              break
                            end
                            iw = Sw - (Sw % 1)
                          until true
                          O[zw] = iw
                        end
                      end
                    else
                      if qw < 9 then
                        L, A, o, c = y[S], R(F, T(x(F, 14), 262143), (T(x(F, 28), 15))), Y[S], P[S]
                        b = ((o < 16384) and 7) or (((o < 2097152) and 14) or 21)
                        D, n = x(o, b), T(o, g(1, b) - 1)
                        v[S] = R(D, 123, (T(x(A, 21), 127)))
                        P[S] = R(c, 36, (T(A, 127)))
                        Y[S] = R(n, 101, (T(x(A, 7), 127)))
                        y[S] = R(L, 110, (T(x(A, 14), 127)))
                        S = S - 1
                      else
                        if qw ~= 10 then
                          L = e[P[S]]
                          L[5][L[4]][O[y[S]]] = i[S]
                        else
                          S = O[Y[S]]
                        end
                      end
                    end
                  end
                else
                  if qw < 16 then
                    if qw >= 13 then
                      if qw < 14 then
                        if p then
                          for zw in G, p, nil do
                            local yw = p[zw]
                            if yw then
                              yw[5] = yw
                              yw[6] = O[zw]
                              yw[4] = 6
                              p[zw] = nil
                            end
                          end
                        end
                        if U then
                          for zw, yw in G, U, nil do
                            local iw = yw[6]
                            if U then
                              yw = U[zw]
                              if yw then
                                local Sw = k(iw)
                                W(O, zw, (zw + iw) - 1, 1, Sw)
                                yw[5] = Sw
                                yw[4] = 1
                                U[zw] = nil
                              end
                            end
                          end
                        end
                        return z[S], m[S]
                      elseif qw ~= 15 then
                        O[P[S]] = R(O[Y[S]], y[S])
                      else
                        L = O[y[S]]
                        O[P[S]] = l(t(L, Y[S], L.n))
                      end
                    else
                      if qw ~= 12 then
                        if p then
                          for zw in G, p, nil do
                            local yw = p[zw]
                            if yw then
                              yw[5] = yw
                              yw[6] = O[zw]
                              yw[4] = 6
                              p[zw] = nil
                            end
                          end
                        end
                        if U then
                          for zw, yw in G, U, nil do
                            local iw = yw[6]
                            if U then
                              yw = U[zw]
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                              if yw then
                                local Sw, Yw = zw + iw, k(iw)
                                W(O, zw, Sw - 1, 1, Yw)
                                yw[5] = Yw
                                yw[4] = 1
                                U[zw] = nil
                              end
                            end
                          end
                        end
                        return O[P[S]](O[y[S]])
                      else
                        O[y[S]] = O[Y[S]] < O[P[S]]
                      end
                    end
                  else
                    if qw >= 19 then
                      if qw < 20 then
                        O[P[S]] = O[y[S]]()
                      else
                        if qw == 21 then
                          A, L = Y[S], P[S] + 1
                          for zw = 1, y[S], 1 do
                            A = T(R(A, (g(A, 13))), 536870911)
                            A = R(A, (x(A, 13)))
                            A = T(R(A, (g(A, 14))), 536870911)
                            P[L] = R(P[L], (T(x(A, 0), 127)))
                            Y[L] = R(Y[L], (T(x(A, 7), 127)))
                            y[L] = R(y[L], (T(x(A, 14), 127)))
                            v[L] = R(v[L], (T(x(A, 21), 127)))
                            L = L + 1
                          end
                          v[S] = 107
                        else
                          L = Y[S]
                          O[L], O[L + 1] = P[S], O[y[S]]
                        end
                      end
                    else
                      if qw >= 17 then
                        if qw ~= 18 then
                          O[P[S]] = B(O[Y[S]], O[y[S]])
                        else
                          O[P[S]] = O[y[S]](i[S])
                        end
                      else
                        L = e[P[S]]
                        O[y[S]] = L[5][L[4]][O[Y[S]]]
                      end
                    end
                  end
                end
              else
                if qw < 33 then
                  if qw < 27 then
                    if qw >= 24 then
                      if qw >= 25 then
                        if qw ~= 26 then
                          if p then
                            for zw in G, p, nil do
                              local yw = p[zw]
                              if yw then
                                yw[5] = yw
                                yw[6] = O[zw]
                                yw[4] = 6
                                p[zw] = nil
                              end
                            end
                          end
                          if U then
                            for zw, yw in G, U, nil do
                              local iw = yw[6]
                              if U then
                                yw = U[zw]
                                if yw then
                                  local Sw, Yw = (zw + iw) - 1, k(iw)
                                  W(O, zw, Sw, 1, Yw)
                                  yw[5] = Yw
                                  yw[4] = 1
                                  U[zw] = nil
                                end
                              end
                            end
                          end
                          return i[S]
                        else
                          L, A = P[S], Y[S]
                          o = {n = (A - L) + 1}
                          W(O, L, A, 1, o)
                          O[y[S]] = o
                        end
                      else
                        L = e[P[S]]
                        L[5][L[4]][O[y[S]]] = O[Y[S]]
                      end
                    else
                      if qw == 23 then
                        L, A = y[S], O[Y[S]]
                        O[L + 1] = A
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                        O[L] = A[z[S]]
                        O[P[S + 1]] = m[S + 1]
                        L = P[S + 2]
                        A, o, c = O[L], O[L + 1], O[L + 2]
                        O[L] = A(o, c)
                        S = S + 2
                      else
                        O[Y[S]] = O[y[S]] - O[P[S]]
                      end
                    end
                  else
                    if qw >= 30 then
                      if qw < 31 then
                        S = if m[S] <= O[Y[S]] then S else P[S]
                      else
                        if qw ~= 32 then
                          L, A = {...}, P[S]
                          W(L, 1, Y[S], A, O)
                        else
                          O[Y[S]] = O[y[S]] + O[P[S]]
                        end
                      end
                    else
                      if qw < 28 then
                        Pw = C
                        C, L = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = Pw}, y[S]
                        r, j = O[L + 2] + 0, O[L + 1] + 0
                        Z = O[L] - r
                        S = P[S]
                      else
                        if qw ~= 29 then
                          O[y[S]] = d[i[S]]
                        else
                          O[y[S]] = P[S]
                        end
                      end
                    end
                  end
                else
                  if qw < 39 then
                    if qw < 36 then
                      if qw < 34 then
                        O[Y[S]] = T(O[y[S]], O[P[S]])
                      else
                        if qw == 35 then
                          S = if O[y[S]] ~= O[Y[S]] then P[S] else S
                        else
                          if p then
                            for zw in G, p, nil do
                              local yw = p[zw]
                              if yw then
                                yw[5] = yw
                                yw[6] = O[zw]
                                yw[4] = 6
                                p[zw] = nil
                              end
                            end
                          end
                          if U then
                            for zw, yw in G, U, nil do
                              local iw = yw[6]
                              if U then
                                yw = U[zw]
                                if yw then
                                  local Sw = k(iw)
                                  W(O, zw, (zw + iw) - 1, 1, Sw)
                                  yw[5] = Sw
                                  yw[4] = 1
                                  U[zw] = nil
                                end
                              end
                            end
                          end
                          return O[y[S]](i[S])
                        end
                      end
                    else
                      if qw < 37 then
                        O[Y[S]] = O[P[S]] < y[S]
                      elseif qw == 38 then
                        O[y[S]] = T(O[Y[S]], z[S])
                      else
                        local zw, yw, iw = Y[S], y[S], I[5]
                        local Sw = R(iw[zw], 379895444)
                        iw[zw] = Sw
                        iw, zw = I[4], Sw + 1
                        Sw = J(iw, zw)
                        local Yw, Iw
                        if Sw < 128 then
                          Yw, Iw = Sw, zw + 1
                        else
                          local vw = J(iw, zw + 1)
                          if vw < 128 then
                            Yw, Iw = (Sw - 128) + (vw * 128), zw + 2
                          else
                            local Mw = J(iw, zw + 2)
                            if Mw < 128 then
                              Yw, Iw = (((Sw - 128) * 16384) + ((vw - 128) * 128)) + Mw, zw + 3
                            else
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                              local uw = J(iw, zw + 3)
                              Yw, Iw = (((((Sw - 128) * 2097152) + ((vw - 128) * 16384)) + (Mw - 128)) + ((uw % 128) * 128)) + ((uw - (uw % 128)) * 2097152), zw + 4
                            end
                          end
                        end
                        zw, Sw = yw * 16843009, Iw + Yw
                        local vw = Sw - (Yw % 4)
                        for Yw = Iw, vw - 1, 4 do
                          h(iw, Yw, (R(H(iw, Yw), zw)))
                        end
                        for zw = vw, Sw - 1, 1 do
                          X(iw, zw, (R(J(iw, zw), yw)))
                        end
                        Y[S] = 70
                        y[S] = 240
                        P[S] = 252
                        v[S] = 107
                      end
                    end
                  else
                    if qw < 42 then
                      if qw >= 40 then
                        if qw ~= 41 then
                          L, A, o, c = Y[S], P[S], R(F, T(x(F, 14), 262143), (T(x(F, 28), 15))), y[S]
                          b = ((c < 2097152) and 7) or 14
                          D, n = x(c, b), T(c, g(1, b) - 1)
                          Y[S] = R(L, 64, (T(x(o, 7), 127)))
                          v[S] = R(D, 112, (T(x(o, 21), 127)))
                          y[S] = R(n, 7, (T(x(o, 14), 127)))
                          P[S] = R(A, 120, (T(o, 127)))
                          S = S - 1
                        else
                          O[Y[S]] = l(O[y[S]](O[P[S]]))
                        end
                      else
                        O[y[S]] = B(O[Y[S]], P[S])
                      end
                    else
                      if qw < 43 then
                        L = e[y[S]]
                        L[5][L[4]] = z[S]
                      else
                        if qw == 44 then
                          Z, j, r = C[9], C[8], C[5]
                          a, C = C[7], C[6]
                        else
                          L = P[S]
                          A, o, c = O[L], O[L + 1], O[L + 2]
                          O[L] = A(o, c)
                        end
                      end
                    end
                  end
                end
              end
            else
              if qw < 68 then
                if qw >= 56 then
                  if qw >= 62 then
                    if qw < 65 then
                      if qw >= 63 then
                        if qw == 64 then
                          if p then
                            for zw in G, p, nil do
                              local yw = p[zw]
                              if yw then
                                yw[5] = yw
                                yw[6] = O[zw]
                                yw[4] = 6
                                p[zw] = nil
                              end
                            end
                          end
                          if U then
                            for zw, yw in G, U, nil do
                              local iw = yw[6]
                              if U then
                                yw = U[zw]
                                if yw then
                                  local Sw, Yw = (zw + iw) - 1, k(iw)
                                  W(O, zw, Sw, 1, Yw)
                                  yw[5] = Yw
                                  yw[4] = 1
                                  U[zw] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]](O[y[S]], z[S])
                        else
                          local zw, yw, iw = P[S], R(Y[S], (T(R(F, (T(x(F, 29), 7))), 536870911))), I[5]
                          local Sw = R(iw[zw], 379895444)
                          iw[zw] = Sw
                          iw, zw = I[4], Sw + 1
                          Sw = J(iw, zw)
                          local Yw, Iw
                          if Sw < 128 then
                            Yw, Iw = Sw, zw + 1
                          else
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                            local vw = J(iw, zw + 1)
                            if vw < 128 then
                              Yw, Iw = (Sw - 128) + (vw * 128), zw + 2
                            else
                              local Mw = J(iw, zw + 2)
                              if Mw < 128 then
                                Yw, Iw = (((Sw - 128) * 16384) + ((vw - 128) * 128)) + Mw, zw + 3
                              else
                                local uw = J(iw, zw + 3)
                                Yw, Iw = (((((Sw - 128) * 2097152) + ((vw - 128) * 16384)) + (Mw - 128)) + ((uw % 128) * 128)) + ((uw - (uw % 128)) * 2097152), zw + 4
                              end
                            end
                          end
                          zw, Sw = yw * 16843009, Iw + Yw
                          local vw = Sw - (Yw % 4)
                          for Yw = Iw, vw - 1, 4 do
                            h(iw, Yw, (R(H(iw, Yw), zw)))
                          end
                          for zw = vw, Sw - 1, 1 do
                            X(iw, zw, (R(J(iw, zw), yw)))
                          end
                          P[S] = 114
                          Y[S] = 131
                          y[S] = 16
                          v[S] = 107
                        end
                      else
                        O[y[S]] = R(O[Y[S]], z[S])
                      end
                    else
                      if qw >= 66 then
                        if qw ~= 67 then
                          O[P[S]] = l(O[Y[S]](t(O[y[S]], 1, O[y[S]].n)))
                        else
                          O[Y[S]] = O[P[S]] == y[S]
                        end
                      else
                        Z += r
                        L = if r <= 0 then Z >= j else Z <= j
                        if L then
                          O[y[S]] = Z
                          S = Y[S]
                        else
                          S = P[S]
                        end
                      end
                    end
                  else
                    if qw >= 59 then
                      if qw >= 60 then
                        if qw == 61 then
                          O[Y[S]] = O[y[S]][z[S]]
                        else
                          if p then
                            for zw in G, p, nil do
                              local yw = p[zw]
                              if yw then
                                yw[5] = yw
                                yw[6] = O[zw]
                                yw[4] = 6
                                p[zw] = nil
                              end
                            end
                          end
                          if U then
                            for zw, yw in G, U, nil do
                              local iw = yw[6]
                              if U then
                                yw = U[zw]
                                if yw then
                                  local Sw, Yw = zw + iw, k(iw)
                                  W(O, zw, Sw - 1, 1, Yw)
                                  yw[5] = Yw
                                  yw[4] = 1
                                  U[zw] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]]()
                        end
                      else
                        O[Y[S]] = O[y[S]] / z[S]
                      end
                    else
                      if qw < 57 then
                        S = if O[y[S]] < O[P[S]] then S else Y[S]
                      else
                        if qw == 58 then
                          O[P[S]](t(O[y[S]], 1, O[y[S]].n))
                        else
                          L, A, o = y[S], P[S], Y[S]
                          c = L + A
                          b = O[c]
                          D = b.n
                          n = (A + D) - 1
                          b.n = n
                          W(b, 1, D, A, b)
                          W(O, L + 1, c - 1, 1, b)
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                          O[L] = l(O[L](t(b, 1, b.n)))
                        end
                      end
                    end
                  end
                else
                  if qw < 50 then
                    if qw >= 47 then
                      if qw >= 48 then
                        if qw ~= 49 then
                          O[Y[S]] = -O[P[S]]
                        else
                          O[Y[S]] = O[y[S]][z[S]]
                          O[Y[S + 1]] = O[y[S + 1]][z[S + 1]]
                          S += 1
                        end
                      else
                        O[y[S]] = d[z[S]][i[S]]
                      end
                    else
                      if qw == 46 then
                        O[y[S]](O[Y[S]], z[S])
                      else
                        L, A, o = y[S], P[S], Y[S]
                        c = L + A
                        O[L] = l(O[L](t(O, L + 1, c)))
                      end
                    end
                  else
                    if qw < 53 then
                      if qw >= 51 then
                        if qw ~= 52 then
                          O[P[S]] = e[Y[S]][m[S]]
                        else
                          Pw = C
                          C, L, A = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = Pw}, Y[S], s(K)
                          A(q, O[L], O[L + 1], O[L + 2])
                          a = P[S]
                          S, Z = y[S], A
                        end
                      else
                        O[Y[S]] = O[P[S]](t(O[y[S]], 1, O[y[S]].n))
                      end
                    else
                      if qw >= 54 then
                        if qw == 55 then
                          L, A, o = Y[S], {...}, P[S]
                          W(A, 1, L - 1, o, O)
                          O[(o + L) - 1] = l(_(L, ...))
                        else
                          O[P[S]] = O[y[S]] + Y[S]
                        end
                      else
                        S = if O[P[S]] then Y[S] else y[S]
                      end
                    end
                  end
                end
              else
                local _ = S
                if qw >= 79 then
                  if qw < 85 then
                    if qw < 82 then
                      if qw >= 80 then
                        if qw == 81 then
                          O[Y[_]] = O[P[_]] ~= y[_]
                        else
                          O[y[_]][O[P[_]]] = O[Y[_]]
                        end
                      else
                        O[y[_]] = q[P[_]]
                      end
                    else
                      if qw < 83 then
                        O[y[_]][z[_]] = O[Y[_]]
                      else
                        if qw ~= 84 then
                          e[Y[_]][O[y[_]]] = O[P[_]]
                        else
                          F = O[P[_]]
                        end
                      end
                    end
                  else
                    if qw < 88 then
                      if qw < 86 then
                        L = Y[_]
                        O[L], O[L + 1] = m[_], O[P[_]]
                      else
                        if qw ~= 87 then
                          O[Y[_]] = e[y[_]]
                        else
                          O[y[_]] = O[Y[_]] + z[_]
                        end
                      end
                    else
                      if qw < 89 then
                        L = P[_]
                        O[L], O[L + 1] = Y[_], m[_]
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                      else
                        if qw ~= 90 then
                          O[P[_]] = m[_]
                        else
                          O[Y[_]](O[P[_]], O[y[_]])
                        end
                      end
                    end
                  end
                else
                  if qw < 73 then
                    if qw >= 70 then
                      if qw < 71 then
                        O[y[_]](z[_], i[_])
                      elseif qw == 72 then
                        O[Y[_]] = F
                      else
                        O[Y[_]] = O[y[_]]
                      end
                    elseif qw ~= 69 then
                      if p then
                        for Pw in G, p, nil do
                          local zw = p[Pw]
                          if zw then
                            zw[5] = zw
                            zw[6] = O[Pw]
                            zw[4] = 6
                            p[Pw] = nil
                          end
                        end
                      end
                      if U then
                        for Pw, zw in G, U, nil do
                          local yw = zw[6]
                          if U then
                            zw = U[Pw]
                            if zw then
                              local iw = k(yw)
                              W(O, Pw, (Pw + yw) - 1, 1, iw)
                              zw[5] = iw
                              zw[4] = 1
                              U[Pw] = nil
                            end
                          end
                        end
                      end
                      return O[P[_]], O[y[_]]
                    else
                      if p then
                        for Pw in G, p, nil do
                          local zw = p[Pw]
                          if zw then
                            zw[5] = zw
                            zw[6] = O[Pw]
                            zw[4] = 6
                            p[Pw] = nil
                          end
                        end
                      end
                      if U then
                        for Pw, zw in G, U, nil do
                          local yw = zw[6]
                          if U then
                            zw = U[Pw]
                            if zw then
                              local iw = k(yw)
                              W(O, Pw, (Pw + yw) - 1, 1, iw)
                              zw[5] = iw
                              zw[4] = 1
                              U[Pw] = nil
                            end
                          end
                        end
                      end
                      return O[y[_]](O[Y[_]], O[P[_]])
                    end
                  else
                    if qw >= 76 then
                      if qw >= 77 then
                        if qw ~= 78 then
                          Q = O[Y[_]]
                        else
                          L = y[_]
                          O[L], O[L + 1] = O[P[_]], i[_]
                        end
                      else
                        V = Y[_]
                        S = P[_] + 1
                        break
                      end
                    else
                      if qw >= 74 then
                        if qw == 75 then
                          if p then
                            for Pw in G, p, nil do
                              local zw = p[Pw]
                              if zw then
                                zw[5] = zw
                                zw[6] = O[Pw]
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                                zw[4] = 6
                                p[Pw] = nil
                              end
                            end
                          end
                          if U then
                            for Pw, zw in G, U, nil do
                              local yw = zw[6]
                              if U then
                                zw = U[Pw]
                                if zw then
                                  local iw = k(yw)
                                  W(O, Pw, (Pw + yw) - 1, 1, iw)
                                  zw[5] = iw
                                  zw[4] = 1
                                  U[Pw] = nil
                                end
                              end
                            end
                          end
                          return i[_], O[y[_]]
                        else
                          O[Y[_]] = O[y[_]] ~= z[_]
                        end
                      else
                        O[Y[_]] = P[_] + O[y[_]]
                      end
                    end
                  end
                end
                S = _
              end
            end
          else
            if qw >= 136 then
              if qw < 159 then
                if qw < 147 then
                  local _, Pw, zw = L, A, o
                  if qw < 141 then
                    if qw >= 138 then
                      if qw >= 139 then
                        if qw == 140 then
                          O[P[S]] = x(O[Y[S]], y[S])
                        else
                          L = P[S]
                          o = L + y[S]
                          if p then
                            for yw in G, p, nil do
                              local iw = p[yw]
                              if iw then
                                iw[5] = iw
                                iw[6] = O[yw]
                                iw[4] = 6
                                p[yw] = nil
                              end
                            end
                          end
                          if U then
                            for yw, iw in G, U, nil do
                              local Sw = iw[6]
                              if U then
                                iw = U[yw]
                                if iw then
                                  local Yw, Iw = (yw + Sw) - 1, k(Sw)
                                  W(O, yw, Yw, 1, Iw)
                                  iw[5] = Iw
                                  iw[4] = 1
                                  U[yw] = nil
                                end
                              end
                            end
                          end
                          return O[L](t(O, L + 1, o))
                        end
                      else
                        if p then
                          for yw in G, p, nil do
                            local iw = p[yw]
                            if iw then
                              iw[5] = iw
                              iw[6] = O[yw]
                              iw[4] = 6
                              p[yw] = nil
                            end
                          end
                        end
                        if U then
                          for yw, iw in G, U, nil do
                            local Sw = iw[6]
                            if U then
                              iw = U[yw]
                              if iw then
                                local Yw, Iw = (yw + Sw) - 1, k(Sw)
                                W(O, yw, Yw, 1, Iw)
                                iw[5] = Iw
                                iw[4] = 1
                                U[yw] = nil
                              end
                            end
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                          end
                        end
                        return O[y[S]]
                      end
                    elseif qw ~= 137 then
                      O[y[S]]()
                    else
                      O[Y[S]] = O[P[S]](O[y[S]])
                    end
                  elseif qw < 144 then
                    if qw >= 142 then
                      if qw ~= 143 then
                        O[Y[S]] = O[P[S]] / y[S]
                      else
                        e[Y[S]][z[S]] = y[S]
                      end
                    else
                      O[Y[S]] = e[y[S]][O[P[S]]]
                    end
                  elseif qw < 145 then
                    O[P[S]] = O[y[S]] - Y[S]
                  elseif qw == 146 then
                    O[y[S]] = O[P[S]] * O[Y[S]]
                  else
                    O[y[S]] = O[Y[S]] % P[S]
                  end
                  L, A, o = _, Pw, zw
                else
                  if qw < 153 then
                    if qw < 150 then
                      if qw >= 148 then
                        if qw ~= 149 then
                          O[P[S]] = O[y[S]] * Y[S]
                        else
                          S = if O[y[S]] <= O[P[S]] then S else Y[S]
                        end
                      else
                        local _, Pw, zw = Y[S], m[S], O[P[S]]
                        local yw, iw = T(Pw, 4294967295), T(zw, 4294967295)
                        local Sw, Yw, Iw, vw = T(yw, 65535), x(yw, 16), T(iw, 65535), x(iw, 16)
                        zw = T((Sw * Iw) + g(T((Sw * vw) + (Yw * Iw), 65535), 16), 4294967295)
                        Sw = nil
                        repeat
                          Pw = zw % 4294967296
                          if Pw ~= Pw then
                            Sw = 0
                            break
                          end
                          Sw = Pw - (Pw % 1)
                        until true
                        O[_] = Sw
                      end
                    else
                      if qw < 151 then
                        O[P[S]][m[S]] = Y[S]
                      else
                        if qw ~= 152 then
                          L = e[P[S]]
                          O[y[S]] = L[5][L[4]][i[S]]
                        else
                          if p then
                            local _ = P[S]
                            local Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                      end
                    end
                  else
                    if qw < 156 then
                      if qw < 154 then
                        L, A, o = Y[S], P[S], y[S]
                        c, b = (L + o) - 1, L + A
                        D = O[b]
                        n = D.n
                        w = (A + n) - 1
                        D.n = w
                        W(D, 1, n, A, D)
                        W(O, L + 1, b - 1, 1, D)
                        f = l(O[L](t(D, 1, D.n)))
                        W(f, 1, o, L, O)
                      else
                        if qw ~= 155 then
                          if p then
                            local _ = Y[S]
                            local Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                            _ = y[S]
                            Pw = p[_]
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                            _ = P[S]
                            Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                          end
                        else
                          O[Y[S]], O[P[S]] = O[y[S]]()
                        end
                      end
                    else
                      if qw < 157 then
                        O[y[S]] = P[S] * O[Y[S]]
                      elseif qw ~= 158 then
                        if p then
                          for _ in G, p, nil do
                            local Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                        if U then
                          for _, Pw in G, U, nil do
                            local zw = Pw[6]
                            if U then
                              Pw = U[_]
                              if Pw then
                                local yw, iw = (_ + zw) - 1, k(zw)
                                W(O, _, yw, 1, iw)
                                Pw[5] = iw
                                Pw[4] = 1
                                U[_] = nil
                              end
                            end
                          end
                        end
                        return O[Y[S]], m[S]
                      else
                        local _, Pw, zw = P[S], O[Y[S]], y[S]
                        local yw, iw = T(Pw, 4294967295), T(zw, 4294967295)
                        local Pw, Sw, Yw, Iw = T(yw, 65535), x(yw, 16), T(iw, 65535), x(iw, 16)
                        yw = T((Pw * Yw) + g(T((Pw * Iw) + (Sw * Yw), 65535), 16), 4294967295)
                        zw = nil
                        repeat
                          iw = yw % 4294967296
                          if iw ~= iw then
                            zw = 0
                            break
                          end
                          zw = iw - (iw % 1)
                        until true
                        O[_] = zw
                      end
                    end
                  end
                end
              else
                if qw < 170 then
                  if qw < 164 then
                    if qw >= 161 then
                      if qw < 162 then
                        L = e[P[S]]
                        L[5][L[4]] = O[y[S]]
                      else
                        if qw == 163 then
                          S = if O[Y[S]] < z[S] then S else y[S]
                        else
                          local _, Pw, zw = P[S], O[Y[S]], O[y[S]]
                          local yw, iw = T(Pw, 4294967295), T(zw, 4294967295)
                          local Sw, Yw, Iw, vw = T(yw, 65535), x(yw, 16), T(iw, 65535), x(iw, 16)
                          Pw = T((Sw * Iw) + g(T((Sw * vw) + (Yw * Iw), 65535), 16), 4294967295)
                          zw = nil
                          repeat
                            Iw = Pw % 4294967296
                            if Iw ~= Iw then
                              zw = 0
                              break
                            end
                            zw = Iw - (Iw % 1)
                          until true
                          O[_] = zw
                        end
                      end
                    else
                      if qw == 160 then
                        O[Y[S]] = l(O[P[S]]())
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                      else
                        L, A, o = Y[S], y[S], P[S]
                        c, b, D = (L + o) - 1, L + A, l(O[L](t(O, L + 1, L + A)))
                        W(D, 1, o, L, O)
                      end
                    end
                  else
                    if qw >= 167 then
                      if qw >= 168 then
                        if qw ~= 169 then
                          O[Y[S]] = R(m[S], z[S])
                        else
                          O[P[S]] = O[y[S]] // O[Y[S]]
                        end
                      else
                        S = if P[S] < O[y[S]] then S else Y[S]
                      end
                    else
                      if qw < 165 then
                        L = Y[S]
                        O[L], O[L + 1] = P[S], y[S]
                      else
                        if qw == 166 then
                          L, A, o = Y[S], P[S], y[S]
                          c = O[L]
                          W(O, L + 1, L + A, o + 1, c)
                        else
                          O[y[S]] = O[P[S]] >= Y[S]
                        end
                      end
                    end
                  end
                else
                  if qw < 176 then
                    if qw < 173 then
                      if qw >= 171 then
                        if qw == 172 then
                          L = e[P[S]]
                          O[y[S]] = L[5][L[4]]
                        else
                          O[y[S]] = O[P[S]] ~= O[Y[S]]
                        end
                      else
                        L = P[S]
                        O[L], O[L + 1] = O[Y[S]], O[y[S]]
                      end
                    else
                      if qw >= 174 then
                        if qw ~= 175 then
                          e[y[S]][z[S]] = i[S]
                        else
                          O[Y[S]] = g(O[P[S]], y[S])
                        end
                      else
                        S = y[S]
                      end
                    end
                  else
                    if qw >= 179 then
                      if qw >= 180 then
                        if qw == 181 then
                          O[P[S]] = O[y[S]] == i[S]
                        else
                          S = if z[S] < O[Y[S]] then S else y[S]
                        end
                      else
                        O[y[S]] = O[Y[S]] .. O[P[S]]
                      end
                    else
                      if qw < 177 then
                        L, A = y[S], O[Y[S]]
                        O[L + 1] = A
                        O[L] = A[z[S]]
                      else
                        if qw == 178 then
                          S = if O[P[S]] ~= m[S] then Y[S] else S
                        else
                          A, L = (R(Y[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911)))), P[S] + 1
                          for _ = 1, y[S], 1 do
                            A = T(R(A, (g(A, 13))), 536870911)
                            A = R(A, (x(A, 13)))
                            A = T(R(A, (g(A, 14))), 536870911)
                            P[L] = R(P[L], (T(x(A, 0), 127)))
                            Y[L] = R(Y[L], (T(x(A, 7), 127)))
                            y[L] = R(y[L], (T(x(A, 14), 127)))
                            v[L] = R(v[L], (T(x(A, 21), 127)))
                            L = L + 1
                          end
                          v[S] = 107
                        end
                      end
                    end
                  end
                end
              end
            else
              if qw >= 113 then
                if qw >= 124 then
                  if qw < 130 then
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                    if qw < 127 then
                      if qw < 125 then
                        O[Y[S]] = O[P[S]] * m[S]
                      else
                        if qw == 126 then
                          if p then
                            local _ = y[S]
                            local Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                            Pw = P[S]
                            _ = p[Pw]
                            if _ then
                              _[5] = _
                              _[6] = O[Pw]
                              _[4] = 6
                              p[Pw] = nil
                            end
                          end
                        else
                          S = if O[y[S]] < Y[S] then S else P[S]
                        end
                      end
                    else
                      if qw >= 128 then
                        if qw == 129 then
                          L, A, o = P[S], Y[S], y[S]
                          c, b = O[L], L + A
                          D = O[b]
                          W(O, L + 1, b - 1, o + 1, c)
                          W(D, 1, D.n, o + A, c)
                        else
                          if p then
                            for _ in G, p, nil do
                              local Pw = p[_]
                              if Pw then
                                Pw[5] = Pw
                                Pw[6] = O[_]
                                Pw[4] = 6
                                p[_] = nil
                              end
                            end
                          end
                          if U then
                            for _, Pw in G, U, nil do
                              local zw = Pw[6]
                              if U then
                                Pw = U[_]
                                if Pw then
                                  local yw = k(zw)
                                  W(O, _, (_ + zw) - 1, 1, yw)
                                  Pw[5] = yw
                                  Pw[4] = 1
                                  U[_] = nil
                                end
                              end
                            end
                          end
                          return
                        end
                      else
                        e[Y[S]][m[S]] = O[P[S]]
                      end
                    end
                  else
                    if qw >= 133 then
                      if qw < 134 then
                        O[Y[S]] = O[y[S]] > O[P[S]]
                      elseif qw == 135 then
                        O[y[S]] = O[Y[S]] > P[S]
                      else
                        O[y[S]](O[Y[S]], t(O[P[S]], 1, O[P[S]].n))
                      end
                    elseif qw >= 131 then
                      if qw ~= 132 then
                        local _, Pw, zw = P[S], m[S], i[S]
                        local yw, iw = T(Pw, 4294967295), T(zw, 4294967295)
                        local Pw, zw, Sw, Yw = T(yw, 65535), x(yw, 16), T(iw, 65535), x(iw, 16)
                        iw = T((Pw * Sw) + g(T((Pw * Yw) + (zw * Sw), 65535), 16), 4294967295)
                        Sw = nil
                        repeat
                          Pw = iw % 4294967296
                          if Pw ~= Pw then
                            Sw = 0
                            break
                          end
                          Sw = Pw - (Pw % 1)
                        until true
                        O[_] = Sw
                      else
                        if p then
                          for _ in G, p, nil do
                            local Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                              Pw[6] = O[_]
                              Pw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                        if U then
                          for _, Pw in G, U, nil do
                            local zw = Pw[6]
                            if U then
                              Pw = U[_]
                              if Pw then
                                local yw, iw = _ + zw, k(zw)
                                W(O, _, yw - 1, 1, iw)
                                Pw[5] = iw
                                Pw[4] = 1
                                U[_] = nil
                              end
                            end
                          end
                        end
                        return O[Y[S]], O[y[S]], O[P[S]]
                      end
                    else
                      O[P[S]] = O[y[S]] - i[S]
                    end
                  end
                else
                  if qw < 118 then
                    if qw >= 115 then
                      if qw < 116 then
                        O[y[S]] = not O[Y[S]]
                      elseif qw == 117 then
                        local _, Pw, zw = P[S], R(Y[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911))), I[5]
                        local yw = R(zw[_], 379895444)
                        zw[_] = yw
                        zw, _ = I[4], yw + 1
                        yw = J(zw, _)
                        local iw, Sw
                        if yw < 128 then
                          iw, Sw = yw, _ + 1
                        else
                          local Yw = J(zw, _ + 1)
                          if Yw < 128 then
                            iw, Sw = (yw - 128) + (Yw * 128), _ + 2
                          else
                            local Iw = J(zw, _ + 2)
                            if Iw < 128 then
                              iw, Sw = (((yw - 128) * 16384) + ((Yw - 128) * 128)) + Iw, _ + 3
                            else
                              local vw = J(zw, _ + 3)
                              iw, Sw = (((((yw - 128) * 2097152) + ((Yw - 128) * 16384)) + (Iw - 128)) + ((vw % 128) * 128)) + ((vw - (vw % 128)) * 2097152), _ + 4
                            end
                          end
                        end
                        _, yw = Pw * 16843009, Sw + iw
                        local Yw = yw - (iw % 4)
                        for iw = Sw, Yw - 1, 4 do
                          h(zw, iw, (R(H(zw, iw), _)))
                        end
                        for _ = Yw, yw - 1, 1 do
                          X(zw, _, (R(J(zw, _), Pw)))
                        end
                        P[S] = 81
                        Y[S] = 179
                        y[S] = 250
                        v[S] = 107
                      else
                        O[y[S]] = O[Y[S]] .. z[S]
                      end
                    else
                      if qw ~= 114 then
                        O[y[S]] = O[P[S]] >= O[Y[S]]
                      else
                        S = if O[Y[S]] ~= P[S] then y[S] else S
                      end
                    end
                  else
                    if qw < 121 then
                      if qw < 119 then
                        L = Y[S]
                        O[L], O[L + 1] = z[S], m[S]
                      else
                        if qw ~= 120 then
                          O[y[S]] = O[P[S]] == O[Y[S]]
                        else
                          O[Y[S]] = Q
                        end
                      end
                    else
                      if qw < 122 then
                        O[P[S]] = #O[Y[S]]
                      elseif qw ~= 123 then
                        if p then
                          for _ in G, p, nil do
                            local Pw = p[_]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[_]
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                              Pw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                        if U then
                          for _, Pw in G, U, nil do
                            local zw = Pw[6]
                            if U then
                              Pw = U[_]
                              if Pw then
                                local yw = k(zw)
                                W(O, _, (_ + zw) - 1, 1, yw)
                                Pw[5] = yw
                                Pw[4] = 1
                                U[_] = nil
                              end
                            end
                          end
                        end
                        return z[S], t(O[y[S]], 1, O[y[S]].n)
                      else
                        O[Y[S]] = O[y[S]][O[P[S]]]
                      end
                    end
                  end
                end
              else
                if qw < 102 then
                  if qw >= 96 then
                    if qw >= 99 then
                      if qw >= 100 then
                        if qw == 101 then
                          O[P[S]] = m[S] .. O[Y[S]]
                        else
                          O[y[S]] = B(O[P[S]], i[S])
                        end
                      else
                        O[Y[S]](z[S])
                      end
                    else
                      if qw < 97 then
                        O[y[S]] = O[P[S]] <= O[Y[S]]
                      else
                        if qw == 98 then
                          L, A = {...}, P[S]
                          W(L, 1, Y[S], A, O)
                          O[Y[S + 1]] = O[y[S + 1]][z[S + 1]]
                          S = S + 1
                        else
                          O[y[S]][O[P[S]]] = i[S]
                        end
                      end
                    end
                  else
                    if qw >= 93 then
                      if qw >= 94 then
                        if qw ~= 95 then
                          O[y[S]] = e[P[S]][Y[S]]
                        else
                          O[y[S]] = N(O[P[S]])
                        end
                      else
                        O[y[S]][z[S]] = i[S]
                      end
                    elseif qw == 92 then
                      O[y[S]](z[S], O[Y[S]])
                    else
                      O[P[S]] = {}
                    end
                  end
                else
                  if qw < 107 then
                    if qw < 104 then
                      if qw ~= 103 then
                        A, L = (R(Y[S], (T(R(F, (T(x(F, 29), 7))), 536870911)))), P[S] + 1
                        for _ = 1, y[S], 1 do
                          A = T(R(A, (g(A, 13))), 536870911)
                          A = R(A, (x(A, 13)))
                          A = T(R(A, (g(A, 14))), 536870911)
                          P[L] = R(P[L], (T(x(A, 0), 127)))
                          Y[L] = R(Y[L], (T(x(A, 7), 127)))
                          y[L] = R(y[L], (T(x(A, 14), 127)))
                          v[L] = R(v[L], (T(x(A, 21), 127)))
                          L = L + 1
                        end
                        v[S] = 107
                      else
                        O[Y[S]] = O[P[S]] <= y[S]
                      end
                    else
                      if qw >= 105 then
                        if qw == 106 then
                          O[y[S]] = T(O[P[S]], Y[S])
                        else
                          S = if O[Y[S]] then P[S] else y[S]
                        end
                      else
                        O[y[S]](O[Y[S]])
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                      end
                    end
                  else
                    if qw >= 110 then
                      if qw < 111 then
                        O[P[S]] = not (O[y[S]] <= Y[S])
                      else
                        if qw ~= 112 then
                          L = P[S]
                          O[L], O[L + 1] = i[S], y[S]
                        else
                          O[Y[S]] = e[y[S]]
                          L, A = y[S + 1], O[Y[S + 1]]
                          O[L + 1] = A
                          O[L] = A[z[S + 1]]
                          S = S + 1
                        end
                      end
                    else
                      if not (qw < 108) then
                        if qw ~= 109 then
                          O[P[S]] = O[y[S]] / O[Y[S]]
                        else
                          O[Y[S]] = O[y[S]] > z[S]
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          S = S + 1
        end
      else
        S, V = E, u
      end
      if V == 154 then
        while true do
          local u = P[S]
          if u >= 88 then
            if u < 132 then
              if u < 110 then
                if u >= 99 then
                  local E
                  if u < 104 then
                    if u >= 101 then
                      if u < 102 then
                        if p then
                          for _ in G, p, nil do
                            local qw = p[_]
                            if qw then
                              qw[5] = qw
                              qw[6] = O[_]
                              qw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                        if U then
                          for _, qw in G, U, nil do
                            local Pw = qw[6]
                            if U then
                              qw = U[_]
                              if qw then
                                local zw = k(Pw)
                                W(O, _, (_ + Pw) - 1, 1, zw)
                                qw[5] = zw
                                qw[4] = 1
                                U[_] = nil
                              end
                            end
                          end
                        end
                        return O[y[S]], O[v[S]]
                      elseif u ~= 103 then
                        if p then
                          for _ in G, p, nil do
                            local qw = p[_]
                            if qw then
                              qw[5] = qw
                              qw[6] = O[_]
                              qw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                        if U then
                          for _, qw in G, U, nil do
                            local Pw = qw[6]
                            if U then
                              qw = U[_]
                              if qw then
                                local zw = k(Pw)
                                W(O, _, (_ + Pw) - 1, 1, zw)
                                qw[5] = zw
                                qw[4] = 1
                                U[_] = nil
                              end
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                            end
                          end
                        end
                        return O[v[S]](O[Y[S]], t(O[y[S]], 1, O[y[S]].n))
                      else
                        O[y[S]] = O[Y[S]] + v[S]
                      end
                    else
                      if u == 100 then
                        if p then
                          for _ in G, p, nil do
                            local qw = p[_]
                            if qw then
                              qw[5] = qw
                              qw[6] = O[_]
                              qw[4] = 6
                              p[_] = nil
                            end
                          end
                        end
                        if U then
                          for _, qw in G, U, nil do
                            local Pw = qw[6]
                            if U then
                              qw = U[_]
                              if qw then
                                local zw, yw = (_ + Pw) - 1, k(Pw)
                                W(O, _, zw, 1, yw)
                                qw[5] = yw
                                qw[4] = 1
                                U[_] = nil
                              end
                            end
                          end
                        end
                        return m[S]
                      else
                        E = C
                        C, L = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = E}, Y[S]
                        r, j = O[L + 2] + 0, O[L + 1] + 0
                        Z, S = O[L] - r, v[S]
                      end
                    end
                  else
                    if u >= 107 then
                      if u >= 108 then
                        if u == 109 then
                          local _, qw, Pw = v[S], R(Y[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911))), I[5]
                          local zw = R(Pw[_], 379895444)
                          Pw[_] = zw
                          _, Pw = I[4], zw + 1
                          zw = J(_, Pw)
                          local yw, iw
                          if zw < 128 then
                            yw, iw = zw, Pw + 1
                          else
                            local Sw = J(_, Pw + 1)
                            if Sw < 128 then
                              yw, iw = (zw - 128) + (Sw * 128), Pw + 2
                            else
                              local Yw = J(_, Pw + 2)
                              if Yw < 128 then
                                yw, iw = (((zw - 128) * 16384) + ((Sw - 128) * 128)) + Yw, Pw + 3
                              else
                                local Iw = J(_, Pw + 3)
                                yw, iw = (((((zw - 128) * 2097152) + ((Sw - 128) * 16384)) + (Yw - 128)) + ((Iw % 128) * 128)) + ((Iw - (Iw % 128)) * 2097152), Pw + 4
                              end
                            end
                          end
                          zw, Pw = qw * 16843009, iw + yw
                          local Sw = Pw - (yw % 4)
                          for yw = iw, Sw - 1, 4 do
                            h(_, yw, (R(H(_, yw), zw)))
                          end
                          for zw = Sw, Pw - 1, 1 do
                            X(_, zw, (R(J(_, zw), qw)))
                          end
                          v[S] = 115
                          Y[S] = 18
                          y[S] = 64
                          P[S] = 7
                        else
                          L = e[v[S]]
                          O[y[S]] = L[5][L[4]][O[Y[S]]]
                        end
                      else
                        S = v[S]
                      end
                    else
                      if u >= 105 then
                        if u ~= 106 then
                          O[Y[S]] = O[y[S]] * v[S]
                        else
                          L = e[Y[S]]
                          L[5][L[4]] = O[y[S]]
                        end
                      else
                        E = C
                        C, L, A = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = E}, y[S], s(K)
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                        A(q, O[L], O[L + 1], O[L + 2])
                        a = Y[S]
                        S, Z = v[S], A
                      end
                    end
                  end
                else
                  local E = S
                  if u >= 93 then
                    if u < 96 then
                      if u < 94 then
                        O[v[E]](O[Y[E]], m[E])
                      elseif u == 95 then
                        O[y[E]][v[E]] = O[Y[E]]
                      else
                        V = v[E]
                        S = Y[E] + 1
                        break
                      end
                    elseif u >= 97 then
                      if u == 98 then
                        O[v[E]] = T(O[y[E]], Y[E])
                      else
                        e[y[E]][i[E]] = O[v[E]]
                      end
                    else
                      local _, qw, Pw = y[E], O[v[E]], Y[E]
                      local zw, yw = T(qw, 4294967295), T(Pw, 4294967295)
                      local Pw, iw, Sw, Yw = T(zw, 65535), x(zw, 16), T(yw, 65535), x(yw, 16)
                      zw = T((Pw * Sw) + g(T((Pw * Yw) + (iw * Sw), 65535), 16), 4294967295)
                      Pw = nil
                      repeat
                        qw = zw % 4294967296
                        if qw ~= qw then
                          Pw = 0
                          break
                        end
                        Pw = qw - (qw % 1)
                      until true
                      O[_] = Pw
                    end
                  else
                    if u < 90 then
                      if u == 89 then
                        O[v[E]] = i[E] + O[y[E]]
                      else
                        O[y[E]](M[E], i[E])
                      end
                    else
                      if u >= 91 then
                        if u ~= 92 then
                          O[Y[E]]()
                        else
                          O[v[E]] = O[y[E]] == O[Y[E]]
                        end
                      else
                        A, L = (R(Y[E], (T(R(Q, (T(x(Q, 29), 7))), 536870911)))), v[E] + 1
                        for _ = 1, y[E], 1 do
                          A = T(R(A, (g(A, 13))), 536870911)
                          A = R(A, (x(A, 13)))
                          A = T(R(A, (g(A, 14))), 536870911)
                          v[L] = R(v[L], (T(x(A, 0), 127)))
                          Y[L] = R(Y[L], (T(x(A, 7), 127)))
                          y[L] = R(y[L], (T(x(A, 14), 127)))
                          P[L] = R(P[L], (T(x(A, 21), 127)))
                          L = L + 1
                        end
                        P[E] = 7
                      end
                    end
                  end
                  S = E
                end
              else
                if u < 121 then
                  if u < 115 then
                    if u < 112 then
                      if u == 111 then
                        local E, _, qw = v[S], O[Y[S]], O[y[S]]
                        local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                        local _, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                        qw = T((_ * iw) + g(T((_ * Sw) + (yw * iw), 65535), 16), 4294967295)
                        Sw = nil
                        repeat
                          iw = qw % 4294967296
                          if iw ~= iw then
                            Sw = 0
                            break
                          end
                          Sw = iw - (iw % 1)
                        until true
                        O[E] = Sw
                      else
                        O[Y[S]] = O[y[S]] < v[S]
                      end
                    else
                      if u < 113 then
                        O[Y[S]] = O[y[S]] % O[v[S]]
                      else
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                        if u == 114 then
                          L, A, o = v[S], y[S], Y[S]
                          c = L + A
                          O[L] = l(O[L](t(O, L + 1, c)))
                        else
                          L = Y[S]
                          O[L], O[L + 1] = y[S], M[S]
                        end
                      end
                    end
                  else
                    if u >= 118 then
                      if u < 119 then
                        O[v[S]] = O[Y[S]] ~= y[S]
                      elseif u ~= 120 then
                        O[v[S]] = O[Y[S]] / y[S]
                      else
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = (E + qw) - 1, k(qw)
                                W(O, E, Pw, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[y[S]]
                      end
                    elseif u < 116 then
                      O[Y[S]] = O[y[S]] // v[S]
                    elseif u == 117 then
                      O[Y[S]] = B(O[v[S]], O[y[S]])
                    else
                      O[Y[S]] = y[S] + O[v[S]]
                    end
                  end
                else
                  if u < 126 then
                    if u >= 123 then
                      if u >= 124 then
                        if u == 125 then
                          O[v[S]] = {}
                        else
                          O[v[S]] = O[Y[S]] <= O[y[S]]
                        end
                      else
                        O[y[S]] = not O[Y[S]]
                      end
                    elseif u ~= 122 then
                      O[Y[S]] = T(O[y[S]], O[v[S]])
                    else
                      O[v[S]] = e[Y[S]][O[y[S]]]
                    end
                  else
                    if u >= 129 then
                      if u >= 130 then
                        if u ~= 131 then
                          L, A, o = v[S], y[S], Y[S]
                          c, b, D = (L + o) - 1, L + A, l(O[L](t(O, L + 1, L + A)))
                          W(D, 1, o, L, O)
                        else
                          O[Y[S]] = O[v[S]] >= m[S]
                        end
                      else
                        L = e[Y[S]]
                        O[y[S]] = L[5][L[4]][M[S]]
                      end
                    else
                      if u < 127 then
                        O[v[S]] = O[Y[S]] ~= O[y[S]]
                      else
                        if u ~= 128 then
                          L, A = v[S], O[y[S]]
                          O[L + 1] = A
                          O[L] = A[i[S]]
                        else
                          O[v[S]] = O[y[S]]()
                        end
                      end
                    end
                  end
                end
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
              end
            else
              if u < 154 then
                if u < 143 then
                  if u < 137 then
                    if u < 134 then
                      if u ~= 133 then
                        O[y[S]][M[S]] = i[S]
                      else
                        L = Y[S]
                        O[L], O[L + 1] = O[y[S]], O[v[S]]
                      end
                    else
                      if u < 135 then
                        O[v[S]] = O[y[S]][Y[S]]
                      else
                        if u ~= 136 then
                          O[Y[S]](O[v[S]], O[y[S]])
                        else
                          S = if O[y[S]] then Y[S] else v[S]
                        end
                      end
                    end
                  else
                    if u < 140 then
                      if u < 138 then
                        O[Y[S]] = O[v[S]] / O[y[S]]
                      else
                        if u == 139 then
                          O[y[S]] = O[v[S]] + i[S]
                        else
                          O[v[S]] = O[y[S]][i[S]]
                          O[v[S + 1]] = O[y[S + 1]][i[S + 1]]
                          S += 1
                        end
                      end
                    else
                      if u >= 141 then
                        if u ~= 142 then
                          O[v[S]] = #O[Y[S]]
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]](O[y[S]], O[v[S]])
                        end
                      else
                        L, A, o = Y[S], v[S], y[S]
                        c, b = (L + o) - 1, L + A
                        D = O[b]
                        n = D.n
                        w = (A + n) - 1
                        D.n = w
                        W(D, 1, n, A, D)
                        W(O, L + 1, b - 1, 1, D)
                        f = l(O[L](t(D, 1, D.n)))
                        W(f, 1, o, L, O)
                      end
                    end
                  end
                else
                  if u < 148 then
                    if u >= 145 then
                      if u < 146 then
                        Z += r
                        L = if r <= 0 then Z >= j else Z <= j
                        if L then
                          O[v[S]] = Z
                          S = Y[S]
                        else
                          S = y[S]
                        end
                      else
                        if u == 147 then
                          O[y[S]](O[v[S]], t(O[Y[S]], 1, O[Y[S]].n))
                        else
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                          O[v[S]] = O[Y[S]] - m[S]
                        end
                      end
                    else
                      if u == 144 then
                        O[Y[S]] = l(O[y[S]]())
                      else
                        O[v[S]] = O[y[S]] == i[S]
                      end
                    end
                  else
                    if u < 151 then
                      if u >= 149 then
                        if u == 150 then
                          if p then
                            local E = y[S]
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                            _ = Y[S]
                            E = p[_]
                            if E then
                              E[5] = E
                              E[6] = O[_]
                              E[4] = 6
                              p[_] = nil
                            end
                          end
                        else
                          O[v[S]] = O[Y[S]] + O[y[S]]
                        end
                      else
                        local E, _, qw = y[S], M[S], O[Y[S]]
                        local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                        local _, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                        zw = T((_ * iw) + g(T((_ * Sw) + (yw * iw), 65535), 16), 4294967295)
                        qw = nil
                        repeat
                          iw = zw % 4294967296
                          if iw ~= iw then
                            qw = 0
                            break
                          end
                          qw = iw - (iw % 1)
                        until true
                        O[E] = qw
                      end
                    elseif u >= 152 then
                      if u ~= 153 then
                        O[Y[S]] = O[v[S]](t(O[y[S]], 1, O[y[S]].n))
                      else
                        local E, _, qw = v[S], R(Y[S], (T(R(F, (T(x(F, 29), 7))), 536870911))), I[5]
                        local Pw = R(qw[E], 379895444)
                        qw[E] = Pw
                        qw, E = I[4], Pw + 1
                        Pw = J(qw, E)
                        local zw, yw
                        if Pw < 128 then
                          zw, yw = Pw, E + 1
                        else
                          local iw = J(qw, E + 1)
                          if iw < 128 then
                            zw, yw = (Pw - 128) + (iw * 128), E + 2
                          else
                            local Sw = J(qw, E + 2)
                            if Sw < 128 then
                              zw, yw = (((Pw - 128) * 16384) + ((iw - 128) * 128)) + Sw, E + 3
                            else
                              local Yw = J(qw, E + 3)
                              zw, yw = (((((Pw - 128) * 2097152) + ((iw - 128) * 16384)) + (Sw - 128)) + ((Yw % 128) * 128)) + ((Yw - (Yw % 128)) * 2097152), E + 4
                            end
                          end
                        end
                        Pw, E = _ * 16843009, yw + zw
                        local iw = E - (zw % 4)
                        for zw = yw, iw - 1, 4 do
                          h(qw, zw, (R(H(qw, zw), Pw)))
                        end
                        for Pw = iw, E - 1, 1 do
                          X(qw, Pw, (R(J(qw, Pw), _)))
                        end
                        v[S] = 95
                        Y[S] = 108
                        y[S] = 107
                        P[S] = 7
                      end
                    else
                      local E, _, qw = Y[S], v[S], m[S]
                      local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                      local _, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                      qw = T((_ * iw) + g(T((_ * Sw) + (yw * iw), 65535), 16), 4294967295)
                      Sw = nil
                      repeat
                        _ = qw % 4294967296
                        if _ ~= _ then
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                          Sw = 0
                          break
                        end
                        Sw = _ - (_ % 1)
                      until true
                      O[E] = Sw
                    end
                  end
                end
              else
                if u >= 165 then
                  if u < 170 then
                    if u >= 167 then
                      if u < 168 then
                        L = v[S]
                        O[L], O[L + 1] = O[y[S]], i[S]
                      else
                        if u == 169 then
                          O[y[S]](M[S], O[Y[S]])
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]], m[S]
                        end
                      end
                    else
                      S = if u == 166 then if O[v[S]] ~= i[S] then y[S] else S else if O[v[S]] ~= y[S] then Y[S] else S
                    end
                  else
                    if u >= 173 then
                      if u >= 174 then
                        if u == 175 then
                          O[Y[S]] = Q
                        else
                          L, A, o = Y[S], v[S], y[S]
                          c = O[L]
                          W(O, L + 1, L + A, o + 1, c)
                        end
                      else
                        O[v[S]][O[Y[S]]] = O[y[S]]
                      end
                    else
                      if u < 171 then
                        O[y[S]] = -O[Y[S]]
                      elseif u == 172 then
                        O[y[S]] = O[Y[S]] > O[v[S]]
                      else
                        O[y[S]] = O[Y[S]] ~= M[S]
                      end
                    end
                  end
                else
                  if u >= 159 then
                    if u >= 162 then
                      if u >= 163 then
                        if u ~= 164 then
                          O[v[S]] = R(O[y[S]], i[S])
                        else
                          S = if O[v[S]] ~= O[y[S]] then Y[S] else S
                        end
                      else
                        S = if O[v[S]] <= O[Y[S]] then S else y[S]
                      end
                    else
                      if u >= 160 then
                        if u ~= 161 then
                          O[y[S]] = O[Y[S]][O[v[S]]]
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]](m[S], O[v[S]])
                        end
                      elseif p then
                        local E = y[S]
                        local _ = p[E]
                        if _ then
                          _[5] = _
                          _[6] = O[E]
                          _[4] = 6
                          p[E] = nil
                        end
                        E = Y[S]
                        _ = p[E]
                        if _ then
                          _[5] = _
                          _[6] = O[E]
                          _[4] = 6
                          p[E] = nil
                        end
                        E = v[S]
                        _ = p[E]
                        if _ then
                          _[5] = _
                          _[6] = O[E]
                          _[4] = 6
                          p[E] = nil
                        end
                      end
                    end
                  else
                    if u >= 156 then
                      if u >= 157 then
                        if u == 158 then
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw, zw = E + qw, k(qw)
                                  W(O, E, Pw - 1, 1, zw)
                                  _[5] = zw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[y[S]](M[S])
                        else
                          local E, _, qw = y[S], O[v[S]]
                          repeat
                            local Pw = _ % 4294967296
                            if Pw ~= Pw then
                              qw = 0
                              break
                            end
                            qw = Pw - (Pw % 1)
                          until true
                          O[E] = qw
                        end
                      else
                        O[v[S]] = l(O[Y[S]](O[y[S]]))
                      end
                    else
                      if u ~= 155 then
                        L = e[Y[S]]
                        O[y[S]] = L[5][L[4]]
                      else
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                        A, L = y[S], v[S] + 1
                        for E = 1, Y[S], 1 do
                          A = T(R(A, (g(A, 13))), 536870911)
                          A = R(A, (x(A, 13)))
                          A = T(R(A, (g(A, 14))), 536870911)
                          v[L] = R(v[L], (T(x(A, 0), 127)))
                          Y[L] = R(Y[L], (T(x(A, 7), 127)))
                          y[L] = R(y[L], (T(x(A, 14), 127)))
                          P[L] = R(P[L], (T(x(A, 21), 127)))
                          L = L + 1
                        end
                        P[S] = 7
                      end
                    end
                  end
                end
              end
            end
          else
            if u >= 44 then
              if u < 66 then
                local E, _ = A, o
                if u < 55 then
                  if u >= 49 then
                    if u >= 52 then
                      if u < 53 then
                        O[y[S]] = Y[S]
                      elseif u ~= 54 then
                        local qw, Pw, zw = v[S], y[S], I[5]
                        local yw = R(zw[qw], 379895444)
                        zw[qw] = yw
                        qw, zw = I[4], yw + 1
                        yw = J(qw, zw)
                        local iw, Sw
                        if yw < 128 then
                          iw, Sw = yw, zw + 1
                        else
                          local Yw = J(qw, zw + 1)
                          if Yw < 128 then
                            iw, Sw = (yw - 128) + (Yw * 128), zw + 2
                          else
                            local Iw = J(qw, zw + 2)
                            if Iw < 128 then
                              iw, Sw = (((yw - 128) * 16384) + ((Yw - 128) * 128)) + Iw, zw + 3
                            else
                              local vw = J(qw, zw + 3)
                              iw, Sw = (((((yw - 128) * 2097152) + ((Yw - 128) * 16384)) + (Iw - 128)) + ((vw % 128) * 128)) + ((vw - (vw % 128)) * 2097152), zw + 4
                            end
                          end
                        end
                        zw, yw = Pw * 16843009, Sw + iw
                        local Yw = yw - (iw % 4)
                        for iw = Sw, Yw - 1, 4 do
                          h(qw, iw, (R(H(qw, iw), zw)))
                        end
                        for zw = Yw, yw - 1, 1 do
                          X(qw, zw, (R(J(qw, zw), Pw)))
                        end
                        v[S] = 194
                        y[S] = 245
                        Y[S] = 13
                        P[S] = 7
                      else
                        O[Y[S]] = e[y[S]][M[S]]
                      end
                    elseif u >= 50 then
                      if u == 51 then
                        O[Y[S]] = v[S] / O[y[S]]
                      else
                        O[Y[S]] = F
                      end
                    else
                      O[Y[S]] = N(O[v[S]])
                    end
                  else
                    if u < 46 then
                      if u == 45 then
                        O[y[S]] = O[Y[S]] >= v[S]
                      else
                        if p then
                          for qw in G, p, nil do
                            local Pw = p[qw]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[qw]
                              Pw[4] = 6
                              p[qw] = nil
                            end
                          end
                        end
                        if U then
                          for qw, Pw in G, U, nil do
                            local zw = Pw[6]
                            if U then
                              Pw = U[qw]
                              if Pw then
                                local yw, iw = (qw + zw) - 1, k(zw)
                                W(O, qw, yw, 1, iw)
                                Pw[5] = iw
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                                Pw[4] = 1
                                U[qw] = nil
                              end
                            end
                          end
                        end
                        return m[S], t(O[Y[S]], 1, O[Y[S]].n)
                      end
                    else
                      if u < 47 then
                        O[Y[S]][m[S]] = O[v[S]]
                      else
                        if u == 48 then
                          O[Y[S]] = O[v[S]] == y[S]
                        else
                          S = if O[v[S]] < y[S] then S else Y[S]
                        end
                      end
                    end
                  end
                else
                  if u < 60 then
                    if u >= 57 then
                      if u >= 58 then
                        local qw
                        if u ~= 59 then
                          qw = nil
                          local Pw = m[S]
                          if Pw then
                            local zw = #Pw / 3
                            if zw > 0 then
                              qw = {}
                              local yw, iw = p, U
                              for Sw = 1, zw, 1 do
                                local zw = (Sw - 1) * 3
                                local Yw, Iw = Pw[zw + 3], Pw[zw + 2]
                                if Yw == 3 then
                                  yw = yw or {}
                                  local vw = yw[Iw]
                                  if vw then
                                  else
                                    vw = {[4] = Iw, [5] = O}
                                    yw[Iw] = vw
                                  end
                                  qw[Sw] = vw
                                else
                                  if Yw == 2 then
                                    qw[Sw] = O[Iw]
                                  else
                                    if Yw == 1 then
                                      qw[Sw] = e[Iw]
                                    else
                                      if Yw == 0 then
                                        iw = iw or {}
                                        local Yw = iw[Iw]
                                        if Yw then
                                        else
                                          Yw = {[4] = Iw, [6] = Pw[zw + 1], [5] = O}
                                          iw[Iw] = Yw
                                        end
                                        qw[Sw] = Yw
                                      else
                                      end
                                    end
                                  end
                                end
                              end
                              p, U = yw, iw
                            else
                            end
                          else
                          end
                          O[Y[S]] = M[S](nil, qw, nil)
                        else
                          L = Y[S]
                          o = L + y[S]
                          if p then
                            for Pw in G, p, nil do
                              local zw = p[Pw]
                              if zw then
                                zw[5] = zw
                                zw[6] = O[Pw]
                                zw[4] = 6
                                p[Pw] = nil
                              end
                            end
                          end
                          if U then
                            for Pw, zw in G, U, nil do
                              local yw = zw[6]
                              if U then
                                zw = U[Pw]
                                if zw then
                                  local iw, Sw = Pw + yw, k(yw)
                                  W(O, Pw, iw - 1, 1, Sw)
                                  zw[5] = Sw
                                  zw[4] = 1
                                  U[Pw] = nil
                                end
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                              end
                            end
                          end
                          return O[L](t(O, L + 1, o))
                        end
                        L = qw
                      else
                        O[Y[S]] = y[S] * O[v[S]]
                      end
                    else
                      if u == 56 then
                        O[Y[S]] = O[y[S]] <= v[S]
                      else
                        if p then
                          for qw in G, p, nil do
                            local Pw = p[qw]
                            if Pw then
                              Pw[5] = Pw
                              Pw[6] = O[qw]
                              Pw[4] = 6
                              p[qw] = nil
                            end
                          end
                        end
                        if U then
                          for qw, Pw in G, U, nil do
                            local zw = Pw[6]
                            if U then
                              Pw = U[qw]
                              if Pw then
                                local yw, iw = (qw + zw) - 1, k(zw)
                                W(O, qw, yw, 1, iw)
                                Pw[5] = iw
                                Pw[4] = 1
                                U[qw] = nil
                              end
                            end
                          end
                        end
                        return O[y[S]](O[Y[S]])
                      end
                    end
                  else
                    if u < 63 then
                      if u < 61 then
                        if p then
                          local qw = y[S]
                          local Pw = p[qw]
                          if Pw then
                            Pw[5] = Pw
                            Pw[6] = O[qw]
                            Pw[4] = 6
                            p[qw] = nil
                          end
                        end
                      else
                        if u == 62 then
                          L = e[v[S]]
                          L[5][L[4]][i[S]] = O[y[S]]
                        else
                          Q = O[Y[S]]
                        end
                      end
                    else
                      if u >= 64 then
                        if u == 65 then
                          L = v[S]
                          O[L], O[L + 1] = O[Y[S]], y[S]
                        else
                          O[y[S]] = O[Y[S]](O[v[S]])
                        end
                      else
                        F = O[v[S]]
                      end
                    end
                  end
                end
                A, o = E, _
              else
                if u < 77 then
                  if u < 71 then
                    if u >= 68 then
                      if u >= 69 then
                        if u ~= 70 then
                          O[v[S]] = e[y[S]][Y[S]]
                        else
                          L = y[S]
                          O[L], O[L + 1] = i[S], O[v[S]]
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = E + qw, k(qw)
                                W(O, E, Pw - 1, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[y[S]], O[Y[S]], O[v[S]]
                      end
                    else
                      if u == 67 then
                        O[Y[S]] = T(O[y[S]], M[S])
                      else
                        O[v[S]] = O[Y[S]] * m[S]
                      end
                    end
                  else
                    if u >= 74 then
                      if u >= 75 then
                        if u ~= 76 then
                          O[v[S]] = O[y[S]] - O[Y[S]]
                        else
                          O[v[S]] = O[Y[S]] - y[S]
                        end
                      else
                        O[y[S]](t(O[Y[S]], 1, O[Y[S]].n))
                      end
                    elseif u >= 72 then
                      if u ~= 73 then
                        O[v[S]] = O[y[S]] % Y[S]
                      else
                        O[v[S]] = O[y[S]] // O[Y[S]]
                      end
                    else
                      O[v[S]], O[y[S]] = O[Y[S]]()
                    end
                  end
                else
                  if u < 82 then
                    if u >= 79 then
                      if u < 80 then
                        L = y[S]
                        O[L], O[L + 1] = i[S], M[S]
                      else
                        if u ~= 81 then
                          e[v[S]][m[S]] = i[S]
                        else
                          O[Y[S]] = O[v[S]] < O[y[S]]
                        end
                      end
                    else
                      if u == 78 then
                        L, A = v[S], O[y[S]]
                        O[L + 1] = A
                        O[L] = A[i[S]]
                        O[y[S + 1]] = M[S + 1]
                        L, A, o = v[S + 2], y[S + 2], Y[S + 2]
                        c, b, D = (L + o) - 1, L + A, l(O[L](t(O, L + 1, L + A)))
                        W(D, 1, o, L, O)
                        S = S + 2
                      else
                        L = Y[S]
                        O[L], O[L + 1] = v[S], y[S]
                      end
                    end
                  else
                    if u < 85 then
                      if u >= 83 then
                        if u ~= 84 then
                          S = if O[Y[S]] < O[y[S]] then S else v[S]
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return
                        end
                      else
                        S = if v[S] <= O[y[S]] then S else Y[S]
                      end
                    else
                      if u >= 86 then
                        if u ~= 87 then
                          L = v[S]
                          local E, _, qw = Z()
                          if E then
                            O[L + 1] = _
                            O[L + 2] = qw
                            S = Y[S]
                          else
                            S = y[S]
                          end
                          A, o, c = E, _, qw
                        else
                          O[Y[S]] = O[v[S]] * O[y[S]]
                        end
                      else
                        O[v[S]] = y[S] - O[Y[S]]
                      end
                    end
                  end
                end
              end
            else
              if u >= 22 then
                if u < 33 then
                  if u < 27 then
                    if u < 24 then
                      if u == 23 then
                        O[v[S]][i[S]] = y[S]
                      else
                        O[Y[S]] = R(O[y[S]], v[S])
                      end
                    elseif u < 25 then
                      O[y[S]] = R(O[Y[S]], O[v[S]])
                    elseif u == 26 then
                      O[v[S]](O[y[S]])
                    else
                      O[v[S]] = d[m[S]]
                    end
                  else
                    if u >= 30 then
                      if u >= 31 then
                        if u == 32 then
                          O[y[S]] = x(O[Y[S]], v[S])
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return m[S], M[S]
                        end
                      else
                        O[y[S]] = O[v[S]] > Y[S]
                      end
                    else
                      if u < 28 then
                        O[Y[S]] = q[v[S]]
                      else
                        if u ~= 29 then
                          S = O[y[S]]
                        else
                          L, A, o = y[S], Y[S], v[S]
                          c, b = O[L], L + A
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                          D = O[b]
                          W(O, L + 1, b - 1, o + 1, c)
                          W(D, 1, D.n, o + A, c)
                        end
                      end
                    end
                  end
                else
                  if u < 38 then
                    if u >= 35 then
                      if u >= 36 then
                        if u == 37 then
                          S = if O[Y[S]] then y[S] else v[S]
                        else
                          Z, j, r = C[9], C[8], C[5]
                          a, C = C[7], C[6]
                        end
                      else
                        S = if v[S] < O[y[S]] then S else Y[S]
                      end
                    else
                      if u == 34 then
                        O[y[S]] = O[Y[S]](M[S])
                      else
                        e[y[S]][M[S]] = Y[S]
                      end
                    end
                  else
                    if u < 41 then
                      if u < 39 then
                        O[y[S]] = O[v[S]] >= O[Y[S]]
                      else
                        if u == 40 then
                          O[Y[S]] = e[y[S]]
                        else
                          L = e[v[S]]
                          L[5][L[4]] = i[S]
                        end
                      end
                    else
                      if u < 42 then
                        O[y[S]] = M[S] .. O[Y[S]]
                      else
                        if u == 43 then
                          O[y[S]][O[v[S]]] = i[S]
                        else
                          L, A, o, c = R(Q, T(x(Q, 14), 262143), (T(x(Q, 28), 15))), v[S], Y[S], y[S]
                          b = ((c < 16384) and 7) or (((c < 2097152) and 14) or 21)
                          D, n = x(c, b), T(c, g(1, b) - 1)
                          Y[S] = R(o, 82, (T(x(L, 7), 127)))
                          v[S] = R(A, 56, (T(L, 127)))
                          P[S] = R(D, 104, (T(x(L, 21), 127)))
                          y[S] = R(n, 84, (T(x(L, 14), 127)))
                          S = S - 1
                        end
                      end
                    end
                  end
                end
              else
                if u >= 11 then
                  if u >= 16 then
                    if u >= 19 then
                      if u >= 20 then
                        if u == 21 then
                          O[v[S]] = B(O[y[S]], i[S])
                        else
                          O[v[S]] = O[y[S]]
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = E + qw, k(qw)
                                W(O, E, Pw - 1, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return M[S], O[y[S]]
                      end
                    else
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                      if u >= 17 then
                        if u == 18 then
                          L = Y[S]
                          O[L], O[L + 1] = v[S], O[y[S]]
                        else
                          L, A, o, c = Y[S], R(Q, T(x(Q, 14), 262143), (T(x(Q, 28), 15))), y[S], v[S]
                          b = ((L < 2097152) and 7) or 14
                          D, n = x(L, b), T(L, g(1, b) - 1)
                          Y[S] = R(n, 22, (T(x(A, 7), 127)))
                          y[S] = R(o, 54, (T(x(A, 14), 127)))
                          P[S] = R(D, 18, (T(x(A, 21), 127)))
                          v[S] = R(c, 106, (T(A, 127)))
                          S = S - 1
                        end
                      else
                        O[v[S]] = O[y[S]] .. O[Y[S]]
                      end
                    end
                  else
                    if u >= 13 then
                      if u < 14 then
                        S = if M[S] <= O[y[S]] then S else Y[S]
                      else
                        if u ~= 15 then
                          O[v[S]](i[S])
                        else
                          O[Y[S]][y[S]] = M[S]
                        end
                      end
                    else
                      if u == 12 then
                        S = if O[y[S]] <= v[S] then S else Y[S]
                      else
                        A, L = (R(Y[S], (T(R(F, (T(x(F, 29), 7))), 536870911)))), v[S] + 1
                        for E = 1, y[S], 1 do
                          A = T(R(A, (g(A, 13))), 536870911)
                          A = R(A, (x(A, 13)))
                          A = T(R(A, (g(A, 14))), 536870911)
                          v[L] = R(v[L], (T(x(A, 0), 127)))
                          Y[L] = R(Y[L], (T(x(A, 7), 127)))
                          y[L] = R(y[L], (T(x(A, 14), 127)))
                          P[L] = R(P[L], (T(x(A, 21), 127)))
                          L = L + 1
                        end
                        P[S] = 7
                      end
                    end
                  end
                else
                  if u >= 5 then
                    if u >= 8 then
                      if u >= 9 then
                        if u == 10 then
                          L = O[y[S]]
                          O[Y[S]] = l(t(L, v[S], L.n))
                        else
                          O[y[S]] = O[v[S]] / i[S]
                        end
                      else
                        O[y[S]] = g(O[Y[S]], v[S])
                      end
                    else
                      if u >= 6 then
                        if not (u == 7) then
                          O[Y[S]] = d[m[S]][M[S]]
                        end
                      else
                        L = v[S]
                        O[L], O[L + 1] = m[S], Y[S]
                      end
                    end
                  else
                    if u >= 2 then
                      if u < 3 then
                        O[y[S]] = O[Y[S]] .. M[S]
                      else
                        if u ~= 4 then
                          L = y[S]
                          A, o, c, b = O[L], O[L + 1], O[L + 2], O[L + 3]
                          O[L] = A(o, c, b)
                        else
                          O[v[S]] = O[y[S]][i[S]]
                        end
                      end
                    else
                      if u ~= 1 then
                        O[y[S]] = M[S]
                      else
                        S = if O[Y[S]] < m[S] then S else v[S]
                      end
                    end
                  end
                end
              end
            end
          end
          S = S + 1
        end
      else
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
      end
      if V == 32 then
        while true do
          local u = v[S]
          if u < 105 then
            if u < 52 then
              if u >= 26 then
                if u < 39 then
                  if u >= 32 then
                    local E = S
                    if u >= 35 then
                      if u < 37 then
                        if u ~= 36 then
                          O[Y[E]] = x(O[P[E]], y[E])
                        elseif p then
                          local _ = P[E]
                          local qw = p[_]
                          if qw then
                            qw[5] = qw
                            qw[6] = O[_]
                            qw[4] = 6
                            p[_] = nil
                          end
                        end
                      elseif u == 38 then
                        O[y[E]] = N(O[Y[E]])
                      else
                        O[y[E]](t(O[P[E]], 1, O[P[E]].n))
                      end
                    elseif u >= 33 then
                      if u ~= 34 then
                        O[y[E]] = O[Y[E]](t(O[P[E]], 1, O[P[E]].n))
                      else
                        V = Y[E]
                        S = y[E] + 1
                        break
                      end
                    else
                      O[y[E]] = q[P[E]]
                    end
                    S = E
                  else
                    if u < 29 then
                      if u < 27 then
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = (E + qw) - 1, k(qw)
                                W(O, E, Pw, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[P[S]](O[Y[S]], m[S])
                      elseif u ~= 28 then
                        O[y[S]] = T(O[P[S]], O[Y[S]])
                      else
                        L = P[S]
                        O[L], O[L + 1] = O[y[S]], Y[S]
                      end
                    else
                      if u < 30 then
                        S = y[S]
                      else
                        if u == 31 then
                          e[P[S]][i[S]] = m[S]
                        else
                          L = e[Y[S]]
                          O[P[S]] = L[5][L[4]]
                        end
                      end
                    end
                  end
                else
                  if u < 45 then
                    if u >= 42 then
                      if u < 43 then
                        L = e[Y[S]]
                        L[5][L[4]] = z[S]
                      else
                        if u ~= 44 then
                          O[P[S]] = e[y[S]]
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                        else
                          S = if O[y[S]] then Y[S] else P[S]
                        end
                      end
                    else
                      if u >= 40 then
                        if u == 41 then
                          Q = O[y[S]]
                        else
                          O[Y[S]] = O[y[S]] * P[S]
                        end
                      else
                        O[Y[S]] = T(z[S], O[y[S]])
                      end
                    end
                  else
                    if u >= 48 then
                      if u >= 50 then
                        if u == 51 then
                          L, A, o = P[S], y[S], Y[S]
                          c = L + A
                          b = O[c]
                          D = b.n
                          n = (A + D) - 1
                          b.n = n
                          W(b, 1, D, A, b)
                          W(O, L + 1, c - 1, 1, b)
                          O[L] = l(O[L](t(b, 1, b.n)))
                        else
                          O[y[S]] = O[P[S]] == O[Y[S]]
                        end
                      else
                        if u ~= 49 then
                          O[P[S]] = q
                        else
                          O[Y[S]][O[P[S]]] = y[S]
                        end
                      end
                    else
                      if u < 46 then
                        O[Y[S]](O[P[S]], t(O[y[S]], 1, O[y[S]].n))
                      else
                        if u == 47 then
                          O[Y[S]][y[S]] = z[S]
                        else
                          local E
                          local _ = i[S]
                          if _ then
                            local qw = #_ / 3
                            if qw > 0 then
                              E = {}
                              local Pw, zw = p, U
                              for yw = 1, qw, 1 do
                                local qw = (yw - 1) * 3
                                local iw, Sw = _[qw + 3], _[qw + 2]
                                if iw == 3 then
                                  Pw = Pw or {}
                                  local Yw = Pw[Sw]
                                  if Yw then
                                  else
                                    Yw = {[4] = Sw, [5] = O}
                                    Pw[Sw] = Yw
                                  end
                                  E[yw] = Yw
                                else
                                  if iw == 2 then
                                    E[yw] = O[Sw]
                                  else
                                    if iw == 1 then
                                      E[yw] = e[Sw]
                                    else
                                      if iw == 0 then
                                        zw = zw or {}
                                        local iw = zw[Sw]
                                        if iw then
                                        else
                                          iw = {[4] = Sw, [6] = _[qw + 1], [5] = O}
                                          zw[Sw] = iw
                                        end
                                        E[yw] = iw
                                      else
                                      end
                                    end
                                  end
                                end
                              end
                              p, U = Pw, zw
                            else
                            end
                          else
                          end
                          O[P[S]] = m[S](nil, E, nil)
                          L = E
                        end
                      end
                    end
                  end
                end
              else
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                if u < 13 then
                  if u < 6 then
                    if u < 3 then
                      if u >= 1 then
                        if u ~= 2 then
                          O[Y[S]][z[S]] = y[S]
                        else
                          O[y[S]](O[P[S]], O[Y[S]])
                        end
                      else
                        O[Y[S]] = O[y[S]] ~= O[P[S]]
                      end
                    elseif u < 4 then
                      O[Y[S]] = d[m[S]]
                    elseif u ~= 5 then
                      O[P[S]] = O[Y[S]] < O[y[S]]
                    else
                      O[P[S]] = {}
                    end
                  else
                    if u >= 9 then
                      if u < 11 then
                        if u == 10 then
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return i[S], O[y[S]]
                        else
                          O[y[S]] = O[Y[S]][P[S]]
                        end
                      else
                        if u ~= 12 then
                          S = if O[Y[S]] ~= y[S] then P[S] else S
                        else
                          O[y[S]] = O[P[S]](i[S])
                        end
                      end
                    else
                      if u >= 7 then
                        if u ~= 8 then
                          O[Y[S]](O[P[S]], m[S])
                        else
                          O[P[S]] = R(O[y[S]], O[Y[S]])
                        end
                      else
                        local E, _, qw = Y[S], O[y[S]], P[S]
                        local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                        local _, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                        Pw = T((_ * iw) + g(T((_ * Sw) + (yw * iw), 65535), 16), 4294967295)
                        yw = nil
                        repeat
                          qw = Pw % 4294967296
                          if qw ~= qw then
                            yw = 0
                            break
                          end
                          yw = qw - (qw % 1)
                        until true
                        O[E] = yw
                      end
                    end
                  end
                else
                  if u < 19 then
                    if u < 16 then
                      if u < 14 then
                        O[y[S]] = B(P[S], O[Y[S]])
                      else
                        if u ~= 15 then
                          O[Y[S]] = B(O[y[S]], O[P[S]])
                        else
                          S = if m[S] < O[P[S]] then S else Y[S]
                        end
                      end
                    else
                      if u < 17 then
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                        L = Y[S]
                        O[L], O[L + 1] = P[S], y[S]
                      else
                        if u == 18 then
                          O[y[S]], O[P[S]] = O[Y[S]]()
                        else
                          Z, j, r, a = C[9], C[8], C[5], C[7]
                          C = C[6]
                        end
                      end
                    end
                  else
                    if u >= 22 then
                      if u < 24 then
                        if u == 23 then
                          L = e[Y[S]]
                          O[y[S]] = L[5][L[4]][O[P[S]]]
                        else
                          O[P[S]] = O[Y[S]]()
                        end
                      else
                        if u == 25 then
                          local E, _, qw = Y[S], O[P[S]]
                          repeat
                            local Pw = _ % 4294967296
                            if Pw ~= Pw then
                              qw = 0
                              break
                            end
                            qw = Pw - (Pw % 1)
                          until true
                          O[E] = qw
                        else
                          S = if O[y[S]] <= P[S] then S else Y[S]
                        end
                      end
                    else
                      if u >= 20 then
                        if u ~= 21 then
                          O[y[S]] = y
                        else
                          O[Y[S]] = B(O[P[S]], y[S])
                        end
                      else
                        F = O[Y[S]]
                      end
                    end
                  end
                end
              end
            else
              local E
              if u < 78 then
                if u < 65 then
                  if u >= 58 then
                    if u >= 61 then
                      if u < 63 then
                        if u == 62 then
                          L = Y[S]
                          O[L], O[L + 1] = m[S], P[S]
                        else
                          O[y[S]] = R(O[Y[S]], z[S])
                        end
                      else
                        if u ~= 64 then
                          if p then
                            for _ in G, p, nil do
                              local qw = p[_]
                              if qw then
                                qw[5] = qw
                                qw[6] = O[_]
                                qw[4] = 6
                                p[_] = nil
                              end
                            end
                          end
                          if U then
                            for _, qw in G, U, nil do
                              local Pw = qw[6]
                              if U then
                                qw = U[_]
                                if qw then
                                  local zw, yw = (_ + Pw) - 1, k(Pw)
                                  W(O, _, zw, 1, yw)
                                  qw[5] = yw
                                  qw[4] = 1
                                  U[_] = nil
                                end
                              end
                            end
                          end
                          return O[y[S]](O[P[S]], O[Y[S]])
                        else
                          O[Y[S]] = O[P[S]] > O[y[S]]
                        end
                      end
                    else
                      if u >= 59 then
                        if u == 60 then
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                          local _, qw, Pw = y[S], O[P[S]], i[S]
                          local zw, yw = T(qw, 4294967295), T(Pw, 4294967295)
                          local qw, iw, Sw, Yw = T(zw, 65535), x(zw, 16), T(yw, 65535), x(yw, 16)
                          Pw = T((qw * Sw) + g(T((qw * Yw) + (iw * Sw), 65535), 16), 4294967295)
                          Yw = nil
                          repeat
                            Sw = Pw % 4294967296
                            if Sw ~= Sw then
                              Yw = 0
                              break
                            end
                            Yw = Sw - (Sw % 1)
                          until true
                          O[_] = Yw
                        else
                          Z += r
                          L = if r <= 0 then Z >= j else Z <= j
                          if L then
                            O[y[S]] = Z
                            S = Y[S]
                          else
                            S = P[S]
                          end
                        end
                      else
                        q[P[S]] = O[y[S]]
                      end
                    end
                  else
                    if u < 55 then
                      if not (u < 53) then
                        if u == 54 then
                          if p then
                            for _ in G, p, nil do
                              local qw = p[_]
                              if qw then
                                qw[5] = qw
                                qw[6] = O[_]
                                qw[4] = 6
                                p[_] = nil
                              end
                            end
                          end
                          if U then
                            for _, qw in G, U, nil do
                              local Pw = qw[6]
                              if U then
                                qw = U[_]
                                if qw then
                                  local zw, yw = _ + Pw, k(Pw)
                                  W(O, _, zw - 1, 1, yw)
                                  qw[5] = yw
                                  qw[4] = 1
                                  U[_] = nil
                                end
                              end
                            end
                          end
                          return
                        else
                          O[Y[S]] = g(O[P[S]], y[S])
                        end
                      end
                    else
                      if u >= 56 then
                        if u ~= 57 then
                          S = if O[P[S]] <= i[S] then S else y[S]
                        else
                          O[y[S]]()
                        end
                      else
                        O[y[S]][O[Y[S]]] = O[P[S]]
                      end
                    end
                  end
                else
                  if u >= 71 then
                    if u >= 74 then
                      if u >= 76 then
                        if u ~= 77 then
                          S = if y[S] < O[Y[S]] then S else P[S]
                        else
                          if p then
                            for _ in G, p, nil do
                              local qw = p[_]
                              if qw then
                                qw[5] = qw
                                qw[6] = O[_]
                                qw[4] = 6
                                p[_] = nil
                              end
                            end
                          end
                          if U then
                            for _, qw in G, U, nil do
                              local Pw = qw[6]
                              if U then
                                qw = U[_]
                                if qw then
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                                  local zw, yw = (_ + Pw) - 1, k(Pw)
                                  W(O, _, zw, 1, yw)
                                  qw[5] = yw
                                  qw[4] = 1
                                  U[_] = nil
                                end
                              end
                            end
                          end
                          return O[P[S]](t(O[Y[S]], 1, O[Y[S]].n))
                        end
                      else
                        if u ~= 75 then
                          L = e[y[S]]
                          L[5][L[4]][O[P[S]]] = O[Y[S]]
                        else
                          q[m[S]] = i[S]
                        end
                      end
                    else
                      if u < 72 then
                        O[P[S]][y[S]] = O[Y[S]]
                      elseif u == 73 then
                        O[y[S]] = i[S] + O[P[S]]
                      else
                        local _, qw, Pw = Y[S], P[S], m[S]
                        local zw, yw = T(qw, 4294967295), T(Pw, 4294967295)
                        local Pw, iw, Sw, Yw = T(zw, 65535), x(zw, 16), T(yw, 65535), x(yw, 16)
                        qw = T((Pw * Sw) + g(T((Pw * Yw) + (iw * Sw), 65535), 16), 4294967295)
                        zw = nil
                        repeat
                          yw = qw % 4294967296
                          if yw ~= yw then
                            zw = 0
                            break
                          end
                          zw = yw - (yw % 1)
                        until true
                        O[_] = zw
                      end
                    end
                  else
                    if u < 68 then
                      if u >= 66 then
                        if u == 67 then
                          E = C
                          C, L, A = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = E}, Y[S], s(K)
                          A(q, O[L], O[L + 1], O[L + 2])
                          a = y[S]
                          S, Z = P[S], A
                        else
                          O[Y[S]] = O[P[S]] + O[y[S]]
                        end
                      else
                        L = Y[S]
                        O[L], O[L + 1] = y[S], z[S]
                      end
                    else
                      if u >= 69 then
                        if u ~= 70 then
                          S = if m[S] <= O[Y[S]] then S else P[S]
                        else
                          O[y[S]] = z[S] + i[S]
                        end
                      else
                        O[y[S]] = O[Y[S]] > z[S]
                      end
                    end
                  end
                end
              else
                if u < 91 then
                  if u < 84 then
                    if u >= 81 then
                      if u < 82 then
                        O[y[S]] = O[P[S]][i[S]]
                      else
                        if u ~= 83 then
                          O[Y[S]] = O[P[S]] < y[S]
                        else
                          E = C
                          C, L = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = E}, P[S]
                          r, j = O[L + 2] + 0, O[L + 1] + 0
                          Z = O[L] - r
                          S = Y[S]
                        end
                      end
                    else
                      if u >= 79 then
                        if u ~= 80 then
                          L = e[P[S]]
                          L[5][L[4]] = O[y[S]]
                        else
                          local E, _, qw = Y[S], R(y[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911))), I[5]
                          local Pw = R(qw[E], 379895444)
                          qw[E] = Pw
                          E, qw = I[4], Pw + 1
                          Pw = J(E, qw)
                          local zw, yw
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                          if Pw < 128 then
                            zw, yw = Pw, qw + 1
                          else
                            local iw = J(E, qw + 1)
                            if iw < 128 then
                              zw, yw = (Pw - 128) + (iw * 128), qw + 2
                            else
                              local Sw = J(E, qw + 2)
                              if Sw < 128 then
                                zw, yw = (((Pw - 128) * 16384) + ((iw - 128) * 128)) + Sw, qw + 3
                              else
                                local Yw = J(E, qw + 3)
                                zw, yw = (((((Pw - 128) * 2097152) + ((iw - 128) * 16384)) + (Sw - 128)) + ((Yw % 128) * 128)) + ((Yw - (Yw % 128)) * 2097152), qw + 4
                              end
                            end
                          end
                          Pw, qw = _ * 16843009, yw + zw
                          local iw = qw - (zw % 4)
                          for zw = yw, iw - 1, 4 do
                            h(E, zw, (R(H(E, zw), Pw)))
                          end
                          for Pw = iw, qw - 1, 1 do
                            X(E, Pw, (R(J(E, Pw), _)))
                          end
                          Y[S] = 184
                          y[S] = 222
                          P[S] = 102
                          v[S] = 52
                        end
                      else
                        O[P[S]] = O[y[S]] .. O[Y[S]]
                      end
                    end
                  else
                    if u < 87 then
                      if u < 85 then
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = E + qw, k(qw)
                                W(O, E, Pw - 1, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return z[S], t(O[Y[S]], 1, O[Y[S]].n)
                      elseif u ~= 86 then
                        L = e[Y[S]]
                        O[y[S]] = L[5][L[4]][z[S]]
                      else
                        O[y[S]] = O[Y[S]] > P[S]
                      end
                    else
                      if u < 89 then
                        if u ~= 88 then
                          O[y[S]] = O[P[S]] < i[S]
                        else
                          O[P[S]] = O[y[S]] // O[Y[S]]
                        end
                      elseif u ~= 90 then
                        O[Y[S]] = B(m[S], O[P[S]])
                      else
                        O[Y[S]] = not (O[P[S]] < y[S])
                      end
                    end
                  end
                else
                  if u >= 98 then
                    if u >= 101 then
                      if u >= 103 then
                        if u ~= 104 then
                          O[Y[S]] = not O[P[S]]
                        else
                          O[P[S]] = O[Y[S]] == m[S]
                        end
                      else
                        if u ~= 102 then
                          S = O[P[S]]
                        else
                          O[Y[S]] = O[y[S]](O[P[S]])
                        end
                      end
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                    else
                      if u < 99 then
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = (E + qw) - 1, k(qw)
                                W(O, E, Pw, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[Y[S]], O[y[S]], O[P[S]]
                      elseif u == 100 then
                        O[Y[S]] = v
                      else
                        O[y[S]] = O[P[S]] <= O[Y[S]]
                      end
                    end
                  else
                    if u < 94 then
                      if u < 92 then
                        L, A, o = P[S], Y[S], y[S]
                        c = O[L]
                        W(O, L + 1, L + A, o + 1, c)
                      else
                        if u ~= 93 then
                          L, A, o = Y[S], P[S], y[S]
                          c, b, D = (L + o) - 1, L + A, l(O[L](t(O, L + 1, L + A)))
                          W(D, 1, o, L, O)
                        else
                          O[y[S]] = -O[Y[S]]
                        end
                      end
                    else
                      if u < 96 then
                        if u ~= 95 then
                          O[y[S]] = O[Y[S]] + P[S]
                        else
                          local E, _, qw = y[S], Y[S], I[5]
                          local Pw = R(qw[E], 379895444)
                          qw[E] = Pw
                          E, qw = I[4], Pw + 1
                          Pw = J(E, qw)
                          local zw, yw
                          if Pw < 128 then
                            zw, yw = Pw, qw + 1
                          else
                            local iw = J(E, qw + 1)
                            if iw < 128 then
                              zw, yw = (Pw - 128) + (iw * 128), qw + 2
                            else
                              local Sw = J(E, qw + 2)
                              if Sw < 128 then
                                zw, yw = (((Pw - 128) * 16384) + ((iw - 128) * 128)) + Sw, qw + 3
                              else
                                local Yw = J(E, qw + 3)
                                zw, yw = (((((Pw - 128) * 2097152) + ((iw - 128) * 16384)) + (Sw - 128)) + ((Yw % 128) * 128)) + ((Yw - (Yw % 128)) * 2097152), qw + 4
                              end
                            end
                          end
                          qw, Pw = _ * 16843009, yw + zw
                          local iw = Pw - (zw % 4)
                          for zw = yw, iw - 1, 4 do
                            h(E, zw, (R(H(E, zw), qw)))
                          end
                          for qw = iw, Pw - 1, 1 do
                            X(E, qw, (R(J(E, qw), _)))
                          end
                          y[S] = 80
                          Y[S] = 185
                          P[S] = 123
                          v[S] = 52
                        end
                      elseif u == 97 then
                        O[y[S]] = Q
                      else
                        O[y[S]] = T(O[P[S]], Y[S])
                      end
                    end
                  end
                end
              end
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
            end
          else
            if u >= 157 then
              if u >= 183 then
                if u < 196 then
                  if u >= 189 then
                    if u >= 192 then
                      if u < 194 then
                        if u == 193 then
                          O[Y[S]] = e[y[S]][O[P[S]]]
                        else
                          O[Y[S]] = O[y[S]] % O[P[S]]
                        end
                      elseif u == 195 then
                        O[P[S]] = l(O[y[S]](O[Y[S]]))
                      else
                        O[Y[S]] = R(z[S], m[S])
                      end
                    else
                      if u >= 190 then
                        if u ~= 191 then
                          S = if O[Y[S]] ~= O[y[S]] then P[S] else S
                        else
                          O[Y[S]] = I
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw = k(qw)
                                W(O, E, (E + qw) - 1, 1, Pw)
                                _[5] = Pw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return z[S], i[S]
                      end
                    end
                  else
                    if u >= 186 then
                      if u >= 187 then
                        if u ~= 188 then
                          L = P[S]
                          O[L], O[L + 1] = i[S], m[S]
                        else
                          O[Y[S]] = z[S] .. O[y[S]]
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw, zw = E + qw, k(qw)
                                W(O, E, Pw - 1, 1, zw)
                                _[5] = zw
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return i[S]
                      end
                    else
                      if u >= 184 then
                        if u ~= 185 then
                          e[y[S]][i[S]] = O[P[S]]
                        else
                          O[P[S]] = O[y[S]] >= i[S]
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                        end
                      else
                        O[y[S]] = B(O[P[S]], i[S])
                      end
                    end
                  end
                else
                  if u >= 203 then
                    if u >= 206 then
                      if u >= 208 then
                        if u == 209 then
                          O[P[S]] = y[S] - O[Y[S]]
                        else
                          S = O[P[S]]
                        end
                      else
                        if u == 207 then
                          O[P[S]] = d[i[S]][m[S]]
                        else
                          O[Y[S]] = O[P[S]] % m[S]
                        end
                      end
                    else
                      if u < 204 then
                        local E, _, qw = y[S], i[S], O[P[S]]
                        local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                        local qw, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                        _ = T((qw * iw) + g(T((qw * Sw) + (yw * iw), 65535), 16), 4294967295)
                        qw = nil
                        repeat
                          zw = _ % 4294967296
                          if zw ~= zw then
                            qw = 0
                            break
                          end
                          qw = zw - (zw % 1)
                        until true
                        O[E] = qw
                      else
                        if u == 205 then
                          d[m[S]] = O[P[S]]
                        else
                          S = if P[S] <= O[y[S]] then S else Y[S]
                        end
                      end
                    end
                  else
                    if u >= 199 then
                      if u < 201 then
                        if u ~= 200 then
                          if p then
                            local E = P[S]
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                            E = Y[S]
                            _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                            _ = y[S]
                            E = p[_]
                            if E then
                              E[5] = E
                              E[6] = O[_]
                              E[4] = 6
                              p[_] = nil
                            end
                          end
                        else
                          O[y[S]](i[S], O[P[S]])
                        end
                      else
                        if u ~= 202 then
                          e[P[S]][m[S]] = Y[S]
                        else
                          L = e[y[S]]
                          L[5][L[4]][O[P[S]]] = Y[S]
                        end
                      end
                    else
                      if u >= 197 then
                        if u ~= 198 then
                          O[Y[S]] = O[P[S]] >= O[y[S]]
                        else
                          O[y[S]] = O[Y[S]] * O[P[S]]
                        end
                      else
                        L = e[Y[S]]
                        L[5][L[4]][O[P[S]]] = m[S]
                      end
                    end
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                  end
                end
              else
                if u < 170 then
                  if u < 163 then
                    if u >= 160 then
                      if u < 161 then
                        O[y[S]][i[S]] = O[P[S]]
                      else
                        if u == 162 then
                          A, L = (R(y[S], (T(R(F, (T(x(F, 29), 7))), 536870911)))), Y[S] + 1
                          for E = 1, P[S], 1 do
                            A = T(R(A, (g(A, 13))), 536870911)
                            A = R(A, (x(A, 13)))
                            A = T(R(A, (g(A, 14))), 536870911)
                            Y[L] = R(Y[L], (T(x(A, 0), 127)))
                            y[L] = R(y[L], (T(x(A, 7), 127)))
                            P[L] = R(P[L], (T(x(A, 14), 127)))
                            v[L] = R(v[L], (T(x(A, 21), 127)))
                            L = L + 1
                          end
                          v[S] = 52
                        else
                          O[Y[S]] = l(O[y[S]](t(O[P[S]], 1, O[P[S]].n)))
                        end
                      end
                    else
                      if u >= 158 then
                        if u ~= 159 then
                          local E, _, qw = P[S], Y[S], O[y[S]]
                          local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                          local _, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                          qw = T((_ * iw) + g(T((_ * Sw) + (yw * iw), 65535), 16), 4294967295)
                          _ = nil
                          repeat
                            yw = qw % 4294967296
                            if yw ~= yw then
                              _ = 0
                              break
                            end
                            _ = yw - (yw % 1)
                          until true
                          O[E] = _
                        else
                          L, A, o = Y[S], P[S], y[S]
                          c, b = O[L], L + A
                          D = O[b]
                          W(O, L + 1, b - 1, o + 1, c)
                          W(D, 1, D.n, o + A, c)
                        end
                      else
                        O[y[S]] = k(Y[S])
                      end
                    end
                  else
                    if u < 166 then
                      if u < 164 then
                        O[y[S]][O[P[S]]] = i[S]
                      elseif u ~= 165 then
                        O[y[S]](O[P[S]])
                      else
                        O[Y[S]] = O[P[S]] - m[S]
                      end
                    else
                      if u >= 168 then
                        if u == 169 then
                          O[Y[S]] = O[P[S]] - y[S]
                        elseif p then
                          local E = P[S]
                          local _ = p[E]
                          if _ then
                            _[5] = _
                            _[6] = O[E]
                            _[4] = 6
                            p[E] = nil
                          end
                          _ = Y[S]
                          E = p[_]
                          if E then
                            E[5] = E
                            E[6] = O[_]
                            E[4] = 6
                            p[_] = nil
                          end
                        end
                      else
                        if u ~= 167 then
                          O[y[S]] = F
                        else
                          S = if O[P[S]] <= O[Y[S]] then S else y[S]
                        end
                      end
                    end
                  end
                else
                  if u < 176 then
                    if u >= 173 then
                      if u < 174 then
                        A, L = (R(y[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911)))), Y[S] + 1
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                        for E = 1, P[S], 1 do
                          A = T(R(A, (g(A, 13))), 536870911)
                          A = R(A, (x(A, 13)))
                          A = T(R(A, (g(A, 14))), 536870911)
                          Y[L] = R(Y[L], (T(x(A, 0), 127)))
                          y[L] = R(y[L], (T(x(A, 7), 127)))
                          P[L] = R(P[L], (T(x(A, 14), 127)))
                          v[L] = R(v[L], (T(x(A, 21), 127)))
                          L = L + 1
                        end
                        v[S] = 52
                      else
                        if u == 175 then
                          L, A, o, c = R(Q, T(x(Q, 14), 262143), (T(x(Q, 28), 15))), P[S], Y[S], y[S]
                          b = ((o < 2097152) and 7) or 14
                          D, n = T(o, g(1, b) - 1), x(o, b)
                          Y[S] = R(D, 126, (T(L, 127)))
                          y[S] = R(c, 90, (T(x(L, 7), 127)))
                          P[S] = R(A, 122, (T(x(L, 14), 127)))
                          v[S] = R(n, 37, (T(x(L, 21), 127)))
                          S = S - 1
                        else
                          O[y[S]] = O[P[S]] <= Y[S]
                        end
                      end
                    else
                      if u < 171 then
                        O[y[S]] = O[P[S]] ~= Y[S]
                      else
                        if u ~= 172 then
                          A, L = Y[S], y[S] + 1
                          for E = 1, P[S], 1 do
                            A = T(R(A, (g(A, 13))), 536870911)
                            A = R(A, (x(A, 13)))
                            A = T(R(A, (g(A, 14))), 536870911)
                            Y[L] = R(Y[L], (T(x(A, 0), 127)))
                            y[L] = R(y[L], (T(x(A, 7), 127)))
                            P[L] = R(P[L], (T(x(A, 14), 127)))
                            v[L] = R(v[L], (T(x(A, 21), 127)))
                            L = L + 1
                          end
                          v[S] = 52
                        else
                          O[Y[S]] = O[y[S]] / P[S]
                        end
                      end
                    end
                  else
                    if u < 179 then
                      if u >= 177 then
                        if u == 178 then
                          O[P[S]] = q[m[S]]
                        else
                          local E, _, qw = Y[S], R(y[S], (T(R(F, (T(x(F, 29), 7))), 536870911))), I[5]
                          local Pw = R(qw[E], 379895444)
                          qw[E] = Pw
                          E, qw = I[4], Pw + 1
                          Pw = J(E, qw)
                          local zw, yw
                          if Pw < 128 then
                            zw, yw = Pw, qw + 1
                          else
                            local iw = J(E, qw + 1)
                            if iw < 128 then
                              zw, yw = (Pw - 128) + (iw * 128), qw + 2
                            else
                              local Sw = J(E, qw + 2)
                              if Sw < 128 then
                                zw, yw = (((Pw - 128) * 16384) + ((iw - 128) * 128)) + Sw, qw + 3
                              else
                                local Yw = J(E, qw + 3)
                                zw, yw = (((((Pw - 128) * 2097152) + ((iw - 128) * 16384)) + (Sw - 128)) + ((Yw % 128) * 128)) + ((Yw - (Yw % 128)) * 2097152), qw + 4
                              end
                            end
                          end
                          qw, Pw = _ * 16843009, yw + zw
                          local iw = Pw - (zw % 4)
                          for zw = yw, iw - 1, 4 do
                            h(E, zw, (R(H(E, zw), qw)))
                          end
                          for qw = iw, Pw - 1, 1 do
                            X(E, qw, (R(J(E, qw), _)))
                          end
                          Y[S] = 166
                          y[S] = 28
                          P[S] = 249
                          v[S] = 52
                        end
                      else
                        O[y[S]] = O[Y[S]] ~= z[S]
                      end
                    else
                      if u >= 181 then
                        if u == 182 then
                          S = if O[y[S]] < P[S] then S else Y[S]
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw, zw = (E + qw) - 1, k(qw)
                                  W(O, E, Pw, 1, zw)
                                  _[5] = zw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[y[S]](i[S], O[P[S]])
                        end
                      else
                        if u ~= 180 then
                          L = Y[S]
                          O[L], O[L + 1] = P[S], O[y[S]]
                        else
                          O[P[S]](i[S], m[S])
                        end
                      end
                    end
                  end
                end
              end
            else
              if u >= 131 then
                if u < 144 then
                  if u < 137 then
                    if u < 134 then
                      if u < 132 then
                        L, A, o, c = P[S], Y[S], y[S], R(Q, T(x(Q, 14), 262143), (T(x(Q, 28), 15)))
                        b = ((L < 16384) and 7) or (((L < 2097152) and 14) or 21)
                        D, n = T(L, g(1, b) - 1), x(L, b)
                        v[S] = R(n, 70, (T(x(c, 21), 127)))
                        y[S] = R(o, 26, (T(x(c, 7), 127)))
                        P[S] = R(D, 105, (T(x(c, 14), 127)))
                        Y[S] = R(A, 115, (T(c, 127)))
                        S = S - 1
                      else
                        if u ~= 133 then
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw = k(qw)
                                  W(O, E, (E + qw) - 1, 1, Pw)
                                  _[5] = Pw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[P[S]]
                        else
                          L = y[S]
                          A, o, c = O[L], O[L + 1], O[L + 2]
                          O[L] = A(o, c)
                        end
                      end
                    else
                      if u < 135 then
                        O[P[S]] = O[Y[S]][O[y[S]]]
                      else
                        if u ~= 136 then
                          O[y[S]] = O[P[S]] // Y[S]
                        else
                          L = Y[S]
                          O[L], O[L + 1] = O[y[S]], O[P[S]]
                        end
                      end
                    end
                  else
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                    if u >= 140 then
                      if u < 142 then
                        if u ~= 141 then
                          O[Y[S]] = R(m[S], O[P[S]])
                        else
                          S = if O[y[S]] < z[S] then S else Y[S]
                        end
                      else
                        if u ~= 143 then
                          L = P[S]
                          O[L], O[L + 1] = m[S], O[Y[S]]
                        else
                          O[y[S]] = Y[S] * O[P[S]]
                        end
                      end
                    else
                      if u >= 138 then
                        if u ~= 139 then
                          for E = Y[S], y[S], 1 do
                            O[E] = nil
                          end
                        else
                          O[Y[S]] = m[S] % O[P[S]]
                        end
                      else
                        O[Y[S]] = O[y[S]] .. z[S]
                      end
                    end
                  end
                else
                  if u < 150 then
                    if u < 147 then
                      if u < 145 then
                        O[y[S]] = O[P[S]] * i[S]
                      else
                        if u == 146 then
                          local E, _, qw = Y[S], m[S], z[S]
                          local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                          local _, qw, yw, iw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                          zw = T((_ * yw) + g(T((_ * iw) + (qw * yw), 65535), 16), 4294967295)
                          Pw = nil
                          repeat
                            yw = zw % 4294967296
                            if yw ~= yw then
                              Pw = 0
                              break
                            end
                            Pw = yw - (yw % 1)
                          until true
                          O[E] = Pw
                        else
                          L, A, o = y[S], P[S], Y[S]
                          c, b = (L + o) - 1, L + A
                          D = O[b]
                          n = D.n
                          w = (A + n) - 1
                          D.n = w
                          W(D, 1, n, A, D)
                          W(O, L + 1, b - 1, 1, D)
                          f = l(O[L](t(D, 1, D.n)))
                          W(f, 1, o, L, O)
                        end
                      end
                    else
                      if u < 148 then
                        O[Y[S]] = O[y[S]] / O[P[S]]
                      else
                        if u ~= 149 then
                          L, A = y[S], O[P[S]]
                          O[L + 1] = A
                          O[L] = A[i[S]]
                        else
                          O[y[S]] = i[S]
                        end
                      end
                    end
                  else
                    if u < 153 then
                      if u < 151 then
                        if p then
                          for E in G, p, nil do
                            local _ = p[E]
                            if _ then
                              _[5] = _
                              _[6] = O[E]
                              _[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, _ in G, U, nil do
                            local qw = _[6]
                            if U then
                              _ = U[E]
                              if _ then
                                local Pw = k(qw)
                                W(O, E, (E + qw) - 1, 1, Pw)
                                _[5] = Pw
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                                _[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[Y[S]], O[y[S]]
                      elseif u == 152 then
                        O[P[S]] = O
                      else
                        O[Y[S]] = P
                      end
                    else
                      if u >= 155 then
                        if u == 156 then
                          O[Y[S]][z[S]] = m[S]
                        else
                          S = if O[y[S]] then P[S] else Y[S]
                        end
                      else
                        if u ~= 154 then
                          local E, _, qw = Y[S], O[P[S]], O[y[S]]
                          local Pw, zw = T(_, 4294967295), T(qw, 4294967295)
                          local _, yw, iw, Sw = T(Pw, 65535), x(Pw, 16), T(zw, 65535), x(zw, 16)
                          Pw = T((_ * iw) + g(T((_ * Sw) + (yw * iw), 65535), 16), 4294967295)
                          yw = nil
                          repeat
                            qw = Pw % 4294967296
                            if qw ~= qw then
                              yw = 0
                              break
                            end
                            yw = qw - (qw % 1)
                          until true
                          O[E] = yw
                        else
                          O[P[S]] = y[S]
                        end
                      end
                    end
                  end
                end
              else
                if u < 118 then
                  if u < 111 then
                    if u < 108 then
                      if u < 106 then
                        O[Y[S]] = O[P[S]] + m[S]
                      else
                        if u == 107 then
                          S = if O[P[S]] ~= i[S] then y[S] else S
                        else
                          if p then
                            for E in G, p, nil do
                              local _ = p[E]
                              if _ then
                                _[5] = _
                                _[6] = O[E]
                                _[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, _ in G, U, nil do
                              local qw = _[6]
                              if U then
                                _ = U[E]
                                if _ then
                                  local Pw, zw = E + qw, k(qw)
                                  W(O, E, Pw - 1, 1, zw)
                                  _[5] = zw
                                  _[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[y[S]](z[S])
                        end
                      end
                    else
                      if u >= 109 then
                        if u ~= 110 then
                          e[Y[S]][O[P[S]]] = O[y[S]]
                        else
                          O[y[S]] = P[S] + O[Y[S]]
                        end
                      else
                        S = if O[Y[S]] < O[y[S]] then S else P[S]
                      end
                    end
                  else
                    if u < 114 then
                      if u < 112 then
                        O[y[S]] = e[P[S]][i[S]]
                      else
                        if u ~= 113 then
                          O[y[S]] = O[P[S]][i[S]]
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                          O[y[S + 1]] = O[P[S + 1]][i[S + 1]]
                          S += 1
                        else
                          O[Y[S]] = O[y[S]] == P[S]
                        end
                      end
                    else
                      if u < 116 then
                        if u ~= 115 then
                          O[y[S]] = l(O[P[S]]())
                        else
                          L = y[S]
                          O[L], O[L + 1] = O[Y[S]], z[S]
                        end
                      else
                        if u == 117 then
                          L, A, o = P[S], Y[S], y[S]
                          c = L + A
                          O[L] = l(O[L](t(O, L + 1, c)))
                        else
                          O[y[S]] = O[P[S]] % Y[S]
                        end
                      end
                    end
                  end
                else
                  if u >= 124 then
                    local E, _, qw = L, A, o
                    if u < 127 then
                      if u < 125 then
                        O[y[S]](i[S])
                      elseif u == 126 then
                        O[P[S]] = R(O[Y[S]], y[S])
                      else
                        O[P[S]] = Y
                      end
                    elseif u < 129 then
                      if u == 128 then
                        O[Y[S]] = #O[y[S]]
                      else
                        O[y[S]] = O[P[S]] / i[S]
                      end
                    elseif u == 130 then
                      L = Y[S]
                      o = L + P[S]
                      if p then
                        for Pw in G, p, nil do
                          local zw = p[Pw]
                          if zw then
                            zw[5] = zw
                            zw[6] = O[Pw]
                            zw[4] = 6
                            p[Pw] = nil
                          end
                        end
                      end
                      if U then
                        for Pw, zw in G, U, nil do
                          local yw = zw[6]
                          if U then
                            zw = U[Pw]
                            if zw then
                              local iw, Sw = (Pw + yw) - 1, k(yw)
                              W(O, Pw, iw, 1, Sw)
                              zw[5] = Sw
                              zw[4] = 1
                              U[Pw] = nil
                            end
                          end
                        end
                      end
                      return O[L](t(O, L + 1, o))
                    else
                      e[Y[S]][O[P[S]]] = m[S]
                    end
                    L, A, o = E, _, qw
                  else
                    if u < 121 then
                      if u >= 119 then
                        local E, _, qw
                        if u ~= 120 then
                          if p then
                            for Pw in G, p, nil do
                              local zw = p[Pw]
                              if zw then
                                zw[5] = zw
                                zw[6] = O[Pw]
                                zw[4] = 6
                                p[Pw] = nil
                              end
                            end
                          end
                          if U then
                            for Pw, zw in G, U, nil do
                              local yw = zw[6]
                              if U then
                                zw = U[Pw]
                                if zw then
                                  local iw, Sw = Pw + yw, k(yw)
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                                  W(O, Pw, iw - 1, 1, Sw)
                                  zw[5] = Sw
                                  zw[4] = 1
                                  U[Pw] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]](O[P[S]])
                        else
                          L, E, _, qw = P[S], Z()
                          if E then
                            O[L + 1] = _
                            O[L + 2] = qw
                            S = y[S]
                          else
                            S = Y[S]
                          end
                        end
                        A, o, c = E, _, qw
                      else
                        O[y[S]] = O[P[S]]
                      end
                    else
                      if u >= 122 then
                        if u == 123 then
                          if p then
                            for u in G, p, nil do
                              local E = p[u]
                              if E then
                                E[5] = E
                                E[6] = O[u]
                                E[4] = 6
                                p[u] = nil
                              end
                            end
                          end
                          if U then
                            for u, E in G, U, nil do
                              local _ = E[6]
                              if U then
                                E = U[u]
                                if E then
                                  local qw = k(_)
                                  W(O, u, (u + _) - 1, 1, qw)
                                  E[5] = qw
                                  E[4] = 1
                                  U[u] = nil
                                end
                              end
                            end
                          end
                          return O[Y[S]], m[S]
                        else
                          O[P[S]] = O[y[S]] - O[Y[S]]
                        end
                      else
                        O[y[S]] = T(O[Y[S]], z[S])
                      end
                    end
                  end
                end
              end
            end
          end
          S = S + 1
        end
      else
      end
      if V == 34 then
        while true do
          local u = y[S]
          if u >= 91 then
            if u >= 137 then
              if u >= 160 then
                if u < 171 then
                  if u >= 165 then
                    if u < 168 then
                      if u >= 166 then
                        if u ~= 167 then
                          if p then
                            for E in G, p, nil do
                              local m = p[E]
                              if m then
                                m[5] = m
                                m[6] = O[E]
                                m[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, m in G, U, nil do
                              local V = m[6]
                              if U then
                                m = U[E]
                                if m then
                                  local _, qw = (E + V) - 1, k(V)
                                  W(O, E, _, 1, qw)
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                                  m[5] = qw
                                  m[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[P[S]]
                        else
                          O[Y[S]](O[v[S]], t(O[P[S]], 1, O[P[S]].n))
                        end
                      else
                        O[P[S]] = F
                      end
                    elseif u >= 169 then
                      if u == 170 then
                        O[v[S]][O[Y[S]]] = z[S]
                      else
                        O[P[S]] = v[S]
                      end
                    else
                      O[P[S]] = T(O[v[S]], Y[S])
                    end
                  else
                    if u >= 162 then
                      if u >= 163 then
                        if u ~= 164 then
                          S = if Y[S] <= O[P[S]] then S else v[S]
                        else
                          O[Y[S]] = l(O[v[S]]())
                        end
                      else
                        S = if i[S] < O[v[S]] then S else P[S]
                      end
                    else
                      S = if u == 161 then if v[S] < O[P[S]] then S else Y[S] else if O[Y[S]] ~= P[S] then v[S] else S
                    end
                  end
                else
                  if u >= 177 then
                    if u >= 180 then
                      if u >= 181 then
                        if u == 182 then
                          if p then
                            for E in G, p, nil do
                              local m = p[E]
                              if m then
                                m[5] = m
                                m[6] = O[E]
                                m[4] = 6
                                p[E] = nil
                              end
                            end
                          end
                          if U then
                            for E, m in G, U, nil do
                              local V = m[6]
                              if U then
                                m = U[E]
                                if m then
                                  local _, qw = E + V, k(V)
                                  W(O, E, _ - 1, 1, qw)
                                  m[5] = qw
                                  m[4] = 1
                                  U[E] = nil
                                end
                              end
                            end
                          end
                          return O[P[S]](O[Y[S]], M[S])
                        else
                          q[v[S]] = O[P[S]]
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
                              if m then
                                local _, qw = E + V, k(V)
                                W(O, E, _ - 1, 1, qw)
                                m[5] = qw
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                        end
                        return O[P[S]](O[v[S]])
                      end
                    elseif u < 178 then
                      local E, m, V = Y[S], z[S], M[S]
                      local _, qw = T(m, 4294967295), T(V, 4294967295)
                      local m, Pw, zw, yw = T(_, 65535), x(_, 16), T(qw, 65535), x(qw, 16)
                      V = T((m * zw) + g(T((m * yw) + (Pw * zw), 65535), 16), 4294967295)
                      _ = nil
                      repeat
                        Pw = V % 4294967296
                        if Pw ~= Pw then
                          _ = 0
                          break
                        end
                        _ = Pw - (Pw % 1)
                      until true
                      O[E] = _
                    elseif u ~= 179 then
                      O[v[S]] = O[Y[S]] .. z[S]
                    else
                      O[P[S]] = {}
                    end
                  elseif u < 174 then
                    if u >= 172 then
                      if u ~= 173 then
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
                              if m then
                                local _ = k(V)
                                W(O, E, (E + V) - 1, 1, _)
                                m[5] = _
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return
                      else
                        O[P[S]] = O[v[S]] == Y[S]
                      end
                    else
                      O[P[S]][i[S]] = M[S]
                    end
                  elseif u < 175 then
                    O[Y[S]] = O[P[S]] > O[v[S]]
                  elseif u ~= 176 then
                    if p then
                      for E in G, p, nil do
                        local m = p[E]
                        if m then
                          m[5] = m
                          m[6] = O[E]
                          m[4] = 6
                          p[E] = nil
                        end
                      end
                    end
                    if U then
                      for E, m in G, U, nil do
                        local V = m[6]
                        if U then
                          m = U[E]
                          if m then
                            local _ = k(V)
                            W(O, E, (E + V) - 1, 1, _)
                            m[5] = _
                            m[4] = 1
                            U[E] = nil
                          end
                        end
                      end
                    end
                    return i[S], O[v[S]]
                  else
                    O[v[S]] = q[Y[S]]
                  end
                end
              else
                if u >= 148 then
                  if u < 154 then
                    if u < 151 then
                      if u < 149 then
                        S = if O[P[S]] < M[S] then S else Y[S]
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                      else
                        if u == 150 then
                          L, A, o = Y[S], v[S], P[S]
                          c = O[L]
                          W(O, L + 1, L + A, o + 1, c)
                        else
                          O[Y[S]] = O[v[S]] * P[S]
                        end
                      end
                    else
                      if u < 152 then
                        O[Y[S]] = O[P[S]] % v[S]
                      else
                        if u ~= 153 then
                          O[P[S]] = -O[v[S]]
                        else
                          L = e[Y[S]]
                          L[5][L[4]] = z[S]
                        end
                      end
                    end
                  else
                    if u >= 157 then
                      if u >= 158 then
                        if u ~= 159 then
                          O[v[S]] = O[P[S]] <= O[Y[S]]
                        else
                          S = P[S]
                        end
                      else
                        local E
                        E, O[v[S]][i[S]] = nil, O[P[S]]
                        local m = M[S + 1]
                        if m then
                          local V = #m / 3
                          if V > 0 then
                            E = {}
                            local _, qw = p, U
                            for Pw = 1, V, 1 do
                              local V = (Pw - 1) * 3
                              local zw, yw = m[V + 3], m[V + 2]
                              if zw == 3 then
                                _ = _ or {}
                                local iw = _[yw]
                                if iw then
                                else
                                  iw = {[4] = yw, [5] = O}
                                  _[yw] = iw
                                end
                                E[Pw] = iw
                              else
                                if zw == 2 then
                                  E[Pw] = O[yw]
                                else
                                  if zw == 1 then
                                    E[Pw] = e[yw]
                                  else
                                    if zw == 0 then
                                      qw = qw or {}
                                      local zw = qw[yw]
                                      if zw then
                                      else
                                        zw = {[4] = yw, [6] = m[V + 1], [5] = O}
                                        qw[yw] = zw
                                      end
                                      E[Pw] = zw
                                    else
                                    end
                                  end
                                end
                              end
                            end
                            p, U = _, qw
                          else
                          end
                        else
                        end
                        O[P[S + 1]] = i[S + 1](nil, E, nil)
                        O[v[S + 2]][i[S + 2]] = O[P[S + 2]]
                        S, L = S + 2, E
                      end
                    else
                      if u < 155 then
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                              if m then
                                local _, qw = (E + V) - 1, k(V)
                                W(O, E, _, 1, qw)
                                m[5] = qw
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[P[S]], O[v[S]], O[Y[S]]
                      elseif u ~= 156 then
                        S = O[v[S]]
                      else
                        L = Y[S]
                        O[L], O[L + 1] = O[P[S]], O[v[S]]
                      end
                    end
                  end
                else
                  if u >= 142 then
                    if u < 145 then
                      if u < 143 then
                        O[P[S]], O[v[S]] = O[Y[S]]()
                      else
                        if u == 144 then
                          O[Y[S]] = O[v[S]] ~= O[P[S]]
                        else
                          S = if O[v[S]] ~= O[P[S]] then Y[S] else S
                        end
                      end
                    else
                      if u < 146 then
                        O[P[S]] = T(O[v[S]], O[Y[S]])
                      elseif u == 147 then
                        O[Y[S]] = O[P[S]] ~= M[S]
                      else
                        e[v[S]][i[S]] = P[S]
                      end
                    end
                  else
                    if u < 139 then
                      if u == 138 then
                        F = O[v[S]]
                      else
                        O[Y[S]] = O[v[S]]
                      end
                    else
                      if u >= 140 then
                        if u == 141 then
                          O[P[S]](i[S], O[v[S]])
                        else
                          A, L = (R(P[S], (T(R(F, (T(x(F, 29), 7))), 536870911)))), v[S] + 1
                          for E = 1, Y[S], 1 do
                            A = T(R(A, (g(A, 13))), 536870911)
                            A = R(A, (x(A, 13)))
                            A = T(R(A, (g(A, 14))), 536870911)
                            v[L] = R(v[L], (T(x(A, 0), 127)))
                            P[L] = R(P[L], (T(x(A, 7), 127)))
                            Y[L] = R(Y[L], (T(x(A, 14), 127)))
                            y[L] = R(y[L], (T(x(A, 21), 127)))
                            L = L + 1
                          end
                          y[S] = 0
                        end
                      else
                        local E
                        local m = M[S]
                        if m then
                          local V = #m / 3
                          if V > 0 then
                            E = {}
                            local _, qw = p, U
                            for Pw = 1, V, 1 do
                              local V = (Pw - 1) * 3
                              local zw, yw = m[V + 3], m[V + 2]
                              if zw == 3 then
                                _ = _ or {}
                                local iw = _[yw]
                                if iw then
                                else
                                  iw = {[4] = yw, [5] = O}
                                  _[yw] = iw
                                end
                                E[Pw] = iw
                              else
                                if zw == 2 then
                                  E[Pw] = O[yw]
                                else
                                  if zw == 1 then
                                    E[Pw] = e[yw]
                                  else
                                    if zw == 0 then
                                      qw = qw or {}
                                      local zw = qw[yw]
                                      if zw then
                                      else
                                        zw = {[4] = yw, [6] = m[V + 1], [5] = O}
                                        qw[yw] = zw
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                                      end
                                      E[Pw] = zw
                                    else
                                    end
                                  end
                                end
                              end
                            end
                            p, U = _, qw
                          else
                          end
                        else
                        end
                        O[P[S]] = i[S](nil, E, nil)
                        L = E
                      end
                    end
                  end
                end
              end
            else
              if u >= 114 then
                if u < 125 then
                  if u < 119 then
                    if u < 116 then
                      if u == 115 then
                        A, L = (R(P[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911)))), v[S] + 1
                        for E = 1, Y[S], 1 do
                          A = T(R(A, (g(A, 13))), 536870911)
                          A = R(A, (x(A, 13)))
                          A = T(R(A, (g(A, 14))), 536870911)
                          v[L] = R(v[L], (T(x(A, 0), 127)))
                          P[L] = R(P[L], (T(x(A, 7), 127)))
                          Y[L] = R(Y[L], (T(x(A, 14), 127)))
                          y[L] = R(y[L], (T(x(A, 21), 127)))
                          L = L + 1
                        end
                        y[S] = 0
                      else
                        O[P[S]] = B(O[v[S]], i[S])
                      end
                    else
                      if u < 117 then
                        O[v[S]] = O[P[S]] // Y[S]
                      elseif u == 118 then
                        O[Y[S]] = z[S] - O[v[S]]
                      else
                        O[P[S]] = d[M[S]][i[S]]
                      end
                    end
                  else
                    if u < 122 then
                      if u >= 120 then
                        if u ~= 121 then
                          S = if O[v[S]] ~= z[S] then Y[S] else S
                        else
                          local E, m, V = v[S], O[P[S]], O[Y[S]]
                          local _, qw = T(m, 4294967295), T(V, 4294967295)
                          local m, Pw, zw, yw = T(_, 65535), x(_, 16), T(qw, 65535), x(qw, 16)
                          qw = T((m * zw) + g(T((m * yw) + (Pw * zw), 65535), 16), 4294967295)
                          yw = nil
                          repeat
                            V = qw % 4294967296
                            if V ~= V then
                              yw = 0
                              break
                            end
                            yw = V - (V % 1)
                          until true
                          O[E] = yw
                        end
                      else
                        O[v[S]]()
                      end
                    else
                      if u >= 123 then
                        if u ~= 124 then
                          O[Y[S]] = O[P[S]] <= v[S]
                        else
                          L = P[S]
                          O[L], O[L + 1] = Y[S], O[v[S]]
                        end
                      else
                        O[P[S]](t(O[v[S]], 1, O[v[S]].n))
                      end
                    end
                  end
                else
                  if u < 131 then
                    if u < 128 then
                      if u < 126 then
                        L, A, o = v[S], Y[S], P[S]
                        c = L + A
                        b = O[c]
                        D = b.n
                        n = (A + D) - 1
                        b.n = n
                        W(b, 1, D, A, b)
                        W(O, L + 1, c - 1, 1, b)
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                        O[L] = l(O[L](t(b, 1, b.n)))
                      else
                        if u ~= 127 then
                          L = v[S]
                          O[L], O[L + 1] = i[S], O[P[S]]
                        else
                          L = Y[S]
                          O[L], O[L + 1] = z[S], M[S]
                        end
                      end
                    else
                      if u >= 129 then
                        local E, m, V
                        if u ~= 130 then
                          L, E, m, V = P[S], Z()
                          if E then
                            O[L + 1] = m
                            O[L + 2] = V
                            S = Y[S]
                          else
                            S = v[S]
                          end
                        else
                          if p then
                            for _ in G, p, nil do
                              local qw = p[_]
                              if qw then
                                qw[5] = qw
                                qw[6] = O[_]
                                qw[4] = 6
                                p[_] = nil
                              end
                            end
                          end
                          if U then
                            for _, qw in G, U, nil do
                              local Pw = qw[6]
                              if U then
                                qw = U[_]
                                if qw then
                                  local zw = k(Pw)
                                  W(O, _, (_ + Pw) - 1, 1, zw)
                                  qw[5] = zw
                                  qw[4] = 1
                                  U[_] = nil
                                end
                              end
                            end
                          end
                          return i[S], M[S]
                        end
                        A, o, c = E, m, V
                      else
                        e[P[S]][O[Y[S]]] = M[S]
                      end
                    end
                  else
                    if u >= 134 then
                      if u < 135 then
                        O[P[S]] = e[v[S]][i[S]]
                      elseif u ~= 136 then
                        O[Y[S]] = O[P[S]] - v[S]
                      else
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
                              if m then
                                local _, qw = E + V, k(V)
                                W(O, E, _ - 1, 1, qw)
                                m[5] = qw
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[Y[S]], O[P[S]]
                      end
                    else
                      if u >= 132 then
                        if u ~= 133 then
                          L = e[P[S]]
                          L[5][L[4]] = O[v[S]]
                        else
                          O[Y[S]] = #O[P[S]]
                        end
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                      else
                        O[P[S]][Y[S]] = O[v[S]]
                      end
                    end
                  end
                end
              else
                if u < 102 then
                  if u < 96 then
                    if u >= 93 then
                      if u >= 94 then
                        if u ~= 95 then
                          O[Y[S]] = P[S] + O[v[S]]
                        else
                          O[Y[S]] = O[v[S]][P[S]]
                        end
                      else
                        S = if O[v[S]] <= P[S] then S else Y[S]
                      end
                    else
                      if u == 92 then
                        Q = O[P[S]]
                      else
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
                              if m then
                                local _ = k(V)
                                W(O, E, (E + V) - 1, 1, _)
                                m[5] = _
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[v[S]], z[S]
                      end
                    end
                  else
                    if u < 99 then
                      if u < 97 then
                        O[P[S]] = O[Y[S]]()
                      else
                        if u == 98 then
                          L = e[Y[S]]
                          O[v[S]] = L[5][L[4]][O[P[S]]]
                        else
                          O[v[S]] = e[Y[S]][O[P[S]]]
                        end
                      end
                    else
                      if u < 100 then
                        L = Y[S]
                        O[L], O[L + 1] = P[S], v[S]
                      else
                        if u == 101 then
                          O[Y[S]] = d[M[S]]
                        else
                          O[P[S]] = O[v[S]] ~= Y[S]
                        end
                      end
                    end
                  end
                else
                  if u >= 108 then
                    if u >= 111 then
                      if u >= 112 then
                        if u == 113 then
                          e[Y[S]][O[v[S]]] = O[P[S]]
                        else
                          L = Y[S]
                          A, o, c = O[L], O[L + 1], O[L + 2]
                          O[L] = A(o, c)
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
                              if m then
                                local d = k(V)
                                W(O, E, (E + V) - 1, 1, d)
                                m[5] = d
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return z[S]
                      end
                    else
                      if u >= 109 then
                        if u ~= 110 then
                          if p then
                            local E = P[S]
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                            m = v[S]
                            E = p[m]
                            if E then
                              E[5] = E
                              E[6] = O[m]
                              E[4] = 6
                              p[m] = nil
                            end
                          end
                        else
                          L = e[v[S]]
                          O[P[S]] = L[5][L[4]]
                        end
                      else
                        if p then
                          for E in G, p, nil do
                            local m = p[E]
                            if m then
                              m[5] = m
                              m[6] = O[E]
                              m[4] = 6
                              p[E] = nil
                            end
                          end
                        end
                        if U then
                          for E, m in G, U, nil do
                            local V = m[6]
                            if U then
                              m = U[E]
                              if m then
                                local d = k(V)
                                W(O, E, (E + V) - 1, 1, d)
                                m[5] = d
                                m[4] = 1
                                U[E] = nil
                              end
                            end
                          end
                        end
                        return O[P[S]](O[v[S]], O[Y[S]])
                      end
                    end
                  else
                    if u < 105 then
                      if u >= 103 then
                        if u ~= 104 then
                          S = if O[Y[S]] then v[S] else P[S]
                        else
                          O[v[S]] = O[Y[S]] + P[S]
                        end
                      else
                        O[Y[S]] = v[S] * O[P[S]]
                      end
                    else
                      if u >= 106 then
                        if u ~= 107 then
                          O[Y[S]] = R(O[P[S]], v[S])
                        else
                          O[v[S]](O[Y[S]])
                        end
                      else
                        O[Y[S]] = O[v[S]] - z[S]
                      end
                    end
                  end
                end
              end
            end
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
          else
            if u >= 45 then
              local E, m, V
              if u < 68 then
                E = o
                if u < 56 then
                  if u < 50 then
                    if u >= 47 then
                      if u >= 48 then
                        if u ~= 49 then
                          L, A = P[S], O[Y[S]]
                          O[L + 1] = A
                          O[L] = A[M[S]]
                        else
                          O[P[S]] = T(O[v[S]], i[S])
                        end
                      else
                        Z += r
                        L = if r <= 0 then Z >= j else Z <= j
                        if L then
                          O[P[S]] = Z
                          S = Y[S]
                        else
                          S = v[S]
                        end
                      end
                    else
                      if u ~= 46 then
                        O[Y[S]] = B(O[P[S]], O[v[S]])
                      else
                        O[Y[S]] = O[v[S]] + z[S]
                      end
                    end
                  else
                    if u >= 53 then
                      if u < 54 then
                        S = if O[Y[S]] then P[S] else v[S]
                      else
                        if u ~= 55 then
                          local d, _, qw = v[S], R(P[S], (T(R(F, (T(x(F, 29), 7))), 536870911))), I[5]
                          local F = R(qw[d], 379895444)
                          qw[d] = F
                          d, qw = I[4], F + 1
                          F = J(d, qw)
                          local Pw, zw
                          if F < 128 then
                            Pw, zw = F, qw + 1
                          else
                            local yw = J(d, qw + 1)
                            if yw < 128 then
                              Pw, zw = (F - 128) + (yw * 128), qw + 2
                            else
                              local iw = J(d, qw + 2)
                              if iw < 128 then
                                Pw, zw = (((F - 128) * 16384) + ((yw - 128) * 128)) + iw, qw + 3
                              else
                                local Sw = J(d, qw + 3)
                                Pw, zw = (((((F - 128) * 2097152) + ((yw - 128) * 16384)) + (iw - 128)) + ((Sw % 128) * 128)) + ((Sw - (Sw % 128)) * 2097152), qw + 4
                              end
                            end
                          end
                          qw, F = _ * 16843009, zw + Pw
                          local yw = F - (Pw % 4)
                          for Pw = zw, yw - 1, 4 do
                            h(d, Pw, (R(H(d, Pw), qw)))
                          end
                          for qw = yw, F - 1, 1 do
                            X(d, qw, (R(J(d, qw), _)))
                          end
                          v[S] = 195
                          P[S] = 9
                          Y[S] = 251
                          y[S] = 0
                        else
                          O[P[S]] = q
                        end
                      end
                    else
                      if u >= 51 then
                        if u ~= 52 then
                          O[v[S]] = O[Y[S]] == z[S]
                        else
                          O[v[S]] = O[P[S]] > Y[S]
                        end
                      else
                        O[v[S]](i[S])
                      end
                    end
                  end
                else
                  m, V = L, A
                  if u >= 62 then
                    if u >= 65 then
                      if u >= 66 then
                        if u == 67 then
                          if p then
                            local F = v[S]
                            local d = p[F]
                            if d then
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                              d[5] = d
                              d[6] = O[F]
                              d[4] = 6
                              p[F] = nil
                            end
                          end
                        else
                          O[Y[S]] = O[v[S]] / O[P[S]]
                        end
                      else
                        O[Y[S]] = x(O[v[S]], P[S])
                      end
                    elseif u >= 63 then
                      if u ~= 64 then
                        O[v[S]] = g(O[P[S]], Y[S])
                      else
                        O[v[S]] = O[Y[S]] // O[P[S]]
                      end
                    elseif p then
                      local F = P[S]
                      local d = p[F]
                      if d then
                        d[5] = d
                        d[6] = O[F]
                        d[4] = 6
                        p[F] = nil
                      end
                      d = Y[S]
                      F = p[d]
                      if F then
                        F[5] = F
                        F[6] = O[d]
                        F[4] = 6
                        p[d] = nil
                      end
                      F = v[S]
                      d = p[F]
                      if d then
                        d[5] = d
                        d[6] = O[F]
                        d[4] = 6
                        p[F] = nil
                      end
                    end
                  elseif u < 59 then
                    if u >= 57 then
                      if u ~= 58 then
                        O[P[S]] = B(O[Y[S]], v[S])
                      else
                        if p then
                          for F in G, p, nil do
                            local B = p[F]
                            if B then
                              B[5] = B
                              B[6] = O[F]
                              B[4] = 6
                              p[F] = nil
                            end
                          end
                        end
                        if U then
                          for F, B in G, U, nil do
                            local d = B[6]
                            if U then
                              B = U[F]
                              if B then
                                local _, qw = (F + d) - 1, k(d)
                                W(O, F, _, 1, qw)
                                B[5] = qw
                                B[4] = 1
                                U[F] = nil
                              end
                            end
                          end
                        end
                        return O[v[S]](t(O[Y[S]], 1, O[Y[S]].n))
                      end
                    else
                      O[Y[S]] = R(O[P[S]], O[v[S]])
                    end
                  elseif u < 60 then
                    L = v[S]
                    o = L + P[S]
                    if p then
                      for F in G, p, nil do
                        local B = p[F]
                        if B then
                          B[5] = B
                          B[6] = O[F]
                          B[4] = 6
                          p[F] = nil
                        end
                      end
                    end
                    if U then
                      for F, B in G, U, nil do
                        local d = B[6]
                        if U then
                          B = U[F]
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                          if B then
                            local _, qw = F + d, k(d)
                            W(O, F, _ - 1, 1, qw)
                            B[5] = qw
                            B[4] = 1
                            U[F] = nil
                          end
                        end
                      end
                    end
                    return O[L](t(O, L + 1, o))
                  elseif u ~= 61 then
                    O[v[S]] = O[P[S]](t(O[Y[S]], 1, O[Y[S]].n))
                  else
                    if p then
                      for F in G, p, nil do
                        local B = p[F]
                        if B then
                          B[5] = B
                          B[6] = O[F]
                          B[4] = 6
                          p[F] = nil
                        end
                      end
                    end
                    if U then
                      for F, B in G, U, nil do
                        local d = B[6]
                        if U then
                          B = U[F]
                          if B then
                            local _, qw = F + d, k(d)
                            W(O, F, _ - 1, 1, qw)
                            B[5] = qw
                            B[4] = 1
                            U[F] = nil
                          end
                        end
                      end
                    end
                    return O[Y[S]], t(O[v[S]], 1, O[v[S]].n)
                  end
                  L, A = m, V
                end
                o = E
              else
                if u >= 79 then
                  if u >= 85 then
                    if u < 88 then
                      if u >= 86 then
                        if u ~= 87 then
                          O[v[S]] = O[P[S]] / Y[S]
                        else
                          L, A, o = P[S], v[S], Y[S]
                          c, b = (L + o) - 1, L + A
                          D = O[b]
                          n = D.n
                          w = (A + n) - 1
                          D.n = w
                          W(D, 1, n, A, D)
                          W(O, L + 1, b - 1, 1, D)
                          f = l(O[L](t(D, 1, D.n)))
                          W(f, 1, o, L, O)
                        end
                      else
                        O[Y[S]] = O[P[S]] .. O[v[S]]
                      end
                    else
                      if u < 89 then
                        L = v[S]
                        O[L], O[L + 1] = Y[S], z[S]
                      else
                        if u ~= 90 then
                          O[v[S]] = N(O[Y[S]])
                        else
                          O[v[S]] = R(O[Y[S]], z[S])
                        end
                      end
                    end
                  else
                    if u >= 82 then
                      if u >= 83 then
                        if u ~= 84 then
                          if p then
                            for w in G, p, nil do
                              local f = p[w]
                              if f then
                                f[5] = f
                                f[6] = O[w]
                                f[4] = 6
                                p[w] = nil
                              end
                            end
                          end
                          if U then
                            for w, f in G, U, nil do
                              local F = f[6]
                              if U then
                                f = U[w]
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
                                if f then
                                  local B, d = w + F, k(F)
                                  W(O, w, B - 1, 1, d)
                                  f[5] = d
                                  f[4] = 1
                                  U[w] = nil
                                end
                              end
                            end
                          end
                          return O[v[S]](i[S], t(O[P[S]], 1, O[P[S]].n))
                        else
                          O[P[S]] = Q
                        end
                      else
                        O[P[S]] = M[S] * O[Y[S]]
                      end
                    elseif u < 80 then
                      O[Y[S]](O[v[S]], O[P[S]])
                    elseif u ~= 81 then
                      O[v[S]] = O[Y[S]] >= P[S]
                    else
                      O[v[S]] = i[S]
                    end
                  end
                else
                  if u < 73 then
                    m = L
                    if u >= 70 then
                      if u >= 71 then
                        if u == 72 then
                          local w, f, F = Y[S], z[S], O[v[S]]
                          local B, d = T(f, 4294967295), T(F, 4294967295)
                          local f, _, N, qw = T(B, 65535), x(B, 16), T(d, 65535), x(d, 16)
                          d = T((f * N) + g(T((f * qw) + (_ * N), 65535), 16), 4294967295)
                          F = nil
                          repeat
                            _ = d % 4294967296
                            if _ ~= _ then
                              F = 0
                              break
                            end
                            F = _ - (_ % 1)
                          until true
                          O[w] = F
                        else
                          O[v[S]] = O[P[S]][O[Y[S]]]
                        end
                      else
                        O[P[S]][M[S]] = Y[S]
                      end
                    else
                      if u ~= 69 then
                        if p then
                          for w in G, p, nil do
                            local f = p[w]
                            if f then
                              f[5] = f
                              f[6] = O[w]
                              f[4] = 6
                              p[w] = nil
                            end
                          end
                        end
                        if U then
                          for w, f in G, U, nil do
                            local F = f[6]
                            if U then
                              f = U[w]
                              if f then
                                local B, d = w + F, k(F)
                                W(O, w, B - 1, 1, d)
                                f[5] = d
                                f[4] = 1
                                U[w] = nil
                              end
                            end
                          end
                        end
                        L = Y[S]
                        return t(O, L, (L + v[S]) - 1)
                      else
                        S = if O[v[S]] <= O[P[S]] then S else Y[S]
                      end
                    end
                    L = m
                  else
                    if u >= 76 then
                      if u < 77 then
                        O[Y[S]] = O[P[S]](M[S])
                      else
                        if u ~= 78 then
                          L, A, o, c = Y[S], P[S], R(Q, T(x(Q, 14), 262143), (T(x(Q, 28), 15))), v[S]
                          b = ((A < 2097152) and 7) or 14
                          D, n = T(A, g(1, b) - 1), x(A, b)
                          y[S] = R(n, 32, (T(x(o, 21), 127)))
                          P[S] = R(D, 111, (T(x(o, 7), 127)))
                          Y[S] = R(L, 32, (T(x(o, 14), 127)))
                          v[S] = R(c, 114, (T(o, 127)))
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                          S = S - 1
                        else
                          local m, w, f = v[S], R(P[S], (T(R(Q, (T(x(Q, 29), 7))), 536870911))), I[5]
                          local F = R(f[m], 379895444)
                          f[m] = F
                          f, m = I[4], F + 1
                          F = J(f, m)
                          local B, d
                          if F < 128 then
                            B, d = F, m + 1
                          else
                            local _ = J(f, m + 1)
                            if _ < 128 then
                              B, d = (F - 128) + (_ * 128), m + 2
                            else
                              local N = J(f, m + 2)
                              if N < 128 then
                                B, d = (((F - 128) * 16384) + ((_ - 128) * 128)) + N, m + 3
                              else
                                local qw = J(f, m + 3)
                                B, d = (((((F - 128) * 2097152) + ((_ - 128) * 16384)) + (N - 128)) + ((qw % 128) * 128)) + ((qw - (qw % 128)) * 2097152), m + 4
                              end
                            end
                          end
                          m, F = w * 16843009, d + B
                          local _ = F - (B % 4)
                          for B = d, _ - 1, 4 do
                            h(f, B, (R(H(f, B), m)))
                          end
                          for m = _, F - 1, 1 do
                            X(f, m, (R(J(f, m), w)))
                          end
                          v[S] = 180
                          P[S] = 137
                          Y[S] = 242
                          y[S] = 0
                        end
                      end
                    else
                      V, E = A, o
                      local m, w, f = c, b, D
                      if u < 74 then
                        L, A = v[S], Y[S]
                        o = L + A
                        c = O[o]
                        b = c.n
                        if p then
                          for F in G, p, nil do
                            local B = p[F]
                            if B then
                              B[5] = B
                              B[6] = O[F]
                              B[4] = 6
                              p[F] = nil
                            end
                          end
                        end
                        if U then
                          for F, B in G, U, nil do
                            local d = B[6]
                            if U then
                              B = U[F]
                              if B then
                                local _, N = (F + d) - 1, k(d)
                                W(O, F, _, 1, N)
                                B[5] = N
                                B[4] = 1
                                U[F] = nil
                              end
                            end
                          end
                        end
                        c.n = (A + b) - 1
                        W(c, 1, b, A, c)
                        W(O, L + 1, o - 1, 1, c)
                        return O[L](t(c, 1, c.n))
                      elseif u == 75 then
                        L = v[S]
                        O[L], O[L + 1] = O[Y[S]], z[S]
                      else
                        O[v[S]] = O[P[S]] * i[S]
                      end
                      A, o, c, b, D = V, E, m, w, f
                    end
                  end
                end
              end
            else
              local E
              if u < 22 then
                if u < 11 then
                  if u >= 5 then
                    if u >= 8 then
                      if u >= 9 then
                        if u ~= 10 then
                          if p then
                            for m in G, p, nil do
                              local V = p[m]
                              if V then
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
                                V[5] = V
                                V[6] = O[m]
                                V[4] = 6
                                p[m] = nil
                              end
                            end
                          end
                          if U then
                            for m, V in G, U, nil do
                              local w = V[6]
                              if U then
                                V = U[m]
                                if V then
                                  local f, F = m + w, k(w)
                                  W(O, m, f - 1, 1, F)
                                  V[5] = F
                                  V[4] = 1
                                  U[m] = nil
                                end
                              end
                            end
                          end
                          return O[v[S]](i[S], O[P[S]])
                        else
                          if p then
                            for m in G, p, nil do
                              local V = p[m]
                              if V then
                                V[5] = V
                                V[6] = O[m]
                                V[4] = 6
                                p[m] = nil
                              end
                            end
                          end
                          if U then
                            for m, V in G, U, nil do
                              local w = V[6]
                              if U then
                                V = U[m]
                                if V then
                                  local f = k(w)
                                  W(O, m, (m + w) - 1, 1, f)
                                  V[5] = f
                                  V[4] = 1
                                  U[m] = nil
                                end
                              end
                            end
                          end
                          return t(O[P[S]], 1, O[P[S]].n)
                        end
                      else
                        q[i[S]] = O[P[S]]
                      end
                    else
                      if u < 6 then
                        L, A, o = v[S], Y[S], P[S]
                        c, b, D = (L + o) - 1, L + A, l(O[L](t(O, L + 1, L + A)))
                        W(D, 1, o, L, O)
                      else
                        if u == 7 then
                          L = O[v[S]]
                          O[P[S]] = l(t(L, Y[S], L.n))
                        else
                          O[P[S]] = O[v[S]] == O[Y[S]]
                        end
                      end
                    end
                  else
                    if u < 2 then
                      if u ~= 1 then
                      else
                        L = Y[S]
                        O[L], O[L + 1] = O[P[S]], v[S]
                      end
                    else
                      if u < 3 then
                        local m, V, w = Y[S], v[S], I[5]
                        local f = R(w[m], 379895444)
                        w[m] = f
                        w, m = I[4], f + 1
                        f = J(w, m)
                        local I, F
                        if f < 128 then
                          I, F = f, m + 1
                        else
                          local B = J(w, m + 1)
                          if B < 128 then
                            I, F = (f - 128) + (B * 128), m + 2
                          else
                            local d = J(w, m + 2)
                            if d < 128 then
                              I, F = (((f - 128) * 16384) + ((B - 128) * 128)) + d, m + 3
                            else
                              local _ = J(w, m + 3)
                              I, F = (((((f - 128) * 2097152) + ((B - 128) * 16384)) + (d - 128)) + ((_ % 128) * 128)) + ((_ - (_ % 128)) * 2097152), m + 4
                            end
                          end
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                        end
                        m, f = V * 16843009, F + I
                        local B = f - (I % 4)
                        for I = F, B - 1, 4 do
                          h(w, I, (R(H(w, I), m)))
                        end
                        for I = B, f - 1, 1 do
                          X(w, I, (R(J(w, I), V)))
                        end
                        Y[S] = 114
                        v[S] = 112
                        P[S] = 188
                        y[S] = 0
                      else
                        if u ~= 4 then
                          L = e[v[S]]
                          O[Y[S]] = L[5][L[4]][z[S]]
                        else
                          local I, m, V = Y[S], O[v[S]]
                          repeat
                            local w = m % 4294967296
                            if w ~= w then
                              V = 0
                              break
                            end
                            V = w - (w % 1)
                          until true
                          O[I] = V
                        end
                      end
                    end
                  end
                else
                  if u < 16 then
                    if u < 13 then
                      if u ~= 12 then
                        local I, m, V = P[S], M[S], Y[S]
                        local w, f = T(m, 4294967295), T(V, 4294967295)
                        local V, F, B, d = T(w, 65535), x(w, 16), T(f, 65535), x(f, 16)
                        m = T((V * B) + g(T((V * d) + (F * B), 65535), 16), 4294967295)
                        B = nil
                        repeat
                          f = m % 4294967296
                          if f ~= f then
                            B = 0
                            break
                          end
                          B = f - (f % 1)
                        until true
                        O[I] = B
                      else
                        O[v[S]] = O[P[S]] - O[Y[S]]
                      end
                    else
                      if u < 14 then
                        E = C
                        C, L, A = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = E}, Y[S], s(K)
                        A(q, O[L], O[L + 1], O[L + 2])
                        a = P[S]
                        S, Z = v[S], A
                      else
                        if u == 15 then
                          S = if O[v[S]] < O[Y[S]] then S else P[S]
                        else
                          O[Y[S]][O[P[S]]] = O[v[S]]
                        end
                      end
                    end
                  else
                    if u < 19 then
                      if u >= 17 then
                        if u ~= 18 then
                          L, A, o = v[S], Y[S], P[S]
                          c, b = O[L], L + A
                          D = O[b]
                          W(O, L + 1, b - 1, o + 1, c)
                          W(D, 1, D.n, o + A, c)
                        else
                          O[P[S]] = not O[v[S]]
                        end
                      else
                        e[Y[S]][M[S]] = O[P[S]]
                      end
                    else
                      if u < 20 then
                        O[Y[S]] = O[P[S]][M[S]]
                      else
                        if u ~= 21 then
                          L = e[v[S]]
                          L[5][L[4]][z[S]] = i[S]
                        else
                          L = P[S]
                          O[L], O[L + 1] = M[S], Y[S]
                        end
                      end
                    end
                  end
                end
              else
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
                if u < 33 then
                  if u >= 27 then
                    if u >= 30 then
                      if u >= 31 then
                        if u == 32 then
                          local I, m, V = v[S], O[Y[S]], P[S]
                          local w, f = T(m, 4294967295), T(V, 4294967295)
                          local V, F, B, d = T(w, 65535), x(w, 16), T(f, 65535), x(f, 16)
                          m = T((V * B) + g(T((V * d) + (F * B), 65535), 16), 4294967295)
                          V = nil
                          repeat
                            B = m % 4294967296
                            if B ~= B then
                              V = 0
                              break
                            end
                            V = B - (B % 1)
                          until true
                          O[I] = V
                        else
                          O[Y[S]](O[P[S]], M[S])
                        end
                      else
                        L, A, o = Y[S], v[S], P[S]
                        c = L + A
                        O[L] = l(O[L](t(O, L + 1, c)))
                      end
                    else
                      if u >= 28 then
                        if u ~= 29 then
                          O[P[S]] = q[i[S]]
                        else
                          if p then
                            for q in G, p, nil do
                              local I = p[q]
                              if I then
                                I[5] = I
                                I[6] = O[q]
                                I[4] = 6
                                p[q] = nil
                              end
                            end
                          end
                          if U then
                            for q, I in G, U, nil do
                              local m = I[6]
                              if U then
                                I = U[q]
                                if I then
                                  local V = k(m)
                                  W(O, q, (q + m) - 1, 1, V)
                                  I[5] = V
                                  I[4] = 1
                                  U[q] = nil
                                end
                              end
                            end
                          end
                          return i[S], t(O[v[S]], 1, O[v[S]].n)
                        end
                      else
                        O[Y[S]] = O[v[S]] < O[P[S]]
                      end
                    end
                  else
                    if u >= 24 then
                      if u >= 25 then
                        if u ~= 26 then
                          O[v[S]] = O[P[S]](O[Y[S]])
                        else
                          O[v[S]] = O[Y[S]] * O[P[S]]
                        end
                      else
                        E = C
                        C, L = {[7] = a, [8] = j, [5] = r, [9] = Z, [6] = E}, v[S]
                        r, j = O[L + 2] + 0, O[L + 1] + 0
                        Z = O[L] - r
                        S = P[S]
                      end
                    else
                      if u == 23 then
                        L, A, o, c = P[S], Y[S], R(Q, T(x(Q, 14), 262143), (T(x(Q, 28), 15))), v[S]
                        b = ((A < 16384) and 7) or (((A < 2097152) and 14) or 21)
                        D, n = T(A, g(1, b) - 1), x(A, b)
                        Y[S] = R(D, 126, (T(x(o, 14), 127)))
                        y[S] = R(n, 1, (T(x(o, 21), 127)))
                        v[S] = R(c, 30, (T(o, 127)))
                        P[S] = R(L, 66, (T(x(o, 7), 127)))
                        S = S - 1
                      else
                        O[v[S]](i[S], z[S])
                      end
                    end
                  end
                else
                  if u < 39 then
                    if u < 36 then
                      if u >= 34 then
                        if u == 35 then
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
                          S = if O[P[S]] < Y[S] then S else v[S]
                        else
                          O[P[S]] = l(O[v[S]](O[Y[S]]))
                        end
                      else
                        Z, j = C[9], C[8]
                        r, a, C = C[5], C[7], C[6]
                      end
                    else
                      if u < 37 then
                        O[P[S]] = O[v[S]] / i[S]
                      elseif u == 38 then
                        e[Y[S]][M[S]] = z[S]
                      else
                        O[v[S]] = e[Y[S]]
                      end
                    end
                  else
                    if u >= 42 then
                      if u < 43 then
                        O[P[S]] = O[Y[S]] < v[S]
                      else
                        if u ~= 44 then
                          A, L = v[S], Y[S] + 1
                          for q = 1, P[S], 1 do
                            A = T(R(A, (g(A, 13))), 536870911)
                            A = R(A, (x(A, 13)))
                            A = T(R(A, (g(A, 14))), 536870911)
                            v[L] = R(v[L], (T(x(A, 0), 127)))
                            P[L] = R(P[L], (T(x(A, 7), 127)))
                            Y[L] = R(Y[L], (T(x(A, 14), 127)))
                            y[L] = R(y[L], (T(x(A, 21), 127)))
                            L = L + 1
                          end
                          y[S] = 0
                        else
                          O[P[S]] = i[S] .. O[v[S]]
                        end
                      end
                    else
                      if u < 40 then
                        O[P[S]] = O[Y[S]] + O[v[S]]
                      elseif u == 41 then
                        O[v[S]] = O[Y[S]] >= O[P[S]]
                      else
                        O[v[S]][i[S]] = O[P[S]]
                      end
                    end
                  end
                end
              end
            end
          end
          S = S + 1
        end
      end
    end
  end
end

local f73 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    return function(q)
      local q
      local q = P
      local P = q.Character
      return P, P and (P:FindFirstChildOfClass("Humanoid")), P and (P:FindFirstChild("HumanoidRootPart"))
    end
  end
end

local f16 = function(q, q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    local Y = q[6]
    local I = q[7]
    return function()
      local q
      local q, v = P
      if q.destroyed then
        return
      else
        local v = P
        if v.enabled then
          local v
          local v, M = z, y
          if v.Character ~= M then
            return
          end
        else
          return
        end
      end
      q = y
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
      q:FindFirstChild("HumanoidRootPart")
      q = y
      local z = q:FindFirstChildOfClass("Humanoid")
      pcall(function()
        local v
        local v = i
        v.Enabled = false
      end)
      local i
      q = S
      for i in pairs(q) do
        if i.Parent then
          pcall(function()
            i.Enabled = false
          end)
        end
      end
      local i
      local i, S = Y
      if i then
        if not I[5][I[4]] then
          local S, Y, v = P, P, y
          if pcall(S._spawnTransitClone, Y, v) then
            q = P
            if q.treadmillDecoy then
              I[5][I[4]] = true
            end
          end
        end
        if I[5][I[4]] then
          local S, S = P, P
          pcall(P._setLiveCharacterHidden, P, true)
        end
      else
        if not I[5][I[4]] then
          local S, Y, v = P, P, y
          if pcall(S._spawnTransitClone, Y, v) then
            local y = P
            if y.treadmillDecoy then
              I[5][I[4]] = true
            end
          end
        end
        if I[5][I[4]] then
          local y, y = P, P
          pcall(P._setLiveCharacterHidden, P, true)
        end
      end
      local y = workspace.CurrentCamera
      if y then
        i = P
        local S, Y = i.treadmillDecoy
        if S then
          q = P
          Y = q.treadmillDecoyCameraSubject
        else
          Y = S
        end
        S = Y or nil
        S = I[5][I[4]] and S
        local q = S or z
        if q and (y.CameraSubject ~= q) then
          pcall(function()
            if y.CameraType ~= Enum.CameraType.Custom then
              y.CameraType = Enum.CameraType.Custom
            end
            y.CameraSubject = q
          end)
        end
      end
    end
  end
end

local f5827 = function(q, P, P, P, P, P, P, P)
  return function(P, P, z)
    local z = P[1]
    local y = P[2]
    return function(P, i, S)
      local Y, I = 28
      local v, M, u, E, m, V, j, A, L, C, w, n = P, i, S
      while true do
        i = nil
        if Y <= 14 then
          if Y <= 6 then
            if Y <= 2 then
              if Y <= 0 then
                S = q[10](L, u + 1)
                Y, A = 5, S
              elseif Y <= 1 then
                P = I[4]
                Y, I = 7, P
              else
                local P = q[10](L, u + 3)
                Y, V, u = 20, (((((V - 128) * 2097152) + ((j - 128) * 16384)) + (A - 128)) + ((P % 128) * 128)) + ((P - (P % 128)) * 2097152), u + 4
              end
            elseif Y <= 4 then
              if Y <= 3 then
                local P = q[10](E, m + 1)
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
                Y, j = ((P < 128) and 12) or 29, P
              else
                Y, j, u = 30, (j - 128) + (A * 128), u + 2
              end
            elseif Y <= 5 then
              Y = ((A < 128) and 4) or 13
            else
              local P = q[10](L, u + 1)
              Y, j = ((P < 128) and 23) or 10, P
            end
          elseif Y <= 10 then
            if Y <= 8 then
              if Y <= 7 then
                local P, S = V - 1, 1 + 0
                local b = {nil, I, S, w - S, P + 0}
                Y, I = 24, b
              else
                local P = q[10](E, m + 3)
                Y, V, m = 11, (((((V - 128) * 2097152) + ((j - 128) * 16384)) + (A - 128)) + ((P % 128) * 128)) + ((P - (P % 128)) * 2097152), m + 4
              end
            elseif Y <= 9 then
              Y, u = 30, u + 1
            else
              local P = q[10](L, u + 2)
              Y, A = ((P < 128) and 27) or 2, P
            end
          elseif Y <= 12 then
            if Y <= 11 then
              local P, S = 169, 63
              i = (u + M) % 256
              local b, U, a = q[105](V), u * 16843009, V - (V % 4)
              local c, D = a - 1, 4 + 0
              local r = 0 - D
              local o = {c + 0, D, nil, I, r}
              Y, I, M, j, A, L, C, w = 26, o, i, P, S, b, U, a
            else
              Y, V, m = 11, (V - 128) + (j * 128), m + 2
            end
          elseif Y <= 13 then
            local P = q[10](L, u + 2)
            Y, C = ((P < 128) and 22) or 21, P
          else
            Y, u = 20, u + 1
          end
        elseif Y <= 22 then
          if Y <= 18 then
            if Y <= 16 then
              if Y <= 15 then
                i = ((j * M) + A) % 256
                q[12](L, V, (q[115](q[10](E, m + V), u, i)))
                Y, M = 24, i
              else
                Y, m = 11, m + 1
              end
            elseif Y <= 17 then
              Y, V, m = 11, (((V - 128) * 16384) + ((j - 128) * 128)) + A, m + 3
            else
              return v, M
            end
          elseif Y <= 20 then
            if Y <= 19 then
              local P, S = q[43], q[25](E, m + n)
              local w
              local w = z[5][z[4]][M]
              P(L, n, (q[115](S, w, C)))
              local P
              i = y[5][y[4]][M]
              Y, M = 26, i
            else
              local P = q[10](L, u)
              Y, j = ((P < 128) and 9) or 0, P
            end
          elseif Y <= 21 then
            local P = q[10](L, u + 3)
            Y, j, u = 30, (((((j - 128) * 2097152) + ((A - 128) * 16384)) + (C - 128)) + ((P % 128) * 128)) + ((P - (P % 128)) * 2097152), u + 4
          else
            Y, j, u = 30, (((j - 128) * 16384) + ((A - 128) * 128)) + C, u + 3
          end
        elseif Y <= 26 then
          if Y <= 24 then
            if Y <= 23 then
              Y, V, u = 20, (V - 128) + (j * 128), u + 2
            else
              local P, z, y = I[4], I[3], I[5]
              local i, S = P + z, z <= 0
              z, P = i >= y, i <= y
              y = (S and z) or (not S and P)
              I[4] = i
              if y then
                Y, V = 15, i
              else
                Y = 25
              end
            end
          elseif Y <= 25 then
            local P = I[2]
            v[6] = q[5](v)
            local z, y, i = q:MU(v, L)
            local S = q[10](L, i)
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
            Y, I, v, M, u, V = ((S < 128) and 14) or 6, P, z, y, i, S
          else
            local P, z, y = I[5], I[2], I[1]
            local i, S = P + z, z <= 0
            P, z = i >= y, i <= y
            y = (S and P) or (not S and z)
            I[5] = i
            if y then
              Y, n = 19, i
            else
              Y = 1
            end
          end
        elseif Y <= 28 then
          if Y <= 27 then
            Y, V, u = 20, (((V - 128) * 16384) + ((j - 128) * 128)) + A, u + 3
          else
            local P, z = v[5][M], v[4]
            local y = P + 1
            P = q[10](z, y)
            Y, E, m, V = ((P < 128) and 16) or 3, z, y, P
          end
        elseif Y <= 29 then
          local P = q[10](E, m + 2)
          Y, A = ((P < 128) and 17) or 8, P
        else
          local P, z = q[10](L, u), u + 1
          q[62](E, m + V, P, j)
          Y = 18
        end
      end
    end
  end
end

local f99 = function(q, q, q, q, q, q)
  return function()
    return function(q)
      local P, z = q.eggRuntime, q.destroyed
      local y = ((((if z then not z else q.enabled) and not q._primerHitWindow) and (P ~= nil)) and not P.destroyed) and (P.enabled == true)
      if y == q._guardTouchesDisabled then
        return
      end
      q._guardTouchesDisabled = y
      if y then
        z = q:_collectGuardParts()
        if #z > 0 then
          for P, P in ipairs(z) do
            if q._guardTouchOriginal[P] == nil then
              q._guardTouchOriginal[P] = P.CanTouch
            end
            P.CanTouch = false
          end
        else
          for P, P in ipairs(workspace:GetDescendants()) do
            q:_disableGuardTouch(P)
          end
        end
      else
        for P, z in pairs(q._guardTouchOriginal) do
          if P.Parent then
            pcall(function()
              P.CanTouch = z
            end)
          end
        end
        table.clear(q._guardTouchOriginal)
      end
    end
  end
end

local f67 = function(q, q, q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    return function(q, i, S)
      if type(q) ~= "table" then
        return false
      end
      local Y = rawget(q, "RootPart")
      local I = ((Y and Y.Parent) and Y.CFrame) or nil
      local v = (I and I.Position) or nil
      local M = ((typeof(S) == "Vector3") and S) or Vector3.new(0, 0, 0)
      local function u(E)
        if type(E) == "table" then
          rawset(E, "WalkSpeed", i)
          if I then
            rawset(E, "CFrame", I)
            rawset(E, "Position", v)
            rawset(E, "LinearVelocity", M)
            rawset(E, "AngularVelocity", (Vector3.new(0, 0, 0)))
          end
        end
      end
      local I
      Y = P
      for P, P in ipairs(Y) do
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
        u(rawget(q, P))
      end
      for P, P in pairs(rawget(q, "SampleHistory") or {}) do
        u(P)
      end
      for P, P in pairs(rawget(q, "SafeGroundCheckpoints") or {}) do
        u(P)
      end
      S = rawget(q, "Evidence")
      if type(S) == "table" then
        S.Speed = 0
        S.Teleport = 0
        S.Flight = 0
      end
      S = rawget(q, "ImpulseContext")
      if type(S) == "table" then
        Y = math.max(tonumber(S.MaxHorizontalSpeed) or 0, i)
        local P
        local P, P = z, math.max((tonumber(S.ExpiresAt) or 0) - (tonumber(S.StartedAt) or 0), z)
        S.MaxHorizontalSpeed = Y
        if v then
          S.OriginPosition = v
        end
        local z, z
        z, S.MaxHorizontalDistance = y, math.max(tonumber(S.MaxHorizontalDistance) or 0, (Y * P) + (y * 2))
        u(S.PreMovementSafeSample)
      end
      if rawget(q, "CorrectionContext") == nil then
        rawset(q, "FirstSuspiciousAt", nil)
        if rawget(q, "ThreatLevel") == "Observing" then
          rawset(q, "ThreatLevel", "Trusted")
        end
      end
      return true
    end
  end
end

local f18 = function(q, q, q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    return function()
      local q
      local q = P
      if q.enabled then
        local q, Y = P
        local Y = z
        if q.epoch == Y then
          local q = P
          if q.token then
            local q = P
            if not (q.token.released) then
              local q
              local q, P = y
              local P = i
              if q.Parent == P then
                local q, P = y
                local P = S
                q.WalkSpeed = P
              end
            end
          end
        end
      end
    end
  end
end

local f16075 = function(q, q, q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    return function()
      local q = 1
      while true do
        if q <= 0 then
          return
        else
          local y, y
          P[5][P[4]](z[5][z[4]])
          q = 0
        end
      end
    end
  end
end

local f83 = function(q, q, q, q, q, q)
  return function(q, q, P, P, P)
    local P = q[1]
    return function()
      local q
      local q = P
      if q.destroyed then
        return
-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
      else
        local z = P
        if not (z:_shouldUseNoclip()) then
          return
        end
      end
      q = P
      q:_enforceNoclip()
    end
  end
end

local f96 = function(q, q, q, q, q, q, q)
  return function(q, q)
    return function(q)
      for P in pairs(q.noclipParts) do
        if P.Parent then
          if P.CanCollide == true then
            if q.noclipOriginal[P] == nil then
              q.noclipOriginal[P] = true
            end
            P.CanCollide = false
          end
        end
        if P.Parent then
          if not (P.CanTouch) then
            P.CanTouch = true
          end
          if not (P.CanQuery) then
            P.CanQuery = true
          end
        end
      end
    end
  end
end

local f90 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    local Y = q[6]
    local I = q[7]
    return function(q, v, M, u)
      local E
      local E, m = P
      local P = z
      local z = E()[P]
      if type(z) ~= "table" then
        return false
      elseif z.Enabled then
        if z.Humanoid ~= q then
          return false
        elseif z.RootPart ~= v then
          return false
        else
          local P
          E = y
          if not (E(z.State, q, v)) then
            return false
          end
        end
      else
        return false
      end
      local q, q, q, q, P, y, E
      q, P, y, E, z.WalkSpeed = i, S, Y, i, math.clamp(M * i, S, Y * i)
      if typeof(u) == "Vector3" then
        z.TravelVelocity = u
      elseif typeof(z.TravelVelocity) ~= "Vector3" then
        z.TravelVelocity = Vector3.new(0, 0, 0)
      end
      local q
      v = I
      return v(z.State, z.WalkSpeed, z.TravelVelocity)
    end
  end
end

local f63 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    return function()
      local q
      local q = P
      if q.destroyed then
        return
      else
        local y = P
        if not (y.noclipActive) then
          return
        end
      end
      q = P
      local y = q.driver.mount
-- *.*.* Luraph V15.1 Cracked By SL *.*.* [ https://discord.gg/zNyHGU6eUK ]
      local i, S = y ~= nil
      if i then
        q = nil
        q, S = P, y.Override == P.driver.railOverride
      else
        S = i
      end
      i = nil
      if S then
        q = P
        i = not q:autoStealMoving()
      else
        i = S
      end
      if not i then
        q = P
        q:_syncNoclip(false)
        return
      end
      q, S = P, P
      q.noclipFrame = (S.noclipFrame or 0) + 1
      local S, Y = P
      i = z
      if (S.noclipFrame % i) == 0 then
        y = P
        y:_rescanNoclip()
      end
      q = P
      q:_enforceNoclip()
    end
  end
end

local f28 = function(q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    return function(q)
      local Y, Y, Y
      if P[5][P[4]] then
        if P[5][P[4]].Parent then
          local Y = z
          if Y then
            local Y = y
            if not (Y) then
              return
            end
          else
            return
          end
        else
          return
        end
      else
        return
      end
      local Y
      if q then
        Y = q
      else
        local I
        local I = i
        Y = I
      end
      q = z
      local i = q.AssemblyLinearVelocity
      q = Vector3.new(i.X, 0, i.Z)
      local i, I, I, v, M, u, E = ((q.Magnitude > 1) and (q.Unit * math.clamp(q.Magnitude * 0.05, 0, 25))) or Vector3.new(0, 0, 0)
      I, v, M, u, E, P[5][P[4]].CFrame = z, S, z, y, z, CFrame.new(z.Position.X + i.X, (Y - S:_feetOffset(z, y)) - 0.55, z.Position.Z + i.Z)
    end
  end
end

local f39 = function(q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    local Y = q[6]
    local I = q[7]
    local v = q[8]
    local M = q[9]
    return function(q, u, E)
      local m
      local m = P
      local P = m()
      local V, j = P.State
      m = z
      if m(V, q, u) then
      else
        local z = os.clock()
        if z < (P.NextSearchAt or 0) then
          return false
        end
-- [ SL x Luraph V15.1 ] Cracked & Open | discord.gg/zNyHGU6eUK
        P.NextSearchAt = z + 0.2
        local j
        local j, A = y
        z = i
        V = (j(z, q, u))
      end
      if not (V) then
        return false
      end
      local z
      m = S
      if not (m(V, q, u)) then
        P.Enabled = false
        P.Humanoid = q
        P.RootPart = u
        P.State = V
        return false
      end
      P.NextSearchAt = 0
      P.Enabled = true
      P.Humanoid = q
      P.RootPart = u
      P.State = V
      local q, q, q, q, z, y, i
      q, z, y, i, P.WalkSpeed = Y, I, v, Y, math.clamp(E * Y, I, v * Y)
      P.TravelVelocity = Vector3.new(0, 0, 0)
      local q
      m = M
      m(V, P.WalkSpeed, P.TravelVelocity)
      return true
    end
  end
end

local f114 = function(q, q, q, q, q, q, q, q)
  return function(q, q)
    return function()
      return (getgenv and getgenv()) or _G
    end
  end
end

local f2076 = function(q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    return function()
      local q = 1
      while true do
        if q <= 0 then
          return
        else
          local i, S = true
          P[5][P[4]] = i
          z[5][z[4]] = (z[5][z[4]] - (z[5][z[4]] % 2)) + 1
          local P
          y[5][y[4]], q = ((28889 * y[5][y[4]]) + 46703033) % 268435456, 0
        end
      end
    end
  end
end

local f91 = function(q, q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    return function()
      local q
      local q = P
      q:_enforceArrivalHold()
    end
  end
end

local f75 = function(q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    return function()
      local q
      if P[5][P[4]] then
        return
      end
      local q
      local q, P = z
      if q then
        local q = z
        if q.Parent then
          local q
          local q = y
          if q then
            local q = y
            if q.Parent then
              local q, P = z, i
              if q.Position.Y < (P - 2.5) then
-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
                local q, P, Y, I, v = z
                P, Y, I, v, q.CFrame = z, i, z, z, CFrame.new(z.Position.X, i, z.Position.Z) * z.CFrame.Rotation
                Y = z
                P, q = Y.AssemblyLinearVelocity, z
                q.AssemblyLinearVelocity = Vector3.new(P.X, 0, P.Z)
                I = y
                if I:GetState() == Enum.HumanoidStateType.Freefall then
                  v = y
                  v:ChangeState(Enum.HumanoidStateType.Running)
                end
              end
            end
          end
        end
      end
      local q
      local q, P = S, i
      q(P)
    end
  end
end

local f56 = function(q, q, q, q, q, q, q)
  return function(q, q, P, P, P)
    local P = q[1]
    return function()
      local q
      local q = P
      if not (q:_syncHoverPad()) then
        local q = P
        q:_startHoverPad()
      end
    end
  end
end

local f69 = function(q, q, q, q, q)
  return function(q)
    return function(q)
      local P = q.eggRuntime
      if P then
        if P.destroyed then
          return false
        end
      else
        return false
      end
      if P.carry then
        if P.carry.active then
          return true
        end
      end
      if P.running then
        return true
      end
      if P.activeTween ~= nil then
        if P.config then
          if P.config.stealMode ~= "MoveTo" then
            return true
          end
        end
      end
      return false
    end
  end
end

local f9383 = function(q, q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    return function()
      local q = 0
      while true do
        if q <= 0 then
          local y, y
          P[5][P[4]](z[5][z[4]])
          q = 1
        else
          return
        end
      end
    end
  end
end

local f31 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    local S = q[5]
    local Y = q[6]
    local I = q[7]
    return function()
      local q
      local q, v, v, v = P
      if q then
-- SL | Luraph V15.1 Cracked & Released | Source Leak [ https://discord.gg/zNyHGU6eUK ]
        return
      else
        local P = z
        if P.destroyed then
          return
        else
          local P
          local P, v = y, i
          if P.Character ~= v then
            return
          else
            local P, y = S, i
            if P.Parent ~= y then
              return
            end
          end
        end
      end
      local P, y = S
      if P.Health <= 0 then
        local y, v = Y, z
        y(v)
        return
      else
        q = S
        if q:GetState() == Enum.HumanoidStateType.Dead then
          local y, v = Y, z
          y(v)
          return
        end
      end
      local z
      P = I
      if P then
        local z, y = I, i
        if z.Parent == y then
          q = I
          if q.Anchored then
            local z = I
            z.Anchored = false
          end
        end
      end
      q = S
      if q.BreakJointsOnDeath == true then
        P = S
        P.BreakJointsOnDeath = false
      end
    end
  end
end

local f109 = function(q, q, q, q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    return function(q, z, y)
      local i, S, Y = type(q) == "table"
      if i then
        local Y
        Y, S = P, rawget(q, "Player") == P
      else
        S = i
      end
      i = nil
      if S then
        local Y
        Y, i = P, rawget(q, "Character") == P.Character
      else
        i = S
      end
      return (i and (rawget(q, "Humanoid") == z)) and (rawget(q, "RootPart") == y)
    end
  end
end

local f14836 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    return function()
      local q
      local q = P
      q:syncGuardTouches()
      q = P
      local y = q.enabled
      local i, S = not y
      if y then
        q = P
        S = q.destroyed
      else
        S = i
      end
      if S then
        q = P
        q._wasHolding = false
        y = P
        y._burstUid = nil
        return
      end
-- ----------- SL | Luraph V15.1 | Cracked ----------- [ https://discord.gg/zNyHGU6eUK ]
      i = os.clock()
      local Y
      if i < z[5][z[4]] then
        return
      end
      z[5][z[4]] = i + 0.25
      y = P
      i = y:_getHeldEggUid()
      q = i ~= nil
      if q then
        y = P
        if not (y._wasHolding) then
          S = P
          if not (S.antiHitBusy) then
            local z = P
            if not (z:_isPrimerEgg(i)) then
              local z = P
              if z._burstUid ~= i then
                local z = P
                z:_scheduleBurst(i)
              end
            end
          end
        end
      end
      S = P
      S._wasHolding = q
      if not q then
        S = P
        S._scheduledBurstToken = S._scheduledBurstToken + 1
        i = P
        i._burstUid = nil
      end
    end
  end
end

local f1522 = function(q, q, q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    local z = q[2]
    return function(q)
      if q.enabled then
        if q.destroyed then
          return false
        end
      else
        return false
      end
      if q:_isWaitingGuardHit() then
        return false
      end
      local y, i, S = q:_liveBody()
      if y then
        if i then
          if not (S) then
            return false
          end
        else
          return false
        end
      else
        return false
      end
      if i.Health <= 0 then
        return false
      end
      local Y = q.eggRuntime
      if Y then
        if type(Y._isInField) == "function" then
          local I, v = pcall(Y._isInField, Y, S)
          if I then
            if not (v == true) then
              return false
            end
          end
        end
      end
      Y = false
      if i.Sit then
        i.Sit = false
        Y = true
      else
      end
      if i.PlatformStand then
        i.PlatformStand = false
        Y = true
      else
      end
      local I = i:GetState()
      if ((I == Enum.HumanoidStateType.Physics) or (I == Enum.HumanoidStateType.Ragdoll)) or (I == Enum.HumanoidStateType.FallingDown) then
        i:ChangeState(Enum.HumanoidStateType.Running)
        Y = true
      else
      end
      if I ~= Enum.HumanoidStateType.Jumping then
        if I ~= Enum.HumanoidStateType.Freefall then
          if I ~= Enum.HumanoidStateType.Landed then
            local I, v = S.AssemblyLinearVelocity
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
            local v = P
            if math.abs(I.Y) > v then
              if q:_isAirborne(y, i, S) then
              else
                S.AssemblyLinearVelocity = Vector3.new(I.X, 0, I.Z)
                Y = true
              end
            else
            end
          else
          end
        else
        end
      else
      end
      if Y then
        local P, P
        P, q._knockWindowUntil = z, os.clock() + z
        q.stats.blockedHits += 1
      end
      return Y
    end
  end
end

local f9897 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    return function()
      local q
      local q = P
      if q.enabled then
        local z = P
        if z.destroyed then
          return
        end
      else
        return
      end
      q = P
      q:_antiKnockbackFrame()
      q = P
      if os.clock() < (q._knockWindowUntil or 0) then
        local q = P
        q:_recoverBody()
      end
    end
  end
end

local f70 = function(q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    local z = q[2]
    return function()
      local q
      local q = P
      local P = q()
      local y
      q = z
      local y = P[q]
      if type(y) ~= "table" then
        y = {}
        q = z
        P[q] = y
      else
      end
      return y
    end
  end
end

local f102 = function(q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    local z = q[2]
    return function()
      local q
      local q = P
      if not (q._activeDecoy) then
        return
      end
      q = workspace.CurrentCamera
      if q then
        local y
        local y = z
        if y then
          if q.CameraType ~= Enum.CameraType.Scriptable then
            q.CameraType = Enum.CameraType.Scriptable
          end
          local y = z
          q.CFrame = y
        end
      end
      q = P
      if q._decoyHiddenParts then
        local q = P
        for P in pairs(q._decoyHiddenParts) do
          if P.Parent then
-- ====== Luraph V15.1 Cracked By SL ====== [ https://discord.gg/zNyHGU6eUK ]
            if P.LocalTransparencyModifier ~= 1 then
              P.LocalTransparencyModifier = 1
            end
          end
        end
      end
    end
  end
end

local f55 = function(q, q, q, q, q, q)
  return function(q, q, P)
    local P = q[1]
    return function()
      local q
      local q = P
      if q.activeTween then
        local q = P
        q:_syncHoverPad()
      else
        local q = P
        if q.arrivalHold then
          local q = P
          q:_syncHoverPad()
        end
      end
    end
  end
end

local f104 = function(q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    return function(q, z, y)
      local i
      local i = P
      return i(q, z, y)
    end
  end
end

local f53 = function(q, q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    return function()
      local q
      local q, S = P
      local S = z
      if q.treadmillDecoy ~= S then
        return
      else
        local q, S = P
        local P = y
        if q.treadmillDecoyCharacter ~= P then
          return
        else
          local q = z
          if q.Parent then
            local q
            local q, P = i, y
            if q.Character ~= P then
              return
            end
          else
            return
          end
        end
      end
      local q = workspace.CurrentCamera
      if q then
        pcall(function()
          if q.CameraType ~= Enum.CameraType.Custom then
            q.CameraType = Enum.CameraType.Custom
          end
          local P = z
          if q.CameraSubject ~= P then
            local P = z
            q.CameraSubject = P
          end
        end)
      end
    end
  end
end

local f66 = function(q, q, q, q, q, q)
  return function(q, q)
    return function(q, q, P)
      if P.RigType == Enum.HumanoidRigType.R15 then
        return (q.Size.Y * 0.5) + math.max(P.HipHeight, 0.5)
      end
      return (q.Size.Y * 0.5) + 2
    end
  end
end

-- ~~ Luraph V15.1 | Cracked By SL ~~ https://discord.gg/zNyHGU6eUK ~~
local f41 = function(q, q, q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    local i = q[4]
    return function()
      local q
      local q = P
      local P = q()
      local S
      q = z
      local S = P[q]
      local Y, I, v = type(S) ~= "table"
      if Y then
        I = Y
      else
        q = nil
        q, I = y, S.Version ~= y
      end
      if I then
        if type(S) == "table" then
          S.Enabled = false
        end
        S = {}
        q = y
        S.Version = q
        S.Installed = false
        S.Enabled = false
        S.Mode = "StateBaseline"
        S.Humanoid = nil
        S.RootPart = nil
        local q
        Y = i
        S.WalkSpeed = Y
        local q = z
        P[q] = S
      else
      end
      return S
    end
  end
end

local f12269 = function(q, q, q, q, q)
  return function(q, q)
    local P = q[1]
    local z = q[2]
    return function()
      local q, y, i = 3
      while true do
        local S
        if q <= 1 then
          if q <= 0 then
            P[5][P[4]] = y % i
            P[5][P[4]] = ((464293 * P[5][P[4]]) + 4116105) % 268435456
            P[5][P[4]] = ((661867 * P[5][P[4]]) + 166353925) % 268435456
            local S
            z[5][z[4]], q = ((1 * z[5][z[4]]) + 119555644) % 268435456, 2
          else
            P[5][P[4]] = (y + 259641579) % 268435456
            P[5][P[4]] = ((90769 * P[5][P[4]]) + 157946431) % 268435456
            P[5][P[4]] = ((634839 * P[5][P[4]]) + 130381025) % 268435456
            q, y, i = 0, (839839 * P[5][P[4]]) + 184688641, 268435456
          end
        elseif q <= 2 then
          return
        else
          P[5][P[4]] = ((292389 * P[5][P[4]]) + 64615907) % 268435456
          P[5][P[4]] = ((546713 * P[5][P[4]]) + 138279751) % 268435456
          P[5][P[4]] = ((531539 * P[5][P[4]]) + 4144353) % 268435456
          q, y = 1, 980407 * P[5][P[4]]
        end
      end
    end
  end
end

local f22 = function(q, q, q, q, q)
  return function(q, q, P, P)
    local P = q[1]
    local z = q[2]
    local y = q[3]
    return function(q, i)
      local S = q.hoverPad
      if S then
        if S.Parent then
          local Y
          local Y = P
          if S:GetAttribute(Y) ~= q.hoverPadOwnerId then
            return false
          end
        else
          return false
        end
      else
        return false
      end
      local P
-- [SL] Luraph V15.1 Cracked & Leaked | Source Leak [ https://discord.gg/zNyHGU6eUK ]
      local P = z
      local z = P.Character
      local P, Y = z and (z:FindFirstChild("HumanoidRootPart")), z and (z:FindFirstChildOfClass("Humanoid"))
      if P then
        if not (Y) then
          return false
        end
      else
        return false
      end
      local z, I, I = ((typeof(i) == "Vector3") and i) or P.Position
      I, S.CFrame = y, CFrame.new(z.X, ((z.Y - q:_feetOffset(P, Y)) - (y * 0.5)) - 0.05, z.Z)
      return true
    end
  end
end

local f47 = function(q, q, q, q, q)
  return function()
    return function(q, q)
      local P = workspace:FindFirstChild("World") or workspace:FindFirstChild("__OBJECTS")
      local z = P and (P:FindFirstChild("Areas"))
      P = z and (z:FindFirstChild("WallStartCollision"))
      if P then
        if not (P:IsA("BasePart")) then
          return true
        end
      else
        return true
      end
      return q.Position.X >= (P.Position.X + 3)
    end
  end
end



-- This Luraph V15.1 Cracked By SL | Source Leak [ https://discord.gg/zNyHGU6eUK ]
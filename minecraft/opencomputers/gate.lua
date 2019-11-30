-- Script for OpenComputers to handle the opening and closing of a hidden space rocket launchsite.
-- Works on T1 Hardware but also requires: 1 redstone card, 1 gpu card
-- Works best with 50x16 resolution with a one block sized screen

local component = require("component");
local sides = require("sides");
local rs = component.redstone;
local gpu = component.gpu;
local open = false;

function drawIdle()
    gpu.fill(0, 0, 50, 16, ' ');
    gpu.fill(22, 6, 6, 7, 'X');
    gpu.fill(23, 7, 4, 5, ' ');
end

function drawClose()
    drawIdle();
    gpu.fill(22, 8, 1, 3, ' ');
    gpu.fill(19, 9, 7, 1, 'X');
    gpu.fill(24, 8, 1, 3, 'X');
end

function drawOpen()
    drawIdle();
    gpu.fill(22, 8, 1, 3, ' ');
    gpu.fill(18, 9, 7, 1, 'X');
    gpu.fill(19, 8, 1, 3, 'X');
end

function closeGate()
    drawClose();
    rs.setOutput(sides.back, 3);
    os.sleep(3);
    rs.setOutput(sides.back, 0);
    rs.setOutput(sides.front, 3);
    os.sleep(1);
    rs.setOutput(sides.front, 0);
end

function openGate()
    drawOpen();
    rs.setOutput(sides.right, 3);
    os.sleep(4);
    rs.setOutput(sides.right, 0);
end

drawIdle();

while true do
    os.sleep(0.5);
    if rs.getInput(sides.left) > 1
    then
        if open
        then
            closeGate();
            open = false;
        else
            openGate();
            open = true;
        end
        drawIdle();
    end
end
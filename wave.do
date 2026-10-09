# Part II: simulate the 2-to-1 mux implemented in mux.sv.
if {![file isdirectory work]} {
    vlib work
}
vlog -sv mux.sv
vsim work.mux2to1

log {/*}
add wave {/*}

# Check every combination of x, y, and s. The output should be x when
# s is 0, and y when s is 1.
set failures 0
foreach s {0 1} {
    foreach x {0 1} {
        foreach y {0 1} {
            force x $x
            force y $y
            force s $s
            run 10ns

            set expected [expr {$s ? $y : $x}]
            set actual [examine -radix binary m]
            if {$actual ne $expected} {
                incr failures
                echo "FAIL: x=$x y=$y s=$s expected m=$expected got $actual"
            }
        }
    }
}

if {$failures == 0} {
    echo "PASS: all 8 mux2to1 input combinations passed"
} else {
    error "FAIL: $failures of 8 mux2to1 input combinations failed"
}

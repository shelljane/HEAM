# Approximate Multiplier by HEAM


## What's HEAM?

 - **HEAM** is a general optimization method to generate high-efficiency approximate multipliers for specific applications.
 - This project contains an 8x8 unsigned approximate multiplier based on HEAM for Deep Neural Network (DNN) accelerators and the corresponding Design Compiler(DC) script. Besides, the exact WallaceTree multiplier is included for comparison.


## Optimization Procedure of the 8×8 Unsigned Approximate Multiplier

![](https://github.com/shelljane/HEAM/edit/main/fig.png)


## Experiments of the Approximate Multiplier and the Exact WallaceTree multiplier on Design Compiler(DC) with Semiconductor Manufacturing International Corporation (SMIC) 65nm technology

|         |   Ours  | WallaceTree | Reduction |
| :-----: | :-----: | :-----: |  :-----: | 
| Area ( μm * μm ) | 523.32 | 829.11 | 36.88% |
| Power ( μW )  | 313.13 | 658.49 | 52.45% |
| Latency ( ns ) | 1.01 | 1.34 | 24.63% |


## Future
1. add our four reproduced approximate multipliers for comparison;
2. add DNNs accelerators.

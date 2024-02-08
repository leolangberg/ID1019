defmodule Interpreter do


  def test do

    #seq = [{:match, {:var, :x}, {:atm, :a}},
           # {:case, {:var, :x},
          #  [{:clause, {:atm, :b}, [{:atm, :ops}]},
         #   {:clause, {:atm, :a}, [{:atm, :yes}]}
        #    ]}
       #     ]
      #  Eager.eval_seq(seq, EnvList.new())
   # seq = [{:match, {:var, :x}, {:atm, :a}}, #x = a
    #      {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}}, #y = {a, b}
     #     {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}}, #match {ignore, z} = {a, b}
      #    {:var, :z}] #z = b

    #Eager.eval(seq)

    #sequence = [{:match, {:var, :x}, {:atm, :a}},
     #           {:case, {:var, :x}, [{:clause, {:atm, :b}, [{:atm, :ops}]},
    #            {:clause, {:atm, :a}, [{:atm, :yes}]},
   #             ]}
  #             ]
#
 #   Eager.eval_seq(sequence, EnvList.new())


   # seq = [{:match, {:var, :x}, {:atm, :a}},
    #          {:match, {:var, :f}, {:lambda, [:y], [:x], [{:cons, {:var, :x}, {:var, :y}}]}},
      #    {:apply, {:var, :f}, [{:atm, :b}]}
     #    ]

    #Eager.eval_seq(seq, EnvList.new())


   seq = [{:match, {:var, :x},
          {:cons, {:atm, :a}, {:cons, {:atm, :b}, {:atm, []}}}},
         {:match, {:var, :y},
          {:cons, {:atm, :c}, {:cons, {:atm, :d}, {:atm, []}}}},
          {:apply, {:fun, :append}, [{:var, :x}, {:var, :y}]}
        ]

    Eager.eval_seq(seq, EnvList.new())


  end

end

local ls = require("luasnip")
local s = ls.snippet
--local sn = ls.snippet_node
--local t = ls.text_node
local i = ls.insert_node
--local f = ls.function_node
--local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
--local fmta = require("luasnip.extras.fmt").fmta
--local rep = require("luasnip.extras").rep 
--local extras = require("luasnip.extras")


-- cpp templates
-- for cp
return {
    s({ trig = "lezzgo", dscr = "cp template" },
        fmt([[
        #include <bits/stdc++.h>
        using namespace std;

        typedef long long ll;
        #define pb push_back 
        const int mod = 1e9+7;

        void space() {{
            {}

        }}

        int main() {{
            ios::sync_with_stdio(false);
            cin.tie(nullptr);

            int t = 1;
            cin >> t;

            while (t--) {{
                space();
                cout << '\n';
            }}
            return 0;
        }}
        ]], {i(0)}
        )
    ),

    s({ trig = "sieve", dscr = "sieve of primes" },
        fmt([[
        int MAXN = 1e7+1;
        vector<bool> primes(MAXN+1, true);
        primes[0] = 0; primes[1] = 0;

        for (int i = 2; i*i <= MAXN; i++) {{
	        if (primes[i]) {{ //prime found
		        for (int j=i*i; j<=MAXN; j+=i) primes[j] = false;
            }}
	    }}
        ]], {})
    ),

    s({ trig = "usaco", dscr = "usaco template" },
        fmt([[
        #include <bits/stdc++.h>
        using namespace std;

        typedef long long ll;
        #define pb push_back
    
        void setIO(string name = "") {{
            ios_base::sync_with_stdio(0);
            cin.tie(0);
            if (name.size()) {{
                freopen((name + ".in").c_str(), "r", stdin);
                freopen((name + ".out").c_str(), "w", stdout);
            }}
        }}
        
        int main() {{
            ios::sync_with_stdio(0);
            cin.tie(0); cout.tie(0);
        
            setIO("filename");
        
            {}

        
            return 0;
        }}
        ]], {i(0)}
        )
    ),

    s({ trig = "simple", dscr = "default cpp template" },
        fmt([[

        #include <bits/stdc++.h>
        using namespace std;

        typedef long long ll;
        #define pb push_back
        const int mod = 1e9+7;
        
        int main() {{
            ios::sync_with_stdio(false);
            cin.tie(nullptr);

            {}

            return 0;
        }}
        ]], { i(0) }
        )
    ),
}

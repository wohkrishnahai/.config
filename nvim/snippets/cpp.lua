---@diagnostic disable: undefined-global

return {
-- for CP 
  s({ trig = "lezzgo", snippetType = "autosnippet", dscr = "cp template" },
    fmt([[
	#include <bits/stdc++.h>
	using namespace std;

	#define int long long
	const int N = 1e6+7;
	const int INF = 1e15;
	const int MOD = 1e9+7;
 
	// vector<int> adj[N];
	// vector<bool> vis(N);

	void space() {{
		int {}

	}}

	int32_t main() {{
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

  s({ trig = "sieve", snippetType = "autosnippet", dscr = "sieve of primes" },
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

  s({ trig = "usaco", snippetType = "autosnippet", dscr = "usaco template" },
      fmt([[
      #include <bits/stdc++.h>
      using namespace std;

      typedef long long ll;
      #define pb push_back
  
      void setIO(string name) {{
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

  s({ trig = "simple", snippetType = "autosnippet", dscr = "default cpp template" },
      fmt([[

      #include <bits/stdc++.h>
      using namespace std;

      int main() {{
          {}

          return 0;
      }}
      ]], { i(0) }
      )
  ),
}

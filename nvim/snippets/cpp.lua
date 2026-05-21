---@diagnostic disable: undefined-global

return {
-- for CP 
  s({trig = "lezzgo", snippetType = "autosnippet", dscr = "cp template"},
    fmt([[
#include <bits/stdc++.h>
using namespace std;
#define int long long

void space() {{
  int n{};
  cin >> n;

  vector<int> arr(n);
  for (int &x : arr) cin >> x;


  

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

  s({trig = "usaco", snippetType = "autosnippet", dscr = "usaco template"},
    fmt([[
#include <bits/stdc++.h>
using namespace std;
typedef long long ll; 

void setIO(string name) {{
  if (name.size()) {{
    freopen((name + ".in").c_str(), "r", stdin);
    freopen((name + ".out").c_str(), "w", stdout);
  }}
}}

int main() {{
  ios::sync_with_stdio(0);
  cin.tie(0);

  setIO("filename");
  
  {}
  

  return 0;
}}
]], {i(0)}
    )
  ),
}

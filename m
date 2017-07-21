From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH v2] cpufreq: s5pv210: add missing of_node_put
Date: Fri, 21 Jul 2017 21:53:30 +0200
Message-ID: <1500666810-21841-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

for_each_compatible_node performs an of_node_get on each iteration, so a
return from the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
local idexpression n;
expression e,e1,e2;
statement S;
iterator i1;
iterator name for_each_compatible_node;
@@

 for_each_compatible_node(n,e1,e2) {
   ...
(
   of_node_put(n);
|
   e = n
|
   return n;
|
   i1(...,n,...) S
|
+  of_node_put(n);
?  return ...;
)
   ...
 }
// </smpl>

Additionally, call of_node_put on the previous value of np, obtained from
of_find_compatible_node, that is no longer accessible at the point of the
for_each_compatible_node.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v2: add the of_node_put for the call to of_find_compatible_node as well.

 drivers/cpufreq/s5pv210-cpufreq.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index f82074e..5d31c2d 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -602,6 +602,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	clk_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!clk_base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
 		return -EFAULT;
@@ -612,6 +613,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
 			pr_err("%s: failed to get alias of dmc node '%s'\n",
 				__func__, np->name);
+			of_node_put(np);
 			return id;
 		}
 
@@ -619,6 +621,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 		if (!dmc_base[id]) {
 			pr_err("%s: failed to map dmc%d registers\n",
 				__func__, id);
+			of_node_put(np);
 			return -EFAULT;
 		}
 	}

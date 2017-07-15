From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] cpufreq: s5pv210: add missing of_node_put
Date: Sat, 15 Jul 2017 21:40:53 +0200
Message-ID: <1500147653-31229-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:59820
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751244AbdGOUF6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 Jul 2017 16:05:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: kernel-janitors@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

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

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/cpufreq/s5pv210-cpufreq.c |    2 ++
 1 file changed, 2 insertions(+)

diff -u -p a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -612,6 +612,7 @@ static int s5pv210_cpufreq_probe(struct
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
 			pr_err("%s: failed to get alias of dmc node '%s'\n",
 				__func__, np->name);
+			of_node_put(np);
 			return id;
 		}
 
@@ -619,6 +620,7 @@ static int s5pv210_cpufreq_probe(struct
 		if (!dmc_base[id]) {
 			pr_err("%s: failed to map dmc%d registers\n",
 				__func__, id);
+			of_node_put(np);
 			return -EFAULT;
 		}
 	}

From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 01/12] drivers: base: cacheinfo: move cache_setup_of_node()
Date: Fri, 12 Jan 2018 18:59:09 -0600
Message-ID: <20180113005920.28658-2-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180113005920.28658-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org, lenb@kernel.org, vkilari@codeaurora.org, morten.rasmussen@arm.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

In preparation for the next patch, and to aid in
review of that patch, lets move cache_setup_of_node
farther down in the module without any changes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/base/cacheinfo.c | 80 ++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 07532d83be0b..a883a213fcd5 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -43,46 +43,6 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 }
 
 #ifdef CONFIG_OF
-static int cache_setup_of_node(unsigned int cpu)
-{
-	struct device_node *np;
-	struct cacheinfo *this_leaf;
-	struct device *cpu_dev = get_cpu_device(cpu);
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	unsigned int index = 0;
-
-	/* skip if of_node is already populated */
-	if (this_cpu_ci->info_list->of_node)
-		return 0;
-
-	if (!cpu_dev) {
-		pr_err("No cpu device for CPU %d\n", cpu);
-		return -ENODEV;
-	}
-	np = cpu_dev->of_node;
-	if (!np) {
-		pr_err("Failed to find cpu%d device node\n", cpu);
-		return -ENOENT;
-	}
-
-	while (index < cache_leaves(cpu)) {
-		this_leaf = this_cpu_ci->info_list + index;
-		if (this_leaf->level != 1)
-			np = of_find_next_cache_node(np);
-		else
-			np = of_node_get(np);/* cpu node itself */
-		if (!np)
-			break;
-		this_leaf->of_node = np;
-		index++;
-	}
-
-	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
-		return -ENOENT;
-
-	return 0;
-}
-
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
@@ -213,6 +173,46 @@ static void cache_of_override_properties(unsigned int cpu)
 		cache_associativity(this_leaf);
 	}
 }
+
+static int cache_setup_of_node(unsigned int cpu)
+{
+	struct device_node *np;
+	struct cacheinfo *this_leaf;
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	unsigned int index = 0;
+
+	/* skip if of_node is already populated */
+	if (this_cpu_ci->info_list->of_node)
+		return 0;
+
+	if (!cpu_dev) {
+		pr_err("No cpu device for CPU %d\n", cpu);
+		return -ENODEV;
+	}
+	np = cpu_dev->of_node;
+	if (!np) {
+		pr_err("Failed to find cpu%d device node\n", cpu);
+		return -ENOENT;
+	}
+
+	while (index < cache_leaves(cpu)) {
+		this_leaf = this_cpu_ci->info_list + index;
+		if (this_leaf->level != 1)
+			np = of_find_next_cache_node(np);
+		else
+			np = of_node_get(np);/* cpu node itself */
+		if (!np)
+			break;
+		this_leaf->of_node = np;
+		index++;
+	}
+
+	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
+		return -ENOENT;
+
+	return 0;
+}
 #else
 static void cache_of_override_properties(unsigned int cpu) { }
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
-- 
2.13.5

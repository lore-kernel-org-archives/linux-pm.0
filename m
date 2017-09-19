From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 3/6] drivers: base: cacheinfo: arm64: Add support for ACPI based firmware tables
Date: Tue, 19 Sep 2017 13:47:48 -0500
Message-ID: <20170919184751.25110-4-jeremy.linton@arm.com>
References: <20170919184751.25110-1-jeremy.linton@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919184751.25110-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@codeaurora.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jeremy Linton <jeremy.linton@arm.com>
List-Id: linux-pm@vger.kernel.org

The /sys cache entries should support ACPI/PPTT generated cache
topology information. Lets detect ACPI systems and call
an arch specific cache_setup_acpi() routine to update the hardware
probed cache topology.

For arm64, if ACPI is enabled, determine the max number of cache
levels and populate them using a PPTT table if one is available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cacheinfo.c | 23 ++++++++++++++++++-----
 drivers/acpi/pptt.c           |  1 +
 drivers/base/cacheinfo.c      | 17 +++++++++++------
 include/linux/cacheinfo.h     | 10 ++++++++--
 4 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 380f2e2fbed5..2e2cf0d312ba 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/cacheinfo.h>
 #include <linux/of.h>
 
@@ -44,9 +45,17 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+#ifndef CONFIG_ACPI
+int acpi_find_last_cache_level(unsigned int cpu)
+{
+	/*ACPI kernels should be built with PPTT support*/
+	return 0;
+}
+#endif
+
 static int __init_cache_level(unsigned int cpu)
 {
-	unsigned int ctype, level, leaves, of_level;
+	unsigned int ctype, level, leaves, fw_level;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -59,15 +68,19 @@ static int __init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
-	of_level = of_find_last_cache_level(cpu);
-	if (level < of_level) {
+	if (acpi_disabled)
+		fw_level = of_find_last_cache_level(cpu);
+	else
+		fw_level = acpi_find_last_cache_level(cpu);
+
+	if (level < fw_level) {
 		/*
 		 * some external caches not specified in CLIDR_EL1
 		 * the information may be available in the device tree
 		 * only unified external caches are considered here
 		 */
-		leaves += (of_level - level);
-		level = of_level;
+		leaves += (fw_level - level);
+		level = fw_level;
 	}
 
 	this_cpu_ci->num_levels = level;
diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f7694fa1e0bd..0dd918c3782c 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -331,6 +331,7 @@ static void update_cache_properties(struct cacheinfo *this_leaf,
 				    struct acpi_pptt_cache *found_cache,
 				    struct acpi_pptt_processor *cpu_node)
 {
+	this_leaf->firmware_node = found_cache;
 	if (found_cache->flags & ACPI_PPTT_SIZE_PROPERTY_VALID)
 		this_leaf->size = found_cache->size;
 	if (found_cache->flags & ACPI_PPTT_LINE_SIZE_VALID)
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index eb3af2739537..8eca279e50d1 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -86,7 +86,7 @@ static int cache_setup_of_node(unsigned int cpu)
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
-	return sib_leaf->of_node == this_leaf->of_node;
+	return sib_leaf->firmware_node == this_leaf->firmware_node;
 }
 
 /* OF properties to query for a given cache type */
@@ -215,6 +215,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 }
 #endif
 
+int __weak cache_setup_acpi(unsigned int cpu)
+{
+	return -ENOTSUPP;
+}
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -225,11 +230,11 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	if (this_cpu_ci->cpu_map_populated)
 		return 0;
 
-	if (of_have_populated_dt())
+	if (!acpi_disabled)
+		ret = cache_setup_acpi(cpu);
+	else if (of_have_populated_dt())
 		ret = cache_setup_of_node(cpu);
-	else if (!acpi_disabled)
-		/* No cache property/hierarchy support yet in ACPI */
-		ret = -ENOTSUPP;
+
 	if (ret)
 		return ret;
 
@@ -286,7 +291,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 static void cache_override_properties(unsigned int cpu)
 {
-	if (of_have_populated_dt())
+	if (acpi_disabled && of_have_populated_dt())
 		return cache_of_override_properties(cpu);
 }
 
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 6a524bf6a06d..0114eb9ab67b 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -36,6 +36,9 @@ enum cache_type {
  * @of_node: if devicetree is used, this represents either the cpu node in
  *	case there's no explicit cache node or the cache node itself in the
  *	device tree
+ * @firmware_node: Shared with of_node. When not using DT, this may contain
+ *	pointers to other firmware based values. Particularly ACPI/PPTT
+ *	unique values.
  * @disable_sysfs: indicates whether this node is visible to the user via
  *	sysfs or not
  * @priv: pointer to any private data structure specific to particular
@@ -64,8 +67,10 @@ struct cacheinfo {
 #define CACHE_ALLOCATE_POLICY_MASK	\
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
-
-	struct device_node *of_node;
+	union {
+		struct device_node *of_node;
+		void *firmware_node;
+	};
 	bool disable_sysfs;
 	void *priv;
 };
@@ -98,6 +103,7 @@ int func(unsigned int cpu)					\
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+int acpi_find_last_cache_level(unsigned int cpu);
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-- 
2.13.5

From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 02/12] drivers: base: cacheinfo: setup DT cache properties
 early
Date: Fri, 12 Jan 2018 18:59:10 -0600
Message-ID: <20180113005920.28658-3-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180113005920.28658-1-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, austinwc@codeaurora.org, catalin.marinas@arm.com, Palmer Dabbelt <palmer@sifive.com>, will.deacon@arm.com, morten.rasmussen@arm.com, vkilari@codeaurora.org, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, viresh.kumar@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, hanjun.guo@linaro.org, Albert Ou <albert@sifive.com>, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

The original intent in cacheinfo was that an architecture
specific populate_cache_leaves() would probe the hardware
and then cache_shared_cpu_map_setup() and
cache_override_properties() would provide firmware help to
extend/expand upon what was probed. Arm64 was really
the only architecture that was working this way, and
with the removal of most of the hardware probing logic it
became clear that it was possible to simplify the logic a bit.

This patch combines the walk of the DT nodes with the
code updating the cache size/line_size and nr_sets.
cache_override_properties() (which was DT specific) is
then removed. The result is that cacheinfo.of_node is
no longer used as a temporary place to hold DT references
for future calls that update cache properties. That change
helps to clarify its one remaining use (matching
cacheinfo nodes that represent shared caches) which
will be used by the ACPI/PPTT code in the following patches.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/riscv/kernel/cacheinfo.c |  1 +
 drivers/base/cacheinfo.c      | 65 +++++++++++++++++++------------------------
 include/linux/cacheinfo.h     |  1 +
 3 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 10ed2749e246..6f4500233cf8 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -30,6 +30,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 		CACHE_WRITE_BACK
 		| CACHE_READ_ALLOCATE
 		| CACHE_WRITE_ALLOCATE;
+	cache_of_set_props(this_leaf, node);
 }
 
 static int __init_cache_level(unsigned int cpu)
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a883a213fcd5..fc0d42bbd9eb 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -43,6 +43,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 }
 
 #ifdef CONFIG_OF
+
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
@@ -82,7 +83,7 @@ static inline int get_cacheinfo_idx(enum cache_type type)
 	return type;
 }
 
-static void cache_size(struct cacheinfo *this_leaf)
+static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
 {
 	const char *propname;
 	const __be32 *cache_size;
@@ -91,13 +92,14 @@ static void cache_size(struct cacheinfo *this_leaf)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].size_prop;
 
-	cache_size = of_get_property(this_leaf->of_node, propname, NULL);
+	cache_size = of_get_property(np, propname, NULL);
 	if (cache_size)
 		this_leaf->size = of_read_number(cache_size, 1);
 }
 
 /* not cache_line_size() because that's a macro in include/linux/cache.h */
-static void cache_get_line_size(struct cacheinfo *this_leaf)
+static void cache_get_line_size(struct cacheinfo *this_leaf,
+				struct device_node *np)
 {
 	const __be32 *line_size;
 	int i, lim, ct_idx;
@@ -109,7 +111,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf)
 		const char *propname;
 
 		propname = cache_type_info[ct_idx].line_size_props[i];
-		line_size = of_get_property(this_leaf->of_node, propname, NULL);
+		line_size = of_get_property(np, propname, NULL);
 		if (line_size)
 			break;
 	}
@@ -118,7 +120,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf)
 		this_leaf->coherency_line_size = of_read_number(line_size, 1);
 }
 
-static void cache_nr_sets(struct cacheinfo *this_leaf)
+static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
 {
 	const char *propname;
 	const __be32 *nr_sets;
@@ -127,7 +129,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf)
 	ct_idx = get_cacheinfo_idx(this_leaf->type);
 	propname = cache_type_info[ct_idx].nr_sets_prop;
 
-	nr_sets = of_get_property(this_leaf->of_node, propname, NULL);
+	nr_sets = of_get_property(np, propname, NULL);
 	if (nr_sets)
 		this_leaf->number_of_sets = of_read_number(nr_sets, 1);
 }
@@ -146,32 +148,26 @@ static void cache_associativity(struct cacheinfo *this_leaf)
 		this_leaf->ways_of_associativity = (size / nr_sets) / line_size;
 }
 
-static bool cache_node_is_unified(struct cacheinfo *this_leaf)
+static bool cache_node_is_unified(struct cacheinfo *this_leaf,
+				  struct device_node *np)
 {
-	return of_property_read_bool(this_leaf->of_node, "cache-unified");
+	return of_property_read_bool(np, "cache-unified");
 }
 
-static void cache_of_override_properties(unsigned int cpu)
+void cache_of_set_props(struct cacheinfo *this_leaf, struct device_node *np)
 {
-	int index;
-	struct cacheinfo *this_leaf;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	for (index = 0; index < cache_leaves(cpu); index++) {
-		this_leaf = this_cpu_ci->info_list + index;
-		/*
-		 * init_cache_level must setup the cache level correctly
-		 * overriding the architecturally specified levels, so
-		 * if type is NONE at this stage, it should be unified
-		 */
-		if (this_leaf->type == CACHE_TYPE_NOCACHE &&
-		    cache_node_is_unified(this_leaf))
-			this_leaf->type = CACHE_TYPE_UNIFIED;
-		cache_size(this_leaf);
-		cache_get_line_size(this_leaf);
-		cache_nr_sets(this_leaf);
-		cache_associativity(this_leaf);
-	}
+	/*
+	 * init_cache_level must setup the cache level correctly
+	 * overriding the architecturally specified levels, so
+	 * if type is NONE at this stage, it should be unified
+	 */
+	if (this_leaf->type == CACHE_TYPE_NOCACHE &&
+	    cache_node_is_unified(this_leaf, np))
+		this_leaf->type = CACHE_TYPE_UNIFIED;
+	cache_size(this_leaf, np);
+	cache_get_line_size(this_leaf, np);
+	cache_nr_sets(this_leaf, np);
+	cache_associativity(this_leaf);
 }
 
 static int cache_setup_of_node(unsigned int cpu)
@@ -204,6 +200,7 @@ static int cache_setup_of_node(unsigned int cpu)
 			np = of_node_get(np);/* cpu node itself */
 		if (!np)
 			break;
+		cache_of_set_props(this_leaf, np);
 		this_leaf->of_node = np;
 		index++;
 	}
@@ -214,7 +211,6 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 #else
-static void cache_of_override_properties(unsigned int cpu) { }
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
@@ -297,12 +293,6 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 	}
 }
 
-static void cache_override_properties(unsigned int cpu)
-{
-	if (of_have_populated_dt())
-		return cache_of_override_properties(cpu);
-}
-
 static void free_cache_attributes(unsigned int cpu)
 {
 	if (!per_cpu_cacheinfo(cpu))
@@ -336,6 +326,10 @@ static int detect_cache_attributes(unsigned int cpu)
 	if (per_cpu_cacheinfo(cpu) == NULL)
 		return -ENOMEM;
 
+	/*
+	 * populate_cache_leaves() may completely setup the cache leaves and
+	 * shared_cpu_map or it may leave it partially setup.
+	 */
 	ret = populate_cache_leaves(cpu);
 	if (ret)
 		goto free_ci;
@@ -349,7 +343,6 @@ static int detect_cache_attributes(unsigned int cpu)
 		goto free_ci;
 	}
 
-	cache_override_properties(cpu);
 	return 0;
 
 free_ci:
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 3d9805297cda..d35299a590a4 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -99,6 +99,7 @@ int func(unsigned int cpu)					\
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+void cache_of_set_props(struct cacheinfo *this_leaf, struct device_node *np);
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-- 
2.13.5

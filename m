From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 03/12] cacheinfo: rename of_node to fw_unique
Date: Fri, 12 Jan 2018 18:59:11 -0600
Message-ID: <20180113005920.28658-4-jeremy.linton@arm.com>
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

Rename and change the type of of_node to indicate
it is a generic pointer which is generally only used
for comparison purposes. In a later patch we will apply
an ACPI/PPTT "token" pointer in fw_unique so that
the code which builds the shared cpu masks can be reused.

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <albert@sifive.com>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/riscv/kernel/cacheinfo.c |  2 +-
 drivers/base/cacheinfo.c      | 16 +++++++++-------
 include/linux/cacheinfo.h     |  8 +++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 6f4500233cf8..6b0219af88d4 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -20,7 +20,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 			 struct device_node *node,
 			 enum cache_type type, unsigned int level)
 {
-	this_leaf->of_node = node;
+	this_leaf->fw_unique = node;
 	this_leaf->level = level;
 	this_leaf->type = type;
 	/* not a sector cache */
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index fc0d42bbd9eb..217aa90fb036 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -47,7 +47,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
-	return sib_leaf->of_node == this_leaf->of_node;
+	return sib_leaf->fw_unique == this_leaf->fw_unique;
 }
 
 /* OF properties to query for a given cache type */
@@ -178,9 +178,10 @@ static int cache_setup_of_node(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int index = 0;
 
-	/* skip if of_node is already populated */
-	if (this_cpu_ci->info_list->of_node)
+	/* skip if fw_unique is already populated */
+	if (this_cpu_ci->info_list->fw_unique) {
 		return 0;
+	}
 
 	if (!cpu_dev) {
 		pr_err("No cpu device for CPU %d\n", cpu);
@@ -201,7 +202,7 @@ static int cache_setup_of_node(unsigned int cpu)
 		if (!np)
 			break;
 		cache_of_set_props(this_leaf, np);
-		this_leaf->of_node = np;
+		this_leaf->fw_unique = np;
 		index++;
 	}
 
@@ -289,7 +290,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
 		}
-		of_node_put(this_leaf->of_node);
+		of_node_put(this_leaf->fw_unique);
 	}
 }
 
@@ -334,8 +335,9 @@ static int detect_cache_attributes(unsigned int cpu)
 	if (ret)
 		goto free_ci;
 	/*
-	 * For systems using DT for cache hierarchy, of_node and shared_cpu_map
-	 * will be set up here only if they are not populated already
+	 * For systems using DT for cache hierarchy, fw_unique
+	 * and shared_cpu_map will be set up here only if they are
+	 * not populated already
 	 */
 	ret = cache_shared_cpu_map_setup(cpu);
 	if (ret) {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index d35299a590a4..6f2e6c87b64c 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -34,9 +34,8 @@ enum cache_type {
  * @shared_cpu_map: logical cpumask representing all the cpus sharing
  *	this cache node
  * @attributes: bitfield representing various cache attributes
- * @of_node: if devicetree is used, this represents either the cpu node in
- *	case there's no explicit cache node or the cache node itself in the
- *	device tree
+ * @fw_unique: Unique value used to determine if different cacheinfo
+ *	structures represent a single hardware cache instance.
  * @disable_sysfs: indicates whether this node is visible to the user via
  *	sysfs or not
  * @priv: pointer to any private data structure specific to particular
@@ -65,8 +64,7 @@ struct cacheinfo {
 #define CACHE_ALLOCATE_POLICY_MASK	\
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
-
-	struct device_node *of_node;
+	void *fw_unique;
 	bool disable_sysfs;
 	void *priv;
 };
-- 
2.13.5

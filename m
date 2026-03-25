Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5474413229;
	Wed, 25 Mar 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462418; cv=none; b=GunozODvv1VlyBhdVnclVUxzhdVhvUfomWk/8dXToFVuw9oamBaSWoZbIBmUXziQTdEg6cCYYO3FPACkzqvbLI/WuwvurxE2f1LlirHxVs9vdvRi/zqYmyIi+ENVpjVDHNETPK4501tTNywEgTF4fCpnIdaGOBs6lf6s3svgKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462418; c=relaxed/simple;
	bh=JZdNYTj3ClIfmM7jwXm7/67ZP/xpRyybvZIV/gfcCeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7OfidUx8QA2or4/39ViHzWcdDcK3EeiSOe8gAWtwjLfODygXxlnAkkrY3yaBk1A97P479IwdEGc/DA22zfDHXPo3r8Qsw4qwg1y+KnUPaY2s+9bWSvzxnVbDaaRyX/gQyAXQYT8I98XB/DbAl+w9Tx7OL/O7YkOH5v4Xkly0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gZ6qaL6V; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gZ6qaL6V"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48B912444;
	Wed, 25 Mar 2026 11:13:30 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.83.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A6273F836;
	Wed, 25 Mar 2026 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774462416; bh=JZdNYTj3ClIfmM7jwXm7/67ZP/xpRyybvZIV/gfcCeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZ6qaL6VX7A8HZaR9urc8keQYcxyC246d7h8Tav+yE6203WDpCJTEsExXI88WP7To
	 NS/hnGUNe7nBCb+xykHaKUbK83NT1nIBc/jyW6LAzCApN8g64zNhr2vvu61MCN5DHd
	 i+7/yA011GgZ2dnUiE7PNwpRAmxKdHEXqn8/nvo0=
From: Christian Loehle <christian.loehle@arm.com>
To: arighi@nvidia.com
Cc: peterz@infradead.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	valentin.schneider@arm.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	segall@google.com,
	mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com,
	kobak@nvidia.com,
	fabecassis@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 3/3] arm64/sched: Enable CPPC-based asympacking
Date: Wed, 25 Mar 2026 18:13:14 +0000
Message-Id: <20260325181314.3875909-4-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325181314.3875909-1-christian.loehle@arm.com>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To handle minor capacity differences (<5%) use asym-packing to steer
tasks towards higher performance CPUs, replacing capacity-aware
scheduling in those cases and skip setting SD_ASYM_CPUCAPACITY.
This is implemented by using highest_perf values as priorities to steer
towards.
highest_perf-based asympacking is a global ordering that is applied
at all levels of the hierarchy for now.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 arch/arm64/include/asm/topology.h |  6 ++++++
 arch/arm64/kernel/topology.c      | 34 +++++++++++++++++++++++++++++++
 kernel/sched/topology.c           | 26 ++++++++++++++++-------
 3 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/topology.h b/arch/arm64/include/asm/topology.h
index b9eaf4ad7085..e0b039e1a5bb 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -39,6 +39,12 @@ void update_freq_counters_refs(void);
 #undef arch_cpu_is_threaded
 #define arch_cpu_is_threaded() (read_cpuid_mpidr() & MPIDR_MT_BITMASK)
 
+#undef arch_asym_cpu_priority
+#define arch_asym_cpu_priority arm64_arch_asym_cpu_priority
+#define arch_sched_asym_flags arm64_arch_sched_asym_flags
+extern int arm64_arch_asym_cpu_priority(int cpu);
+extern int arm64_arch_sched_asym_flags(void);
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_ARM_TOPOLOGY_H */
diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index b32f13358fbb..4e3582d44a26 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/sched/isolation.h>
+#include <linux/sched/topology.h>
 #include <linux/xarray.h>
 
 #include <asm/cpu.h>
@@ -373,6 +374,26 @@ core_initcall(init_amu_fie);
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
+static bool __read_mostly sched_cppc_asym_active;
+DEFINE_PER_CPU_READ_MOSTLY(int, sched_cppc_priority);
+
+int arm64_arch_asym_cpu_priority(int cpu)
+{
+	if (!READ_ONCE(sched_cppc_asym_active))
+		return -cpu;
+	return per_cpu(sched_cppc_priority, cpu);
+}
+
+int arm64_arch_sched_asym_flags(void)
+{
+	return READ_ONCE(sched_cppc_asym_active) ? SD_ASYM_PACKING : 0;
+}
+
+void arch_topology_init_cppc_asym(void)
+{
+	WRITE_ONCE(sched_cppc_asym_active, topology_init_cppc_asym_packing(&sched_cppc_priority));
+}
+
 static void cpu_read_corecnt(void *val)
 {
 	/*
@@ -473,4 +494,17 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 {
 	return -EOPNOTSUPP;
 }
+
+#else
+int arm64_arch_asym_cpu_priority(int cpu)
+{
+	return -cpu;
+}
+
+int arm64_arch_sched_asym_flags(void)
+{
+	return 0;
+}
+
+void arch_topology_init_cppc_asym(void) { }
 #endif /* CONFIG_ACPI_CPPC_LIB */
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b0c590dfdb01..758b8796b62d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1396,6 +1396,8 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
 			   const struct cpumask *cpu_map)
 {
 	struct asym_cap_data *entry;
+	unsigned long max_cap = 0, min_cap = ULONG_MAX;
+	bool has_cap = false;
 	int count = 0, miss = 0;
 
 	/*
@@ -1405,9 +1407,12 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
 	 * skip those.
 	 */
 	list_for_each_entry(entry, &asym_cap_list, link) {
-		if (cpumask_intersects(sd_span, cpu_capacity_span(entry)))
+		if (cpumask_intersects(sd_span, cpu_capacity_span(entry))) {
 			++count;
-		else if (cpumask_intersects(cpu_map, cpu_capacity_span(entry)))
+			max_cap = max(max_cap, entry->capacity);
+			min_cap = min(min_cap, entry->capacity);
+			has_cap = true;
+		} else if (cpumask_intersects(cpu_map, cpu_capacity_span(entry)))
 			++miss;
 	}
 
@@ -1419,10 +1424,12 @@ asym_cpu_capacity_classify(const struct cpumask *sd_span,
 	/* Some of the available CPU capacity values have not been detected */
 	if (miss)
 		return SD_ASYM_CPUCAPACITY;
+	/* When asym packing is active, ignore small capacity differences. */
+	if (arch_sched_asym_flags() && has_cap && !capacity_greater(max_cap, min_cap))
+		return 0;
 
 	/* Full asymmetry */
 	return SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
-
 }
 
 static void free_asym_cap_entry(struct rcu_head *head)
@@ -1753,7 +1760,7 @@ static inline int topology_arch_sched_asym_flags(void)
 #ifdef CONFIG_SCHED_SMT
 int cpu_smt_flags(void)
 {
-	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
+	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC | arch_sched_asym_flags();
 }
 
 const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
@@ -1765,7 +1772,7 @@ const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cp
 #ifdef CONFIG_SCHED_CLUSTER
 int cpu_cluster_flags(void)
 {
-	return SD_CLUSTER | SD_SHARE_LLC;
+	return SD_CLUSTER | SD_SHARE_LLC | arch_sched_asym_flags();
 }
 
 const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
@@ -1777,7 +1784,7 @@ const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cp
 #ifdef CONFIG_SCHED_MC
 int cpu_core_flags(void)
 {
-	return SD_SHARE_LLC;
+	return SD_SHARE_LLC | arch_sched_asym_flags();
 }
 
 const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
@@ -1791,6 +1798,11 @@ const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cp
 	return cpu_node_mask(cpu);
 }
 
+static int cpu_pkg_flags(void)
+{
+	return arch_sched_asym_flags();
+}
+
 /*
  * Topology list, bottom-up.
  */
@@ -1806,7 +1818,7 @@ static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_MC
 	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
 #endif
-	SDTL_INIT(tl_pkg_mask, NULL, PKG),
+	SDTL_INIT(tl_pkg_mask, cpu_pkg_flags, PKG),
 	{ NULL, },
 };
 
-- 
2.34.1


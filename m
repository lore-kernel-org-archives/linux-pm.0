Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB73FEB14;
	Wed, 25 Mar 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462411; cv=none; b=f9QEdnYzYlzKWeYTyJI/lk3umpgIh9zHUdtHufvVB2SG+A2bPa6miCSrSlcKc+yBWSP30OfYVH0dNjjR/OWbIwtnmHT6eMdBTBCUYVb0YkndSgZXmi1hYPlaA0MRaQNi7belN/8/r0VSWIpE13D99rI2heZkLP9QRImKut5slRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462411; c=relaxed/simple;
	bh=7rAu1Vlezsh+1smfwJBrEKWoCgYi3QO4tfK0hK5YCvc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tth+Zy2wfwes3I1sidIiX4RrU1nj2rxlxLAY/k50oTSfKnbRsy16cs/A7vspXrabdOMytGRxE0ZEsrF/eInUAPsGhVPfcjKRKgmzT8kDiQ4HV95YZCgH20+ZFODch/JSigKIIdiHDyIaPAgCkLRJnplqmwF5Vjb0WdA6zqlaskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B8OUxUMO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B8OUxUMO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D2012444;
	Wed, 25 Mar 2026 11:13:23 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.83.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 832C03F836;
	Wed, 25 Mar 2026 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774462409; bh=7rAu1Vlezsh+1smfwJBrEKWoCgYi3QO4tfK0hK5YCvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B8OUxUMOBKL8wTraYBWh223RIv2ln1WDkNbo6jIcWhv9dOo/EWvg6qczTrz7xmk3n
	 u80a4FGcPRx592G+Q5b1NZUHTqPrkFfptwC1mZo1afjW75EkrdNEGdKdETahQIpPL8
	 PMgZsMk/sXyCJKpo8cat1DfR6exC6H6ohuTkn/u8=
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
Subject: [PATCH 1/3] sched/topology: Introduce arch hooks for asympacking
Date: Wed, 25 Mar 2026 18:13:12 +0000
Message-Id: <20260325181314.3875909-2-christian.loehle@arm.com>
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

Prepare for arch-specifc asympacking logic.

No functional impact intended.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 include/linux/arch_topology.h  | 24 ++++++++++++++++++++++++
 include/linux/sched/topology.h |  9 +++++++++
 kernel/sched/fair.c            | 16 ----------------
 kernel/sched/topology.c        |  8 ++++++++
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index ebd7f8935f96..3ab571b287ef 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -94,6 +94,11 @@ void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
 void freq_inv_set_max_ratio(int cpu, u64 max_rate);
+void arch_topology_init_cppc_asym(void);
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+bool topology_init_cppc_asym_packing(int __percpu *priority_var);
+#endif
 
 /*
  * Architectures like ARM64 don't have reliable architectural way to get SMT
@@ -105,10 +110,29 @@ static inline bool topology_core_has_smt(int cpu)
 	return cpu_topology[cpu].thread_id != -1;
 }
 
+#ifdef CONFIG_ARM64
+#undef arch_sched_asym_flags
+#define arch_sched_asym_flags arm64_arch_sched_asym_flags
+int arm64_arch_asym_cpu_priority(int cpu);
+int arm64_arch_sched_asym_flags(void);
+#endif
+
 #else
 
 static inline bool topology_core_has_smt(int cpu) { return false; }
 
 #endif /* CONFIG_GENERIC_ARCH_TOPOLOGY */
 
+/*
+ * Architectures may override this to provide a custom CPU priority for
+ * asymmetric packing.
+ */
+#ifndef arch_asym_cpu_priority
+#define arch_asym_cpu_priority topology_arch_asym_cpu_priority
+static inline int topology_arch_asym_cpu_priority(int cpu)
+{
+	return -cpu;
+}
+#endif
+
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 45c0022b91ce..48cfa89df0fc 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -50,6 +50,15 @@ extern const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl,
 extern const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu);
 
 extern int arch_asym_cpu_priority(int cpu);
+extern int arch_sched_asym_flags(void);
+
+/*
+ * The margin used when comparing CPU capacities.
+ * is 'cap1' noticeably greater than 'cap2'
+ *
+ * (default: ~5%)
+ */
+#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
 
 struct sched_domain_attr {
 	int relax_domain_level;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bf948db905ed..c5f8aa3ad535 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -88,14 +88,6 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
-/*
- * For asym packing, by default the lower numbered CPU has higher priority.
- */
-int __weak arch_asym_cpu_priority(int cpu)
-{
-	return -cpu;
-}
-
 /*
  * The margin used when comparing utilization with CPU capacity.
  *
@@ -103,14 +95,6 @@ int __weak arch_asym_cpu_priority(int cpu)
  */
 #define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
 
-/*
- * The margin used when comparing CPU capacities.
- * is 'cap1' noticeably greater than 'cap2'
- *
- * (default: ~5%)
- */
-#define capacity_greater(cap1, cap2) ((cap1) * 1024 > (cap2) * 1078)
-
 #ifdef CONFIG_CFS_BANDWIDTH
 /*
  * Amount of runtime to allocate from global (tg) to local (per-cfs_rq) pool
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 32dcddaead82..b0c590dfdb01 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1742,6 +1742,14 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
 
+#ifndef arch_sched_asym_flags
+#define arch_sched_asym_flags topology_arch_sched_asym_flags
+static inline int topology_arch_sched_asym_flags(void)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SCHED_SMT
 int cpu_smt_flags(void)
 {
-- 
2.34.1


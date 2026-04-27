Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61A3793A5;
	Mon, 27 Apr 2026 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262133; cv=none; b=GHP3H56lkiGCdkP/r1MAXTTAQiLU8vb3gJ/OZihcO0LUJPdb1Gu6DxtuZ9tBgIMDL5OAkYyjFW/Bfa1nTRY06e1COeKnbg6f34dpL+pMvOpmpJOucTeEl0vLBxulXMslEC52EW439DvhV5hseNTLOJPiwcGqgEL9B2HOq94cyrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262133; c=relaxed/simple;
	bh=jm9601ye/dak73z5yWA7GFyDX/m2IXHFBny0wAWJZu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8/wPtVA2cf9w013qJ1lSboSfOsowhw4D2gbJ5LAABzQ4aTh4r1+7U/j6tfb/Gz91R6nsoj4q8S3IfldcEM2e4z2mdLAgKBCthOWsKWEneG55Qwj+PJZDNdADbrt+2/8pyFwMub4qHKbKNKQKxuK0Ym3N3L+kOAeASX8EzCJyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjRgDbDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjRgDbDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FFAC2BCB8;
	Mon, 27 Apr 2026 03:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262133;
	bh=jm9601ye/dak73z5yWA7GFyDX/m2IXHFBny0wAWJZu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjRgDbDyMUyQnsNOmOTUuUdYHy2Zq6ur4v3WnWWgsBToPp8NqQjrOwWUm4m6b131x
	 +PXY+8rHboFquUVmV9j6WfHKA0t3dIpwRxZuFrZeXVaLzo7jXCnv+Xm4C+22s2+cVG
	 DLNFsWuOhNwBIOrZ/YeXsgGIqrnvRr+d++HGGg9tcv1EPCk0IT9XtXYlOjHOBBTiid
	 Kh7FqPLKbs3UU8cDBixaU0DXYrbNbVpiD1rxsWS6gZB1DfOXYkdP95PiUz3Ro0L3FW
	 YOInKtDgriQ8hUsuBjgActPbmA6JNqUWFXBw7Ga8XTpBralJtuhjBXtQRb0TPxIDWk
	 pGAUrb/zsY9lw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 4/6] ACPI: CPPC: Refactor boost ratio handling
Date: Sun, 26 Apr 2026 22:55:18 -0500
Message-ID: <20260427035520.1427080-5-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035520.1427080-1-superm1@kernel.org>
References: <20260427035520.1427080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
to better reflect that it returns the effective highest performance value
for a CPU, accounting for preferred cores and heterogeneous topologies.

Add a new helper amd_get_boost_ratio() for doing both for boost
ratio calculations and update callers to use it.

This refactoring is needed because on some AMD systems (Zen6+),
the boost ratio should be calculated from frequency values rather than
performance values.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 arch/x86/kernel/acpi/cppc.c    | 122 ++++++++++++++++++---------------
 drivers/cpufreq/acpi-cpufreq.c |   5 +-
 drivers/cpufreq/amd-pstate.c   |  12 ++--
 include/acpi/cppc_acpi.h       |   9 ++-
 4 files changed, 86 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index be4c5e9e5ff6f..b581447711079 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -81,31 +81,18 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 
 static void amd_set_max_freq_ratio(void)
 {
-	struct cppc_perf_caps perf_caps;
-	u64 numerator, nominal_perf;
+	u64 numerator, denominator;
 	u64 perf_ratio;
 	int rc;
 
-	rc = cppc_get_perf_caps(0, &perf_caps);
-	if (rc) {
-		pr_debug("Could not retrieve perf counters (%d)\n", rc);
-		return;
-	}
-
-	rc = amd_get_boost_ratio_numerator(0, &numerator);
+	rc = amd_get_boost_ratio(0, &numerator, &denominator);
 	if (rc) {
-		pr_debug("Could not retrieve highest performance (%d)\n", rc);
-		return;
-	}
-	nominal_perf = perf_caps.nominal_perf;
-
-	if (!nominal_perf) {
-		pr_debug("Could not retrieve nominal performance\n");
+		pr_debug("Could not retrieve boost ratio (%d)\n", rc);
 		return;
 	}
 
 	/* midpoint between max_boost and max_P */
-	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, nominal_perf) + SCHED_CAPACITY_SCALE) >> 1;
+	perf_ratio = (div_u64(numerator * SCHED_CAPACITY_SCALE, denominator) + SCHED_CAPACITY_SCALE) >> 1;
 
 	freq_invariance_set_perf_ratio(perf_ratio, false);
 }
@@ -225,21 +212,18 @@ int amd_detect_prefcore(bool *detected)
 EXPORT_SYMBOL_GPL(amd_detect_prefcore);
 
 /**
- * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
- * @cpu: CPU to get numerator for.
- * @numerator: Output variable for numerator.
+ * amd_get_effective_highest_perf: Get the effective highest performance value
+ * @cpu: CPU to get highest performance for.
  *
- * Determine the numerator to use for calculating the boost ratio on
- * a CPU. On systems that support preferred cores, this will be a hardcoded
- * value. On other systems this will the highest performance register value.
+ * Get the effective highest performance value for a CPU, accounting for
+ * preferred cores and heterogeneous topologies. On systems with preferred
+ * cores, this may be a hardcoded value. On heterogeneous systems, this
+ * may be a per-CPU value. On other systems, this is the shared highest
+ * performance value.
  *
- * If booting the system with amd-pstate enabled but preferred cores disabled then
- * the correct boost numerator will be returned to match hardware capabilities
- * even if the preferred cores scheduling hints are not enabled.
- *
- * Return: 0 for success, negative error code otherwise.
+ * Return: Effective highest performance value, or negative error code.
  */
-int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
+int amd_get_effective_highest_perf(unsigned int cpu)
 {
 	enum x86_topology_cpu_type core_type = get_topology_cpu_type(&cpu_data(cpu));
 	bool prefcore;
@@ -247,14 +231,12 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	u32 tmp;
 
 	ret = amd_detect_prefcore(&prefcore);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	/* without preferred cores, return the highest perf register value */
-	if (!prefcore) {
-		*numerator = boost_numerator;
-		return 0;
-	}
+	if (!prefcore)
+		return boost_numerator;
 
 	/*
 	 * For AMD CPUs with Family ID 19H and Model ID range 0x70 to 0x7f,
@@ -264,8 +246,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN4)) {
 		switch (boot_cpu_data.x86_model) {
 		case 0x70 ... 0x7f:
-			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
-			return 0;
+			return CPPC_HIGHEST_PERF_PERFORMANCE;
 		default:
 			break;
 		}
@@ -273,26 +254,59 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 
 	/* detect if running on heterogeneous design */
 	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
-		switch (core_type) {
-		case TOPO_CPU_TYPE_UNKNOWN:
-			pr_warn("Undefined core type found for cpu %d\n", cpu);
-			break;
-		case TOPO_CPU_TYPE_PERFORMANCE:
-			/* use the max scale for performance cores */
-			*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
-			return 0;
-		case TOPO_CPU_TYPE_EFFICIENCY:
-			/* use the highest perf value for efficiency cores */
-			ret = amd_get_highest_perf(cpu, &tmp);
-			if (ret)
-				return ret;
-			*numerator = tmp;
-			return 0;
-		}
+		if (cpu_feature_enabled(X86_FEATURE_ZEN5) &&
+		    core_type == TOPO_CPU_TYPE_PERFORMANCE)
+			return CPPC_HIGHEST_PERF_PERFORMANCE;
+
+		/* Zen 5 efficiency, and Zen 6+ */
+		ret = amd_get_highest_perf(cpu, &tmp);
+		if (ret < 0)
+			return ret;
+
+		return tmp;
+	}
+
+	return CPPC_HIGHEST_PERF_PREFCORE;
+}
+EXPORT_SYMBOL_GPL(amd_get_effective_highest_perf);
+
+/**
+ * amd_get_boost_ratio: Get numerator and denominator for boost ratio
+ * @cpu: CPU to get the boost ratio for.
+ * @numerator: Output variable for numerator.
+ * @denominator: Output variable for denominator.
+ *
+ * Get the numerator and denominator for calculating the boost ratio.
+ *
+ * Return: 0 for success, negative error code otherwise.
+ */
+int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
+{
+	struct cppc_perf_caps perf_caps;
+	int ret;
+
+	ret = cppc_get_perf_caps(cpu, &perf_caps);
+	if (ret)
+		return ret;
+
+	/* Use frequency values if available */
+	if (perf_caps.highest_freq && perf_caps.nominal_freq) {
+		*numerator = perf_caps.highest_freq;
+		*denominator = perf_caps.nominal_freq;
+		return 0;
 	}
 
-	*numerator = CPPC_HIGHEST_PERF_PREFCORE;
+	/* Fall back to performance values */
+	ret = amd_get_effective_highest_perf(cpu);
+	if (ret < 0)
+		return ret;
+
+	*numerator = ret;
+
+	*denominator = perf_caps.nominal_perf;
+	if (!*denominator)
+		return -EINVAL;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_get_boost_ratio_numerator);
+EXPORT_SYMBOL_GPL(amd_get_boost_ratio);
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753b..a1a005b29daba 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -640,12 +640,13 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	}
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		ret = amd_get_boost_ratio_numerator(cpu, &highest_perf);
-		if (ret) {
+		ret = amd_get_effective_highest_perf(cpu);
+		if (ret < 0) {
 			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
 				 cpu, ret);
 			return 0;
 		}
+		highest_perf = ret;
 	} else {
 		highest_perf = perf_caps.highest_perf;
 	}
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 453084c67327f..f5c7cc05220c4 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,10 +476,12 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
+	ret = amd_get_effective_highest_perf(cpudata->cpu);
+	if (ret < 0)
 		return ret;
 
+	numerator = ret;
+
 	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
 	if (ret)
 		return ret;
@@ -520,10 +522,12 @@ static int shmem_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = amd_get_boost_ratio_numerator(cpudata->cpu, &numerator);
-	if (ret)
+	ret = amd_get_effective_highest_perf(cpudata->cpu);
+	if (ret < 0)
 		return ret;
 
+	numerator = ret;
+
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
 	perf.min_limit_perf = cppc_perf.lowest_perf;
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 79f1eef957a45..c25755630f8be 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -193,7 +193,8 @@ extern int cppc_set_auto_sel(int cpu, bool enable);
 extern int cppc_get_perf_limited(int cpu, u64 *perf_limited);
 extern int cppc_set_perf_limited(int cpu, u64 bits_to_clear);
 extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
-extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
+extern int amd_get_effective_highest_perf(unsigned int cpu);
+extern int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator);
 extern int amd_detect_prefcore(bool *detected);
 #else /* !CONFIG_ACPI_CPPC_LIB */
 static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
@@ -300,7 +301,11 @@ static inline int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 {
 	return -ENODEV;
 }
-static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
+static inline int amd_get_effective_highest_perf(unsigned int cpu)
+{
+	return -EOPNOTSUPP;
+}
+static inline int amd_get_boost_ratio(unsigned int cpu, u64 *numerator, u64 *denominator)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.43.0


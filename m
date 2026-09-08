Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA594351C2E;
	Tue,  8 Sep 2026 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841183; cv=none; b=R81TtI65B+toQoDeIlpZOav8Libq3yjm9uW7tRusNkbYMU7d+roe1gmKGgtiUD93CfTYUKSQfVuBP+J+ZV2+h9Uk+Ggj72/zDj1tYLJ3AVwK/k7u1q49NpPdo70jEKBMk9Aww3rE4OlAlLR2Xxy4JwCKc3Zt3Kw9VjQM/i9lXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841183; c=relaxed/simple;
	bh=4EGpw+4NS2YtAY7YoxGWZBkJsbNtVsJZcX5YGO4nDa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2zVEYpFkpyhCenqX8qAuOQsNnSLuh8e/cpE8BkHxyv2miL/6rDJiywIJvh5e8pgy6l3LbYoPa0OLlApoka3OE8pFUqv+N0A3QWJ+yelQ++4loNzZsGYgNkUM5DakkdASaa7mSVP+dqcFyiqlcEd+ZAEd2EArwlY2Gkk8u/v8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbr4OiRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbr4OiRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE341F00A3E;
	Tue,  8 Sep 2026 04:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788841181;
	bh=vKmo73A1z07iImrTwKZJE9KTVXf5sPh6dnxOhpUAZiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zbr4OiRclB4X6We7yyJ1uPWtwt+Yk9YMV6t0rd3uHCElqrnQnHJQLxwOZWDj/+T9L
	 cb88V5y5Ch+LqGtX6jHfioaAkWSwjqSVMSuo06XcwzeSIwLHH5JBH/MC84Vp2MTzpK
	 FAEadJ6KbL9u+f9MN/qSkbR366fymsS80OkjaNt5MLhNH6Kpaq2FnIFM5sMULh2hSv
	 R7JR+EYTHXwKpfEN9HRDN0BsQXKQ4GmNx2fbMFDGSFElKC0greGK4J3JMbBI5M86Zl
	 lGJVIWjpkvf5DX5kEwKnOgz5bd27tqoKMLZJcjlRkuttm2CSuVyYVhTUK6MZxmFEnM
	 hE5Sx5R2AG6Mg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 1/3] cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
Date: Mon,  7 Sep 2026 23:19:33 -0500
Message-ID: <20260908041935.402116-2-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908041935.402116-1-superm1@kernel.org>
References: <20260908041935.402116-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On newer SoCs the behavior of the platform has changed, and using
the same EPP values for everything will yield worse results than expected.

Add a x86_cpu_id match table that allows setting policies on a
per-SoC/per-core type basis.  If a SoC is missing, fallback to legacy
values that are used.

Changes also:
- Change epp_values array and amd_pstate_cpu_epp_values() from unsigned int to u8
- Add static_assert to ensure epp_values has rows for all CPU types
- Fix show_energy_performance_preference() loop to exclude uninitialized
  EPP_INDEX_CUSTOM and EPP_INDEX_DYNAMIC slots
- Add debug print statements
- Remove amd_pstate_get_epp_from_platform_profile and inline the logic
- Fix cleanup path in amd_pstate_set_dynamic_epp
- Change show_energy_performance_preference to use for loop with preference tracking
- Add debug prints in amd_pstate_init_epp_values

Behavioral change: show_energy_performance_preference() now returns a numeric
EPP value via sysfs when the cached EPP does not match any named preference,
instead of returning -EINVAL as before. This provides visibility into custom
EPP values set by hardware or BIOS.

No new platforms are added in this commit.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/amd-pstate.c | 197 ++++++++++++++++++++++++++++-------
 1 file changed, 160 insertions(+), 37 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9325c657d2d49..960db977cc8ca 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -55,10 +55,10 @@
 #define AMD_PSTATE_TRANSITION_DELAY	1000
 #define AMD_PSTATE_FAST_CPPC_TRANSITION_DELAY 600
 
-#define AMD_CPPC_EPP_PERFORMANCE		0x00
-#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
-#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
-#define AMD_CPPC_EPP_POWERSAVE			0xFF
+#define AMD_CPPC_EPP_LEGACY_PERFORMANCE			0x00
+#define AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE		0x80
+#define AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE		0xBF
+#define AMD_CPPC_EPP_LEGACY_POWERSAVE			0xFF
 
 static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_UNDEFINED]   = "undefined",
@@ -129,14 +129,102 @@ static const char * const energy_perf_strings[] = {
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
-static unsigned int epp_values[] = {
-	[EPP_INDEX_DEFAULT] = 0,
-	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
-	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
-	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
-	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
+/*
+ * The numeric EPP value programmed for each named preference. First dimension
+ * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
+ * EFFICIENCY/LOW_POWER for hybrid). The initializer holds the legacy values
+ * used as the fallback on any platform not listed in amd_pstate_epp_soc_ids[];
+ * amd_pstate_init_epp_values() overwrites slots at boot when the running SoC
+ * has a per-SoC (and potentially per-CPU-type) override.
+ */
+static u8 epp_values[][EPP_INDEX_MAX] = {
+	[TOPO_CPU_TYPE_ANY] = {
+		[EPP_INDEX_DEFAULT] = 0,
+		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
+		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
+		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
+		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
+	},
+	[TOPO_CPU_TYPE_PERFORMANCE] = {
+		[EPP_INDEX_DEFAULT] = 0,
+		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
+		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
+		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
+		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
+	},
+	[TOPO_CPU_TYPE_EFFICIENCY] = {
+		[EPP_INDEX_DEFAULT] = 0,
+		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
+		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
+		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
+		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
+	},
+	[TOPO_CPU_TYPE_LOW_POWER] = {
+		[EPP_INDEX_DEFAULT] = 0,
+		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
+		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
+		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
+		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
+	},
+};
+static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
+	      "epp_values must have entries for all CPU types up to TOPO_CPU_TYPE_LOW_POWER");
+
+/*
+ * Get the EPP value row for a given CPU, accounting for hybrid CPU types.
+ * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
+ * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
+ */
+static inline u8 *amd_pstate_cpu_epp_values(int cpu)
+{
+	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
+
+	if (type == TOPO_CPU_TYPE_PERFORMANCE ||
+	    type == TOPO_CPU_TYPE_EFFICIENCY ||
+	    type == TOPO_CPU_TYPE_LOW_POWER)
+		return epp_values[type];
+
+	return epp_values[TOPO_CPU_TYPE_ANY];
+}
+
+/**
+ * struct amd_pstate_epp_values - EPP values for the four named preferences
+ * @performance:	value for the "performance" preference
+ * @balance_performance: value for the "balance_performance" preference
+ * @balance_power:	value for the "balance_power" preference
+ * @power:		value for the "power" preference
+ */
+struct amd_pstate_epp_values {
+	u8 performance;
+	u8 balance_performance;
+	u8 balance_power;
+	u8 power;
+};
+
+/**
+ * struct amd_pstate_epp_soc - per-CPU-type EPP overrides for hybrid systems
+ * @performance_core:	values for TOPO_CPU_TYPE_PERFORMANCE cores
+ * @efficiency_core:	values for TOPO_CPU_TYPE_EFFICIENCY cores
+ * @low_power_core:	values for TOPO_CPU_TYPE_LOW_POWER cores
+ *
+ * Referenced from amd_pstate_epp_soc_ids[] to give a hybrid platform its own
+ * numeric EPP values for the four named preferences, with distinct values per
+ * CPU type. Non-hybrid systems are not listed in the table and always use the
+ * legacy defaults.
+ */
+struct amd_pstate_epp_soc {
+	struct amd_pstate_epp_values performance_core;
+	struct amd_pstate_epp_values efficiency_core;
+	struct amd_pstate_epp_values low_power_core;
+};
+
+/*
+ * Per-CPU-type EPP overrides for hybrid systems. Only hybrid SoCs should be
+ * listed here; non-hybrid systems always use the legacy defaults.
+ */
+static const struct x86_cpu_id amd_pstate_epp_soc_ids[] __initconst = {
+	{}
 };
-static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 2);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -1204,13 +1292,16 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 static int amd_pstate_get_epp_from_platform_profile(struct cpufreq_policy *policy,
 						    enum platform_profile_option profile)
 {
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 *values = amd_pstate_cpu_epp_values(cpudata->cpu);
+
 	switch (profile) {
 	case PLATFORM_PROFILE_PERFORMANCE:
-		return AMD_CPPC_EPP_PERFORMANCE;
+		return values[EPP_INDEX_PERFORMANCE];
 	case PLATFORM_PROFILE_BALANCED:
 		return amd_pstate_get_balanced_epp(policy);
 	case PLATFORM_PROFILE_LOW_POWER:
-		return AMD_CPPC_EPP_POWERSAVE;
+		return values[EPP_INDEX_POWERSAVE];
 	default:
 		break;
 	}
@@ -1420,6 +1511,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 				    const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 *values = amd_pstate_cpu_epp_values(policy->cpu);
 	ssize_t ret;
 	bool raw_epp = false;
 	u8 epp;
@@ -1454,12 +1546,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		}
 
 		if (ret)
-			epp = epp_values[ret];
+			epp = values[ret];
 		else
 			epp = cpudata->epp_default_dc;
 	}
 
-	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (epp > 0 && epp != values[EPP_INDEX_PERFORMANCE] &&
+	    cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
 		return -EBUSY;
 	}
@@ -1484,34 +1577,31 @@ EXPORT_SYMBOL_FOR_PSTATE_UT(store_energy_performance_preference);
 ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
-	u8 preference, epp;
+	u8 *values = amd_pstate_cpu_epp_values(policy->cpu);
+	u8 epp;
+	int i;
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
 	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
-	switch (epp) {
-	case AMD_CPPC_EPP_PERFORMANCE:
-		preference = EPP_INDEX_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
-		preference = EPP_INDEX_BALANCE_PERFORMANCE;
-		break;
-	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
-		preference = EPP_INDEX_BALANCE_POWERSAVE;
-		break;
-	case AMD_CPPC_EPP_POWERSAVE:
-		preference = EPP_INDEX_POWERSAVE;
-		break;
-	default:
-		return -EINVAL;
-	}
+	/*
+	 * Map the cached EPP value back to a named preference. Skip the
+	 * "default" slot (index 0) so an EPP of 0 reports as "performance".
+	 * Stop at POWERSAVE; CUSTOM and DYNAMIC are not initialized in epp_values.
+	 */
+	for (i = EPP_INDEX_PERFORMANCE; i <= EPP_INDEX_POWERSAVE; i++) {
+		const char *name = energy_perf_strings[i];
 
-	if (cpudata->dynamic_epp)
-		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
+		if (epp == values[i]) {
+			if (cpudata->dynamic_epp)
+				return sysfs_emit(buf, "dynamic(profile:%s)\n", name);
+			return sysfs_emit(buf, "%s\n", name);
+		}
+	}
 
-	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
+	return sysfs_emit(buf, "%u\n", epp);
 }
 EXPORT_SYMBOL_FOR_PSTATE_UT(show_energy_performance_preference);
 
@@ -1953,9 +2043,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->epp_default_ac = cpudata->epp_default_dc = default_epp;
 		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
 	} else {
+		u8 *values = amd_pstate_cpu_epp_values(policy->cpu);
+
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
-		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+		cpudata->epp_default_ac = values[EPP_INDEX_PERFORMANCE];
+		cpudata->epp_default_dc = values[EPP_INDEX_BALANCE_PERFORMANCE];
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
@@ -2254,6 +2346,34 @@ static bool amd_cppc_supported(void)
 	return true;
 }
 
+/*
+ * Resolve the numeric EPP values for hybrid systems. Only hybrid SoCs are listed
+ * in amd_pstate_epp_soc_ids[]; non-hybrid systems always use the legacy defaults.
+ */
+static inline void __init amd_pstate_set_epp_values(enum x86_topology_cpu_type type,
+						    const struct amd_pstate_epp_values *core)
+{
+	epp_values[type][EPP_INDEX_PERFORMANCE] = core->performance;
+	epp_values[type][EPP_INDEX_BALANCE_PERFORMANCE] = core->balance_performance;
+	epp_values[type][EPP_INDEX_BALANCE_POWERSAVE] = core->balance_power;
+	epp_values[type][EPP_INDEX_POWERSAVE] = core->power;
+}
+
+static void __init amd_pstate_init_epp_values(void)
+{
+	const struct x86_cpu_id *id = x86_match_cpu(amd_pstate_epp_soc_ids);
+	const struct amd_pstate_epp_soc *soc;
+
+	if (!id || !id->driver_data)
+		return;
+
+	soc = (const struct amd_pstate_epp_soc *)id->driver_data;
+
+	amd_pstate_set_epp_values(TOPO_CPU_TYPE_PERFORMANCE, &soc->performance_core);
+	amd_pstate_set_epp_values(TOPO_CPU_TYPE_EFFICIENCY, &soc->efficiency_core);
+	amd_pstate_set_epp_values(TOPO_CPU_TYPE_LOW_POWER, &soc->low_power_core);
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -2281,6 +2401,9 @@ static int __init amd_pstate_init(void)
 	/* check if this machine need CPPC quirks */
 	dmi_check_system(amd_pstate_quirks_table);
 
+	/* resolve per-SoC EPP values for the named preferences */
+	amd_pstate_init_epp_values();
+
 	/*
 	* determine the driver mode from the command line or kernel config.
 	* If no command line input is provided, cppc_state will be AMD_PSTATE_UNDEFINED.
-- 
2.43.0


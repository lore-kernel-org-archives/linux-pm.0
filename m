Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCC65304C2;
	Thu,  1 Oct 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886187; cv=none; b=p+NzP+8E8RhPWqyXtXC6E+SxpA+w7+OOamTh31Dlz+SLDZdLVj8uM87YmTN8SVyWnZ4x19E6ZTCwsUfZK84Qy4lYgRSXjXDrFFped5AIQT5+d73aPX+vKJmrrQ53oKR+KIDhcNhknUBQftFZBHzocHbM7CVNW6yvlBk1HAKlvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886187; c=relaxed/simple;
	bh=UPXENUPaKnkpLGIG0EJdzFRy7knkJIHYMp4miTMaPe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMd9rj9UsdPt9JEXaLow0/Tbw6rnz4X0L+lvzlqEpRJc0eiS5N33349JuSGLsjv2pegZOE4amqKwumNJ2Yuyx13QM/nfd7v4w/Io4t7bioODS/ly4VWwU1CLyl13kZJcMhqAjf8h4uik+BZz5PH4GMl1n/0Z5xCmlF1V0XoU2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/IWTHu4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/IWTHu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5631F00898;
	Thu,  1 Oct 2026 20:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790886181;
	bh=qX1O/9NiOPFtTih/KfPqzGLQIYo32qyCWBMGjYqQlSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/IWTHu4sbj8D3fxUuAQQskD1vRddcsB+bLS3SLEi+K5EBk6pshxbR7ldtwetErAI
	 yqc9KInQ9nkpH8LMaEXQbNDqM5GBMRtRsQjer00f5pzBEmwnmff99nFGT7vT90MWg9
	 egLwQYzJjv/kPYwhUpe9UwIYVUN8ocmSA2Dvu3fibA3Ekd4WNu4zrNG93EV0pOiFCU
	 6ZmGy/UCmTjtSSgPfh3j/a8T+eX1dmkIc6OmtTH50NNpreU1XZ0yIftuF9da047Dg5
	 tc1TBJL7iZV0U2LM9wDeCmFuilgnqC8vekaSnDn/9jUXimpe1hA5dRjrOsc9g7mDbI
	 PioxGhCzI2I1Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/3] cpufreq: amd-pstate-ut: Fix max_freq and EPP test failures on Zen6
Date: Thu,  1 Oct 2026 15:22:54 -0500
Message-ID: <20261001202254.1679976-3-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001202254.1679976-1-superm1@kernel.org>
References: <20261001202254.1679976-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Zen6 platforms expose conditions that cause two amd-pstate unit tests to
fail: low-power cores can report max_freq below the shared nominal_freq,
and multiple EPP preferences can alias to the same raw value.

Relax the max_freq >= nominal_freq assertion to max_freq >=
lowest_nonlinear_freq, and tolerate aliased EPP preferences by validating
the raw programmed value instead of string comparison.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Replace patch 3/4 and 4/4 with Prateek's patch
 drivers/cpufreq/amd-pstate-ut.c | 54 ++++++++++++++++++++++++---------
 drivers/cpufreq/amd-pstate.c    | 44 ++-------------------------
 drivers/cpufreq/amd-pstate.h    | 44 +++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index c2c1a166b3a9e..506d7bb2e6609 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -216,7 +216,14 @@ static int amd_pstate_ut_check_perf(u32 index)
 
 /*
  * Check if frequency values are reasonable.
- * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
+ * nominal_freq > lowest_nonlinear_freq >= min_freq > 0
+ * max_freq >= lowest_nonlinear_freq
+ *
+ * On most parts the boost frequency is the highest, i.e.
+ * max_freq >= nominal_freq. On heterogeneous designs (e.g. Zen6) a
+ * low-power core can have a maximum frequency below the shared nominal
+ * reference frequency, so only require the boost frequency to sit above
+ * the lowest nonlinear frequency here.
  * check max freq when set support boost mode.
  */
 static int amd_pstate_ut_check_freq(u32 index)
@@ -235,11 +242,11 @@ static int amd_pstate_ut_check_freq(u32 index)
 		cpudata = policy->driver_data;
 		perf = READ_ONCE(cpudata->perf);
 
-		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
+		if (!((policy->cpuinfo.max_freq >= cpudata->lowest_nonlinear_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
 			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
 			(policy->cpuinfo.min_freq > 0))) {
-			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
+			pr_err("%s cpu%d max=%d, nominal=%d, lowest_nonlinear=%d, min=%d, the formula is incorrect!\n",
 				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
 			return -EINVAL;
@@ -297,12 +304,12 @@ static int amd_pstate_set_mode(enum amd_pstate_mode mode)
 
 static int amd_pstate_ut_epp(u32 index)
 {
-	static const char * const epp_strings[] = {
-		"dynamic",
-		"power",
-		"balance_power",
-		"balance_performance",
-		"performance",
+	enum energy_perf_value_index epp_modes[] = {
+		EPP_INDEX_DYNAMIC,
+		EPP_INDEX_POWERSAVE,
+		EPP_INDEX_BALANCE_POWERSAVE,
+		EPP_INDEX_BALANCE_PERFORMANCE,
+		EPP_INDEX_PERFORMANCE,
 	};
 	char *buf __free(cleanup_page) = NULL;
 	struct cpufreq_policy *policy = NULL;
@@ -371,9 +378,9 @@ static int amd_pstate_ut_epp(u32 index)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(epp_strings); i++) {
+	for (i = 0; i < ARRAY_SIZE(epp_modes); i++) {
 		memset(buf, 0, PAGE_SIZE);
-		snprintf(buf, PAGE_SIZE, "%s", epp_strings[i]);
+		snprintf(buf, PAGE_SIZE, "%s", energy_perf_strings[epp_modes[i]]);
 		ret = store_energy_performance_preference(policy, buf, strlen(buf));
 		if (ret < 0)
 			goto out;
@@ -389,8 +396,24 @@ static int amd_pstate_ut_epp(u32 index)
 		 */
 		strreplace(buf, '(', '\0');
 
-		if (strcmp(buf, epp_strings[i])) {
-			pr_err("String EPP value mismatch: %s != %s\n", buf, epp_strings[i]);
+		if (strcmp(buf, energy_perf_strings[epp_modes[i]])) {
+			u8 epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
+
+			/*
+			 * The preference read back may legitimately differ from the one
+			 * written: some platforms (e.g. Zen6) program the same raw EPP
+			 * value for more than one named preference, so show() reports the
+			 * first name that matches that value.
+			 *
+			 * If strings mismatch, confirm the CPU is programmed with the correct
+			 * EPP value for the mode. This verifies hardware programming while
+			 * tolerating such aliasing in driver.
+			 */
+			if (epp == amd_pstate_cpu_epp_values(cpudata->cpu_type)[epp_modes[i]])
+				continue;
+
+			pr_err("String EPP value mismatch: %s != %s\n",
+			       buf, energy_perf_strings[epp_modes[i]]);
 			ret = -EINVAL;
 			goto out;
 		}
@@ -406,11 +429,12 @@ static int amd_pstate_ut_epp(u32 index)
 		 * restore it here before dropping policy reference.
 		 */
 		if (orig_dynamic_epp) {
+			const char * const dynamic_string = energy_perf_strings[epp_modes[0]];
 			int ret2;
 
 			ret2 = store_energy_performance_preference(policy,
-								  epp_strings[0],
-								  strlen(epp_strings[0]));
+								  dynamic_string,
+								  strlen(dynamic_string));
 			if (!ret && (ret2 < 0))
 				ret = ret2;
 		}
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d8e2eec6e7250..4bf158f677f3e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -44,7 +44,6 @@
 #include <acpi/cppc_acpi.h>
 
 #include <asm/msr.h>
-#include <asm/processor.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_device_id.h>
 
@@ -89,46 +88,6 @@ static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
 static struct quirk_entry *quirks;
 
-/*
- * AMD Energy Preference Performance (EPP)
- * The EPP is used in the CCLK DPM controller to drive
- * the frequency that a core is going to operate during
- * short periods of activity. EPP values will be utilized for
- * different OS profiles (balanced, performance, power savings)
- * display strings corresponding to EPP index in the
- * energy_perf_strings[]
- *	index		String
- *-------------------------------------
- *	0		default
- *	1		performance
- *	2		balance_performance
- *	3		balance_power
- *	4		power
- *	5		custom (for raw EPP values)
- *	6		dynamic (platform profile driven selection)
- */
-enum energy_perf_value_index {
-	EPP_INDEX_DEFAULT = 0,
-	EPP_INDEX_PERFORMANCE,
-	EPP_INDEX_BALANCE_PERFORMANCE,
-	EPP_INDEX_BALANCE_POWERSAVE,
-	EPP_INDEX_POWERSAVE,
-	EPP_INDEX_CUSTOM,
-	EPP_INDEX_DYNAMIC,
-	EPP_INDEX_MAX,
-};
-
-static const char * const energy_perf_strings[] = {
-	[EPP_INDEX_DEFAULT] = "default",
-	[EPP_INDEX_PERFORMANCE] = "performance",
-	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
-	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
-	[EPP_INDEX_POWERSAVE] = "power",
-	[EPP_INDEX_CUSTOM] = "custom",
-	[EPP_INDEX_DYNAMIC] = "dynamic",
-};
-static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
-
 /*
  * The numeric EPP value programmed for each named preference. First dimension
  * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
@@ -159,7 +118,7 @@ static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
  * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
  * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
  */
-static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
+u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 {
 	switch (cpu_type) {
 	case TOPO_CPU_TYPE_PERFORMANCE:
@@ -170,6 +129,7 @@ static inline u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type)
 		return epp_values[TOPO_CPU_TYPE_ANY];
 	}
 }
+EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_cpu_epp_values);
 
 /**
  * struct amd_pstate_epp_values - EPP values for the four named preferences
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index c7189d177b81a..422188c639b1e 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -11,6 +11,8 @@
 #include <linux/pm_qos.h>
 #include <linux/platform_profile.h>
 
+#include <asm/processor.h>
+
 #if IS_MODULE(CONFIG_X86_AMD_PSTATE_UT)
 #define EXPORT_SYMBOL_FOR_PSTATE_UT(symbol) \
 	EXPORT_SYMBOL_FOR_MODULES(symbol, "amd-pstate-ut")
@@ -162,6 +164,48 @@ enum amd_pstate_mode {
 	AMD_PSTATE_MAX,
 };
 
+/*
+ * AMD Energy Preference Performance (EPP)
+ * The EPP is used in the CCLK DPM controller to drive
+ * the frequency that a core is going to operate during
+ * short periods of activity. EPP values will be utilized for
+ * different OS profiles (balanced, performance, power savings)
+ * display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ *	5		custom (for raw EPP values)
+ *	6		dynamic (platform profile driven selection)
+ */
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+	EPP_INDEX_CUSTOM,
+	EPP_INDEX_DYNAMIC,
+	EPP_INDEX_MAX,
+};
+
+static const char * const energy_perf_strings[] = {
+	[EPP_INDEX_DEFAULT] = "default",
+	[EPP_INDEX_PERFORMANCE] = "performance",
+	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
+	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
+	[EPP_INDEX_POWERSAVE] = "power",
+	[EPP_INDEX_CUSTOM] = "custom",
+	[EPP_INDEX_DYNAMIC] = "dynamic",
+};
+static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
+
+u8 *amd_pstate_cpu_epp_values(enum x86_topology_cpu_type cpu_type);
+
 static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
 {
 	u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
-- 
2.53.0


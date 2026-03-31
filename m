Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E044CF34;
	Tue, 31 Mar 2026 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987158; cv=none; b=fH43JDmvlXutnSwhyjj7KpRzr3DFgzGGnRu3nkrs9Dr23aPFzVOXdAWzA+Tnp+W1n/5HmzdOOZhwKqmx3mDopHQzkq4hrhmqtt32E17raIUxB0ELcEPFDWfm9NNpw4HGSR4DGPyCUsocSujog9OoORk8M7MoWs9j4h2prUyc9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987158; c=relaxed/simple;
	bh=UzsnI+RjWA0PfDdtWoQUdwNoibhupvZAoSqsW9ZZiqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJJpnzFOJj/q0bhcB/6epzklZxnT49t87zox8NGuO2CJAojdt6M2RHOEalX8N6QAVoUC5WQvf2DVbEcqStQF8GXyRlN5VxWbDrNi9Pw2GpaaObyjLhmEFLJjo8yo+aj+mEdiK9luo1JWWe9tb7NP5Yn5cXbGx4gfStVQwuC1VYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1yLerRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1yLerRI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CADEC19424;
	Tue, 31 Mar 2026 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987158;
	bh=UzsnI+RjWA0PfDdtWoQUdwNoibhupvZAoSqsW9ZZiqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1yLerRI7Q5K0JP/y12y4oZXeqR/Dv9zsdLdWzQBRFT4R24FypIvRcrwVAE2BzPRp
	 dSPjDjvJs6wHRkjI8pWRBIoYMPP+W4cUUUh0wEMCOCai8AyRjcnJGo1DAjP0OfFxL5
	 XueWeiuLHwLgE1RTQ71HreLJRR/1eD0YDGg96t6RW6Dn42wqpxbbKmNgT7Sxb6f2jd
	 QF59owMBH9SXLuKep4zw6q5wr8JC3tJ8BZI6aPIATHSLMmFSpbmYVchRJcUNuWJbAs
	 S+pFtjg16sy3t6x6VV2aM3B9Eg4xCbOwIb9yfc86rF10zlQSUvmcjVoCXSC4G9676Z
	 uPz5Agz4C+cug==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 3/5] cpufreq/amd-pstate: Add support for platform profile class
Date: Tue, 31 Mar 2026 14:59:05 -0500
Message-ID: <20260331195907.2557193-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331195907.2557193-1-superm1@kernel.org>
References: <20260331195907.2557193-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The platform profile core allows multiple drivers and devices to
register platform profile support.

When the legacy platform profile interface is used all drivers will
adjust the platform profile as well.

Add support for registering every CPU with the platform profile handler
when dynamic EPP is enabled.

The end result will be that changing the platform profile will modify
EPP accordingly.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst |   4 +-
 drivers/cpufreq/Kconfig.x86                 |   1 +
 drivers/cpufreq/amd-pstate.c                | 110 ++++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                |   6 ++
 4 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 01e6ab10f996e..d68ddfea6a9da 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -357,7 +357,9 @@ config option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be ove
 at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
 
 When set to enabled, the driver will select a different energy performance
-profile when the machine is running on battery or AC power.
+profile when the machine is running on battery or AC power. The driver will
+also register with the platform profile handler to receive notifications of
+user desired power state and react to those.
 When set to disabled, the driver will not change the energy performance profile
 based on the power source and will not react to user desired power state.
 
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index cdaa8d858045a..a0dbb9808ae99 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -40,6 +40,7 @@ config X86_AMD_PSTATE
 	select ACPI_PROCESSOR
 	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
+	select ACPI_PLATFORM_PROFILE
 	help
 	  This driver adds a CPUFreq driver which utilizes a fine grain
 	  processor performance frequency control range instead of legacy
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index de22d9bd28cc6..fa0709c3b49ac 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1182,6 +1182,10 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 	if (event != PSY_EVENT_PROP_CHANGED)
 		return NOTIFY_OK;
 
+	/* dynamic actions are only applied while platform profile is in balanced */
+	if (cpudata->current_profile != PLATFORM_PROFILE_BALANCED)
+		return 0;
+
 	epp = amd_pstate_get_balanced_epp(policy);
 
 	ret = amd_pstate_set_epp(policy, epp);
@@ -1190,12 +1194,81 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 
 	return NOTIFY_OK;
 }
+
+static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
+{
+	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
+	set_bit(PLATFORM_PROFILE_BALANCED, choices);
+	set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+
+	return 0;
+}
+
+static int amd_pstate_profile_get(struct device *dev,
+				  enum platform_profile_option *profile)
+{
+	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
+
+	*profile = cpudata->current_profile;
+
+	return 0;
+}
+
+static int amd_pstate_profile_set(struct device *dev,
+				  enum platform_profile_option profile)
+{
+	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	int ret;
+
+	switch (profile) {
+	case PLATFORM_PROFILE_LOW_POWER:
+		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
+			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
+		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
+		if (ret)
+			return ret;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		if (cpudata->policy != CPUFREQ_POLICY_POWERSAVE)
+			cpudata->policy = CPUFREQ_POLICY_POWERSAVE;
+		ret = amd_pstate_set_epp(policy,
+					 amd_pstate_get_balanced_epp(policy));
+		if (ret)
+			return ret;
+		break;
+	case PLATFORM_PROFILE_PERFORMANCE:
+		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
+		if (ret)
+			return ret;
+		break;
+	default:
+		pr_err("Unknown Platform Profile %d\n", profile);
+		return -EOPNOTSUPP;
+	}
+
+	cpudata->current_profile = profile;
+
+	return 0;
+}
+
+static const struct platform_profile_ops amd_pstate_profile_ops = {
+	.probe = amd_pstate_profile_probe,
+	.profile_set = amd_pstate_profile_set,
+	.profile_get = amd_pstate_profile_get,
+};
+
 static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->power_nb.notifier_call)
 		power_supply_unreg_notifier(&cpudata->power_nb);
+	if (cpudata->ppdev) {
+		platform_profile_remove(cpudata->ppdev);
+		cpudata->ppdev = NULL;
+	}
+	kfree(cpudata->profile_name);
 	cpudata->dynamic_epp = false;
 }
 
@@ -1206,11 +1279,35 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 	u8 epp;
 
 	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-	epp = amd_pstate_get_balanced_epp(policy);
+	switch (cpudata->current_profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		epp = AMD_CPPC_EPP_PERFORMANCE;
+		break;
+	case PLATFORM_PROFILE_LOW_POWER:
+		epp = AMD_CPPC_EPP_POWERSAVE;
+		break;
+	case PLATFORM_PROFILE_BALANCED:
+		epp = amd_pstate_get_balanced_epp(policy);
+		break;
+	default:
+		pr_err("Unknown Platform Profile %d\n", cpudata->current_profile);
+		return -EOPNOTSUPP;
+	}
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
 
+	cpudata->profile_name = kasprintf(GFP_KERNEL, "amd-pstate-epp-cpu%d", cpudata->cpu);
+
+	cpudata->ppdev = platform_profile_register(get_cpu_device(policy->cpu),
+						   cpudata->profile_name,
+						   policy->driver_data,
+						   &amd_pstate_profile_ops);
+	if (IS_ERR(cpudata->ppdev)) {
+		ret = PTR_ERR(cpudata->ppdev);
+		goto cleanup;
+	}
+
 	/* only enable notifier if things will actually change */
 	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
 		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
@@ -1311,8 +1408,8 @@ static ssize_t show_energy_performance_available_preferences(
 	return offset;
 }
 
-static ssize_t store_energy_performance_preference(
-		struct cpufreq_policy *policy, const char *buf, size_t count)
+static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
+					   const char *buf, size_t count)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	ssize_t ret;
@@ -1332,7 +1429,7 @@ static ssize_t store_energy_performance_preference(
 	else
 		epp = amd_pstate_get_balanced_epp(policy);
 
-	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
 		return -EBUSY;
 	}
@@ -1344,8 +1441,7 @@ static ssize_t store_energy_performance_preference(
 	return ret ? ret : count;
 }
 
-static ssize_t show_energy_performance_preference(
-				struct cpufreq_policy *policy, char *buf)
+static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	u8 preference, epp;
@@ -1825,10 +1921,12 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
 		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
+		cpudata->current_profile = PLATFORM_PROFILE_PERFORMANCE;
 	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
 		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
 	if (dynamic_epp)
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index d929ae3163b3d..a7e52f79a8029 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -9,6 +9,7 @@
 #define _LINUX_AMD_PSTATE_H
 
 #include <linux/pm_qos.h>
+#include <linux/platform_profile.h>
 
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
@@ -127,6 +128,11 @@ struct amd_cpudata {
 	u8	epp_default_dc;
 	bool	dynamic_epp;
 	struct notifier_block power_nb;
+
+	/* platform profile */
+	enum platform_profile_option current_profile;
+	struct device *ppdev;
+	char *profile_name;
 };
 
 /*
-- 
2.43.0


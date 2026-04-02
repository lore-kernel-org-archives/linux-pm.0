Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE254726;
	Thu,  2 Apr 2026 05:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775106152; cv=none; b=UxTWzRHCfdc/i0DAT3XvKo+Urt+/8FVEMDJg0LGn4yzH8ILiC0XK4MBIqDCIMIuKFevJmEzqyO4+l7ckcJITlmEiL7L2YqEEApgvOdNRL4pYzIkdHGr4XNy5PM4Ocyl/Qg+TY+VGWXJHWXwmrejrC+v+/wcMdpLksl7s5Vbznig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775106152; c=relaxed/simple;
	bh=+VTPQolpGcTVzTrra33CF+fGoXrnO5FCEnNtO1PFyQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jsx4HowZqFgU02rxfItdp1UVEGw6I+ngwDw5NVCeHTjLKMXlgkmgjBBimlJdBLDIPK6N3u88xFYzRz0lXXKj5K4T6J9B3rulcPuvQXiZvyGRkQsuJVHSzvB60jL3gkVKy7fMNlEk/CQmE202Ed5JvWe2p7TYkc7PTJ68pVVU22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilvee6hE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilvee6hE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C55C2BCB0;
	Thu,  2 Apr 2026 05:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775106151;
	bh=+VTPQolpGcTVzTrra33CF+fGoXrnO5FCEnNtO1PFyQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilvee6hEAda+ISQqfRUGx1KwYetziUgXN6+/1/zcieqMG7Tq5uMKnnYSW4LThMw0v
	 d7kEoP/cmh9Fl1JVT/vdqy2TKnEM1/4CZ+oGgyh7IagRxYg1PIxNuTiimBh4fxAqnD
	 qJ+88fCDxorA+p2/skc1tbWJu9EAQUHPrrX8dJe8NSTWEa6/RPuNBrzf2dnGmG7ulZ
	 nXbP7NoR2Wtz8t8XFkvgfYNBc+iewt2zrjXDWlGun1VS3dPvfbhpGycZj9dAUz1ckY
	 LG1XrlQ8EGTCiPunFqkj87hySnEARWrXx7MNQoMaE/N+ao4oM8N5epptjr7mkepWmD
	 D5g7qG7eDdulw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v8 1/5] cpufreq/amd-pstate: Add dynamic energy performance preference
Date: Thu,  2 Apr 2026 00:02:10 -0500
Message-ID: <20260402050214.1238624-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402050214.1238624-1-superm1@kernel.org>
References: <20260402050214.1238624-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic energy performance preference changes the EPP profile based on
whether the machine is running on AC or DC power.

A notification chain from the power supply core is used to adjust EPP
values on plug in or plug out events.

When enabled, the driver exposes a sysfs toggle for dynamic EPP, blocks
manual writes to energy_performance_preference, and keeps the policy in
performance mode while it "owns" the EPP updates.

For non-server systems:
    * the default EPP for AC mode is `performance`.
    * the default EPP for DC mode is `balance_performance`.

For server systems dynamic EPP is mostly a no-op.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v7->v8:
 * Handle failures to enable dynamic epp
 * Don't set policy to CPUFREQ_POLICY_PERFORMANCE in dymamic epp
 * Allow policy governor changes
v6->v7:
 * Fix accidental casualty of floor perf from rebase (Gautham)
 * Adjust documentation (Gautham)
---
 Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
 drivers/cpufreq/Kconfig.x86                 |  12 ++
 drivers/cpufreq/amd-pstate.c                | 128 +++++++++++++++++++-
 drivers/cpufreq/amd-pstate.h                |  10 +-
 4 files changed, 160 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index b43675b7f739b..bb1341763882b 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -325,7 +325,7 @@ and user can change current preference according to energy or performance needs
 Please get all support profiles list from
 ``energy_performance_available_preferences`` attribute, all the profiles are
 integer values defined between 0 to 255 when EPP feature is enabled by platform
-firmware, if EPP feature is disabled, driver will ignore the written value
+firmware, but if the dynamic EPP feature is enabled, driver will block writes.
 This attribute is read-write.
 
 ``boost``
@@ -347,6 +347,22 @@ boost or `1` to enable it, for the respective CPU using the sysfs path
 Other performance and frequency values can be read back from
 ``/sys/devices/system/cpu/cpuX/acpi_cppc/``, see :ref:`cppc_sysfs`.
 
+Dynamic energy performance profile
+==================================
+The amd-pstate driver supports dynamically selecting the energy performance
+profile based on whether the machine is running on AC or DC power.
+
+Whether this behavior is enabled by default depends on the kernel
+config option `CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
+at runtime by the sysfs file ``/sys/devices/system/cpu/cpufreq/policyX/dynamic_epp``.
+
+When set to enabled, the driver will select a different energy performance
+profile when the machine is running on battery or AC power.
+When set to disabled, the driver will not change the energy performance profile
+based on the power source and will not react to user desired power state.
+
+Attempting to manually write to the ``energy_performance_preference`` sysfs
+file will fail when ``dynamic_epp`` is enabled.
 
 ``amd-pstate`` vs ``acpi-cpufreq``
 ======================================
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 2c5c228408bf2..cdaa8d858045a 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -68,6 +68,18 @@ config X86_AMD_PSTATE_DEFAULT_MODE
 	  For details, take a look at:
 	  <file:Documentation/admin-guide/pm/amd-pstate.rst>.
 
+config X86_AMD_PSTATE_DYNAMIC_EPP
+	bool "AMD Processor P-State dynamic EPP support"
+	depends on X86_AMD_PSTATE
+	default n
+	help
+	  Allow the kernel to dynamically change the energy performance
+	  value from events like ACPI platform profile and AC adapter plug
+	  events.
+
+	  This feature can also be changed at runtime, this configuration
+	  option only sets the kernel default value behavior.
+
 config X86_AMD_PSTATE_UT
 	tristate "selftest for AMD Processor P-State driver"
 	depends on X86 && ACPI_PROCESSOR
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index f207252eb5f5f..379e7dd442522 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -36,6 +36,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/uaccess.h>
+#include <linux/power_supply.h>
 #include <linux/static_call.h>
 #include <linux/topology.h>
 
@@ -86,6 +87,11 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
+#ifdef CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP
+static bool dynamic_epp = CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP;
+#else
+static bool dynamic_epp;
+#endif
 static struct quirk_entry *quirks;
 
 /*
@@ -1155,6 +1161,73 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 	kfree(cpudata);
 }
 
+static int amd_pstate_get_balanced_epp(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (power_supply_is_system_supplied())
+		return cpudata->epp_default_ac;
+	else
+		return cpudata->epp_default_dc;
+}
+
+static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
+					    unsigned long event, void *data)
+{
+	struct amd_cpudata *cpudata = container_of(nb, struct amd_cpudata, power_nb);
+	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
+	u8 epp;
+	int ret;
+
+	if (event != PSY_EVENT_PROP_CHANGED)
+		return NOTIFY_OK;
+
+	epp = amd_pstate_get_balanced_epp(policy);
+
+	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		pr_warn("Failed to set CPU %d EPP %u: %d\n", cpudata->cpu, epp, ret);
+
+	return NOTIFY_OK;
+}
+static void amd_pstate_clear_dynamic_epp(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (cpudata->power_nb.notifier_call)
+		power_supply_unreg_notifier(&cpudata->power_nb);
+	cpudata->dynamic_epp = false;
+}
+
+static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int ret;
+	u8 epp;
+
+	epp = amd_pstate_get_balanced_epp(policy);
+	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
+
+	/* only enable notifier if things will actually change */
+	if (cpudata->epp_default_ac != cpudata->epp_default_dc) {
+		cpudata->power_nb.notifier_call = amd_pstate_power_supply_notifier;
+		ret = power_supply_reg_notifier(&cpudata->power_nb);
+		if (ret)
+			goto cleanup;
+	}
+
+	cpudata->dynamic_epp = true;
+
+	return 0;
+
+cleanup:
+	amd_pstate_clear_dynamic_epp(policy);
+
+	return ret;
+}
+
 /* Sysfs attributes */
 
 /*
@@ -1244,14 +1317,19 @@ static ssize_t store_energy_performance_preference(
 	ssize_t ret;
 	u8 epp;
 
+	if (cpudata->dynamic_epp) {
+		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
+		return -EBUSY;
+	}
+
 	ret = sysfs_match_string(energy_perf_strings, buf);
 	if (ret < 0)
 		return -EINVAL;
 
-	if (!ret)
-		epp = cpudata->epp_default;
-	else
+	if (ret)
 		epp = epp_values[ret];
+	else
+		epp = amd_pstate_get_balanced_epp(policy);
 
 	if (epp > 0 && policy->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
@@ -1259,6 +1337,8 @@ static ssize_t store_energy_performance_preference(
 	}
 
 	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
 
 	return ret ? ret : count;
 }
@@ -1620,12 +1700,42 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
+static ssize_t dynamic_epp_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
+}
+
+static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
+				 const char *buf, size_t count)
+{
+	bool enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	if (dynamic_epp == enabled)
+		return -EINVAL;
+
+	/* reinitialize with desired dynamic EPP value */
+	dynamic_epp = enabled;
+	ret = amd_pstate_change_driver_mode(cppc_state);
+	if (ret)
+		dynamic_epp = false;
+
+	return ret ? ret : count;
+}
+
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
+static DEVICE_ATTR_RW(dynamic_epp);
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
+	&dev_attr_dynamic_epp.attr,
 	NULL
 };
 
@@ -1715,13 +1825,17 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (amd_pstate_acpi_pm_profile_server() ||
 	    amd_pstate_acpi_pm_profile_undefined()) {
 		policy->policy = CPUFREQ_POLICY_PERFORMANCE;
-		cpudata->epp_default = amd_pstate_get_epp(cpudata);
+		cpudata->epp_default_ac = cpudata->epp_default_dc = amd_pstate_get_epp(cpudata);
 	} else {
 		policy->policy = CPUFREQ_POLICY_POWERSAVE;
-		cpudata->epp_default = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
+		cpudata->epp_default_ac = AMD_CPPC_EPP_PERFORMANCE;
+		cpudata->epp_default_dc = AMD_CPPC_EPP_BALANCE_PERFORMANCE;
 	}
 
-	ret = amd_pstate_set_epp(policy, cpudata->epp_default);
+	if (dynamic_epp)
+		ret = amd_pstate_set_dynamic_epp(policy);
+	else
+		ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
 	if (ret)
 		goto free_cpudata1;
 
@@ -1753,6 +1867,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 
+		if (cpudata->dynamic_epp)
+			amd_pstate_clear_dynamic_epp(policy);
 		kfree(cpudata);
 		policy->driver_data = NULL;
 	}
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index 32b8b26ce388f..d929ae3163b3d 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -85,6 +85,11 @@ struct amd_aperf_mperf {
  * 		  AMD P-State driver supports preferred core featue.
  * @epp_cached: Cached CPPC energy-performance preference value
  * @policy: Cpufreq policy value
+ * @suspended: If CPU core if offlined
+ * @epp_default_ac: Default EPP value for AC power source
+ * @epp_default_dc: Default EPP value for DC power source
+ * @dynamic_epp: Whether dynamic EPP is enabled
+ * @power_nb: Notifier block for power events
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -118,7 +123,10 @@ struct amd_cpudata {
 	/* EPP feature related attributes*/
 	u32	policy;
 	bool	suspended;
-	u8	epp_default;
+	u8	epp_default_ac;
+	u8	epp_default_dc;
+	bool	dynamic_epp;
+	struct notifier_block power_nb;
 };
 
 /*
-- 
2.43.0


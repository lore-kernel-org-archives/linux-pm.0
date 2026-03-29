Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE5387354;
	Sun, 29 Mar 2026 20:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774816705; cv=none; b=FBQcOoFdRerDDVhgmJwXx3KkXvZzAdcwdrIU8XhmCPA6Ld8T23+jHWsvKyKXQAMNmLKrvc7zUqrLBry5UN9193YiLScqYKJW0Uv0+9IxRp1mOFdCvmL/OYxI73gy51LbTTkmmF3jwMqui0sU6UexIScfMrv9cIIqjyiIOBH2Xpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774816705; c=relaxed/simple;
	bh=GCDcQLs0jsdAuh+3LifhC5fa5TSYaqzut23mEb80PrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfUa52NSkDfbFLuQC6XIoMMvmhcYvMyQKYIQ4nfwNqTbH1bi+/FBozFGDLTXHzYqxjVMkMng7ZE1D8QMBwQ4G2DlINLRO1Evimb6D952OdepREFsKsbJ8DW6yQSe2IelaMXOQKbFbLghkU/3ZXo6R6fcUWcC9ktwS0P2TkxO7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjAC4INF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjAC4INF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E261C2BCB1;
	Sun, 29 Mar 2026 20:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774816705;
	bh=GCDcQLs0jsdAuh+3LifhC5fa5TSYaqzut23mEb80PrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjAC4INFHJbkX5BpEY970zkR9OPJUdfYK0c2Au5sj2X41ydmpei2QGyGIDdxuAc2e
	 eh/E7TfvaTEAVKKgPyJ22fjKjsoNtIVuz4aSzPAWHvsWRY3qWLpprN2hgKUDn1h0r7
	 JQux6tfXxUxGZIyxts5mHJBXwOGuNvGlOeonTepTEi+4jQiNPnX3e1qStc1QxV5l9c
	 gzIFQ1Yly9jtcHIaKtbLxO+TTu5xJsu/zUC5GFtlCuEp4523AdR/Lsr9NpB50vloD+
	 vWBnjCO+Uh+4cAfCcOi1LAC0NMrImlcnzrq6O0yN7RImReapL9leapu/WXW3mtz0wJ
	 HuKk1sGKy87Bg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v6 1/5] cpufreq/amd-pstate: Add dynamic energy performance preference
Date: Sun, 29 Mar 2026 15:38:07 -0500
Message-ID: <20260329203811.2590633-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260329203811.2590633-1-superm1@kernel.org>
References: <20260329203811.2590633-1-superm1@kernel.org>
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
v5->v6:
 * Set the power supply notifier callback before registration
 * Expand the changelog to cover the sysfs toggle and manual EPP blocking
 * Add missing kdoc
---
 Documentation/admin-guide/pm/amd-pstate.rst |  18 ++-
 drivers/cpufreq/Kconfig.x86                 |  12 ++
 drivers/cpufreq/amd-pstate.c                | 137 ++++++++++++++++++--
 drivers/cpufreq/amd-pstate.h                |  10 +-
 4 files changed, 163 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index d6c2f233ab239..0e4355fe13558 100644
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
+Whether this behavior is enabled by default with the kernel config option
+`CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP`. This behavior can also be overridden
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
index f207252eb5f5f..2e3fb1fd280a0 100644
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
@@ -1155,6 +1161,74 @@ static void amd_pstate_cpu_exit(struct cpufreq_policy *policy)
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
+	policy->policy = CPUFREQ_POLICY_PERFORMANCE;
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
@@ -1244,14 +1318,19 @@ static ssize_t store_energy_performance_preference(
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
@@ -1259,6 +1338,8 @@ static ssize_t store_energy_performance_preference(
 	}
 
 	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
 
 	return ret ? ret : count;
 }
@@ -1620,12 +1701,40 @@ static ssize_t prefcore_show(struct device *dev,
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
 
@@ -1715,22 +1824,20 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
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
 
-	ret = amd_pstate_init_floor_perf(policy);
-	if (ret) {
-		dev_err(dev, "Failed to initialize Floor Perf (%d)\n", ret);
-		goto free_cpudata1;
-	}
-
 	current_pstate_driver->adjust_perf = NULL;
 
 	return 0;
@@ -1753,6 +1860,8 @@ static void amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
 		amd_pstate_update_perf(policy, perf.bios_min_perf, 0U, 0U, 0U, false);
 		amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 
+		if (cpudata->dynamic_epp)
+			amd_pstate_clear_dynamic_epp(policy);
 		kfree(cpudata);
 		policy->driver_data = NULL;
 	}
@@ -1790,6 +1899,10 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
+	/* policy can't be changed to powersave policy while dynamic epp is enabled */
+	if (policy->policy == CPUFREQ_POLICY_POWERSAVE && cpudata->dynamic_epp)
+		return -EBUSY;
+
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy, true);
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


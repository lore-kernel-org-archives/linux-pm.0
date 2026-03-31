Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21F744D005;
	Tue, 31 Mar 2026 19:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987159; cv=none; b=EU8TVDwEdB4KOxF4NN5Is0b8cRccBTjPr1bMc0tOHDpo4iUk4b+FDGpu+PyJb+6PCnaxfOsi0CAES7x0KFhTm39pYWaGVP0x4cduPa5ie4EiAOZOE7cZIiobSGi/KdCmjAvC3Igg5LZ5CvXgfxC1fzgUBxyVZNf6aKIa5RMKg5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987159; c=relaxed/simple;
	bh=PDnACkjrqmkOg+tt73vEewjqvFCa+Lj7n2rTfunLRDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guMSa+uHLwSe6f6ttyIkXeJvgMPwTdgTHsEQzL6VgSriUE0QVwddg5H/KGf3We7SWTPpyc1torPxxcuYDfwLrY9OjjPxK5WWrS1IHEX3eQXXR3v07EUuKjCpnFjQVNMAJwWrbiNMvEohmVSCVRTSYJ+0o5sKh9TrYN1uvvnBP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh9bst9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh9bst9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76F9C2BCB0;
	Tue, 31 Mar 2026 19:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987159;
	bh=PDnACkjrqmkOg+tt73vEewjqvFCa+Lj7n2rTfunLRDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qh9bst9R2dnduBbg/35DZd/x8Wk87NFeIsuvv3jbvFQFRJfX8kIZ7OFMHJ5Z41OAH
	 9ok1WhpGGO2LL5l/30U0cHOb0vsG5ig7Z/g7RjfPWbaZVEfzv6Qx/FNFdwn621m+ib
	 cGtt1lKk7rXdVE07MKXrH7wFvrorD4xpOFxB/Md3rbBfGzPAJZ0jqIStxIGBmvZB9y
	 DVkNJqauamUzDGvYMzxLqtobhQ9zD1a1CRWjG22nlGOGzIVOcrjNN84YHLec+Ywsln
	 ECsh7Bz0hwXAmsw2gHOcdsHaAv7BRM7EgfEmYWiaf9ki4dVsvdCF5U1xsp5/sTNnUw
	 gAVUiyllJAStg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v7 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
Date: Tue, 31 Mar 2026 14:59:06 -0500
Message-ID: <20260331195907.2557193-5-superm1@kernel.org>
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

The energy performance preference field of the CPPC request MSR
supports values from 0 to 255, but the strings only offer 4 values.

The other values are useful for tuning the performance of some
workloads.

Add support for writing the raw energy performance preference value
to the sysfs file.  If the last value written was an integer then
an integer will be returned.  If the last value written was a string
then a string will be returned.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
v6->v7:
 * Correct documentation
---
 Documentation/admin-guide/pm/amd-pstate.rst | 16 ++++++---
 drivers/cpufreq/amd-pstate.c                | 36 +++++++++++++++------
 drivers/cpufreq/amd-pstate.h                |  1 +
 3 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index d68ddfea6a9da..f8e7050fc7623 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -316,16 +316,22 @@ A list of all the supported EPP preferences that could be used for
 These profiles represent different hints that are provided
 to the low-level firmware about the user's desired energy vs efficiency
 tradeoff.  ``default`` represents the epp value is set by platform
-firmware. This attribute is read-only.
+firmware. ``custom`` designates that integer values 0-255 may be written
+as well.  This attribute is read-only.
 
 ``energy_performance_preference``
 
 The current energy performance preference can be read from this attribute.
 and user can change current preference according to energy or performance needs
-Please get all support profiles list from
-``energy_performance_available_preferences`` attribute, all the profiles are
-integer values defined between 0 to 255 when EPP feature is enabled by platform
-firmware, but if the dynamic EPP feature is enabled, driver will block writes.
+Coarse named profiles are available in the attribute
+``energy_performance_available_preferences``.
+Users can also write individual integer values between 0 to 255.
+When dynamic EPP is enabled, writes to energy_performance_preference are blocked
+even when EPP feature is enabled by platform firmware. Lower epp values shift the bias
+towards improved performance while a higher epp value shifts the bias towards
+power-savings. The exact impact can change from one platform to the other.
+If a valid integer was last written, then a number will be returned on future reads.
+If a valid string was last written then a string will be returned on future reads.
 This attribute is read-write.
 
 ``boost``
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fa0709c3b49ac..634a4850a0a67 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -109,6 +109,7 @@ static struct quirk_entry *quirks;
  *	2		balance_performance
  *	3		balance_power
  *	4		power
+ *	5		custom (for raw EPP values)
  */
 enum energy_perf_value_index {
 	EPP_INDEX_DEFAULT = 0,
@@ -116,6 +117,7 @@ enum energy_perf_value_index {
 	EPP_INDEX_BALANCE_PERFORMANCE,
 	EPP_INDEX_BALANCE_POWERSAVE,
 	EPP_INDEX_POWERSAVE,
+	EPP_INDEX_CUSTOM,
 	EPP_INDEX_MAX,
 };
 
@@ -125,6 +127,7 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
+	[EPP_INDEX_CUSTOM] = "custom",
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
@@ -135,7 +138,7 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
 };
-static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX);
+static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -1413,6 +1416,7 @@ static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	ssize_t ret;
+	bool raw_epp = false;
 	u8 epp;
 
 	if (cpudata->dynamic_epp) {
@@ -1420,14 +1424,21 @@ static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy
 		return -EBUSY;
 	}
 
-	ret = sysfs_match_string(energy_perf_strings, buf);
-	if (ret < 0)
-		return -EINVAL;
-
-	if (ret)
-		epp = epp_values[ret];
-	else
-		epp = amd_pstate_get_balanced_epp(policy);
+	/*
+	 * if the value matches a number, use that, otherwise see if
+	 * matches an index in the energy_perf_strings array
+	 */
+	ret = kstrtou8(buf, 0, &epp);
+	raw_epp = !ret;
+	if (ret) {
+		ret = sysfs_match_string(energy_perf_strings, buf);
+		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
+			return -EINVAL;
+		if (ret)
+			epp = epp_values[ret];
+		else
+			epp = amd_pstate_get_balanced_epp(policy);
+	}
 
 	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		pr_debug("EPP cannot be set under performance policy\n");
@@ -1438,7 +1449,9 @@ static ssize_t store_energy_performance_preference(struct cpufreq_policy *policy
 	if (ret)
 		return ret;
 
-	return ret ? ret : count;
+	cpudata->raw_epp = raw_epp;
+
+	return count;
 }
 
 static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *buf)
@@ -1448,6 +1461,9 @@ static ssize_t show_energy_performance_preference(struct cpufreq_policy *policy,
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
+	if (cpudata->raw_epp)
+		return sysfs_emit(buf, "%u\n", epp);
+
 	switch (epp) {
 	case AMD_CPPC_EPP_PERFORMANCE:
 		preference = EPP_INDEX_PERFORMANCE;
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index a7e52f79a8029..f7461d1b6bf3c 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -127,6 +127,7 @@ struct amd_cpudata {
 	u8	epp_default_ac;
 	u8	epp_default_dc;
 	bool	dynamic_epp;
+	bool	raw_epp;
 	struct notifier_block power_nb;
 
 	/* platform profile */
-- 
2.43.0


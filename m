Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012055.outbound.protection.outlook.com [40.107.200.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64DC233723;
	Mon, 27 Jul 2026 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136955; cv=fail; b=MFcuzl2tiPn3sZoIphMwq4UUsoKKG5wIJeXHTXudkezYk9aTKZ5qsdtbIqsltreaS0g4HQgvAJc2S4f5Wcs6jXrVM2DHuXGPHgVGATfaC2o4StWWTT2hFGqENumMYp9rdBDnnVQxI/OIRoC+q8lPS6k4RV4erudd9Y4c2bLOwHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136955; c=relaxed/simple;
	bh=c3oC7JWYpL8P1pq2vJWQGfg39JYzY8ml1yiJoKavowU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB6S1FcMiX2m8j4Ta/yuojkvmSfCZetLm/1nFXYS8G79g+oZVRa+ChflOHay8/ZZ2qqhkVv4J8OMAugJuLyOU0hJrxVY94Vm7D9tpzms0mbZrAFw36R30EHhs8O78hqAkrrjGpZ/qiFPiACLSW8nMhgXX2c3kcPBsqg8JgtHM9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZcdgN+T7; arc=fail smtp.client-ip=40.107.200.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZcdgN+T7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOxWpW4Vt90BC3v0gz+ReD3IlGUWrUeUO19yem8Xvawlj2SYGjQjNwvoNmMSsHQReJpdY0xSE7tRItdKPJumBrAhwHKfAADAyDWiT/UL8eVBWrbk70HfM6GfX6m7jYYlUx1I0cC4TPsc6jPeSIf3hykoayS6NuKeald9TrvM5DTb3O+7M04bbMHcFuBd0ibbL4uyWa6KG27Q2TpZN4rCFONFZMXcKW80oSNGX/4oKExiC/K+qMW1rOcuePnmTNMe3Xb8/o84h+7x6gdovZ4RbdynFtRZeh4xx2w4U921h+E6iZhmEeyV5jv2I8Ztw0pbZih7SOr0hRt0EwPiE4QstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDDhMIaOuzeQoe9T9om4MkbXz8fadg1kVbiGTrt4wFc=;
 b=fYHHFJprFjE0iHIR4TzvqOe6C7XPnLY33S5/JeXr70gaUcVBJJ+JCOVLIQKBNWgzjCg9iQknIv8laVscgjQTH1NhbZgAT2Itwa751mf7QydVFVgy4OP5yzagFuDmQw3s9DdOlnborj39AYmqcvxrC5i7u8kottsMBICVLWT8k9/DN45d/ZMz2bvhCXy9O1MCFryWibuqo6nIhvr5gkFzVT8XxXdMBf2Uy/MR1YHmVvUmNKA1O6YTYW38mfGkSJxMGGW6TGL3Yt3fewNjjT/JSvCnEIcHBLuV8zvb6nmsBOyYseL+GYFX5XR7bzby1MguF1LWx+gDzGob/977e/KEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDDhMIaOuzeQoe9T9om4MkbXz8fadg1kVbiGTrt4wFc=;
 b=ZcdgN+T7exJOz+fdg3Ev+TqlcQqkSBBeviMLa2DAJvIeIZtcMAJgCr/F42XSeDNQkY3ia4X16/2fb/4dQ8Qj65PM1xUhdokw8v+294swZKIcf+Fh04XvgCNwKmUhUULbeJo7iAoL8XGrzMhydhVkQNp5xXNUJ9edluws+l+ngao=
Received: from MN2PR11CA0002.namprd11.prod.outlook.com (2603:10b6:208:23b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:22:29 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23b:cafe::8c) by MN2PR11CA0002.outlook.office365.com
 (2603:10b6:208:23b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:22:29 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:22:24 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 4/9] cpufreq/amd-pstate: Add dynamic EPP as an "energy_performance_preference" mode
Date: Mon, 27 Jul 2026 07:20:51 +0000
Message-ID: <20260727072056.1248-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727072056.1248-1-kprateek.nayak@amd.com>
References: <20260727072056.1248-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1994109f-30dc-4fc2-bc26-08deebafd105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	/qfAoJX83400l6dpey45yFUfi3pSf58X6QkPQdaDV8IiKaaEEsrKchakYl7s1rSmC64+MNpW+MfqfYcmvteTJfaioDXrbctFsQfJQ1+aLdVOMPTNUOiIwA+ulhig/TPROCJalhyjKDEDBrG1+AY8FR51vH5+WK7mxMoJdiWTAMTTyo0VxpUya8q6NyRjG9jBOHZ6mi3H0Z1HGdvrpziwdHknqjq7ekFCWw7svoNu02STPl4ur7rXp4ooRlfSn6AWIgOmkYsckJs9ury/o07FVui8iKkaIi1+0j7pkDJ2Dybmncu1abk7SC5jg3nKtNOruXyeI+m0BYg+vcHBwZjenI17pKA/4vTWeux8GvY1+EOiNU63+Fec6KhhIigE4d/T1v9hmj/uxzZqgEJ4Hfe10bdRVSrQYPxtUArCN1UXUpXWLaVFDOcDzhKSavDF9pKv9wIWhaCR677XWKNlrub/xNSemDvpiljZIS0VQr/oDD4glvO+qWKJnJunstyGvZYUr3X/7101nuKCMsPp2Y/8OnFYO9rgdukBJy2XE4NE3NDrqym2XhtR52BZ5hS03puSeQy9sTzP+tFk4Wyv74aF1ymw+hx5WT5VJN+f2Q7MEil1Cj96ICuFfTGSESLe0LaMY5Fv2vyaxjwpF0IMWUjR/pLXdB9vlLoDskBLoxIFkbHR9n/aySjNOeO3WvMyZMpRQ+VRIQf9etGUWB31Nu0ggw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+HWMsf96PmR6Kn2qx4Q2oWdWhx6of5R93+SwFZbtmDeZvK2gI/qw3ugEgFY3aYEt2xL5akVAPhXExItFrmnWMJiCjf9Z+KBDiFf8xnZX0IQGu4wWXSRphBIhXN/pH0KoLV85sqSQXYkHx3KE7wmeoIKq4/TNFeuJwvTDMwXVX48s5P1OUG5UVjdTmXPRYIJpJXufmawmGKQGUkiizqmzhA1AA3683vq7atg6hWL3SZ9/yl4EqJbwIuJSdIo9K5WS8BFnsMuqXJ4cyVGqBOg+3AR467lbDdE4FDaAikV7JGwZSveSOx8gNdxU2OilK/hmiC4T0OlDkwJuaE9fFu0rZ2kZ96Kz3ZG/p6xg5nUF4z+I4f4g5hHFw7UGkXG4pKBvM3DKaU1nWBKYObAxE5YXyEVQRnthFw56qnnBs2KSl4qCeiL1/rfwpRh8Zel/LYqy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:22:29.1443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1994109f-30dc-4fc2-bc26-08deebafd105
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Convert the global "dynamic_epp" toggle into a per-CPU
"energy_performance_preference" mode "dynamic" that allows toggling the
functionality of "dynamic_epp" at a per-CPU level.

Instead of being a system-wide toggle, users can opt into the
functionality of dynamic EPP on a per-CPU basis by switching to the
powersave governor and selecting the "dynamic" mode from the available
performance preferences.

Unlike the previous implementation that had to check for driver mode
before toggling on the functionality, block writes to certain sysfs
files, potentially disallow policy change, etc. the per-CPU toggle fits
naturally into the intended design and provides more granular control to
the user.

The dynamic_epp file is now redundant as the option to toggle it on is
controlled via energy_performance_preference, and the dynamic_epp file
will be removed in the subsequent commit.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Collected tag from Mario. (Thanks a ton!)

o Fixed a typo in commit message. (Mario)

o Added a policy check to prevent toggling dynamic mode with PERFORMANCE
  policy. (Sashiko)
---
 drivers/cpufreq/amd-pstate.c | 59 +++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5b10a0a0e6b6..fdf3106f6e07 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -106,6 +106,7 @@ static struct quirk_entry *quirks;
  *	3		balance_power
  *	4		power
  *	5		custom (for raw EPP values)
+ *	6		dynamic (platform profile driven selection)
  */
 enum energy_perf_value_index {
 	EPP_INDEX_DEFAULT = 0,
@@ -114,6 +115,7 @@ enum energy_perf_value_index {
 	EPP_INDEX_BALANCE_POWERSAVE,
 	EPP_INDEX_POWERSAVE,
 	EPP_INDEX_CUSTOM,
+	EPP_INDEX_DYNAMIC,
 	EPP_INDEX_MAX,
 };
 
@@ -124,6 +126,7 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
 	[EPP_INDEX_POWERSAVE] = "power",
 	[EPP_INDEX_CUSTOM] = "custom",
+	[EPP_INDEX_DYNAMIC] = "dynamic",
 };
 static_assert(ARRAY_SIZE(energy_perf_strings) == EPP_INDEX_MAX);
 
@@ -134,7 +137,7 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
 };
-static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 1);
+static_assert(ARRAY_SIZE(epp_values) == EPP_INDEX_MAX - 2);
 
 typedef int (*cppc_mode_transition_fn)(int);
 
@@ -1275,6 +1278,7 @@ EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	int ret;
 	u8 epp;
 
@@ -1315,6 +1319,9 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 cleanup:
 	amd_pstate_clear_dynamic_epp(policy);
 
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, prev);
+	/* Restore previous EPP if toggling Dynamic EPP failed. */
+	amd_pstate_set_epp(policy, epp);
 	return ret;
 }
 
@@ -1385,7 +1392,7 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
 static ssize_t show_energy_performance_available_preferences(
 				struct cpufreq_policy *policy, char *buf)
 {
-	int offset = 0, i;
+	int i, offset = 0;
 	struct amd_cpudata *cpudata = policy->driver_data;
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
@@ -1408,11 +1415,6 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 	bool raw_epp = false;
 	u8 epp;
 
-	if (cpudata->dynamic_epp) {
-		pr_debug("EPP cannot be set when dynamic EPP is enabled\n");
-		return -EBUSY;
-	}
-
 	/*
 	 * if the value matches a number, use that, otherwise see if
 	 * matches an index in the energy_perf_strings array
@@ -1423,6 +1425,25 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		ret = sysfs_match_string(energy_perf_strings, buf);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
 			return -EINVAL;
+
+		if (ret == EPP_INDEX_DYNAMIC) {
+			if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+				return -EBUSY;
+			/*
+			 * Dynamic EPP was already enabled for this CPU.
+			 * Nothing to do.
+			 */
+			if (cpudata->dynamic_epp)
+				return count;
+
+			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
+			ret = amd_pstate_set_dynamic_epp(policy);
+			if (ret)
+				return ret;
+
+			return count;
+		}
+
 		if (ret)
 			epp = epp_values[ret];
 		else
@@ -1434,6 +1455,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		return -EBUSY;
 	}
 
+	/*
+	 * Dynamic EPP was enabled previously!
+	 * Switch back to the static EPP mode.
+	 */
+	if (cpudata->dynamic_epp)
+		amd_pstate_clear_dynamic_epp(policy);
+
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
@@ -1451,7 +1479,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
-	if (cpudata->raw_epp)
+	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
 	switch (epp) {
@@ -1471,6 +1499,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		return -EINVAL;
 	}
 
+	if (cpudata->dynamic_epp)
+		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
+
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 EXPORT_SYMBOL_GPL(show_energy_performance_preference);
@@ -2031,6 +2062,18 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	if (!policy->cpuinfo.max_freq)
 		return -ENODEV;
 
+	/* Must be a switch between PERFORMANCE and POWERSAVE */
+	if (cpudata->policy != policy->policy) {
+		/*
+		 * Disable dynamic_epp when switching
+		 * out of CPUFREQ_POLICY_POWERSAVE.
+		 */
+		if (cpudata->dynamic_epp) {
+			WARN_ON_ONCE(cpudata->policy != CPUFREQ_POLICY_POWERSAVE);
+			amd_pstate_clear_dynamic_epp(policy);
+		}
+	}
+
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy, true);
-- 
2.34.1


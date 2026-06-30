Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19612395AE2;
	Tue, 30 Jun 2026 19:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846032; cv=fail; b=Gj38jL+K+Ee4jEz5UuKD9gv9W+PlgUQpQCdBuIh0CfbBipDlv+gZ4aV7OFrLmrmpwqqBvLNFXPNkRswxleETqeZ8J4XWj4l2lnP9fxqWPnZbCuPJ+4pZE662vWA7lgL/5dPjIKXxN+nKG0mkW5mwRUqLNiw3CU2aEwJMTcW79V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846032; c=relaxed/simple;
	bh=9TID/6ufEAyqkHfC1AY+LUTeUVFZ3b8tie/gAKvyRB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Olzm5qxKICdhJk+x3u82FiOSG49Kmou1sglQXe/fGFRhE8VTWDsJBMd6fGa9qi87lFFggPungMbX0JtChiliJwBqWsy16KS2UiK9nvktcgAb+Wi8fRhbg83UhUTCq9aF7DKKFXDqKo2DXTRM1ZmO+RSb61uFowd79FNxx/3G60A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRTfTd6U; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRTfTd6U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwZxx7Krx2Mk8BW5Y8Ockv0M4C6kra9NL1VJpSarNjMSW6PaXRJF1vgCUiRVrhW4Rb6YWD3ixQ3GBUe6SJVth2BFrZPoHZ9cxq5GJaBktN04Enm+zPSh4ZsjgHTsoVk+ao5R2D8zFnbc6kmFt7vKn4+B7tL37gkSyuH4cKe+yQMW38FtaJ2LcZqbSklvxzY28dC/ftWBOPRgjaLfnPy7aYY7a9W/XQkAmK77a8sWLKYf1cnK4J3PpEUk4YT0I+2WBqOvDy+IJibpkzwcX6Z0WbLftbHZBRyWOlCktN816tgShWkA21cJ1n79PXYiRYaVOx5kqeF5+wRAR7M6ADLfLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apgK2YlMRzMMWqnJG8luwA4rtpvkU6i3Z1FfJ3o6eQk=;
 b=fAN6HByzxhYETZBFwiyJyVKIBIH1jBKwgMfIu1Ehclw6+cJvLnvw2TKiu3D3L9ZDyw79+W1DuybqJDJw2IbawAchr99WP14J5bcAF6Hs1EKAT3jAdAlw3qR9BGD80N6E5OTpzPWjLvh0SQr6BodDr3TLoTJ2TjnYtfPpLtqAsXyhsr0tejNGCyYw3bl9hiYI7Skcl96oX+y2W0bdGrPu6SJ/ov7rhEdiPJ/qnUxcUlVm3qzvSbPWDt2kTAfDezSs6Sdz3fl6tNJ3YF5qRquCgCoD0eGjJ8nqJt1IHEQ6twjncRNYgKJRBmvfft3X7jykK08dKTE0Luq8ps5oPy4Y3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apgK2YlMRzMMWqnJG8luwA4rtpvkU6i3Z1FfJ3o6eQk=;
 b=aRTfTd6UwdimVmTCqEiCi2zLJPBIJ9JmdADTiAKhIs7bmGfFhLVZTGr7Evahx4/bHJv+XR5OHDrpiwByYivO7CH+SQ7pKJjO2BJE45mmmTFazoUQECCqtd2srPFIH0TSKcZweYD+AmTQ+UQzSIpEMCGqG3uxl1cFoBRMOHECgRQ=
Received: from SJ0PR03CA0182.namprd03.prod.outlook.com (2603:10b6:a03:2ef::7)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 19:00:21 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::2a) by SJ0PR03CA0182.outlook.office365.com
 (2603:10b6:a03:2ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 19:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 19:00:21 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 30 Jun
 2026 13:59:58 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Huang Rui
	<ray.huang@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 2/6] cpufreq/amd-pstate: Add dynamic EPP as an "energy_performance_preference" mode
Date: Tue, 30 Jun 2026 18:59:00 +0000
Message-ID: <20260630185904.5602-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630185904.5602-1-kprateek.nayak@amd.com>
References: <20260630185904.5602-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fadac2-7731-4286-7986-08ded6d9d595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	n16Kwhm+mD+rC2bSX1obYWpnC6aYTw2Dio3tCxWtQGEcN6IcGPwtnxDXqQ9jySuxhBEue5u46wjXczw0AAHw79rODFyZAdodguEoVbzMjPiROUiZ+ksfBYXMkF6a9jbvm64ShhPfkxREbyZoF8ZcI8Sw9VLgNEe4ZqmHqTXo0G1JTB423BibGp8rmxhcbEZy5UyBXZalxkg3RYNdD+/l/FRynhgzQyGxI+pLHmITjbLLhBfcRb3bzhfXBjtOl3Ni6Xq53sDreCoiDUDHBezidB6K6Ay6oIK/uAY0sgVDB9jKMbeyoIS/bVpX9o75afT24E8iWTfBND2oYs+ZgHDsq48wnPWnTmpht2XYYhoxc2JzBi3awswI6O404gX3yS+brC0zNkifuLFCiMSJCmtYH3UgQ3rqw7QOejQTqZ8uRz0yLmFZkTJpWWib9c95UqupZrFj+wPzUfjNXoAuRp71HeVN0Ld67hUYGHZh/PaX64BCE+JUN/yTQD3M7bHYGOtoxesLuFoFaTTp0VYCmU+fNa6GECUCBn18yK0rd99oeOK50r+hFwPG8GAGfJPowU9iNPk1U/ILlNNZU4Gu0XwlFe6Y9KLQ1JfkiSt/o2WhGFa6v38AIUvhmXXXK9NbEcmRkg4HYNIBP1S4fhj7GvJAdsUxaVD52IaLqbh71sOt2Xyjdff4bcVqMr/yrpw8cqw2UnEZFTCuiu6RZiFTbOcVYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nqKapMgQ0M70LHPlySWK3x5evTIBaHx2McHez/DsSAAjUMiDfUfM3bPTz1ahQcSzLaE5X29/xDy5ebbKIN1TQyaEhnnfOzVAyesLpZgHFXyuAxawk/KLR1Lce41d2IajWvA9Mw0OJMLcFfr+JTOiq2Knb0MqQ8ehxMOnH6a2I2jVW2fgh0/fFVOA5WLq5NnN60OgYqUmbVxWgcsHqj/xyS11caaf0qRPQFcyPnlXydMG/rbrEvEFZOhNFvCZsYwW+KJQGnADJr2vP4ChKAOKqotB/Y5dNx5LpCOk2howNDnJ5FwYYL8dNR0iNzMxcUlU1PzYmpJiWKdL86oY6faNgtXQ67QPnx/oiizIVTZzlkOol9Oj2U6jISorTOit0Eh+SeM/TY2VaOmeGgG76yBKGHVOTMXwAbtZ9dhgTCt5HL9X8sVrsDT/eyTPndlAaFTS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 19:00:21.1501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fadac2-7731-4286-7986-08ded6d9d595
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767

Conver the global "dynamic_epp" toggle into a per-CPU
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

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 90 +++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1893b0054a6a..c7eec6b96dcc 100644
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
 
@@ -1262,6 +1265,7 @@ EXPORT_SYMBOL_GPL(amd_pstate_clear_dynamic_epp);
 static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	int ret;
 	u8 epp;
 
@@ -1302,6 +1306,9 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 cleanup:
 	amd_pstate_clear_dynamic_epp(policy);
 
+	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, prev);
+	/* Restore previous EPP if toggling Dynamic EPP failed. */
+	amd_pstate_set_epp(policy, epp);
 	return ret;
 }
 
@@ -1372,14 +1379,22 @@ static ssize_t show_amd_pstate_hw_prefcore(struct cpufreq_policy *policy,
 static ssize_t show_energy_performance_available_preferences(
 				struct cpufreq_policy *policy, char *buf)
 {
-	int offset = 0, i;
 	struct amd_cpudata *cpudata = policy->driver_data;
+	int i, max = EPP_INDEX_MAX, offset = 0;
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
 		return sysfs_emit_at(buf, offset, "%s\n",
 				energy_perf_strings[EPP_INDEX_PERFORMANCE]);
 
-	for (i = 0; i < ARRAY_SIZE(energy_perf_strings); i++)
+	/*
+	 * Do not enumerate "dynamic" option only if disabled during boot.
+	 * Users can still opt in to dynamic EPP if platform (server) has
+	 * decided to keep it disabled by default.
+	 */
+	if (!dynamic_epp)
+		max = EPP_INDEX_DYNAMIC;
+
+	for (i = 0; i < max; i++)
 		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i]);
 
 	offset += sysfs_emit_at(buf, offset, "\n");
@@ -1395,11 +1410,6 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
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
@@ -1410,6 +1420,26 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		ret = sysfs_match_string(energy_perf_strings, buf);
 		if (ret < 0 || ret == EPP_INDEX_CUSTOM)
 			return -EINVAL;
+
+		if (ret == EPP_INDEX_DYNAMIC) {
+			/* Dynamic EPP disabled at boot or by platform. */
+			if (!dynamic_epp)
+				return -EINVAL;
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
@@ -1421,6 +1451,13 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
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
@@ -1438,7 +1475,7 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 
 	epp = FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached);
 
-	if (cpudata->raw_epp)
+	if (!cpudata->dynamic_epp && cpudata->raw_epp)
 		return sysfs_emit(buf, "%u\n", epp);
 
 	switch (epp) {
@@ -1458,6 +1495,9 @@ ssize_t show_energy_performance_preference(struct cpufreq_policy *policy, char *
 		return -EINVAL;
 	}
 
+	if (cpudata->dynamic_epp)
+		return sysfs_emit(buf, "dynamic(profile:%s)\n", energy_perf_strings[preference]);
+
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 EXPORT_SYMBOL_GPL(show_energy_performance_preference);
@@ -1943,10 +1983,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
-	if (dynamic_epp)
+	if (dynamic_epp) {
+		/* Dynamic EPP is only available with the POWERSAVE policy. */
+		policy->policy = CPUFREQ_POLICY_POWERSAVE;
 		ret = amd_pstate_set_dynamic_epp(policy);
-	else
+	} else {
 		ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
+	}
+
 	if (ret)
 		goto free_cpudata1;
 
@@ -2018,6 +2062,30 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
+		/*
+		 * If dynamic_epp is enabled by default, toggle it on
+		 * when switching to CPUFREQ_POLICY_POWERSAVE.
+		 */
+		if (dynamic_epp) {
+			WARN_ON_ONCE(policy->policy != CPUFREQ_POLICY_POWERSAVE);
+
+			cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
+			ret = amd_pstate_set_dynamic_epp(policy);
+			if (ret)
+				return ret;
+		}
+	}
+
 	cpudata->policy = policy->policy;
 
 	ret = amd_pstate_epp_update_limit(policy, true);
-- 
2.34.1


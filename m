Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A93F7A8A;
	Thu, 26 Mar 2026 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525722; cv=fail; b=H1bUJEoJtyVJ4Vjrd6OzkWOjkpKBnug7f07ufhXPTctCbt12c25znKfPo+nyg3PNoWRdPrTWQjGosudDPDo4QzIaPilSCoGkDC88xWn5eIgkL15wdByEsGezDim1DBkdEmEie9eDO3IZau+2W+JmIuGexnLe1IQUgo44GdPewH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525722; c=relaxed/simple;
	bh=FxmQwI+lEr5R2GmKwQuIg0S2nvDH3G2/EGDzvnoWHC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InVZ7xAqNDtnK3RYDb0F9sj82yKxrekUaPkBjk3Arxd9eKkz8R5dQ1Dxmyd2VL88tbUJkKYSScCN1RxryxG2DYmnMAZPq/04E0+JJsQ8i6OUJcFAVcJZIywkFK8rAh7aO4kvHL/1CN5heRJYyNaE3WtiW0njqH5NfQTMWM3IlQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lmaP/ldV; arc=fail smtp.client-ip=52.101.48.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lmaP/ldV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjUGsf88WRebpq5xVzLF+XnAUnk0HmDcRPfJigR7gIMIJKeeWSSev0e3ZqRXnrgGsmGKt7MQq/2P5SNSq+9pX3cC3obDDo4q+YLp0nWAk/7lthQAlG4U3QegwOw1bXR3kuNRAx6VTFzKs0e2oY5LDk2edgwfcJIVTn+TGkTE1NUhE5hqzyuyIxpQNzIb9WxYTGy33Xf+C/Mw07RVmHMZ37RK4yciSunA29/FLVHnKWyZ3hlLxoB3sXvTiaJGBboAX7L8yGsjCRFWUj3VJo2trebe3VXlJqSH7/0uvbtH6Jc5evwltHROiWKIgMrHUht7meP0R7hR1OML9yX1QMC+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XJC9t1OWljSE2wWIaZdI92Lq0JQEL1lL72oJtG0UJc=;
 b=Q40d3XOYWvQrcPaWAQTdLsh5hkWumo6J182kjjzR9/6ZeoCmtrZzejlffekcmGoG+Mdw9KpUsqbYh4UfXpRy6E6Fm+qK6TT7jEQzK4HFjURzuuLKay51BKKgRMy7JvniQyKq8YKA+6FMeMhwZ7LPdkoEb8g6TFAuVD4Iq55+qzQ0BRlqJXgb+xp8iWsnGmbE2JfmFM0fmq+qApyuI+rYCYIMVR4P5j97YxzZ+KFg7QoQByCilrcEfysMqDCqD8D+wulYq9SZKIJ3NlIJBKVME/UJMi0AeueoxhFsU9nESsvR5iPuOXuTsMCPdd4v0oc2RhtyryX9AAkOHtr0bre3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XJC9t1OWljSE2wWIaZdI92Lq0JQEL1lL72oJtG0UJc=;
 b=lmaP/ldVaNpkKNzQl7lfZ1o4Mhli7WiNQfYdbcgIaBBkunbtmK1aZvEgWsftfGIgScr1WjxecDQI+hNtLe35fjgdkby4jflg0sxNKK1g9Gi0aVLoRmM4/s1OT49l9sTY5EEmVnIiJfqUQqZSgA8mgGl/zZv9rtUR/yCLfE+LMIw=
Received: from CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 26 Mar
 2026 11:48:26 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::8c) by CH2PR19CA0023.outlook.office365.com
 (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 11:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:25 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:22 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 03/12] amd-pstate: Make certain freq_attrs conditionally visible
Date: Thu, 26 Mar 2026 17:17:47 +0530
Message-ID: <20260326114756.20374-4-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326114756.20374-1-gautham.shenoy@amd.com>
References: <20260326114756.20374-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b7a93b-a3f3-4e67-d3fc-08de8b2d9715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7HYRgCe6lvHAZ2XBjLMELaTNJDMRRZD5dHZGhsmXanG2Sgyu4Wu/ywD0FCBSQDNyslNyM/LtYrVDvvt8ZEgZeWRXPf/bA1m9GP48wg3wJ5LyCcVa7aJwIP38mN/GOG2iKEFSoJUrOPqNpO6P820B22gnr1DfUrMI3Mb1g0yPH+2WTABovW1TTSk53DwYOjudK1F6Y6RnFg11hT6hdYh7oBKGD2Re1HWpiLbou9rfwsnLr6ksMGrLHKLNg58HTu/wsZS7ysp+TOi1rDEzBtyh8PgnnEDoBAR9YvaNYXN/Vfl2nlW3HOyFAxwlQrzrZJkgz/Ie2GNsNJBhI6GJYqvQgEr+2GtKCvNHkGoSYyZOMpPfbWBXN+DDg0+kze79fNEp32DsxNyTQ3c/DCg4WxB+sZ08KICCcT5JJUCywhOKSgzXnXW4QHNrDQUSwC3740G2QJD3csRJgeYqGizrDyWcmHeZKy8P2K5FyB1MbKgrv4IwheFZ9TxqHb56HYemGmv+J51wpkrhLwkjeO0eKEcqYotL9EVd5+2Uap/L6b9tXT8d7jPy2A/VGt3JBVg5/p3glQRig0DRB+BaMb7d+mbMDBK9Qhd6dh3rJfbg5gXZqbEHHrazNNrGaa5PKOkpRtlhamHwQ6dwBFETzKCjiFZPFRxdZSIL3WHXfh99wgIRlOieIlMbe+jLBTXBQO+OBkZC5pQoUzx0aysf1AjTpQ5bv88ZoUKSjtIU/b/RuD9mUX2DBIj81y6uA3cuDmsDc7RmKqRsFXXLAipTwnB/Dg2n/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hSMFu9TymSQ3OwZFJ2/D7Wk8fmOLZcJmxcMBcOhdHhK2QUIlr5+ixGRFom2EVZfvhMo5eylkA3HoTAdb6NPiQJwz0llZi4HxvxZ7flLG+Py62/ilsdE9nkeSDtpZOa0e4k9hB65uJb22cFa9EjXZlW5LAUW4XCcqqTxBoOgTcPcpFZDOAJ5rvIiehVhapfaLnd71aCJKZH7s3DEeDJTX1JDl0JODNbF9QuNl7tGz745rBjUZzfqcWUyz77dGZqFaEbfcVFjXNeQhrG9q6B6zYknU+VTc3aJFzpQLZFCTpKEX3wTiiimkKBD36L0hNOg9QwdJ+0CMNNs8KfdMvwddY+eI5HMOd+frNVmdOYu564FRgKCw3oGnq2YBvDf79pZqNrrDfFs90Q/t6+yMGREwSKpTxLR7sl8tjq9hQzMDjuHRB8MGQZklEVC8AXtXDZV7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:25.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b7a93b-a3f3-4e67-d3fc-08de8b2d9715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881

Certain amd_pstate freq_attrs such as amd_pstate_hw_prefcore and
amd_pstate_prefcore_ranking are enabled even when preferred core is
not supported on the platform.

Similarly there are common freq_attrs between the amd-pstate and the
amd-pstate-epp drivers (eg: amd_pstate_max_freq,
amd_pstate_lowest_nonlinear_freq, etc.) but are duplicated in two
different freq_attr structs.

Unify all the attributes in a single place and associate each of them
with a visibility function that determines whether the attribute
should be visible based on the underlying platform support and the
current amd_pstate mode.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 124 ++++++++++++++++++++++++++---------
 1 file changed, 93 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 24cdeffbcd40..4de2037a414c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1220,12 +1220,87 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+cpufreq_freq_attr_ro(amd_pstate_max_freq);
+cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
+
+cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
+cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
+cpufreq_freq_attr_rw(energy_performance_preference);
+cpufreq_freq_attr_ro(energy_performance_available_preferences);
+
+struct freq_attr_visibility {
+	struct freq_attr *attr;
+	bool (*visibility_fn)(void);
+};
+
+/* For attributes which are always visible */
+static bool always_visible(void)
+{
+	return true;
+}
+
+/* Determines whether prefcore related attributes should be visible */
+static bool prefcore_visibility(void)
+{
+	return amd_pstate_prefcore;
+}
+
+/* Determines whether energy performance preference should be visible */
+static bool epp_visibility(void)
+{
+	return cppc_state == AMD_PSTATE_ACTIVE;
+}
+
+static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
+	{&amd_pstate_max_freq, always_visible},
+	{&amd_pstate_lowest_nonlinear_freq, always_visible},
+	{&amd_pstate_highest_perf, always_visible},
+	{&amd_pstate_prefcore_ranking, prefcore_visibility},
+	{&amd_pstate_hw_prefcore, prefcore_visibility},
+	{&energy_performance_preference, epp_visibility},
+	{&energy_performance_available_preferences, epp_visibility},
+};
+
+static struct freq_attr **get_freq_attrs(void)
+{
+	bool attr_visible[ARRAY_SIZE(amd_pstate_attr_visibility)];
+	struct freq_attr **attrs;
+	int i, j, count;
+
+	for (i = 0, count = 0; i < ARRAY_SIZE(amd_pstate_attr_visibility); i++) {
+		struct freq_attr_visibility *v = &amd_pstate_attr_visibility[i];
+
+		attr_visible[i] = v->visibility_fn();
+		if (attr_visible[i])
+			count++;
+	}
+
+	/* amd_pstate_{max_freq, lowest_nonlinear_freq, highest_perf} should always be visible */
+	BUG_ON(!count);
+
+	attrs = kcalloc(count + 1, sizeof(struct freq_attr *), GFP_KERNEL);
+	if (!attrs)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(amd_pstate_attr_visibility); i++) {
+		if (!attr_visible[i])
+			continue;
+
+		attrs[j++] = amd_pstate_attr_visibility[i].attr;
+	}
+
+	return attrs;
+}
+
 static void amd_pstate_driver_cleanup(void)
 {
 	if (amd_pstate_prefcore)
 		sched_clear_itmt_support();
 
 	cppc_state = AMD_PSTATE_DISABLE;
+	kfree(current_pstate_driver->attr);
+	current_pstate_driver->attr = NULL;
 	current_pstate_driver = NULL;
 }
 
@@ -1250,6 +1325,7 @@ static int amd_pstate_set_driver(int mode_idx)
 
 static int amd_pstate_register_driver(int mode)
 {
+	struct freq_attr **attr = NULL;
 	int ret;
 
 	ret = amd_pstate_set_driver(mode);
@@ -1258,6 +1334,22 @@ static int amd_pstate_register_driver(int mode)
 
 	cppc_state = mode;
 
+	/*
+	 * Note: It is important to compute the attrs _after_
+	 * re-initializing the cppc_state.  Some attributes become
+	 * visible only when cppc_state is AMD_PSTATE_ACTIVE.
+	 */
+	attr = get_freq_attrs();
+	if (IS_ERR(attr)) {
+		ret = (int) PTR_ERR(attr);
+		pr_err("Couldn't compute freq_attrs for current mode %s [%d]\n",
+			amd_pstate_get_mode_string(cppc_state), ret);
+		amd_pstate_driver_cleanup();
+		return ret;
+	}
+
+	current_pstate_driver->attr = attr;
+
 	/* at least one CPU supports CPB */
 	current_pstate_driver->boost_enabled = cpu_feature_enabled(X86_FEATURE_CPB);
 
@@ -1399,37 +1491,9 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
-cpufreq_freq_attr_ro(amd_pstate_max_freq);
-cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
-
-cpufreq_freq_attr_ro(amd_pstate_highest_perf);
-cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
-cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
-cpufreq_freq_attr_rw(energy_performance_preference);
-cpufreq_freq_attr_ro(energy_performance_available_preferences);
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
 
-static struct freq_attr *amd_pstate_attr[] = {
-	&amd_pstate_max_freq,
-	&amd_pstate_lowest_nonlinear_freq,
-	&amd_pstate_highest_perf,
-	&amd_pstate_prefcore_ranking,
-	&amd_pstate_hw_prefcore,
-	NULL,
-};
-
-static struct freq_attr *amd_pstate_epp_attr[] = {
-	&amd_pstate_max_freq,
-	&amd_pstate_lowest_nonlinear_freq,
-	&amd_pstate_highest_perf,
-	&amd_pstate_prefcore_ranking,
-	&amd_pstate_hw_prefcore,
-	&energy_performance_preference,
-	&energy_performance_available_preferences,
-	NULL,
-};
-
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
@@ -1696,7 +1760,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
-	.attr		= amd_pstate_attr,
 };
 
 static struct cpufreq_driver amd_pstate_epp_driver = {
@@ -1712,7 +1775,6 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.update_limits	= amd_pstate_update_limits,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
-	.attr		= amd_pstate_epp_attr,
 };
 
 /*
@@ -1858,7 +1920,7 @@ static int __init amd_pstate_init(void)
 	return ret;
 
 global_attr_free:
-	cpufreq_unregister_driver(current_pstate_driver);
+	amd_pstate_unregister_driver(0);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1


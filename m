Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42A3C65E9;
	Fri, 20 Mar 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017850; cv=fail; b=ImjNHWG2PtZ5wG5URL4O67WuF2/G3aOBEgP+z6f95ObaIWXDUNpY/VKGj5XO626dhdz1zf3nnKb63JRc88px6AlUUoGcdMAy5ciaIfsk1IlEtMZQUj4EbNu4KGInIeNqq1jWKslJbq8vgoaouK/CnxGqcIcVA9jeXYh4W69taTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017850; c=relaxed/simple;
	bh=FxmQwI+lEr5R2GmKwQuIg0S2nvDH3G2/EGDzvnoWHC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hk/pz8T3P0emVuyhAA9U0i/tyWgWjajzrDKIpd3TL9PVyiD3Eq+SvRDXEdzhL1OCZ3g4AquJmta8kvGRVAPVV0tBPJLHme2VRX1jCdxMNOjpaSuROrHuqheUUmZDbFxK9+jlS4teDRqSfGJaVCRu62/tCA9DGS7xY3/WSTvEUbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBJDtyoA; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBJDtyoA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XoTGIFakYxobsxYzBFDylRWLTfCz7k5pEsczTGHFX+8u6Jq1zd7Aa0BmbmvkEfqImu3c+4kd6ePqCBhtuPisGvAH4Txwa+BLMZlywXahj+FbNeZq9lwEhajioGuJhIbUMgR+pkdyZLDxBW7ApvdZSDuK+VrEUNKd9svv7qVnqR3U32Z36rX0OAkeUeJXEMUH8sR9FWUe+F5oT1D/fzK8aQE6oYAGNm+NCVA9oo2Qef+IKA3eYYG1t6v6208ha72PHke+wEBYp5y4hnuaqhtuv2KKQuHh8fcb/WapCR9GH2fPIHGOb4c0OPQ20rH0dBCGENKmqE7uIpXz0FEnbhWyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XJC9t1OWljSE2wWIaZdI92Lq0JQEL1lL72oJtG0UJc=;
 b=YscMH9D7gKuc2opL6IfKXm4QXeLjEZTb7ZsehwaVfE0RxmdUvVx9KaDE2CtFCgDhoOddarnr+TQVAHR4Senj9NxDGvKsTOUcANKxSeJGJ7rozNbdqK4Q8AjoWHCecjzAjTBdBYfW7DL8s+cLHo/6gXtGbHqRtwnFVvhBg6ge6Pfk+1Z1XxDuwPgCgAIII1Uef3Tb3WvVOgI8U+U17hngXhthdkcAEcrg1lkAvh0tkA6vMNNpTKs+kvMFqnWf1wjwnGnd0+GCKLyic8CVTC/bD+uV0OrA3+3SIww/2CHbtiDs/K67GFwoCEIwfGszHOVj9HMGTv3spqlCok4fXYtTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XJC9t1OWljSE2wWIaZdI92Lq0JQEL1lL72oJtG0UJc=;
 b=WBJDtyoAn/tIyq/fVAI3nOn01Zk/Z40LPcrJIbPwA9c1bzQdBUfwmtry2yYC3js40+xMUsK1PuIbufMEYRz1KJCgnD0TKSYigIrkI5hqtkoyNqhBxEbzFbexZhY/ggRaF8jYaijbbnbL+HDsjzHOZk0V5iLLyY2KohfRwBvy9Jk=
Received: from MN2PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:23a::8)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:44:04 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::df) by MN2PR03CA0003.outlook.office365.com
 (2603:10b6:208:23a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:04 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:00 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 03/12] amd-pstate: Make certain freq_attrs conditionally visible
Date: Fri, 20 Mar 2026 20:13:12 +0530
Message-ID: <20260320144321.18543-4-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320144321.18543-1-gautham.shenoy@amd.com>
References: <20260320144321.18543-1-gautham.shenoy@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: a478aebb-abe2-4859-fd7b-08de868f2207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ey7iqfq2K/UTIgMg0BhzAUCzy4/NzHSgMBKkR5tuA13SA9tX9qhXSWNkGEQJhWtq2jz0sV+jimUWp28LEQaqSXlvoZZqWhFbX60MMM77E4bJNw5JLx4s19XprGy6XQGQOD5hi/vDdwi3zTKl0HKwt280ivpQ7H/47mJbJqO8VsKjHJRdr0njeU9vjGXgjWyM65CrDSfWIiFJWv8exRjSsbrB/CCwbp2vNPurhrY/IzzF8IO3MKTm6McM1KDqcU+PQgjYh2xSesixBvw+ChzsreFDjjkr3dx5alcXBBofaABvPqW8Pwn2DQUzdwz4dUhGu9zuYs1bozk4Gc6Fom3zg+UHj+jvjXf3JyPc1SAfKuaeyK7awQ+/ZNQ6zbyeydepd0cxqIo4GFfrM5w9zSBdETj9GL3voqylr6V1rAeWWGdqQKAlEIzDk0YDrGJMlcWjavMTEe0B5iuM/MkM0J/1pZhNssSobdYJ9mqK9itZFHfQrSM3HL0OK5b5LBfr83L+vtgq9VTGT3vAE+nfo4sVkjyVJe3/FGM8mLxfYT6aQ0fDNe+LvL5gQWPaflI/vkAolUrGZQHFCrY2n67VqnMecp5IdAtvoZjtuy/8FnjBPVcDhAq1gBpy4G6Mdgk8fTn/CGixPA0mg8rG/0S6gVDKjUwiRtHnL/izZfmPYo5X/lRNCHZVuKTH3FL+Ky1aBcMQwvkB4QNkCnKj7Hx4Us+gOg189e8CFatl7AmBFjq/4W1q9jejlapiLgpvhyFyo6/qI1Bhx4zlHMhRZ8sTwEnaAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yYfa5HXwadp1xf0fuLcXUFu1VOTgA+A5fYuyeSmMWrA5zUx+QadRK8G6FVm++3Lw2Gw0ajaIC+9MmfxZ7+S0x1wL8XBBfAyFjg63/bpJx8uR9tXE5qNjl2TnW9Q9N8BDCXr1+1Rzz9FixqVmVCD7JmtA8ZYHmMhY9AHHEn0n+h9YNwzNBdMtb4PFizaCY2+99HIlor/FSqht8jDeHt9P+lU4Iw0gAKXbkJ8uZRSmFwUJAPbTJgtU+ncz3XPdpL+rt4y636E2A0eV7lhKaytAbgzcE2f5WV+WJCyiAUvNb/oBPvXyfHwTzJkN65bavc1gJnDuM6gTFuwA2Zuz1DGum4UZ6x2AnJNebqKSsoKJbuAnslRt72V618mT3CYFKMcHTR3JOrVeB0son9IK/3FGZyMUyqS4Co7PfqY4JcPEFU+1yVdiByapke8ZYq9OFxdg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:04.2217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a478aebb-abe2-4859-fd7b-08de868f2207
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977

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


Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095D372EFD;
	Wed, 11 Mar 2026 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237713; cv=fail; b=VZxYJoRLy4x4aCDEzv0ANotCB5yvuDO4mnQbvnK3kQhbBHtt8AT2GdGG+BFzBNEEzl4d+eppEQQ52StdEjfojuJDI96waNl+i7MVa01ofGcYpGMofWvht1NEnvXdywtwd6asLyEF618PjNVNVUalSktEmnqMoS9jFqUHwpRs4wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237713; c=relaxed/simple;
	bh=ERDLP2yDIE+LbCEpbvCi04ACdHnp9GqSEDVmw4qbRGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge+tlT6CVjhqo2+9d0mWq9C2B4UDSDL5tZ9P/j/kq1WApLLhcobDf6h8neH9OaVfhPzLeTIHBxKfsoKwuvcYw0oA4kMYF66TQPGAFVKSOL76v70s67VVy97YC4er8qUKt7C8uURMHcitp4X4cPonR1NwlLK9/yPb/IAtsYmGmN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjenNMcN; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjenNMcN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcK5vO4yIMZ5ZpcMZuTanliilyM5qZ7bC/UN6rpURXZCRzX2ptWGDgHITuSXiVBIk7d3i84tYI9xCmag/VSnMuCkdyC6xLzyOsCm3Wgsn8k21ONLUqFPzCn/ebSpxTTj8Z2aapUm6w6pH0ISv1J9t22t0pQxtvCjlMpklNwRYux65+1DdeCh2G5ak2pxmx7rPz4c+rasDtct2VMSiLMNpQ1g4fLgtJrGgoeN0IeYgueGm8LefD6/JCdCpnJKiq/1bqMolPqh2nw2n6Su8hov2TZynhWPeXNR8Iau5D8Qgw82AEbu7l/ABptbZULYTLJ9vqyPnRpE4YjjVQmCBQPx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIklXVIqMNnvTwvkJUffYmhLZc1doDN22kT9oQnfjOQ=;
 b=nlegFzfm6Ft+Kl6ZVGyNNZrjODGR2x/KgyY3+eYXDXI0yrkzTDGOSIEokitDzz5MGz/06/4SAdnQE/8U/fkFlRL0yHh13X9M7Gfoo5pw98ZXJLa7zVTM0RQGM34v/11hXoc5CKtDJOSOXFjm9OxQOiJ9DdlZtlXaahxRsWRh2QfGSBuoiwPMXsYmDDz6desxBd3QtssubYWl48JCYQWbcINhQ32aLfUu3VEifyQdJNjGVUSpHlrIaiSGgwmAmrQi51CO+/0XwVqBiO4ZKYXrMWL2pHALpd2tLTfqQcZULZJfgpw3jFDza1240C3IAKHjF5zKHF2s2T1sb/wRQ8n3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIklXVIqMNnvTwvkJUffYmhLZc1doDN22kT9oQnfjOQ=;
 b=OjenNMcNsmZLB7yaZ8qfne1539x36qCmtRViqO0akXyTj2OFxhIgEkpD0IUWXsCDgyWTsM5GZoSy2k+6P3cq0hWhzoWjeeOnAi6VfKzUSaM2bGtwOujCsETT9ThoHtBLo3RdroLIA4EKav9vkknNBO2QoOU2pxuuGCoVx6UVJ7o=
Received: from SJ2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:a03:505::26)
 by SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 14:01:48 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::14) by SJ2PR07CA0003.outlook.office365.com
 (2603:10b6:a03:505::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 14:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 14:01:47 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 09:01:45 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v2 3/9] amd-pstate: Make certain freq_attrs conditionally visible
Date: Wed, 11 Mar 2026 19:31:10 +0530
Message-ID: <20260311140116.19604-4-gautham.shenoy@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311140116.19604-1-gautham.shenoy@amd.com>
References: <20260311140116.19604-1-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SA1PR12MB999110:EE_
X-MS-Office365-Filtering-Correlation-Id: 2498fd9b-2d83-4b12-6b33-08de7f76bc9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	U0frJksKbQtY+4WisFYg+uw/u8/uZpsDRsOPiUV6ReWf6YkUqBoLCwLjaKNLurkpaEviEAybHnAEfZ5n/LQcOJ+z5i6bHzCuB4TIRsecjJpsFw6lFTtBDam3qVYvJMbuZk3HEwzOSOK4O1vBifGJk2WU7sUUAqug6BlNYYv//0LYiWjdW6rroGcbsx4sJpug0TUnvKLWMDsFGUb+I9vSb+2tb4sl7objKIbu+LuboQA7NHs+tzJWMTntdqaEFbD6Wv8E7X8gFqqVRaXP9DgIiqiKDo+OV8R2uETf//EhWZ7g/Rz3c59pQlWwmGXoNHYxSs2EtWJ2CXhRWYbkVtsmwdNEaJXBzwSxAW8m7dtdqgClzcF+DkJE0RhAscXqEK1YaT/zo7y7mi7dytnPSJanioujGCT4JjyZl0c4vsu7nzyTLngRAD98DeCfnO06cYlD5hfLAh4anZmpY0zuZA7BhVqdUuJG+6Sbkd2SfmuUXG0mReNU3buMtw73LHib9LBLyl27nR+VEE22kLixztUKM9ow341npAbbvY6JprSqh0Lc5qAMTqXhHLSKAwacMxBZbk1uPwDmklEf/jTt1yDkuIBAiFJyLZe+huwDk3TTMbjKTLufj6FnAswnKszHaXqNPvUNQQxJLjMrWDq1PJI60IXrIN7M9nFPi9TAwrpAj0mQYdjbHffj756+LKDjWqPyoQr3Ejr1xmxk3JuZnqEKIpyjO3wG2zOXlsWvg1mesQDdIqOur5/OUrWolZVyFmAINtQjErgLtYqxemti2uG3gw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8hQfe3KKC/H1xcmVJyEpQ4C5cScpk5HDcDpYd2SiXMN2sutuVFvChV75ac0cohWHZRX4q+bU0dKhHXFlV9yhkn+tjLUq0ktQfM43RCXX0iQHZZ59alslGLuyGlGU/Cop9Lz123jRSftulvk7sbjOrO9e1thnjuN+x91oSjxXuXZze/2aymj02p8OXKWZjru8QEvAyIZZUMKNnHiXKsJOyEcOslV/hSPD54TJyDF5mWfJPTPVUzUr9OQLXwjTEYY9sLpfjJS5ovS7pgTHx0qkZq/YgNuNOXEC3HZ2hRpFrtDoQv17R90GzTvWZ2MApLE9RpdLmwjGySgxWS+zrx3w4yvsam3UqC4nVClILRusYL0XkYn6pUgh46udYMshoYj1MZ1rplsYrNAF3HbWwjq9iEC/NXfzlZ8XBQJgI0aeKxc+woELSaOJQClZ3o9lVwtc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 14:01:47.9476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2498fd9b-2d83-4b12-6b33-08de7f76bc9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110

Certain amd_pstate freq_attrs such as amd_pstate_hw_prefcore and
amd_pstate_prefcore_ranking are enabled even when preferred core is
not supported on the platform.

Similarly there are common freq_attrs between the amd-pstate and the
amd-pstate-epp drivers (eg: amd_pstate_max_freq,
amd_pstate_lowest_non_linear_freq, etc.) but are duplicated in two
different freq_attr structs.

Unify all the attributes in a single place and associate each of them
with a visibility function that determines whether the attribute
should be visible based on the underlying platform support and the
current amd_pstate mode.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 123 ++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 24cdeffbcd40e..fb5d7bb320c15 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1220,12 +1220,86 @@ static ssize_t show_energy_performance_preference(
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
+	/* amd_pstate_{max_freq, lowest_nonlinear_freq, highest_freq} should always be visible */
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
 	current_pstate_driver = NULL;
 }
 
@@ -1250,6 +1324,7 @@ static int amd_pstate_set_driver(int mode_idx)
 
 static int amd_pstate_register_driver(int mode)
 {
+	struct freq_attr **attr = NULL;
 	int ret;
 
 	ret = amd_pstate_set_driver(mode);
@@ -1258,6 +1333,22 @@ static int amd_pstate_register_driver(int mode)
 
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
 
@@ -1399,37 +1490,9 @@ static ssize_t prefcore_show(struct device *dev,
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
@@ -1696,7 +1759,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
-	.attr		= amd_pstate_attr,
 };
 
 static struct cpufreq_driver amd_pstate_epp_driver = {
@@ -1712,7 +1774,6 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.update_limits	= amd_pstate_update_limits,
 	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate-epp",
-	.attr		= amd_pstate_epp_attr,
 };
 
 /*
@@ -1858,7 +1919,7 @@ static int __init amd_pstate_init(void)
 	return ret;
 
 global_attr_free:
-	cpufreq_unregister_driver(current_pstate_driver);
+	amd_pstate_unregister_driver(0);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1


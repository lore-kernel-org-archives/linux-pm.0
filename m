Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4D3C65E9;
	Fri, 20 Mar 2026 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017858; cv=fail; b=QSklwIicXUcsWnGP4GfnoV64vqWNBa5F/UG/puO5fGFdxXBwnnXKNJll9b5cY0b40FER/YKQhE++6mvZvKXOa34Mfm2gitedlEHArHymaAYvTSTcQz2psaGVFFiMO8etqxvmNB+2LPAkA/Wvdj7WnPPplwFrSGzlLe3NHjPwHI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017858; c=relaxed/simple;
	bh=XvSHxf8TfXmE2bdskOFFQNxmD9GW0iwKprr7Vt0HrDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ts++ETt70kMRsxI5skCRy7IkNtMmnVQ5xgfHRM+/OPcAtC0GLggiHp9rq4wQAlOyKUbnHVCpOf1Ed6lJW/I74yv+sbM8tYRpAhXFl/fCm4O3SlQm66PIZERsrf6lYBCSFzVQMPvZdZMBupaLymmE7lLP8UwsCxkKy5E7dgfp2Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X1Ixthnh; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X1Ixthnh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM2NkuLkSuky9DKoXkd/aOhsjC0VjPK3i/OjmCAMXxKrO2daQrZye8ikjmfBdB5zsC4lSs4/9jsvgCeZO9+ZXQkdnnXDJbXCmeOi3yJ12WeE3q3emSHdHc7xno+cyq3ksWSeltRvQRA4Lpe0O5tbyo5EiBH9gyeEwIqPKI8p+0QAeFSL4Up0jR4REAfBcmWkfBb/UsTSw4bZN++w0UEkw9IRHyewm8Wp3f33dGdcxibHq8u1HBXDkaOajbyY5mXRDqn7GS8QffuhDHAtTbW0qg8Pt+WuBKxVzXi16jHImYEyuhcjnlmcW6VU0OSHrUtiwfZm/0ObcVAfy9xyEc2olA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWv768GogPeeA8M+vOMfiFox17zHV7ZjegIymU7gKGI=;
 b=aV2ndW3oO9tEAMQ8tg8D2T63shMJsgmyEijGSRnYL6Zv53GPkwO+oh0SBkQRpXZiHyiLrj2BIwgtc7/Ll/MGJGbZEpCH+8lWj/7f11CT4VR4v9pDTNMYjrOH0ub2+MzLTWvDKnnN471eTO6PDJCxOs5gEFnAAB0LlRRlEjZYTnl6Upppy8RQtI5rbn0zSa7nzZa9PesQdkNLMpP7DiJmVglTO5K3Lv+ol271tu2EHXDPfQ1eidpqh4EeySvhkYcrHjq0uasHdVJnZKayJ7CA9LbHkfkTMSxJe2Pm0E01owKaE6k9hwyR2JZ5KufOYmFTs0aukOolJzhK1NOYb687Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWv768GogPeeA8M+vOMfiFox17zHV7ZjegIymU7gKGI=;
 b=X1IxthnhM6LLpEmL5UyXN9lr1/UG0SnExQ3GKbIxjutsp4baCygWG+on3pnRHM7mg/kwZmhnT0AhEWPH+lQbXohG6EnSyS4P4zRfhtHsGeFnJFlZbpWbqrYZyscc+At4lkyd45Aow/CX+lROrapGmXUd7KnsomBF6jbhkhhlduQ=
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by PH7PR12MB9224.namprd12.prod.outlook.com (2603:10b6:510:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:44:11 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::c0) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:44:11 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:44:08 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>
Subject: [PATCH v3 06/12] amd-pstate: Add sysfs support for floor_freq and floor_count
Date: Fri, 20 Mar 2026 20:13:15 +0530
Message-ID: <20260320144321.18543-7-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|PH7PR12MB9224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e77e56c-9ac3-4523-23c7-08de868f2621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5ub//GF4+Ksw+ybPWA64yyjJXFKsMTQo2d/G6iQzGjawEKFaWL8D9QX9xqEXlo1Yn22Ujhy0CeI9vgS+SMV4cZeiK955c7LT0QYxMolS6t0nUZEpuB/PjjMvAYpJZ0u014CM9ID1MY4Iq6lIGvo7fF8TLjKxnK3VJ3JcOroknP8zyaIFZCpOifL3xUGoo4hJbN5Mgi9F4q72otgp/KNmnT/e7EyX/vWNChU0o6HAZA+tJQuvaBEImS/J21wlA/Nbj8DlTS2uosMQPNJqnAkny2OqqQScdIhectoq4Cj/fWmIV4w/qeWJP3+smkobBGKKFFw7kBVO3ylgYMZizw0x0IcN5RyyyfuoHpz6T3+PKO6W10Yzlofix43KQkbmy3HrrpmkxEZryTHNshcvIzRH7+781OL4xGvG6cLSErMvZZ1REowTCZhFtOyKPpE7CMTQwj4uQZvwCsGI7junLcvLyFEjbpBAa2tA9XljMK1Ke76j7I+O/0Em4VjDKeDVI3kCMQk4RBwTE4eXYi2yXqIAkMby4S3/fODtyPwda0UVnKszKw++FZOmVyXhtQtn0HoExw6GFCpNIptMb6hBb1NkkDM+WDkmun57mqK5awIj9gkX8OSLQI2iATJ9w8Dy6tv3Z6YhASGkMK2PR1RguYfTrAPzSfhNNFOZnaR04crrku0uS3xNS6r+ON65iVpEzyy7dNbyI62rqv6ryMOH+pNzyHliWWUxaoP/FAZWBmcWMZ9Cd8083MjXMPXOz0TZiLW5u9WnR0MT9eZD7/PygJW7dw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	isznfpYbHPVrEgJuWCIEetXZqcv1qf0KWY97sA5q+YmDHEceaxO0aG/u7WdCZA6TbSNXxeV57x3IJoRSNOsAlV1i8hKZXENXd50cUPjBJnnn8UsjfFvDQpHyqGhu/vAa4TB7v3gcv2UC8lD5TGXBSIoXx0W9pHT7M8gktU6EiYJF/TJpvpZroSV9AApYbrGp6BF0/wQbfOt5XUdRiAVGkOroi/6Ehnd57lGhCBkQ3xxro23jRHbqBZYPMgA/GRCMvaIsqOCF3ljcnL5uxmtih6qziFGtqn05FdCODnxGW9MGgib8qs7v05b22Kay23IOCRkj3J+CHnq7qUf9Zk2COlKLgWsbkOYLEQoyfN8ibIgC8b+XqFE9wMzf/OJDKVyFGVZIb1sVZD3pHuLi7HTOKxt8qw+jmePrj/G9xgG9QsUUwX+maXcgXe1Dzni1XzAJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:44:11.0988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e77e56c-9ac3-4523-23c7-08de868f2621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9224

When Floor Performance feature is supported by the platform, expose
two sysfs files:

   * amd_pstate_floor_freq to allow userspace to request the floor
     frequency for each CPU.

   * amd_pstate_floor_count which advertises the number of distinct
     levels of floor frequencies supported on this platform.

Reset the floor_perf to bios_floor_perf in the suspend, offline, and
exit paths, and restore the value to the cached user-request
floor_freq on the resume and online paths mirroring how bios_min_perf
is handled for MSR_AMD_CPPC_REQ.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 93 +++++++++++++++++++++++++++++++++---
 drivers/cpufreq/amd-pstate.h |  2 +
 2 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 53b8173ff183..a068c4457a8f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -383,8 +383,10 @@ static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
 			return ret;
 	}
 
-	cpudata->bios_floor_perf = floor_perf;
 
+	cpudata->bios_floor_perf = floor_perf;
+	cpudata->floor_freq = perf_to_freq(cpudata->perf, cpudata->nominal_freq,
+					   floor_perf);
 	return 0;
 }
 
@@ -1288,6 +1290,46 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static ssize_t store_amd_pstate_floor_freq(struct cpufreq_policy *policy,
+					   const char *buf, size_t count)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	unsigned int freq;
+	u8 floor_perf;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &freq);
+	if (ret)
+		return ret;
+
+	if (freq < policy->cpuinfo.min_freq || freq > policy->max)
+		return -EINVAL;
+
+	floor_perf = freq_to_perf(perf, cpudata->nominal_freq, freq);
+	ret = amd_pstate_set_floor_perf(policy, floor_perf);
+
+	if (!ret)
+		cpudata->floor_freq = freq;
+
+	return ret ?: count;
+}
+
+static ssize_t show_amd_pstate_floor_freq(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	return sysfs_emit(buf, "%u\n", cpudata->floor_freq);
+}
+
+static ssize_t show_amd_pstate_floor_count(struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u8 count = cpudata->floor_perf_cnt;
+
+	return sysfs_emit(buf, "%u\n", count);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
@@ -1296,6 +1338,8 @@ cpufreq_freq_attr_ro(amd_pstate_prefcore_ranking);
 cpufreq_freq_attr_ro(amd_pstate_hw_prefcore);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+cpufreq_freq_attr_rw(amd_pstate_floor_freq);
+cpufreq_freq_attr_ro(amd_pstate_floor_count);
 
 struct freq_attr_visibility {
 	struct freq_attr *attr;
@@ -1320,6 +1364,12 @@ static bool epp_visibility(void)
 	return cppc_state == AMD_PSTATE_ACTIVE;
 }
 
+/* Determines whether amd_pstate_floor_freq related attributes should be visible */
+static bool floor_freq_visibility(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO);
+}
+
 static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_max_freq, always_visible},
 	{&amd_pstate_lowest_nonlinear_freq, always_visible},
@@ -1328,6 +1378,8 @@ static struct freq_attr_visibility amd_pstate_attr_visibility[] = {
 	{&amd_pstate_hw_prefcore, prefcore_visibility},
 	{&energy_performance_preference, epp_visibility},
 	{&energy_performance_available_preferences, epp_visibility},
+	{&amd_pstate_floor_freq, floor_freq_visibility},
+	{&amd_pstate_floor_count, floor_freq_visibility},
 };
 
 static struct freq_attr **get_freq_attrs(void)
@@ -1748,24 +1800,39 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 
 static int amd_pstate_cpu_online(struct cpufreq_policy *policy)
 {
-	return amd_pstate_cppc_enable(policy);
+	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	u8 cached_floor_perf;
+	int ret;
+
+	ret = amd_pstate_cppc_enable(policy);
+	if (ret)
+		return ret;
+
+	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
+	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
 }
 
 static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
+	int ret;
 
 	/*
 	 * Reset CPPC_REQ MSR to the BIOS value, this will allow us to retain the BIOS specified
 	 * min_perf value across kexec reboots. If this CPU is just onlined normally after this, the
 	 * limits, epp and desired perf will get reset to the cached values in cpudata struct
 	 */
-	return amd_pstate_update_perf(policy, perf.bios_min_perf,
+	ret = amd_pstate_update_perf(policy, perf.bios_min_perf,
 				     FIELD_GET(AMD_CPPC_DES_PERF_MASK, cpudata->cppc_req_cached),
 				     FIELD_GET(AMD_CPPC_MAX_PERF_MASK, cpudata->cppc_req_cached),
 				     FIELD_GET(AMD_CPPC_EPP_PERF_MASK, cpudata->cppc_req_cached),
 				     false);
+	if (ret)
+		return ret;
+
+	return amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
 }
 
 static int amd_pstate_suspend(struct cpufreq_policy *policy)
@@ -1787,6 +1854,10 @@ static int amd_pstate_suspend(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
+	ret = amd_pstate_set_floor_perf(policy, cpudata->bios_floor_perf);
+	if (ret)
+		return ret;
+
 	/* set this flag to avoid setting core offline*/
 	cpudata->suspended = true;
 
@@ -1798,15 +1869,24 @@ static int amd_pstate_resume(struct cpufreq_policy *policy)
 	struct amd_cpudata *cpudata = policy->driver_data;
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	int cur_perf = freq_to_perf(perf, cpudata->nominal_freq, policy->cur);
+	u8 cached_floor_perf;
+	int ret;
 
 	/* Set CPPC_REQ to last sane value until the governor updates it */
-	return amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
-				      0U, false);
+	ret = amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
+				     0U, false);
+	if (ret)
+		return ret;
+
+	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
+	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
 }
 
 static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 {
 	struct amd_cpudata *cpudata = policy->driver_data;
+	union perf_cached perf = READ_ONCE(cpudata->perf);
+	u8 cached_floor_perf;
 
 	if (cpudata->suspended) {
 		int ret;
@@ -1819,7 +1899,8 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 		cpudata->suspended = false;
 	}
 
-	return 0;
+	cached_floor_perf = freq_to_perf(perf, cpudata->nominal_freq, cpudata->floor_freq);
+	return amd_pstate_set_floor_perf(policy, cached_floor_perf);
 }
 
 static struct cpufreq_driver amd_pstate_driver = {
diff --git a/drivers/cpufreq/amd-pstate.h b/drivers/cpufreq/amd-pstate.h
index f04561da4518..2f7a96836fcd 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -72,6 +72,7 @@ struct amd_aperf_mperf {
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
  * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
+ * @floor_freq: Cached value of the user requested floor_freq
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value (in khz)
@@ -101,6 +102,7 @@ struct amd_cpudata {
 	u32	max_limit_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+	u32	floor_freq;
 
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
-- 
2.34.1


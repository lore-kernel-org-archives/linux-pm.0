Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34A3F65F1;
	Thu, 26 Mar 2026 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525727; cv=fail; b=qTnMhsYi6GXN1HIS7CfUy3ZcDn1AtG7JFGJZOv0p5Piih2r2U/JeektNSQ0gi28JftfV/30ylbFCoD5OK9zd67dIrjg73TcCfQqgIGaVFFgpQmhLZh7iEluFns4ZstmLQX7HAtdwjvlF6WYiHoc8NUNbYRCo74tdUagS8xiFzQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525727; c=relaxed/simple;
	bh=iopGlz2xuw0TM6h5DGqFGtmCKU4VDmaMm91FVUokWnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqh7noEBlUSqCBDtNrv6S7xWtsNLkSiHTaNopTPYIjhlNcUEo2v5vGD+7cSmd6fHcKFUiWOSpgGoICx8urnGQ+RCnxPuX5wjqlTlLOEh7qwtXeXKYEbwk3SnSC2JbIYXvfy8ZVpfCaAUaDSQE1Rs3i3xhFzs+eFVBC0nYRCoe5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=li6KXDXW; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="li6KXDXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7tI9IDTuNhYrSJzRkQI1gfjpx8x2lPD+ULkVSo9adugnPNlVjQeFTFVxu5uMge1D9DGCt6ZvcGbdwrQgxpwj8VhQpPJ5grbDozsVKnLyap22UuMLpx7HDfy64jD6GfEYnlNbSQJeidtwyU1iBw0EpoiJtBDj848YmxWnQ9ky+/d0+ODYcBHuCBvLRkYDMDv8pdwjeyGjWnTAqhRKXDMHVQvjUIczr8x6VdU7pSfcfT6ya/BoSRCot8en+gHMvba4fwIhRGlMT4jbNRZxVyS+h+pM77t6hY3iCEmtk/rw+bpzAshWIM/sJiP/giUeKNUszMe/JqFKPOq6A8MKJSPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnLjUEOUlQ6IZPBZdMxyh/x3IoS2QhHxbcpFoZgwN74=;
 b=jvwLMiXuG+WrY53YrQxIsVHDgBvqWWz27PtQF1rE+B7L6BoZjSbS3y4QdnTMe1NRFvqPEVh/IBQueGtDFH17lVlQFIV+azpU3qxe0Di6YTDk6syyDwVS5BA1+Ebn2YbsbqrfCK5t/Q5K9fKb6nzIwBmXyQ3BMeT4UtvUA+s3nFbYLJEAXRTDaaz+by9nP3sGjgJFqLxw468ni82i+q3s+EaAV24W4xy4B8A/9ylakPi7RJMY/LI5Ff3X5hK5/0U3qN2Ac92wU2XLCrTOYEVdZMXsWFJYlvo5oSJ3h6f7SLrmeAUugZh0fK4KuYFCwFpDn7x9lRZ3KJABgzFcVvzwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnLjUEOUlQ6IZPBZdMxyh/x3IoS2QhHxbcpFoZgwN74=;
 b=li6KXDXWFU4QzsIzWowdWChwuDFBLhy8ZpGPFPR4qNXRlaE3VXjZ6gNTk5bcVambZjGpX0yIlm+rGFT7YGYgHPS93FutnvcEfFIeuR8+FNx53MKWL/XX7ouRabH/hYVWSlQBg5o+cBo4UHeLOQp8CB8BQmAjeWJtxAPiSpMGHxs=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 11:48:35 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2b:cafe::6d) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Thu,
 26 Mar 2026 11:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 11:48:34 +0000
Received: from BLRRASHENOY1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 06:48:31 -0500
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v4 06/12] amd-pstate: Add sysfs support for floor_freq and floor_count
Date: Thu, 26 Mar 2026 17:17:50 +0530
Message-ID: <20260326114756.20374-7-gautham.shenoy@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c97cb4-7494-4ff1-82db-08de8b2d9c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w/VkZsPDY8i9h7cmyoR/7vRE4GtlsEM0rhmJ6HR0E34h6rRj21GjW1oJfN92n9QTnvcsH+W1Hd236QKyq6kE8k6qdBnUPfekfxrweWobCGa7i70465caU+PrlKVMPyC/j5JNyTbYfkif5zylEPLWifxuEyTl5U0fvOSuYJ4ZZ5MYboWFQkDj2sFZXsSoRbEKo/WYKSd+SGC40vi1XKFdGQ9/RTAdn95gSuOu1IKdRlb2U+7RJUl2qZTDTECRji4P+NZXCQWsnnJ7G5Q9Mx/x6vVxJsM3Lx97Rzjp8UV8944ILOUgiUJ1p/MxKLhpSNIqdtUSUzUytnJWBt/6FKVWw3XWuG3qF9i8SF1E1kR8z5Bu+szbtHE+LklUQTp1gvYMQD12cxwgFVWNsv37jFw6Dmx755ifuhyeIvhvIeEM6plStqEfDU8qhV6rpvQ2bOwOdgidYUbclrjbSV0tDcfFVnImlO6rr0GXnxshZxEXTMyfSv7BC3Tx2q1iIxZ35qJyQizO9uYDjX08ukHOX2NCdQIg8mpYmsQqvYc1+SQ83Q1MB+RqLj4SHwIOFkH+5Y1PcVFrI+NES5mZAek1bRm3O8uuiF1DrpyiKJrbsoTQ5cE6FfLUvIlcnYHNZ1l+VCY8gcPxOXp/an5kpSY10IXyHlTweXxWuD56N3fr0H/IEg+CpeOFxWGJA5YcC+kD9Z6hA8zOo0Z0218J+vyvmD43xysYPApeu8LEIGUXueDLyK0kaUFmCljg/oTyVhm5YJvNg7+loky1ICko71D+D9u/lw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sqEMZrVlg8UY7htRTi1INSNM8xmC6qlz9k1s8ZR6CHLzRVLo37KDMTxfAUQHJzqrD6edrla/1vOhDJiRbxW8gdl+lB06K1OtzV/rl6ECVx24HTlzmC0YRv6PbV2TBEyvnZP0NdI14IPWNGpCYoH5OeOjGX7YAcd6HA+uzHaJrrz7GRFtWgWOUMrfo8ksIC7SOQG3Ud77ITvpyDjYVhtmIIR8IqCUV8QDGHI3GfvZOf9nK+eJf+O1ydOYvZRT4vsMctZoVg0vUSBHyJmOKfMhLHrCzlndnmrj+UDJ9JmGXnOAnOpEIYzt2moLVnMHIR3QQZnfsGfkyG9ka45tDF+HssHMz//OFaQV+mc0LESVEQG1nolMHmsg+kOXYQMamYIVUJcGuS0s5UmTomiQLkaYm3AYW4fxuyMaDQIKDpiyEuMM1UEyAze6Spv5pCDsfeju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 11:48:34.6865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c97cb4-7494-4ff1-82db-08de8b2d9c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180

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

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
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
index 303da70b0afa..453adfb445f8 100644
--- a/drivers/cpufreq/amd-pstate.h
+++ b/drivers/cpufreq/amd-pstate.h
@@ -74,6 +74,7 @@ struct amd_aperf_mperf {
  * @max_limit_freq: Cached value of policy->max (in khz)
  * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
  * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
+ * @floor_freq: Cached value of the user requested floor_freq
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value (in khz)
@@ -103,6 +104,7 @@ struct amd_cpudata {
 	u32	max_limit_freq;
 	u32	nominal_freq;
 	u32	lowest_nonlinear_freq;
+	u32	floor_freq;
 
 	struct amd_aperf_mperf cur;
 	struct amd_aperf_mperf prev;
-- 
2.34.1


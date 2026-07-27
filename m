Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D623DCDAC;
	Mon, 27 Jul 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136974; cv=fail; b=X0dr7XCE2ZAbQ9X9yNBOVbwur3Q3TFmtyKmOEuuiS54WKwx7AGcocAHtgzoB7zlxrGeTo9qq1A8Ry9YAm6Zu9aTV+uyawy8+JKUAEzm5XsNXqhwkuybUcJ6T1MCdhNnHEHxldLFUerxv710byZVoQD5esDiDTGnKd9AAipbIjlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136974; c=relaxed/simple;
	bh=ynfBO4o1jIyPSkVYTgz5skQOsxaXApfqQBfX043qfMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PmSWIXC6mGKh9ifEV0JZnYJQq2kNS5C6JzZ1+h9CklMlyg0PwN3K1HybLf0qQBp5v5OChLxZXm+rW+xtgxKloSBW6r1ZHd8Jklc1rohtUCEEHOy7mVD7RTxRDTDdsg/jzsAddDdFAXeBHM2jfkCJm5rOR+DFW7YmIOMqxSSM5/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CU2t8w0n; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CU2t8w0n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epoRcUF5LgqplrDDQFi1Uiv9EoJOZg6UL4SbDw69z/MskMJwnwZH6cIRHg1gbB8Pt0rnAy3q8Ljm5PXMNcGg9o4qr1SLXxPi+roLKFuDgbNgmveTyDE36uQhb5FCLEVKKI6zqli6vRD9qk9Xk0a8le11ko556W3RwOyCIjAzefoJcTJOWsSbpCeex/Bx+cFOnG5e/y0rrJTob/V3ZxD5APrVwnHzKqlDhRXaOWUsrmK9aD4JjGwuE72yxrqFHNrlGDvWDl6m/0wgmbfo35oP4/iJq7ExiAzsPRwx8BVjErOMH2k1ksubjalLSQOWT2meUpvsJx+89zK4yzjIq0t5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doh2clSuLJe8v5vu8SCycqqTg1NXEv49DvlGpkrQRj8=;
 b=xHyse2PGwLP18nkOttraWx1n339Q0E1N3vI79WSt+ggPh0yrpWZqf1i6gRW7O30roq6i5axgaCAaXiAybd4YyvnOU1vqohXjBgFYb725AScxDt+JGbPUEHEOaSTNvSpMnf0GkDnUKB6/IcOOJ1cjdbiJErFISpOou/t0r3Te08dGcxSDN6OuLxDLzsH2BLt6HVLfV6rJKxnSF+E9fPpUVDw15zJh1N3iPMjChPHVlWST7/HugRJ2Y/u+rWzAV8Ywy1DqDD9Tzi3Qoapabbf7GpEaazmGbIRlJWwUeVq95Z9rYFc2y9iWXziOwmgZsZHcU2xD9TWjmicY/eQo8geWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doh2clSuLJe8v5vu8SCycqqTg1NXEv49DvlGpkrQRj8=;
 b=CU2t8w0naJk/5Tcy4J7RVhb3lK8AvKkQ8WeHzZN3qDH8E0E2bUvJ3/e+1tqdVzE+wy1+cahG/9TkqBU2PyIEro8aAuyFqGlXcIabGeMuf2gW6gxKw/MMpXB0BC0Dm6F6gAs0nNA3rjy9a3O9J3uHj4YktZv69tuFERKGvNv2d2c=
Received: from BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::12)
 by IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:22:46 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::65) by BL1P221CA0001.outlook.office365.com
 (2603:10b6:208:2c5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:22:46 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:22:42 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3 5/9] cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp" sysfs
Date: Mon, 27 Jul 2026 07:20:52 +0000
Message-ID: <20260727072056.1248-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: da34451d-451e-43af-2063-08deebafdb92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|5023799004|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	84VG9yN+gr6ZZauo674t137PgS+u/F2YcFt67qmrJ7IjSRckUZWUNMWEfsgVh/e6vAIA5mZYPCT/JRfT+7JH4paVCz5x1v3tt8H9tdITRWOsdxh7Trm/6Bm536pziLY/PFP3qtcIYx457XKE+mVdT9Mq1TJq+phj6WEVgYK3XXtJ0s/mrO2R9xuV34cCSDBvVvDQU8jHh1zc6bxfGKvOSYDqMvtcoiiGnbzBfWg/AEko98kk4THpagZjNtAeohOe2XuolyWFR6yMZvaAgOVHYUEWzJ+WywH4FEHrmZPSPps8EN4PcXzFdV70ulfeDwiCqrzv2ow9+tesJFyPNd7zq+SpZLhTqxMzii6BhRnVsjIkpWJc7TMLwgXLBPTwaZBcqA8uwxgwUMqjTajcvyvikeWjFMqTQ3MHlGbnrniB5eD6M/1dIzMwxQ/sRVT7q2PpU4x1EvolF2/MgTjXk9NYNSvX9Rh9q12L6dlN5XFxmN5XKePd+3BVkqSn3WQ74pXMOK61uKrBYKwCCN2Lq/HvL1iySWIeXHl6S8yNTsOdOL1E6sKTvXCAZfR37nKNwq2VNmIgw5Cy3w92PDQnYzi3I+VKc+VuDwu5D46aZOssLYX5vifxBJW0b789WfjoBoNsMR1G8FXAQYLgOskSSH8uRFIkuqWdM+vrFBU/4f32cpw3ywEBxS1KFOJUMooozwYsWHGYUOBBDWHJJfRZmMyAqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zEIAK16w8mrMSgBsyMWUoM6bdTypB137eRehtUUD15jA9gEnL029ib8y9UZJ7jVSKagENHsI/pFkQTaDyz+yKQ1BVHE76+vjxNZXk0YPDKR49PDSVMQle6w+N5GR1K4KdXx2JlnWnEbaJDuuBO3YwLaele1KlGtKz5mvRM/MAmlXFE+P50S1M4CupnRs/XQz8C0tBWr9o3++UGQK2+ziP1pqMTcHpobTgkIx3vfir0jWcw6djV+z7spyywRtaD3rFHzp3N4J2j4JLJXCgxCVUhtJl79Hu+tBGYPq4mnHVpxbRPpv69s4OAeb7S8FTjghuexiIBmoWGkVpC5ZmvSUhfGI3EnkLNdRe8jm/IRZsQW23na6XVVHY5wOw+uK/JRFSO8A0xYBm6qwYFNL2qU3YHD8QW+YdCoD8z7H6qfOuk99hggR7qqRbn+qbBTSbIKv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:22:46.8339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da34451d-451e-43af-2063-08deebafdb92
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838

Since dynamic_epp has been converted to an
"energy_performance_preference", toggling the feature via the sysfs file
or the kernel cmdline is now redundant.

Remove the sysfs file and the "amd_dynamic_epp" cmdline and only depend
on "energy_performance_preference" to toggle dynamic_epp.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v2..v3:

o Collected tag from Mario. (Thanks a ton!)
---
 drivers/cpufreq/amd-pstate.c | 55 +-----------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fdf3106f6e07..a380c665461f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -87,7 +87,6 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
-static bool dynamic_epp;
 static struct quirk_entry *quirks;
 
 /*
@@ -1837,50 +1836,12 @@ static ssize_t prefcore_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", str_enabled_disabled(amd_pstate_prefcore));
 }
 
-static ssize_t dynamic_epp_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%s\n", str_enabled_disabled(dynamic_epp));
-}
-
-static ssize_t dynamic_epp_store(struct device *a, struct device_attribute *b,
-				 const char *buf, size_t count)
-{
-	bool enabled;
-	int ret;
-
-	ret = kstrtobool(buf, &enabled);
-	if (ret)
-		return ret;
-
-	guard(mutex)(&amd_pstate_driver_lock);
-
-	if (cppc_state != AMD_PSTATE_ACTIVE) {
-		pr_debug("dynamic_epp can only be toggled in active mode\n");
-		return -EINVAL;
-	}
-
-	/* Nothing to do */
-	if (dynamic_epp == enabled)
-		return count;
-
-	/* reinitialize with desired dynamic EPP value */
-	dynamic_epp = enabled;
-	ret = amd_pstate_change_driver_mode(cppc_state);
-	if (ret)
-		dynamic_epp = false;
-
-	return ret ? ret : count;
-}
-
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(prefcore);
-static DEVICE_ATTR_RW(dynamic_epp);
 
 static struct attribute *pstate_global_attributes[] = {
 	&dev_attr_status.attr,
 	&dev_attr_prefcore.attr,
-	&dev_attr_dynamic_epp.attr,
 	NULL
 };
 
@@ -1987,10 +1948,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
-	if (dynamic_epp)
-		ret = amd_pstate_set_dynamic_epp(policy);
-	else
-		ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
+	ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
 	if (ret)
 		goto free_cpudata1;
 
@@ -2401,19 +2359,8 @@ static int __init amd_prefcore_param(char *str)
 	return 0;
 }
 
-static int __init amd_dynamic_epp_param(char *str)
-{
-	if (!strcmp(str, "disable"))
-		dynamic_epp = false;
-	if (!strcmp(str, "enable"))
-		dynamic_epp = true;
-
-	return 0;
-}
-
 early_param("amd_pstate", amd_pstate_param);
 early_param("amd_prefcore", amd_prefcore_param);
-early_param("amd_dynamic_epp", amd_dynamic_epp_param);
 
 MODULE_AUTHOR("Huang Rui <ray.huang@amd.com>");
 MODULE_DESCRIPTION("AMD Processor P-state Frequency Driver");
-- 
2.34.1


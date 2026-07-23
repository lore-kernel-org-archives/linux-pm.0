Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5618E418A30;
	Thu, 23 Jul 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837670; cv=fail; b=aEwYbzT2KdBlf/9hG3Ko99DKfpluQlhBURNcVabCNiMO50pn9QHG1gutmYS1xdHGy00q2bTP6MaNW8wKWYx0q4BenetnCIoPv30mI0gOqNNIyXn8I6qCJTQEhnHdP2mfJZmK9k0bbktaNpxLdFAzekCcFzSCoYX928jtAxQCGFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837670; c=relaxed/simple;
	bh=wd13u160hJFFIsREen0b5imTT2cWu/NTPinHLxd/ZR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6XnEJ4xV/uEhI01LbhVJrxqaEdglajArGbDgnI715jvIHNgeHTcsJkBIWOuRu8W7rUTWLbLPzjOzE7cvFty0gzelilDrtdgujLPC6UujDMcWIQ13iF6CzpvKQ5vWdRaUy4DRyXH9w73S9lM9gvDyeGdxsyYxhUAAL0K9smqdyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ms9FOAf0; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ms9FOAf0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XczDluMDJhLIHwRfkYpUM1//dTlFia8p8idkW07QUep3SNAUCh7s31DMoJJV3L8+2ibCoUC2dDO7Cc/cM1xCbdTLcmJMhmI+ir3lW0s+4aH9Ok72CKn0LXMg1yvXq4AzZrAiF1YBGxQDvHbuEXe1xh0dlMS+HJRYO2pqYZMiVBiPiJ2jOSlCIVt2b9kvfCHDQ/00NPcLIMSFTTfCP2uJEJ4vAR3kX+QaQBcamfpXXj23MyFokbhWyA9YBJNWh89I+pmL10vc1O2XrLttxzvQcU53xg1YSCZoGSVjpDQZ5SqVo3gBdlIabYqYwK6Cs7XlBAukq5N7jKMOC+ytn93LHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdo8UsBncOnfSY1Tso/5kG6CzJ0nFR+T+1oFHdyA/jk=;
 b=pBam2dCVhLjEIAkiZ3jg9rZsqjjGHlKmxe7HQL+z3vk5bJMqYnizs/tUVnotRLZFqbRhd8BzuV3XO4B0gMrgCTubzwllu8n6MtjlC8hDqlJcyBLURweyzJEAwdRfSxce8+K1jYLEyQrc9hGr9Atpe3vjEL75k9DuG/emGKqHai7Ox2bIt2hM0SdPDI4+ltvu4rATtnBkLvdIpPR5aZm4gn+jTyDGQjlxB/ai9n6PAVT8Jia3sSFvQHJdyLu1P5TDq9/MRpqcgzcWPEIqFgkz3cJ9JylDeAX1ojeReTsuCIFjiIhxGSBf0eV27z/6+INBNv0GxF3lfnnNBrMZkLxDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdo8UsBncOnfSY1Tso/5kG6CzJ0nFR+T+1oFHdyA/jk=;
 b=ms9FOAf0yJL0u7vzmBakODaVUeJ7Wb9531/y5o8eGU63q1+1dmhGxj54nw/VZeDF4iFhzfrGUum2fwhzRs8evHSug3oLlQNBYC4+5kbRrRmFXqKYeqpDTc/daTpY3PUstD/H40l85SG1YJxJRkqd/I3voyJWqEP00l74LRogBSc=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:14:22 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::20) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Thu, 23
 Jul 2026 20:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:14:22 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:14:17 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/9] cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp" sysfs
Date: Thu, 23 Jul 2026 20:12:24 +0000
Message-ID: <20260723201228.22584-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 17963be3-8099-4596-97bc-08dee8f6fc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	uhXrsIaktREBnHxGh6awx30BX+lArWvwelSUo4ZHwSGej3DACgvjXQxFz5uDrGGvzTOAOQ9JfNc+d3NQigu1AquIjLRV3V6v/n86dUfaQiwKWfxWdXzTCqUoK4+aAmKg7iqmEm+rX3tzZ1a/L9x3EiaEdcWfW66sa7KYnP5GZnOVKS1/wzdF59/iUewEVsm57fW/skY6hyKziQSS22dH15XUTl1e015waUmoR+89Gr/ko0hgPmzxrv1s81CX5GBe999/N4BYjrTNlWCQl3JLZ4upeETEkzS2w0Je813ur+GM8aYdmYDam9+7TQDLoKGmKhN0svNfTqIZfaIAmNLqDnbeiQwoIIPoQV3RF909GgltIsr/jLM1GdJGOtfruT882pIjQ2wadRIs6WJj/hut46+5NTDKNn5CwoPpXWCa64uPJ30/b18UvAd3WzBCcCACt5lTviVMycTjaVDJxyS5f4eB376Ve9F7URwSrkyPYHbT3VsbMxVNds6glFz+5SO1ImDLAPYAl/zY2Q0mMVayeox6TOZIXzCbb7esnRKMqdxVSgqTYWy1Ks5Yv87UFY9sSzJ9XFxa2KPVKGmbyLAIRBS1H2+/Hb7bd8GneQ2zIL2VChhx2jn4GxgCGt7HalqTupxTcP2b0QpIOYQ7QGo+SEGH1Ua+CEt7bkV6dw5TE+WKD4K2Y9A95OLIB3FUZ8AXUaGehoV9ST+66xinw6B/7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pC3WeIZVr07gaDqb6grrXO5Lso5kbjJZu9lf4Wv5HYu6fh8P+2K8tCFDs5z1ztubYqC177BLERHcleGu9GR0isR4wZ5aaiGEHNx/8xxNS8mnFernM4yhcWNd7Hr/B51N8mF/hzQY1xfoSmqWP3QDkiHlNtEMlDwh64/DMrSqjkSbtrpl/dXIE716BFlsifqruUlzJAabgBLbfXrSDxddTI4LC9MyXTm8iZSEPoyAEu1sW5I/bvW9l55iKAa7mVErmsLjlb66kfD3yI9pt/d9FV792GnqnuLGbbiO1S2lFAQxjqwk9NwYqgohNLieGLSYUjZzxViwwIo3SNKhjzn/b++jwoBhoz8FuSHNVssQDuX7S/ot8WnutBDIHXwkFLf9F2Rzkf8U5+Hx7nldLcA1CRTkpIKdcjQ0/fdtM6aS2Xizvyb5Uya+VTRetOiGn13R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:14:22.4205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17963be3-8099-4596-97bc-08dee8f6fc49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743

Since dynamic_epp has been converted to an
"energy_performance_preference", toggling the feature via the sysfs file
or the kernel cmdline is now redundant.

Remove the sysfs file and the "amd_dynamic_epp" cmdline and only depend
on "energy_performance_preference" to toggle dynamic_epp.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Removed "dynamic_epp" gloabal control, the "amd_synamic_epp" cmdline,
  and the "fdynamic_epp" sysfs since they are all redundant after the
  rework.
---
 drivers/cpufreq/amd-pstate.c | 55 +-----------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index fc90e4108c22..92da8937df04 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -87,7 +87,6 @@ static struct cpufreq_driver amd_pstate_driver;
 static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
-static bool dynamic_epp;
 static struct quirk_entry *quirks;
 
 /*
@@ -1834,50 +1833,12 @@ static ssize_t prefcore_show(struct device *dev,
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
 
@@ -1984,10 +1945,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 		cpudata->current_profile = PLATFORM_PROFILE_BALANCED;
 	}
 
-	if (dynamic_epp)
-		ret = amd_pstate_set_dynamic_epp(policy);
-	else
-		ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
+	ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
 	if (ret)
 		goto free_cpudata1;
 
@@ -2398,19 +2356,8 @@ static int __init amd_prefcore_param(char *str)
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


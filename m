Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D940F727;
	Thu, 23 Jul 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837647; cv=fail; b=ebN/Olny43bS94jqjfzHW/bczJh2+lYsrL9TDs8RnnHUXtjzP3Whw/c5jd75B2NB67MhS/B15vG2IBCK5hDcdPpWTZuzw8Han0QttvFKL4Knq0wamXWgpRO76ilkGxIA7vXS17TDswuoSujFRUcOa8u7vaFP76bC5DUEn87yprE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837647; c=relaxed/simple;
	bh=fFHVPFmu/G2NT/Rj4pjKril7naBqpMz7WoFg0Y3qsdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tydHFmAH+brz13rx2YbmZtVPE2L6mpHyzmJiRxjyWXOwzS4yXWjRBPNmhW2AcejuaGnYWYM55EBSJa3g4S40q+hXTYe9eIx/0ac8gldN/0bdDQe7OI3IAtNKJLPvLdnautjmHfiRXh0tr8iFl1+GPFuABSBxZaX3YxwXREBoqV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yGRNH3mJ; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yGRNH3mJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F2pKY4fz51wyl+IUVOTFP2DR7YMHgRI45+zmSYCaQvr1NgMTeJjfRvdMr0wUSML2bhnyyo2+Llo3TshT+rkCRR4S7d0SCcXKWS/HHcLaKvHHVxWfT+nVMj5wq8DUT3BxBMoK0Gsvw8Xq0s9Qg6uSaWi7fYhXIKkzCTQg/J6C+bJMjcbeLYrhi3LlyiU6lAwlnbmaR5KD8xpKYaKagT0pED4TWTwKjYh9WrqbY/EhyXkn859g4bm8xrzz27+6z4uqwXCoLd36C/b8D7FU1zWFHWGO4X6XMbEuj9vWg2tDURUhp+ylwrxAEc/PJ2gj8E9R8KZj81pIRZLn6H3c1AU4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxHBqhUJ1N8b9axGMU9SrWrHpAbw76/ZXBZdbbnwwbs=;
 b=QgYK3is54a3p46GL8XyJ7FdV+4btnfu+JEbl6tEURi5CXciu+F/x/ENzyZHX272cSPjwekv/TkM1ibJoSJ0alvlZxqnBx/GVy72Xz/s+g1yThCOWRS0K3tFG2UT0k+CfoJL3cEElpUtM5vWTwG57XpoR7jTteclHhr/Ab1jz8oEGGBHujZmP5NGLuZ+p3JtEsU01w+zg4mJfyFdoC1pCnxfyBCbWAYS511xuD2VvShEaxgZ6nSr2YEMmKB8PmROUfQgyI/NImv9DWuWn/MtUk/vXGaLEAsH3oZgqay3HI0EPx2Q864P8hsOYWG4lQT91o/7TJ30YleKC2ibEUZuzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxHBqhUJ1N8b9axGMU9SrWrHpAbw76/ZXBZdbbnwwbs=;
 b=yGRNH3mJTZHZIruNZX5Xct+LbI7saATCKjEhPBFFcyZLaJmlQ/k0WqQyLoOJfXMIHV9NT6IOyRI6FVZivA7oALmvkr3bvQye3pBYvIDlc8XnYnL1jvNV92AGBSlrVjqZC0vOv96a0huVbSnnPkc3BijDuxooBDw6YKxdGE/8mDI=
Received: from SJ0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:a03:331::33)
 by SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:13:50 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::20) by SJ0PR03CA0088.outlook.office365.com
 (2603:10b6:a03:331::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:13:49 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:13:41 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/9] cpufreq/amd-pstate: Extract platform profile to EPP conversion into a helper
Date: Thu, 23 Jul 2026 20:12:22 +0000
Message-ID: <20260723201228.22584-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA1PR12MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: e085b06b-be0e-44f8-e886-08dee8f6e8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A8Wy5+2LhNNg5jYM2qKYWsqBuVfYDRcST7VoDH7FbHxGZBSQzPwdz+39kta39SlM0IkJuxhnu3rOCa5N9IhmenUmT1G9c79CvKQw+9ydmAjIwTmY7ypFs55cOTVo32pk+w5BdduozlkOSIZnZqMOjsSIq8KimpVTfmPJm8sfXR/GiIaKXZ3/YqdPNLOSkVZMKnJiT+i7hVQk3cdHWiXw0heUmgFzcCHbFR2XOKPDZPbmOaXEOXf0Gr8MzAURbqMDRWbi8fXtW3r4IZC6mqDhw4MMKAvCM5eehADs5pnXvqHhkFriQnNN4bvO5o1zpQCOmpsfMf0Elk3WBidBX56DCk7iG27mskCApDavYJlnvt58v5dL1WKQkAuQRnEZ7ZMO9PUQymjhYSMMod7pmbwqj07n+HIaaJtbnLt2ED6lzTVPUgO5Lkan/qx9RdOwla0102IyOCOeKtj3sn4o4XRBxn1BFW/uinMTwejHiPbk8ZIMu26vsNZe9814jx7+Koo+f0XXa2QgMGtanqilNsua4JHqKHG/cH+r29YYomKQtzqSSWdxDh40Js0dOsB1B1S8rcbxVTpX9sf6wohwLT/a0lIiLsgzOWhFP9FFZipPJlYgp3DPQE6Odnx2b8wJCMkpIAQOOO/rSO7rwPA2PoZo4T3dX0LEJkSNxe5ILBoaq9QxJRh8xymY90zsK371uO0YekPCkBAqPMRYGLrM+aFiVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JrpXy9RLBaB+GAFVq2IlqFDdxyRVcSGxjXD5DH+Y1RklBfTOFI9AIbIaHlR2XnPtSnyrdxc3KUAyIX6cNf8rq7T5lfyi1K/TCGTAwh3A64tqPXqNEf7cjH5spD7MsUT0E7Ezhx/paD92voTYkBdtPc98BwfoX7N1AkPPT/wUmuKMfOcSbUOjZP2JLk9wy1IIrchZaLBnCLNvhfrDCaMYgf8S3riHFCw5geg85/qyHLW+gxYs4PRUj9KsIA1OTd52rED4dnQ1EEW0j4t1tWP0V3tW/GExd+NkGRNUEiObszwWovRtBfn0tUUcsDz47DO/YrvN/1yN/BOjhMp+GVJFeG4bFhpmnFKNP8Egg5Qs/vSRifaG52ORa3OPon4gQ6H3q71UppBmKF1U9+KYFgO+t6XQcx6fd7kMkxeWti7FtVkZqLlDCO1ViE1iyUsKGYbx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:13:49.8730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e085b06b-be0e-44f8-e886-08dee8f6e8e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599

Avoid duplication by extracting the switch case that derives EPP based
on platform profile into the amd_pstate_get_epp_from_platform_profile()
helper.

No functional changes intended.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Picked up tag from Mario. (Thanks a ton!)
---
 drivers/cpufreq/amd-pstate.c | 67 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 02308e95636e..7d1feed0e11e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1188,6 +1188,24 @@ static int amd_pstate_power_supply_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static int amd_pstate_get_epp_from_platform_profile(struct cpufreq_policy *policy,
+						    enum platform_profile_option profile)
+{
+	switch (profile) {
+	case PLATFORM_PROFILE_PERFORMANCE:
+		return AMD_CPPC_EPP_PERFORMANCE;
+	case PLATFORM_PROFILE_BALANCED:
+		return amd_pstate_get_balanced_epp(policy);
+	case PLATFORM_PROFILE_LOW_POWER:
+		return AMD_CPPC_EPP_POWERSAVE;
+	default:
+		break;
+	}
+
+	pr_err("Unknown Platform Profile %d\n", profile);
+	return -EOPNOTSUPP;
+}
+
 static int amd_pstate_profile_probe(void *drvdata, unsigned long *choices)
 {
 	set_bit(PLATFORM_PROFILE_LOW_POWER, choices);
@@ -1213,31 +1231,19 @@ static int amd_pstate_profile_set(struct device *dev,
 	struct amd_cpudata *cpudata = dev_get_drvdata(dev);
 	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
 	int ret;
+	u8 epp;
 
 	if (!policy)
 		return -ENODEV;
 
-	switch (profile) {
-	case PLATFORM_PROFILE_LOW_POWER:
-		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_POWERSAVE);
-		if (ret)
-			return ret;
-		break;
-	case PLATFORM_PROFILE_BALANCED:
-		ret = amd_pstate_set_epp(policy,
-					 amd_pstate_get_balanced_epp(policy));
-		if (ret)
-			return ret;
-		break;
-	case PLATFORM_PROFILE_PERFORMANCE:
-		ret = amd_pstate_set_epp(policy, AMD_CPPC_EPP_PERFORMANCE);
-		if (ret)
-			return ret;
-		break;
-	default:
-		pr_err("Unknown Platform Profile %d\n", profile);
-		return -EOPNOTSUPP;
-	}
+	ret = amd_pstate_get_epp_from_platform_profile(policy, profile);
+	if (ret < 0)
+		return ret;
+
+	epp = (u8)ret;
+	ret = amd_pstate_set_epp(policy, epp);
+	if (ret)
+		return ret;
 
 	cpudata->current_profile = profile;
 
@@ -1271,20 +1277,11 @@ static int amd_pstate_set_dynamic_epp(struct cpufreq_policy *policy)
 	int ret;
 	u8 epp;
 
-	switch (cpudata->current_profile) {
-	case PLATFORM_PROFILE_PERFORMANCE:
-		epp = AMD_CPPC_EPP_PERFORMANCE;
-		break;
-	case PLATFORM_PROFILE_LOW_POWER:
-		epp = AMD_CPPC_EPP_POWERSAVE;
-		break;
-	case PLATFORM_PROFILE_BALANCED:
-		epp = amd_pstate_get_balanced_epp(policy);
-		break;
-	default:
-		pr_err("Unknown Platform Profile %d\n", cpudata->current_profile);
-		return -EOPNOTSUPP;
-	}
+	ret = amd_pstate_get_epp_from_platform_profile(policy, cpudata->current_profile);
+	if (ret < 0)
+		return ret;
+
+	epp = (u8)ret;
 	ret = amd_pstate_set_epp(policy, epp);
 	if (ret)
 		return ret;
-- 
2.34.1


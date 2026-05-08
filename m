Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A33264F2;
	Fri,  8 May 2026 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217573; cv=fail; b=KG7c3xT2OJrEpwqwef0ODgX4gNFjTgAEnWQ1CsRQGUxzbzJh/LMzFS2C0M0MhMIN6fJlaww2IS+piWrFQNhP0AL5lAshHsWMWsOpZRapToS8oA79LrNHf2tS6Tf/HpqwL8Oot06WXAfeStG0TNDSRqYW2nStrVeIupFnzX6eCtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217573; c=relaxed/simple;
	bh=4dxRSuQK05T4suWPQbAfTI/j3pJJ/pPYbOQ15DK00bQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQqTzyRQ+9dzAFH0yc1cxgSOWLS37EbDPkdvDgGk7OCgUmnVvQrqp5srKyrCP2JxzqeBsRPcJRL0wSevHrMg+qhYAk56B8GY2IacZHJ8DX7TChwYVauEpSNmzVM4dW7bz8CwcgXJljEVZAhIU/eNyMEkQEhn+TYkQmJeKxEq7OE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=olyLZfun; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="olyLZfun"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wb4bSVXcg5TLpXsDGZk8Az++3CpYO86t7sF63lB5BI72P/YLxmwWb7OZszG2gTwFfb54QGlzWNRFB28uEtiqscwk0iPi9XS3EYS6ONLpS1Y1m39/bVql9P7uOCsCjycSnb3z9FZJ/KNyD9aYOqUZ0u+C/h06XPF4ciNokfAsLvWr7VrrGC/46Hs1ALMHq9aMuML3aWJN+bRIzI2nQuIj1U5VzHpp/R8BeX6lqXLmiGuLguHyCQYFjo9sYygemEJbmGG92AEP7Nt5BWSuxYMibLxHLYwzFKgbZ9kUzVmzMF7KLliGM6zA5lyUjLTBPWrkTUy8y0Hre8CttV6BJdZUVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jOU7Yvynf67M5csXD4P91qfZXsJldoJf6vW0JAWLjM=;
 b=OtJhKhMkljyCuc70HlG/V+1mcXetrjxdR6ccI8Iq0AIJfQdGTAdwRzhNwOywsHG1FRBWXhAPSGo5VkWra9KVZHWUMyJpw4y9djY4Nroo57weeFVDFQd2rkC7L09bjGxmPmM3I9vehrjlzZHMMYpjEXc+c68jF7WKSyCtg5kVDKsQ+BABHdjf6q7QEaKfe/IJKqj0iGE9tU6PD1krrHvnW0F4u0BO6V3UzxB7Pna4NuQBDhZSGyC3xw+FdK1d8+Go9+a67OnJEyf1+qUg5DbVMS/vJwLRqLMTQp3AQ+Es0oSqxbH9W885q3Tc20zlRV45XdIS+KVJ0nZAY5Hj+7na7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jOU7Yvynf67M5csXD4P91qfZXsJldoJf6vW0JAWLjM=;
 b=olyLZfunG6yel0dusprzdOLHc0zl218JzmQrAsd5xXsUGq6Vdspcq8rDd8HEQCVSyfxTD7JGIQqbSOJyaI+3pbDMcq8Vlh6wN3M2ev623+C3MLsO3jzxUV85Fb2yxzset2coKMfmzx82YBKhwji3LUeIeFp1+tVAlrlKbEwxWBY=
Received: from CY5PR14CA0009.namprd14.prod.outlook.com (2603:10b6:930:2::31)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::990) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 8 May
 2026 05:19:27 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:930:2:cafe::65) by CY5PR14CA0009.outlook.office365.com
 (2603:10b6:930:2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Fri,
 8 May 2026 05:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:19:27 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:19:24 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 5/6] cpufreq/amd-pstate: Use "epp_default_dc" as default when dynamic_epp is disabled
Date: Fri, 8 May 2026 05:17:47 +0000
Message-ID: <20260508051748.10484-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508051748.10484-1-kprateek.nayak@amd.com>
References: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: 649cc8ed-0ca3-42ba-2921-08deacc1600b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uAnWDqfGCzUy325VyHzKNKLynLbQ+E00wESGE/MnUfCUMRPreq05R4xES//R4/Xw8MONSILk/+94o1F/bbs4+WjOKoj2RlFfTYh0g0IYuuS2V59rzarnrQD2HKr+V13+mIzkAmDhtNAw6hEQ9ONkZWIpopMD6E41oCrwl71W2eKNii/JY6tjtwhIorBItDNzp28ABKB/LByH0WO5h61JY/IN4T1PPp99Hmfic1bA3+g4WV2jmwvLdWho5D57fGRN2CCgK3Gxw47mjOmwDKCkJx8EOLfv485avOq76mYJjCpWdNrE2rJuvfSs2svjCQVMMvTG6rfq9fR09YQtODNJUrxCsKHUhDu2N2BWJwL4csFQvDaTkQaDhENqIO+tdzvEblIbkZl5IkfY0fibm/JKQrFkKAbGGgp6ZTcKWyUF2iHWsRcXBHhgY8oBVpRkJIh+QUIRdSLSGlkk2Lihh2r7bdDBQJlXiHMD/7BD1z+2MVLv8eYl3aHmPeDksAytX00Vhq9asR3LfLl+sOz4N5uAhJ/yryRZShy2XomybUnqAd212imIbDn7oNjyrxwCb2vcdcmNoulcDR4AutyIPsywK0pt/nxrlJgVZ92F1MecrNNN7Lu77sRvUXP+Zcih8fIqusMrpPe2ePKeYajfTPAsdI65ybMC4ssUy4bp4FlArYZ8FuiIMLKZtsI5EQwqTTWmOnY40tjoReYB9Pz7SXw7nob3juKvR8uaeTG3oWVYXog=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NiEEJFWSrgbNj7J7gtRZfXEwzGeJ9x6UhhgNrLpw9q+iriksVLCms6PY1UswQBcS6cmbTUKxbBHFz+8bxsnG6+41z7Y+VUbnuzAd0ytOGO30X8SGqnqWRInUAuFh5ptZ1S2AySSe+xQbhTcTonEhPC7pTZqeRJg6dhz2TGT7FtV4Dki7cYK00nDkQnkAWKWoW73woHD80aPaEMr2NkcKJfpg6dSkROavaF+YAxvA4oC/VSDhRbUutX3EJAIxDDyhcBPZGl8gg6pStvQghngxnBbCiudoC18zKv24QAMchBXEUQvmm6mUmAQ9SI3ZUrDtR/3ih2xCokQKYJ3NNLSnbTjjUKhRav/FELlvYu6MTri/f0iFTMYopjrUHsQK7wS53suJy/ovpeQnwfAiqmnkGu2m2A8MJmmuYNdiAZyKxqgv7grn6gkdBZ+01uhCtPp3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:19:27.2658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649cc8ed-0ca3-42ba-2921-08deacc1600b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737

If "dynamic_epp" is disabled, the driver initialization and the default
EPP selection from sysfs currently sets the EPP based on the power
supply state of the system at that time but there is no power supply
callbacks registered to toggle it when the power supply state changes.

This can lead to faster battery drain on platforms that start off while
being plugged to the wall but later move to battery power since the EPP
stays at AMD_CPPC_EPP_PERFORMANCE.

Use "epp_default_dc" as the default EPP selection when dynamic_epp is
disabled, restoring older behavior. On servers, this defaults to
AMD_CPPC_EPP_PERFORMANCE and on other platforms, it defaults to
AMD_CPPC_EPP_BALANCE_PERFORMANCE.

Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 175925762a93c..9eb9c3f4e809a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1429,7 +1429,7 @@ ssize_t store_energy_performance_preference(struct cpufreq_policy *policy,
 		if (ret)
 			epp = epp_values[ret];
 		else
-			epp = amd_pstate_get_balanced_epp(policy);
+			epp = cpudata->epp_default_dc;
 	}
 
 	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
@@ -1954,7 +1954,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	if (dynamic_epp)
 		ret = amd_pstate_set_dynamic_epp(policy);
 	else
-		ret = amd_pstate_set_epp(policy, amd_pstate_get_balanced_epp(policy));
+		ret = amd_pstate_set_epp(policy, cpudata->epp_default_dc);
 	if (ret)
 		goto free_cpudata1;
 
-- 
2.34.1


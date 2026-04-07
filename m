Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010010.outbound.protection.outlook.com [52.101.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326C22D7A1;
	Tue,  7 Apr 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591407; cv=fail; b=EWZj8Kcn67NZrKkne9kuKl8Ick7jm7K4b4lXtBSfM+tCry/TeyK1vVNG/5R279ahKY7YMq767x2aufFYxDZiwbhIz8wqFoAHZEv8SD9VAanrcC/cCvlNDhHANUB2AWuFR3zo2CCEnLdr7j67je6/ul3bxgAxbTI+q4va9r/zPcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591407; c=relaxed/simple;
	bh=inYTEcMzLSsj+WS8PupwsOL+ajORqmmGoW6DJiQtQi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lq0Jr0DO+xPN9LwtIrp0S7nQnBpOvZJzLUq0eZqhgf0/Nfc82NmmjYtf8aqryhggkMbJTXUZ8M99UeUtD5ho0FoaTkrMHZMaX7Q14fQLrnJFEJgCjruQCoCegNviOSEINXFO+7AeAMwaPkCcqfvA8m3Z90E3UY8+EYrbB9cEVQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CI1FYGnR; arc=fail smtp.client-ip=52.101.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CI1FYGnR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBtJfRn1R6bYQ2uZ6AqO94AXS6Lp6dG8YuZr67wn4m5zEHsQN1QQzsW5HmMmkOOLan++dhsCbsO7FzJGHyEFwz5TgIBSduHMKnGtBbj0d9d16cCbWChd+WNG6BXaacZKOi+Qg+QF1LSxh1PQ5dhlBLxtfHEq48Xr8y+mBLwOSBkxXDY+FTM40rZZIK83ikQ5kcYgACVnD2EJcMQJkG1vX8jk3WV211D+Q+MeS31fczWYxZheh/3q24EJlVm8ImGQ+wE5luCfgfgNBZB2bzBWTvXdum4swrOhQMo+Y+e+cxEefVNPMq0ov2qN6Ppswt7lnZ7AOfoVE//cs2GmH59D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ssk+dotl88tyvwMFrUDfXxj92aOAYseN9WFG8ocILg=;
 b=Yrg5NX9CaJz9aE2KoHpATzassSy21bqxbNrJ+R+rD6aeCUkKYP9e0APRMAap9vYjjJw1HQTw74k30wHduCEJmri+Am05tZTb4+09QDOyqKnypQf/GnbWLbdyPFKIz3pzhPZHVstvJQ4AVhuS6v6nf1g7l8faU5DVthBqaSe5dNhl1Ju8qhxxvdAZBJxKz/oefI6Dg+XzVTjHUyhMpPzQWROI2luAIqBKbVp1/dGqKMSk09zAn4wtKY6xOpKDvpeTaKJAEIhOqLdYVjqf5pBUpe0/3CwLukjDS0PK5QxdeJMv0jezgCjeuxTLuY7ORL+1JG1o1Pr4CLbb8hcujyUntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ssk+dotl88tyvwMFrUDfXxj92aOAYseN9WFG8ocILg=;
 b=CI1FYGnRqP1Gw3vHO7cVwHAK4hz/nGlQ0oKLJw7xzSrR2w0I3D4d2bUC8JecQTxChPXoNaVP5A2QL+g/rVA9j1x71tc9NtO+TfMnsYBd6aDaLfJE6s1vm88fK4Jk0lYLHGDojLvWmhyTnVMeH1y5s8rQq5uzAYNyQbBZmoXtZLA=
Received: from MN2PR19CA0059.namprd19.prod.outlook.com (2603:10b6:208:19b::36)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 19:50:02 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:19b:cafe::39) by MN2PR19CA0059.outlook.office365.com
 (2603:10b6:208:19b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 19:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 7 Apr 2026 19:50:02 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 14:50:01 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] cpufreq/amd-pstate: Add POWER_SUPPLY select for dynamic EPP
Date: Tue, 7 Apr 2026 14:49:49 -0500
Message-ID: <20260407194949.310114-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fb3085-c11d-4fd7-9d5e-08de94dedc13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0/3DQUrQj2noLOl9TL71mIxr/iorsTSUuKFvRCyeEoxiisbYW9FP4Dnl/13rhy6bNPOVYJIMFZ9d10U1t9WeKW4uM7hBidIyHzuvCr0XwfN062jm7EeNgpqvv73TulvjZsLTL5cMm+sci2vSTYyd3EuBffN9FNONUBDm53CXbqyLQT51r8Y6uDS0n8h/AC1CMoJwEeKJDPrjgkwfunad4BX8jKz2MjXdifWjxnjhezPNLtTP+RwXMrAmL88jOLF4mebabIVkHN7f0eqb8VBDwX3NdkQIbDvRoyhTwtbQyx1ln0tHZXOawtmdDfQh0A0/yQfUYyEohMniljm0B3lPLWG4v9AVEvSfi7q8t+lfWnxri20SfJxOSzJy73icAMcll3BGH9YdhsBfDs71xrPkoWCPma0zEEwNm6R+1mCOOf1VNjzcqR8ANCMV8PXd+fXOALEnXGLMHYn96V98kRKCixG5stnNXpKOuCVijh1zSYB9mKRIXmMC913Dp2r6wLs2rq2lC4nCyiDjLvqPzsPfLOuu/VEn/i4XQBwLioCGi9urbq6z2TLlCPZn9PThdgDRUqbRc4EMyOeHY6PdXo5MGyLDXIz7sNQCMQzOnf7n96r05t4fmUCvBCJgpdqMgLU59k+XZikwkyuTysqz9F7yfkdT+tFcgqs+pg163qrdtRX1AXrPgXsLaAHkAr6oJWFy5LZINhCp6ybyWTG0gtaqUISfs330/aTYo+EPc2UEP793bu9Ynlm5GTJedioIyKBjN9ubP+MU+KrAG0JrQE9/yA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vLwsumw/21HSmTIuhLXzi2e0b17jr7gZcMCeeNJTIvzdkjPmoFxOs734DdTGLZRuowm/DXeNGwnkJTfaeAxeyq8SaxkSFGj3zGzYjEneAOgHrAsjXrtuX174ukfB3X0gFGeMXntIXyz3EPw/Q/rNtTZUZsMGrzWx58/bX7iefRrSjMnxw/zNSETwbhMRaouLIHuq7ye6LCZ+Xy1Wf9UN9U/5xDxyYEuEd04DAhUer/CVV4SdwZ1JTAGApH2dnPwLxKXqmLme+eGp8HVYfE5Q5TjFn8gCDDRuVkyEO7m87nWOkx6xNokcvlHe59I/ekptSQ/hYoT2CW1aEyhQdOeL+sWPRmKaiSrueCk3EWDu93oZ0eYML0dtjf8W6OeLkN4DInAQP81AN+Yn10vL30qTsO0WmWooKjVsaSelfy04SsDXZdLSCHfZA1F/ecz1y912
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 19:50:02.8656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fb3085-c11d-4fd7-9d5e-08de94dedc13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF

The dynamic EPP feature uses power_supply_reg_notifier() and
power_supply_unreg_notifier() but doesn't declare a dependency on
POWER_SUPPLY, causing linker errors when POWER_SUPPLY is not enabled.

Add POWER_SUPPLY to the selects.

Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Fixes: e30ca6dd5345 ("cpufreq/amd-pstate: Add dynamic energy performance preference")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604040742.ySEdkuAa-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Use Prateek's suggestion

 drivers/cpufreq/Kconfig.x86 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 53e2702e6f1c..7cd156b5e0fc 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -41,6 +41,7 @@ config X86_AMD_PSTATE
 	select ACPI_CPPC_LIB if X86_64
 	select CPU_FREQ_GOV_SCHEDUTIL if SMP
 	select ACPI_PLATFORM_PROFILE
+	select POWER_SUPPLY
 	help
 	  This driver adds a CPUFreq driver which utilizes a fine grain
 	  processor performance frequency control range instead of legacy
-- 
2.43.0


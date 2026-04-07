Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144229AAEA;
	Tue,  7 Apr 2026 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573734; cv=fail; b=uB1CP6XmWcgHnyniunp61Q4szhwhm0unHOGhPGij9gDeDOinDz/OxDeGxXzlfixZdmQmQgsvwutMe8gQ39T4rRlqD0NgG1d3PycBESkhRAwE1jFWgX90eQpSU+ov8cZ05vE7HCDaqsoxjQXHIVRCxE8LpnDV5xS/k8ffkiN2m6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573734; c=relaxed/simple;
	bh=4b8YR+HLMVaLdKCbQyfsETaXZGwSxx9ZhFpZ//uAFvE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZeHp8qPcJBq+w5T7K4NZzTYyxJqVnH6KrJK5IoLFLfCihcT2ImAUvJIWWHnFiWYhUfqCgk6KzDFBacHmJNQYxSinI4O5T3IoFW7WHclFnS+RnvKtb+nt28z0jlwuQ1U4X+Y3uRr6TAktPHgM33Vw8wCgyy6oCRVt2Wu/UN5HVOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a+K+R5WM; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a+K+R5WM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksmDKbXwPUNFYhzVzbz/c3BafwFOBhxvrZIlQ4KwVACKw6ITYCWLxAbGl2JpEKrUN4hQr0oO4pKxPdB5RgSyS407slJVFfOjgxoiuj34+CJ2fyINDoy/gYdrrXtpX9budw8NvmpbHwEOMyf4WvyNZCd6LufN2Ntmvhcpn73jB5VG/BAYEl8TwgiomQSaJDCfY4aqnsuRH6vAtKt5lSqN95D/K9E4lLeM6Up9xw/ir5+W4IMA+S14YVXvQcHycAD7mvJ0+15aEVSjje9pfEkm1wdCXqY1rZRT9lwzE55oE0+qfyXpkDn98ZDRlwaQNQUYHTILVypQBD7yOZY6Nt5f/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSXDKL5Vcufvbg110EL5IKLVIzDNF4xtIgnKZ/UlBy4=;
 b=jsR6FpjhY7YLD57z3RSurlUG6SobKLzdvEJwca/UfU7zruWKFmLqMRZd4DLeZHyh+rBMANo/ZE93vltMX3893HPp37LMqwb57HEA4LX3sjR2X4KYHDODp33byT16wA0LGFgh1VWodASZNwgs4k8XwU+9PAn3cqub7UNrO9IiSQmyo38CIr9cIFkbl2wkFueykbZaAUeqJlQLgwN1kSX1e8/5tr+Tx6pehwNeCr4oAsn+XhZJ+tn4CpbcFWzq1ga18GUnNsOE0LSi1ykGLYGb5HdDX+oGyIHNyWX76D4/yWyx0htklO9I+ovowFdeuaXYa1tSEIwnkobKQ97qaO1keQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSXDKL5Vcufvbg110EL5IKLVIzDNF4xtIgnKZ/UlBy4=;
 b=a+K+R5WMUU6ZONreg9SSUvgOez9HTkyz03XDfws8YC8T2O+3LGL90/Xvo48Omtgc6VPZRQdJSVROiZH5f7sQsiyE2FgdfO1bHkL4we3GyyO25EwKRcq+FwIndE/64ItweoU5jj8jDCGYG0ov6PO2ZsMYrw+YGqqMaubQdgYNKc0=
Received: from PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::24)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 14:55:26 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::56) by PH7P220CA0040.outlook.office365.com
 (2603:10b6:510:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 14:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 14:55:25 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 09:55:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH] cpufreq/amd-pstate: Add POWER_SUPPLY dependency for dynamic EPP
Date: Tue, 7 Apr 2026 09:54:58 -0500
Message-ID: <20260407145458.163727-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 31db45fd-3ecf-4d7d-e48a-08de94b5b372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	lf9kG0sku0q17GFIYg64z9EXvXX3zzAI4HBm/zDkm9i0ecy/AgtFtGtNlFxlM98gK5eY/JqXI7Dth/wMXmPEursKBN9j8nhpKjgfu0up4/GS4h0yag2bRqwmvwW49DPGZTUX4iEWOnKRCedJX0oXmUIyRcrDvp95PHP+qjlXwCHgwqffseOQSN3DLvJ1vB/YzDrYmfN8cPHpkjjz9aIviOda3wlQL6LQCEgTpIwf+0O0raXjhJ/ag97V8R4H91bUbISCWMq9uMgUWYAhBffr+wf0zJkdjJHHNi1UPR4jdvDzxfNx77qXp9bQZn9Kasl+ejHYsEHu34qGTKt/q9NoeOqf3eyYSUs/Fk2Am1PZAuhlYEapfBZRdhRyiVoi1dYn7iaI2mLmMrgzIdgmB5l3zX/Yf3d+5hiaW2X+DRq7G7ZgC4cQicjKZZsXEE/LTzC9qxwF8U+AVOHqLjK7dvzStSVK4pHFWolVm8NxWWKVcOrw+0EtBmhmGQCVRMsHjY8z3p2FFLBukQTz6FvEfi4FGWUas0zqvogB7JYbOR26x1s16+So+xLHFq7+s9bZvI5hN6CJGgTeknzdFKEhYp+TF+K1onT7XtwJt/XhiKdtl3lXcvbT044lX0vKWkAbUSifQyelC/06fD8Q6+nQbSXkxD+tTRolzPzqMH+3myFvudZvU2cmCiddYX8UKgWZ/lAp8PBBkW5rMC6F1ujBnweLf76LaTAVr1b9HDmVVl9IFwIWPLbNcGAzO6omlGbFD3K+LyzEINzggKTrA3mbn4iZ7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wE2qNKAga7YbpSBD7Qc1sk/q9H2SX3wq4n5B6OxrqRBCcKm47UUoksXMzGnxp35P6QVnF5hqeugh5eBBcDXowRRJEjnPfqsOetpAddftao9ExzFVKDrof5zibexDTWpj4HocQwKTDhnVhPNfUXmd0ExbhOU1Yb8yEGVzqaoOzOZu8uMvHzz3Lp0o4vWnWcF4cm5ItAP/3SW3cmqEGO5bJNJBDN8X4rN2psU28Zvgrb2nDuuX9+HOPGjifZV0Gg9iHwExsRfaGAeGtGdYwsVgqJ1hkQ5mWBh6guVpFpWZHJ0/3tPHtSfWvYEjFodc48jqKOVJFGPfZfICnnE4y9kmZ5ibijFvvOSZUAnnPuacp/s2iMePW9aQkEXUiU1lhL8fsF2s4by9TUjMeMrqJiEHHGmFFXlCKdSTsdjbcaZ24hHpdhbRTzH7i+zHR34Ql9RS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:55:25.2961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31db45fd-3ecf-4d7d-e48a-08de94b5b372
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428

The dynamic EPP feature uses power_supply_reg_notifier() and
power_supply_unreg_notifier() but doesn't declare a dependency on
POWER_SUPPLY, causing linker errors when POWER_SUPPLY is not enabled.

Add POWER_SUPPLY to the depends line to fix the build issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604040742.ySEdkuAa-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/Kconfig.x86 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index a0dbb9808ae9..53e2702e6f1c 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -71,7 +71,7 @@ config X86_AMD_PSTATE_DEFAULT_MODE
 
 config X86_AMD_PSTATE_DYNAMIC_EPP
 	bool "AMD Processor P-State dynamic EPP support"
-	depends on X86_AMD_PSTATE
+	depends on X86_AMD_PSTATE && POWER_SUPPLY
 	default n
 	help
 	  Allow the kernel to dynamically change the energy performance
-- 
2.43.0


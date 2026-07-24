Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C663FB072;
	Fri, 24 Jul 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930459; cv=fail; b=r7ydXrx5MRVqI2nsVNgupus3u90ZHmMlJy/NdhlU5NeZYUh3PfsfBkZOUkL3TB/qnENznN85hisoGPl5pFWn/IUN1BQbY+OR4xTX8IfjbtBgatB4+6TfgkoaiyoWdgpM6eEFCRg+Zm9aAtYRYaEXj0aTOsVv+DIpi7tNNRmoUXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930459; c=relaxed/simple;
	bh=XHo9DvyenCxP4dZGulq4Exu3RpA2DCPJyP/3R6dsy64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdAjkNWEZVyBfK4XLGTZQTt0KIB2MT85uFXMDpPFki3RT9OI8OFEkBFfeOs5ubZ7I8Sp3eOMwB3BRgjX6Ux1/WSiKmrdvl8XNR4QH8y7/AmhCXqyd/XRs3Bon4PlHLlKcz4nKLT5b8Mew5qKB/gptyTsTP29khk1E2t3XQfIAxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nhAqKcD1; arc=fail smtp.client-ip=52.101.48.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nhAqKcD1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT4IJtyDecMPUmxAd0iQY42CXmrH6BiU+13Nz7ARJXQ4xeDBcslJvEBOjR3KfJ/a9Ifd7znq2/W+zNLGPrWUYcRQTYcUk8OR7JEnCDo7AFbzF+y3ieRg7aHnndxpBlWfskTD5BA0/eAYD3Qt+9RmcbyPla30wQTXAgI+XsSl9gZTB4ie6jSDwBSrJmqw3N1NuKufKcvbNMoXG08JLUtzGGNk7u1OQuzVJT0CwR9OYGoFwXD99vZDW7dxflcLWLhJZmaPN70K3+OYPac8LWh5yZXIYB36pLGkCQvmncQgNpJ72ltCOXE94oNcdAyP98KxCKylEfDzWnav3iwszYOi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onfhws+kP+oPoRuaNRSBYM9J3EFVYGx6hqaWvGSXOzc=;
 b=EtkK812oM4C6B2txMlA0Q5Gr7R4KtdnAJIu3Z66Qoa4wvuSIjglhTilrO2TH1tiCNywUAEgjMyKWPGoSrOzEg1LpHBYUXOOuISMra3ESXOc5Iz2hZPiVgQhBq9DbNPRXaAPXzap9jCx7Mn8GDIl0gaGoI5lv98dKs6kRMPCez1jKqJXV/9pJUjSoisVSOtLrJE4qSIYMJS8ByD4EYwShWRrZ1e7pRUqkAE9z5zkHGe/rwItAclvjsAivSoQq11YKH2WpCqEJIZDpW36Nb2+3fz7fgLa00vfTV+fLLaY2hYoVjInk3skJ0NZdNZOL7DdQRhCf1tOdSENoULSlYCLVug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Onfhws+kP+oPoRuaNRSBYM9J3EFVYGx6hqaWvGSXOzc=;
 b=nhAqKcD1ZBIdrHPGcKyQXC6ihpoZKig93dQwa4vfeiyIqFjUIKRsg0GuxxuCeRgyXkBomTIZN5TnEXJd8jmh1sj3PJgcvecK1+1Z1J14PCnZCog0iod4sB+Xzz6qDsEo9Uua0Hsz/5mWS0Ztv09pfGp7d0Lw0kjsp1wnUUKzG3ZK0iI8OuDlWdgcICskQR7eSiyiMW1jyIEIyO3Kn9nypnU2KH3rKVhEJpQ9yacZZ0WfXd/MjS8FJ+qJ1hb49hPwUNjUVOJlsbuL2XCmOgnMuEsfqAAewiW0p7oOgQVsv2zru9z+J4uvEvHNO1vbgB8gq3CcLQtbhCLhqThX8D5d2A==
Received: from BL0PR05CA0018.namprd05.prod.outlook.com (2603:10b6:208:91::28)
 by CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 22:00:53 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::55) by BL0PR05CA0018.outlook.office365.com
 (2603:10b6:208:91::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.6 via Frontend Transport; Fri, 24
 Jul 2026 22:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 22:00:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Jul
 2026 15:00:33 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Jul 2026 15:00:32 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Jul 2026 15:00:26 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<saket.dumbre@intel.co>, <ray.huang@amd.com>, <mario.limonciello@amd.com>,
	<perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 4/4] cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
Date: Sat, 25 Jul 2026 03:29:37 +0530
Message-ID: <20260724215937.3368276-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724215937.3368276-1-sumitg@nvidia.com>
References: <20260724215937.3368276-1-sumitg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 999dade9-78ee-4bcd-bed6-08dee9cf0705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|7416014|1800799024|82310400026|921020|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eXFS67vee6h+uxkEJ2sZUxUarYnszddYbbnaaXXwUL+7tWtpRA941E8f4YS2wJViFOnzwSgGPwd133oxCP+Zm3GeV4jHe3nmP9Mhht5nHERjWnnBUSHAMiJM9KoY7Z5Lc4CnWx/hV7gmO0XZSThxZXc7grLaP5H3UkBT5/UpC+1siYW3roVcpnN+pZhr9ntTLqhofKeMaNK/5mxDWg6ZPXBd5wXAxbJ0R7sOyRQa0vQ9qtimc7jxoVCQaUY/w2v/pQcXDzwVJjKxDRiLnfWDAxMgweA/00rDmjLFdc+uB1PGrsT0nEthNlKmnP+tmiszIFWAROgUIHoc3tk1PTpXhkyu7ZcNoIq6dMz/io/EJnI3Uye/wF+iPnPN+pWCxdZG4suIJ+EYH0mZ1Hc9xW6PRrgXCKsOCSj/SiYboFAIC3eHHz46k5CrGIq6Im6iweTnK+dh2xFVSZkWJr3+eZtToNyPX4+uSTJBFM17Ot8UyuNMUFe95kn0BTyuqlXwRG7VuX+EXfWEjqS8xjkQAAqUdjFdlVEchWXlPlDFOeGKUj71BcgukACg+ckYY/7RkRPSJ67VcG6rw/Ct2fn3rRmkREePPLSr6o5olcCm7d3SwjAnHzDUBZ0u/K2y1fXMNGxAcvqnt8SNoy12GKQv4yfHl1VrkU9EwMs08obDIPVIh7lEnZrRn3MxwsV/pM6NRkzZGMScZAerQqj0IO1q9ZAL+B5FhzOQ/xStpi5s5LEhOUH1+gDu6sglLSYPR8zfXIv5
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(7416014)(1800799024)(82310400026)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	H/eVhE5SChR+vRe+8iN1IKggFAyKDeggoZ9Ma+DJn6J0Y3tHBQ4i+IYiljbOfHvNHE2EN1rWTH6s+tviNSp83YeZ0NOFQPuvXcJcCAifBSm4yf6h4RKG0/0ddz7oNutdc4+AKwzw/6ut+xx0DnomP/Z2VaiMqXMwfxUpAurVkpYGHw8P3deigXI2XfkfCQAOK9v37tOiO4A4LPua+dxQMcakAUsnAB1Za6v3eSKiDQfTjWnnrYhb/p/3DGifUHwJ19hV7YUbM2oODCHYdtlnUlGAGh8IPzYtUsFvCMb8TKPhZo+BsjBf1An5Jk9VFLWr3R89dVRfvzX4HVWY14i4JmdyWnExqL7k5uMMglwlk/6azBowehPgY97FfKlJFgquoaR6itbilQJEAvjnFxFd2HnYscrxeMTHOuOZQsPgGHA4aQvLfJKby917BSUTZMmQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 22:00:51.6395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 999dade9-78ee-4bcd-bed6-08dee9cf0705
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244

The previous patch preserves the OSPM-set registers across CPU hotplug,
but system suspend/resume is a separate path. On platforms that reset
those registers or the performance controls across suspend, the values
are lost.

Reuse the same save/restore mechanism for suspend/resume:

  - suspend() only saves the current OSPM-set values. It does not revert
    them to firmware, since a later offline() already does that when
    system suspend offlines the secondary CPUs.
  - resume() needs the same steps as online(), so .resume points at
    online() directly.

Suggested-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8a13ec49eb9d..be2d873ccd84 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -921,6 +921,22 @@ static int cppc_cpufreq_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/*
+ * suspend() only saves the OSPM-set values. It does not revert them to the
+ * firmware values.
+ *
+ * This is because system suspend may later offline the secondary CPUs.
+ * That runs offline(), which saves the values and then reverts to firmware.
+ * If suspend() had already reverted, offline() would save the firmware value
+ * instead of the user's request, and the request would be lost.
+ */
+static int cppc_cpufreq_cpu_suspend(struct cpufreq_policy *policy)
+{
+	cppc_cpufreq_save_requested_regs(policy);
+
+	return 0;
+}
+
 static void cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
@@ -1235,6 +1251,8 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.exit = cppc_cpufreq_cpu_exit,
 	.online = cppc_cpufreq_cpu_online,
 	.offline = cppc_cpufreq_cpu_offline,
+	.suspend = cppc_cpufreq_cpu_suspend,
+	.resume = cppc_cpufreq_cpu_online,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.34.1


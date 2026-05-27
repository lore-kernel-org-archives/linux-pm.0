Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3593BC69C;
	Wed, 27 May 2026 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913599; cv=fail; b=QeOLVIhE7CiVkSBT5OIZpJewT0/FjM7C4ebmyBt9Vt/tXlotFJBeVFCquWpN6DhqaNHUKi7ISqudVNIXLpiNvQQrZkYeq0Qi4H73VqbqbqYE4rTro7BNPWcOo2I+FnB9jm8Iz2q4XSvsqaElG1As+2YzZbEQF5ynuYAeUPjCQUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913599; c=relaxed/simple;
	bh=9Jb9c+Hlxb/iY4C8rym84i1cYaM4Qgawi+zIXJLa7Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qao/tbizB4/sKehvyCFIKETZbgRuiFA52HaZ06dVcSBIKX1qS/5HnhaoXFM7pOpjAeEwz2rVhIBYC5159BAA37bbEgm5pirn6UeuXN24OZ33WsTCaWwNgRycrBoS+IiW1Neb5AtQ9h1nKpbpTxxdtYUDziOrpA4YV6KX/lv7jyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baBcC8ft; arc=fail smtp.client-ip=52.101.61.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baBcC8ft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipDVcQt9B9GVvP1xoLrflhNLeU48Wija9fAUCH0CPGiOqkjLGmNnpbUL7cs6rsxis3G0PJVeyHYiAYQDGmRxyban47lRyDRcCXQuXKJFXeg++QLa5UQkfCkePqKKCfyPthDQYn9mOTljpPyfJVszutlzHsaTKM/pysy1mPCPCn2jpyhp7eEnihggfM3w25E965m4WF5gd50hDZfbBLOLjaDpUYYToSeBWlL4X2wg/ksp+Akq43MAYqrEKPyBUf6TLkCjoP9yBYL/TlfDEz7eoDrVmL5g+zvaUu9A2oTzCtWiz+tGZfcHLQTQHLX1HgD04yK7avegSCY6Lh65CTgvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyeqptHbB5TYIvVcHQsgkk9dLFXHUqs0BKf3Sqh1TSE=;
 b=eht6CKMDQUD8gjLwuY8+Xdki9+BpnwPBCCYW0URKRelyWkL8ZP7UKGo4XTxXvRfQVJFNUF8J2T6Vt/ZfiMzlOms/03n9tgb2lP/7XT35rc0jt2YwUHl5BoDv9jI80Mol240NgaL21OYFVVOq+iXr9EZKulPjmHc6jYcKmfuj19VGFDgQau5y2K/PXrOqCIGiJsjBqJS5Rj3+TJnYoelGgYN5z7VvZecPpCzzDxBE98Arhjw1a+hCGKCqcw0jgeXwR85B1xhcXHSoXD8K7LYhLkPRRhg4UZ/LtJSXFKqXGfTW9MVSHRM+F6SRNj8LMyZyyCjFzUmgczeGgdA1pPL0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyeqptHbB5TYIvVcHQsgkk9dLFXHUqs0BKf3Sqh1TSE=;
 b=baBcC8ftWaLCPRu5gMqAWVxfERkuRaiFz7GbO0TP82vbkiLx03SY17GVCVWxJFZwGznfUgjpI7xgIaEoWDO51Mb8Mf36PqCFZUGnqh3cpC+twvSFufU4LfHzapvYwQid9iD79JeTJ16UURfvDafy/bZeTku+c0Oax5FE3Ohzf4cHhFeQRi/LsaRlkRLc5Ca//yRkBrngfVavdyau9IqhBgZcfqViQFUCwNea9Gb4M6QvjAFjBUZtsrt6cb/UlmKUqdFU5GI7jrlZyLGjJF+C6NMO5PZVj6eOlkjRU9/Y3ITy5RzZ+9JyPSuN/SlDBKrzJpcT1FLzz/C3LSNphT3uuQ==
Received: from CY5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:930:12::27)
 by IA4PR12MB9835.namprd12.prod.outlook.com (2603:10b6:208:54f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 20:26:34 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:930:12:cafe::53) by CY5PR17CA0060.outlook.office365.com
 (2603:10b6:930:12::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 20:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Wed, 27 May 2026 20:26:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 13:26:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 13:26:16 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 13:26:11 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v4 1/2] cpufreq: CPPC: Set CPPC Enable register in cpu_init
Date: Thu, 28 May 2026 01:55:49 +0530
Message-ID: <20260527202550.206828-2-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527202550.206828-1-sumitg@nvidia.com>
References: <20260527202550.206828-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|IA4PR12MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: aa05c82d-0e14-4a97-b90f-08debc2e3e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fsTsJAOfUU1ixqjzdXvG6VA3DlX+7hLvdm2LcWLg2mCFX5GQNRfZL7gk3H/KvE8frPtlYeNW1EOOE/xPFvaBXQpaF3z5kx7icSGizh476fcH4p0oEsKEmSZbXpoOcMrxPTWIt77knFXjeojrraj3y8jT7Mub5Hh6LNGJ5+kdm0cLBGAIJ6AhYFwkNCD9cBPmEQl4IjTvfaPgwpXBYrOhX7jfV9pLbIWQf0DpAF3P5rxpdXddR8bfi53dHx1NpmA+G3qbdmQ26ohO0I3G27dk9BnlB3KBQY4mLmyjr3/rRcbIFxD2PL6hIBJnIJco/2D1tQ0wVwu02dmXSnJjVYlivTZjRIl5437KxLoUqLE4pWoLmKpK3O/KpQEOiTVwDMCNdyj5ahSCXQALs+VGdJ5B3nKPKQha6lOPaCpvgZkK5TSQy8a/pFqNE0gFbDWDlvyoz7bnq70PjX05SCmjBY/Ktfru2kFqzAj9fjw3Igg/hbL4Ypd5XCqDVR+jzizJGvdHFeg5XXQJp+GFVQF9OtohrI2KPFPSvPBocHsFxhNa7dISa4WODO/N59W2biuM0yDD63NFBKPSoWyDlKJ2ireoekUZ9p/aC6lBvvI2eya0Vup4xw6cF9vlWeg1fq14Uc7Mu4rIHB7GrJgpghgyvri3R/ub0R8ZIdf68BbqioSLxZ3IdGoy2rHnduOpwKHlrLlKcHsMai6MxeDlDwrX9l2Ow0N9bjgh6mzEXbLttFCFvvAqwdEWxRzZ6+vQ9vMzDiM6KzUWApa9n11tdsSsty4W5A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U0WLmzJ9FBSNUsLGt+GuhHFvohVrrd6S5zq7lQyCpYjNY72Ox075033awyJa5Duy0ZYnceIrLNZM2pvvLMjVl9v8eVV0hOBTTFbWb+3DgNXPfHn3JHPMsSW71nzhdNFmoWD1XwoA54dtQwyYH7CY6aB6Eou9GMpp9lmJZdBQgvgIiFOqeAvw5BSXP2sHRaoZS7Q0LEieTbm6Y6R3PouX2ljNdSkkyu6OnxhXfBBiqaK7oAWaZNBhD2NbnkvEcHWCs6X0z5dybdG+DUUGJ5ucr294XydFdU8BgcqzmEw7w4g3nww331yAqlTzEQI0HwsseLXwnCOZXjiS2s2qVhQ2x9TeUKNQegkHQo9e6Hwqfn5c6jOLMPwNUqrIj8iVOnHa6EhHQaTHlaXalLmSJeivVlBR1Y5cDQ6XR+vPiCiL+m5Kj3pzkYw01mrcNtNs+b4r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:26:33.6672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa05c82d-0e14-4a97-b90f-08debc2e3e9b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9835

As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
  "If supported by the platform, OSPM writes a one to this register
   to enable CPPC on this processor. If not implemented, OSPM assumes
   the platform always has CPPC enabled."

Call cppc_set_enable() at the start of cppc_cpufreq_cpu_init() so
this is done for both OS-driven and autonomous CPPC control modes.
Errors are logged but non-fatal as the register is optional.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 64387b6587cc..7db33761e899 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -655,6 +655,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	caps = &cpu_data->perf_caps;
 	policy->driver_data = cpu_data;
 
+	/*
+	 * Enable CPPC for both OS-driven and autonomous modes.
+	 * The Enable register is optional - some platforms may not support it
+	 */
+	ret = cppc_set_enable(cpu, true);
+	if (ret && ret != -EOPNOTSUPP)
+		pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
+
 	/*
 	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
 	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)
-- 
2.34.1


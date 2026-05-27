Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A173C0602;
	Wed, 27 May 2026 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779913585; cv=fail; b=oGW9dpyBKiIDFn3nj8gtSWClAe2YgOMxPkEIv23ppHntjvTXdyZtNRhzMDflZ25K1+ensUWF1UawCvFg42GKdFjZX4nFh4SKrPX/cA1HFSN5L/8B9pE2Jxa5/0xQCK6E3w9hYS+Pg0VTf7dAJ8zSc7XYfo2vqwNeFXXzE+eFF/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779913585; c=relaxed/simple;
	bh=ugkdMA2+s5f1JKJnICCdBPDV8BEzJfycBFhpXFkjzms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CK488QZeq9ouBGhN+qpRF/Y2+Gw8mMp5pzXn8DszCqI/pyRLAASoAjz9xWIbZ8s6rIHzTfUdDp+eHv1OGBUNrtto86QIqPdrR8iDKaz+juzU4rtw0J2JqnXe1WY0llQd2MikePIrcUCO7NiRm0j4zXckcei20i3D7j/TB8r+np4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FhefFW0N; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FhefFW0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dncawO7l5XZQC/0SBS2O8vM1ZnF/W8pspqDo8wIwJ4hKsAdlydWVU2I7R8P6sFBAaerpY8iC84imjI9FtN3qOGxF9b3seyOkRalaOa2d1vx4k75zU5HLqxIR27xKdG+V333e5Jqf3vsmYCZYzVllCB0QDMLXghb37x4vBrJjGTQwYiEc4d05L2b/PDjHPVYauYO0jTAymPIoyFHDcaP4eqJyMR3D0I/5iUGM5On11VsHw8uYlgrH9PAJUJ+iBdzHxT5zVVDghvhdtJyFmIQnb3o2bn//B+M0f7okA/g1q3W9V78SZruSYflwY1bpccqrkgz9DQgf8hyYbJJggZiEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szQ/kPUS87lOQEm0HjCCkCF/eNTX00aEEVZ7D+O55Es=;
 b=a0TNYAynT3vBgPmh09Xu2eIANuRaMWKwauYuxzFlx0sRTMyqkvrHPW4Gp0JCaN1iN0i63N97bCJ43n01R2Ozod95qkrkZoRlhrn/FsnMg+Tah+2hLACPp9ixxcUXOZtMtVP18w7yi5xIBGg57Mq0QOcZtmmJSwQiEa4QVMAAgU5N37MIaMD+iDS2wYbGDiVNn0CMhM1nArsY1IxtnSQ45ZD01VS6WDEv98m3DCUjok3Gcrl5AzT9+Ewfy4ybLoh55f46dtvAzEie5+YJcpOwdqvhTxE+oRFYZr9C4Zhx5RLg8ILmbgj3lhdJFtK2bbbUemFSJSBpQbea9MVYMdy+cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szQ/kPUS87lOQEm0HjCCkCF/eNTX00aEEVZ7D+O55Es=;
 b=FhefFW0Nm0LPZ7fp/3WJ1d3n9Xc2bjrbubaTjIjoQ7jQYWCMLZsQ/Osh6eQNHRusk86UxG8IUs6/08xRfCdOxSXmP0su1Do7JnNOPA1JKw/ulR+6RxgnW1/yeG9HypJSGllZMCfuFUJnrw0JsnMCqBHwchjNVmBcGZ/fxMlXkE7BXFQDxy+fIc7LJ08DtOWJITNXbi/EYx0A/o09IlgvTbwD3GevJUkal9ClGBC/n4v9mepO10XTkJ8Fyr8bigZF4wVC07/bLsYZwac0bBZn5fZ7G8naa65VuzgvNoTDb4UkG8amv1whmn8PK68qeADGvk0MOUH1wedDxmpo6Fm5KA==
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by MN2PR12MB4303.namprd12.prod.outlook.com (2603:10b6:208:198::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 27 May
 2026 20:26:18 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::42) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 20:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 20:26:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 13:25:58 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 27 May 2026 13:25:58 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 13:25:53 -0700
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
Subject: [PATCH v4 0/2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Thu, 28 May 2026 01:55:48 +0530
Message-ID: <20260527202550.206828-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|MN2PR12MB4303:EE_
X-MS-Office365-Filtering-Correlation-Id: e6dd958d-2652-44c3-44ca-08debc2e3503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|11063799006|3023799007|18002099003|13003099007|56012099006;
X-Microsoft-Antispam-Message-Info:
	XTIWTRmkEfgRu+oMgc2xo8I8COqcnfZqkT4TVE/d0EjL3KFeVEPr8dbmQbshdCvhGxU8hZDHx3RRpjex+hUSauOGm5h51OHM2zdalo2ahY7KjhU1Mz+JjNGu/z+Ds5iFdzb5NOYhuRqONhkMg2P0pRG1FjpwcEy7IXDaBwD71eIvW2SLYiKTqvj/OH++fKnPWrBbuccv8K3hWEp+VcVE8aMA5gm5n4/SjmzpljqKzOkqfawAjJQujJW4mN+joC/uEcUlOo1DoESVcqHwwSndG+9QuX3r3fromzJYT1bvK+ki4tvkaIoAerHFkKLCVQOpYOboV6/FbeDFE1CjCWOkrhGTb/5jDIiaJUsJ+nc414GXDwr6XV/j/8BWnnPfs+XPfaResdvsLVYRsJS958KCFaZyVPvLOABjf0siTUeYtSQCI9a589b2/YDRVf1j65NWcf4yWRNHCDblkQiekRJU4FMv2SvoeE6/lfMmkLpprdCf9LsyEbhzqGGA9lNUF4D2iDIGmoN/PQ6FmbkKhn/Y80A89rE7Xk7cbYBAyuh3xazLc5JJguWVKLCCIvBsfjSSgaAA+GNWd/D0+PbnGva+d+TB4c1KCoia0sDsu74jCNUcoSVtU1HW8XF/anYO1JN7NgRinuBtKumY2BWsA7dFfLpvxUV7QFmihssAUMITXIAxuaLKVCYosiv+Y/RQoc0vchjmUBJ8/9G+JVV8LJyjfqZ7FxIQ+73gAWiEump0P0nHw4jlQxurFOXiNuiLFOJgXWp/kt6NHCKqgNUDjSmnz9/LkFx3uNRwVYtX5WwwCVM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(11063799006)(3023799007)(18002099003)(13003099007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jUGoTQpOoP+H04Q4BhLxgCuJw5H6F5Blf1zGKkrmBgrmTYpK2u/Be8KKQD2XmkxW/hcPJs39kKjY9TqN67mlOVKbaUkpW5lSoYgaLa3lKyYduO9jai5HITg+HzuLUxRgmeTv0CNmstbRPqaEx5Ukz5dXLLHCVwocScLsSbaTRB8yQsxfJNI30WaD+eXRpxt0R1I64h3/NOLYXJBCFm9zrDNqs/UFcXmy2qQPGKyJprAeErxWaXEa9fE3mwBvqsZiQ/1dTvQPEzGt9kMRK1B2xmuiwSGeMvKc7gLCbiUHmGjQf4SvjKRYw6DqtCVl3FKUVG+27ob2/U/NZ0gPNd9gDBUtWpsCQt/gfXLKQFQVbkOWnDCK+B+bYCMdDBkvTuPklyF8HIQvbcRztmkK49ayIMmHbuxP2KzCOOOzj/ICS9jJHLSC0pKIeciKNAVwv7Rh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:26:17.5611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6dd958d-2652-44c3-44ca-08debc2e3503
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4303

This series adds a kernel boot parameter 'cppc_cpufreq.auto_sel_mode'
to enable CPPC autonomous performance selection on all CPUs at system
startup, avoiding per-CPU sysfs scripting at every boot.

When autonomous mode is enabled, the hardware automatically adjusts
CPU performance based on workload demands using Energy Performance
Preference (EPP) hints.

Patch 1: Sets CPPC Enable Register for both OS-driven and autonomous
CPPC control modes. It can be applied independently of patch 2.

Patch 2: Adds the auto_sel_mode boot parameter with three modes:
  - performance (or 1):         override EPP to performance (0x0)
  - balance_performance (or 2): override EPP to balance_performance (0x80)
  - default_epp (or 3):         preserve EPP value programmed by
                                BIOS/firmware

Patch 2 depends on Pierre's series [4] ("cpufreq: Set policy->min and
max as real QoS constraints") so that policy->min/max set during
cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy().

v3[3] -> v4:
- Add 'balance_performance' mode which sets EPP to 0x80.
- Add CPPC_EPP_BALANCE_PERFORMANCE_PREF (0x80) constant in cppc_acpi.h.
- Clean up EPP mode selection with switch + boolean flag in cpu_init.
- Use local variable for kp->arg in auto_sel_mode_set/get to avoid
  repeated casts.

Sumit Gupta (2):
  cpufreq: CPPC: Set CPPC Enable register in cpu_init
  cpufreq: CPPC: add autonomous mode boot parameter support

 .../admin-guide/kernel-parameters.txt         |  20 +++
 drivers/cpufreq/cppc_cpufreq.c                | 154 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |   1 +
 3 files changed, 170 insertions(+), 5 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260424201814.230071-1-sumitg@nvidia.com/
[3] v3: https://lore.kernel.org/lkml/20260515122624.1920637-1-sumitg@nvidia.com/
[4] https://lore.kernel.org/lkml/20260511135538.522653-1-pierre.gondois@arm.com/

-- 
2.34.1


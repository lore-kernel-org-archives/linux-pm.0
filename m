Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A7638F951;
	Thu, 14 May 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788132; cv=fail; b=S9GjD5jtqJxJNvt4v3LzHXZ8kgRycz2ksv5Ipv9uhI2vRgxqgnM6loL3HvQAP6i4suFO4/uZjwBqvQJnn3LYc+jamYDcmq2ySaO/8H2qnyidocaoqZPQu0lh+EAzIYh/djaRpUGrx+EfbHAfMWrtBLhNwgCxYELrNfXFDo3eCDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788132; c=relaxed/simple;
	bh=UsDrqkUs0vs5/2L5sf6jkrNa3uGJRSgIkk4dJy42E0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byTi6MRT2d5AQdJxFcHAlDJCtdS2u4KHtgbcb4wYIkkxoa1WK31UaRUKrJQ5r1ISZIgHHxBaRfvebAT3ZbdAajIGJfRm30iNAL0Iq0HUxzhXCG/Y2HWJPHOMaER98K16UncqnYz1mW/XHCxPrYznAxGROzD29+D0zK8AHMPm/jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b7cXpgtX; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b7cXpgtX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYF6P5SeM2WicqJfLoVBdBT4BjfN8eTOnyYIE9NsAa36+SEN+uY8N9IPKzwJEUQiFbCUbWWnQcO0b7lTRJMv95NwCJylZzbIU6EoYsbh+9kjW0CTcmJ4e902gO5Y29Y+BT8N6EVk0MVPIYboCTJL/jEg3njhiMD3JzPdmDtbiqynePhmk19849ae56covdJpDWcFQvGWWlwK74StJu3c7PSbozCBZjUA64ewY5tyg+Sakr0/DPgpNL+XlqNmNmMKGPUtFMxgXm3a4EYbzq4WfwKE6HqSs/OBYpIAMp7S/Wt/TPsGLejMnULgsxPZ1QPAtChASdCrYpstWvgGpFiSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr99z7sxyTW1895O1i4TWbUKXIx2/91fteS/Qq8NRcg=;
 b=lVRL4HAzjjyNbLboyIRGAEm41NXgRaq6N8ITGlblpCcfWkvmHg4dLqLHg+rXFDq6AaE0JBTECakh0pv7wWzP0B1XYLE985EiiBcJ08Q2Puvc9VAoZ/HhILDSfHFAamm+zqFBC3Y0meFwsn1sFnTmyn4m6oUag/9aTlx90Y088NSrV4KZK+TrrgWrNz9dYd2UJL3QyIfVIezEdt0Lj2nQ5dhLYXV0XrRYxYn7Ai2rUpfCNWFIcKcvG0JcnhziE1UNyk9ziA2FZY+ZQgqRIVdmvixDU+sj1yrVZrFCXk+qWeAdy7MszvI1hMJw7xjGHSg6MjzlZzJgXsVp7kgu/kYKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr99z7sxyTW1895O1i4TWbUKXIx2/91fteS/Qq8NRcg=;
 b=b7cXpgtXyYock3GWE454tcf3et+h2W2c/8YGvBsb1y0l0P4mqjXs3o/p/9NXQut0ebrR3wd+Iz9MCQQFZf8Ap5SMFA3MSk/vukGS2N6+vIAYHPVSDu74+FeL2+b+Zlsam0vGPIdKZuIx0b+8bTEROCzO27yaYvd8Y6+jcRHEDPrBF3DqMahOAGuUYQt1gBDn9zjGhvEISMubmhpqTMJZbRNerBtEEP1kMsaFk82Zel+GLyi0U5LYsmY1V+TDQ3YVO2CzqzXTeSFy6JSYFoEkJQeOsbnN+Of2WmnYe80k9tjxVTYLCvCAUfpA2ZX64DpVow0BeK4rWvdJwzvZFRW70w==
Received: from BLAPR03CA0058.namprd03.prod.outlook.com (2603:10b6:208:32d::33)
 by PH7PR12MB7305.namprd12.prod.outlook.com (2603:10b6:510:209::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 19:48:45 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::db) by BLAPR03CA0058.outlook.office365.com
 (2603:10b6:208:32d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 19:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Thu, 14 May 2026 19:48:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 14 May
 2026 12:48:30 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 14 May 2026 12:48:29 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 14 May 2026 12:48:25 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v3 0/2] ACPI: CPPC: Add CPPC v4 support (ACPI 6.6)
Date: Fri, 15 May 2026 01:18:20 +0530
Message-ID: <20260514194822.1841748-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH7PR12MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ac5c35-c670-4a88-d253-08deb1f1ceec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|7416014|13003099007|921020|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	BRRVmxGSx1MnZ11x/vl95hxXTeLNQV8HAYbwiz/r0mE6BERnOfT5Urq6oO8NYIJxke8hnRgS013IPKWoSrJrURlPcOgFdUetuScmGbpXBFTouCTR5pPTz+7s5E6vr6F+Wr9Gb3fdPnwDAzQA84Hc9UDRlAXrzJQyD7ogMpVl+5wi271MNNqOpfmokY9hAqEYaqOM5Os9QG7s1urheVVbM/gCXpyhSAoM1yv3KgPFQr4ze3hEjT5uzHL7SP2nasGBIaADQEbKfpVbRv/R1S8+2U22lkjACIpG5R/n0ACNecFlkYYBJTFWNUlWwUxLQdbYJrBswGhgoi99uYs19znwT+wSCF4D2dRF4puS/ZERRVjePHcsKwBsNEBIMymz8/TsN0D8+AjcLkknmDxQbvj4g1IR3dwQf3kW4LMVspGXShrqqCKs9LIcSADp2Sub1ofHKr+cFU6Ht4fx6/Rpb9863n5y5fMJqQzhVfpdnQIFYqGLxH9Fwe/Bu1cJ1oPIF1cWj+WQwpr0ZCSyHQ6YYfTARDlSNS71iL0LA53CdnB3WwB68TxL98KSx7bRItMHJDR9JNNhkuRzVI8U+SOCt6mLe5wyrlkwYo31GYzbEEssqZkm5CHCyAZMO8XmyNwoAnDn+llEBr+rKZmAn2GN7nzxQqtkwa13pnQ2qo4gfwhMImwA6gZ7rC/vpOAAyGwdBd55JwkxJpgAtDdo+CYxfqKl73Q7uvj6S1lXgFV4EzTNDOApFlLSP4fUbrQKuOlA3T4K
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(7416014)(13003099007)(921020)(56012099003)(18002099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gWKBhXEZV8Oneg5gZYXvlimuFRbpdt0DIhvy8wb4f/JiPbFuBlnZDqRUfdW9pboWSRAysoONg0Dz3hUvUA32c8SVbpd2k8m5U45eyh5M//zwF8eY+lLPsY01w4dlw/DOXhj+s9Gh0BH36Cw1MQYwTs/IQTYF4EXEH8wcD0fw+KhKAB4J7r6sxW/BafcwrTnnad9U6RMQYV7lSRdt17QovtYzU3cFJLm9t040WYZRxmGCJDLQzi+dwhv3FH/W5AZEGCefL+mNsC833YJO/tRwk8mOYHN6Voa0bIW5futIuvBV+FQsqp19v4gCLRS0BoYT77QjGZ5Ya6PqXkRJgE/kI261OdykHUAay12T9x1F41XQNijNk6xpkYahymUegOOIvVklUqMY15stJKQFOZXvlL5D3SE+ZOl1pC3/V86SQelbxi4onUUEoixxquIGExNf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 19:48:44.8102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac5c35-c670-4a88-d253-08deb1f1ceec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7305

Add initial kernel support for CPPC v4 (ACPI 6.6, Section 8.4.6),
which extends the _CPC package from 23 to 25 entries with two
optional fields:

  - OSPM Nominal Performance (8.4.6.1.2.6): register used by OSPM
    to tell the platform what it considers nominal. The platform
    classifies performance above this as boost and below as
    throttle for power/thermal decisions.

  - Resource Priority (8.4.6.1.2.7): Package of Resource Priority
    Register Descriptor sub-packages. Full parsing is not yet
    implemented; such entries are marked as unsupported.

Patch 1: Add v4 _CPC parsing - validate the 25-entry layout,
restrict the Resource Priority package fallback to that slot
only, and mark the two new registers optional.

Patch 2: Add per-policy sysfs attribute ospm_nominal_freq (kHz)
under cpufreq. Writes are converted to perf and applied to every
CPU in policy->cpus.

---
v2[2] -> v3:
- Patch 1:
  - Accept ACPI_TYPE_PACKAGE only at RESOURCE_PRIORITY; abort otherwise.
  - Added Reviewed-by from Pierre Gondois.
- Patch 2:
  - Sysfs moved from per-CPU acpi_cppc to per-policy cpufreq.
  - Read ospm_nominal_freq sysfs input in kHz and convert to perf.
  - Cached ospm_nominal_perf moved from cpc_desc to cppc_cpudata.
  - Validate input against [Lowest Performance, Nominal Performance]
    in cppc_set_ospm_nominal_perf().
  - Dropped unconditional init in cppc_cpufreq_cpu_init().
  - Remove to skip write if cache matches in cppc_set_ospm_nominal_perf.
  - Early -ENODEV return when no CPC descriptor.
  - Added ABI documentation at
    Documentation/ABI/testing/sysfs-devices-system-cpu.

v1[1] -> v2:
- Patch 1: Added Reviewed-by from Mario Limonciello.
- Patch 2:
  - Make ospm_nominal_perf sysfs read-write; cache last write in
    cpc_desc and skip redundant register writes.
  - Validate input in cppc_set_ospm_nominal_perf.

Sumit Gupta (2):
  ACPI: CPPC: Add support for CPPC v4
  ACPI: CPPC: Add ospm_nominal_perf support

 .../ABI/testing/sysfs-devices-system-cpu      | 17 ++++++
 drivers/acpi/cppc_acpi.c                      | 58 +++++++++++++++++--
 drivers/cpufreq/cppc_cpufreq.c                | 40 +++++++++++++
 include/acpi/cppc_acpi.h                      | 15 ++++-
 4 files changed, 122 insertions(+), 8 deletions(-)

[1] https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/

-- 
2.34.1


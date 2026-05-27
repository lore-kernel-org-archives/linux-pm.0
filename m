Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46603B1013;
	Wed, 27 May 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911231; cv=fail; b=svslfocYW2ugSEBvxKXVW4ugA8VIfrJ67zTAj/AhJ0ooN67qnyXmoJZup/r+ECQ05oODMyU93d69QJ6UJIL95wpWG4kHas/YGP1nNc3qNEglvhQwlkEh7rcOraJohsChQEmbp4DnVYYXfW9e+RthuHNPhf+3eBoEJmVTc6kOkAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911231; c=relaxed/simple;
	bh=9+LI+81okwi3RvxqHTp5yY6FYJcQHQr9cTfo/OsoiLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/XxvoQP933b3+4S8AAljNDAn4p7yyIIud8D9JsRDDogaXl/L5mI8xuV3JaUBH+BNbeTkP/GJBPDYnNpw8FdGbShiy1dfdJ/rmOC5QXkA+6fwiPwhgwH6UNnNyiSy6l0WYmaVz1G6BT2qlMG1e8vPcPdWB25RqSI3i5lwfW9Sdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kr7CizqS; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kr7CizqS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ks9/AtPRsMzhrnLlVDtJuLRRu/Bo/BRMQSC7XB3S2NdQUqUhqCfLT/dIwh5bOAfX1a/+FoHtAAMRz94/UdNv15LtOXMrjUKKXIEoOqhpykN8e61XUbv4z1XYLpEg7rAKvJusJX0Z2v6GWVMRlyrmT1v3CORg6ua54OAkamZzPmtwsbGVLv0ZZd/QmVj9Lc2ZTZLBEYR8Sqic8PYlaR95rNXe0Hv8J5P4mimknBG2ZjvkyeC0Yit5Iere9EDFzb4HU1KpXd5UsTyVaCXJ2Q/vnfVDxamhrbDxClTZWG7BCIegQFIRu/gRV3NEm0kHaGpnw+KZ109Am0jStAw3Kt3DrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnoYMlGrEKLg8mFiRp42PD0qseHKZSUUpKXnZg2UZN4=;
 b=gukLawMIZj0baKG2lisk31143ffYdlzwBlWoaxRclAaDiwUpm1SuMzmxioPkWyzgdNuJD1VvPs61XVlYtg40qYjdxKXaU6HY2RTtiiXYGt5C/ZIGkmmaH+RgZ3WgtQYiwBJ4h4q2jiuMGjfJn5B0FixntMvJ00Le0ARnh8FEg1LcTA7Y8MOnYQ7nzOzY5FP/nYa9oAQn1LyO3duAnSdULxraMIJ7RXSZ6Q2gA2bclZReuJW4KBv4iMaL2F0rgyPq9kayq/Ui0UTJ0P0BR/ydI7sH+MJ5CJWK1BgLs7bOhQBOq5W6qP9h6yBWqTgowwpqg0cBiQVBCoMItFDV0QTx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnoYMlGrEKLg8mFiRp42PD0qseHKZSUUpKXnZg2UZN4=;
 b=Kr7CizqSbjtfXuEtTW+9mLw0FTZb4swKU+nZF2iWgQBduIkRyYSvWUS8a4uSr1lvdsHQkB6MKa3WhXVEhu06MVblN9b2Qy9vEf8PKKX4mOXxsT/fb2IXvwqMo9TtdoqUcfj7M7XHvlM1BiXa2rUx2lLi3WArr1WjifpjoyH1Tm1TWcMtcZqTTciqUZbIm2G/ltrVOgvkghi1Wsrl1TgoVLSJP4/gz0j1/jg249pBXPx8tjY05Y7veLUP3pQuus8SjqH/dNaLAVIXMLgkxyMdSzIWGhHI1Dt/LgooIrWP0XEJu2F5jfU6bBhV7hz6vPvitN0gpRoAP1jXc7yWleP9/g==
Received: from SJ0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:33a::27)
 by PH8PR12MB7253.namprd12.prod.outlook.com (2603:10b6:510:226::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 19:47:03 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::17) by SJ0PR03CA0022.outlook.office365.com
 (2603:10b6:a03:33a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Wed, 27
 May 2026 19:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 19:47:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 12:46:34 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 27 May
 2026 12:46:33 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 27 May 2026 12:46:28 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <lenb@kernel.org>,
	<pierre.gondois@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <mario.limonciello@amd.com>,
	<saket.dumbre@intel.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v4 0/2] ACPI: CPPC: Add CPPC v4 support (ACPI 6.6)
Date: Thu, 28 May 2026 01:16:24 +0530
Message-ID: <20260527194626.185286-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|PH8PR12MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: dda17301-9188-4e7b-7299-08debc28b9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|13003099007|921020|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	t1zXQ3E2VenhNO7i334lgwYun/8UXffsTx9N8d3hHAno6rnDSneF0tprkO12hycfWOASfkQ0h6YSTKiEfaaeg/EeQY2NmbPJsiSPftf06S+SY7mg1ePUEj2NP93eAWiRK65/oloOd2rPEF+IhakpUSGIFE+kANgo2Q3NTiLrelPhaPkaVgKGAE728VVNB5lXlYGThJxmJzCf85R39lGFLi9NunN4UgeqUaUndRREfwYokAkP5xEBgI6f4wALHI3ZBEVSlfve8zq8/+J4AJbrxHdTTnNyd7rUAutMLWoBGoJuwndJJAAQX+q768Pby5xGktCj/Z5P3LNgNO5kRtQ1VIxm25uE0sz1n1d7JCRejVOdWqRt+4nKbwT1akJnbq4SwB6DcLUKcNpR+6YEQKPPbnUfY32FgtxBgFBzMdrxMQKjC4wXO13avlzKFvC5sP+4JoVlrouHmzyi0wunZRmEkglz9JoaNcZewQmL56a4wyzA8N7wZ4Jchg6z2oAchawAvXp3f5NMIdIdV+7MW7rVVkMHEjHkyndqtrSaO6p/raOAD68X24JCe7zdVEZvbTmm9ixiiJkmir8fVJLOh3hmG+1SkqdJh5TX92T6X71eW1Pc5lI+STYeSzk41pPPf650J9AewsfXGTDWWn8w9SXyM8Jm/WTqvUkShv3fr/5080rgArxTGyxctTrQXknkpcYrS/kT6XykniKyy4F3SkELHnXcl7uh/mwIOq1XhCm93e/eI2BJGwdvgYxvWKomiKJVVzvfldncsL2yepkIq58eohupw1iYM0sWmQGGmsa5z8o=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(13003099007)(921020)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2dC7AlhXGxd/XX815gn1SARpOByqohJGYIAXNrGGPukZA0doj0MS/b/OTj1bW8K1Xutx7vMKH33QVV4goJaoQEJSye+4e9e4Pe5QGnMtHMO8bZQMx6FCRzHpwOHH6gBTJeHAc8dTpS++OeWGBEWzC23fOEfVQjsbqOgyBfOvkNouuSxZVTpfyI3NBXRnbIBBOumMys3Nmi49UAG/ELhuqINS3bNeEoZyJIwBYGkldSPKRo/lNNZ2qSmJEp9K4G2z+zwMWDiiGoPeNexMtL31/T+GhBfYmJHhHtoMLX3SPBnGixfkCNeaVHXoxe+/2AuYCoKovHAm0ldJja8PCLO6UVXLOmN3oGsslHj02deHUM1iCrqPEWniF4cOzh27OfvYrBWfEHIxcTVF4iK/IY/c9NLRPcBVoDcf6iP5LMAr5NYOJ6xWWiztZGIMhZfUD1Oc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 19:47:03.2381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dda17301-9188-4e7b-7299-08debc28b9af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7253

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
v3[3] -> v4:
- Patch 2:
  - Add a bool cpu_data->ospm_nominal_perf_set to distinguish an
    unwritten cache from a valid perf=0 write.
  - Switch freq_khz to unsigned int and use kstrtouint(). 
  - Add rollback in store_ospm_nominal_freq() to restore the previous
    cached value on a partial multi-CPU write failure.

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
 drivers/acpi/cppc_acpi.c                      | 58 ++++++++++++++++--
 drivers/cpufreq/cppc_cpufreq.c                | 60 +++++++++++++++++++
 include/acpi/cppc_acpi.h                      | 20 ++++++-
 4 files changed, 147 insertions(+), 8 deletions(-)

[1] https://lore.kernel.org/lkml/20260427051823.280419-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20260430142430.755437-1-sumitg@nvidia.com/
[3] https://lore.kernel.org/lkml/20260514194822.1841748-1-sumitg@nvidia.com/

-- 
2.34.1

Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD43CB90F;
	Tue, 23 Jun 2026 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202048; cv=fail; b=HR2RrJzpkiTUxBkkEsMRn/SFVlmjeKmIqZJBK807Ugov3ZrQCUUju6G4CN4lMELx/kv3VKXRK5gTCYRqNNIo6cVQDA+rG6v9mA9lTzEiepZPcuKKhM4DG3NCbFc7BfEXJLIF/S1QYzTrJnKpfSKXFJPAOioC6/u1OWQmAzIebCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202048; c=relaxed/simple;
	bh=jHkto399eWgUBuu/GkXJfzwjKO4AXeZoVWjRkGVSLec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=InK3Y0+nI0nZkjXiNFrX2CH9X8HICjSPW95+fB2ZO6RSfo2ktJsBFB/8dpE6p92KOZs4nizIz4GDzdf2tnUdRITseFwgFICvFe7TmJTXOmby/uU1xR2bvM4eFpEum0Sfb5MrqlvGVOw035BQdKiVgYeZXRgVehHfA/gBMksDKtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I5PWkJmU; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I5PWkJmU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOrfVfF7XUolv+EFejafCbC2RV4FfK/4ZeVwjwok+qwUoooSx1cyKx9SSSE7yF+dmcbeNNXBaL0AmqKtqApOfeOQJ9P6wqnXPdUkAmRyeQ0R461R9b5aTsFaMAK+HrwXITPWmcpkuXQ1g+Ki+xfhDXqXhtApizq3PIj0gQuYQJnT7SSoisVm5nJqoyM+VuksO0SnTqVGniAdc/zDolw6jJL2k4dCQHawNVb5Lt/lxaI5TiswW8Uz0sK196BdIxHBzI7zATDPzHj+51+7o5JsZAwk4yNTs8ftYt1iDKuIrRaBQFQP0PnpwQmmBl/pMH5FWOo8AuSMglKWzHNaP7+7zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfMh+IQr0Rfn/gr6uwvE5IlrVYmz9ScbhiPSSTRskFo=;
 b=qnga9lDtfeS6dzGUnhjS1u5DKDi7inq1ytO0MP7oZvb4esdt8R84t5N65QuJbqggzl6RrSm5NpH7WEdhZQ4jAhAu/2dOcU0nR6Z3mutBlhxHEiOmcXD1Iq1Sg50Zl2Src3iuDXyE9IU21Nf6DY9zufCiHg0NmuUh9V1nWkZNu2ufdPvyEG7ERPEHAPaG5B6JkAvB0TlzSEF5ROa6ZHKEjHGgz462wmHtvZTUbe6nwg7bvV9IpcWjHR54ucyzaLpYcFUxzpDGRzoau+vKkODy3vJtZnH+pQrhjLi5OkqgWbKLqRrgEGB4L3HAHqr2TseHUPTyDNRjdxCdy545lFmXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfMh+IQr0Rfn/gr6uwvE5IlrVYmz9ScbhiPSSTRskFo=;
 b=I5PWkJmUilXiuxCEbhAQ8Ov4xmrSm0pjKD5P5f/04mZ3fg5Z5Dk+pCPrNNds7RKcGO45hc1+4Gmv+9mp6MnQB5Rf8FAHyG7/ExWNEg4PXWbLBWsKtNPBOAEUHeZbwjKBFiHvBePIJxpN7w24lLrM8qDD8OXTtjoE4f8bt8scBta9RzB3ADlllhjxFpXnKMIS3W0hNRFTGgKb4bEU+AKVC7KUq1A2CLB6grvniLQdq3Mru6Vr+Dh4gjjJk3mpW3PyDvxmVnqKXFAZ2VYnoWhLhMYGhGR2w/T+oK9XOQji8jcSztbAIMsqpTHUuZWyvvcpFqKj3ilMLmTGdveVfPry2g==
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 08:07:20 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::86) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 08:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 08:07:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 01:07:01 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 01:07:01 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Jun 2026 01:06:55 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<ionela.voinescu@arm.com>, <zhenglifeng1@huawei.com>,
	<zhanjie9@hisilicon.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mario.limonciello@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5 0/2] cpufreq: CPPC: add autonomous mode boot parameter support
Date: Tue, 23 Jun 2026 13:36:50 +0530
Message-ID: <20260623080652.3353386-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 700d16a6-de29-4534-f425-08ded0fe729c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|7416014|13003099007|18002099003|921020|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	mBC1ITqgf2lb5Fx3RCEfvnzg9jsR9a7tRYgM72u1m1lseNvskCqdme9R9jJeA3laHGNHNCJLUmpgCI9VQPFT5CKd6J3ZzgTVipxRumT4bw27kQNwTkxtFvlw6EZ65x5BQQqbdZNes2YWCOJOeI65ZBVwtye1Qtjrnwp8POk/2A3xZFYuq5t8cPFaTIAueFlDaYsrGBrKfh94rR8hTc0x+sb2v7li0L4iE/Vu4DWRV4u49pylA46qehvvj/+Gos5nWvGxdzlxIhXHp+HMK1cnu+rOASxhiG6OTFuCvrq4x2V+HJvtD7CtWondjWPNTpSbQVtCX+AnOfEUMn5Ir246uC961ZoW5X4Tr7jk//vw9dEaJVuvZlCaSu4S7eUdqw6vAtTqr15abo69/53kX7j6HW1RD45FIlyKUSk3DKdJ4xVQtK3CJ0qHAcTXU/0l+Ka1Bjh8y5cXUyXsboSzMsz81Kq8c0zxu2lQxJOFp9DsUqnXUIuHtECp2zBlmzbGsh30Vwn2Irs+8jcqymZu8AcWpi5A/hwCVT62ThlfXGVJjLo3Xe4HtSiIwxk1Y0c0PFEczhNih0EgTHe/gxB86nkX7RTPeVSzuM+DEVUofehhLS4DYKSagaD0FihPM3R/lf9nXGxpBLaQogIXu5An5jhDg3sYAbbQlHIQJTUd7iJ2qtVtqiIvJ6GY9FTyvyJAe2ZByJpnBJU3o9q4dL7o1jOTNvAJQrRuGDjtm5ATkYNd8LKlpJI6IMmfjwB+4OKI5qi9
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(7416014)(13003099007)(18002099003)(921020)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ikQdEZ9Mo8efdq2Kj3ccKfzl8v59EkDBaf2yUVp/8pmy17RdQ0SK7sMw40dann9YF4Gessx8CiNjWtk3zQHfOZpzCdGQgp9z71IcNzba51cMtwyOM0NcE+Ypr6fs1Em8TZYH7YO/UBCnAwoY7K7jYH1voznfQqjjb49coVgKhBVx9dyYrovu3gDesM7ryY36SZVZ2z7xxJjiFCLjv5LgCjisWCWU1Bl5ldVc+eQz7UQ5ewkRtbL4CjCWeQNmNRfsdjZAR3ZTvSTB1VQgaCOODmFID9jmnSGEnbbjed0Z2GRu9sfRKFjlaaRXM85uHu2oaF9fdye85o0AIg7nFlblvYMAZyhZN78b+LC5LUQuKgJ8oQI08grj0wi+N2ivMlTOYTZh4Ifu01r3sJx5+IRO9iOtpIVUioct+yru1mDqwRvXBA11RMjSqtWOQOCIvoQP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:07:19.4487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700d16a6-de29-4534-f425-08ded0fe729c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067

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

Patch 2 relies on commit 8c83947c5dbb ("cpufreq: Use policy->min/max
init as QoS request") so that policy->min/max set during
cppc_cpufreq_cpu_init() are not overridden by cpufreq_set_policy().

v4[4] -> v5:
- Accept "disabled/0" and treat unrecognized auto_sel_mode as disabled.
- Rebased on the merged QoS-constraints and updated commit dependency.

v3[3] -> v4:
- Add 'balance_performance' mode which sets EPP to 0x80.
- Add CPPC_EPP_BALANCE_PERFORMANCE_PREF (0x80) constant in cppc_acpi.h.
- Clean up EPP mode selection with switch + boolean flag in cpu_init.
- Use local variable for kp->arg in auto_sel_mode_set/get to avoid
  repeated casts.


Sumit Gupta (2):
  cpufreq: CPPC: Set CPPC Enable register in cpu_init
  cpufreq: CPPC: add autonomous mode boot parameter support

 .../admin-guide/kernel-parameters.txt         |  22 +++
 drivers/cpufreq/cppc_cpufreq.c                | 159 +++++++++++++++++-
 include/acpi/cppc_acpi.h                      |   1 +
 3 files changed, 177 insertions(+), 5 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260317151053.2361475-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260424201814.230071-1-sumitg@nvidia.com/
[3] v3: https://lore.kernel.org/lkml/20260515122624.1920637-1-sumitg@nvidia.com/
[4] v4: https://lore.kernel.org/lkml/20260527202550.206828-1-sumitg@nvidia.com/

-- 
2.34.1


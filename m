Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6014D0A1C;
	Wed, 16 Sep 2026 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789555158; cv=fail; b=sxkqNQbpyLgf/qY4s1kJ6aFJoI93m2dLpa8sfzzKmZsLneffd1Iesbv6U1btEtG7lQaWr9WpstidzERPp2wVTtUUhhKdG7BgKaEBgTSQjEOG8cyhjeIyWSHDygGiTlyhluC/fIjbFzU5R51tOkNW1wkDBsLMGqVAMTc9jVGTPgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789555158; c=relaxed/simple;
	bh=JwVRPJhh0PZYPCy8j56bjc9hENFxPtD7QGy1AlU+MP4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RxYTFw5ISGmApdepu1toThMhW/por9s+tg8hhetF72YeqIo8tIUQ0jJslZ9F0u0JW9zlfNlZTRrsUfYanhDTpxbD2EXESiNA8kK0e5+p1gRUdKPpWp2dBYcxlXoLIKainqysEoNCry3xOMUGBMx39ju5Xtp8kOuVQDw2bPngGgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XavbEm0J; arc=fail smtp.client-ip=40.93.195.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XavbEm0J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUDApUm8CdLkbX66+jvuspTmo/VRy8FlhsIMCvAE7y+qU1He4ozXk1vbnJeS04gOSlhoUL3qn385/gYX+Lh+wpVRMRZWL9MklIV70xksGBFPB8Lnq8Ik32z9qCyvZ0wM8Tp9K3vDvE/S4HDacyFN7uHP/63OSeyC4L2PKUY4sTJSmakg78zjxaSW50TWdsXeT0NaW0nT9/eDg/U/2Qf3g8Dksdr5PibK7598RCQmnsXqRKFD1dc7toz1U9DGOwxlsZYe7/JQxMviaiIBOY0mG18qZMwKAP2NXC5xNK0ZaZf7AuhjbtqjQICotRuEKmMtb1OD8+87dQ8l5j7lk9uSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y3yUNUqla45/a5+5F505QtsFee8olmyJa14mnO7m4s=;
 b=iEAOqA7O3CV6Znm58VJPU8n+bBE5ZUiMU6sL8Ytd73Zv7EV5w+ovUj5CTvBcSShaQt5gvBg5mA7U6JSVPqjjU6eTkK9UcroNJnp9ml9IF8faqAAmYSFK5oZrQCXVJLknPIIPrLeL+QKtr9ru7tAnUrQbtmJGPw6KyS2eQDKkPar4+y/erf6zwRth6GYw5icDgCYJ0OHMVHQ/NRLFFdpRI43POtC0jZaTHJ7vOLPkzZIaTKNwtXf8DFqJokMO90fe9HZ7LR39knrvVTi43ZUuzisAAHHsxEXCcUKjLY7YMEAHGPzeX7o1WMIftqrdLO7ESC26MlSi4iVNp+Jo+4xh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y3yUNUqla45/a5+5F505QtsFee8olmyJa14mnO7m4s=;
 b=XavbEm0Jj5hgk2BP6R3VJqrskjPQwcbyLhodG4ntxz1zG6QL9lF83QdxcmURIyk0/Ga05FVsCSjzn8Kdqh3AHcwSjJ2VEYzSD3SrURuN++K7ZEy84UUx+eXaR/zjHorPOUEsnYnFpMJuDA4PYCISeIPL6WNNlVJWqPqi6aTK4XaiUYbZmDMVxQD0x5MitG63AOS1R4ZD0WQY9f/AqbpsPQf9HXcJpp/jdM587ciZtBGy7iGASaW6ac7URUYHB3DW4TkTZCHZuDYs3FQksrMSJ2E74OgRQEa0r/rEdlrSAaa17EbpfPc8Q2wB3m1GY7B/kMGgFEarQhM8oH/HZbPU+Q==
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by DM4PR12MB6279.namprd12.prod.outlook.com (2603:10b6:8:a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:38:51 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::58) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 10:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:38:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 03:38:31 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 16 Sep
 2026 03:38:31 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 16 Sep 2026 03:38:24 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<acpica-devel@lists.linux.dev>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v5 0/4] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Wed, 16 Sep 2026 16:08:16 +0530
Message-ID: <20260916103820.1760297-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM4PR12MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f9773c-bea2-47a0-bc1a-08df13deb29f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|6133799003|18002099003|13003099007|10067099003|921020|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	pJtVTidvZSt7IZzouh27off7ft8Hw6e+GfvMd9rKf3FZr1OFf3j0NUiXrkJg8SFeoA831daPPu6hnDQ2wCfwqlde2wm8TLaCnRsYSZsThtD5WAEvxveNVVSFY5vmrXW7VastKmy4ahBSnbRuC2RmORRmsc9FpTTo9JaS9vfj2Uqlock0w+3SenwqMvy/X7HdUR6ANCbxB3nZRQxYTM1jV0R3z6I8/yBxvpPSnKS82zLR6bNl7/YgP03qqpCpgHSFVqO+afsWM6gleIMDHNkDkZfXhsfr23DMFbx5VTqKuBOgY+eMKFfujh5YLu8HObzSdAO4GqITideUOtMJhWu+GyUdVh/idXcbyTBwiYiTjoaeZaRpme8dwEdG6rpoFlvMeRHVu9py9hhYrxRDXRhofw/dqcsVHaAzXINkCW7GQD+P7F4fMNhnYBAC9SYCCIMi2vEqt10oD1zrq4I/Z6CcOGRAt5vyCZoRIsxnLOTkvMDMcQwuQ4/gbndHZSXAwc/QT+LnSNtFe2sOfhYABiicpcTVJC963LmnUycdEhEHaMekvjLlS+DQrvvmvxbLKTek1evA2LreuUKNgU75ryfU2MZPM2X6UzyrwKeG1g9hIHlHBQ9DTWW36S2mYWylpcAzMnwvV893CkNje8+0ZU+jwvEuuJ85ha/fBWGKBJr6ACCNSQi2CoYcYqMy/DpQdoxdZblhPDezKbAW3GNo6xYF65Kv7BCprzy2IaJSyZETMabDMXhaMVq3HvyKVkl+q/cc
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(6133799003)(18002099003)(13003099007)(10067099003)(921020)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aO/Qq/KWB+RiIHuIqmiK+qEv/VvMa6MmytgkIMiGZAcT1yyvs3VvUVXYmQJDAkILg/i13WZMrhKl4P/gFSOm7oxvkoRh1PZA1RMzKJQAlDH2Mpe2kskblOCY6qX8DVaTPNc4tMAB/PL+5TCLKsiypEQiJMmt2iL0HWgNooraCEUUCuUiednlmKxdYQwzZ9ivUkA/Ed38yghSY5W8lp8utEloCnfZbwskEFJ4abNzYBW342LFO9U2f0vyKolsQFQxPMb8wEZ7MhZ0f4QnGSjsi7+6Rz8bbBV2tJsTkC9excqBqwkjM8ECJntlRVmF/V1QYgVXbkWMzHJRqDGgfq/g4Wc++BblVCgKCp0rDOZgSrhvQZeaUi+JqU5BiQr/Z4JGMOJIFAslUN7WKZ5AaJVuylM7naIaF9yi+bnMUuH8X+Fd475GTHbJNOMzmhYM0Zko
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:38:50.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f9773c-bea2-47a0-bc1a-08df13deb29f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6279

This series keeps the CPPC cpufreq policy alive across CPU hotplug and
preserves the OSPM-set CPPC registers (Energy Performance Preference,
Autonomous Activity Window, Autonomous Selection - set via sysfs).

Without online()/offline() callbacks, the core tears a policy down when
its last CPU goes offline and rebuilds it on the way back, re-reading the
CPPC capabilities each time. The values written to these registers can
be lost:

 - Across CPU hotplug or suspend/resume: the platform may reset them
   while the CPU is offline.
 - On driver unload: the driver-written value is left in the register
   instead of returning to its pre-driver state.

Handle these with:

 - Patch 1: adds online()/offline() callbacks so the core keeps policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 2: makes the autonomous selection register helpers take a u64.
 - Patch 3: adds a table-driven mechanism that captures each register's
   firmware value at init(), restores it from offline(), and reapplies
   the OSPM-set value from online().
 - Patch 4: extends the same save/restore to system suspend/resume.

v4[4] -> v5:
 - Patch 1:
   - offline() stops the frequency invariance updates and online()
     restarts them, replacing the resync that raced with tick. (Sashiko)
   - reorder the functions to match cppc_cpufreq_driver. (Jie Zhan)
 - Patch 3:
   - reapply the OSPM-set registers even when the performance control
     write fails. (Sashiko)
 - Patch 4:
   - suspend() stops the frequency invariance updates too, completing the
     patch 1 change for a policy whose CPUs stay online.

Sumit Gupta (4):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Make autonomous selection helpers take a u64
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume

 drivers/acpi/cppc_acpi.c       |  20 +-
 drivers/cpufreq/amd-pstate.c   |   2 +-
 drivers/cpufreq/cppc_cpufreq.c | 378 ++++++++++++++++++++++++++++++++-
 include/acpi/cppc_acpi.h       |   8 +-
 4 files changed, 381 insertions(+), 27 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
[3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvidia.com/
[4] v4: https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/

-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793993638;
	b=TaplFa/raeS1gb5cSMuczYr3Ys/MZTijK/bdPHFkRKhJ7MdBbUCxkMuFUVEoOIuDw1Vs
	 hXpxcvfBrj1iooOD9vyEjKAdIzHb1KrAfhy0T5JFssewC3Uc7JDWsTbwPofH0hQ4OCoAU
	 olIaLw3NZEgXZYhCRPq0T+4D7W/Lom9HIp613u2k+QIRFYkORBaq+d/jIS65XcF26uzL2
	 d942cyzapVal9IAdOHLPn1qsDHNAVKCDL1aS3oNa1MUUY9NnTCVnD1BrNoTM6LQtUlSZ2
	 6Ws1vwuqb/M/QUC+pm5rNbvjZMmVPUbVq9xEgkdVQPfwyGlsLnIAWgeXWHccJnvmQdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993638;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7/zqCzzGYvUAL+BeZz5OYRAv6Ex/hzfGP7FkSFADc8A=;
	b=SSapOIX8lUcfn2bwsTW9BJsIMzR5LVf5SlE3Fd3BoKEd/YUoiVtTxShzY1RbHbBIN1li
	 HgoQgStN8z3bAtYAIcA9nHeezqiv3u9W1xN0/D4aNf1q0+RKSuBLlgvAJK6lMcVh/jOv5
	 Bgo7lF02hlofSyLyB7pRl7HH8KTHFZh5lEiJVBX/UeiXDQL1EW9QMIlfh4KhJLTDs1OvY
	 vtC2GFnYeTCXqpELhCRqB/V2LquhWMQDQON/ldbTM9bes3HAN8rastINPwWujx+a0/7Kb
	 F5mFEul9DIXduPK3Ou7CJn/jHQbSl73kkAsxE0NTZhCPvo2Uie3f8uN342ER3hpQAuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ts0hVgLc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.54
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012054.outbound.protection.outlook.com [40.107.200.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C255606A326;
	Fri,  6 Nov 2026 19:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C255606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ts0hVgLc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whnsNQrfI02rnq9rPxNcy9UvJlhjlbOZCzIWm60s3PnibekWXs4kb5iMfU60Ic9cR5USLlpBmsB5sHacODd64A04U+bIrUH+YG4zeCifXDj6vMzsHusTfEY4ZQk98meX0Hr4oKGulW0JQ/3mXwxxr1vIjQGNT/FmWd30Mlhklq9UgtbZ3+5z22l1/BgxhOwUiPqVD3Ceg2vQswEheAWIDT29D43pGhcHF0/9iNHkZNqUxV5MoybXBz0s/WpTwncqPd6kbTsVAVUQW7QGi80cFnBfQ3Wi+eGjahMMysJt7B907oCJbTEn4rYKbq9/96GC+PM+Rv8900mTYtijSDj1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/zqCzzGYvUAL+BeZz5OYRAv6Ex/hzfGP7FkSFADc8A=;
 b=EVlI0Lr4Q2I8b+3hJ41ScxggozIVPEEjsfAq1fZK34ciCPmNh8GELSC+GqAtlhPbLRYBzKKohr6hz/+IeUuZ3r7iZMbzigJc37sJoToslcxGptpSp1DhzlBZkJFOzn+iQs2pqav+DyHdVPnvPmQGqgeWxGgFa5QfElKlOCBMdUqZAKVwHIA76i4UcaE5v7fXW5AYjQ0/z/FVNc7TW0UDBFxhNbNDpDlx9tr+dbdCkNSBmBZBjmpu+LygKxv9YFx+f0FjfIAa7xWQfi7YlOasUkIeosPt8SuuXqNW2xT3C7xuon1xkQAufNSmDm1Qe6q7P6lKHBDk4Y1vP8oj78E0RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/zqCzzGYvUAL+BeZz5OYRAv6Ex/hzfGP7FkSFADc8A=;
 b=Ts0hVgLcgoZ//VKLHlIqbLIkeM/roZ+oxw90ByaBJXMnjeY9AiWdfJIE0zGJMMEvKyzXdBdc2Rbv907hZSfbEHECXe/FYfUX4Atj2FQRK+3iLlzOEZjqHUooVKi+3VTQVZHRHSY1OI7UFGckLTpXDwA5p2JWA89uQeugWfOjreKrL1LkJqdE9zYdT0YtacBqA6qYDQhIi6N9eszP+rSwQAocf0f16TXwuPDyNl2d6gDlYA8pngU4jJXbg6Nu1CYECzesvykTT1bV8jSmSxiGA2vrUlauUqEyWF5dIxvOESoI0xEA0CSHQvAwnBdpklS32+Wmaq8pzMUp3liuL6DiRg==
Received: from DM6PR04CA0020.namprd04.prod.outlook.com (2603:10b6:5:334::25)
 by MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 19:33:46 +0000
Received: from CH3PEPF0002457A.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::84) by DM6PR04CA0020.outlook.office365.com
 (2603:10b6:5:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 19:33:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF0002457A.mail.protection.outlook.com (10.167.252.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 19:33:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 6 Nov
 2026 11:33:30 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 11:33:29 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Fri, 6 Nov 2026 11:33:23 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <mochs@nvidia.com>,
	<bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v9 0/8] ACPI / cpufreq: CPPC: Preserve OSPM-set registers and add ospm_nominal_perf
Date: Sat, 7 Nov 2026 01:02:56 +0530
Message-ID: <20261106193304.3347374-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0002457A:EE_|MW6PR12MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6bbe43-bcd7-4fba-fab5-08df3c3cdfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|23010399003|36860700016|6133799003|261102123227099003|18002099003|56012099006|13003099007|10067099003|261009223027099003|261009221227099003|261021121427099003|921020|261021123027099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	vyVXCYQe7B8bv8iGinTRRnBW0SRAhYn/fhGnvBqhPO7IVBRuA+qNJ6eZsLm2PdATCAUSQTXWVMemlDTK1CsAzARlWgl06trB0hyQ3kVDSMaDSe3/wvKtu245PT1HtHF1y/NiSW+52Pp4hPnJJwjF9VbVPly0by8BoQFi45YnRF2PArkzAuZv4iU0PjF8OEDqO0my7fgrfLXPvgGP7/VifFhpXSWTmRz1KqsEYmWpnHjvlUdh4z28rGMmyjJPuy07lM07opptQj2h3U8quNIe831jVxIS5MReUbFVMTQxzhahrMJ5asQfrndBn5ZibttMCU/+Q+rjG+UoMG+A0hmkTLmzdD0aPY5K8+H5HYlf7IVC9wcxxrSthizv0YOPUUHQiNwiGtK9zXZbGnG1jgwrRlDyzAsc/ngX3AO33KOeLwxjjZvJPY19xnhkwOZ6xc6XV/rpkeh5lPEhCIWSGNxLBQ8Ug7IGFtcQCIeOaLqNW/pWzjrxv6HjpSUEDO2fKwTrmYfpXuTxGObctL8pT2kK2yqpcBb8G9KKBuBmtXvfhLN5BEpbsAMGHISJ1dWe5rJTWEP8AaFv9SI8cbbBNpHBQaBhO2csMj5CrYSiX0BcO0P15q1MzQsbHTRLjqofm4KHXfYnoCEzl1dRVoEkmhJFyVU8kPXZQP8TAzUo4wkq9wVH+JBeKX7wVR9r5eZQugJLPUskwvASwRdW0ZEbE8EMpRyFFftQTPnPGei+cXuNpazWojWlxY/cS8pkjlq08+c+
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(261102123227099003)(18002099003)(56012099006)(13003099007)(10067099003)(261009223027099003)(261009221227099003)(261021121427099003)(921020)(261021123027099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MEcO48vL71m38pbCYUDzAws7AHKcrkYwpFFYpgUIxH7aGQ9px/egMXT582CmuYauSzeFn3XQJoZJWfmfFdGGVI4h0LTUChfp/KNtAPODCP7pEsTuJ/XJOoQwKLEEcT18yzuCzfBuloo2jOxMdpNXatcIipTkdOH5vNML5Rpex5wjyiL9uXQq0wpa+gLMzBlWdHF0T8UbdaglP93BeQezfYFWzv/d/CNP3c+EoQ9KCGVNMe5xBY9PazOV68FNlsxcEIv6e3aQdeUCmrF8Wr3fbZRL0W2XcFFFvm9kRhES90kp9yxKWO0AEPnlENcyGc/NvzWH0Z/GAAQ9lmiGY/yBxf3cEohq6m0g8RJrWKqchyo+3prz5bKgGDN0+fv3h+Zy2Hp4cOjE4iO2/HsshI7igTWpuW9NCeBIn/NCmhxXw10Jr4b+E6xDo+Jag8AjVBfB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 19:33:45.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6bbe43-bcd7-4fba-fab5-08df3c3cdfd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0002457A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8758

This series combines two series, as the second one builds on the first:
 - Patches 1-5:
     cpufreq: CPPC: Preserve OSPM-set registers across hotplug and
     unload, v7 [1].
 - Patches 6-8:
     ACPI / cpufreq: CPPC: Add ospm_nominal_perf support, v8 [2].

There are no code changes from those versions. The series applies on
7.4-rc1.

Patches 1-5
-----------
These preserve the OSPM-set CPPC registers (Energy Performance
Preference, Autonomous Activity Window, Autonomous Selection - set via
sysfs) across CPU hotplug and suspend/resume. On driver unload, they put
back the values the registers had before the driver loaded.

To do this, the driver keeps the CPPC cpufreq policy alive across CPU
hotplug. It also orders the performance-control writes in
cppc_set_perf(), so that restoring them after a platform reset never
sends an invalid request.

Without online()/offline() callbacks, the core tears a policy down when
its last CPU goes offline and rebuilds it on the way back, re-reading the
CPPC capabilities each time. The values written to these registers can
be lost:

 - Across CPU hotplug or suspend/resume: the platform may reset them
   while the CPU is offline or suspended.
 - On driver unload: the driver-written value is left in the register
   instead of returning to its pre-driver state.

Handle these with:

 - Patch 1: orders the Desired, MIN and MAX writes in cppc_set_perf(), so
   that the platform never sees an invalid request.
 - Patch 2: adds online()/offline() callbacks so the core keeps policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 3: makes the autonomous selection register helpers take a u64.
 - Patch 4: saves each register's firmware value at init() and each
   successful sysfs write as the requested value. offline() restores the
   firmware values, and online() reapplies the requested values.
 - Patch 5: extends the same restore and reapply to system
   suspend/resume.

Patches 6-8
-----------
These add support for the OSPM Nominal Performance register (ACPI 6.6,
Section 8.4.6.1.2.6) to the CPPC ACPI and cpufreq drivers.

Unlike the read-only Nominal Performance register, OSPM Nominal
Performance is writable and lets OSPM request a nominal level below
the platform-reported nominal. The platform treats performance above
this level as boost and below as throttle.

 - Patch 6: adds ACPI helpers to write the register and to check that
   the platform supports it.
 - Patch 7: adds the per-policy ospm_nominal_freq attribute in kHz. The
   value is kept across CPU hotplug and suspend/resume. The register
   cannot be read back, so a read returns the last value written.
 - Patch 8: uses the OSPM nominal as the maximum frequency while boost
   is off. Lowering the nominal creates a boost range on a platform
   that has none, and boost can then be enabled.

v8 -> v9:
 - Combine the two series into one. (Christian, Rafael)
 - Rebase on 7.4-rc1.
 - Add Christian's tags.

Christian Loehle (1):
  ACPI: CPPC: Order performance-control updates

Sumit Gupta (7):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Make autonomous selection helpers take a u64
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume
  ACPI: CPPC: Add ospm_nominal_perf support
  cpufreq: CPPC: Add ospm_nominal_freq attribute
  cpufreq: CPPC: Reflect the OSPM nominal in boost and limits

 .../ABI/testing/sysfs-devices-system-cpu      |  31 +
 drivers/acpi/cppc_acpi.c                      | 362 +++++++--
 drivers/cpufreq/amd-pstate.c                  |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                | 689 ++++++++++++++++--
 include/acpi/cppc_acpi.h                      |  19 +-
 5 files changed, 970 insertions(+), 133 deletions(-)

[1] https://lore.kernel.org/lkml/20261030092416.1993889-1-sumitg@nvidia.com/
[2] https://lore.kernel.org/lkml/20261030172745.2045743-1-sumitg@nvidia.com/

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.34.1


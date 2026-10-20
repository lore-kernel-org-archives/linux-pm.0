Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792498760;
	b=VhOMfwyxpY8mP2htv17iXLBSgg1NIzOB6tfR2lIAubvmij8DKHDZ9zpxT63uBUyVf4ey
	 VZEBNxXDlrhZWccQBH3Z6zWqJJ9vwoWzBr7IHNax+HLBm+BB4M7YQmMPH7jBfRVW7tpiQ
	 wPM/BN2Zdbo3sCqcQ8ep5jfTSpbCJUjuRzfbLeRfeVlzSbc0tyzSg4R69CFuRowTDxFDM
	 +xutfgptszl0LDqAVOKwlUQw45vweEi0D9DoNz5uDzNMxLtWiHjTRBYzuO8U0QGkwby2p
	 +FFBycaaj96Ch9W4NStxZ4sa0dAHXbwSVZGIzI5CDEHQX2b+HSAz1BdGP3LeA7H3gXw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498760;
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
	bh=Bqui4gSEsLKVOJwH65N6nGKURuZZrTOxGnpUytKUWO0=;
	b=vyggDSAJ6XTKAZkd8ioGwhVrVV8gkz15bcVGIAzPdcoT3szNz0EapGduoV0htkCoLJ6X
	 LI14pGhaYqo/SVSY+eS5DoxxWdZaQCPrp9iF0UyiopIPlZGsz9S6xCTNWRGPrVa3q4uKE
	 7esxikueFsw4iGp2ajbSzp9hna41Zs6x++LFHKVbCjY7z+FPaTJ4CwdB1lcBWMQ5gpwJ5
	 VY1TtB9fn6BgJccAUjqhYS4/BFD9/j7DoWxk2BdBrzWWWBGJK1oxG+VdCO6IlDFBWjxgw
	 6phjftQq+B+AgO5/j1WG6KyOeZAJZTkYCnj/fIqCUHoHqmeYlkn5wcPEPGSNGY2zk+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g+YgJloq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.39
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A908606A31A;
	Tue, 20 Oct 2026 12:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A908606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g+YgJloq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JmX+CD0rGvqrI4Q1pkudWY48dUWFPA+JSV0OPYsydu1waG7/cNCPjUud4+VLIdPOM6DdFn+owphouFJhj2MiMFjJ2zgZT3JE9kFFhiIfY9qF/8EWWUBmaPySbO+W94WSQp3/b3ZflKTKkNspOjOFGhLcr2CFnvgvvUMG5Z7JQbdTc9VFKctRg09q7K24jHKdYMhtIsaZd8VSQMtj86v07Vx7m8kRWGXUyfooCGCx6zZVpLy6JQvbr/Dg51JjkTsxq3CQB8LRRcJHH+9GmXMaG+6w3kItdeiGH7XK9DPOGOyxOchlU2V9ilRv0BhTQbfstVA2fqNXL0COVtlOjznzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bqui4gSEsLKVOJwH65N6nGKURuZZrTOxGnpUytKUWO0=;
 b=ALs8xWxHJMdkMNM5Trx0HEurGivFDkTy2YN4WPmEq7v8r+jtTj0C7SG+W+dLr76gGwMM1JIsZxat7Qp5I95hvX+GfXPRFglQniE2r+WVv1A02TCJNrrtMPjdzOgoR87Rgy/CvvjJ7dT/aUj2OXylrRBZr6Au6aFn4aDHI99SCNio6zQ+1luzqzl1eCnKd7135XTNCbz81+aw1MbKdouqRzJE4L4k6GLGumaCR6ipnJy4jcPJSVDOj8OCGbKeAVqupclNrhfn0wNGCfm+W7xgfU5kOSnXNM8SRTA/Hl8BZHMb16gJKHpasfAqiiGVfcCXoVlQm/qjL0kQUz7ZxEMzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bqui4gSEsLKVOJwH65N6nGKURuZZrTOxGnpUytKUWO0=;
 b=g+YgJloqBZ7gths84XkkyouAnl5ZF656QgkI+1sQ2mxbAGzpCOVh8Z+hGWxpbRhYBcyNK1N+RecMvteq04tUWySruaWKmfpaGM4Ozzkc7VsHtYbIm5FQQTWEvMBQkNv57dRn51h9R76BjVurvBCoUWxTWZby2eTpKStQWt7/kEuDGftOLg2k3MvX7qjtGZmhhiTzhMrISHwtQ+gmQv+r3A11vRJHM2izu41sED+Ci4ee+Ay3FvwqI4ee8D5uXraCS7vCoScnz9AHv7E3V/j2bLKapMCEy3eq5Pfz1RrSCWHvX81xnnlA40nupa+Vn5MV8FCmj4suiT9hQt7cUwJOOA==
Received: from BLAPR03CA0065.namprd03.prod.outlook.com (2603:10b6:208:329::10)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 12:19:15 +0000
Received: from MN7PEPF0000014E.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::76) by BLAPR03CA0065.outlook.office365.com
 (2603:10b6:208:329::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 12:19:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN7PEPF0000014E.mail.protection.outlook.com (10.167.254.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 12:19:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 05:18:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 05:18:57 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 05:18:50 -0700
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <pierre.gondois@arm.com>,
	<christian.loehle@arm.com>, <ionela.voinescu@arm.com>,
	<zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <lenb@kernel.org>,
	<ray.huang@amd.com>, <mario.limonciello@amd.com>, <perry.yuan@amd.com>,
	<kprateek.nayak@amd.com>, <maciej.wieczor-retman@intel.com>,
	<pawel.chmielewski@intel.com>, <linux-pm@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
	<sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>,
	<sumitg@nvidia.com>
Subject: [PATCH v6 0/5] cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
Date: Tue, 20 Oct 2026 17:48:41 +0530
Message-ID: <20261020121846.691218-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014E:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 31788edf-7acc-48a4-4b59-08df2ea45b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|7416014|6133799003|18002099003|13003099007|921020|261009221227099003|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	0xW0x6kfFikfqXydZcfzQlAH6RDUlVCXYi7SoIDc8vUspPHjBHDWZa2j2NXfWdjcz/tJM6rsxW5/ua9j+3Q2wVwiO7d08dqEFgBVZK/nrhDlgKqZHfc3X0qnig4vFjJo5L8QsdIrSB+QirI931SB+SU/gj/4Maien/hmQSK9T4Uit+6pFpjOgKMaSAT+4KoWB1HYTCUYKpNUfnO5eGMR3PGppIOpDcaSNFtTZQUgQ5fJs4UgMA7xV7WAlOZt0gp2kTQzZP3U990Bslwi4cJ8uyehYHiv+vuyIrhZpU1neSK+zj+7/SoPnCxZo8rtm39c3v/0jqBdHP4QctFyPbaTU3qZs/lz2X6Wd7OQrsmfUO82XceZYTqPWE/jY6q5O/iFURBSFmZ+Got6QoGZKDlUQHEC4fIeLs7pNwd6BbRyrkRbJo0DyRcuVdmSoiKxuEN3ctKgY68Z+hA5JxgmyDPORtjM2GxRAZezMZqsAQAvs1Vg0evrq+8A1ygL4gMGKRDm69fQHjrY6PtWcLukFiNUgE7Ihx7qZRcXVdkAgFIitqr6oQ2qvSpG5UFoHlBeU2sXiTUjCbY37GiCfidFxFlt7v0goT5plM2HjmKpXuqhtkVadG5XqgmzETtF+CAcp0K9s5RwDMRTbyHAZSep8gpLD5KbFXelI5+lE21GPUk4OqAq320d/0M1InTBY1sZVQgR4PrDpXWky01ukADhdc95V2KYwq9sIPJ+1m4sutkiVEstZ34ZdNTA5Y/0RjexsOem
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(7416014)(6133799003)(18002099003)(13003099007)(921020)(261009221227099003)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Iiaf1VAIC8QBlX9vmfd1xXsWcOciNCEQq270IHQrLD9Y6dzJF4GwUebBbvgB+L8TPDSTLby38FEPDtVtj0qReDmUutRfDPyYwJ39HO0xEWTU1GKSVT090oWctEqMNeaX9U4fAur3VIpvkjNoCgdLml3JQz44lj5dktSC4ADftp+2Tp0oocM7N/ZPvzMuSboc8wkrQtF2rPo/coKeSiHME4XXSnpn0STaepsxfmzeWzxKwlGoKYptvKslrL0PHYILSBWuPy6ywa+uGDAeiKKTcVWH199Z41NZkXY07DQ7OKMoiQ76hx2rbrQhgNClynjuIdqxDcTtTruuB2nm5pwA74QKJEH41iLeCNQaX4McSejRDZHsZkmUCJpm6HMRnmKpN6EVpQn9IIr6RQhz+4D7RDTPwec/iWMMQJSyQeJ5fV5mYT+ls1pTEw5i8BlaUzFT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:19:14.9925
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31788edf-7acc-48a4-4b59-08df2ea45b55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

This series preserves the OSPM-set CPPC registers (Energy Performance
Preference, Autonomous Activity Window, Autonomous Selection - set via
sysfs) across CPU hotplug and suspend/resume. On driver unload, it puts
back the values they had before the driver loaded.

To do this, it keeps the CPPC cpufreq policy alive across CPU hotplug.
It also orders the performance-control writes in cppc_set_perf(), so
that restoring them after a platform reset never sends an invalid
request.

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
   that the platform never sees an invalid request. Christian proposed
   it in [6], and this version adds fixes found in testing.
 - Patch 2: adds online()/offline() callbacks so the core keeps policy
   alive across CPU hotplug instead of tearing it down and rebuilding it.
 - Patch 3: makes the autonomous selection register helpers take a u64.
 - Patch 4: adds a table-driven mechanism that captures each register's
   firmware value at init(), restores it from offline(), and reapplies
   the OSPM-set value from online().
 - Patch 5: extends the same save/restore to system suspend/resume.

v5[5] -> v6:
 - Patch 1 (new):
   - add Christian's patch [6] ordering the performance-control writes.
   - init() requests the full range when the live MAX is zero, to avoid
     a probe failure.
   - clamp Desired to MIN and MAX, as rounding can put it below MIN.
 - Patch 2:
   - offline() lowers MIN to lowest_perf with Desired, so that the parked
     request stays valid. (Pierre)
   - drop cppc_cpufreq_prepare_perf_restore(), as cppc_set_perf() now
     orders the writes. (Jie Zhan, Christian, Pierre)
   - online() caches the restored limits only once the platform takes
     them, as set_target() and fast_switch() do.
 - Patch 3:
   - add Prateek's Reviewed-by and Tested-by.
 - Patch 4:
   - replace struct cppc_saved_vals with a u64 array indexed by register
     and type, which drops cppc_cpufreq_saved_reg_value(). (Pierre)
 - Patch 5:
   - fie_init() covers related_cpus, so CPUs onlined after resume() also
     restart their frequency invariance updates. (Sashiko, Pierre)
   - drop the fast-path cache reset in resume(), as online() does it.
 - Prateek's v5 Tested-by is not carried to patches 2, 4 and 5, as they
   changed. A retest would be welcome.

Christian Loehle (1):
  ACPI: CPPC: Order performance-control updates

Sumit Gupta (4):
  cpufreq: CPPC: Keep the policy across CPU hotplug
  ACPI: CPPC: Make autonomous selection helpers take a u64
  cpufreq: CPPC: Preserve OSPM-set registers across hotplug and unload
  cpufreq: CPPC: Preserve OSPM-set registers across suspend/resume

 drivers/acpi/cppc_acpi.c       | 314 ++++++++++++++++------
 drivers/cpufreq/amd-pstate.c   |   2 +-
 drivers/cpufreq/cppc_cpufreq.c | 465 +++++++++++++++++++++++++++++++--
 include/acpi/cppc_acpi.h       |   9 +-
 4 files changed, 684 insertions(+), 106 deletions(-)

[1] v1: https://lore.kernel.org/lkml/20260623095403.3407436-1-sumitg@nvidia.com/
[2] v2: https://lore.kernel.org/lkml/20260716153820.2007095-1-sumitg@nvidia.com/
[3] v3: https://lore.kernel.org/lkml/20260724215937.3368276-1-sumitg@nvidia.com/
[4] v4: https://lore.kernel.org/lkml/20260806200857.601152-1-sumitg@nvidia.com/
[5] v5: https://lore.kernel.org/lkml/20260916103820.1760297-1-sumitg@nvidia.com/
[6] https://lore.kernel.org/lkml/1be30b2b-e1e5-41ed-a0dc-0dd5ad3c47cd@arm.com/

-- 
2.34.1


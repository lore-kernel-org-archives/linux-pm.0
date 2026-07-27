Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE23CB91C;
	Mon, 27 Jul 2026 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785136886; cv=fail; b=dz/UoRl9y/yGayh7Kh5RbSQ84h5HrHqaryhUahxfWDWUpizl7B+6xu/qR4vfmZrLmIdFYnk2FwtkJM+KrScSGLJOxe55h56iLq7vO/AwStQiaFx6kIi0li1kw7P+E+SUPVb68kjEYhsVlfoMvlB+iLYQFmNNbH7omlC8SJd9x5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785136886; c=relaxed/simple;
	bh=DyWw6RY1BHSiNdM8nBtj+MDGvLz8AwkEFOBZGAYlrLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7AVVyqmtd+Fq0LUnIPk4SZvVONlVImCWfTRAz9g5zyumHZNFNwxboSQTq19iq+9Sgj2PEvHcLxN4Ww8fj0zWJ+mtRrerNIo2ulsGvq/FJIT83kBS2eiM5apLVOBGiM9C+v2LlJPORy6K8W+YqwHO1ylRjONHof9zl2J+CNCsMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHQSzTqq; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHQSzTqq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0j8CTUcScBX4bQSJtVGOyVELET4GuGlOX/jy8kP3XT0mKKsBCTzPQ09SuhnkT8QIBrLNWxZTuH1p+WlqQWXWWxqkmX4739ntQ6ef1+uqDVZvZLGplz/kz5Jxwg1BD2UVWkTGqnzZpoyxYGODxJK7jjtsmPAi6y9/C112MBD/sbfPzXcG7xk6iiAn0k/NNkY2U5Wz6S3bg8pVipcGG/Gf50fNy5lWKXSn3tFrMS8fDPakPurf1oI7+b0i2fXZFEsrY6ZlUBeV85jLBvatq/JHZPzqkAAu+592tEABJxgT0Pps6RpT+wYuPlVhXnvufS73MmnXoJrz72t13qvFavG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tghcp//S8nLAgTm+5Qmii5W///yNZ2Zf2yesVHaWfqY=;
 b=APwFTWRA5dUzoXDJamAoOJO7kFVOYUCSWP2CxZCnQKUUW7JWkkOyb5aXPEXDobk31xPpQ8qXQnDON9hxX/Zqi3iXz3O9jhmI+lfYx0IQUT4zyx4cVwUH8Irtju5I5XFmkM9fJTr9OPYjfU0W46fwUtgFDxDpL6V8TcYFWbjBOpq0G63gWTTKUDWGE+WNrb2eSnBo4ZlRzQC5HEp4OAKX98nRiLcjQmUMGCc8xb2XaBmhPXAFC2CM0kB8utDSf9hz9d/w0xIHFywvlO7F0eeoJmhvx9Kay8R6R9O6WG9vp1rHnyAuT2hGuHlgpDI4bDRrFV2HIAUDzT6IPdx6jyjTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tghcp//S8nLAgTm+5Qmii5W///yNZ2Zf2yesVHaWfqY=;
 b=SHQSzTqqoJAKB76WMc2Fm/UXusuEu0shQ3BvLiJfNZ/C02/Wji6vhh+ubIH1nNrKtOmAmwy5SDBKe0Z2ZLwep/vhnwJjpW+vGfWdWLydBaXTqeUEt+XHnPY2+AaQe3KUTK8X+gGSWrz8iC3MCLXvp+o9ZDuO/OmorZvF4lUrrGI=
Received: from MN2PR15CA0053.namprd15.prod.outlook.com (2603:10b6:208:237::22)
 by CY5PR12MB6552.namprd12.prod.outlook.com (2603:10b6:930:40::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:21:19 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:237:cafe::a6) by MN2PR15CA0053.outlook.office365.com
 (2603:10b6:208:237::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:21:19 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 02:21:14 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Kalpana Shetty <kalpana.shetty@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/9] cpufreq/amd-pstate: BIOS min perf fixes and Dynamic EPP rework
Date: Mon, 27 Jul 2026 07:20:47 +0000
Message-ID: <20260727072056.1248-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CY5PR12MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: a27cd92d-1fd0-4ae1-10d1-08deebafa76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|10067099003|6133799003|5023799004|11063799006|56012099006|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	/0Sf/9Ky7TSNmBwkvZGIhlfboTYH7Ot1qr6noYp1EUSCIvQxXaAMgSswdIWgHrTpOAtaugZacHnhEoTfnVDw4AJBBmeGjrv4iSXWV75fc57UbPi8eS/WEprIk1jbHVBIFlF0+e8BoalxeJcacY/Xot+eL8IXL2ARCsXP8jZJjFxST6Bs3680FExR2Gi4VzlpcWg9gHaSPupyLi6x8ACSrGLdlC4uIhOS1EaEKPCOwRyAjTsjVefFCIWjeV+pBbQhRwSCaz3f+ra2VWf6rPwC1Q0IrD2yzt1fSVpiXW1zvBISiCwVSMf/U2lilAYlx0nK0cW9QmhtDlJUtRKQeGh/Er20EJkHeAhQjtA6QONno9Dgi2h3Gnl12bpcEoP6RhAf4XDB/LP2aeWB2zuCaa4Vnd044iIE8d/qhtXmUjoYzRdxjDQ3NBspeEFBV9OHyltniNMpwlZhV/9ZdiUW6uqYi1HRMrKnUQeBbUjrEORq15CmH+wXe7OjrWnx5Vi5TKagEvisfKIPNTrxZqjB3vaEZZr1jqO/TlJjAsRTKvQmuLt8QM37xX6ugnemf8IbTJos/2GZ4somHR7MSM1HzBfnEw/wqi9Mk7uixGr1+VDw9xB4Rm/5hSOnnjQ6V4E+BzYpMBPr0TLx9KggJkmgctITh2xk1ZWnPo23NxFDk79A61k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(6133799003)(5023799004)(11063799006)(56012099006)(3023799007)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wXBhqJ7HGJJs8CKQyAT8nE2YGFhG2Ze5QzXtCZcYQMYsnqldh+3yi9kIhxnW6LqerHkjohtjwBMV4FeudhLj3r6Rul8+jI2TrfOL34VAcmb8eh9sBCt5H8umnyGFcFB4TK62bpEEoMkN5xB/Dsh68AtuyiML4Qb5yGhmfJulL4QVlM+OENUhRWRRYpa2oayDSpPkKLGGysR819CQH6kv9gO+X7mBYeIJg4rcYvburBidHLHzUdzGz2SavvtuKnhds7MFt+kLdiha4l/1TPkYrC/YleYVS5c1hHgRMo+DWSw/y7Fwjv/Q2wPAaLLdSNlHGnJhcaDAivBdlvtxGfydNwHrAD95Y8hAZ0PH6PoxW81ZvRP5shfVXJuidSaO++y4AIMN040gIBAlbUIGfrffYWV+0amgkT+GBqa/xT19caNNgXeE1bHcz08A71Ho7WdN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:21:19.3710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27cd92d-1fd0-4ae1-10d1-08deebafa76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6552

This is a follow up of
https://lore.kernel.org/lkml/20260723201228.22584-1-kprateek.nayak@amd.com/
with comments from Mario and Sashiko addressed.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge

at commit 39c0cf62fc78 ("cpufreq/amd-pstate: handle missing policy in
dynamic EPP callbacks")

Everyone has been Cc'd on the cover letter. Respective maintainers have
been Cc'd on the relevant patches to reduce noise. Lists get the full
series.
---
changelog v2..v3:

o Ensure min_limit_perf is always <= max_limi_perf when adhering to
  bios_min_perf constraints. (Sashiko)

o Fix the units in debug message to KHz. (Sashiko)

o Added a policy check for dynamic mode toggle. (Sashiko)

o Reworded documentation based on suggestion. (Mario)

o Collected tags from Mario and fix typos highlighted. (Thanks a ton!)

Some Sashiko reviews haven't been addressed in this series:

Mixing of __free() and goto was considered safe as long as they are in
the same scope and programmers know what they are doing. (See
https://lore.kernel.org/all/20260327152052.GJ3738010@noisy.programming.kicks-ass.net/)
(The flagging was unrelated to changes in this series)

Kdump scenario for bios_floor_perf is ignored as (afaik) kdump kernels
are loaded temporarily for debug and dumping out data structures that
are preserved from last crash, and an inaccurate bios_min_perf during
this process should be acceptable.

System profile notifiers do not grab the policy sem to prevent a
deadlock with disable path. Disable path already grabs the read end and
a pending notifier must finish for it to be removed. Since the driver
disallows EPP modifications in dynamic mode, this is handled by the
driver without needing to grab the policy sem in notifier handler.

amd-pstate-ut is considered a developer test and is supposed to be run
in isolation without any parallel modifications to driver settings. As
such, any of those concerns have not been addressed here.
---
K Prateek Nayak (9):
  cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
  cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
  cpufreq/amd-pstate: Extract platform profile to EPP conversion into a
    helper
  cpufreq/amd-pstate: Add dynamic EPP as an
    "energy_performance_preference" mode
  cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp"
    sysfs
  Documentation/amd-pstate: Update dynamic_epp documentation with new
    behavior
  cpufreq/amd-pstate: Reduce the scope of exported symbols
  cpufreq/amd-pstate-ut: Add unit test for "dynamic" EPP mode
  cpufreq/amd-pstate-ut: Add unit test for CPPC Performance Priority

 Documentation/admin-guide/pm/amd-pstate.rst |  45 ++--
 drivers/cpufreq/amd-pstate-ut.c             | 131 ++++++++--
 drivers/cpufreq/amd-pstate.c                | 251 ++++++++++----------
 drivers/cpufreq/amd-pstate.h                |   9 +
 4 files changed, 262 insertions(+), 174 deletions(-)


base-commit: 39c0cf62fc7851a17782e7efe8dfb2948739c681
-- 
2.34.1


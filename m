Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8936F901;
	Thu, 23 Jul 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837578; cv=fail; b=ibqi9wKq/sye+VOy/zudU/WyhrGHPBBwK3hn437WXnkuQHcaKn0ylv9bz2KadqstIIl7qiupc/yvumL5EMjpS5n+g9C2x5T9p5citao42vZFvu/h8KvvkMvjTBZ8dLrNesDcaGcj/FurXs59fXrfqv0p9ZeWlRAQa30YTJtoY5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837578; c=relaxed/simple;
	bh=pLLWiij7A+dvNRooqpIkH7S47obaA2RqgUhj8NoTchw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nWakyVanN5ucDYEYKyytcOuAGpbQzAmfzKRZ64AnKg6LgtkdwmPS/R8kSkuUgNnqiYcSKLMOum5pOl1NmNJaWgLzvyube/ZWY3ZbRzijdnFpV6eGBTHOsy/q4MJRHcvHvLhYl/uLPDaRepnpyww32JWuTzp4aWIjFK/jcN4eKyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zYZTi3/H; arc=fail smtp.client-ip=52.101.85.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zYZTi3/H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0j1JX5TR7nRs+Czs0UPq9mjUdUHHR/9Rd48Gt0qOlBVj4mWrcgiPqprH9PA0rzAHl3StFrp7fBOr870TByhObmrgHmbz5crYYiXXFj9sZPAYxq3LPjwTB+YwxArKiamVkIy9OyS3/iBf8a+lOJP/t4zWZOk5NIyb8Lgg46qkQdlEUM9oiUUzdT6bsWxDPSgyDI7HvA56hB/OUMzqd7sp4EEoRU2pDr3xipJkv4XdiBvC1AjrN/sWiRdViyhmcsJ2Bw+RfBCVhbrWA4JS/tgSKvIuzB4pf4nvh2MS/D27zwRFrqdd7aJP0mgnTYZ+kEJA9zTCKZAzhn5ETj62OT6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15wN639FaWXFNTDtNERklKgSOdFTC9E849U9AP7sxj0=;
 b=HcxYXiY5cbRTiFI/ugBe7bP4r/NHPE0qoaHSWyBZdhQ2FMiS8CVzHrULwxBNdsGkxG2zfaohdVZTctWZZgyHL5My/FOe7g3dTYjq/uhf3THH22WhcXkA5u8zNGGSZxoBEW2UKV73DsPPiWcpFmLPTND7IBUg1ZAtOiMZvNyd2wyPN03CNBKLjNjNOtlPuZnG9f7zCY1dkiEBih1lpl7jWNpdXvybsqu6zbh/LkyeVYyg4q24BJXeigq+6JAAZzF6SSBYGndR/0tEPzOB8AvmG50q8N2gpDqRYsjH9gPYM0ryX7J/qN9Sx8Zypxqxm7eMXVo2540G2hVgdFS0FUqStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15wN639FaWXFNTDtNERklKgSOdFTC9E849U9AP7sxj0=;
 b=zYZTi3/H4DZ4DyzXMFcpnwVJfkcmn4rS13pjf6KoijGCHRzBzO71dEPfOiBxTQnnhtfgQuDnYPYOKiP/oL4XdCUEPENUTrGC4FqtiZVGTEI1FylfTJx2DwY6zBxFA16z8p5tGaV6tbHexLofchD9GjUtY+RokSbiRwlYHjl9CI8=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 20:12:53 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::92) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:12:53 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:12:47 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Kalpana Shetty <kalpana.shetty@amd.com>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/9] cpufreq/amd-pstate: BIOS min perf fixes and Dynamic EPP rework
Date: Thu, 23 Jul 2026 20:12:19 +0000
Message-ID: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: d05dce7d-c843-4522-1dad-08dee8f6c725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	JrNs8gmfeB7AyYphLZdg1pj3nDA8PVDQ3qCbuftXSxHytAcZ5s0kOgTFEj5vMjGP9fhQpeBJ2PH1mAeLCNm5k4RkoAZ6nuD0Gb3Bx2ectBBRekaYwI5SpgJnSfloc+xITK7MZhEVFxeaPlei0jhfQhB2UQNdt/rUJHQQIdzzQ/0CVkzNxsrp0PcF860PgS2duqS3MPbBsq8UZA/ERFjS06KDPpH5V13KQrSjWF5vLqXCAP7YPw6iLr1tcd6m9VqYAoCKEDzIZ6Zl/wqAGec+JRdEgVdAeGiUBeUnUmIviIYBQ5BfaHCU2ntkcC1ll/6QA8IzqbD4IF2SSsKkUvU0YrhIix+acGsHZf0A9Cu7KT+gsM93uuDXviAmZXyeabSgLb5HYZj/vU30mtimmUiVVYyswZ9VlI5CJpsJuifSOOz+snqyNXkjAnXoT0jpzmC9ACQs17T3VKHMXAf67wV3+Li5ptLK5I0qrcUzZoFilTUNNfWhZdMwXHVS1ug7whvAngbw6L+EPSZ5NfO2nTunsbYviz6ogAeK/U3QwhngxprQdgK2Ap9QxxtTO68Lhw3aVreFhB/GdC2h51J/TffqoZCI3g6DWxmSnLlGsODZt3uFxphcR0GIjBhxxjf4dMlO2KF7Yl1y/VvfQEgzICEk+G9pfPgz98W37nFySuTskU4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e2h7h71kM6yyT1xw9mhk9VPBYUd4vvMQ/xusW/7UPhOSByVh0EY0c2JJc201YAXT3j3DipvOXVWW0qZb5OyQd6lUnnGbwBBih/nzwKth/uk/oXQ354aR3hbIH8xQt43UQXQnGZX0r0wETkViZx5veEOeZDWznPW5TgrbTjODDXqYyJnbElVguyxRMUBNESdKeBYtb9pBUSNQQzlxgHAYIKlTM51rlNHdBLbBOjqAIgKQN/JiC2VClFKFdxluZhi5QZGbr0OSIce9RbIc1kwZwDhBs97jgiLFd07yD44vPtjQl2G9Ne3FfKGig77LEphG71eRX9Wy1ziXu+i2/hFFmkcmhDj0ITWpNF8RsNbWs1JSDIcpXkS+JPfNvC93PlH7yowB22qkJNDYwDXqwxCS4Qf0H59bV06SdnHB8XII6vHyAnI1oxVsHvIhEBKxXpbA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:12:53.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d05dce7d-c843-4522-1dad-08dee8f6c725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336

This is essentially a combined v2 of the following series:

  https://lore.kernel.org/lkml/20260715074822.16324-1-kprateek.nayak@amd.com/
  https://lore.kernel.org/lkml/20260630185904.5602-1-kprateek.nayak@amd.com/

The first two patches fix BIOS min perf setting and its persistence
across kexec. The next set of patches rework the Dynamic EPP feature
into an energy_performance_preference mode.

Unit tests are extended to cover the new dynamic_epp mode and also the
floor perf (CPPC Performance Priority) feature for completeness.

Patches are based on:

  git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git bleeding-edge

at commit 39c0cf62fc78 ("cpufreq/amd-pstate: handle missing policy in
dynamic EPP callbacks")

Everyone has been Cc'd on the cover letter. Respective maintainers have
been Cc'd on the relevant patches to reduce noise. Lists get the full
series.

---
Changelog rfc v1..v2:

o Simplified bios_min_perf handover during kexec by removing the
  defensive check (Mario).

o Removed the amd_dynamic_epp kernel cmdline and the dynamic_epp sysfs
  file as they are now redundant.

o Updated the documentation.

o Updated unit test to account for dynamic_epp removal.

o Added unit test for floor frequency. (Kalpana)

Individual patches have breief changelogs attached. Reviews and testing
is highly appreciated.
-- 
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

 Documentation/admin-guide/pm/amd-pstate.rst |  46 ++--
 drivers/cpufreq/amd-pstate-ut.c             | 128 +++++++++--
 drivers/cpufreq/amd-pstate.c                | 240 ++++++++++----------
 drivers/cpufreq/amd-pstate.h                |   9 +
 4 files changed, 253 insertions(+), 170 deletions(-)


base-commit: 39c0cf62fc7851a17782e7efe8dfb2948739c681
-- 
2.34.1


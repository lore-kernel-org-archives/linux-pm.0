Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010061.outbound.protection.outlook.com [52.101.61.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC712318EC5;
	Wed, 15 Jul 2026 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101731; cv=fail; b=F2XsxILlhrq4eaCS/caUucZpKLyI5pEHq4be/vQdHYPrnHTQd2C3jmRy1+6/wOyT8LcaDlmHbCmQEfUaJ/nN6U4aipRTnvEbdpTNL0DPiaRhE6JGYv0YtguyRCKPQlhUQkPAQLOWK1zOt3EpEdGLVzO7nI/YJ320/2vssyW5phc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101731; c=relaxed/simple;
	bh=YaB8Esv1zL/mA8w7ViRd+HJdKwylq6kAk+GgcKWe6ak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TgFDUYorV4KdDyF8bMJgYb4v+dfAdkdaSp9swT5HWR2i0ykIu2UPZf2d3OsdpjVvXHb92f9spUp6ZH7zm2EwFxAkFJGwexdIlC9QJdDNJ1+3vichQdrmq4XsolpB5IpA2PmEaALnY8CdUlzIj6sQ5GNLLtYt0zfHHgwS3tU4UqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yg8wiwuP; arc=fail smtp.client-ip=52.101.61.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yg8wiwuP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OChT3aWP9/GNV2Riawg3vzWuaakNUhYF18J5lWwN4b68et9stgpEzvwQqSvTmx4hlgNF/+7DIyI/0Qb9da7BbqL4xQz2evdOgAJVio/uC5vruhQjhVnx57BpOtUbiPPfM9wVoQil0T8umHza9Mqcqw5jw5xN2JhQjsFB9zVCDQN8xnt0GcKCzZytvOmEyXS+m7bvIvQx6KloaI3e4Ugt2xbH8/KAk+9sxl6m0RDDc1SpBAdgJbdsI9eQO/HVUTX71tsbzznBHlZNDos+06Jz9xm3YuIkOAQfjY7+ItB7qReZVqupnhkOQTqnMjOuYUPOr1UOvPm/LP3Cn/MMgvOtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAKDHOvabpJyksqHJFUF3uHRbWKQss4Kk2yauKro1zk=;
 b=UkqbgCnJW6YHkTX3OwVGw4HrIwr2kLDExVQpnRctmGxS60tVgHj2gZIQUpMToJVjvMmSphIjrIck62Hn9TO/B0HodOiVN5oG0G2hwWRp8WDB8o0UsLa5qmWBSk8xKr3nHFPLHc66gDFdk3aBZh9BsYgk3PMFzvMuHW8dYYFiAH0aPf5l4g8QNG4OiVvr5Nu95CHsUhrxu5Rsd8Nt0eUqb4eznadTP75M0kkYoPve4oMgjzlqn9Lu0sEEUXnpWiruhuC79lFjlJEmRrmvKhuefj1pv5IvmDyC6wp/BVgLkySu1XyVu6VIH49dAgzVhvAOdXL5SYL5syJ2r3mRszuwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAKDHOvabpJyksqHJFUF3uHRbWKQss4Kk2yauKro1zk=;
 b=Yg8wiwuPo9prTjmUIsrDNNs89N9oFPbTrOvJbrROlYvQSaBjWwXNY+DUjIxKFJRyVRdAAbhSnIt/aVBy2DMB8TDl09obRE6Mgg65bnGwjR+K2aKe4+IbB4iyHe/aOXqKZtkgh4PbDCcKRQAunUFk7FCCSyIevhJiSyVxxwoKxVE=
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 07:48:43 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:32b:cafe::67) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.20 via Frontend Transport; Wed,
 15 Jul 2026 07:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 07:48:43 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 02:48:39 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Huang Rui <ray.huang@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
CC: "Mario Limonciello (AMD)" <superm1@kernel.org>, Perry Yuan
	<perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/2] cpufreq/amd-pstate: Fixes for "Requested CPU Min frequency" support
Date: Wed, 15 Jul 2026 07:48:20 +0000
Message-ID: <20260715074822.16324-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 59edb508-3dea-4b91-237a-08dee2457e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|6133799003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CMzqiJXuKrcjdFs9UgGhkcSzFz9sZqJ3WFXdkmuIysh6KzG8BRlFjTKpr/khuO/h9IeahyP0HjQ68ohGWpvv11HizDhSGhCCrlHpd4+AX3dSgj4onqnns493QDsHZfNZNSgcYyss/PZAWUfQUz2yTbcC56cAtikk1PqFFXwMOQb9Y9sc3fCk1TQZmCGc7FkrmeJbN+xnI3mkImglm2nJhXyzeCZtVuP8wt6tp+14C1+8y8v71hz9G/lRSjU5exXreRrGhWFSouK2QcEwLlic/K9KpWeI+1Os1tW+01RTjeVsYwl4qUdb/v33eHHU7vde3l/apquZC45caP537a1rSKvuw6ZjmegqJ8iUnDguZ+biSgkGbtPRIUNKHKvOO4asifgN1QKpYSyjWQDeDq0lBssaPHc//B0TWVbO3/VTm8Uqz0gI7GyfUW927q2fSi/1Ar7vsRdDDTbeO52PXMH1b/ws//HkdCyxTrQ0degqWY6falOyHjn5Vh7IiXjR7Ah+aIVfGq2zoCJ/GJgScPtr4e9AN7wrfteq8vXI4lYOgHl61hTJPcCXeYxE6lrTTmbD9BIgYMR1LUsJLa/pfMz29HR3Nk2Jw7BjQRt4qjxoKAJ5gST6K3Xpyq9bB8r+Fo1bHFEpASbUDCsFMX0EJSgVlyqG+RQQklrDzRb5QHytxb+rIGMIkjNJ/a2S2l6RUIs4ciphtBvwldaEqNsTfyxgKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tljOL+uU8Q4i1JQvc2RsEdKW8OT26ap5FHC3aETKwXaCz/b4NL0T8Ks/de/WfH06AlWJX+1WBKRex82Ks7EpEUrf65Mqzn351zXVZUbwLbnH7x4iogf5A8bYzfun0wNydNf8Ajy9kawmFOvIdEgGdOPo8H/S41CLsEOMVkJcYK1P58XCkKIdfLGZ2havWqmYUubjB031jZrGto3XO7zKyZuItHyGJLIrOE749vCDzgN4ydzuIBJ4tQ2hgSuQv2QmsCb22e25xue8IKz6GUiu8L7BOO+mTR5QFFnFLUll+Yad1Tq3x276TGPOD9B593H35a5nT3W1iIgh2GXjatjf97sXrRnn0D9k3/OoteU9G0K60oExCvmO6jXpx5sXSPJfG54hPUFEIGKgGX7xSaqfa8NAJjJHM3X1WpGH7U75iOiQyUzlMxnU4riE9tQUQQSR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 07:48:43.4414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59edb508-3dea-4b91-237a-08dee2457e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204

It was noted during internal testing that amd-pstate active mode with
performance governor always sets the min_perf to nominal_perf despite
BIOS having supplied bios_min_perf as the preferred idling perf.

Users who set the "Requested CPU Min frequency" from BIOS are known to
have profiled their workload at different operating frequency to know
the best configuration and amd-pstate should use the same as the lower
limit when configured.

While testing the fix for above, it was noted that kexec fails to
persist bios_min_freq even when both, the old and new kernel are aware
of bios_min_perf.

The suspend, offlining paths switched to persisting the CPPC_REQ MSR
state at the time of suspend / offlining with only min_perf being reset
to bios_min_perf.

msr_init() path only accepts the configured min_perf as bios_min_perf
when it finds rest of the bits in CPPC_REQ MSR to be 0. This is
intentional to prevent stale value of last CPPC_REQ from kernels that
are not aware of bios_min_perf to be mistakenly interpreted as the
bios_min_perf during kexec boot.

Work around this limitation by stashing the state of CPPC_REQ during
suspend / offlining in cpudata and then only programming the
bios_min_perf into CPPC_REQ while keeping the rest of the bits as 0.

Resume / onlining callbacks use the stashed state to restore the
CPPC_REQ before the CPU resumes normal operation.

Patches are prepared on top of linux-pm:bleeding-edge at commit
0e4eef86f0f4d ("Merge branch 'thermal-intel' into bleeding-edge").

-- 
K Prateek Nayak (2):
  cpufreq/amd-pstate: Set min_limit_freq based on bios_min_perf
  cpufreq/amd-pstate: Correctly reset bios_min_perf during suspend and
    offlining

 drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 17 deletions(-)


base-commit: 0e4eef86f0f4df58cb7526fdb968bb779fe66d81
-- 
2.34.1


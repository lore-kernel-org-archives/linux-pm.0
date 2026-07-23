Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF54156FB;
	Thu, 23 Jul 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837627; cv=fail; b=K6R8CMbSLoFHsJI8Qg4MoPMsNvMGWjf3mjx3VxRGq2VNJWmwNRD0Eg4SpMd/a8SFFLzxtQ4wAo9n5WJ4F8IIlgdd2tPB6mLAG8pnTUh6UeoYKPrga4tpA4H+GBEzDWEtynA6et+QsZxDD6LVvLOSyqF2cmy+VICGz099+x54ytg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837627; c=relaxed/simple;
	bh=66YLEgxGHpip7rsI14hQ77agBsIoHS0cjuXcb+ntmi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e0wAxlgoOa537ViIisYqVLoBdeX05B5d1o9G71RG0YkYN+nmv8Xv5MreUcJbh6cV/oJCk9EDC6lL4Denh/xKBU4Tl5OUBzmjPmAx5MTCcXkNc+GE8Vy7rWgWfy4w1VvLsF1AZVsWbso+ZKtZWo9Jbc02yy/bXFS3RNKYc7Dwolg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0QS9WoZ3; arc=fail smtp.client-ip=40.93.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0QS9WoZ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=errX8cyySh91yno6raUUfBeHEsXK8M6Hpjv6za2Z8r5sxbgypiyLoE6a7jtei3ZbynHNw2RSqcTfgtJo7uFVCzeVfO289idJVspLiB+Yqn1rfAVpAXHl7T0Y9Odlq0JlIO5wxBelPnvH+UNEYFayTez8ZstMu0vpJDJb1HBGTfU+DyRoVL7XYpEtZgDCch0H8xeK2uuR4l7Hl/HMISwEmEb7Jxg3m97sshpvBIzhrEBXzbUOWzITdpH32u1q+9Ol8R5bJPOyGOcKSvbgekobBzy8tc3BW3o6IsAqlZ1RvOida79BwVsxoRwzEhRfIPjuoBDctym0BNBGGzoHPrl78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uhcNoC3hRkQKz8Cf9z1rv7mDWY2eXSh8zeri11qCQ3g=;
 b=oO0sYZl7CkpujSlLWj2gD5cj0XMp5f57ci2yGPHrdkXB+pMOafsvTRRVu56FWY+BGTSMIYr/dRjvxIT97efc4Xbem9+HOImJscyAADUkofEZHvSJ5vWDAUioJqZthJtprhv+/T+iKN4AAXIgYPDz3Ok7DsB5HRAFMoNjfFLrMElopjVb3gbKhNiCadJDFvt5xgJx9pjxyA6PRVVEfJwmIQeYZYag7ro77dgVRdZYSKSuzce987CC/+DgZ9nCyr010FKwrBJK7ZbQNdteiPurSketfYfF1yEDTKDY/0G67BWbKTD0sqIhpmCdEkFz7zDHOo75ZUCKAyp2O5Q84zX8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uhcNoC3hRkQKz8Cf9z1rv7mDWY2eXSh8zeri11qCQ3g=;
 b=0QS9WoZ3d1nwFc1p6kbuZu9/VfnuY5aCtQwL/eijL3xFEgkcOWLYV41WGumcqNl08GpusQXN5Ekv75jPaf1yIdiBLLo0+vVmtfJo3b3zVT16r5D8Xfle5MvUQVlrZuRoak7tZR9RafCR9a5fGGSu4upug49tmDnnt3tiNLl47zw=
Received: from SJ0PR03CA0072.namprd03.prod.outlook.com (2603:10b6:a03:331::17)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 23 Jul
 2026 20:13:28 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::47) by SJ0PR03CA0072.outlook.office365.com
 (2603:10b6:a03:331::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 20:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:13:28 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:13:24 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>
CC: Mario Limonciello <superm1@kernel.org>, Perry Yuan <perry.yuan@amd.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/9] cpufreq/amd-pstate: Remove the defensive check for bios_min_perf
Date: Thu, 23 Jul 2026 20:12:21 +0000
Message-ID: <20260723201228.22584-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723201228.22584-1-kprateek.nayak@amd.com>
References: <20260723201228.22584-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd8b94b-8692-4980-f7f6-08dee8f6dc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZaerSLYWdY+G2KrPRycRAM/Z9/yKCJDKuX0bbJIxluVh27F48FcWaGMKSMqgITZqAW1PSpgRg4CZiRJZWpSSym9C6k1DzsxJ/dYiIzmqIB9JGnkpfLcLrFZiId3OuA0OOZ8wtVsL6e6llOGjKVJHfOn+ATDEwsJ6YCIeWkPT3eht2Rl1ymeY+VcvtSU5dGKycGMIQi9rXT4MfDdh334QY8orHm+N7AnJamIvvvtgfe1zwYRADgjvQt6DIWY4XD+/1mLUKv6CEZBTB9pxS4yFMRdtHtNW+R/V7wF+hFb17cYrjqDPHrN9D7j0ouqqPu9MQBkJFI9k86JjsLzLrv9QuNVXsVDYAIQZ6KPH0m4/qt3Pw0TRScQi2LkNyf88kt7Hbn6eCHAfEzHrlDocW61Mi/EckWUD8THYz+GIhWczZVe5UtvOkd4SYdBetadjU/nWM0ojYbAB/MEXxaON/ebWxfD1w1N2WCvYHBG1XbDCXEq37vRFGcTULZUN15WTzKgVuuWRnuugH5VI8fJp9v9eoZiDv2kX4sGeKYp9kTffIiol7np+Ks8AbzlE3dJsAbH2Tt06mAf4uGPxsX4c1f5zk1uDJq0qLNGx8G5+VQWus5QpFl+qdg6RF8xnzbGFy2rAU3tu7PmX6INXmD/o4COz8IPqifOC9zrIYxBKIPAPZKz1BPa8YvHndasIX+fneu9EjibFaT5a6VCqxcjghHTYfg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ilLBAHysXI24YoSkElYxnGESBaG5yDpguczGYcWSIAsn7FUJmsTSIxMKAkrZEnRy0RgfT8QMsPuAHoLFfP6eUxfPno6G90egblMdqlnz9i0o91m0nkDGLC8rDgnoBb0QEG4BsnnLKhEwUVvkGeMVqK/2cZM657+g9HhV7nZZz/m6WVdTwTAGXCvK1LLcXF6rPA0aARSxf1ky9qpx8BrYztN3amPrySp+r2cHPTBMyizjLI6PFu4l7CYgXR21IxcHdlIzc2b2gxlZKAOT2I9HWXx6zT0Sc1kw9vH9RFHnmyrgvNdnb7GgdCpBgTDTIXyt+8wIP19wVqnl2NwYdZNWAiy0zDCiHibvK8IZw7giV/0GF4HbSPRb6lcnxI18pPScJj32t+U/kZXpqiOkYcHUK1zb7qpK8FqKtuCusKKD4RvWAnRoKVED5pVPwnv73Evo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:13:28.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd8b94b-8692-4980-f7f6-08dee8f6dc3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445

Initialization of bios_min_perf (BIOS Requested CPU Min Freq.) only
succeeds when the driver init finds the CPPC_REQ MSRs to have all 0s
except for MIN_PERF bits.

A kexec puts the driver through the suspend path which, although resets
the min_perf back to bios_min_perf, keeps the rest of the CPPR_REQ
intact with the last value at the time of suspend.

The defensive check for bios_min_perf exists to prevent the min perf
from last CPPC_REQ being incorrectly considered as bios_min_perf when
a kexec switches from an older kernel running the version of driver
which is not aware of bios_min_perf to a newer one.

This scenario is extremely unlikely and Mario suggested it is better to
simplify the initialization rather than complicating the suspend resume
paths.

Drop the defensive check for bios_min_perf initialization and add a
debug message to dump the BIOS Requested Min Freq. to console leaving
enough breadcrumbs for debug if a situation so arises.

Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v1..v2:

o Reworked based on review comments from Mario.
---
 drivers/cpufreq/amd-pstate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1157f05df10f..02308e95636e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -462,7 +462,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 {
 	union perf_cached perf = READ_ONCE(cpudata->perf);
 	u64 cap1, numerator, cppc_req;
-	u8 min_perf;
 
 	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
 				     &cap1);
@@ -478,16 +477,6 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 		return ret;
 
 	WRITE_ONCE(cpudata->cppc_req_cached, cppc_req);
-	min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
-
-	/*
-	 * Clear out the min_perf part to check if the rest of the MSR is 0, if yes, this is an
-	 * indication that the min_perf value is the one specified through the BIOS option
-	 */
-	cppc_req &= ~(AMD_CPPC_MIN_PERF_MASK);
-
-	if (!cppc_req)
-		perf.bios_min_perf = min_perf;
 
 	perf.highest_perf = numerator;
 	perf.max_limit_perf = numerator;
@@ -495,6 +484,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	perf.nominal_perf = FIELD_GET(AMD_CPPC_NOMINAL_PERF_MASK, cap1);
 	perf.lowest_nonlinear_perf = FIELD_GET(AMD_CPPC_LOWNONLIN_PERF_MASK, cap1);
 	perf.lowest_perf = FIELD_GET(AMD_CPPC_LOWEST_PERF_MASK, cap1);
+	perf.bios_min_perf = FIELD_GET(AMD_CPPC_MIN_PERF_MASK, cppc_req);
 	WRITE_ONCE(cpudata->perf, perf);
 	WRITE_ONCE(cpudata->prefcore_ranking, FIELD_GET(AMD_CPPC_HIGHEST_PERF_MASK, cap1));
 	WRITE_ONCE(cpudata->floor_perf_cnt, FIELD_GET(AMD_CPPC_FLOOR_PERF_CNT_MASK, cap1));
@@ -1043,6 +1033,13 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 		return -EINVAL;
 	}
 
+	if (perf.bios_min_perf) {
+		u32 bios_min_freq = perf_to_freq(perf, cpudata->nominal_freq, perf.bios_min_perf);
+
+		pr_debug("Found Requested CPU Min Frequency of %uMHz on CPU%d\n",
+			 bios_min_freq, cpudata->cpu);
+	}
+
 	return 0;
 }
 
-- 
2.34.1


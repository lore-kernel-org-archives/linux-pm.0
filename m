Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1FA502D49;
	Mon, 21 Sep 2026 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790017373; cv=fail; b=g3YNzCQdY8NsO0yO13Ae/WzvyABynJdGCnKCerV1v+csYqM1NtPB8h5Yd32kAIKgjwdj9FdD7VRGiDlloXmx83a0HmXiqNE50RqY4oyiNjkX59XoKcwqiMvPH46JPRBABgDzsqf2H3F2c6BKJPWdOkTorq4w26El/kLp3F1DHw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790017373; c=relaxed/simple;
	bh=L8dbjBtlUjI3io+S3KjUZzmiQcvK4dpWEZC0Rcw9w7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZeT4lpBB29ObE3dzD9qMPu/eaXbU4y++k6y3uGpiskXS6snmPU5I7TNxTCS6UVEAQr3QANnBuNZKUl8SmZG2rasZnjYIX5FdhOcGzY0nDYZuJDmP7OnpWZAW/TLDyCXLFGN9j1CVcCQOGlnui0nzN83rUsPaLsqfEpm/JHnsms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MLrmZ2YR; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MLrmZ2YR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIB743XyJ6PHA6rOmKVb/0/txLlQabEDIEx0M++smRm6ccXpCH7Yv+1awa45FPKsmexyw3uACZNuPn09x2+VjzbF03nKQoTDPKrIc0JHsyPFvOVvMG1eWaZMALW8bLQMMc2zhw9aeAO4SpXc9gW/heL7+D+KFuEntIZMDpwuHyOjFd4EM2gJXIgm2l1nOEIV0yvF4eLfivQrsybMO+AI/qZVRlpFyEMyynOKgkTA6S53SVyWY/of249zc5l8QbAjV77ajGVUQ0hmuB0gqGAra2Ojag9lrN3ul3fBL7OpZxHxUV4iqkI2t27XqiK+2PY+nAAASre2jIfK9dF4750cFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qOYedFSUw4DCEJQgNelQoeYDKnk/ZyeM/TtESFYrDs=;
 b=QFZCna+gbR6hrQiYzDKrLHJORxLoMfCSssze0tnvqJznzPnhFIKArV5kwBxmNnLmpILZZE424GwlJEBJrIvt3i1njZRi1HjuajQIQHv0xE0q8kSIJQhx3hXSLVNXtWN7KQ026xwifJS0nUQ/+YcMHX2ROC9m9zwJVkMfYV4Ls9wEIvDuTeWyan/4oktZN7ucNJBpxD3GdZnYFUbDZfSR3qyKW9mWb+b5sWzyfzAkUl0dCTHBNgNheYN5vR0n/EfJX3oVFCjzwBl0a7MNydlcLWpgwHm9r/7oY+7Cum9clA2URmSVOIUMxsoasSY0HXthJgvRr7IVi2LPPrCVjLgkiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qOYedFSUw4DCEJQgNelQoeYDKnk/ZyeM/TtESFYrDs=;
 b=MLrmZ2YRfsQvoume9UUDmqDfsIqXxdNgixuunXHuxtKn3gEwB0mVPvccTui9jVP14OHzWpyl80OOHPegDVL2xDyc+ImbtD7D+SW8mgvku1fmfhjHjSiLyyCcS7FxwtGjm6044BygePh/EvQcZPijJwdyEROr9IpFeP7QQ2ovEtM=
Received: from BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 19:02:47 +0000
Received: from BN1PEPF00018546.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::93) by BL1PR13CA0359.outlook.office365.com
 (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Mon, 21
 Sep 2026 19:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018546.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 19:02:46 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 14:02:43 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH 4/4] cpufreq: amd-pstate-ut: Don't require max_freq >= nominal_freq
Date: Mon, 21 Sep 2026 14:02:35 -0500
Message-ID: <20260921190235.3651688-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921190235.3651688-1-mario.limonciello@amd.com>
References: <20260921190235.3651688-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018546:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 000fd90e-b0fb-4f58-2034-08df1812ec69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|10067099003|18002099003|18092099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Jcs5EtLAyfSKjO8erGl7OSDW76o/2exVQnbn3tFwyiCxaA3X1Egb6zhqdBrHzo28JvAriV1pS7TDtniKUrQJVP5174s1j5hMOAeS4IDftI2gM9iLbt40XNR/MMUO1Obl5sMBPe0Aq9RutmTKgB8xp8vRo/sDdpD0yAnPUGux/hULuFXvx84vSGGj/huS4e3q37Vb4G9AQGEUhcc+j02I1AjoZ+eMA22Gnvr/Y3qMwlkAUZ7TjHm+emdKaDtc4XxS836bSFiqN1Rp5cjqp017/zfJooIzdEFB4Aw5ThX6F8/P4q+bKwtYs+aZvEEsF4XToSAdmEqviWD2oEcJ58TlXHKmBCyXUgrlhamHK8VcBKXHvkhCCU02oOFf9d0OWLEf0XMAhQQVfqdpI/dS+ekbVCfU4ooJ6+RoaLeKXdamN5mK55vOGhVJiDDvOsItxUpXjxi26d5Jci9Fg47CgXP6mjJGBcNjkNEFQfrHI4kOgysOkxhvjmdu4hq6BK81KVmW7QJ4RrUu2EtNko56/texnxnl4GYw/XrQ9DIs75bNkjMVRAe2jssTjc5vExo53xMLTrwd21+8DWGrHw1ushVjFeIyapfb9EJCLfU0QK3SAO/1L0H/L/ccN1OHf5b1CNS1vsCqrUe6Z31Cq2tOQcWU5H+rrJ2kBfbQ7n2QSCNVDqknBwXEoYtpoPtTtpEBheyHjimQEBlqlIKH8yuYhzvjBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(18092099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bnhgXKbMqF2eLc9VHmt0bQRrwanapIlPt8RCykOuX4YO/MoMpNMH5Mos7octRJgfKFOikIUe94ipcZHhG5oCCiSqd9iq0YFL4nqFHAYO2xumSG9XZ6phJeFu7QeVtBTWnyZ8XLNV2AwHR6WiCzWd7/ig7TrN8sSDxAB0oM3zKnYa3ngsKA2jUiQ380yd27OijP4O9FntBiqlZ0jsYxlzjE1bRmAKl5JQiY85A16H6pSm0f4tZhPD6VrZE84In88jMqsoRr1y+YR9vxz2DzZ93f6OljurG7ATcfKTAMH1Ajp9rcK0AgvQlT7Brl2dSD1KriJKfoX15Hu7GvGXdYAL3YIvBWl3wM2fVkjwmyla8xxlxxvLDfFd9qN9L1eX+Vt+/cvLLlKVAGNp1qNmVQkyyKoLaPGdVPpgnX5B5CQia26ZHQjypIZzbufZpzkeF3qf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 19:02:46.4265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000fd90e-b0fb-4f58-2034-08df1812ec69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018546.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

amd_pstate_ut_check_freq() asserts the ordering

  max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0

but max_freq >= nominal_freq does not hold on all parts.  On
heterogeneous Zen6 client, amd_get_max_frequency() returns a hardcoded
per-CPU-type maximum frequency, and the low-power cores cap below the
shared nominal reference frequency.  On a 20-core Zen6 sample the four
low-power cores report a maximum of 2399 MHz against a nominal of
2400 MHz, so the test fails:

```
  amd_pstate_ut: amd_pstate_ut_check_freq cpu8 max=2399000 >= nominal=2400000 ... the formula is incorrect!
  amd_pstate_ut: 4    amd_pstate_ut_check_freq      fail: -22!
```

The maximum frequency is a boost ceiling and its relationship to the
nominal reference is platform dependent, so only require it to sit above
the lowest nonlinear frequency, which holds on every core.  The rest of
the ordering (nominal_freq > lowest_nonlinear_freq >= min_freq > 0) is
kept unchanged.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f5888beb767a8..e4e85514d0b67 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -216,7 +216,14 @@ static int amd_pstate_ut_check_perf(u32 index)
 
 /*
  * Check if frequency values are reasonable.
- * max_freq >= nominal_freq > lowest_nonlinear_freq > min_freq > 0
+ * nominal_freq > lowest_nonlinear_freq >= min_freq > 0
+ * max_freq >= lowest_nonlinear_freq
+ *
+ * On most parts the boost frequency is the highest, i.e.
+ * max_freq >= nominal_freq. On heterogeneous designs (e.g. Zen6) a
+ * low-power core can have a maximum frequency below the shared nominal
+ * reference frequency, so only require the boost frequency to sit above
+ * the lowest nonlinear frequency here.
  * check max freq when set support boost mode.
  */
 static int amd_pstate_ut_check_freq(u32 index)
@@ -235,11 +242,11 @@ static int amd_pstate_ut_check_freq(u32 index)
 		cpudata = policy->driver_data;
 		perf = READ_ONCE(cpudata->perf);
 
-		if (!((policy->cpuinfo.max_freq >= cpudata->nominal_freq) &&
+		if (!((policy->cpuinfo.max_freq >= cpudata->lowest_nonlinear_freq) &&
 			(cpudata->nominal_freq > cpudata->lowest_nonlinear_freq) &&
 			(cpudata->lowest_nonlinear_freq >= policy->cpuinfo.min_freq) &&
 			(policy->cpuinfo.min_freq > 0))) {
-			pr_err("%s cpu%d max=%d >= nominal=%d > lowest_nonlinear=%d > min=%d > 0, the formula is incorrect!\n",
+			pr_err("%s cpu%d max=%d, nominal=%d, lowest_nonlinear=%d, min=%d, the formula is incorrect!\n",
 				__func__, cpu, policy->cpuinfo.max_freq, cpudata->nominal_freq,
 				cpudata->lowest_nonlinear_freq, policy->cpuinfo.min_freq);
 			return -EINVAL;
-- 
2.43.0


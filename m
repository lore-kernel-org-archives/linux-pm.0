Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A297381AF1;
	Tue, 22 Sep 2026 02:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043844; cv=fail; b=FZL9b4gT7Hcn9OU/jZyNAzuJMzb1wihGw95wclJcbxs2oR5u5XLl20ZCPAOdZ2RDjTwH2yavBf2eTRH81RzApAMVY/0T49fgRA74t7iLFKrMNWOOIzGj4lflgtk+/DnJzdEwjZtuu5D+EP738U8zE3HanjSC4vKg5jegthzLesA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043844; c=relaxed/simple;
	bh=0po82FTA1ZJGiuyZvbv147QUgA7yT8VR4yhkygGbXJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cqyFa54al3JvF1TXIt+yY8mEtkA3+ABUa3Fo52JxDWCP2BZ3weJI0TYp06AA0tpuHp4n+9LAUMOa+2njppBbu1iWbAPNsSOFutvYbZIzoiBWVHBwLrrbt7c4aPjCGPDjGcbG3Po+5O65HbqWyrdv3HWkH98UfsFzR3d0+HcSwgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g0dn+OHn; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g0dn+OHn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPVJmnEVsS/Gapz/4aSPnyy9JHFinolYfkfm01CFtujmt7ZdBvOt16uM+WB5+ojQNAS9PRQkj3fu2TlV+tcDgM4x6dzLsOhe1MbHnddCZ3AU6hQkKYBSFnJoYJ78tEFUnHKgY6J6Uimm2ZyJnyuJeUN9yWkJ+BXewYXif2MeqiSvRtWOtNWujSTyDA4Z8/wYZKX80D5Ug4kM1TmkFjqlYMclDmSDTk3R78NaQtIIepPUcMp20iOMSQh5ttiDle0zcoRFUDcdRuMMqHTbqbyIs1dxrTz440TdnFRPtDvJ62tP1ZYYEjwpZC0VYSRAv5G9lxiDLjUnOmQBAMfexoMqxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb/NaOOhmS2DqoD8Bfse5Ce0q75qXgj8JZDxWElsP+4=;
 b=rwdHm1FQN1peE1VY/7GMvWOBV2sew8X8//BHBQKHEHteu9fDuPA1ECFU509KK1vClj7ihBwaaIvDsV6EQ6UDCujf/DRLfwALjwPCjVeams6ZxG4+IR8K8PKJksF2mrRMl/leGdWDjAhdQaoC++uEUES9qrjFPdvfCS5fSRnaCJKLuTcDWOBNnl/hePdAu//+Hrx2t16b/3uxTv5wCtkkgD1I5C7TJmxZOFNjU3x2/Nn/8Gz0bWynwChNwTS2T3mRBSJON6CzZ7zxFrfqbM44iJiKHdAo298MV4x9Bt6YdUm22ptUksJ5EDTraF4kM2+xAhfWJCoZAUsCYtTSy2GO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb/NaOOhmS2DqoD8Bfse5Ce0q75qXgj8JZDxWElsP+4=;
 b=g0dn+OHn34ifaEdIt2jiRTRRwhm9aYq11AnoGvCzfQxs0NbYzQq3HUi932OnqzFxEORajNUS8HC+56Zxpbu6YE0Ymqu5bSIMDAwWwRWylbLcKnAOr/SSAzXdyoMQC06vS8zYop/qCvq2E2umGoQ652RmV41POiXI1Jg7T+BraUo=
Received: from BL1PR13CA0334.namprd13.prod.outlook.com (2603:10b6:208:2c6::9)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:23:57 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::7b) by BL1PR13CA0334.outlook.office365.com
 (2603:10b6:208:2c6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Tue, 22
 Sep 2026 02:23:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 22 Sep 2026 02:23:57 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 21:23:56 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Prateek Nayak <KPrateek.Nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] cpufreq/amd-pstate: Fix TOCTOU when changing driver mode via sysfs
Date: Mon, 21 Sep 2026 21:23:47 -0500
Message-ID: <20260922022347.1270746-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 35969579-e9d7-40c9-e6ad-08df18508e20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|13003099007|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1oEyMa/LCKFEt6zX7gWzSWxdXC5Han4S4RcCdMwMQ5tcj07ZIoPcBBPQETa1Ec8Bv4GCxuy7Z/xGoLUFgJurPIScNB5NvKlORsV9ofCShe6xJtVtkD81uEV38UpsQ+nZgK5kv60/0itXueudYnZ5G8GMdyQzIXLnooyLap63LXDyYF3Ufm2uuMf5lOmBRELgkgVsmJMclwCN8WlO5/O0NKIyhGHhtneys6MaPR6Nrxki+GNWTLqif4lC8vZFtAMbOtgS3iSaybWDUDKQwaELDhBKuaU5cME+Ve3/boP/HradAzHe1MsxfzgDjlAxAxyXXahaSSC15rpFqdqPPzSB+D6lz+wFn+ujIImuHX5vrEiA5E2NIEQ7X91WxcP4sHOPcOP5llgI7BtuipTjIdvF9q2NFOKryHjFkZkDiAB+27G4ss6I8+evqY5s5Oo4Uu2BciV7+RHSVqeh5vkNxBf6ZKhf8TGozuq1+qOzcUddHdo7bLpsiMeuUAhucLQsMcqDhgU/preotkhSuWFZN05nPuj83KbSclhUDuU9XKkJvPQeSPE9/H+EZ0ON2of4maUhW7Fris558hGsviuNcAMHznnFbEi8ACEDa5TY8fSjh6EpzzppTeW5ckWJK6k68YSZrxwWFpMaEXV7RPl/79ddnQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(13003099007)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wwx8rFqv9Jd07FZOfKv8KcXxncxe9RMfi4Ek9isPPgXgoiIysLIoEHr84jiM51N6B2f0HQvqZ9cDtQIBp004JJn4bQieZUKy1TpXa/8k00vvt1NTzfiBr3hb9UPnMoqfNI2Ru41gto3+2BrS6PZAldNacnv/GyHfT3GXWqpPz8BKreBTZPvAWJ6bi+MzTqSvdD1/I8trBD0dTom9TlOgHtu7MItoiehyfXRpYk33kSFwlnRuuLsxytjOowmiAOoWFi4pIyk2/Gtv9Nfm0qGhTLxbtraLBTN/yf+jjFsb1QErs/hIX8Nsw9lVYFu7b4cqDb2UP+95yTE0zLbU3qZthQFnA057ru6tC9l1BTzM1hPBgQr7aI8qx1KI6rg1LCcUWC1FkUnuvWjmpani4hpHlhHm01rzgd5Lg4v4pdWvFbMY3sd2IRekfwJi3/yDe5QT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:23:57.0446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35969579-e9d7-40c9-e6ad-08df18508e20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

amd_pstate_update_status() evaluates mode_state_machine[cppc_state]
[mode_idx] before taking amd_pstate_driver_lock, and then re-evaluates it
again once the lock is held.  cppc_state is global and only stable under
the lock, so concurrent sysfs writes race:

  CPU 0                               CPU 1
  -----                               -----
  // cppc_state == A, mode == B
  if (mode_state_machine[A][B])       // sees non-NULL
                                      if (mode_state_machine[A][B])
                                        guard(&amd_pstate_driver_lock);
                                        mode_state_machine[A][B](B);
                                          cppc_state = B;
    guard(&amd_pstate_driver_lock);
    // cppc_state is now B
    mode_state_machine[B][B](B);      // NULL -> NULL deref

The re-read under the lock can resolve to a self-transition (NULL
pointer, immediate NULL deref) or to an unexpected transition that
redundantly runs amd_pstate_driver_cleanup(), double-freeing
current_pstate_driver->attr.

Take the lock first, then read cppc_state and resolve the transition
function exactly once into a local before calling it, so the check and
the call observe the same state.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-f86ff3a6-55df-4eef-8e4d-62ac270dba25
Fixes: 6f0b13f16f7a ("cpufreq/amd-pstate: Overhaul locking")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7a2174b5911e4..698b889a08d07 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1901,6 +1901,7 @@ EXPORT_SYMBOL_FOR_PSTATE_UT(amd_pstate_get_status);
 
 int amd_pstate_update_status(const char *buf, size_t size)
 {
+	cppc_mode_transition_fn fn;
 	int mode_idx;
 
 	if (size > strlen("passive") || size < strlen("active"))
@@ -1910,10 +1911,12 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0)
 		return mode_idx;
 
-	if (mode_state_machine[cppc_state][mode_idx]) {
-		guard(mutex)(&amd_pstate_driver_lock);
-		return mode_state_machine[cppc_state][mode_idx](mode_idx);
-	}
+	guard(mutex)(&amd_pstate_driver_lock);
+
+	/* Resolve the transition under the lock; cppc_state is only stable while held. */
+	fn = mode_state_machine[cppc_state][mode_idx];
+	if (fn)
+		return fn(mode_idx);
 
 	return 0;
 }
-- 
2.55.0


Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754B2303C97;
	Fri,  8 May 2026 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217492; cv=fail; b=XozKNLHAUgqexxb80woBqQflkmrWhy7Rv40YBR5wmLAC/eF2Vx91QRMeFMUvNsT8lM5OqdKHzbQzkBFF1Sv5lb6chFXDFhXJnytaX66vSyYWOPHods/Em8G1XPA0HifPk6EZNO5Bh7thXR64DWand+uCHeEVQaNjo58pShrzKmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217492; c=relaxed/simple;
	bh=XD2wxjjYjsfTs539vLnASLUFwDVyc7bBGrKECLXxRyA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAZRN2DBpyyLwH0bXB7SOa1uF++nUEfCHKPh5tDGt7L43Aa2ZvGCtaq4AEJMqthT/AwPgl/JtssQPlBA/xQBdHPVWz267ADmxAOyPTKWS2kwyqkHA7MqyW+0mqSkJU4KyXTFFZnvM8uppHTMpTEF2NeIcsriU1ZPNxN4JcwaKig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frd8Wqe1; arc=fail smtp.client-ip=52.101.48.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frd8Wqe1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sH9WoFk62upmdqMMYqSmwFw1A6Xt4ThfGHQ2czjorV6i6ulI3YehhwBYSt04oH/trYcvlA/8FltWdFHNPhMUbW2gG7J1eBuvdv7TIwFkRuU5TcfoZMQb0vhYY2GaP5tEnOeyWu65pPebNy4Hz2tjTEeFNzGFsGSoE5EFysotNEToKG69/xGt+lEilPc6G6xdacBizwwzGylssbFIEXmqcUKXWIC7mMWEt9PLisnAeRhcoq6bDdRg5tpBsUaVJB9n1Jj83sam/Tg0NM4YzV07NxlkY88rDCSF3bkavXdrIDjzxoet7RaFDF6YOoga+f6BVWdzlmE0y44ACZaaYviifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=th1iDWJdd6f98rhVaRPhY4jsDfhw7N3KeVnnA6F4zQQ=;
 b=Ft+EbL+/ZzBAZWrflJoybI1q/pWR0IS+J+H2vFNHxDVRxTOTXZdVQEZwj/UppMgWa9QfIdEAixQXtPzjtKhCHeQviA3lEA19YZBe//jql+JayZ31txi4i9VMXBb9D7PlOFV5s8Zt7VaxaesxPjK2u4cUUQdz2HqxIVAXuzeleWHa4RpCP7XtSZR7jPwsH6nMpY+pGU+KolvvobToVqA3PQQpX6veOhxkjErMQ28WQg3NppXk0ACcvqVe5JOsmArIf7mmrpWp7yJSwdhuxg0HWdM65ZkyRCWeLA2OITdWJ44XpdnA8xibdPNwEk/+mqrJwQiA/kUbQR9fCpRgd6AvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=th1iDWJdd6f98rhVaRPhY4jsDfhw7N3KeVnnA6F4zQQ=;
 b=frd8Wqe18699o1cdNlWy9NCqyMCzp7ik1HDyM356ueI7u0EmqjLlZWfUf4dtFYXp+yGurTZgGkVPuOAnZAOwLgInz1QhrgKdT8C+84JiEeFj4G9GBIjMNLHW8mKdA1X2ZK5bb7d8k0mdogsF4auTtrOj3/VmZ+rqJbJ4tFM/xjg=
Received: from BL1PR13CA0094.namprd13.prod.outlook.com (2603:10b6:208:2b9::9)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Fri, 8 May
 2026 05:18:07 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::ed) by BL1PR13CA0094.outlook.office365.com
 (2603:10b6:208:2b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Fri, 8
 May 2026 05:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 05:18:07 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 00:18:04 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Perry Yuan <perry.yuan@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Kalpana Shetty <kalpana.shetty@amd.com>
Subject: [PATCH 0/6] cpufreq/amd-pstate: Dynamic EPP fixes
Date: Fri, 8 May 2026 05:17:42 +0000
Message-ID: <20260508051748.10484-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e585b4-eb10-474b-166b-08deacc13090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HMIygKH38uEoiIj8RRa+SxzTYEYQsvv22O6/MOuYiAbwH8LNvg6St82mP9vcQ9wxachMabofbo2zhdWgjZdwoOzTnl9M8PfcNslR9H0TDYtUr8wDkUavmbCXM4j3k11Pq5uiDzZV1bvyp93UFayThdUh3Lqjo83YDF+HMUDUQJ+hYgUXd3wHjgahYlp6WJFZ8eC1XcU7QyPr/hXmJ8kjVCNYeRCKW+yF0kcOCPGdxCpucKvKisNPHeIr5Zvm7jFTKrvoJOqj7Fy0KOOc930V4CFLUT8/JlCvuIA+q7b/hEXzdpVDwWmMSgmpLPSBB6Tv96Ta8Np5/XMArXb5a2WkDMg0QnZJs6EIROkhgB+sCqgmuXihnLx2c2ABYddm6Bch8TulKc7gQ3teLSIWnzksCosfsyiGRm5vKPVBh3aStnhM1xGb7y/w/QpR3DcTsn0ODFYRNbEqo1n346I+SsjM3wJHrMjWwHUnukMhZWjQd6ZWF1lAmRPg2eKiBX3duxvK4OEgf0+gjsDnPTfF5X2r97kRpBHxwjTrVZ9n2Wj5FnkTB43MWyXGxaglbt0wY7LnaqCDAPB7e2tBlIXQs7ndctAvurOZWvsMtpSx7/1qLJ4CIEm4z1CeeCcglfEbocoyNUmoMR5L7TFhgoFLuH93NzHN78s6gIglshNHmW5n1VKpfDNwZ8kJOGch33asXN2uM0oG3DsuGQCBa4KWigOZzGExmd1kWk2jtv9ojIT1BnQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gunmUuiQ4Gpwcs1IF8r2yRSdInEhbtIVDzCmi4Br6Vlkinl7J3hkb9On/Fon9ofd0iviHJgkpV1xuZLyDPDv8Kxtn5ogas/IIGlzYP26wyStJ1k2z0yyx0mtmAZ/+vvws6cYFIUY7gvx6aADXdfjzfaWasLdBTmYCQXlSaklgDl1sbPi42QO0o/ir0deJQ7YPPQ1i6aMhoqxt6hQuGT57uobyuo0O7EZ4AINl+x20R7Ewkea21loN/uNimN7V7VP1I7vN9wmw9aFVT8pHF2lSntHjKWgTUpMj89DaFBfGb+zuD1WntUbmADNQMrx2HcuhGEXorpK6prYHE+cqFa1bjVQKAG8ZwdzcmzXYehlvaErS0dUJ9UPtn6PKVcWZF1c7Teqimh6VtYeSDEHkmoTGVV8u6xCRM76UlADTUVX0MpEEUAw4ZH3EFTW2UZ+d8Ms
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 05:18:07.6157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e585b4-eb10-474b-166b-08deacc13090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

Few rare race conditions were found when testing the Dynamic EPP feature
on EPYC platforms:

o Toggling dynamic EPP is essentially a driver switch into the same mode
  and can race with an admin-initiated driver switch which can cause the
  system to hang.

o If a profile change / power supply status change races with the driver
  unloading, it can overwrite the Floor Perf restored in the CPPC_REQ
  register that was meant to be left untouched until the next driver
  load.

o When dynamic mode is disabled, the default EPP hint is set based on
  the power supply mode at the time of driver load which can cause the
  battery to drain faster when starting off from AC supply and then
  switching to battery.

When fixing and testing the above, a couple of incorrect error codes
were noted which is also fixed in the series along with the unit test.

Series is based on mainline at v7.1-rc2 release tag. Thanks to Mario for
initial review. Feedback is greatly appreciated.
---
K Prateek Nayak (6):
  cpufreq/amd-pstate: Grab "amd_pstate_driver_lock" when toggling
    dynamic_epp
  cpufreq/amd-pstate: Return -ENOMEM on failure to allocate profile_name
  cpufreq/amd-pstate: Allow writes to dynamic_epp when state isn't
    modified
  cpufreq/amd-pstate: Reorder notifier unregistration and floor perf
    reset
  cpufreq/amd-pstate: Use "epp_default_dc" as default when dynamic_epp
    is disabled
  cpufreq/amd-pstate-ut: Drop policy reference before driver switch

 drivers/cpufreq/amd-pstate-ut.c | 36 ++++++++++++++++++++++++++-------
 drivers/cpufreq/amd-pstate.c    | 23 ++++++++++++++++-----
 2 files changed, 47 insertions(+), 12 deletions(-)


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.34.1


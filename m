Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639323D0930;
	Thu, 14 May 2026 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795818; cv=fail; b=jNndOz907XdN6AHknqESs3d49waZSfGYW25G40pAKGFTgzbje0rOTNqpgnmDtOXk3ujmUDs0P8eE1AoDJ3ME7TNY32loUQVfzNVP4ECdwE8zIdQfyuxjDqS/13RM2C2kEWQFaYNSAXEJvlITZhrfQcyU5JME5KR8G/yqyRq3owY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795818; c=relaxed/simple;
	bh=tXzLkTT3MO98+naUz8HTknpXmSfBMpMHYlU3BgELi9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1tvDWUbwWxgzOcnLRXC5R3d4F3oH7SA4jT5149kuIc5vS5HkmVKkIShjSuN4ArKD+rxGInW4aF7WDkk2JKhtxliCl5yf1UkIgqfqnMBoR3cFXd8qAae2Xz+uCrpTmgHkH8vMCqg1zhI+zfv0+LNV/1Dv5a+jztNhAxtjkcpeKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SH0Kh8tf; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SH0Kh8tf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9xALefxqd7qG0xTKV4rNbS5Eqk3JIEyaXfqS3Zgol5QB9PX1nJ0qskkMlvJre+bJrYLZnI2SBg0QU2d5MnKIGt/wnvaQMMbYyOn/rdJcAfL8+szA9AI0/N783kNMT3bpBpXWkQzIN409qahSFtBYVEbxrN8nDZWzOg/lkmnR+bZT1M4/hON33OTDivlTDkKjyaYURGkx+C15sSr4T+1dwCJ8Xj+NOaQsp8cCcmFqIrPboHOmQtIMN8RFjkGvVll/PyF1XtVYu7+pYiuPhVdvsw1OX10E0P8laYfb1qEg3YgAvuuqLXpHHTD7CZkGqQKCPv/jhsNNaWgJqzvMbovDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsuMb5xm29mygM/v0++QXVWwjE4DMWKnDJZKNP2VgFw=;
 b=A9Uop7LWnJolM9w0YHeso/AtcBYJTfd5ZdO/gX9IDyC8LC2nFNOUMfpaxFZHbYqqjmBa7CBvWfR7nG4J2bBhObFHTXtv55iBgvrMai1qZgTs+p0oHmPX2A6nXvQMJM+RvKUPbi5WZk9ToGNtOrLdqsoGVjVfsR3X/ESclBLGVV/PUJcVfZ6W3XHJnpUcezhd44M5BXkfaZ3YWW4CrJ0zzqa5F1Brr5OxRd1W53nDToogbGH/f2V+aRoS1DiTET5r/YH6J8fo7tMc0SsTrkCVffw2J9Qfrob7xK6fyQn4ynGzWpllgP6Zbn5ydzUixbhAwa50r3jGBmICQdqF6ToaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsuMb5xm29mygM/v0++QXVWwjE4DMWKnDJZKNP2VgFw=;
 b=SH0Kh8tfPiy9nreqmCU/tQBM4F8tU2hJ1rCaW95jHlZMQK84l1Lnpyp+wjkH0Yu3NYNZ4quKAYJIjmO85IMIunjJo+y3dHObtWBpPUmA6h8ubfESx8wJ1X24Bwg+L3KEAx5wvZQHox+d+kf8D+DiYvFgzhskrULfknaVfgIjqeg=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Thu, 14 May
 2026 21:56:53 +0000
Received: from SJ1PEPF000023CC.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::eb) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Thu,
 14 May 2026 21:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CC.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Thu, 14 May 2026 21:56:52 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 14 May
 2026 16:56:49 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/4] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Thu, 14 May 2026 16:56:25 -0500
Message-ID: <20260514215626.35327-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514215626.35327-1-mario.limonciello@amd.com>
References: <20260514215626.35327-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CC:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 791bc3a7-09ad-4845-dee3-08deb203b565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	H8ohnC3+9+9x4OIVVubwDiIx1JjaTxLZakRPdNa4RAHj/6VRl+3F6HE6WTB9lnytfO4L0DBUfp2EsFGjFxK/gWQx1KlLbjekmncrGFW/EgGFgkANLcgM/etSOKoN9Iol0QvB8LNTbTlll535r3k84fOSSJp/gnupPRYEgN60dvrgeXn58A+BNGztxUOUbGXIMnNN2lLyOvbkOuetWd+GUYXqOQ2T7D0c94iJVzbnRzRy+pCZgI9kTDArm9RPOO6SGwizunayhqOjGwTgpG5ERl6q2Wj5BkOvxBYBQBmz/17xLougzypC8D7hatpJxzjHk/4oz3fFpIcwvpsV6/FXw1QQJtldYPkMg0HnReVv+/am7J2ilvewnz7FYIOcBtSwck+0rIPXE+93T4pV3s87C7QuEbG4zzehd/KHXEqqxIj9CldTd3fD/0uEvGD47G482rgKzxfOXUVG1cn+RRJjyK/qc5Tx25dumuKnlTU77brqz7Dk2uUa7wi3Nz8/Oro9psnOZITgDC7C2K9QdvP5+Ku5fMaG6VueMIL+eUrqtaMQqdMbPWSXpnQTCABl50M4YlgRMzAycvZ4SgoZxkL3CDsXpAQ3XAxTE8YP/OVghLx02WzBRjGs/KzFU2ZtqnmsXqK5JLBh9lm6Va4TjFcNkl1yo+VRoPUwrJnhuk9TePxoMdHX4VsyRBRRad8wjyFR31CsL9PmFzR5VcDR3FCgiTYiBEvQ9OETdQESV1Xuvp8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IqqXTiNqu64kdiKYdvOA7QxOY9Doe2csUiRR3vXa5PJG8DL/88giksyicRiuMBnHc/NIdhpJMqzc/4hx+QCtVhu05pFmaloaoTd1z0FRKeu44iEe89baRUlOPUvg957q5MiL8k2QIYilhJOWXYpsozCFpry/sYfK8BOyh0Yk2hVpvcb4D58IwyrKTXzJ6nsP4o9Q+p9KxV3eGwK24u4WkNWdPLLSOFNIA8KC5f9gcQa2xPDGyQ3E4WzAbk+d0Z2xylkH+L/dqcCfknlLmvR9WSvfdNA7DVAYnPR3THRg5NyTMbxaF7VekMg82zZKXZlp1qOkJxGBhodXJtUXB7Bb2LCoxSTDZHiiXsEL/B5QIkwO3KyrI4Ba2BY28xbu2HJSPZBa+eaP4o0h2zj7wRpiyiBUsCavBTkDuYB13WweSyXhK4l61+2VGfqzlYfEVeVr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 21:56:52.9843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791bc3a7-09ad-4845-dee3-08deb203b565
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

Update get_max_boost_ratio() to use the new amd_get_boost_ratio()
helper function instead of calling amd_get_effective_highest_perf()
directly.

This ensures the boost ratio is calculated correctly on systems where
frequency values should be used instead of performance values.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a1a005b29daba..6e80540311f60 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -626,7 +626,7 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 {
 	struct cppc_perf_caps perf_caps;
-	u64 highest_perf, nominal_perf;
+	u64 numerator, denominator;
 	int ret;
 
 	if (acpi_pstate_strict)
@@ -640,33 +640,31 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	}
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		ret = amd_get_effective_highest_perf(cpu);
-		if (ret < 0) {
-			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
+		ret = amd_get_boost_ratio(cpu, &numerator, &denominator);
+		if (ret) {
+			pr_debug("CPU%d: Unable to get boost ratio (%d)\n",
 				 cpu, ret);
 			return 0;
 		}
-		highest_perf = ret;
 	} else {
-		highest_perf = perf_caps.highest_perf;
+		numerator = perf_caps.highest_perf;
+		denominator = perf_caps.nominal_perf;
 	}
 
-	nominal_perf = perf_caps.nominal_perf;
-
 	if (nominal_freq)
 		*nominal_freq = perf_caps.nominal_freq * 1000;
 
-	if (!highest_perf || !nominal_perf) {
+	if (!numerator || !denominator) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
 		return 0;
 	}
 
-	if (highest_perf < nominal_perf) {
+	if (numerator < denominator) {
 		pr_debug("CPU%d: nominal performance above highest\n", cpu);
 		return 0;
 	}
 
-	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+	return div_u64(numerator << SCHED_CAPACITY_SHIFT, denominator);
 }
 
 #else
-- 
2.54.0


Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0E45DF61;
	Tue,  1 Sep 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299979; cv=fail; b=dFW17sDjw5wEGFS7nNr6b2gJ9k6fAeHPVOzPhnlkEpnnY+kMQyhgcnaBoJfuQYIBbxXRUecCNoXrzh/BXViOFkC+f4bICVv2OIu6SGicfX89u6cVTuvBTvDzvmUTqTdZv4sCLKK03H8WOMeYwQbZ5byTEG5Jx3mpm5I1ewJUprw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299979; c=relaxed/simple;
	bh=jaf2OZrz6goSaXYh9O7m7a41gzvNHur/SKLKuIvqRAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIXJoA/Jb9pKw5NgDE0JbMMcZkGgyUIfY0kwtJap3xLi21Y59zwxQt9venSrgVLWnHCKUxLh6pD0dncyEVLYJsJ2OLYdR0ENzKbWpz+5iWNmMf/0KMaubUPiq2KxC4wxI9rL5JZ8RCzyQ8cktbvpsEBfT0brRZ8ZYJlZxkT9VP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5bvYiSlk; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5bvYiSlk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMgpkOfvqYQng7drQqxEA3mCD/LCGYVQGZOhnj/1l31CQGYidkaE8vhRntVUAJpoDrSBnaxFFbA3CSfyC43g2inc/xzTQw6yrQhuGXzAamJYNaHnUqom7TIS6QMBgZUX7D3Motf6St6hbXMowmD2ujf10dqL7lHDqqepaFW6QNJIrd1d+FGKxjNI07N4hWCe5YoRgc2kiNMgc9J1J4U0sAeU0t/Qj6+aG5YReC11MjHlP+NPSarAKnmQ5Jy2F7vRoSHfbuw0AKXmhRnqTVpKeFL7HeW19JMuOWW+1FltwU1jEcesj6pqWfhLVYodOKLS6yo6i3/v476ci1HOE4W6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/170WNqvzSQxQ9u4vl2fD+LLwjr2RfDr0kuTJ3hlnAw=;
 b=tNZFeKCUifNy0gEPU6pWZdzsCSUeIN+REeF2SzAyRLolLrRSzMDmjQ55FzRaYcbPgDhbjp9IVI6rgvswEPbe2PbJTgBNVIiTIf2kYIXHb9L7wvhLby1M3i7wU7tFI3g2SuaEOUDy3bRZFWya1UD+gJWlFyzm4lxYH5D7enuXhswjknLz7/H/kWgGYqZMB5Cpct4964hxFiuU2W8kOpOUQFPLCokmO5gZHMQyLh05aa90q9DZOXF/hAlynsvgnlGOrQRv7Gmr/UyC5zsQWjA+GQPii9/26BTEBZ5fgAsRVWXINr/zTqaHtvC6sRG/3tc9VGxiGLjjc2eFw/sojqYnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/170WNqvzSQxQ9u4vl2fD+LLwjr2RfDr0kuTJ3hlnAw=;
 b=5bvYiSlk/7d6XSuZgY7MUI8imMaag0BvfsxbW9CTv1fYot2NJ0NFfTGWUY1BKN/Qfx44iJYemBSukUjayArNWbstmTQW2QFK30ypflXXhOgbDmJd8hmXjVzu5LXlagCnP/+zGk7GTNc4ot6KbI3EhvKhBaKNxReBEDwEf280pPY=
Received: from SJ2P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::10)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 21:59:28 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:5da:cafe::3b) by SJ2P220CA0002.outlook.office365.com
 (2603:10b6:a03:5da::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 21:59:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 21:59:28 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 16:59:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Vishal Badole <Vishal.Badole@amd.com>, Mario Limonciello
	<mario.limonciello@amd.com>
Subject: [PATCH v2 2/3] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Tue, 1 Sep 2026 16:59:11 -0500
Message-ID: <20260901215913.3042182-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901215913.3042182-1-mario.limonciello@amd.com>
References: <20260901215913.3042182-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: ca602832-f6f8-42be-6b16-08df08744b5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yP0B5zaaYfGrxZ5BgTSpsXzHaLRbpg029Hv0+C97x7X/Y2Djg0pl4Jbfad5PgotoiE44JWDLPnPor+Wb92SaxvnHHxyP5JoAQx5T0OAqa4r3fQj0Kz3E2t6QNRcpzuAt1ZYvY5cZGPQcJOSYl2zXL/CEiO3vaTT7sIIaGrx1LiRXtoWXQ2QP381I1xAtcZ4PnlyJujbvn0oHefJqLOhrUWqg6GRt781KL2vzqxU76noJc0TsP/HpZGXytuBa8uqPz5C7t+sV/an/I94YJf/l4711bUdg5jKpkVMaIbW9F5QDL8WVAK3BVmgHqDkkfTjTWKInhKBl+M3+kcy5mQqm5fsrgaSLaQ73/nPv4ZcQP5XMAhb6t6vD5BSILbrcTzfB9jbQfrQxItqV3uk8pnbZ0ZRbPch19zfP248wiwDPskSx1NegDgbgkZs0dSuPeMhQ8fxB6z7n+gLtp3UoJqVaa16y6Gla2zN0+BTISOeTYkA7Ipltb4VtvCB/GjRzGp8xMLbuyVhg4XX73ImYY5AUbNCQdJAlh+GsMug9Unv5Zed51y9q2R7YwbAD3XItN1Cv6Osr8oM3RnnjxwJWvQtEp5+FkyINEaC0KNx8qiek7A4L3RmPQvPP1hfxVHhnqh4hTbvOsoAMFz7QzNoyYoSbp3fm76OSHcPqUZHviP9PMreLsudPfoH1BIaKVNf/KGKov1FCh0hJlQLbumMAT6lrKg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G3ZltZ9zjViBQ0c3PiVUWDebILsl5YtVDZuay0ynFuVeQcggIdno8pifeekYI8iSI37bseIGBk9IkJtjPyMxl8uQKbpOT6ar5PfcBu9jw+iKIehzL2rYco+PGCrvdodTtRhqCm2i50m8hx7o/KN2YGqIFZ87HtihNe9aJ/KM3cx/Nja8BLJ4XJHpsMbueC3HWDG3qqSKhrzopWPCmZ0WHTXk4y54su1ADcFpHAS9DxfKhNOj9eFwlGXKi+anwOIANvdysemM+8hAaUhe0YRH/aUJLCvFyQGeGlH3g57B1RCahsAGYKXKxn0eBKIgZeIB7u2NSKrkVnqKDmRcpMVEG+P1Rw/WC+1Mwa48J7/0bEYxx0T7g+HfqRnSdvFP3j1F8zUitW/jGl9BPCuTXnSgFrWbKQ+DVGBUmMzmnkdo8WlQVp/PJERbaZJceZO6T5Ca
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 21:59:28.2197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca602832-f6f8-42be-6b16-08df08744b5d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608

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
index 523ee1a06ef8a..2e74a000cdc74 100644
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
2.43.0


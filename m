Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844E38423B;
	Thu,  1 Oct 2026 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864642; cv=fail; b=esZaecF989gXGKZxlhlYVvKzTXom5zb6Lff+yGxK9Kc6c2e0PrUKDRfHmHGRSKKe3oYShuRfmYI+Z3oszKBI6fUu1v67R2/7wFwCpzxIEacpKvBCjDjYP0KzulXWDkM+PpXh35PhSM6KxL4UOd3JwNiN0H7Un35yUq/DJTKJlDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864642; c=relaxed/simple;
	bh=Vgq2F4bgNGlfBaKZRWHC9Rsk5xEISqHsQJuKiVgPC34=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBqIcEELxhBLe1VoYwTlsdK4WY66d8oJ88H1tyDlIlqJ/k3kd2o0rNNA7gEs98a/SZoQRQo98uM26nf8zjeVGArkNqNYYjK78ZhWWeuQlJ1N1hY0z60qGtIKYD6M63saddFMCP1z2k1xASpI7KT+wF4WshKCLGEiqv18p483+9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wecrRedy; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wecrRedy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcqJDogRhxhoQRmJIRpX5xbEML0pIU9V30SrSWetoujXPtzrda0Mqra2jOJemwY6bNcNR1i+wk66KcdYGXyYV0LWvjdZeLfa7rbnkZIbp+RJtiOzuFYDP2Uc6l+dPcNIg4+WM5zPWXozqeas+GvN7dBZ+UVc+mIShGtiytOEA3v25qXvK+XjUgohGEtdi3hU5rKzgMMYLrjeb6huN4fDSET+LsSA6QzwCEl85eklhnVaKrLKsUaKcQveC+6XPJlnaTCxjd5jyGM/WmAEEXL7Mc4KbvHemQAi4y5r3bs2exfBUv/3p7AmB5sehrGWvwbt1HS/aez939i6kT3uE8xUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hoBokosdWlnYfEuQ3KF/oHQx8+tPs9mSQyEGSG+LFE=;
 b=B3MHH/0VNI3ahy84cGEI/lTMGM5LRvHYB8FhW91phQQzjNTP+E2FJ85KzLsWTahDv1bLiKMTISpdKBnYwoZq6RQDbTPhSULhjDTf35fo1iS/uMhrfMZM2so2LddLKlpW67gMpDJCYS0eEsqkf97bRexTZ4Yw1r82wO7Ut7VOK/VmajhTVrOWkGVWcOTj1SoB0bFFVRtDN7T0WubRJ4NpAuQQGHy+LaUcxMC7JEuA98zLWa7/E8XLq8cr0llgqJGGBtkMLEhm2kAbAkfi5HEd6+62NQuEqah4+LiuK7oT/uOhgtJqPpgrvFUk1lQv7FnpViFEyunh69DeJWZByatPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hoBokosdWlnYfEuQ3KF/oHQx8+tPs9mSQyEGSG+LFE=;
 b=wecrRedyUkb6EOL1kmsvDYrH/UXW5ZiMfgUQE9L6eW1NMr4Yeqo6BK+vYrXoaHQmqzk3ZOEl5FC5l7Ywv+osNVv6Slkwz2O+iu1EUkuKAsLFkyHiOmfz7Qq0oTeaF+S2O1MK9qcXShnoAEyUt026EAnTLIR73T6EoUl+Peok/bU=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 14:23:53 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::5a) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 14:23:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 14:23:52 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 09:23:51 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Prateek Nayak <KPrateek.Nayak@amd.com>
CC: Perry Yuan <perry.yuan@amd.com>, "open list:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:CPU FREQUENCY SCALING
 FRAMEWORK" <linux-pm@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Subject: [PATCH v4 2/3] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Thu, 1 Oct 2026 09:23:40 -0500
Message-ID: <20261001142341.2934582-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001142341.2934582-1-mario.limonciello@amd.com>
References: <20261001142341.2934582-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: fc068b2d-6a46-47ce-be92-08df1fc79ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	JMnDIAeLP5meXy0bznLjFIhQE7kWSX4vNUurgecJtoRxAk5B/gBwQRddgWrBsPsF0WXhDM/0l/GtiD/FSLf2aRztTrlmA/b8QfaXSPSMoZJOD9HwgkpeFlsC/3b2NwJYTnwISv60Wnp6vwi59Pvd6Y9VbsO+FD9+YuqmYX+/Mz7wr9rE6NlkzoQ1Q5gkVxQf33B0V2ijL/12b/2GlYY7oY70N71QYpiZo+UdRIuAONmPNC/h6nBSntJxV7xuItuc3wmKvskBLLdyZe0/ZQecuVqJLihh5xofUlEhgnKaK9mFBXwhHCFotp4KdwjKy+hW356NVcaobXVlGOXxPQOPN9LrLMGVnXI+sbAcptmId8Gel0fPgGYMBI90L40f07m2mywu2eFrfBbxJWR+rCNH/THZYdWWrJl2gEU9O6zSSWSFouuGNVm93d4Al8VjrmLfuSv89VDbYZc8FwMOcvnBBualguRAeKRveta3/6eOnon59L+M9RUqxhQahasl14MgRDw5+6R6ZYioBvi9L+lLQScRZ8kNY715vWd4VISIE0p1Z4x/3zE6+l2/k6UC9W6d7JZ093reo5BF6MuBCJsVUkJAuXaGjIDTGl6SnD89teymarjQ6puZ27Erd8tLg0vJu5ord5crKhI9t08wZBzjNyZnkY9bEs85AMPSlgU3JipABX/6yCpPp4jie6llmGEiBOyNZ4hmgDvIew/A7JnpyQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/rT42+T4YtqnvbLYgSGAccQygY9SccluQU4SqVnvj3/9slb70kZ2edl5i9geWbKgX8NodOBF39FGrY/qhPDCW2DoAe+kmIxV1jFJi9vKe7BAepWe3GzfRkq6u1BKw3WLs/97Wwv2HoSz4o9ArBkFFbirDKtvMbGqJYBWRcpwsNcMQkMDiaoY87m0LJ6ghikHSo+Z/5971BMkugBJLSOympIzj4I3pJ+Bvv4Yse1ndkWEcCMJ4iJhOYxQD4+H2GP5lcCXV9vxPA85wrX55wAhaP5igtaOFiiMBP8KXFeQJXh9kzg2l3vb3EnikTpU4zzqtkpyd3THGTtvdFBmxlo25ER//Iyae+ltgZ5Vt7ZrbfPM+ZQizSvYXMaa9Nd6b39onE/ZsGbkkXKt/N75cySEWivt9q6SqLtyDawjpP4Jm0EyzSZK/fFEX0vR0fDrnv2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 14:23:52.9190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc068b2d-6a46-47ce-be92-08df1fc79ea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

Update get_max_boost_ratio() to use the new amd_get_boost_ratio()
helper function instead of calling amd_get_effective_highest_perf()
directly.

This ensures the boost ratio is calculated correctly on systems where
frequency values should be used instead of performance values.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Add Rafael's tag
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
2.55.0


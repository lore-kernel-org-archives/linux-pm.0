Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332D390209;
	Mon,  4 May 2026 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935724; cv=fail; b=K3H4dbYIJB+Ks8gGGxl1LrN5LrCmoKN8b2WYE13JR9JM8X3eU9V70h2bEmcdf5gGcn6s+ubpa3gVRHfGJkWwnM+WBF6O+eGy8iSDPGvZa68aQbuzU0RRDqNeZt+LZhgdRQ/2IniVNKf9Gik7xj+m79Atai/sF4E0GnP8KDvmU7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935724; c=relaxed/simple;
	bh=rzozYoGCON92sHNogKL0QITfvx1DSZFOpG2V3871Wf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP6uCY1Kgx5S/rR6HQH7QK5m4/nwwAk7TgeYYjeRDB1IzVBKJHIh8tc9V+7xuRSM9K/oGruzfskcC71AOdsNcEDCPaVUVnF4/1JKwmTQoaC4i0s8/lofiihG0TTU3vuGXvEciQ97HbbFnSxu9DMrL2/8iOhFMux7KaXoro7PB5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cv9zD3fx; arc=fail smtp.client-ip=52.101.57.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cv9zD3fx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kyxd4TUJ27Gexvbg+zmWSuS8ig/MdL1Q5ROX3ZnDhZ04KxtwSD+Z56b9hJxaDj7cm3S/bAxEK4Wnw1GaxuqasHg6YZPwuvKzPOmYncpjvSWFnpELtgHVJaKWsQlGVwpSAC0Fs0nvR7si/fDxkxKqAo7yrMl4kWbBU/dd/m6KhUfBA6wid3Ag3T/+Wqwjdnl+BclB+jF3YulUT/zytZfiQSLmNr8giicUvt/S+AQPE6UwniHt7H9BxebH8BBUwkG6G1QMFZuTjE8BNv417y0UQhvVuYopcqhNUnlTyYAicjnkgLZX2joBBSLbFnoaFjx/iB5OXTcm1/yPNfet4orr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxsyJZ8quAY8CsGRrV66WF9feUl9sUhMDg/JTu+wKRY=;
 b=qN7eKpPfUDV1fhe8qkstCryLaYzDzYs54V+CE507dNv7/AtyxegxKf2czEr8tkQloPFs+SaVto3fN0OtJ+CICr0PdJkY2e9qWpDEEYrUJfTu3ynbICivgvl3fFEaTdvu4ym2BTfFvti8GNFzFIn5ySXO7BaKkweb/XU9Y191sItlRRcg/FOdVFtAU5xIgNDZdDpGi22QUS2PGOTTqXLaWNsZGg5S050lgFqxRwI8axhqlYMo6MSo4/AkJ99CzSFb6lLautyfUGIb5+Kee/G12/RQZ0uXC3S++3zKO9Y/jgkpllTcewuY8d9SMyKbdcrCdvaWF1WyuRQ//qyiRUpU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxsyJZ8quAY8CsGRrV66WF9feUl9sUhMDg/JTu+wKRY=;
 b=cv9zD3fxznej5sl+o2pHZWGgmBVZ362T+iVaoTvR6j4HlVlX/sZPBkmGrc+/tT/uDj1ootWx6uCK5L39jO8tQVsFzV69TfSJhpZDVZ01hLNkR1YnUdWGs02zSpWRbfQ8iFnfv9y7KpUClqMtjIDJ30PnAVeAUA0+WgvGHKvrXH8=
Received: from MN2PR04CA0002.namprd04.prod.outlook.com (2603:10b6:208:d4::15)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 23:01:54 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:d4:cafe::41) by MN2PR04CA0002.outlook.office365.com
 (2603:10b6:208:d4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 23:01:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 23:01:53 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 18:01:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	<x86@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/5] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Mon, 4 May 2026 18:01:40 -0500
Message-ID: <20260504230141.484743-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504230141.484743-1-mario.limonciello@amd.com>
References: <20260504230141.484743-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: cc24a1b9-efc5-411d-821e-08deaa312259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VV/jRqR/AWb2lGv5iWB0nmF/nmgRGnvkxywg1XWjqHlS3D7KUyRndJDZcLuknMCKYWuW+KgrgKc2AAOSy6IvAWut/4irDZQZWqR3lRCCBu6fXtG5L/WPa/O/5B6wESZuQ04Y+aBV2GEEba5jkP9OLdc3lhA2XQht/dTVlQqVHtwR4Od9wq/eO+4DNJnSknRLZIwXOW/OlDoPry5C6NVuCkm4DJTcqdZ1pj2l5k642JGnbRN5hqbhhfST0KKGTSCHw50/X4d+1t6InLc5Fr2cR8hc1P0m4Vs4gSr1+kz77I4ehXVZUqKXu+nsbQPpaVkq4X02/dTNLZQJ0G06BRolPjhHANS6W3zYpMzx2EVbPTDq/zaNDzsLrnsPNGiNtHlWMM0dHVO+RUCT8oaLPheD1bhbhXiEKF0hcJ1sOyVzJek91U8X9q79uWgmOJzMuoW+8BfxVGsLL2nIUsRJywz4l1soq2mIELhuQVkVsV0vvbu8Px5nR3hcMtXcLfykE6+28+xVw1MkLDHJamoyPDrRFnX2CnV7EbKX1+KM02FlXVEeujeC+EOOCqy/u7Xk/5bq6YtpnrRO6DVuAfRJJ6S1ClAVmyAdyrEVj7AcN4gNiwD5qcnSZe5FlIQRqqZ6CK3VxrFSifbdVegJP/mVRc3Ra+xwUw+TKpkCmSsIfNem+40BxV+P/U5cxL0XSIe/SGBZBEQZ4taNjAbs1gCNs6MnzXwxIIfWjvlHrPOte4AxAtg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SXTIBhIvIVDf9fHdWWi3/2k5w8eDCwc6TKK9UGTA88iM6Fz4vWOqB9AcwNYqJs0aKJwL1mUrRhVAVXXuUUGHsLcf/q5rY5Hh6SCKJnxDl+lKmVXddGM/EkPLBNYW0pXzmUT3Y2C3SQB3y0ipDvphEu2O84bpLb9C0fQiIj+I+hKg86z5d7riN130N1IjLPOIBclygOyYQ1kNcnmIpH5dZXT2rOzrShkIaMh3yEtUb91AuHGFBiAjh7G4kWe4jADMenAYYeisbpyjFvfdmkcgNGc1vgM4zbws/3Hxpra1jsIdrftJox9n0HQTmbrg68oeNb3q0a3wqHczSUkvtJZgeLdSNyx6HD3WZep3KA6d4/RTXMoFhxQ6Lj4/Bz5nN8o9OBH6Ryysr24sZkLLg3Jqq9DDGPp/a7W+6LQdRHzd2Bqyb3lecVIbUOyYniVuV0Ly
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 23:01:53.9172
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc24a1b9-efc5-411d-821e-08deaa312259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677

Update get_max_boost_ratio() to use the new amd_get_boost_ratio()
helper function instead of calling amd_get_effective_highest_perf()
directly.

This ensures the boost ratio is calculated correctly on systems where
frequency values should be used instead of performance values.

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
2.43.0


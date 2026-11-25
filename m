Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795627259;
	b=DS1M8FTVdLk51fVuRqDeYd70vjIv9T+vndR19v3q4XXW5fiMaeisYdR/Wl/5+AK42xgE
	 9OLrgoV4lFyS31jaaynak0mWfuAw63oZJEiHA4gUBpW9se/GL1Tvf1uqXagDOujiJF3F2
	 RhQqWA56AdGBr1qPWcsILrdY3Fmn26zfb+y+V9e4kTo+8/OKEJ7W8Mwfw0AKS1rQF5tLF
	 WDzNxcTLiBJFOXqu4J9BznHZlrR8HKNdtklCGfRis87MFRCNpc5CuT/06AQRM2ukD9aqq
	 0vUH/BCtx4/T7p8pxq2Lwe8/+xbVAPkpJdIx4H0OBAdlqgxfvqxb3JE6j0qeZN/dAxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627259;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Px+biz5ypv+JMPnEwBTTGJxz0qlJ8j8+xv5ooB2c4d8=;
	b=AAI+rwNZk/XTqwCXxbhPu6EoiAnf15954JRymBW+AjCHPY+C2Fn6LiIA6fNMf8YOCC8K
	 4vG0VbBEACWFmY4PgwlBlTXFbuhZNMnXhrcYakqYK0Qvi5zVc01WO74voLYQNdx/o2HuL
	 ccLerqktrVbRGVtPR5Ov6Z9YbtpPWRb8BwJv20lC66d+qNwUjeA8RJoXav+ZClW4FYweS
	 euRouK4TDJl39tVAaWn1grzuQK4Gc2Z4sDfnxVilYeSIJeID4mi0ulq0VeBm0sGrIAeOj
	 80nI8FgHhV+igBsGI0B0VJiMEdqDmOG78t9z1XEt3vFNR6e4ZIxLMCPAPLqC2Q+WtlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5BtG3gI2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.15
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE85606A31E;
	Wed, 25 Nov 2026 17:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE85606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5BtG3gI2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F54A219Lhw4FzIeISE5YCLE7mcFmyZict/CnDPoxQM6lMzxn87eLFWyoLLrvfh7FZOZW3wvlJa4oqC00t3AQsfzaSwjz9P2vCgRHBNulxEq8HU+EnqGnWoffvPCAgxyMfjW+rauuuWraXgS7dely60rzpbTE/GDHVMM91d2ewFx/Ov9l4zYZhSbB1Bn0+A+hPvZtxatQJiEAo5OZPZ6HtlEqXrwSE6qcvh+n0AcOGgPN/D844UkgnHADM6pJr+P7XLoyBUkA7eWnwEBIpYz/ExcTTr/s0SDoloIs2tUphUgbWJINjluGG8TBLWE/yFxZvCkf1hE4kDZtLnSIyZWHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Px+biz5ypv+JMPnEwBTTGJxz0qlJ8j8+xv5ooB2c4d8=;
 b=cOwuu/Tw1Wd5/u4jVZ82O+gpjmVeIcrLpnYYLex22g/ShPkiFWbSWTV8GDyWXeq1SlbGcjKSsgmjRZ9yuWu+5emk31eMEPRZe6Z9lJY/0hpxiY6I6D4RjXMYAQf3xLKbeGql/X2FdC43kIvVqHyEQBGde+8jX8t01uqwYhgrAR2eVXUEuadqDJHiEKu1cwA7TCNayJB4NmAIyZKRIe6ZlHoBSeVXGiiOnKpAM5ugClDyF++XqH6mBvZAeNixCXbhXG3R2VBADzXOeaRPpHA593I5nuGzEWuF5F/Hh/IdsrTgWPqQ+tgclWCqVu/mYaseoRGIQaK0wEGyjskCkb1ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Px+biz5ypv+JMPnEwBTTGJxz0qlJ8j8+xv5ooB2c4d8=;
 b=5BtG3gI2mSLqGyUb5IBk9FtUbEYYzc1xDs4E7RKtKIuXZdKlVbzeLtdH53YcWptqDs4m4Ob5EzihDjYcAAgQXzU6uF2W0d5fcg4A7r+bE+XULPCo0BkkiY+yebF1r4+g05VkCsjwxDFBM7PklbjVJfKiTsdD9LdnpgKwr4z/4Rk=
Received: from DM6PR05CA0060.namprd05.prod.outlook.com (2603:10b6:5:335::29)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 17:20:54 +0000
Received: from CY7PEPF000000F2.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::72) by DM6PR05CA0060.outlook.office365.com
 (2603:10b6:5:335::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.4 via Frontend Transport; Wed, 25
 Nov 2026 17:20:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F2.mail.protection.outlook.com (10.167.247.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:20:54 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:20:50 -0600
From: Vishal Badole <Vishal.Badole@amd.com>
To: <ray.huang@amd.com>, <mario.limonciello@amd.com>, <rafael@kernel.org>,
	<viresh.kumar@linaro.org>, <perry.yuan@amd.com>, <kprateek.nayak@amd.com>,
	<hansg@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH v2 1/3] cpufreq: amd-pstate: Finalize prefcore before registration
Date: Wed, 25 Nov 2026 22:50:29 +0530
Message-ID: <20261125172031.741740-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261125172031.741740-1-Vishal.Badole@amd.com>
References: <20261125172031.741740-1-Vishal.Badole@amd.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F2:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 22767ee2-7ba9-4441-37df-08df4b187621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|921020|56012099006|10067099003|11063799006|261022105027099003|261022075727099003|261026140227099003|261028144727099003|261021121427099003|261026121527099003|261021123027099003|261102123227099003|261009223027099003|261009221227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	24TScElfEflfBIHAowHPnrh8W8BDHtglVkb0odqkScAX8CB2SmPljJk2V2jm9k+sHWly93+sDlfaZxOoWIEmrDGJBp5oIxk5zML4cO5IHBvNquwCBGbh8zuZNu0eByKN+jg1faTLsQ3Qh9D22eNnU+toKVSMxI+PLOm4AhP/OEYO80gTG2aDucy+3Ky0dO+yb2rBAud1LJXsdtNjH0a/vZdB6d2onsF4INiK6OmmuXYrsIvpq514qr1AXDrOfub4D3UW+xkqloZHZTLuMLuI4xK3cQy3ifBMDcXDtln5DQzIoNB4rKoMWTji+QZzfvv3vNEHliGX5GoCw4EaMwaBH0jWWLu0MWFJZurzJCPW+CEJaEbaMo2uHIZs4T8fZ4sLJy2UiR//SsipeTMwbFFlGqeIaZgAPW0dd0RVb9c+4qxjXOvyGxPJKGTW6ViMT8+XZQXTyQyYbRcfhQ8EcCZg76P8QvHjDgBNA7Sp0okYBqVqgnaq0A/rzK6W2d3UfT9Gw7zxxXWuI1SdBExdmJLHA9Ikyjvb+t0X8j54DzMb3f1SBbA9/AWychTvZ9VVdF3nybo/GhF9hJ6Rv6WLysH/v3SagnymcxXrvpm72LDZP1XvtOpe+IbNo6xzMU+LerbenuWYL5wqYClIjiledhc7pUtvvKECOB4fsA8cNAxudMtcLOZbniC94vl6lb4ZlAz2yEAUP+EPquAMA+FGI5EX5AdQ1Vvxo1JIFjNoeL4caBYfH56s+fD3/BRcAxpl6kWL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(921020)(56012099006)(10067099003)(11063799006)(261022105027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261026121527099003)(261021123027099003)(261102123227099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YznGvbPioHV/EzqhZigIuZ7FPXs9iOUXlS3JK4cUH+HSspX63mVEseEox6x8xRvZp9j4b982Xete5pDhblpXTbyemfMl3dnwcF8Zb/U4r2j3Yew9yaXhN7W+5RsPdc7RYvP+nJUjrwdTuRy32edV2Ettb34klHKZJJKWMoDBJNyQIVlHrp2kLwU3vr8GYSiAECmL2ICeVlAeGC8/8TeQ9RwtZu5vNKXaAG7mvhZtqE6jmtLiuzVM5bG1i5cWBBiH1gWdEnBpnukkaeKcSwlU/bqHM9OfdhLZMwT56KkphfSsMsObU9WrtKR+mp2dJqOJHuqmZ6vqTHt4mPo+gsJ7t7FQesZNDmjJOmWMuO6V7Aoa28DybAATQX4Hh0GhEpZFozc/jH+hUd5EQgeyipHo3UTw2UISR5H8v7f6sLZQ1Cq3+XXBhd58ADJ1XbisvjrL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:20:54.1932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22767ee2-7ba9-4441-37df-08df4b187621
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591

The choice between amd-hfi and preferred-core scheduling applies to the
whole system. However, the HFI check currently runs during per-CPU
initialization and clears the global amd_pstate_prefcore flag.

Move the check to amd_pstate_init(), after preferred-core detection and
before driver registration.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4bedfbfc18b66..3e0308f644778 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -956,13 +956,6 @@ static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata)
 	if (!amd_pstate_prefcore)
 		return;
 
-	/* should use amd-hfi instead */
-	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
-	    IS_ENABLED(CONFIG_AMD_HFI)) {
-		amd_pstate_prefcore = false;
-		return;
-	}
-
 	cpudata->hw_prefcore = true;
 
 	/* Priorities must be initialized before ITMT support can be toggled on. */
@@ -2438,6 +2431,10 @@ static int __init amd_pstate_init(void)
 			return ret;
 	}
 
+	if (cpu_feature_enabled(X86_FEATURE_AMD_WORKLOAD_CLASS) &&
+	    IS_ENABLED(CONFIG_AMD_HFI))
+		amd_pstate_prefcore = false;
+
 	ret = amd_pstate_register_driver(cppc_state);
 	if (ret) {
 		pr_err("failed to register with return %d\n", ret);
-- 
2.34.1


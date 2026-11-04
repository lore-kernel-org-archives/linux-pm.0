Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816186;
	b=xrXLGNK4T/8hr7fhu82gQLZrZpavRCaGA70tVII6T2gnrQiVfCzOCofSU2MyARCJtl3P
	 aQFwW2bqQtFi7ekxrmpw4pg06fZIvLkeimhZ/knmd/XqZD2VNqI68nhn1QiWViJh+FicB
	 xQM6HStvqCYOwLqzXTydOEefoVIEK98jBCJr/XHgt+IXd46ocEFiam4FD3uQqP6pzFWB4
	 Ko2ms4hO+aq48QJiSHg8QAQbUDfgTlBKuUh0PFPw9bIp1gaNbFGwUg7eNvo9ObhjHypiU
	 81DDZ5BN7BqaYMhOkWIQi9D3djbaPpw7EvMVpZCJhHqYJc7vXsHVI5wUo+4orjQzHvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816186;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Transfer-Encoding:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=FRTWXPOzN4odCLqt1BZ4Bae07c39yQJkoArXwGn6Lbg=;
	b=V2kSqg/N5UKbQp5z2I4EqBOC44lIIZeA+lMbMs2CW7Bc1LHfFTjGRgbFtYW/iKeUL5+k
	 i6TKV0MqhbHKLTdsSwFlP8AFBq1GFQRPEV0ss1agpol2hYOKorBjzXXkKVmtXY4JzO1C3
	 GAh/A1SkbCk/Vn70uE0XkEK2MIRBLQ8a+YOarBLsHWrEQ1fqBX6H7uCV8g7w0Mks2Dlf9
	 f6LMaTCtV9HvISzdOzEoyF2rMadfAIFJ1tpY7DPTafBQdo4Svi4gzoX8y8ETMvuMAikgH
	 yk/tV1tc9c4pj6+ImuduXjrGyU/SFrBuVapZFyewKeXUamtZjE8d4jqPpvn5Va7AQjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pjcWLSc8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.11
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A7606A329;
	Wed,  4 Nov 2026 18:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 913A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=pjcWLSc8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCXscZ6O77zIrzEiu+bDi23eCI+59ZCiWCnEqiCF08ibzWjfM6GzWCLwzZ9pP9bgs2kfi+ToiIwakcOjjBPQEj1v7xmAtTw8HGoQurACxCuiKf84qxuDeNRUf1PuFE4vF7q06D1XUjn2V+EBMBR1fQroTo7UE3qAGK4BLalBrRs9cWOavtzn29Y0nR/eW79v3ktqpw9hLIX0uxtkSH42zhXsm3KlNIKV1UimKK+Jw0vN+VGSIzSyOj2jDwxLq2SJhqVB39ZIzbBK3mqYrA7v2hEDyuxOrEeSAejCU9H3pLzvYz8wWfupKu487HWbncGOBYxbL+61U+0HrgyAPlR/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRTWXPOzN4odCLqt1BZ4Bae07c39yQJkoArXwGn6Lbg=;
 b=V4gLOCTM/YnwY/cU2MAjGygRoUsz6uNIaMeN7ZGjYSvLhgQCJ7l/UZT0wGHXkIlI2xMbDYpXh8kzzOvUbxvbmkCLprAtUxx5dl0guEj3BEUDyIMdunpuw7YhI43NNfcmlm0EpMsfEX3ekjMp4i6dHjOuM4vMyceYV6waSfKoMAagiBSPA8yALuDn1oqYELnDlzxVtnARYDOJaKY3HX2OWmefJxyp5HF/hpCCCjUWyQxKfnmRAqcWARfXceLiMXiIwxRTNViScUWjX+OPmFIt+TmmoS8oRCCGzD9trJlOz7Tdl0+HqsircQnk6p8FZG7n9ggZxJ3ywQt0lXfOISEWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRTWXPOzN4odCLqt1BZ4Bae07c39yQJkoArXwGn6Lbg=;
 b=pjcWLSc8ym1E0UQhNuHaqWJdCeuI37e7QTOyHOQ0l8ZpnjeH/cTkV4lzIkEccbSxCHk+AwaBxbeTT2qCc6ZdLoDcxCE6qjhvOvRD4MvSWCIVtAz4jsLHp1+H58lca10y5/yQfyLb5QDcbmHTIOw50ZcxwSNwN0xL61R/C7zJzAVm2/2Nx6KvTse53gR3obPuonmCz5Af+rRDKP8Y1PkBg8U5SUMSl8+xnyHM5wKKgNdJVffqSk3U9lWJ35uNd7wgfdA4cFtU1NKmHT6N0n4onIXIscwYepKCLn92icZACxdvc9VghFsyf91Y+flB//Mlr3oAIAcIogGCR42smEGI9w==
Received: from SJ0PR05CA0178.namprd05.prod.outlook.com (2603:10b6:a03:339::33)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:12 +0000
Received: from BY1PEPF000264AF.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::84) by SJ0PR05CA0178.outlook.office365.com
 (2603:10b6:a03:339::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Wed, 4
 Nov 2026 18:16:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264AF.mail.protection.outlook.com (10.167.242.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:15:43 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:43 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:40 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 3/9] cpufreq: tegra194: add tegra_counter_delta helper
Date: Wed, 4 Nov 2026 23:45:15 +0530
Message-ID: <20261104181521.3003578-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104181521.3003578-1-sumitg@nvidia.com>
References: <20261104181521.3003578-1-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264AF:EE_|DM4PR12MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: f6705c97-8684-47dd-dd08-08df3a9fb4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|261026121527099003|261009223027099003|261102123227099003|261021123027099003|261021121427099003|11063799006|56012099006|10067099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	svWCdxlvk6I2Vg8PVMHNFRDr/+5/EuRjHO7YNYYpnDStWr4xJHq0mPMepOSjH7i9SeUM4g0fX0/ICvgnrO4u6kfo9pdHg7f5Pe/pzQyMufi1kU8pGi2nHaCCO9V6nVddBgpbsFXgI9Hg+neudHK4mJuUlSQjo7elcOsbBueOJCq7cNJ31KggQNEpSXOEYeZv0x8l84nqJYe75qfmh4HDqxLpCmMsbrL04yUoBx/RpKcND9uDOKvO/wIJVNJ8YdPZIovOeFJ/lr1Y8ioGn6wQ9zDoxjCystCj9dQvOUaFqgAfqSJi0+qONeWShmJ7IuJJVIDm1cauNcnmAcyZnlY7gFyzJIo9G2+2le9/Pwnl/Lha7Ob8o9LziGWhWpqf9LQh1UJOQ2pJ83XVvlxlrNt6dIZ3oBAq6LeQBGQd2j3SLqu5BPFmYj5d+5Xiy9SLslmRulpAI0gClmBoYjWJ7f6zrinvmYMz/O9IhcXz4SE8kLwMbs1GirlOUgBewSV8aqdLnim4e94YR9o28PsSUYjf19hf+C1gpp6IjctM6T/x8FJEd4NDV72V1oLi+t0//ELpUJgTNjjYEXgx0zuHcEQw5DKXrR1zRkuOoLH+964g+lMSlQQVD68JMrmd8f9Pp3eOzbvPrJBieeTDDvd7/YsYK4ykTmgxKxee5nXZRkcvsIol51lCZhz4VEW2/UQCEeOnrF/xCs2tXG78llb1tAX7P15sQK3/yeDjTBGir6jbToU7xWt5A58i1K0PwKEXLKly
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(261026121527099003)(261009223027099003)(261102123227099003)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9BQvPuhU9m4mlqSwdGF4SNOSIfSiej/L5lI/57XPdaPLk43Q5dZcdXNblcWQg/c4V1eHX2iupz+RT+hbg8loy4uBw4Ht9PtDr0QwZhitU7SWGQyxASCqpg8vUCEST1qvSSeR7Z+5hwPxgusPuQa2TQyByQ3U9VCGJIU4DtviJjWBJoK8LX87cFfP48nbNS5qXLxss1fGhu//OstNIUljn6n26k0p8gVr1iHqmarPRNnmTm/4okXsH/HEqaDoPgAOZWfLL7UYW6HcFmCZabrH6YgQMyXIj5xBP5QD30wlI4+mD/YNaomjH62+0+2aXNbU4/R13nuSq6KnqYjOrEK4KNZ6uGS93y7YvOd7vBmgRrOuXxhVcEg0NWgeNMZHcbzXLJOTelaF1NdBlUqxWMr/2+il4091MPfARb4cCSlr585TLgAHqWD0ZU02CjEOL34w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:11.9647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6705c97-8684-47dd-dd08-08df3a9fb4f0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264AF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794

Frequency readback open-codes the same counter wrap-around subtraction in
three places. Move it into a single helper.

The helper works on u64 values, so the frequency multiply now runs in
64 bits. The old (unsigned long) cast applied to the result of the 32-bit
multiply, not to its operands, so it had no effect. Drop it.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 drivers/cpufreq/tegra194-cpufreq.c | 37 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
index 0f350b4db6cd..afc10c0b874e 100644
--- a/drivers/cpufreq/tegra194-cpufreq.c
+++ b/drivers/cpufreq/tegra194-cpufreq.c
@@ -110,6 +110,14 @@ static int tegra_cpufreq_set_bw(struct cpufreq_policy *policy, unsigned long fre
 	return ret;
 }
 
+static u64 tegra_counter_delta(u64 after, u64 before, u64 mask)
+{
+	if (after < before)
+		return after + (mask - before);
+
+	return after - before;
+}
+
 static void tegra_get_cpu_mpidr(void *mpidr)
 {
 	*((u64 *)mpidr) = read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
@@ -276,7 +284,7 @@ static void tegra_read_counters(struct work_struct *work)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work *read_counters_work;
 	struct tegra_cpu_ctr *c;
-	u32 delta_refcnt;
+	u64 delta_refcnt;
 	int cnt = 0;
 
 	/*
@@ -305,12 +313,10 @@ static void tegra_read_counters(struct work_struct *work)
 	 */
 	do {
 		data->soc->ops->sample_counters(data, c);
-		if (c->refclk_cnt < c->last_refclk_cnt)
-			delta_refcnt = c->refclk_cnt + (MAX_CNT - c->last_refclk_cnt);
-		else
-			delta_refcnt = c->refclk_cnt - c->last_refclk_cnt;
+		delta_refcnt = tegra_counter_delta(c->refclk_cnt, c->last_refclk_cnt,
+						   MAX_CNT);
 		if (++cnt >= 0xFFFF) {
-			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%u, cnt:%d\n",
+			pr_warn("cpufreq: problem with refclk on cpu:%d, delta_refcnt:%llu, cnt:%d\n",
 				c->cpu, delta_refcnt, cnt);
 			break;
 		}
@@ -342,9 +348,9 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 {
 	struct read_counters_work read_counters_work;
 	struct tegra_cpu_ctr c;
-	u32 delta_refcnt;
-	u32 delta_ccnt;
-	u32 rate_mhz;
+	u64 delta_refcnt;
+	u64 delta_ccnt;
+	u64 rate_mhz;
 
 	/*
 	 * Reconstruct cpu frequency over an observation/sampling window.
@@ -356,23 +362,16 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
 	flush_work(&read_counters_work.work);
 	c = read_counters_work.c;
 
-	if (c.coreclk_cnt < c.last_coreclk_cnt)
-		delta_ccnt = c.coreclk_cnt + (MAX_CNT - c.last_coreclk_cnt);
-	else
-		delta_ccnt = c.coreclk_cnt - c.last_coreclk_cnt;
+	delta_ccnt = tegra_counter_delta(c.coreclk_cnt, c.last_coreclk_cnt, MAX_CNT);
 	if (!delta_ccnt)
 		return 0;
 
-	/* ref clock is 32 bits */
-	if (c.refclk_cnt < c.last_refclk_cnt)
-		delta_refcnt = c.refclk_cnt + (MAX_CNT - c.last_refclk_cnt);
-	else
-		delta_refcnt = c.refclk_cnt - c.last_refclk_cnt;
+	delta_refcnt = tegra_counter_delta(c.refclk_cnt, c.last_refclk_cnt, MAX_CNT);
 	if (!delta_refcnt) {
 		pr_debug("cpufreq: %d is idle, delta_refcnt: 0\n", cpu);
 		return 0;
 	}
-	rate_mhz = ((unsigned long)(delta_ccnt * REF_CLK_MHZ)) / delta_refcnt;
+	rate_mhz = delta_ccnt * REF_CLK_MHZ / delta_refcnt;
 
 	return (rate_mhz * KHZ); /* in KHz */
 }
-- 
2.34.1


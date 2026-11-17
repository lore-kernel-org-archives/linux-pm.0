Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930657;
	b=Pn9oK115Q076biQk22C/aBTEo/aY44t6kWxpAFcYcHIXgWITGzS46bVo1CEXqR4U2NWE
	 9j0iY4ezj9clW6Kfcy5tiMv2q+dzsthS1K/aZ/ATM5MHnt04wwUkB34IMCCKVUdUVTiQ4
	 lYyq04cpcg4nPMlN8LgAUvEn0kO1ZqLiSBWKCIfvbmgqW/ZI3MuHJjreE6MLsR0LhDO4G
	 Po4NLbz8QP/ELYrqMumSPYxqV47y7DkhEJGSN4djQNClUHTuURP7GnA7jkSrpeJLMCoSo
	 Hz6Vz+GLK55lDNrU0n1ItjJQ761c7PVuLc6qyIfSvjbxMtNcPVBrJyDoTQ/QimZP8bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930657;
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
	bh=FbYnWgATwqW4C7aBs+eI0l4s7JA2FTAb0XwqqGaWk+Y=;
	b=Ly08OzyrkrWg5MBbA2DUNMU4SVSWbnO4UV+K0QGPXbzJW2UbtsT1p0xkNDoWp7GWKsVZ
	 Q2fHarK5ieLSH8xbegu6Ylnnjg7B3BONDB9gidaq26+lJFrBSL04sEGFaPvanT1D5GeBU
	 B+QdfQbTVZ3SPAcR6QtqkshFm5kj2lSod/a1y+kZVR3Kr+hH5Lc5H2sRDXZF7wuVpzSFl
	 5NqpzyHmx11hsJ4P3pKYRgzUCGWAOUsrS81IF04jVkAdSjRvDz9YC8dJwifgBIoyvJu4c
	 7ioGwiilm3SFE0xxlGKTNtL6Ya58w0zqvMA+rA+NY6SmUoo9t5UQX1z7e8eRV7tndyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="H/UY1odi";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.8
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB4606A31C;
	Tue, 17 Nov 2026 15:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DB4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H/UY1odi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8ZKIB4Yeye3wpK6CQY0lPF2XXsH6dZHgZ4onIKem19o0G1Xmdw9Ht8Cy50nAY6WLTilmeaUZaUDvcOKZlc26eBRrTqTS6o8zY3TZ6exs/Jfs7QnxqAqGj7Zhjpjgb76MzWw2motRCf8HjUQmHrXBrsTOA6c+mKC5yimYxYBwDOIvxCfBuS+WAh18/eJP94JCxTSxu69b7sGtUFGYdbg5Vlv2HGSY1RUp9QosvTxFT5XlAS6Fjzpr1wRzKd91gxBImralACKNiT8INohlEkJkgOvURM9PNMs243lYUBWzbbXZMannTEgFNKPWaKV3F1j9/iX0Z3/37mH/1jnVwXThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbYnWgATwqW4C7aBs+eI0l4s7JA2FTAb0XwqqGaWk+Y=;
 b=xEVWIUaVbRYdK10jzXz7eJEnvfZoOOjesA6/xa8BX7lx5yPBV2vHQhxsLKxd6L7tzZLWidk8B+gqBQDQICaZnmVGAP7zL5JAG0SdXfXqrTEPmIxFhtVf2Hc2Y4l8AEUKyLou3GhR8ag7nXNstp5XDE98UX67BxsP/4KQLccPVpTzeNeflZNm8I3FK0f5FAkwM4VtqHZ1kthF16WjPdvOzsxLenAr/08EXkANtu5k9EgAJ2gEuUp0Fq/wojoWwB/gMRn2MyPbsnkRiJL4GSui07LMDIONeRSS4zLLIASOJDUhXHDFU0aOZyvgR9yaPgVTeDeaNPVPWhtlOr3pCs3T1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbYnWgATwqW4C7aBs+eI0l4s7JA2FTAb0XwqqGaWk+Y=;
 b=H/UY1odiFjqH0Va4L5n4Ui0x7Z1MAswuZrmaqzSgrXe9yPG4CO8Q2i6n9pVOzfQNLJfMIdcaRrefDN/t5T67rxeK+xydP8i1ju0uhrjC6hNMXL8y/qV9Pm6Mu8jXf6lVgzQb14l5g7Dajx+rofZgFznP8bIAOhxi82M1s82gT6XwdGMnw7k7LaxS2eYGFKZTS4Z9LrrrvI6RHjSVKOyhGW2yvECRazbeRqA8IxQ3Xi2PskZ+AK8nAMIDjMyt9dGANAhyOabZ3tSGN2AImWmWUQrNSUVoWTzCDUIL8rvyRtT3Uhe19UOkgNT/npGQlGKkhQN/4g5rjtR2ID919ciTTw==
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:50:52 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::93) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 15:50:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:50:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:29 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:25 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 3/9] cpufreq: tegra194: add tegra_counter_delta helper
Date: Tue, 17 Nov 2026 21:19:48 +0530
Message-ID: <20261117154954.625126-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117154954.625126-1-sumitg@nvidia.com>
References: <20261117154954.625126-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cd59f2b-a3fb-43b8-a721-08df44c28efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|921020|11063799006|56012099006|261026121527099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	KJ2bnn+AMVGU76+cR8L0M2enxnC3p09Nt8Wn1CFlmyFC+mjt14PUjsuO7RSRggaYGD+3hVJivR9fygRvw6czSM8xTJ+cE990WMGdf8pVCP94vfdIZ3CF7fIJG4CB83+5Drw9ltwK9exqqf+BUcPuyVDu1IfX5+jxfGAlHAmN/oOBdFyX5p4z3XY0QSy+CoQ8Mn5/lREQxs4fFSXsMKSFloBEjjKsqjZKlwX87/zBWoQSG2zQHsiecmv5cJvKqlfZjsSHOgORPZNQjv0JNJGly7odUPrMRvywDWpxN+8ntwZFTzFiaps/HYsT133XsBbN2gy3GLfIgWlAcFMerSUgmGuBAVIIPjenGOv/gIJlnzAwSq+K9q3ZmWB0aRWBvrEOP83TgBaY8JEO6ZiCx3pH80gyIFEjjjOvNLN0uGdFo02wyaKQ9schl3uX2rvVbcmyIbMW91AbwDvg0x+vcr7I/AmUGyQM37BzomC9YNaTDxQfNP3D6vGAk2Ry5CeEMeA2qyN7syvqOCYKOp8vLtkOpLbMzVbklLoPDC07rRpMZdhaiLir+OAa2cCcEprn2oy0Z+lKmf7NEInovBL+vcJyEGoTja8ZhFL1zWLf3u3ULbTVh5vUWxRFsiYwFDIdyaZGobGl3SfO8pAMVnJ3RB2zRuWHLZEKaliVpjqZat7dj5HaoXFMI1rMvhEuOgD78GXn288rJmsQf/pnfc1QMaiALYJFG7TErmCq2q2ePjx2sycYAauxvTXOGTyDuBO9DByx
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(921020)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gDlxTN1ZDkk8qT8KQVN/JOXdTDqJ/6RpEMHlf5/FstqOETA9VfrvTlvLdESLEUJ/7ledprWO4vTY6jcIB2a+f0/HsZMRKGnNYrYFA74EJsdWm41Cpkiyf3FJ4fCi8++D2op1JcNYKfXxnwaQZNSUY9Mzc2KCmuIhHB9xyvlB/CnVz1cZy8z3VGbVgtUComizd4KnlC0wNr3RlqUAeuMoQB3GVooyyW/1bVZSR7773QOxkZ1dwB+IOlH7rq6cvfwtPIhLd7BCSxbZJVRuNIcfG3sH3iu2iKFc0WSZwKkA/YFQVGuZsVEumRMmh15TAMWgc35hlSqwwiH/iqK3SbJlHfe0gBhXbX0d/9sJoTbS1dFbZa1RZF4R1geHMdgXurJaB0ji7kCNfTY8cHqaM2EkLSkVOpL87jyGKCqpwFZ/pc6u51NrpL/xTALWYO8KHuJX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:50:52.2904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd59f2b-a3fb-43b8-a721-08df44c28efe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156

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
index f190de8c2cea..e5ad2108a670 100644
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
@@ -277,7 +285,7 @@ static void tegra_read_counters(struct work_struct *work)
 	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
 	struct read_counters_work *read_counters_work;
 	struct tegra_cpu_ctr *c;
-	u32 delta_refcnt;
+	u64 delta_refcnt;
 	int cnt = 0;
 
 	/*
@@ -306,12 +314,10 @@ static void tegra_read_counters(struct work_struct *work)
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
@@ -343,9 +349,9 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
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
@@ -357,23 +363,16 @@ static unsigned int tegra194_calculate_speed(u32 cpu)
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


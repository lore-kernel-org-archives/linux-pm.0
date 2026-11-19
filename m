Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086842;
	b=TpdplB+1paAo0rHTihGhBa6sWCpXSEDMHvvfsIhNhZ84HfZb2qPjs9WicclekLIZZxEp
	 Okkgpd/iuIFbhZv2/Ky74GdOrVsyuKzlKastWy/7D+qH3tOenAATmASL+QzzlAIoK7g8J
	 DE5mPhoiMeK1neIh9XvbIjsA9AvxSrPqlknBWyOP+1QacBss6gjWnL3KqhddWXhTd4BS9
	 vAAUqgxBw0V2rve3y4J9wO33btpnCwhU352de6Eqxkp8wPxm3tTPvQFaEYIqe9H9HB5rk
	 QHaaLCOF5KH+24Ob2CVNTsrJX2WaV3qAwS1Wua/97KlFQBu4M2M0IWP0GfwgBGrEOpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086842;
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
	bh=DRdIvJbyWhdNJJoWfRNlRI4zPXshnh+oFezW2Q10VRE=;
	b=pWi4u4UkXe27H1XRMWkEubTvOo33JCQK/tUTh/4M6REYB1HDmrKLj0QMhw5J/iEagwy3
	 aHvqh0ZkEUsn4qKTC6ZG3jK+f31MfSmwe/vaW4F16mdWfU1CM7qxKqPYn38G+JSsxNStA
	 1bOjxbe+m7pi0Wa308kP0OC/1BbMDipsKNiFR8DaSKiZTOMQdBf2m02uoAdXo6x4X9jrw
	 J6zwZtC9huTNCQJ+JGdrv2t4qL0LIhH2Ql8598+wBF/ANVsDB6PSnMF5v0rLry3Tc9rY/
	 CYsdjvCulUU1dtVM5QdF4oaEPfnCwI42dAhM+pd8HsFOlUUk9AUIfZ429r1WNFu3Ckw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vyc41hED;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.31
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B87606A325;
	Thu, 19 Nov 2026 11:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7B87606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Vyc41hED
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/JHBSKnJ0sCg4ixDkGj8AoWsp6JsQxZBppEa91J+r5ubj/RDf8qNB8nk6cESBaIjal2uf83+F5LN4RO1nlRLqxXkTHxs0d5eRdbso76AkTz/qQFWW81tNrDGwBBNp/d738X2kad7N2IAEkBXqdlCLS3Cap+Gw7XRIH3GRngKve0zKNnu64SeC2ImtNBsfwjv57KzXbaEMdzJHBlCw+KhqNL/nQQvav55+M6zvDLT7yzdVcNZfqqa1sj0F6d3vhW1f8nZ1Vs56dEMskmAr4QyDHwl4v+xngRCRzCIbekPJFMyeATAJU4NYx4SObQmARbeyu1376sd9R+MIJPxY3pVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRdIvJbyWhdNJJoWfRNlRI4zPXshnh+oFezW2Q10VRE=;
 b=InD+McNSc/s4zEUPxIWop5KqQu2j1YjaJkpscKqEIVtJj51zU56lh+ujMV1Q4rnV17y7FaJjpA0bcsT82O8gwLUAS42S9fG7jlps8neKkOJvKXM8/6fMln8g+MQKVWVqjyRAXy5uAoqbxBTQOOLD923RajQzwhest8TB+DaxAxYCKx5H3K6BVdjJ8KiTG8dj1NEy+ISC8kohgDzd7iaQAtG9efEOl9omqbaLJQZiXWAIBFgf9GjAmkMKTvbI4V5pnS1ti+PkGJZW5vTkYGyrpf7YLG7g5wTK1FJVDFPcYcSn/aKxxRIYWrfDt4myoJTbKAEVb9fRT8Psy1DaDjTdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRdIvJbyWhdNJJoWfRNlRI4zPXshnh+oFezW2Q10VRE=;
 b=Vyc41hEDhVvt5c9Z0LUpszwKNSNMimKsvlu7kXP+B6W4E0ppmPVd5ctu0sCd4rZEdDABpgbo0/l7OBBoufj49pIgEVoUR2/cGVbmFPy7d+Q76OESpxiHlO1ek7ehXl+n79dP2NZRRCnEn0aVrCTUX5pvWmTvHegrWI77X+UdACu0MbSuqxlv9W+kZWWY0V88xGOId5Y90zaRTbvBtlxYQc2/BCTYY+sl8uBl9cGu+XRJY/7H/pAAa5cQTL6XvyMPZBjgSx1XvMv6rlJPvE2YPhDkpln+L6l4T0hbSpD8FfD3gugS3c5t0XhVFW9OlXMujRFP6xkqpIFuA+1zQVPEtw==
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by IA4PR12MB176353.namprd12.prod.outlook.com (2603:10b6:207:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 11:13:58 +0000
Received: from DS4PEPF000001C1.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::6b) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 11:13:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS4PEPF000001C1.mail.protection.outlook.com (10.167.23.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Thu, 19 Nov 2026 11:13:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:13:41 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 03:13:41 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:13:36 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 9/9] arm64: tegra: Add CCPLEX cluster node for Tegra264
Date: Thu, 19 Nov 2026 16:42:17 +0530
Message-ID: <20261119111217.902071-10-sumitg@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119111217.902071-1-sumitg@nvidia.com>
References: <20261119111217.902071-1-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C1:EE_|IA4PR12MB176353:EE_
X-MS-Office365-Filtering-Correlation-Id: bde9d5f4-5951-406b-d9fe-08df462e3503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|23010399003|921020|10067099003|56012099006|260925022911599003|260925021911599003|11063799006|260925021311599003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	m7LOM8uKu+7lgSnof26AmuzWk8Oj9wHM/x+myGO75HdZ+fFweF6NyjeSXQduLxyPtPp9VcxVoacDBZUtyDDIIhr9VvcTDD1gyZrPtzMX0O5fb+KgRb512T8P3mJjXIYDVwT1Cz8Dbh1OnYw1RfrnrD16BnXhwhicUjDv5eqziHuu3ZZrUSCDe7nHQ6H7eMmebv4s3+VfgFtyoRXgIEeq4obv36OuCiKEuzBz+7ExcHnwvrgSC/AiG27458ab87QQf3Bb/RQ1ZVoRIZxrE05EbVoZovmHPOtxB04uyj8F62Zme9UdIdMcS02C1Ic8GxoQPTaq/q8k+ri/pv7/v710ASl8uBeUUM318Cbx56VMFLFGJ2pXecI98Ums2OMWOYK+SbuYlqiOdvQm+L3+Y739vKXNrhy7zmn85LozxdBA8rNNuv+9zlLCptDnPX1d0waVukyT8QaQrSfarJWUnUb7wQp1/+NRS250BJN9CrvC8pZtMACbIP6Gb0HcwjNs/v8x17WVnTO9jd/j6giIETmShE8AMzfhZ2jc5vV8FiQSkCsBfpg8StpI+di3ke3gqyVeGrb75isbAtjEhhvGY4hHYiHSi+r+Oe5TOCu+Uhuqv4Af/tUIvoXDRixURljybleoKPRNTYI/SYAu637Lj6k4hYeXtEDrxp1+PkIbmjT0EBwnm5PpwtruukBbvZLJzpqz+Ih2kalduIqnZPhV1rFXJ5s+qAOPTRG51+qgDoM0zOyTnCf0aPdPKw+DltQ5QKZw
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(921020)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(11063799006)(260925021311599003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gYvp6QTvTAuGVo0JTuscqvayTE2DjgYJIAZdECo3XX7G8GjtnesyrpKq7xbeonQqZa7P3Jd43BR0EXj9B40BNqnfjv/LpBCGH2dlqvYPzC3tbxEyXnS1jKNcj+eTETCKLAYrTsgyTJ03eHWiFT5C9h3Ka1TyYyloOXEs3WJ8yhmq4fYiM4Ydg55zx6vKvNqRlhIYTKyQFPPYy+p+aNR9p8RNAByE3Q/ZCagRQ5sHMGytCeyJccJVJLGf8qntuKHbDzC/q1+GVMzfbXb5Zms7mrJ1D/SxUnfHYaqQseKgW9V+KwCdftlFP7vdLi4wJ99Jiv6i0oo56w2Frra4Iq3LjcWSJaAtosm3cG8y7NjX3zgZBwO1a6aYcz/KbHHqZBRSLnOk4MNLxYIgojbXaKUE9tfO7ke6P9rZrWlAkWWpiAwIRZaVq7sDu9fCSdQ718u7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:58.0466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bde9d5f4-5951-406b-d9fe-08df462e3503
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS4PEPF000001C1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB176353

Add the CCPLEX cluster node under bus@8100000000. The cpufreq driver
uses it to request CPU frequencies.

Add the generic "performance-domains" property to each CPU, referencing
this node. The driver uses the domain index to group CPUs that share a
clock and to select their core_freq_req register. Each cluster has one
CPU and two clusters share a clock, so each domain holds two CPUs.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index b7f6b649baab..9c5d8d4e1d10 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3964,6 +3964,13 @@ i2c12: i2c@c6d0000 {
 			status = "disabled";
 		};
 
+		ccplex: ccplex@30000000 {
+			compatible = "nvidia,tegra264-ccplex-cluster";
+			reg = <0x00 0x30000000 0x0 0x00cf0000>;
+			#performance-domain-cells = <1>;
+			nvidia,bpmp = <&bpmp>;
+		};
+
 		gic: interrupt-controller@46000000 {
 			compatible = "arm,gic-v3";
 			reg = <0x00 0x46000000 0x0 0x010000>, /* GICD */
@@ -4382,6 +4389,7 @@ cpu0: cpu@0 {
 			reg = <0x00000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 0>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4398,6 +4406,7 @@ cpu1: cpu@10000 {
 			reg = <0x10000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 0>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4414,6 +4423,7 @@ cpu2: cpu@20000 {
 			reg = <0x20000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 1>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4430,6 +4440,7 @@ cpu3: cpu@30000 {
 			reg = <0x30000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 1>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4446,6 +4457,7 @@ cpu4: cpu@40000 {
 			reg = <0x40000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 2>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4462,6 +4474,7 @@ cpu5: cpu@50000 {
 			reg = <0x50000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 2>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4478,6 +4491,7 @@ cpu6: cpu@60000 {
 			reg = <0x60000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 3>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4494,6 +4508,7 @@ cpu7: cpu@70000 {
 			reg = <0x70000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 3>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4510,6 +4525,7 @@ cpu8: cpu@80000 {
 			reg = <0x80000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 4>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4526,6 +4542,7 @@ cpu9: cpu@90000 {
 			reg = <0x90000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 4>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4542,6 +4559,7 @@ cpu10: cpu@a0000 {
 			reg = <0xa0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 5>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4558,6 +4576,7 @@ cpu11: cpu@b0000 {
 			reg = <0xb0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 5>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4574,6 +4593,7 @@ cpu12: cpu@c0000 {
 			reg = <0xc0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 6>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4590,6 +4610,7 @@ cpu13: cpu@d0000 {
 			reg = <0xd0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 6>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
-- 
2.34.1


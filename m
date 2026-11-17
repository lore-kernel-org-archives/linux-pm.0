Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930716;
	b=J0xdr+pWS5XUkbvTlRK2pL3kj//XCygJGcoNHGjW7kFdqIktXrltBamKabw3K3iUUHLP
	 AFGkfvRJ8eDmrpy4ETQINuK4GqXB2XIMdj2wMS7e0pyUdFf++luwmuYgmx1qmQq4bS5cd
	 HRDqD4QCFBrXV0QX+sLg0SfQPU2bu9du+20huXBr8TaA0rdyyHaI+ejLDGrpTe0fIpHq+
	 EUtK7MJrx5tirnhJ/Ejhhj/EIZhJoe5C/7qFVTDthoGe+VfrtiUl/EL8siAVuf6xVfnmR
	 btAd7V/jTxy4Z/Df1M0ElwKw/J1lOEXcXPk9hkQr/Qz3pphKBX6z/uNQP+/L5srM5ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930716;
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
	bh=DsWwyPG1QEuF9oe+jUl9x2XNEiVgvtmUUWP8R9ivLD0=;
	b=KH7JuRmcr+E7UX45Pk9o3pFgxaYDbW8bG9ZgvLuZvIn55StGKAtYb/K5WEqAJoZCJvl1
	 fSlX5O5iIQ7CcEuShmoPYhrh5vL21fKIKJzbfMfFjPJILRcax6cgL5pn5EQksmyrX3JTf
	 OA9yE56fFiWBvDHMnfYDEeEP6YnoRLG4OuuwvMKLD5LSsomS/W+5hzVho7q2UzdHlCHAd
	 lxFEIKpOlY9m3BebxhKc1NYZ2I2ClqCh8sVF+kMujEC4msDrTuzpGF35LtpghySEYSll0
	 PxYtCOat7g5oFDE6VPj87bNKGdyuyg9fP8Tq0Hr9JgoS+p+1jP9vlxf9Zq6BuOydRrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aOX74UEP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.62
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010062.outbound.protection.outlook.com [52.101.193.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56467606A330;
	Tue, 17 Nov 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56467606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aOX74UEP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TztJbb99vnHT75T0xWJWT21KsHpI6atEr3oQCe0vRFzitZiU2VxLvq6q0FYC/vlSG2s3kOO1xKUpAsn25bgjww9AJKTZjSIQoVfppjyX+vnK5694wOdAiJO6po9Ex+vDyofVphRtveRbUwztsU0Ld/h4jNBzINsWiP66HydjbbV/IA7ycxTXGXtMGmgF0dbZFxrRYjJtRetcFkOuHOrXws7XbL0wT9AFUCuoC5lS3+3EK+F/9mMRRNAw6hwLszJ6eVEsLIBvSmPk3xkBKxzufsDdx3vUSW9JtMzK+7gGrjvw3HElvOAjEgjHhPZMynVFrTAPi0H+DbA5G3Fiirx5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsWwyPG1QEuF9oe+jUl9x2XNEiVgvtmUUWP8R9ivLD0=;
 b=ac/U9+ejQXhHLjzxetz/+eIRmjVO8nwmtdEvTPRnEOek/oEoCLoLfNhTu3JJkr5mCYBOe7hq4x9XVooW6toQYynOxrBmaWxwezeQUOCxR1ZALmrCMf1gYWWMPqTBi5f4K/2xxFlYv46hMavIBGUgYOXp3VOZjR3pB5ztgL8zxd4+Br2cYrtFdiWkuyJtuUfFOzujrJ40hCWxZrPui9ELcIZCfsIWJE/dmyetOB/MH4Q6J57tQiIZAAvoxcfvDDkVYMmRlQPKU96oCFhl/6K792Rno7mH6pigIFItSzbacc1DkE+A0Miuy4kSEl9qmnPrTN2+7Mp2CamEgRNxgEjFBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsWwyPG1QEuF9oe+jUl9x2XNEiVgvtmUUWP8R9ivLD0=;
 b=aOX74UEPAgIf4OW+5YwL6qY5/in1OD0/EnryIp8O3Ru4zHuA19FYnpdciCnNYwI1tv+pm7/AVC6lzm6dj/3uzEqotDxhv69ktBLI+BdpADi1I5etgmsk4i4j4HWW9aKdYc89SEXRJsbitTYtPHwTg4wtxFWt5b2wwF53rEoH+eVM9/TU7ULCUXdEyDdi2ZLM2jM7ehtNiEL6wnhOpHBxHmabYz9JbK6jgmyqtKswlLA9pkZ78Befqh+oRIIpBZCy8PzJV6vpN3VMg58l5YT0Zt7JnD206zRGQLPlG6Ot2a2LtnRpw4T/M5OK3ikF/8aSKMpF+7Kq5JSAg1Stupi/LQ==
Received: from MN0PR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:52f::33)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 17 Nov
 2026 15:51:42 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::3d) by MN0PR03CA0027.outlook.office365.com
 (2603:10b6:208:52f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 15:51:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 15:51:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:51:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:51:13 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:51:09 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 9/9] arm64: tegra: Add CCPLEX cluster node for Tegra264
Date: Tue, 17 Nov 2026 21:19:54 +0530
Message-ID: <20261117154954.625126-10-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8555b5-b165-42b1-1208-08df44c2ace7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|36860700016|82310400026|1800799024|261028144727099003|261102123227099003|260925022911599003|260925021311599003|260925021911599003|261026140227099003|261021121427099003|56012099006|261022105027099003|261009223027099003|11063799006|261026121527099003|921020|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MwNdeRgYw2GM/aOqVUBoqUKG8ZmVDLNR84KryL+0TKxUv3n2ion+d2TNeflo/29aleMDmVyIkWzX4YbNX76uIlar53Xt0+meadeqp1WssfMYszpNPnX1LPMCFmezon9SpCVa1iazcXw0tmSHebsGj1cRiE136fEasl8hxGl3UKqDECeWiCQP0DNA0l5DxNWAf99gEiNSbbbkM1B8KLXj6T5cexfbYFrOXY1gv+0ivIEUtPqLNaqqMTiqlZ6HfPKD7n/G4nmkyoM/2888rutmllFzoMfqVoQuT7Ua+nN0n8pZoFYSg80OZFml6n/LRcyUlRRrqaqOGimvUuB2lt9/NCX8h0e0Mt9WzuHKaXSmWaYy2AVose5morniwxkyq1XGqUIEElrv9e5YkuQN1aemAiVQb9RSorZzMPlSHd3s2AGVzw8eWNs21Azrxd9mp5qGFNKw/cMyrA29HKQKXinn711dMQ/qAAHA1ZYXkTAOYRR9zNTWYCzz7Emh4DVs2KP2zKmOw4KvgGjGhR50KR5+VoPTyWZjUMjwu87yMbfKxgUC7JXNXcIrbzpG4wJZUX9TblxKOoukNrrv5leZ5Y5fxIWBckiBL9HIzQH3l5p0qzZBTQXLcBaL0R+6HFJ3dS+Wzg/ktEVx9FDrRQBDbla6OGFFHRGgKLOsEHGdH4DfCcxhnEqVbTBAc8p1vHcHTbxea+HKtFJR2B/6D+UuIKkDMzrraRgzM4vkfyOJ/FxKWOuewahKJeL8bW3VLKg2PHDI
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(261028144727099003)(261102123227099003)(260925022911599003)(260925021311599003)(260925021911599003)(261026140227099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003)(11063799006)(261026121527099003)(921020)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bL9tvUyTllkcG3B/lq5QchpHYZ93cnvg3NQoOVrf1rMIj/ItMUvc9+Hk5Rb8Hz9BFPIcyYwlxASh/5H7NLuMM4ccSEvW8KkA9FHm8Vv3Z8qnTKnMc6jLd/PR9gZ0PlY/OC2eQMfayKJvBl/nMifbAruwYox6nekBJo3HzgAt6CgQJND4tGDTKIysKWcLqjRkgEBxzzkUMMpY4NZOvNIOTts5HTKzz1sTHTOEl6pJIByaqX+IrWiOHuiTFw1YF+pwnj0ulBqOeLCu11X0rGEvYSnbu8u4Qoc1AshnywD7tyqADDThC+oCHvAvfSQisXhVeDxfCqU1xOzG6Zo8ir9Lt6tHKEkuugboaBuPn9Syj+TnwGJU6S7w2vkN9QrgqJWsGthU6WHELrbU9oUXsr9sqQul8n7tJun5c8J4NCYSZIzngvR3vW8zuDAkWc6sW8az
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:51:42.3384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8555b5-b165-42b1-1208-08df44c2ace7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987

Add the CCPLEX cluster node under bus@8100000000. The cpufreq driver
uses it to request CPU frequencies.

Add the generic "performance-domains" property to each CPU, referencing
this node. The driver uses the domain index to group CPUs that share a
clock and to select their core_freq_req register. Each cluster has one
CPU and two clusters share a clock, so each domain holds two CPUs.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 5ab34cd09a3d..10ea51802e8c 100644
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
@@ -4384,6 +4391,7 @@ cpu0: cpu@0 {
 			reg = <0x00000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 0>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4400,6 +4408,7 @@ cpu1: cpu@10000 {
 			reg = <0x10000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 0>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4416,6 +4425,7 @@ cpu2: cpu@20000 {
 			reg = <0x20000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 1>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4432,6 +4442,7 @@ cpu3: cpu@30000 {
 			reg = <0x30000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 1>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4448,6 +4459,7 @@ cpu4: cpu@40000 {
 			reg = <0x40000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 2>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4464,6 +4476,7 @@ cpu5: cpu@50000 {
 			reg = <0x50000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 2>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4480,6 +4493,7 @@ cpu6: cpu@60000 {
 			reg = <0x60000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 3>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4496,6 +4510,7 @@ cpu7: cpu@70000 {
 			reg = <0x70000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 3>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4512,6 +4527,7 @@ cpu8: cpu@80000 {
 			reg = <0x80000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 4>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4528,6 +4544,7 @@ cpu9: cpu@90000 {
 			reg = <0x90000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 4>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4544,6 +4561,7 @@ cpu10: cpu@a0000 {
 			reg = <0xa0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 5>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4560,6 +4578,7 @@ cpu11: cpu@b0000 {
 			reg = <0xb0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 5>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4576,6 +4595,7 @@ cpu12: cpu@c0000 {
 			reg = <0xc0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 6>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
@@ -4592,6 +4612,7 @@ cpu13: cpu@d0000 {
 			reg = <0xd0000>;
 
 			enable-method = "psci";
+			performance-domains = <&ccplex 6>;
 
 			i-cache-size = <65536>;
 			i-cache-line-size = <64>;
-- 
2.34.1


Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816214;
	b=htRrHGS/FnpLAyo32cpRJ9IycNbZshN0woxFElKKKv9Q+H107w50f4VbVdB4FyAhhvsO
	 CtuQU9jMBd1Vr91BfcDfYJPh34u8VJqRDjL7TOhdbaK7BSG8Jdd06TTxdOpEwcXAe2zhW
	 bwqkF2oS/1e6ZcF6rG57BrFtaD198/z/i8FEDUYZUtMJzfQxE7U5BMIecaOycT3bS9gp1
	 2LoQzNxYY/EGSKV+29nliWI82utQyc5INQYAI0boAbjxVA249i0zHU502GfyxGOgfGDXi
	 qoFFlqnguFT6UzLUPR+Y4hWRylL12CoZgKmCTs7vyaodxmSXvXCW30KgM/XCIE1wfLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816214;
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
	bh=CuSIrzMtDbBI6UKwx9Pe2jMjWP8ICoQud/3wTvm+LNA=;
	b=nR308OWKACUve5mNiZNc4b0lk4mmIDQZzaxGQ1P6pGdlf/Rxuc3UJtd7hjkrlUd9oLrv
	 lUGqLNgE+r+5lEaqfKIOvlvUqpytyHH7nHtld+jvKws+Zr1lXRRoohavUHmhgUPJ9IuLz
	 o/44f2/VaoscGZfBb9PQkIcIsRqnKshStcEpdJQHun1SRq/uCGANJTxtHVdrZyI7Tghsd
	 21BM4fuyZOuFbT0nSOH3eQr5T45fLcURtu/s8WF4YqdyHP9z80MDUBKumHlilYBA40XF4
	 Zj1gO0rgtfi5C+EZ20ddIDZXOvTQ3E9FBMbS1yLtcvAY1BoZBapigqD1H3C7s70sCwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MMviAbys;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.66
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABD606A337;
	Wed,  4 Nov 2026 18:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8ABD606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=MMviAbys
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlCKwtuYwO2KiF5U+I/esjbEkl3x2wM4dySZFdz3Jt8xZKXU+52PiAm0ezNHPGzlpOGuGUTvsYVsWcqO/RxFKtxiQkuLDDTaCa3V7qO4oB/sPf3FOQJHJ4dFS1YX6dlvMVS6FmpHVg/nlHmxTpgN004DubtrMZVtTtl2OrVlIMeKCokuE4xls+Urf3ysD4pRoPUNVoH4+aYLK2jUcUmR2D+5aIhMyVLzhILsSH/IfE9mcV7qjDlpxG9882KwcagrWinGLjlN8ZxGJbeSf3KKqlDqgbnKzjWg1k8GyXEQpOkNtv6wNJGve8yekTeMwtRTRkumd4APwRc37grlM5gjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuSIrzMtDbBI6UKwx9Pe2jMjWP8ICoQud/3wTvm+LNA=;
 b=DVUmi/sNJlSY+wzWs15QTeFKMqaPat+zy75XzCn7b/1wL3gOxmACmOIEEFOQj/fZ4f+fSNaqJYAnLjLRqnfrfhzHQZc4eXImnf4SIyztirozwsFB5JkHVAs1OBD7bOmly/a5T2lduW/KLhw27SWxaWkf1lzyeHoNRZaze/K/l31OcifBqg8ovHV+TO0dSzJSqd58yuOnk8qINmyiC9eOWSyzLsm5XqDZc0TNZPae4RBOu83sg9kXqDK+5KD2fFm0NfhyoWwVv41VK2Cb5yBD4g+GOYdMHss1CzVqymEMwJM7QveCfW9RD0wnCyYLW7Folw9pnYtBmLz3kM0FcrhpfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuSIrzMtDbBI6UKwx9Pe2jMjWP8ICoQud/3wTvm+LNA=;
 b=MMviAbysoyE6XD+gBOidGrIg5uJUJ31OZiHISNejT8DyHqwXTn7z3y9H5UGbpE2YAgYzV3UBFYYo3QCvFCDnvb/X71lZ034yY7T9iOK+s4gEicCNE87dpuViDwGGy0xZhSIS1xGt9z8iQgqss0efePO+4gjGfV6+wSRUFWOZ1+9VTIIiZrYrdt91nKsYDHqFADGffZzgcjzAvfUfOi2+dpM6jXxJ9eGJ82jA39R2AmDejw1ZzaB7RH49m4PuEU5IMPgiBhVATHfuAUZ1YJgbq+wUKfaRO5j5TmTtv0qqHE/9e3B6+XCXLEBc8G2IvaDozVmqaKHpFqaAArsOcil8bw==
Received: from SJ0PR05CA0161.namprd05.prod.outlook.com (2603:10b6:a03:339::16)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 18:16:38 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::54) by SJ0PR05CA0161.outlook.office365.com
 (2603:10b6:a03:339::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.7 via Frontend Transport; Wed, 4
 Nov 2026 18:16:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:16:21 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:16:20 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:16:17 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 9/9] arm64: tegra: Add CCPLEX cluster node for Tegra264
Date: Wed, 4 Nov 2026 23:45:21 +0530
Message-ID: <20261104181521.3003578-10-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b016231-7571-48e0-278b-08df3a9fc49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|10067099003|22082099003|18002099003|921020|56012099006|11063799006|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|261009223027099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	VbIqoY+F0yeQmBEDCKRc7eeQhGA/2Uve4VlDGDc8esZXp8cY0BIPsS75xGaUEgQkfFob8wwFI3wo1X+uwSKlXQ2WLYoPxYl0ICt8Ak4XZdPZkpIneha/fxcwjbsIxMlB0+kMD9YBTwRxswBQ6flvIrBMwwcZy1u1you2XMXENbWGt75/jJaVOoVb+hvOJ5uSYScD/++imM6YYAGGUkCXjYr70WRTxFFArsqKRHcgnmQgOSlAox7ZpiX06uEmo1catjexJ7xIUEz+1sG30FAFbOXfE1Ri29o+hoFlnL2ehxAYIM1OnNaxtTI4So+eklaW3G75nOtHOZxGHCGer0MV1Z7jmBLbTQ/PZgXiCc/KfqsyMobTdXxU/UaBunEnpQ0sTx1VPuxtG3d5JlEOCtGBN3MbThi9NGR3d5vZemTQ8Ll1bwDr1MA0BVMYBzS5SwyoyanXXlq6IKKr350f9GYYPGPKfmCgWvYHVDSCiehys+9o50tcDphMpbEZGi58HSnot0P/5HMUd/OrzR5S9oKeY2Utv3okN88xaWyUNef6MBkfP6GKbSH4Kt9adDaUNTQPIzGywBOBOxRROJHQ8qBnZfaKq5UbrjFn/ZAnSN4RT6ZpXnzhl59c5sOBrgHYVt6vrMuA9Zczh9a0Y9BzO9HkZqRrk4ahDZefUGkF0K/AJkaCwdnWGBlEJJw9Nane1/rOLxyXnnoalUN4QLIC5Gv8atuoNSG+0WpjLgnhAlJMh2fuu64rl5GJ6SQCfAPNHoPQ
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(261009223027099003)(260925021311599003)(260925022911599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wa4q3ftIBfcShMtkhWVub5iKPKNHzisKUd0e8vlsVuQbn1nhRei3WnhHLwYSeXreOy5fzTyN851NO0rtvyEcQRgqdMvf3021H4dA7f4TrPh2pbSRlOgJa4zQlwLvFN487I/uz6WjAkhA144DLJkGz3LfNf0Q9YE1Q5dxfWEsiCqCoPjMRFSVJ4S2VBqJbYfPWM6JfSPoMs+ruA5ro2j8kzN4JkSJQJw1n9k6XVjrbVHUGO1hJCrYYO7d1erZ8s114/g9+7aLt2hWA34y8P5plN+5tg5x6et8twtnRhSh/uZpBzF+iiDZl9jlb0zmhfDoUycTEYsWBfhC2eyJS1Wh+HyVpP6vUsmL59TEHA06DZj/s8nIHyBz0rGJXA93ZHOoJZFWHp8UXVyX51QYUD0p8Ppx/bCu/T8GevKMvhnTvoTmiXvGFZFm2pv1OATVzIrw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:38.2534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b016231-7571-48e0-278b-08df3a9fc49d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649

Add the CCPLEX cluster node under bus@8100000000. The cpufreq driver
uses it to request CPU frequencies.

Add the generic "performance-domains" property to each CPU, referencing
this node. The driver uses the domain index to group CPUs that share a
cluster-clock unit and to select their core_freq_req register. Each
cluster has one CPU, and two clusters share a unit, so each domain
holds two CPUs.

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


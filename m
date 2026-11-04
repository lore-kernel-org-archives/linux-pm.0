Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793816185;
	b=ZVziuxPe6iA9mPuQzT7osF3bRUIJnrgqfpgvIr2jOmJSIgPbh9zZ71DK29ozUyTs2wCi
	 jMXO9jfH4ylfDd0LCegPlrinjcyrug5MqqnYuOkaPZ+d07xl+RAmq0MxutvMrs9P/xmYR
	 mE/cmjHC0VHPxguqR49S1ObwNddowibDQ3O1IrzLLFQ1XWmzJAlPjr1HHPMDVEDMhfj4X
	 Dg2SglpUmt68bJLzWYjmgeVbn9S2EBT7qC1N7Xox9ryGTDftN6ki6WF7UUY6ndmt8WOpW
	 0x7BZBFo6Um3zJ8qQsvdRXfn/xRliK/AkVzBpjosYriuNIJ676YbPKiJuYtd88djNvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816185;
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
	bh=CvGWO/kDUMmOU2GY40k0xEBgKQIwh89sbvAY/4LWj8U=;
	b=A36aviIr9mQ6lszBc9wpMXXJD322sYRvKaisPvuEHQTqRzmEOoJzlYoNsBAz7w9hOw/W
	 MZnHCM3qgyfQuOw2gkJz993W5K3ntOozGMcWMMmjAiqJCW8hJckprOD2NyDMJt37EXFoz
	 S4wGMK9Cp0bJy3NY3ddHWZeLM62guu03BHJv/8xsOtMrXxnJISD/au6eY83PDEEpmXt8R
	 ss8iAtuy4BhA3Zx0+Rh0w6bQJYU/j6DAJ0dXa4fIudU0bPSSakp1SYNGHq0PjnjJ/N+TF
	 XVnHahwe7nvuA1cMfOmAmoCJ4whpn8Q3q7YA73vegmac7MZLxaV8sqqnxBhNHZ5XkdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lAnIaNE3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.59
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638D606A328;
	Wed,  4 Nov 2026 18:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3638D606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lAnIaNE3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYuKHAsFcoe9KnhTf2n8gfG2kCfR1wh/X8gPokzTOm84IsZZptwb6qrIjAMRT1fCh8nRteuWn9ZVTf1ZBj6jQbGBisKupiI+UT156H8MjTaXNKaHRZey3ByhqgJLFcvRdT5F0GBAjNQJ4Vz/cvv+52BMUU9m29bOi+R7HRk8eGByAkKZlLIMn3y9nXa8OCIWcVZK9Z6nZ5+PI4lFQuCNXyXRBq3b6E9QMIxsBiym0/mHvATYVAY8D3ggvLrTh2aBUWvkuQZOkN7zGwgn/Fw8xguNmSsvZzZVFK6s/C1ptu+3nhpkd6HAXJangYmYtmmHTcnUPx31/FL9YPxYt+VaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvGWO/kDUMmOU2GY40k0xEBgKQIwh89sbvAY/4LWj8U=;
 b=oNJj6JgZlj1rBxm7Knxs7g8rzq/3SX6gRUNJ962C40839WEWJHxPDk7ZMwJkvKX7qyIqDqaH22E8afvTHbC6S6jVMmr5svNTOGamsp8TRxPdcH2vDNTU8zUF81gLwPs54FOSdHr5zzytGpmt1WmgkoiMZON4Gl6mfksIJVCCeo72J2Uh6UM8GxdSepdykqibXvheH371JJUQffqHzbgoMcp1OMqOVATT6dQwu3kKKIQjMhOYMwXjrkkSQaczMmxykdMSOqjUsF//RHO2+xOMihE6VHD8jh1ntBp8mgxZCGruaL2xEKYrx5aaS2kdN1X1LX3VR1LMWfyFKpCiYugsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvGWO/kDUMmOU2GY40k0xEBgKQIwh89sbvAY/4LWj8U=;
 b=lAnIaNE3X16dYjgMgte96TNZDusvpkyvcAq9SUOFyaAz/ZbathuT6fGAE98vQsTDI6ezPYWkD9D4DSaBFrL6Wrc26cPptr1URDiurzQ9DeDGy+6uTEWg2sB2WhpV10UgbO5io2UZ5O3jB+PZMgqu8DuyCeyCBFm5nJQYdhIeiHQPy2DVFJ+0UCD0kX2FrRqPJumQVR3RbX8ghi/i5cdqt8owoPX+1ktvb8FCLttcUjAqZQeVUS8LJ2x70sWzYnOFsdfu8qt/C6lLKkghRdoEhvnVSc8oBATGm/HDWzK3s6FDFJTNfPs20dn/9FZGCCXv5dAWf6dbpTI6/RW+uDWvkA==
Received: from SJ0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:a03:333::13)
 by DS6PR12MB801076.namprd12.prod.outlook.com (2603:10b6:8:417::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 18:16:19 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::a) by SJ0PR03CA0098.outlook.office365.com
 (2603:10b6:a03:333::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 18:16:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 18:16:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 10:15:59 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:15:59 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 4 Nov 2026 10:15:55 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <treding@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH 6/9] dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
Date: Wed, 4 Nov 2026 23:45:18 +0530
Message-ID: <20261104181521.3003578-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|DS6PR12MB801076:EE_
X-MS-Office365-Filtering-Correlation-Id: f9234725-5e82-40fe-6164-08df3a9fb926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|22082099003|18002099003|921020|56012099006|11063799006|261021121427099003|261021123027099003|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261009223027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4Jdi9lhFndECMWBRwaMBkof7zbal79MDZG9w8o//BJRaiJTSQdfBYKK+navUj8pFUASJBJQZO/iaLGiH+T0tqwc9U267l160cwtJzCEXVnip8FnM/DVGZgo6bUIMwSEkb3zxSWT6LjFc8tcp3UDMm2Usaf+Shg4Lo0HEelP+lEO/yP4T2hqn27qXKvfL9LjqJGglb1kAUF0Ir3zSgeOI70vHM1HsVA1sVR8Cl7ZXd0Sn65LwToorUKu+sqC806UIcn7tRjVqMVpjoTfjLLsBD3dRMYBE17wFCx6tL7Yee4GgnAaSpytbpG+gxxQAhZKf9KG5KYFQB7zaFDLb3qJk09YsHS8/AqqTXXMwHOXk2GjmxcDOmgsXLX0LcXMC5QI8GyJqd3tNQU2FOL7z2m0pUekx7cJxsk2GdGZmZAEFUJpUCsbm9+rnGr5SgVApj/4xFKZ7VRJLbbPxgRb0VvswaqPLZD4kzgA1bmv85kUp5UYy1OhtzXl1lBmdM4UV3eqVDnTELGyB75oafcq6xhHuXS0Uovvvr2w/5B6CVZ2oanrrHDbvZjKtaNucvqxvwePks6CNg+H0qj39hJNF0H7raJ8rP/4bSVrAZ2XqqGW7+6IRV1fL48lNluQl0Lje7J4EMg7iE1R60OuhqSM4L9WpR00Nf+d/26oh2ZsQvAOi+hiw1AFaDsa3vjHEDanK2/WYwTUIrawmfEQFRuHjAFbbxGog1XCouMyWW20h9ouYRfprlGLvlm9NxSS3gHspCCgb
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(921020)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261009223027099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bAIS9OKGWeU2iAAKP/EqyddfVFcU8f2IwGdJbUnlGXuNZc3tNoFkUuqVu04tZlvDYOJ/FZKiw1g5s8Fw2nGdu5/a2my4X/Xt09o/8AHxBP80Qz1QYUf89klfYkmoisVmh0O+VxZwQiU6HGfl1QX9HZw4zI2RlxHuaMaFcSwo1G+jQvwXZsLL71QeoxgtGYWWbw/rExCq1LY9r3rQd5P1XB06rPML51xkssbzKzb8HQpdBLT6dr0D/N2mHe/S/HfnV/tnZGIkY9GKJ/Zx4qamLF7CT8HIUgPg4CB2EYd+urVk106zO7KZZIlFTWOzxOIeO0+8sXp43oHmkDUr2nXg3l0SdUtWG8Ab6y6LR6jpdZfm+1TWcgk3eHYGFfaW82WY5F2tJR0W77vRRQS/IYMHklFFOl2liTJHAUMUOcsKW7nX7GWLpA959U60D0QpDG8K
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:16:19.0093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9234725-5e82-40fe-6164-08df3a9fb926
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB801076

Add a compatible string for the CCPLEX cluster on Tegra264.

On Tegra264, two CPU clusters share one clock. Add the generic
"#performance-domain-cells" provider property so a CPU node can name
its domain with "performance-domains = <&ccplex N>", where N is the
index of the domain that clocks the CPU. The consumer side is already
described in bindings/arm/cpus.yaml.

The property is required on Tegra264, where a domain spans two clusters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../tegra/nvidia,tegra-ccplex-cluster.yaml    | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
index fe9c8791f227..2bdb512fb677 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
@@ -25,6 +25,7 @@ properties:
       - nvidia,tegra186-ccplex-cluster
       - nvidia,tegra234-ccplex-cluster
       - nvidia,tegra238-ccplex-cluster
+      - nvidia,tegra264-ccplex-cluster
 
   reg:
     maxItems: 1
@@ -35,13 +36,29 @@ properties:
       Specifies the BPMP node that needs to be queried to get
       operating point data for all CPUs.
 
-additionalProperties: false
+  '#performance-domain-cells':
+    const: 1
+    description:
+      The cell is the index of the performance domain that clocks a CPU.
+      When present, every CPU names its domain with "performance-domains".
 
 required:
   - compatible
   - reg
   - nvidia,bpmp
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra264-ccplex-cluster
+    then:
+      required:
+        - '#performance-domain-cells'
+
+additionalProperties: false
+
 examples:
   - |
     ccplex@e000000 {
@@ -49,3 +66,11 @@ examples:
       reg = <0x0e000000 0x5ffff>;
       nvidia,bpmp = <&bpmp>;
     };
+
+  - |
+    ccplex@30000000 {
+      compatible = "nvidia,tegra264-ccplex-cluster";
+      reg = <0x30000000 0xcf0000>;
+      #performance-domain-cells = <1>;
+      nvidia,bpmp = <&bpmp>;
+    };
-- 
2.34.1


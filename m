Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795086819;
	b=QZCphqXXCa4W2F2kcp0A6qyOZnI8ziosYzlIJmaTQVjdy1ZzRjapKjSemS3mof19zKXt
	 9iNUpdoc75EFuj2hooB2WeKggi26Ocy5so94Ld36sd7InbzQDlOfFkS3PSWiD1UA0BYRQ
	 GaxqHgJkJXl/HQNqdEHiXT4ezP0o3fUEHP2eMG0jSW7JWxOSQ4aX0xrpqZ/XnixSxryl2
	 b/t3CkYNXGCiKYqGzLmUWF4OZkRQoAc/IDbCFDwH+TeRUKzQ+9Fs13VHImVzt7kQ8p61b
	 WZhF7MhtWtWCVimHVs5sbVGsMU9Bi1YezKiZWCVplhy+Ss2QW5d5GaFM+lXeneNrtfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086819;
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
	bh=2grIkxeDoYqdNbSc2qUeSZjbSxG2ipLsDGIoPn5ZOBc=;
	b=s8/8glyAKxzWLar0090ibttj7wUMyCYxtwssq4NIgYe8oHE3GxPPVQ7BgL9ZrBnpb1RX
	 L/3od/frQ5sCIhqHd7JgT0wFiunCcF2S+7/rAsXJ5u/D5xuH+ER6g+yuDGaIq6RbOYDd5
	 t1u0k3Zzi9sLZ272QgR+qw/XQ/MpYNRhIAPQu6+zgjIMk4HKhjXABs7O+XEhmdqwSaULG
	 zfzuJezp/zciGCmszuEg6ujIKYGkt4RIUal0hXOB/9GbTb9gsgl5FHqXnr4e4UB/8DH7c
	 +T+G8Q2oRiwk/CM5LZsDtUiGT4Aj9kzKm9NHIgyLd5ZO8OjiMJLcxh8Si99gFlW/ihw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gQdck6cA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.38
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012038.outbound.protection.outlook.com [40.93.195.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957FD606A320;
	Thu, 19 Nov 2026 11:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 957FD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gQdck6cA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viw8hdaOynKUY0bmSUAcLw8qWZQHj2Nvrr1KgPZqROVy/w+tLXTuEAeiNLur8iZBKmdABOtRRcvMbxGBKoWSATSW31+uVCCTFxPMpNPtN7nSpOMOROAJZXiHR7NI0iCXTc55Es3QiN0I7g9o8y/BHw5n9/OUkTAjQDrJ92ZWYyLwXTU2Tivygsn/1MWv5ZQ3ZkMv8hNxWoyltLwtKZ0zObNmtUHOES5tgnXEtaBd6ysakqC4+7c6sLNOmWoB3jyIdDbgwqVWzzZyPSMWpkQL0TO+Ml/T2EMIebJGGc/dqXPepfSiB4vNfkVYbYdj6T5AMxm/dXjc1yoxaYdbxT6Zmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2grIkxeDoYqdNbSc2qUeSZjbSxG2ipLsDGIoPn5ZOBc=;
 b=qo1N17eZbIpgWq4pFOl4ysyv6MLU7skPyA2wZcaK6Ij4y2Qd2k99bcGGjXcZkrYJ1ia3UN2LUzVugNocwYNX2vzkVRvSBeiRovw0Zskar0kzamEo1RsNw5PhJG6HHux5h/EB7icf2IPqx79I7fMAaAKrP2aBARGk4Q3k7lrfr25oAfQuniWt8LpG9Zyhn2F+IaMVnhrU9AAMyfE7xnitu3QBoLrQFJLzfKV62hYxpNkCmCOs4Dxey5kvVC7BBkueL0IYy3TPVVeOxCd55PJHVqXWo1tcl9xI02bK61AkUAOjjoeVlkx5unK8xHuDfI3ZwY7vlMeVeaf9D4ZZVr5eJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2grIkxeDoYqdNbSc2qUeSZjbSxG2ipLsDGIoPn5ZOBc=;
 b=gQdck6cA9TuKhKC59cqvAmm2AU7Z6GWV3MuzQJmZAYpLt5/26VRvITPidX3ZgctU4Jl0qlPgup+1tjrf8v/aIyzypYDYAY/9LXh02vW1+VjVF5zzv822b3QQ+UrnhhGn7fqJ+0PFKvp+fGOsK5lgONAD+Tr+30TSnDFSbL12O2m1X180YNO8oYJWeG+Tej82MjtPLWHKstDqEMsNsrMn5+XM9XkjpMJ7rRtQzKtcW1gHdq3YvXaOcUJlkNZnfHTx7RoqS236EnFquuCWX9eEf3CD5Fz3w/oSMAp2O1VivlDUA6sEz9h1It+GRE8X0qGSZPntrv2LxXELHT3VoUz7RQ==
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by CY8PR12MB7416.namprd12.prod.outlook.com (2603:10b6:930:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 11:13:34 +0000
Received: from BN1PEPF00018548.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::7e) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 11:13:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00018548.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 11:13:33 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 03:13:17 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 03:13:16 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 03:13:12 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v3 6/9] dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
Date: Thu, 19 Nov 2026 16:42:14 +0530
Message-ID: <20261119111217.902071-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018548:EE_|CY8PR12MB7416:EE_
X-MS-Office365-Filtering-Correlation-Id: 360c0920-91db-45b9-733b-08df462e269e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|7416014|376014|1800799024|18002099003|22082099003|261009223027099003|921020|56012099006|261021121427099003|11063799006|261026140227099003|261021123027099003|261102123227099003|261028144727099003|261026121527099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	baUVgyToKPSYMKyy/Ddd0/zwc4hvsxskmiIbcXR/vHQDraJEgvdPz48Dfl1NW0BtikA1UxbbReLiuJwOv3CW12fB/bN8oEKjPmBVgjcmGflx5hAkkmZpWXt5gsyWAeK6L2s2OJXZtCGSFTy6pWvzRjTvwGH2ly5oghnGQ2jVcrxpVORTPWRKvT1Px8bRQdgT8J6/6qKzODpq1w3d4TuO7MtYTr1qqWwQ0aYRz/HFnbvJsrZngTvgLfBwA8vrGVcl0TbN3CSuiu1EfiS4rmU0Ox3L05piLqYWqGFsDNZ5dtMsKgCSBddQHw4V1ZRL/7Olr2duGsmoCYjfHp3LgL7O39wL9b66gQhjIEOqlyl/uROxCaJVEGR7kjzulEa6goYHZy7QuSNRmWrqW7wcHqXzFejAh/ZwQKLfZjBuw1HENvIK64vE4xMQfrG03fGb+QrT4JO0QZ+vs3E8Y7/VeVkZ3J6Xjb3VKe9adve9sVdDqcCSbWtrN9AEhygKwzXZ5Qhj4H8OlrI8V+sW5HqP3L1ua5Tn9eIjdr9ZYurAtuNuswZbtCdr44FQ87418V2Hr3FZV7SYqK5ZQlJPaWmeicgQo7kGPj7jNH/r3O3xeBd1YhnqGjmeSs4RHYKOZCe/wwlqfGYSejM7ivkb+62RHsQa937M4nFSFQ5zkuAM5gmuaFiDlFctFEzkb37S4d1A4lxcDEsgEZU7x9wfLrpEijSOGsIgcicWOZL83ExqXtTPm+FHn3bpBKkY8zaUsXYEOzVm
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(7416014)(376014)(1800799024)(18002099003)(22082099003)(261009223027099003)(921020)(56012099006)(261021121427099003)(11063799006)(261026140227099003)(261021123027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SLsGAuFisipvAXVQVCuj5lbbVwWVm7rVWsbgNzIiv4440wy9AN0PWiWKgVctmSD7EXTGl3GcPmfLII3+icExSyEm3oUQiNAGk7CJRI68jGpZzgjb2TgoXhmV0NP+4L74USTCwxUjYf4Z64Lu0v66jTUde7g5uiGIWyakMA6OAQOJ08p1Q8+biYUit2x4m+Kdr4vNwB7Sfe3znUwOFz5UmXC+8DPMNMSvCREJASRVFrOqF87LHujQmtexYBfoMSCzBw5mwH6bEgGAlbLdMgpHx2MvNMEfs0Kw1wMqK64k86VsteGokpEl9X1NNd4x/B/BUAvCc8l6phYUCAnQjjFjU/9VPxotgLhhB/DKGZ0rmgEkJHiAi3HZMN1X/zK3dgJ55GgbrFYqFh5ZScon43WZEnDvgT7Pq+J1ceGf8vXe9NWPRj6PiRCnaSdgkIAVWp8m
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 11:13:33.8537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c0920-91db-45b9-733b-08df462e269e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018548.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7416

Add a compatible string for the CCPLEX cluster on Tegra264.

On Tegra264, two CPU clusters share one clock. Add the generic
"#performance-domain-cells" provider property so a CPU node can name
its domain with "performance-domains = <&ccplex N>", where N is the
index of the domain that clocks the CPU. The consumer side is already
described in bindings/arm/cpus.yaml.

The property is required on Tegra264, where a domain spans two clusters.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
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


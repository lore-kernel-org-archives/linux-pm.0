Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794930693;
	b=ZL/4eWsOMTalXxcLSglJxlYx0JdOY5g6tw4f8uU3C07EKf4o3kjdtom9O75Xftim8b0c
	 cjqN/SpNpoAcLhOPygSdnY7R9wqP6XE3a037hH7wJtGB38gXEk0wR1YXbfyrEaQWhnpfW
	 SJgnpJvlt+F8Jnd25nfIrXdBjIljt/hYP6cp4Mj7gHh3nkaNMlUaUik7mfVH37hlNcsbn
	 GEMHOdWHYRX9WTwt8eKnFzGjMoFhoPBHcKROCA2f+sH3Y5PHzd5JLCY7eoqKoaSg6a9ZU
	 uWo235ESyWsPdRBbh/X/ER7KNyCLREJ/yGayj86iMOpDqazU5Y1ztfVX9Yt0Ctd1NJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930693;
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
	b=WutrXjRfjk1ZSSYVW2cTOrBOhJ2pezX1ten/ujQGr6iN9/lqDqCI1xAkEiS4PPzfRbTY
	 K05Q0Kr7xu/W7Q6c4vjBeV12x37RoHV8aoDl9YeWU7TiVqvs+AqAGfHZ5IeaP/wo+DY9/
	 OMI1hvj1rKqdcCtEbvi2JtpryHByxV5oA7dXK9NEr8jEq4Glpy4YwkSMHswiqxIUWwXqR
	 RksmSTDT64BbJUULRtsqt6hfWfH+ELhpdtHqXS/f3YHPmyD9ILOXJBdZTCAQoBlBROr0s
	 yRLTehOrWRPCFYy4zd67pcxS3EtbAB4QrwacA/WIb3I1bUK/7RBQTYSZKUY4vQASvdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LtHfEk9J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.27
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EB8606A32C;
	Tue, 17 Nov 2026 15:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68EB8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LtHfEk9J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+ac1nU3cibHYbnnLxj5/OheBvGyphv/Tnyi7WDCR3qjz6x+gX8WhBIqwuXRqyM2OUR7e0AP4+ljvfHVLNB/+EdOO3Kec7d+S1efWHmdhd22vFMKN66aliBT0F0Lpq9IDmFXUCkewAd8CX5lNgioDxSAhaceM1WHmbmZv3Cycgg8LiE9VTwLMiciqg4nN9o8JfxzBHpzMhiKhLuMXZYZsu5O24EocYd0oHIXnD2UmgYLDeC4ri1Try7GE7HB20r8GqVmn1ydsu1mNlnukCky7lKi2aqe5IT73tKiH8tylPcW3xgAjrtKR1PhZIO6e4wQPWTTTsVuLp2/yaAC/OhW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvGWO/kDUMmOU2GY40k0xEBgKQIwh89sbvAY/4LWj8U=;
 b=vxKGLZIctOJbux7uXHbeSi+eCWW7KJFl01aqFUYinhhdJ/fJ1UpnDubo+5eJyuJkkfV1rCqLhYJMjM2Gws+rSLwfo5M89y3rmK9LTpx/VYxx94k4mcLrQZK2iSBdtsiyimiAO6wVewWN1IIhXMqWYwv+Gn26qWs991EpPSpLTgfLcfEntJfEWOOGCTxGW5mfbwJswNDVwfECbWVfRrfAyEpLkIiWvOFQiiCH1LmNv44mjpyHZlOi2HRyFjokl2goEyXl5RU7V0i8rZXlun9w6VsPvQLb9GcRAjPESBOn7tEZjq/1amzbjGQTkTeHC4HqcemMujEmS4FE9ZYtGmJdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvGWO/kDUMmOU2GY40k0xEBgKQIwh89sbvAY/4LWj8U=;
 b=LtHfEk9JAFhZmO+b+agHsM2rrn/GP8Y96+iSM/HMratCsIUmzQdJgnZW0txJUHbwfWbO9wWyO1LsDfO3+ObZ0x8W5655YpNhQpbfWNd/wV8IamRz7C218i0pS6raAS8IAN9KdSJkkn32mKypoE8UebUFQxQKZTiZD5sdVImN4qHF4APH0WIYjsWkpUn5JOg80xYT9qZOiR8ZC5vwQI3vDHPIa1jtGcAJE2GyiUKasaT4JgpdkrnhotEJ5s6fmDYIPhE2jLEZUd9qoEh7ewgQwhXXgVsZIEMKCPROUgCV8jc83XnD5pJp4gdKiP44J7n5Za+YMadDIS/RejREn+fxNg==
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 15:51:17 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::9f) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Tue, 17
 Nov 2026 15:51:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 15:51:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 07:50:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 07:50:51 -0800
Received: from sumitg-l4t.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 17 Nov 2026 07:50:48 -0800
From: Sumit Gupta <sumitg@nvidia.com>
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <zhongqiu.han@oss.qualcomm.com>, <conor+dt@kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <linux-pm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <bbasu@nvidia.com>, <sumitg@nvidia.com>
Subject: [PATCH v2 6/9] dt-bindings: arm: nvidia: Document the Tegra264 CCPLEX cluster
Date: Tue, 17 Nov 2026 21:19:51 +0530
Message-ID: <20261117154954.625126-7-sumitg@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 562623ba-2cf5-4c35-4607-08df44c29ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|23010399003|18002099003|261009223027099003|22082099003|261021123027099003|261021121427099003|261022105027099003|921020|261102123227099003|261028144727099003|261026121527099003|261026140227099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	pCLmCRi8MWaD6p16f2nMxiZINR/tCpnpE7P22B1ADAb7nYQY6a3k2ZI+96GZnCttKnYyjAwZIhtNUMdAv1xnxKzMoSYpMwYu34YLdLNxT+DxqCN+65N0fTluASOH5JcHPepf3NoX2Q5Cn5odCWtJ6R+5Iq7hMmbrgRQlCn5X2A45H4SMm9nKkELtercnpr1CGTMgLz3T095pj2GKUv1JKCHj2sj0ZT/7unkBIzXfbK/CJkd2+MwsI+oAAXzvZ0vVRtx2NONtl7DPlhgjsh2Yl+CKdY9ngI0PThMUJuBP8RZKyQ62OF+IHhMoVMmdkJmqqaDEn+3f7C4OPFg4eqCbDDKxsuYkX8CZw0HClNwEeXqsL+0duOMPCxSMMYCMWRDlvwS+3qZgsJQ1jfSDI+zVPbh1RXoeQiTewpKCdP9nD15C4DK6hHZLhbmqBIvNu3CVcQaeI8nOlHKdIiZ1kZZtDsn+K8hPCbGGeOA1+Mc9q49fVE25SPdVzp2aoQHuVBemqXCVeFExeUol+9PZHEqtJ5lkZ6KeKD2RxJ+p7ZNR8MX1Newg7/91qRL8/EIOSj/sAjCCBDLTJ8UYxiiVWHxb2ffHKBQKfNYzhwtGXy1DatO3yn7854oBgV1o9cRkvAc/skBjXIR2LxzgJfefJ1zu90FmIORWUSoD5zXCp9uekooS2imsTmykDZQCeJWz4g/SydQoEcyEw4hwf6JEfVsg/NPpiqCPpQv11qmfkTIMYupDY528v68bg7jchesGFjck
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(23010399003)(18002099003)(261009223027099003)(22082099003)(261021123027099003)(261021121427099003)(261022105027099003)(921020)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2vjpp2rYl/rhxnRVrmbxq1Oab9wh7HE4Zd3D+rd6FzFNTkWRloTsIBAU4Wm6UgdJoWYma94adW5/UX7Dg/yYsA+vIa+uJ5sQdp+kw+xihUn52t7DtY2OVUU9llKbQQTw6FPj/9Ap9rs5IARusane6BDUq/RD4+bepBvDnNEKOtgCGrH8tp5Dc5K4l/qy4QQA50oTSdZ/ncHmfENVsd3shqfVmpc0XMwbbM5cRC2d3WynW8JKfyuKKWOGlZwgjGslMFwUD8LjsqxUQFI8p8z5lXdQA6XP9db83fqm5UTLF2Ba1xbbLbup4zxfZ6HNb98vkj3X12yUgTOnjv0CB2iDDNt2Ynbbw2pm/sBH+4hsfqv9gkisKSNzL605r7pg6RjAGwPEfk3yYXzNkAisv+Rtl73Tza174zd4rvVEKoxEEvZ7KsrVuq6/KqcZucC7/dcC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 15:51:15.4559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562623ba-2cf5-4c35-4607-08df44c29ccc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

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


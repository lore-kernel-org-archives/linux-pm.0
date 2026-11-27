Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803612;
	b=k+4wlZL3sPY+I69d194Mcpi+2lebRKeG7E9ius481xXGoVRBpXsrcR6TajtVHxP6xrUu
	 7Fc5iDe7magVAEzbAfEizwXV2FohsL5m80cNOoXWXD8D6/aUWccMsDaypDNabOQNQEvsw
	 U59WItunOOdncvKajhNDoFl/crD4BagwWQ5xlWEsPXS54xWoTIoNBqO/tKicVRQUg5K7l
	 cc+gFkpmG3WLOyFl4gPabzIH8yodSMmjGD0zXS2vuFTatDY0P8hiTWCTUOe4VGenKXlaw
	 dSsoaTv0hueM/kwtIqsgQ5B9HoHSlOhqyWImHSn937pxVto64BotEfAIAHbogPQopRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803612;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ae6TjPLYahPbfrTZ4UranBAr3CbiTEeIFv/CHK+41Jo=;
	b=3Dg3CIO5/8XIEkuhyxzt1bAhkhQnikG1rG3C5I1+R9DYY3KdvQzpxC4IoiB4uWZgjiX2
	 2rEVYUTr89mQI16oxJHe/ILjyWNXxK4hkJ+czFAiiI+g9d5uFwdvkr+7qa4MGw3mkc2iy
	 YyFSABI8OQJ/qFncvDoS9ak4rOImkB7h4nI+KPBCwqdQpnaPgrxVjoCLNcqGQfldwrkVg
	 pNQpTi6OdAYLXdeP6xjVcpNsxEXqIxe6qI/1I1z/2zxOPcAaoWy/piGBT45rK/uYO+TZh
	 VzqMbjX4ehn4OicS9TcUHbBaaGl1m/AQQD8fi8KuXlacdxV7qkwqRt3YfZ6dELICXzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kvgmQBFr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.57
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05B606A32C;
	Fri, 27 Nov 2026 18:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B05B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kvgmQBFr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcweJ1nGVWjL5sG6sZIZkvDiJxEMVTsiFmm10mNyUxVB/St0hRfxvmKfM5sQ6G1oUkNREyVkdtO4V3omWh5lN3D6a7RKrZOyq69JB3x0OMH1yo8J8y/P+NHq7V4FSRjK49jCFLM9YRfSCxx2ahMbMgazNEFdHFh3XkfzzW8uDBPp/jAoD1cs7E+jNsHpPPqXG0yZIKMKL9M369MENvSaMb+29gd+kjNxc0hq9EBQC3dt0+j7YwjDSXynF6FXQIxWzqBQIdgThadbNDB3YvZKBvq8BMTjckVsBhUVJNRiVGFMBDtAjapqWjOSbxEkMzSzUqGKZ66F7ytcOAJeBDmYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae6TjPLYahPbfrTZ4UranBAr3CbiTEeIFv/CHK+41Jo=;
 b=OC/LtJKUgbI8x0wBI/zuV3WVHbpOQe0zyBA5fOofMCXq3jkRlcFk/4EKHZMShvZz77v+MhclsprxL9Wp7NcNU5Hvyc4IJPcIF/OiBe+L7ITYKYORfmowZBsYTf28I2NwrX1+LVv1uRc+XT8f+I6c9laVaDrXnqjmtnyfN0050oxurfrhAOunUEaPNRdOoUY7X7GqaqyRhS9/vVXXRwE0efTO50CnJhxWEhUM9SOf9Su4JdqSftv8zh3mUCX+Ye0dZTzx3yluqidj+J83z/JOLttIjzD/nj8MOk3UWE3BM5GKcXdO5xXXTw6J8Snpa6jl8w38j4siyh7T71rlC9Ovlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae6TjPLYahPbfrTZ4UranBAr3CbiTEeIFv/CHK+41Jo=;
 b=kvgmQBFrxPDq/wzTz7FITB0vc6DdQCCzdA7Ti//0kOtElM9y5Tva790ZEc1LZh11nW3kfe0nxKnr4NDvWfflf5UA4hAconyhoB0rUA4sTcbQZM26tHN8nXbF38viFWw67RNyo0NHuAolMb3dWawAbxGi2iKHGL4fH8K0Pr5Dx4CpBCA0dotJWCALEtZZeA9P9lUymWOgMowwNzxWmRS8RoRbJDw6NyDjFmPoa0/e/uW1NbxdEUF7bqciYyHW3E2xMf7/nDOX9Yc1au3KiqU6cgoXO0sYqPH+F5h6dJjnG8wYZcfUhUrfYXSbFtNA1dVF3vhp1g8ZwNCqYR3g35wJwQ==
Received: from DU2PR04CA0238.eurprd04.prod.outlook.com (2603:10a6:10:2b1::33)
 by MI3PR10MB277145.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Fri, 27 Nov
 2026 18:20:07 +0000
Received: from MAD0EPF000008B1.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6a) by DU2PR04CA0238.outlook.office365.com
 (2603:10a6:10:2b1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 18:20:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008B1.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 18:20:06 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 19:21:11 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:04 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 1/7] dt-bindings: power: st: add STM32MP PM domain
Date: Fri, 27 Nov 2026 19:18:25 +0100
Message-ID: <20261127191823.v2.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
References: <20261127181958.113639-1-patrick.delaunay@foss.st.com>
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
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B1:EE_|MI3PR10MB277145:EE_
X-MS-Office365-Filtering-Correlation-Id: 02cd8295-492f-4f7c-8d65-08df4cb3102e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|82310400026|1800799024|10067099003|5023799004|11063799006|261028144727099003|56012099006|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261021121427099003|261102123227099003|261022075727099003|22082099003|18092099006|18002099003|261009223027099003|3023799007|44046007;
X-Microsoft-Antispam-Message-Info:
	py6nfVJ4lFTI5sUflSCXD2OsK/AtBND1NDjmImn3tRc2ilIu7wY4TtVqYQMzzrJKFoEJVcxdKFp6kog0PD2fEVlKLEOcIIXm2uh8DX2CiyqEj6PZ+oS1nm5l30m+XUGBfhr8iyjM98cjsiN80agzg9WiC24dcBVDhJ1cf8hMrw0u6HNG/P4VTaZpvrvIv3PwTDUkQxrUCJ3eEFX1bgKFTK0RAtUXkGImXetL7LFggdX0fFRX8ikJvzaiuAgkhlXJCrQECmIsvXVrI4jypVuyrearOc2PP5MV9hBPAiSrVvFLA+f0KSHlSpNyBifmGGuALPDWDiktrIqK1OlDf2soWuxXGrN1k/K7dnTIN1ZMlie40o0LCUXFZwLKjvimBShD0EkvBAsIeQzJ/PQgGC5Coov4cgSFiGHbuHLoBerARgSBxUbYWB5mRucOpEkGGA/nUmOLNGBsmKXgSTu/yGIVBaCA9uTfCuSBIDaxyh04tVUhZHWXrHnH0OfHK1sp5gPLYrPzE49OCawKP9I6XKNIqkap5jgeNLvj5ofCrcuJwP+RIZnsI12bNJIt4+vmLiM+s/9CpTlJJFc8lOwO97JBNNVybqdOjPTgIbB1vu6zayIj1KErh8iqURcmAUiQKbk1HYUEyDB+KTARiyDM2ZjqkO2STIVuTRPh+mh3KYRfCyvguECuIOX3DG0UfhvUjvf6M8USY23zXqYp7aX8HXBZlQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(82310400026)(1800799024)(10067099003)(5023799004)(11063799006)(261028144727099003)(56012099006)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261022075727099003)(22082099003)(18092099006)(18002099003)(261009223027099003)(3023799007)(44046007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qbauDUlg9AnswWbPeFiXgoDeSQgV6HWzwq8jPHnKI4DaCB2+CCXV9rcI4xF3aDgQJhB48Ad0JAyUO3sz7B/0+gO2dZBTe0M43fA/pEDkTGGdeRpATPvvg9iVg4m7qTD85vg38s8ai5i9EdKhfdopi1OPi9CWPS9hJm2cEmT0INGZTJxjAATHO4NYZOfRXtFG+FnpdawIgPh0wwCTb/Y0y/uaClmO1YoqnqFDq3jMimsDbOOYhzqMvnXrmd96yjHxx2OrVa6CV5u4YmaroNteQgmq06pnXphIhLRdBU0QWoBrqwNc3sqoez4kP8G84qa03F6mCU9QcgkaETBUfBH9yS9u2jKS+yekNCdohjmjynotcbjXnoewMejrXHlyjI7IIUP9G3ygxKSKAxcPXITbnYvmKl2jeVCSJ9J1N4WWAuXwGrQqloZ8DrRXrCVOUgiS
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:06.3084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cd8295-492f-4f7c-8d65-08df4cb3102e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB277145

Document the STM32MP D1 functional-dependency power domain.

Some peripherals assigned to CPU1 rely on RCC clocks that are available
only while the Cortex-A35 cluster is active. Model this dependency as
a child of the PSCI cluster domain, which represents the PWR CPU domain
powered from VDD_CPU.

The D1 domain does not control a separate power switch. Device wakeup
routing is handled separately through EXTI1 and the retention power
domain.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- update commit message
- update binding description
- move additionalProperties after required
- rename "power-domain-d1" to generic name "power-controller"
- remove "generic" in binding title

 .../bindings/power/st,stm32mp-pm-domain.yaml  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
new file mode 100644
index 000000000000..b4118e1e5a38
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/st,stm32mp-pm-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP power domain
+
+maintainers:
+  - Patrick Delaunay <patrick.delaunay@foss.st.com>
+
+allOf:
+  - $ref: /schemas/power/power-domain.yaml#
+
+description: |
+  The STM32MP SoCs contain a D1 domain for PWR and RCC, which defines the
+  devices assigned by RIFSC to CPU1, the Cortex A cluster powered by VDD_CPU.
+  the devices in this domain are functional and clocked by RCC only when the
+  cluster domain is active, not in Idle state. The devices in this domain are
+  not powered by VDD_CPU and are wake-up capable in Stop1 low power modes.
+
+  This power domain node represents this dependency (see PWR table
+  "Functionalities depending on system operating mode").
+
+properties:
+  compatible:
+    const: st,stm32mp-pm-domain
+
+  '#power-domain-cells':
+    const: 0
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller {
+      compatible = "st,stm32mp-pm-domain";
+      #power-domain-cells = <0>;
+      power-domains = <&cluster_pd>;
+    };
-- 
2.43.0


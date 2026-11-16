Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825671;
	b=yYx6yitaKDQK+tjG6wd/bynWT5x/8oxp/Xx0ZCAc/ysDQQZuw56vJPgQB1aE/7ZBzLib
	 PO61Ki1xgy6uIAS91RPZ3uXKCUXNpVkitmJqYlPXxwwFw4VSNDdbKVAr8C/ChddljN4vh
	 mnppQhGpXICHkmNrpC9wkb9YfmsRfE9GvR9jG+77y0z2YAcZ+vCj9Uef9fPfwelMOL02G
	 /dYOEmN8CvBBGkKg9EFKzK/WT1L38Iay4PVfIbQn94tRW/8M03Q0tym75BDdIrk95SMlr
	 7aYV0kw34waQhfo4pHUcGiMc0YkJw3zAjOjPb+70hVXQUmzDfTJRhNY7VvRnGUbOFig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825671;
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
	bh=+7kNUG83Oj11M0j5M3QsDAZT2F095k4U5l4Fjw41Iio=;
	b=FhHrgWGJ9CmtcXliVfuGppFGkYKiLrNj9VjuuarrnMeWe8Q1K//qX9F5e69Hc2YpLH7W
	 LtDO+TSk7c3jUIV+Fs5ZLuZjAPwVQWeZ8TOyBMDqb66k9gNuKLndAfxWpR4QqoLezscuT
	 joQdbLoK8+5yH/LMzH247EhPMq6Mb62/qdKuIKjum9NZygn/9QZ+ovFyqs2WfAq0B1x26
	 y4oNCo+9G4JlSRVWpIHADy6uStrZcEXIien/PhpZNSEKeAApXSemSsLp1TBELfXOPWAIT
	 Gi4j13i9rUJjpwntkj3/j0FuZBsWQ2D+7sogylRj+/rCqEdYzFoZP8ngU+P9G5+luKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="mJxPB/cV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.65
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83D606A31C;
	Mon, 16 Nov 2026 10:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F83D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=mJxPB/cV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3qaYnwiHIL1LrJnbChLA5aVg0y/uW0x/ZzNHz4e+/AY8nAwkWif77807qDhtTpleQ5KxrG6O9mkKsMTtkIJycl5YKzsJHTtcvapuSHt+ZCVV7cv6HVedGpG3W9ao8cxHaIRislJCjdhHqbxlCEdAmveUKkqrZhadHr8BPAz7YokVJHwx9EtxrDhECOnd+v3zZi2AsBWYZ6pCn7Wjj53kKJGBpnbQ3WZZlzKnV9rWu+p9U1KnFBELOtvcpoJ1ZNh92h8/84QN7YdnlooEVgV/+IdwHD5wBKupMFyzrQm6Dc9TgpBxRfOB4j8FYxy8DAIvQmpJPd/7SyU8YhEd4XRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7kNUG83Oj11M0j5M3QsDAZT2F095k4U5l4Fjw41Iio=;
 b=lW5h4myFlti84w3K1BaXKdVlM+46DpPTJwmVSVOtvoGMuawUP6Bfw3zBjU3D7tP2ihCzHB9npPrhuLjC0wZYqWBSjU4ImirJ/ZiW/FVnLMh4k7j3BZKvvhkCWQpvah1SSq6sFBi5+f4Z5qhiKf0yEfP/9EdlU/XMU4x8aYVizBUiAikrrriTC5tIeFDk6ROm3NqGWqTb9eV5wjr5OVOGgBpwgM20ewR5S3fYasWWZknsc5oNVGTMeX9mmCgnWWOu2Ziu34vX9LLAUKJQXD+F+r8QSjIeuYJjss8kyud7+UNlymPxoKffjMf3xrSoH/fJmptgzUiw+XoWfpiQRDxtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7kNUG83Oj11M0j5M3QsDAZT2F095k4U5l4Fjw41Iio=;
 b=mJxPB/cV380wtWaQDdKZdv27ZLxYbvWt1Q18oD0b4NlzS9ffO0e/Adg+srUQkdo4aMrsbcLmWWYxmhW4iSGu1AgWPoZ8hIsY1KO4UvZaLHvz3ZZpO4jVfdNlmNDDquWMXSCWddEu36xreUTPvyspHlgB45ymi2EvGYwmVB9J83sI5bjP83Ji5pyTZWSzCdh07MfNuFDZ56g1jfUgcEARNNoQtWJM6iGUQPApwlCnJ/RaPhekVzzQHOCnaOAtAt9IRMpH9E7m5CuvzkPz47Cif7ZMMPKgbytyNptVnyU3+Jb1hpbxqUK6xZ+35gbsLLEgWbP3Cf3p6Sn19Lq9ZqTUKg==
Received: from PAZP264CA0117.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1ef::8)
 by PAWPR10MB6781.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:335::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Mon, 16 Nov
 2026 10:41:06 +0000
Received: from ZR1PEPF0000E45E.eurprd04.prod.outlook.com
 (2603:10a6:102:1ef:cafe::6a) by PAZP264CA0117.outlook.office365.com
 (2603:10a6:102:1ef::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Mon,
 16 Nov 2026 10:41:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E45E.mail.protection.outlook.com (10.167.241.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 16 Nov 2026 10:41:06 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 16 Nov
 2026 11:42:06 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 16 Nov
 2026 11:41:05 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH 1/7] dt-bindings: power: st: add STM32MP PM domain binding
Date: Mon, 16 Nov 2026 11:40:26 +0100
Message-ID: <20261116114024.RESEND.1.If3d55e03486413ca40ac73f9bf07046e76a00f0a@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
References: <20261116104054.94115-1-patrick.delaunay@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E45E:EE_|PAWPR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b193ac-6b63-410c-d67b-08df43ce1e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	XrBd/DAA3qdnzv81p8EbGjqkiQ6C+Cvl3PeTjzZBDhy85Az8fRXbivVTEoxxjRWrS/gsxRVsP+BynSDWXWPnAwwczuuHHs630WpEBcPo//LnznHPV88HiHRDKnf20HdKyC9TG7zQq0FI9Vz5ZL7d9UD8usd8j5o0RFJkuXGh9HToMHPCPbo4F57FdLALz9nPMTN/QA4kpZuj2BNJf8AiBLMyhw6AJyqMSFgQUxEG+o5UoSh5VrIM1BZVshqaZ8NRw4Q6XLGrL2xvIP/jblYNoUKgjoZZpqMnCrcA+lqc5VN4SqOQC7HdfiEkRbYm57U2zimWmW/3Yxb/AXR+ujoFEoNyM9ZK4fzKN59Nda2HIdL20nfjXJzYDU+VwHj+WD71Pb3rXYvG05VSrSN2AQ+8fvalIvttQrmkekXBMsBB01aHDFQK4UOa9gogYTaOQBZHQK+KNaybXMtmkOA+EF6uOw58zLKR9pORAYc0aQp30v1KlrGl78TT0tYEs3y3aOKfThyBaN8fXR6ow3Z/qTAMssgwweMplQwoklBiKuw8KpOEfFYbltM+Qy7RCh5OfpGUgPbHgYokJdQ3rBFhtmEX19WDvrmzambnwCwQ91E812LKne3uBY635aQ7+GmlDyevVGNP0dQK131H1j9HeNNvdA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nuHs1GeNbMLqOWKAExosZOHtWb21njU4WVpwF8cEAiQ6WneMt2KMNh3r14mLAAL3zLKye7jMUM+8JPmxxSvXAcGnasr/+87hV96KqHPWiA4a81yqjrqdCxRHf3kQEyOve629WCrab9gwqKeEo0dX7KFonv2j6GuKrC2+MnHQzl4C0tNgxbWBRaKSpudz8OqumzPnFAFBQpX2V7x4p2DftFYFOvYAFHxX/CxAqMGjdOXZgeFzqKA1RRgIwQasmeCGz0r+q6emZ6rvr3+katxOXH5pHjKdvhgOu3RSnTaSpkRlZBi2FnnQaCCSJJxJdZySJqto+qY9ZizTZ0nO0csrmynt58NZ7W5rujm5y+uiALpyaPVBoY8orPnjqorq3KRDxcxVyhQQEMbN0stGVy80PA6mB3ujfGvkyhICracmRoni1bWRIZ2Rh4b2OnhIht2x
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 10:41:06.4513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b193ac-6b63-410c-d67b-08df43ce1e8c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E45E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6781

Add binding documentation for the power domains found on
STMicroelectronics STM32MP SoCs.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

 .../bindings/power/st,stm32mp-pm-domain.yaml  | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml

diff --git a/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
new file mode 100644
index 000000000000..4ab477fb4499
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/st,stm32mp-pm-domain.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/st,stm32mp-pm-domain.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP generic power domain
+
+maintainers:
+  - Patrick Delaunay <patrick.delaunay@foss.st.com>
+
+allOf:
+  - $ref: /schemas/power/power-domain.yaml#
+
+description: |
+  The STM32MP SoCs contain a D1 domain which defines the devices assigned to
+  Cortex A cluster, the devices in this domain are functional only when this
+  cluster is not in low power modes (Stop modes) with clock OFF.
+
+  This PM domain node represents this dependency, based on PM framework and
+  without wake-up path support.
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
+additionalProperties: false
+
+required:
+  - compatible
+  - '#power-domain-cells'
+  - power-domains
+
+examples:
+  - |
+    power-domain-d1 {
+      compatible = "st,stm32mp-pm-domain";
+      #power-domain-cells = <0>;
+      power-domains = <&cluster_pd>;
+    };
-- 
2.43.0


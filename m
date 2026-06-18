Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE33911A8;
	Thu, 18 Jun 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789887; cv=fail; b=hnf1pRx9xAbbuSrJ6sIYPcPW8LJhUuUOiuLqFMR/LUhLKzNgV/sunYvrRINTP9JMkujm48Ye7E1UN498ch5vwhHhvn4jD5AR9XPy70wKJQdceTGSiMdaR1hX+j9P1Fl/ZPULYQylzCAKv5e0ZpYKiLoOq8aaA/eQbjASIpW/kLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789887; c=relaxed/simple;
	bh=YKWBHF8xvyyHYq9brMKHv0t+G1RvYmcFcWcd18l0pYk=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=uC16wtLSEEuqhQ0Ft1w8qCXXgH9mYQLprQVpcvsay3mg2ThGZT6+d/3zRSz1YUEGQcNMwxPRbu/XvW3kM10RP6Txos5w/FlMUSeyIdsp9skJbcV7vyGQr39q3LdQtg4LN3D3lIGDPWEu25c8kNcJsI2A9PKGpLomg80IoHWIygo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lPVH0yj9; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lPVH0yj9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIDocRC4O45kaMTsTgozBuIwsryAOrS5llht5ITCl5Y3wSntoY3T9HVg4Fan6U+DyLQlQvFgw9qpf4Ui5zPT64v/Z6qwxmO1Bs1Cucg50eI9B4042stsQu6lB41zhlAbmo9ETwRxxh/U9y2HGfdrOA5QZoGeB+1ruTLb96sZwqJvtiPCMU5Tp6HFUD9/g6DphEQvsd1kakeAEHW7+BPHCpD9O7tTHYIOQLggyfyAWnAcXhdXzjE191TIiumGWMhy/jyuhsdX7Bj+tzPsXtIHrnrobFTepkfCdaWoQN6LUSC5cmRCFKZ2nVMAch+wAKabvb5hYpQlq/vg3K75WnxftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGE2TGVpjAyGwyuhZ6SHdUa2SuVaQqctWRHa/0ut2Kc=;
 b=F8wEhY/0gyEyNqh/OWmoXUxVki8RLBaKaNRMzDhzFlmiQ0in8jybaqgW2fbtcgk4MZMHFoXPnB/pXNama3iJivBwRLfAZv7iuWL8cMxhdezEiQciDkdbydgA3v9Iqz5NIpHwsG+eJCozrJaoyv6SFM3AU529yGbnjH5KltOlfc868c2gU+XVQCHu0L9IzRxHXA9bBDP3jW5wSy7iZYI7nAQVZh0ThzikGuP9neBvoy2qan5brpcPs2eIW7zUUWfzgk+SEOxc4DD/5Z6SPfhiB+H7vFYVY01JgoQk4uswvswebTuokpoeTqe+Rt39nUlIKPOsEfewYRPTKYKx3uPcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGE2TGVpjAyGwyuhZ6SHdUa2SuVaQqctWRHa/0ut2Kc=;
 b=lPVH0yj9MU4cDhm9Oqlt1wHC0otaqncD8sklEcsEufkh9s2lsxPQGV7hbuB95GIcY0EERazaDHcjVUBQL0v2RDI4QOlKdoJ+hfORvUigQA9Sz3WGNdqNbrLZdcr7YD9UYJGDDHAcm2ryIOF9UINhOCHF8w0O4TfFMKF9g36R1/o=
Received: from CWLP123CA0265.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::13)
 by PAXPR02MB7296.eurprd02.prod.outlook.com (2603:10a6:102:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 13:38:01 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::86) by CWLP123CA0265.outlook.office365.com
 (2603:10a6:400:1d5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 13:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 13:38:01 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Thu, 18 Jun
 2026 15:37:59 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
In-Reply-To: <cover.1781789320.git.waqarh@axis.com>
References: <cover.1781789320.git.waqarh@axis.com>
User-Agent: a.out
Message-ID: <96b7d1a0aa0c00929f0fef2847db116b54079a30.1781789320.git.waqarh@axis.com>
Date: Thu, 18 Jun 2026 15:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|PAXPR02MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ecb45b7-a960-46b2-2d96-08decd3ed112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|13003099007|22082099003|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	GJqMNnevOB7zmz/F1NMEQOb088AT6BegDST4CinnuaKZgBinnCHWm4SfuTngmsHR3hSrQ6BeQAj4xzhosMA623d6TPPZq6iFanYY1GL5bh54t/dGF5iIDqw3Ywy+iXHKdTk/MJwvhC381eImqN6VUeu09Ub1CmFsLRDGeLrxp/VKj4EVw/8Ti+XRlm/4VF30zVZxVwgjCAw5SBySYK/sv3LAuV/RTC00Ze2viCGqySwMbaxwSd2Rtm/5u6nTygE+8OfEyGcBupvAM48IDQj/nfxwYh1YOTqJx81i85rqbgM8xQSZvgMGj8wcYXY9btKh5t38GXAnEuHg+EqbTMnLYusWNDAAxtvLW5qDH++bgsrcN6nM5ZoNmRUJWgh58spmpoVNN/6fblOe4L7AMn9Z+cuSzhBEKBVfD8Y8+oljIwZTeTJnoE6uM0JTs1GD7yrF0hrHXCl0EwsfBLX6KR1qURr575FbuJpgtztedVhObYB2TxvdEGXBMXkmpwuXmpD5yFlIuW3OwhGqxciUJSjSCDyeJTRWAEJ0okhiN+ig5XOz58UlVWQ0whcwhJ3EGCEipYG90MELquAZDIbzhAMwLrbf6yejpFvlf4KW98A+bHGWOrT/1mVtK84LTPFgfj7wcU7Ln+aqXbPZu/CgAT5tSRB8uNsGlzYlyg3juVj2lkvZcRMzf+fcVwM3kcK2pdrh
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(13003099007)(22082099003)(18002099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	73/YitcN1gjNyLoxjsw+vI/MxvawgFgFkiy+KxAgk4QDhLdpr0lFehgtIcDhCP+umdEWElSQR09duFJa6yK0rINWBAJh8TvGmfE8LwlRZjH5XgLUobUz5/TnNWMe6b816YIuBaJrC6Ac5Y17pRnOxMStf62jDof2Lws32C5R5/W7a5sp8n/7gXnyx+K5Dhh+HZnB8GRY+87c6wpoFUUs4nKeXvRT0/b1yEz9HGtCYoVBwLciO3or/ZrBer5jh08J8iQIkAgcn4ICwKCWDH2JICWvbTjaK8g04I7ACs7riZFv1qXHniANhVJ6aDx8W0NrQBIvQ/ZtXEWQP7FBKiR8ayy2aRv4F9LVa/drC8SW1LjUdiVHzQZ5VvyJAksoFF4sVwo/LwWniCVrklFCrLs12DJu6UXckz7HSeLBi2TelQ9tCUaP3+5+ifE0B+UMrD/c
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 13:38:01.2075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecb45b7-a960-46b2-2d96-08decd3ed112
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7296

Add devicetree bindings for the TI BQ25630 battery charger. It's I2C
controlled and sends interrupts.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../bindings/power/supply/ti,bq25630.yaml     | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq256=
30.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml=
 b/Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
new file mode 100644
index 0000000000000..1e2c7aacb26d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/ti,bq25630.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI BQ25630 battery charger
+
+maintainers:
+  - Waqar Hameed <waqar.hameed@axis.com>
+
+description: |
+  I2C controlled single cell Li-ion and Li-polymer 5A buck charger.
+  Datasheet: https://www.ti.com/lit/gpn/bq25630
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: ti,bq25630
+
+  reg:
+    const: 0x6b
+    description:
+      Device I2C address.
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Device sends active low 256 =C2=B5s pulse. Type should therefore be
+      IRQ_TYPE_EDGE_FALLING.
+
+  monitored-battery: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - monitored-battery
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        charger@6b {
+            compatible =3D "ti,bq25630";
+            reg =3D <0x6b>;
+            interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
+            monitored-battery =3D <&bat>;
+        };
+    };
+...
--=20
2.43.0


Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17A35836A;
	Sun, 28 Jun 2026 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782684087; cv=fail; b=q8e1/VFeTMiBkNHY8N302l7OMcNp7apq2pwUTNeUA+zwceF89QY8XCGdYauX4eWPG9FZgRBnoNilQN7MqeAM1jeu4mWgXyGsCeJPtXt8TgtwWpF59FSeQzvVhaTV+6iiJgT+7zGcchqVnd3OLAnqLktlc/QFLIqnPZIYHBB/p3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782684087; c=relaxed/simple;
	bh=O11G8rxmdTSh3W8yg7YJDD9kQCCwdpSxxv9d8z+Ye0I=;
	h=From:To:CC:Subject:In-Reply-To:References:Message-ID:Date:
	 MIME-Version:Content-Type; b=TA51Ma9QtxNuE73p62g+lUlijiHsKkfrKnl5Rujl9uMUJGVvUZ6jTYZ5y2/f1mVY/qhcCuhtyqVb0m4K23VgqIByPkyXiwPhUa0NgeaK/PLbGRmkwpgY+ASuoUOkp7r8zA2VX9eSaDWNLvP1PWB/1Pwyga9dtZLrwFlu6FveyN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=a33nWLkk; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="a33nWLkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFQis/IQcj7M8IWy4afq3bTwzdgbO++4Vy/p3iYFy7Di/DB4DDp5TVAxs4B+4yyAxmtCK257Djd0bquB/xx/Fr9QfxXD/BSla7Kr73GOO3Fc5qMhVXRt5O6MyxKWvTM1Vm/lz5lewLPkE4Psj4YdEd7cUEz+8kXiTKeHwtz4Riw9pU9Cgp3Cmz8FF3aNmjAOK9amaeew35QHxe98eawKmtY3Xiy5rC4HspaFrVGSg/qI2SPveQF3FCmpZdrGwZ3sdtdlrvmYlgvtN8I1am8KdlS8ayj9xSeA74zfdjuCDJ3Km+Vu3l/2WyVBx2X0g8gDiYjwobWpqvmS2s6cYYiBGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb5JdtztTDOyq1MTJgbwY94+lVApv2GerXob413beI0=;
 b=YW8iNrKloIm4lCriVKc8GZL6Y40tdq/3nBbumios4cR2+23OXDeZvcQBPXzxa7S5nmE+deMItJkr/mFhwPNIpEe5opGzudncRwwPtYJWSyK/eSklX145k4885pR+5F2upuqDnU2amRFdLQK4vDxVtiaZbNZLLaCtzc4Bp2Z5RtLS/uKa8iIv+QI7YP0HrjgAlxv0yWVPapKK0sA1MFDiVf974YRnsLCrurSu5xiTfDGA1giNn5Wx5Y6sv7ChVs1RHz88pQSiCCqERYXhTzwNr9v46skkIHqlMULZuH1oT7lQitA400SXErM8m4okPcgF9gxAnyS/vio0js7bCGC+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb5JdtztTDOyq1MTJgbwY94+lVApv2GerXob413beI0=;
 b=a33nWLkkAw4k+PZpJe94GJKhP6ygwJU5d5LLVW92ClgViyEgKnF4G3HXE+2zMQsdV8FwDoHe8Bw/FXg9hSQBr9Pv8kx/EVmHbZdGO09/PD/JiuYqbNx1+rv5HeuZ2BBUuHco7ReApChYB61XtGXJBNH23Ve0IJ1UZrcbUAMW07s=
Received: from AS4P191CA0006.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::17)
 by PA6PR02MB10616.eurprd02.prod.outlook.com (2603:10a6:102:3c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 22:01:20 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::8d) by AS4P191CA0006.outlook.office365.com
 (2603:10a6:20b:5d5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 22:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 22:01:20 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 29 Jun
 2026 00:01:19 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
In-Reply-To: <cover.1782683551.git.waqar.hameed@axis.com>
References: <cover.1782683551.git.waqar.hameed@axis.com>
User-Agent: a.out
Message-ID: <3c28e53cff6d2e6ee94f8bf516ffa75134cb0959.1782683551.git.waqar.hameed@axis.com>
Date: Mon, 29 Jun 2026 00:01:19 +0200
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA2:EE_|PA6PR02MB10616:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5008ed-5d30-488f-c204-08ded560c967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|56012099006|3023799007|22082099003|18002099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	jY2rw4QPUepAMxtA4Z5w4Q/aZoMj7g8RK+b/PkZ9DRWiO+VvC1m9dorwEJ8r6F8uMLTXMazCUbZHHWUoHYNIHEm+G5Wrhlktz6I5o69hpRhvpjtUyApdkg+RSvnWlw8Kft6OQ1C5WUg3Dr3AaPo3GuGfFwoESrelhZEAzgvuDeMvrMRu6CjzfoTQOuJu3jMJYdY/l6fhOxpInNzS1ULptMi2dZG1/1pt1NyWNlisHTkfX3mqnpQEMb5TRfA5AqxAlinL8mNEmAeq/xFPOcWhrTlknML6X+sJlgBZNLZ+2LerEXNJ0DvtJlO4eS3aGxdMhMZhD3lMfdhvZknreKe02rkCfaF5uOFpIqfMGBWtSie3+iEeW+SX7a7XMgwaqySaHJtsOKuujXrBnt23oXCfRZdHIT8XazSX/5nhwPRXM/PJ3xdLlqVbOsFive+/AorZaU4kk7a6DOsLxVPfcoRHnA8JRQdS45RuJXz3zut1gYjfKuQFtSjY+2/tQGzkoBPNMachCiXGJH7lX4CCnEYRNpb17NKMQySITAlj4T9S78TbhXPMLyMRkH7gWJXIazUwUbf7F/GerYCumHn4hIULh0RI/CDjhcXtNNjawJPlCy1htT48UTHozzhfSS+SGBO5LYXAES9OxizUIOQJTFG7IQ==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(56012099006)(3023799007)(22082099003)(18002099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LxIQPQRqqTGOVHAWuxgFc6r4vrgw9wVJO83EGip5Fae4XxSmUIIybJBHYs1zMadvpC9Rx85IyiskuHKqS/okkT9w+OADIkDhUx4bNFXD0IedAoi0Xg2hOnO5kvQNJKHyfdgt+TqR19tnzocRGPMA9p5dMuiHrEH2Z6d+7o6EaXeHlDe5CE4sdPeKI97qWRz2uSSCFMgnbdmFn48jryUrUF8GbQI1aX7jJNR+Jqs7xYVsg7mvYSw/Yr6QkdVpek8MOrLUSSCCRnMFRioVquT4WUOAr8fx1qGzFgDkk1xm7QwGrnovtQlnnmK7VOvJe9eEvz/suUFcrufxsvFej+F9PS8xjkwyXKZUY+Bc+vvKVA2O4XzW4bgaj1g303k74/NfyuD5xuvhHP62JxgO/RD+6Q3f8b/C/82aPfVIn1jF4NU+fDm7Gl0B4CdIohTVarvb
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 22:01:20.5417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5008ed-5d30-488f-c204-08ded560c967
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR02MB10616

Add devicetree bindings for the TI BQ25630 battery charger. It's I2C
controlled and sends interrupts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 .../bindings/power/supply/ti,bq25630.yaml     | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/ti,bq256=
30.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml=
 b/Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
new file mode 100644
index 0000000000000..3f2904731c5a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/ti,bq25630.yaml
@@ -0,0 +1,55 @@
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
+
+  interrupts:
+    maxItems: 1
+    description:
+      Device sends active low 256 =C2=B5s pulse. Type should therefore be
+      IRQ_TYPE_EDGE_FALLING.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - monitored-battery
+
+unevaluatedProperties: false
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


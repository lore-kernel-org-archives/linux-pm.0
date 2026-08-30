Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E03C3BBA1A;
	Sun, 30 Aug 2026 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103731; cv=fail; b=D9AdKWvoXJXRcfoL1Bp1ET089nwWVGZX89yOR3B4ZwOzmesSYbJlCDpsISvRYaK/5nHoDwoEKWawhN2vCxNQGq9yVlnvRqMcg3Z+kqJEeY8w9Cn9oDe+Meo0KRbufUXNAXrOIIFoth6QxhMEbpJxdB0MkyAmfjVAy0tyAsrlrOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103731; c=relaxed/simple;
	bh=fPfnfa+udoGcmHROCDGZqA+KR9fMa7LarKi+L4yqbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcwYBIWQOdTzaKh71Yf8SJ+MqqcSf7DB9QUlvvjr9gxx04TKMh88LACAVbJOCh+t9oCS66WsBlLu3b8DDzLiTAPNyEqov76H1vnw8L7eX9ByxK0XPkc+6WSdTJnPDQ0lw7/dAoLpvbQXuLCQ4nXfV/DIWRa2ZnHVo9bINeG9Qog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm+Jg9iZ9pjjqAFHA/Hhi9AxYve7wzZ/nAPTm1EyIbC6WQL0JOpQZ8Xp0mr8EuuOdjaOspEd0z8RS05CYaLP/cjNorZt3KaJsUBKvPED3PrnYclXUflGC3PGxMiGPTsAHYAp0nCoJ3Bqrj+o12tHxOESi50s0rUhPg2rpIRf8C9FskbIvtTSReF7SbOK6DcytomKYf15r7hr98kfPTaU3sjVAJI6z94nyn1XcJUBgPEyP0RT41Dqrf0tpfmtqT9kBHX/aK2QBPsM23f1tQko/sA4YRFP6m9Kw6mcOhb8MHELic90nS1ATiGoTKYv4fKUVPLOz9VCaRSvFE7SxTHT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+qoQIZIyGZLEKbZaeCztvK/3VrELEMlKlZ6iktumko=;
 b=b7bJJvtpoBgajA/tR4o4msXB6HtRnpQ96pEi6+htm4V4RIl5vPowUdKVbNIGJfXgngt2qzf44/bTRqORZ6s0G9KOl3cG5IByTDMhUOyCfWbgFnYDIIOOWdoxALHvaLHcpEfdlwjDsmZAmrk7octw+h2N+bGaJ4UiAbgBVu8aGVtND4pVujzBrfx4VIY3gbuKWc9pkqGTGohp+vYB5fDWyAOmw3kwB1oqNjVEIlrDuxjMSRX5FCqCtm0nLqZ5hvH3dbJcnaQVrAPt+nvFUIIS53ABusDKbBV9MWTBlOebT7p0qOr1+AwmRCPveBP/im6uQiW7Z8co+8N+bk2lACOdcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0821.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sun, 30 Aug
 2026 15:28:38 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Sun, 30 Aug 2026 15:28:38 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: power: Add RPMI device power service bindings
Date: Sun, 30 Aug 2026 23:28:11 +0800
Message-ID: <20260830152812.312663-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830152812.312663-1-joshua.yeong@starfivetech.com>
References: <20260830152812.312663-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::30) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9757b6f7-cc14-4dd5-9361-08df06ab5cf7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|7416014|366016|376014|1800799024|13003099007|921020|6133799003|38350700014|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	c+Y9A6Kec/KIEK5PpaPhlwOHcnWiYJoXB3F63kw3ts6OjLnimYov23kEgtjhOhsIs5YdvqBheLzQRIc+KAb33LQcFT759SjfBNMYSQknGQDVilY/gdv06Lw6FokO2jAr/DI1gPAQB2WaZ5QEnlTTwZzLir2pasOf6w1rEfUCOnWCaY4dewc1E2IzPDsZsKbg/UrWoygGGnVTSDml03lL5uHrV6LnozrzpFRCKPZ4RtPWJgMAMvQdDNz9xRB/t5SCgivHVsn3KWaj9ryEcwHUFQjse1AwMGVfzB+pkos3ywb+UDnc/bnPMTvxuwK3yZz5SAc4ZwxUT0sx0ZFTV8LMBry3sPPUJW8mW06udpVoWOFeJUjAbpwpZZE+AlTjrmamo09/dHtuMxTmP1rQgolCo0XipmVLFqIt4gKFFkM9INYCs4P/luK9njMu2SD11Ye+euaddFOGuXbaJ6t0KVSIjZkLUJ82NnvkpA+3Yh570QUPmaPtg4hJxMY64B+t0gO9Fwvvxene5j27XruenW7IOALuI5RYUUu043K71vX9FBxPf/AeHIcDpQFaFCRSPsyq7JFVDg0btqZ6yJ3nW2FdOQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(7416014)(366016)(376014)(1800799024)(13003099007)(921020)(6133799003)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPP2M2NFpMOtyQdQd6osv2yPap/eSFfJR+GbFJjCYxny1G/5aWTRKYg3dML6?=
 =?us-ascii?Q?kz4Jc5AFNYlTwVCQO4zrAApC5t38UxMNwyaG/wN44sneDzhrTcskSl0qBppv?=
 =?us-ascii?Q?7g30Irz7azzqpnUkmzNFA2RDQ2lcv9YJ/l3Sz2nETfPeKznjQqmjEQYz9R9k?=
 =?us-ascii?Q?17CZbbDTJgCgU7hZ6CGvxjIzrqxJyP8tzjJQK8bDwd2uGxbHHaP+s7Iw4N89?=
 =?us-ascii?Q?UtZOmKuE1Y99KqiweCx8Wl6Dr4iK/2W+OOLdIgx3qPAT7elAQX78t2n/z2p3?=
 =?us-ascii?Q?COtVHVNZXF+WCZbCQQD0SF7nTGNOIXtv2oYWzoNLPDyU9mFcLhjLn4+JXWlc?=
 =?us-ascii?Q?03WFmzw0bn8rp5hixY2/iYP2+nUdwJHzMDddkN4w3tWL4TUSeStYJdXnjXQc?=
 =?us-ascii?Q?LoDd7WWu4WgNhXn0tKcriLh0ONRxvxJhMcu7WefN9P3UshA38Dkn8WjQAlzI?=
 =?us-ascii?Q?CltDVJLyE0zvwHON+Bfz1C2Fq3J13aVInCBiBVGqOyrr7kY74NwTgnjpH92o?=
 =?us-ascii?Q?IvzV3azutQaG2Oa+d8tLbxRUJF7fumCXqNCBzknp8OSJrTyi7KYGq3+VVjfc?=
 =?us-ascii?Q?BPhJPxXrRxdmrxsJ5c2SrdoRTZghcv1OjODPUhfjWjNAlEbkLzkDhFqCw7yL?=
 =?us-ascii?Q?NSU8vFV/PNaWdQbts4YlmYF0SCAfLMyV2AKursX/vfKwcXgLROYEcMkUmBeB?=
 =?us-ascii?Q?uWytSTCZXYx9poJXj63tEDPMeRiUu3QoVV4mKU/hcfGDNkx1rF4u4umUr4ya?=
 =?us-ascii?Q?JvHkDZOlkEn8s88hfl4FAn61uLToN8MwG0Qw11ktUFninSkk+rRQATNJilQI?=
 =?us-ascii?Q?xIWJkpBk+bSjdJhbD6n9pOotNJMW/2yYCjcr5LgiYCS9s15hePF8Xhb6/Z+a?=
 =?us-ascii?Q?yPLZ0h23Vn4Ce3AXqoUjsQ9iUQWsuJphKtz69+Vm7m0blvq31pKv8hD+L396?=
 =?us-ascii?Q?J8j3Yl5qAtQrruPEC/SAfaWKHi8IpktF6i5CGTnMh9PR0rAHUsIXBa6+BApp?=
 =?us-ascii?Q?4GRQxCJ9F8wm6/Y9D1sE59jcr3IcFLKgfIrllAfPqkqap1FGLuy1Wd70922E?=
 =?us-ascii?Q?P3QU9ORmkAN3rtKoWd9/IiqIgr1yTmy2T/zWASeJzBhhxdvIO0qHEs2rFbvM?=
 =?us-ascii?Q?pDvsisjrpH5LUtZAp9MeSxEA4BHJZMWGlI+N4GRG6V3ouwdIFxBqHF6TlTOM?=
 =?us-ascii?Q?GSKG05L3EegoDFw0AD8rSG5lDS/otYMhTxxlIlv0V6Nyp1jNMGPonewjtMGJ?=
 =?us-ascii?Q?Lm6uf1yeE3guUZSiLa1tpZi92d7dpkuqBv5ULUKFoW1ahmPbgG2lkTeyxVut?=
 =?us-ascii?Q?02Mz/a/oZ7OYmrWT9EibP6PayvbfvgvG2JqnydJAH9e0/1PkYvtES4fxjLkm?=
 =?us-ascii?Q?Z8ADwC2P2ueGyte8vcmJdJE0tTvksaYU0lUYwgqcKvsfay1Ba1xpzfIh9eFi?=
 =?us-ascii?Q?/enFISg0meV0ww+M8MfBpTo+2A/IxJZtg2An5Miw+DdNwh1bWcXKu2g1cumB?=
 =?us-ascii?Q?gNjT1PcjAjatam18wd8sMGTVEBZCAmPVNq7D3jdUrdu9TzvTz3bx1bzjl7Tg?=
 =?us-ascii?Q?g62oRLX3evf6RA1Gh7YZwtryg+mnzboAGruVoj8rsNxQaG5+X5V4bZzDlX4D?=
 =?us-ascii?Q?bj1G5Cilb0p3kkg7XDhFRptCib7Z8JxTdxIKE9ArNkVUXcQWkbbLE+e4yNGh?=
 =?us-ascii?Q?cejOixdnwrd4jtdYU8f0ZC2TS0kbNL3yRHBCDXgAzYLmI9Sd1J5/RyeIKE0K?=
 =?us-ascii?Q?PMgNzfP4+3uecwgIHMgO0hLe8ewGpIY=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9757b6f7-cc14-4dd5-9361-08df06ab5cf7
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:28:38.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qn40iim+v5fuiQFK1/2VtbeNE8AC/bjDRQ2JgxhbLqMawmlijJmkqLIzW08tisgP8DKqOEPmTPsMSId4VUSIFyoEJmnXHaavipCTuGy17dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0821

Add device tree bindings for the RISC-V Platform Management Interface
(RPMI) device power service group, both for the supervisor-facing power
domain controller and for the SBI MPXY channel which the SBI
implementation uses to expose the service group.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../power/riscv,rpmi-device-power.yaml        | 65 +++++++++++++++++++
 .../power/riscv,rpmi-mpxy-device-power.yaml   | 65 +++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
 create mode 100644 Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml

diff --git a/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml b/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
new file mode 100644
index 000000000000..5afdc40df7e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/riscv,rpmi-device-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI device power service group based power domain controller
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines device power service group for
+  accessing and controlling the power state of platform devices managed
+  by a platform microcontroller. The supervisor software can access RPMI
+  device power service group via SBI MPXY channel or some dedicated
+  supervisor-mode RPMI transport.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the supervisor software.
+    const: riscv,rpmi-device-power
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport or SBI message proxy channel.
+
+  "#power-domain-cells":
+    const: 1
+    description:
+      Platform specific DOMAIN_ID as defined by the RISC-V Platform Management
+      Interface (RPMI) specification.
+
+required:
+  - compatible
+  - mboxes
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller {
+        compatible = "riscv,rpmi-device-power";
+        mboxes = <&mpxy_mbox 0x1002 0x0>;
+        #power-domain-cells = <1>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
new file mode 100644
index 000000000000..2b7df66ba172
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/riscv,rpmi-mpxy-device-power.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI device power service group based message proxy
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines device power service group for
+  accessing and controlling the power state of platform devices managed
+  by a platform microcontroller. The SBI implementation (machine mode
+  firmware or hypervisor) can implement an SBI MPXY channel to allow RPMI
+  device power service group access to the supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-device-power
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    device-power-service {
+        compatible = "riscv,rpmi-mpxy-device-power";
+        mboxes = <&rpmi_shmem_mbox 0x9>;
+        riscv,sbi-mpxy-channel-id = <0x1002>;
+    };
+...
-- 
2.43.0


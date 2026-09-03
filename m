Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21544065E;
	Thu,  3 Sep 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429453; cv=fail; b=rJYgaYSgqbmfMp2Q4Tu7UjHdE8uq0RTROoJe5WrzBnZHEakMm5AwZqHrklNXFV4qj8WF++NBJagxvEi4W8DwbEgQGzdJ5531bW8U3vuEqf+2RAufyIx75eNcDoQ03D4sx4diBiKYP6lO0Ll2jw21sjDAbgxxg83ljOuxXRY/IGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429453; c=relaxed/simple;
	bh=fPfnfa+udoGcmHROCDGZqA+KR9fMa7LarKi+L4yqbWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qdQXupSZz1B7RmfKMfJmxuRHO8NAdBiBQtSWQgycoxw89PBELG9PT8B/o8b8zTDvGtMw8l7jc+2BeOs4Hu8wzECaoK2r28D3TOXe0jhGcV97Hjxm38qkHEzwlARCE94MIBg2IHq2zr8sfw22P0TGPv9UjfzmSuUBE1qrB+fPaRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVWGM01EJ0fvvRJXQAFCa8iB9gDi9iwpT1LVjbot8f5oGa64Ugr+5XNJQIs58003mFoGlMElpd0YmQpLVDS70w70TS3rFjIuejh/WNLH4ziJwTU9N4NzgD/r+/IaRTjVpL9TCnzYjPYb5ZXkFLxcJj5AdityPBKnic6SRSsMhTjzvt6yEM4U8UG9ZdZyfhyRuYC/z5qRiztsnkglrFmKTOtyt94BHRAGwj3l00SvH8/T07SwWjXlTK+rwi5HNU8o0TxfIet3Cxg4OJW6FjB1Pk0weHUlfNQMNRVSsrh3nfTmHTY+K9gscvKrmU+VDzdeiz+eo4FNL3K8Bu8cCJ0V/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+qoQIZIyGZLEKbZaeCztvK/3VrELEMlKlZ6iktumko=;
 b=lomRyr/7NmJNK5oCHjmysXgNy/iJNBxVT784FrSlZd4yandra/RddNVZ9pV/QxGK7/sCNdLONwGVgnX1XAKkbjpEUzv4NkAkN7YLoZYmAQA4r87Q8DBzJ/cLpZ3mEZnGopLKvR4Tt3VaIPp1smJulxInXayO4u2WPkQ45gHMMFDRqFxEYgE2KOrsV0CZfT11Ea3CvKA0tLHbh7ZtgVvmrn0KtM/RHNdn6FTw+9OvRyMNXn/GX1G3hwhnmQedcUMsO1pfOQ8pGs/XZEXJD2sEFl68W3MaWXn18xra6uUrXYjPUL6C7PIIL8gH+4QdtBDTxY+hcca9NqvIVFL5Pw07Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0680.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 3 Sep
 2026 09:24:19 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Thu, 3 Sep 2026 09:24:19 +0000
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
Subject: [PATCH v3 1/3] dt-bindings: power: Add RPMI device power service
Date: Thu,  3 Sep 2026 17:23:45 +0800
Message-ID: <20260903092347.620060-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
References: <20260903092347.620060-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::14) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0680:EE_
X-MS-Office365-Filtering-Correlation-Id: 7549e53e-8777-453a-19b8-08df099d21e6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|23010399003|3023799007|921020|56012099006|6133799003|22082099003|13003099007|38350700014|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 tY7w54jMBELqW6gJTCeQM3iv3tyWcG19W+eG7v4FeOtcT3QqMnR2ehaJxlLd2Jny12E5ftrv2+Kuf1Er5l4lcSUp4eBwQXCY/Otpna8qlquBC0JA3NRIw79HKxqVUl0fy6k+GGmAcy9h/9vNHYcCaetrRLKHY88nGd1mxbBfSj6PEwxI7lC7aQjgenPr16UrDajmKWIsf9tyQf5HG73+oEFc34hocS7Om7Izf/LEIom/kMasRyliB/HBzI0u3ha6AoSPvH9pa9RQgdhp+x2MEd2ZCZcp9aUNr4V0h49BS6bSLyhtLswgobCzjv/ZJ5Z7uPyHtIOu9nuCG8cwww1u/EwrL2HOtweTHhZ0aHDX7GIBuj2hF+smPcjr401MtzjzYQlmjx1dB2DAXRaPW4ohTECGHdkmoQWDAc48A6XyCMwXIzF4akcl6iiZak4MBkDPGKiWQGWGhXCHcG77qZ2FUONow2oQ9AUiLuxtjAEzsu6q7Mh7PQDkjI9LY1xNjNyWfXv8J+UvkbHtqH1677BER+E6SMYwbeg74oxKrVsrW2QyqQ2g0dnABzBmjZgtE6UjWc4jNeJ8th0g19wKymkbZA==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(23010399003)(3023799007)(921020)(56012099006)(6133799003)(22082099003)(13003099007)(38350700014)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?jTeZsg4BAtQvJnA0/aE7aoji57yFP/F1XRPKJv3vI/Au0Q+sQX0wYNjED5da?=
 =?us-ascii?Q?/D44jflzBHbWmxaBA4RtzDR8kVqYloBKWNKFP6Zco6sOTiimL7vFh0zLfjzh?=
 =?us-ascii?Q?kEUJpN+y7TGNm8cjMa9djoW8N7bWIwpbrruCC5c/hQ0kcnmNSqzPyJ2ox4dS?=
 =?us-ascii?Q?fC0NUIc+yJNVUqUcJFiLs4McXGQiAkODlSvRVfa7CSVHxvXZF5L7KGzlTvMu?=
 =?us-ascii?Q?P7i2eEwMwiEo8KrEuQtJAlUOU0S5QNw8rVhEUTJzXkTRXMdJhTUqC25RUxHq?=
 =?us-ascii?Q?URifiTdRVvNniUGZCtDCT3Sv/LGMopnIkOBwDAN3EEHKPaH9skC7KJ5OKJEk?=
 =?us-ascii?Q?AAoxnjcaSWLIzqWncHD8lIBnxN42gWMhifvgOPIftH8rN46WW9uellKYFNdL?=
 =?us-ascii?Q?R7PXby3vBOw/lWJjSycPbemQnHDrN6ISjMA8lLEwF8jXXnmC+J8aL38DML+v?=
 =?us-ascii?Q?a2iQ+ioHRPxTLMA2oYdv2jYflDMpeBUVwMYWlhVu+Htf9ADdVQj5CHVq66Qy?=
 =?us-ascii?Q?ufWRvxizzYVnmWiwYnU9/CTCKd6vI7OdtFbUTtIkLe2/Q1KJBv/n9G3S0pD1?=
 =?us-ascii?Q?PRCFlGCZR4RIC6WV1vl0f1SCPUrgLRRM21LxmKO0F++v0cRPk3rEtWVvyi5L?=
 =?us-ascii?Q?NHvnOLskDDkwSDQtiDkc5Dd1s7zya07uJ4/ugUG539vGNzvXU8O1QBRGnoax?=
 =?us-ascii?Q?7caFCq5ZFaLTp6haLsZpYiiN4OJyZykgZpQs+S4lZcT1nvC49Meqr8oxPkYn?=
 =?us-ascii?Q?vmZMQKSA1wVPMoJFdp6sTrvGJEiWFQ3jgFuTdchrea3OK1B0Eqa5jy4g3X66?=
 =?us-ascii?Q?pI4RMPoVKvZg29ivVOh9kjDNxFGLvDubQbWXK3zJ0tFN/mUWu7vy+iG62Eoe?=
 =?us-ascii?Q?Cd05rNMQpoau0vPYpGMP17TSxvU12SMfu+6Vc+KKohhyL7oCMhsx61YJvohS?=
 =?us-ascii?Q?1fLJIwX3tIj+LgQW1iMNOmrOXLNIXrk9rwmSGJNEfzls/5tDqQ/6o7y3Smdg?=
 =?us-ascii?Q?jNeqW5xI+DuuSLGIBWWH76FiV63o0jMLxS7/7cEUoQrRQZuEDR/gj8FetJBy?=
 =?us-ascii?Q?625ej+nHM3HixK4jYW+j24frnEwGX2uyUGT33DlMFFXdyUCUxtOjkiiyCS5q?=
 =?us-ascii?Q?8I1oKUYE3N2qbEJtI8tvfa3ZFQG8aAVWpvKT3voXu90I94Rb57PCzm/ePXY/?=
 =?us-ascii?Q?K5LA3zHaAr214/paumbqZwde74M57U4Mhl6ZRuXtQNuwquA9S2HP6Nje32Vk?=
 =?us-ascii?Q?E2G5P+kMJ2Evdwd3XMRBOfLhcCCyoi6sqxoRZ+RLI/5IHhe2ksGOcr3HhwXU?=
 =?us-ascii?Q?FO4hB+OY+VdarmJn6JuOQtqd6xswPr90HB0rzM4oIujxHydnMub8n8uwFxp1?=
 =?us-ascii?Q?u454bbMpiGCCgeBNZzKCSVUXzjKJyykAjDZUZN7TH8GxYyb+Vc20oeLOV149?=
 =?us-ascii?Q?b1iOKS8gtoQprms4nQptcSeVWsUl/gq7iIiVDEW6q3+bfpQ6CiPmr0WWHL3g?=
 =?us-ascii?Q?lfp4XMsjqFC2rrhM3WaPpp25edcESq8Fl/z6vfY+xIaXEs4l4s37mjyDIxmt?=
 =?us-ascii?Q?ReAB4Bkxw5S5TTO7QYstIKde4vGH1o+gZHvFwF6qujvkOTiws8YlU7YU+1Ru?=
 =?us-ascii?Q?LqUa8T35lbmX7PhgScdSL88OlVJhHmAi8pbA4D6Rb14U0xemlncqNVjR4K4R?=
 =?us-ascii?Q?lt5ZsAV5M2oPqwzIvokacVQcR4uWdx8vGNuQH3dtzhU5ZRUuQ7w3cleDEv0u?=
 =?us-ascii?Q?OAxThs8wZ6TWN3Id81PsyEhtwYpLGBU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7549e53e-8777-453a-19b8-08df099d21e6
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:24:19.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJrizHD3KQJrmwOPDATjq/ddlulJ/4FlAkVmCgFRIZyc/373x1iJ7GbCvRxH6yAP3pnGwY1BdVz/5Y5rd4BNZtj5rJSbWjkJ7KBqEhs1r5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0680

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


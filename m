Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2094.outbound.protection.partner.outlook.cn [139.219.146.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304741D11F;
	Sat, 29 Aug 2026 20:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788037002; cv=fail; b=Zmm2F7HRUkQILEOLVWgjCQM40Bq9fAlguSlbWsocoLlrcVFOFaJ36yjnrVoZvyovoOsozDTflXMYRwgTnJvk5enA5fsFniwZGROweF0pxAyMVAzqwujbisaclSloLgZgCXtketm3osBYyKSouT/Q9wpajO78h7QU1RMopMa56NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788037002; c=relaxed/simple;
	bh=JkGCKLtdrjDRUEpXIrE0pUdOwxPSotQ8FQPjxKln2zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tqVD4M0j5uaIOm7JuYSbbU4Ef60QVagiXi8vvSVH/JYE2tbqnr9rLt67NC6KKi0zRiIsiURTdki73X+leFOXN1RBUu9LkakB4ZIvZGiEGfx5J035Vt5HK+EOHqgCVpHO4Jp5PHqZtchzYkla4rz9jnufIdGV3ro1xSDjkE6Ls7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRjAx9PA+v60wCal+43tdB/UNopFoFrToWP2lSxoPf/6FFJVNEwNwo4Dquo8FR2x969NiwuEosjCuPpJfuRfKi0R0/wbmrYG6145mYAgbxkRa/j8KAXpGDoiqyBKnnELUDpF0A72otMIeaZCb4hHMPteK+QZPb9kXPpUs+o8rPKWzg7H8656Xx6FaSWUF2x14UXr5yZ2kxqm5GgNOFpnpyGI23jtk7oyZNbxQZrOuRvZ7c/Dy042wkm7iCvikkwqHVMAC97UuBMsqimPhAA642oK3dxNO9rmkOBaFWs00DwlXKEBzaVZVh4xULMpLtvfasDEDQiW6G2UvTzHjZTvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/xrRYmp0VqEpZfuweO5dC9aM1cnQOoaEKfhUG2PMQI=;
 b=DglbvM1dQNiHlNUIwPk4Qf0bSpVYujMTSKOC+OJiLsDyWqkN8yokjJph7zdMzupe4sNPtMw9TcXbnl3k126d/KHTEQIgX5AzcaWS56gDitd8rO8B5qzk1sd2/ZWffW8CdN+tEyzJ+g9nW+7ywZQBSqAkHKkdY+fSnuLEVGZ4L9lWT/30YXX1G93q1JwfPYwyL7BtmuW23MPcG2x0SBg6XmuWYaRvKfhqayCpUnlnLkWusekT4YqRCxAnNpduaAQBoEGHR5pyfa6r5S/VH0YNd4okohK0ODsvr2qd4/ik9HKHVm4oYL1TarV2o//rjQFJysePfjEMfuI80jWZPcZmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0709.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sat, 29 Aug
 2026 20:56:31 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Sat, 29 Aug 2026 20:56:31 +0000
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
Subject: [PATCH 2/2] pmdomain: riscv: Add RPMI device power service
Date: Sun, 30 Aug 2026 04:55:19 +0800
Message-ID: <20260829205520.1691-3-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260829205520.1691-1-joshua.yeong@starfivetech.com>
References: <20260829205520.1691-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0062.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::29) To BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0838:EE_|BJXPR01MB0709:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bee869a-87d4-45fe-d56a-08df061000b5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|1800799024|7416014|376014|366016|18002099003|56012099006|10067099003|3023799007|22082099003|38350700014|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	c27Ogx53jXbUw7XNVNN//cEm+s5tBC7UUJsB6aMCIpnDZwUGtcHOA3mH+w6fePrWCAn3KZ1AzvunJUK1QwukRmByYoL2o3CanTsoYaCMXqRsxfxPymnT9SfpHlfS0h0daD+0CmwkPf8SCmovg9NmQgbx7uFP+MRU6w5kVcM9ECNYsnyhC0n+UCMh2KvyWeZmPbKilobSddoRBcDmFkweoyIkXVl0tYWBuXuSGXUzL8PviHqTTamXZr5JBuMwhUJIagJD6a030RH9YH77JwH7H6iF9Rbdoma2nHxvunGYUEkAcvlmkvvZ79h2YVb/FPaYODSmt4XiPCk9Tcj0y2VXo+FaCf5E+BfsNYBV9e3DINC2M8ujrhp2l3pmWflP0Ao1xQx5yiUfTQ0bMLzf6XRUBZwRwF4rs/scQDJ07+E+iLDpA8f+2LcLvxYUSZ44yLcfqAy8V9H3WOe18NjdKPugHHnnNat5lG0oz7yDz2AfV4pP9HzTRjgxoRpVIbxNER73d/u2KOiGULuMMvNB0FwXjfTdKLoSxqJlKt5/bQqL07sKRw2AsoduZU1FfcVKoPaoeoEsWNpbgKdgJPIi4TKDyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(56012099006)(10067099003)(3023799007)(22082099003)(38350700014)(6133799003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QOIxXV3yeBFFYMFaZN0W+j/MvV4tyV8xPqmd0n8CFyYeVD8fmn0txQhvWP9f?=
 =?us-ascii?Q?JVYbByuYxz6qQKCc0uYYNLgLtLZwl0ju3Sj3qJPCgXsphBUpnCZ5F+NImN06?=
 =?us-ascii?Q?xic4A8CoXtn4dmd2H3RgOyaM3qF+JS7LZC5r6BTXWohVe+k21teBveSVpFyt?=
 =?us-ascii?Q?SqBsvZPWFIneRVFCZQTDgPmT8SVr9QfLCCqMxzN4xTdWEUOpr1ajsckrmxIv?=
 =?us-ascii?Q?GNnBNDGD71wFYOl+z4/hLS9oOtmOKTPg89T5q5rFR9v7+7voFyU6x8tK1Wz8?=
 =?us-ascii?Q?mwEODNq5c1GznyvG1OUZYTb8sYzn7//ak2xqdZEM64riKRoKVV6Yf1gQDwHP?=
 =?us-ascii?Q?VUkmay4vdTPM+mxZP0kGXO8VxDC2ToBkjMNWEnMmcA5Y7I0BhplFldrsDtgh?=
 =?us-ascii?Q?/pFi63rOPMCb8dK4WDPRbaZjwTapLdmb7WFlaQ5JPjJdp0yTw4TgwWssvDmm?=
 =?us-ascii?Q?3Klrd/n1R+lp8NhK3+nz14UcgYpMZHXjYXgkXj7f/bF2a8/tcI1kiiaGyf8k?=
 =?us-ascii?Q?qHdnRJ6Ll9eHA5D1CF0wuq16r7KvlR2wkqGAMVJCZDqHUCTtAsYcBlwPrmvT?=
 =?us-ascii?Q?d9qUv5HK4MwFgf7eJPTYwfuqCDWP8mHh3N6NSo2AnnNQZ0RzqeXUGhqV3pYc?=
 =?us-ascii?Q?vQukwBYMivbuyk2OQQJNVfjkuM8lwNT/wbXH6JCMbf4ssXHGODCFCsgUfWsv?=
 =?us-ascii?Q?67gCziJVajGAw7FmVy1e+9erPr0W1F0nF25nYIGzCAdA3gcVLPKckNMndQZ4?=
 =?us-ascii?Q?beH35J/hUhNqCHMttGqaXPxK0xNduewx+NkOTNhvD2r2P1mywEYI+2ufvEx5?=
 =?us-ascii?Q?SFn7MJ4OCU6aoACnTmtOvU9+qRdOpEKk7OKTFIO2mwg9eBvxvAyR71OGFWXt?=
 =?us-ascii?Q?PuM+xS74OBOkXEL3bAsHpJgd8khLu+JkuyejZtrIxzWqEB/RfSz/LoAUGod8?=
 =?us-ascii?Q?fJV4mzD6tQ2JIyTOtzVmxEslqqGG8oHzCNuhuisXoMl37SAvD2GUcGNtbtnx?=
 =?us-ascii?Q?TScCPokPmE+62j7cfzhuI7MVflCEFctIWPaFlNU8irhMHZGaKQA1oCzjPGCZ?=
 =?us-ascii?Q?QoaUfLam8NsNs/b8ZTuZGVkDwSa6lOqrqC1U0ly4C6e28h9Gs5KgDxkqLwAa?=
 =?us-ascii?Q?nQQEM/2lvzUSZx9awb46PB1xwFyufUUE/lGDU3lo7d0ikKXQZKbspYRADEFJ?=
 =?us-ascii?Q?Yz/6lL7q9Qhmpp0cyLIj1AP9HkSll5JfjkqzQ42yXJfmNCYJ4BoGBG5eDeVZ?=
 =?us-ascii?Q?IMZ4vWkLT9tiutuJeNClNpJdDumWNGnEmwO87C5JcXMaculd0PXCMnE6b5t+?=
 =?us-ascii?Q?493II+9d3GXLd0sYPuQC1tSoYmFebGtrD/szzTKv6kg+DH0aFmMGVwGAZ41c?=
 =?us-ascii?Q?25xz8aZu6LC2lkf64f/q7N7bevz1Qpv+ZXvZS602ptCFMG8/Is+A9g8qQdXF?=
 =?us-ascii?Q?iffFYsl4cIWCTp32XA0URUAXkEXGQWh8VdZQVIo91gwJYGSgev6DXr/ic09A?=
 =?us-ascii?Q?ofmlKXjkEi3zJjvxF1ONLZXzUNDqyMKQ5bT/dJ73smkLXU0+5usHHkkIgM2t?=
 =?us-ascii?Q?4CfGHvcH9n+1O3kjbMNDs1OL5tLEsBvRdn20aULvyOFfgGR7BCpOnjja8LCZ?=
 =?us-ascii?Q?o2DvpGPFg8m32NKve2JMXiCSS5sMzryuoJ25L9Jds0v8Pd+99PF3iAWS6wsC?=
 =?us-ascii?Q?Ed6aCjZuha2ZuBDjzYcHh6wN/ytnasee7tgdAVAozjo2YXfCuFWWy1SHDJ2B?=
 =?us-ascii?Q?KP/7IVxKGaQfM75yMm8azcDIaz1pr2Y=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bee869a-87d4-45fe-d56a-08df061000b5
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2026 20:56:31.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHj7H0kSyaEeuAFDqLp3SWtGc56SSRr9j3qp5RSkEJZSN+L772oVYLBykFn6w9oCrH26hXUYWO2NCs+vVugoRvner6sBhpT91AcYBUPRpDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0709

Add a generic power domain provider on top of the RISC-V Platform
Management Interface (RPMI) device power service group, reached through
an SBI MPXY channel.

The driver enumerates the device power domains advertised by the
platform microcontroller, queries their attributes and initial state,
and registers them as an onecell genpd provider so that devices can
reference them through the "power-domains" property.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 MAINTAINERS                                   |   4 +
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/riscv/Kconfig                |  13 +
 drivers/pmdomain/riscv/Makefile               |   3 +
 .../pmdomain/riscv/riscv-rpmi-device-power.c  | 441 ++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h    |  11 +
 7 files changed, 474 insertions(+)
 create mode 100644 drivers/pmdomain/riscv/Kconfig
 create mode 100644 drivers/pmdomain/riscv/Makefile
 create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-device-power.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..726d4637c074 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23296,6 +23296,7 @@ F:	drivers/perf/riscv_pmu_sbi.c
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
 M:	Anup Patel <anup@brainfault.org>
+M:	Joshua Yeong <joshua.yeong@starfivetech.com>
 L:	linux-riscv@lists.infradead.org
 F:	Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
 F:	Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
@@ -23303,9 +23304,12 @@ F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system
 F:	Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
 F:	Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
 F:	Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
+F:	Documentation/devicetree/bindings/power/riscv,rpmi-device-power.yaml
+F:	Documentation/devicetree/bindings/power/riscv,rpmi-mpxy-device-power.yaml
 F:	drivers/clk/clk-rpmi.c
 F:	drivers/irqchip/irq-riscv-rpmi-sysmsi.c
 F:	drivers/mailbox/riscv-sbi-mpxy-mbox.c
+F:	drivers/pmdomain/riscv/
 F:	include/linux/mailbox/riscv-rpmi-message.h
 
 RISC-V SPACEMIT SoC Support
diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 23076ae90e66..5341dff669be 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -11,6 +11,7 @@ source "drivers/pmdomain/marvell/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
 source "drivers/pmdomain/qcom/Kconfig"
 source "drivers/pmdomain/renesas/Kconfig"
+source "drivers/pmdomain/riscv/Kconfig"
 source "drivers/pmdomain/rockchip/Kconfig"
 source "drivers/pmdomain/samsung/Kconfig"
 source "drivers/pmdomain/st/Kconfig"
diff --git a/drivers/pmdomain/Makefile b/drivers/pmdomain/Makefile
index ebc802f13eb9..d7aee13ae571 100644
--- a/drivers/pmdomain/Makefile
+++ b/drivers/pmdomain/Makefile
@@ -9,6 +9,7 @@ obj-y					+= marvell/
 obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
+obj-y					+= riscv/
 obj-y					+= rockchip/
 obj-y					+= samsung/
 obj-y					+= st/
diff --git a/drivers/pmdomain/riscv/Kconfig b/drivers/pmdomain/riscv/Kconfig
new file mode 100644
index 000000000000..5c2ef53218a3
--- /dev/null
+++ b/drivers/pmdomain/riscv/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RISCV_RPMI_DEVICE_POWER
+	bool "RISC-V RPMI Based Device Power driver"
+	depends on MAILBOX || COMPILE_TEST
+	default RISCV
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Support for device power domains based on the device power service
+	  group defined by the RISC-V platform management interface (RPMI)
+	  specification. The power domains advertised by the platform
+	  microcontroller are registered as generic power domains, so that
+	  devices can reference them through the "power-domains" property.
diff --git a/drivers/pmdomain/riscv/Makefile b/drivers/pmdomain/riscv/Makefile
new file mode 100644
index 000000000000..2cb0ee8ad413
--- /dev/null
+++ b/drivers/pmdomain/riscv/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_RISCV_RPMI_DEVICE_POWER)	+= riscv-rpmi-device-power.o
diff --git a/drivers/pmdomain/riscv/riscv-rpmi-device-power.c b/drivers/pmdomain/riscv/riscv-rpmi-device-power.c
new file mode 100644
index 000000000000..f34ef48dff39
--- /dev/null
+++ b/drivers/pmdomain/riscv/riscv-rpmi-device-power.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * RISC-V RPMI Based Device Power Driver through SBI MPXY
+ *
+ * Copyright (C) 2026 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Implements a Device Power driver on top of SBI RPMI Message Proxy Extension (MPXY)
+ *
+ * Each SBI MPXY Device Power instance is associated, through the means of a proper DT
+ * entry description, to a specific Transport ID.
+ */
+
+#define pr_fmt(fmt) "riscv-rpmi-device-power: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+
+#define RPMI_PM_DOMAIN_NAME_LEN		16
+
+/* power state for device power domains */
+#define RPMI_POWER_STATE_CONTEXT_MASK		GENMASK(16, 16)
+#define RPMI_POWER_STATE_CONTEXT_PRESERVED	0
+#define RPMI_POWER_STATE_CONTEXT_LOST		1
+#define RPMI_POWER_STATE_VALUE_MASK		GENMASK(15, 0)
+#define RPMI_POWER_STATE_VALUE_ON		0
+#define RPMI_POWER_STATE_VALUE_OFF		3
+
+#define RPMI_POWER_STATE_PARAM(context_type, state_value) \
+	((FIELD_PREP(RPMI_POWER_STATE_CONTEXT_MASK, context_type)) | \
+	(FIELD_PREP(RPMI_POWER_STATE_VALUE_MASK, state_value)))
+
+#define RPMI_POWER_STATE_GENERIC_ON  \
+	RPMI_POWER_STATE_PARAM(RPMI_POWER_STATE_CONTEXT_PRESERVED, \
+				   RPMI_POWER_STATE_VALUE_ON)
+
+#define RPMI_POWER_STATE_GENERIC_OFF  \
+	RPMI_POWER_STATE_PARAM(RPMI_POWER_STATE_CONTEXT_PRESERVED, \
+				   RPMI_POWER_STATE_VALUE_OFF)
+
+struct rpmi_ctx {
+	struct mbox_chan *chan;
+	struct mbox_client client;
+};
+
+/**
+ * struct rpmi_device_power_domain - describe one available MPXY Device Power Domain
+ *
+ * @id: the power domain ID as advertised by PuC
+ * @transition_latency: worst case transition latency of power domain from one state
+ *			to another
+ * @dev: device associated with this power domain
+ * @name: device power domain name assigned by PuC
+ */
+struct rpmi_device_power_domain {
+	u32 id;
+	u32 transition_latency;
+	struct device *dev;
+	struct rpmi_ctx *mpxy_ctx;
+	struct generic_pm_domain genpd;
+	char name[RPMI_PM_DOMAIN_NAME_LEN];
+};
+
+#define to_rpmi_pd(gpd) container_of(gpd, struct rpmi_device_power_domain, genpd)
+
+/* Service: ENABLE_NOTIFICATION */
+struct rpmi_pm_enable_notification_tx {
+	u32 event_id;
+};
+
+struct rpmi_pm_enable_notification_rx {
+	s32 status;
+};
+
+/* Service: GET_POWER_DOMAINS */
+struct rpmi_pm_get_num_domain_rx {
+	s32 status;
+	u32 num_domains;
+};
+
+/* Service: GET_POWER_DOMAIN_ATTRS */
+struct rpmi_pm_get_domain_attrs_tx {
+	u32 domain_id;
+};
+
+/* pm domain attributes response data */
+struct rpmi_pm_get_domain_attrs_rx {
+	s32 status;
+	u32 flags;
+	u32 transition_latency;
+	char name[RPMI_PM_DOMAIN_NAME_LEN];
+};
+
+/* Service: SET_POWER_DOMAIN_STATE */
+struct rpmi_pm_set_power_state_tx {
+	u32 domain_id;
+	u32 power_state;
+};
+
+struct rpmi_pm_set_power_state_rx {
+	s32 status;
+};
+
+/* Service: GET_POWER_DOMAIN_STATE */
+struct rpmi_pm_get_power_state_tx {
+	u32 domain_id;
+};
+
+struct rpmi_pm_get_power_state_rx {
+	s32 status;
+	u32 power_state;
+};
+
+static int rpmi_power_state_get(struct rpmi_device_power_domain *mpxy_pm_domain,
+				u32 domain_id, u32 *state)
+{
+	struct rpmi_pm_get_power_state_tx tx;
+	struct rpmi_pm_get_power_state_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(domain_id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_GET_STATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	ret = rpmi_mbox_send_message(mpxy_pm_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	*state = rx.power_state;
+
+	return ret;
+}
+
+static int rpmi_power_state_set(struct rpmi_device_power_domain *mpxy_pm_domain,
+				u32 domain_id, u32 state)
+{
+	struct rpmi_pm_set_power_state_tx tx;
+	struct rpmi_pm_set_power_state_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(domain_id);
+	tx.power_state = cpu_to_le32(state);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_SET_STATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(mpxy_pm_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	return 0;
+}
+
+static int rpmi_pd_power(struct generic_pm_domain *domain, bool power_on)
+{
+	struct rpmi_device_power_domain *mpxy_pm_domain;
+	u32 state, ret_state, domain_id;
+	int ret;
+
+	if (power_on)
+		state = RPMI_POWER_STATE_GENERIC_ON;
+	else
+		state = RPMI_POWER_STATE_GENERIC_OFF;
+
+	mpxy_pm_domain = to_rpmi_pd(domain);
+	domain_id = mpxy_pm_domain->id;
+
+	ret = rpmi_power_state_set(mpxy_pm_domain, domain_id, state);
+	if (!ret)
+		ret = rpmi_power_state_get(mpxy_pm_domain, domain_id, &ret_state);
+	if (!ret && state != ret_state)
+		return -EIO;
+
+	return ret;
+}
+
+static int rpmi_pd_power_on(struct generic_pm_domain *domain)
+{
+	return rpmi_pd_power(domain, true);
+}
+
+static int rpmi_pd_power_off(struct generic_pm_domain *domain)
+{
+	return rpmi_pd_power(domain, false);
+}
+
+static int rpmi_pm_get_num_domains(struct rpmi_ctx *mpxy_ctx, u32 *domain)
+{
+	struct rpmi_pm_get_num_domain_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_GET_NUM_DOMAINS,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	*domain = rx.num_domains;
+
+	return 0;
+}
+
+/* obtain the MPXY device power domain attributes */
+static int rpmi_device_power_get_attrs(u32 domain_id,
+				       struct rpmi_device_power_domain *mpxy_pm_domain)
+{
+	struct rpmi_pm_get_domain_attrs_tx tx;
+	struct rpmi_pm_get_domain_attrs_rx rx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(domain_id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_GET_ATTRS,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_mbox_send_message(mpxy_pm_domain->mpxy_ctx->chan, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(rx.status);
+
+	mpxy_pm_domain->transition_latency = rx.transition_latency;
+	strscpy(mpxy_pm_domain->name, rx.name, RPMI_PM_DOMAIN_NAME_LEN);
+
+	return 0;
+}
+
+static int rpmi_pm_attr_setup(struct device *dev, struct rpmi_ctx *mpxy_ctx)
+{
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	/* Validate RPMI specification version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SPEC_VERSION);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get spec version\n");
+		return ret;
+	}
+
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		dev_dbg(dev,
+			"msg protocol version mismatch, expected 0x%x, found 0x%x\n",
+			RPMI_MKVER(1, 0), msg.attr.value);
+		return -EINVAL;
+	}
+
+	/* Validate device power service group ID */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get service group ID\n");
+		return ret;
+	}
+
+	if (msg.attr.value != RPMI_SRVGRP_DEVICE_POWER) {
+		dev_dbg(dev,
+			"service group match failed, expected 0x%x, found 0x%x\n",
+			RPMI_SRVGRP_DEVICE_POWER, msg.attr.value);
+		return -EINVAL;
+	}
+
+	/* Validate device power service group version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION);
+	ret = rpmi_mbox_send_message(mpxy_ctx->chan, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get service group version\n");
+		return ret;
+	}
+
+	if (msg.attr.value < RPMI_MKVER(1, 0)) {
+		dev_dbg(dev,
+			"service group version failed, expected 0x%x, found 0x%x\n",
+			RPMI_MKVER(1, 0), msg.attr.value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void rpmi_pm_domain_mbox_chan_release(void *data)
+{
+	mbox_free_channel((struct mbox_chan *)data);
+}
+
+static int rpmi_pm_domain_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct rpmi_device_power_domain *mpxy_pd;
+	struct genpd_onecell_data *mpxy_pd_data;
+	struct generic_pm_domain **domains;
+	struct device *dev = &pdev->dev;
+	struct rpmi_ctx *mpxy_ctx;
+	u32 num_domains = 0;
+	int ret;
+	u32 i;
+
+	mpxy_ctx = devm_kzalloc(&pdev->dev, sizeof(*mpxy_ctx), GFP_KERNEL);
+	if (!mpxy_ctx)
+		return -ENOMEM;
+
+	/* Setup mailbox client */
+	mpxy_ctx->client.dev		= dev;
+	mpxy_ctx->client.rx_callback	= NULL;
+	mpxy_ctx->client.tx_block	= false;
+	mpxy_ctx->client.knows_txdone	= true;
+	mpxy_ctx->client.tx_tout	= 0;
+
+	/* Request mailbox channel */
+	mpxy_ctx->chan = mbox_request_channel(&mpxy_ctx->client, 0);
+	if (IS_ERR(mpxy_ctx->chan))
+		return PTR_ERR(mpxy_ctx->chan);
+
+	ret = devm_add_action_or_reset(dev, rpmi_pm_domain_mbox_chan_release,
+				       mpxy_ctx->chan);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add rpmi mbox channel cleanup\n");
+
+	ret = rpmi_pm_attr_setup(dev, mpxy_ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to verify RPMI attribute\n");
+
+	/* Get number of device power domain */
+	ret = rpmi_pm_get_num_domains(mpxy_ctx, &num_domains);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get number of pm domains\n");
+
+	if (!num_domains)
+		return dev_err_probe(dev, -EINVAL, "No PM domains found!\n");
+
+	dev_info(&pdev->dev, "%d MPXY PM domains are found\n", num_domains);
+
+	mpxy_pd = devm_kcalloc(&pdev->dev, num_domains, sizeof(*mpxy_pd), GFP_KERNEL);
+	if (!mpxy_pd)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(&pdev->dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	mpxy_pd_data = devm_kzalloc(&pdev->dev, sizeof(*mpxy_pd_data), GFP_KERNEL);
+	if (!mpxy_pd_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++, mpxy_pd++) {
+		u32 state;
+
+		mpxy_pd->dev = &pdev->dev;
+		mpxy_pd->mpxy_ctx = mpxy_ctx;
+		mpxy_pd->id = i;
+
+		ret = rpmi_device_power_get_attrs(i, mpxy_pd);
+		if (ret) {
+			dev_warn(mpxy_pd->dev,
+				 "power domain %d initialization failed\n",
+				 mpxy_pd->id);
+			domains[i] = NULL;
+			continue;
+		}
+
+		ret = rpmi_power_state_get(mpxy_pd, i, &state);
+		if (ret || (state != RPMI_POWER_STATE_GENERIC_OFF &&
+			    state != RPMI_POWER_STATE_GENERIC_ON)) {
+			dev_warn(mpxy_pd->dev,
+				 "failed to get state for power domain %d\n",
+				 mpxy_pd->id);
+			domains[i] = NULL;
+			continue;
+		}
+
+		mpxy_pd->genpd.name = mpxy_pd->name;
+		mpxy_pd->genpd.power_off = rpmi_pd_power_off;
+		mpxy_pd->genpd.power_on = rpmi_pd_power_on;
+
+		pm_genpd_init(&mpxy_pd->genpd, NULL,
+			      state == RPMI_POWER_STATE_GENERIC_OFF);
+
+		domains[i] = &mpxy_pd->genpd;
+	}
+
+	mpxy_pd_data->domains = domains;
+	mpxy_pd_data->num_domains = num_domains;
+
+	platform_set_drvdata(pdev, mpxy_pd_data);
+
+	return of_genpd_add_provider_onecell(np, mpxy_pd_data);
+}
+
+static void rpmi_pm_domain_remove(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct genpd_onecell_data *mpxy_pd_data;
+	unsigned int i;
+
+	of_genpd_del_provider(np);
+	mpxy_pd_data = platform_get_drvdata(pdev);
+	for (i = 0; i < mpxy_pd_data->num_domains; i++) {
+		if (!mpxy_pd_data->domains[i])
+			continue;
+		pm_genpd_remove(mpxy_pd_data->domains[i]);
+	}
+}
+
+static const struct of_device_id rpmi_pm_domain_of_match[] = {
+	{ .compatible = "riscv,rpmi-device-power" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, rpmi_pm_domain_of_match);
+
+static struct platform_driver rpmi_pm_domain_platdrv = {
+	.driver = {
+		.name = "riscv-rpmi-device-power",
+		.of_match_table = rpmi_pm_domain_of_match,
+	},
+	.probe = rpmi_pm_domain_probe,
+	.remove = rpmi_pm_domain_remove,
+};
+
+module_platform_driver(rpmi_pm_domain_platdrv);
+
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_DESCRIPTION("Device Power Driver based on RPMI message protocol");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index e135c6564d0c..d5362b5821f9 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -93,6 +93,7 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 /* RPMI service group IDs */
 #define RPMI_SRVGRP_SYSTEM_MSI		0x00002
 #define RPMI_SRVGRP_CLOCK		0x00008
+#define RPMI_SRVGRP_DEVICE_POWER	0x00009
 
 /* RPMI clock service IDs */
 enum rpmi_clock_service_id {
@@ -119,6 +120,16 @@ enum rpmi_sysmsi_service_id {
 	RPMI_SYSMSI_SRV_ID_MAX_COUNT
 };
 
+/* RPMI device power service IDs */
+enum rpmi_device_power_service_id {
+	RPMI_DP_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_DP_SRV_GET_NUM_DOMAINS  = 0x02,
+	RPMI_DP_SRV_GET_ATTRS = 0x03,
+	RPMI_DP_SRV_SET_STATE = 0x04,
+	RPMI_DP_SRV_GET_STATE = 0x05,
+	RPMI_DP_SRV_ID_MAX_COUNT,
+};
+
 /* RPMI Linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION,
-- 
2.43.0


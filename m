Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED183BBFBB;
	Sun, 30 Aug 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103735; cv=fail; b=MFf7meyokGtTpxZ1O9k9lWiCw60qTZwZZ2p5xXI3mEBlkCXzrwVE9tUuO7QeR/ACkCZJHS8HggXTt0/a7q+WQKsEh7u9cP4Co1a53f8d1TTiH5nvGvwY1DKwN6QjY7XGNO9t4Xq0IbArv2PouNdZSRqxapyFzm3hM3dGkJ2xcKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103735; c=relaxed/simple;
	bh=kmmjv/goECh/EUrg+ltiAs9l+2XYISaFyLFE4DC5v2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnpPC+6ilQ/1qVQo2R3ijsHJls6cdHspjTLbg9KGyM75i2w8ZZGIT3dyid5Pz6cTXkF+lH5emiO3BcwvtdF6qYKDnfFPn2xm9DuBQaQit7DtQU7iLr3VKhnV+EmF293LY7SSlFEfawu6QDcAv/f6nvNPZN2zXU/sQu6Tw/wwuT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nc4B2YO5xd8m301cUNcrcYsTDbiGeBWsSMa1S4t5VsAuRSB4fVD2XLywzBo4gSqmFjp0qs9OOwZHwca5p6gi4+LS+4ArnAKzaTQQ2oTNhYVOdZK/1t1ZLsQFfX992tY9q4efIkuJgChaiKguSGalsr5SmZFq9kU4nToxKqOWcL5nswRslt5WKXi8ydH8fwkoRDPfQSMhC4cfOj0aJH+jDfFKkmURpz325U76YnkB0K0/1EuQKRU61STOxbJTgmb4V5vGmLnA5IvVU39pV9o7t4lcDsRnhgNNKZgGOMj2AZpReuwdkYmFg+40xI90Jk/5Ubg5eqqAiVtKeXzTGwHurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hKjNNwAu48GZGiA/AlrT02CdQQqjnoOvVFmVjpsTFk=;
 b=fwFixo0kM2RYA8Iu4fLzsxEKtQN/mGl5chqBAJO+Lz4sgkmf0TTo5wQDALrOfZvGHKjzuncr7TOHou9NKb7mK28umWsAjTUI8lZ8fbz9TktyDw1nity4+k8fFNTfeM55ZPuXLx2bbrb2hn3YcX4csyFHOaK6RbuL78IFTpJMT1vckORTnmTMiuX8O7aTP/74otlXuKJxQBwv85S+Njubu6qk9+dsmdA40rMIVVZbCBU6WZuxtI3gPKecq4P8Ldhgfc/pKj2oXjkAj3pZOJECuRpowgXWVz0R0oJcN8mnJJx82eOr/QWlncbDLJ9fMGOoLJe/7cgnfqNCsAld+2jIQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0821.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Sun, 30 Aug
 2026 15:28:43 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Sun, 30 Aug 2026 15:28:43 +0000
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
Subject: [PATCH v2 2/2] pmdomain: riscv: Add RPMI device power service
Date: Sun, 30 Aug 2026 23:28:12 +0800
Message-ID: <20260830152812.312663-3-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 26a7020b-d7d8-4514-b54b-08df06ab6005
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|7416014|366016|376014|1800799024|921020|6133799003|38350700014|10067099003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SnQm4/TI6A/cgz9u4w4S0TT0OeUjJ6wno4gKgzvE/jeGoe/XLyv/YyoO4apSylfWjvnzYVB34VTAQVvsdz4Z/OEiCCn+A1n91iHgjtKOtZ7MdvaHXGxQ7IOvolSPnr9IlAzFYhvYQNeNKY2kF2RT06f2RUhq9NPV+Z7ioC1SQiUfeeozLyZuMV4/o3kOJbC/+G5qQ24asf1pbLM6o0vrTIqirTHqvTxzSVn9bA7hGRAxZsfzbxmWXrepYZUoI68P+RVtp4yVZyhXLfW0qIuyIvfB8JI70E1YI4n+/DJJ8vLfjSnyGiKFZ1AEaR/I+rpAmFvBHz61C7ywFw0ZycZnIRZrKMegAG3GP3pyacHm5ANVZWg33uz7+PY9q0ZoMdhtPw2JLYB/kA931Dnm5UdAuJuvn5U2BC3V+SDIwkpPBDdrqY3ofs+dlXgJUrH5pCiLxPAW4K7jqKJZMNPrhvERpSO66RclBlVc3tsRjl01VY80x7rgxdIe9U/19EOTgvXxnQh3XrpeYKpb9vfcok6ZLOmv1tXsV/Npv7QaOs40k/Ei+kkpqvFWEwy0311Ie3+2t8KUT+YrpCQH8SWt15XtEw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(7416014)(366016)(376014)(1800799024)(921020)(6133799003)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M2GAm7UxlJ8ePtrZflLEA4JqDuvrDOjdKQ+i7sK7VdrK7c7wwVGlnbAzygsv?=
 =?us-ascii?Q?02HoJqz5dpomy8XNa+bdqtMYXu3N92ZoauapzcRNXUO8uXhYtGpreFcYG8m9?=
 =?us-ascii?Q?LizNGR/qNWmfb9SoMaUO7mMOxhSSgsbDxUNFQVHToR/NvHULdGiKiBPzEHAT?=
 =?us-ascii?Q?SPWTV+Gqr2tAWZ3O0zsfxaw/msqKuq9TCFdGwLss7YeJcMmVYJqoFaKgJk9f?=
 =?us-ascii?Q?UPkQH98iJWD1AypZBSUX5iZovdCtp+CbYwtRcUZRb86O674rWmdYBnAVS7Uk?=
 =?us-ascii?Q?HGGD53j9pexoICjF9eg4ab4fNxl4hYNpfbLHXoxtUwVxp4dBA7MRpXJvgspq?=
 =?us-ascii?Q?Pwxj9gs00DF26n3Iy9+zOnDKclc4CsgwZ6iw6PK10c3X41NpFAMoyp6wWRVX?=
 =?us-ascii?Q?HicaLrZVeTe/VR2l78vshSiJWwZ4q9aL7ZC1JDX/duj3Sb3kLO6vYuzTj3f6?=
 =?us-ascii?Q?QtKXN+7RSXtf6OaxzFSMtXNL5vfHZhAeUcTntHfAlcoxzKSIwzLLS57ISDoM?=
 =?us-ascii?Q?wneim9bmdC4htrL0q17oPcl8j03pfuZvnLKB4TPBdPCaagdONq/XF92t08+l?=
 =?us-ascii?Q?FibIJHT6EfVSiKIc5Q+FV0bNHAmS77YFLsXwKNMF4qnwA3S4dOyjXeAd9dTs?=
 =?us-ascii?Q?TkLEI/YBVvqpL3hf8wWToHmpu2RECbrCBCbw92i3+HIeF2fixqSJ1tPx+XAw?=
 =?us-ascii?Q?NTtH7p+Jblzl0/zPP2N6pq+7pHS6TglyJVG7/AII+R9kAZUaHyfinWfhWjIG?=
 =?us-ascii?Q?kobFirQ5WtxQj2Lt/52QEqmHf6vk3NDkeeaBtvMcLZGWD91pZQcjfxV719GX?=
 =?us-ascii?Q?64QFWvBbIcdE8x0oC5hHSwYKKa842cDUntE3DuQ2PuNqm4peMwXMRo2LD2fw?=
 =?us-ascii?Q?l/VgkaSzYj4WIepIWtBSVQqGHrfcPrUNrYP/WVP33kEXPJB0Y4+9nQEbi/5P?=
 =?us-ascii?Q?Ze4jDH59KzPy/HJnlo+X/dkc6xoJS9E6lk5RVHcd3Ths/U3lmu5LjZaQH7y1?=
 =?us-ascii?Q?sS0pCDz1z6tvS72C6UeY7BxYUpWORfsb439EUkVaRwuIquMA/xClsx/DBQ32?=
 =?us-ascii?Q?Lr3H9qrlm8lL0GG+9Bpz+shzvtbsbXUlzE8sSd0Njb6mMPJYgdzy57M295Bt?=
 =?us-ascii?Q?wk0Gnqw1B1LJR8lJ07MW7mv5BpEL5NA8k1GegFqeuPowjLvx9IS4amR0FRhN?=
 =?us-ascii?Q?gxhKOnMThZteP1T8EyG3N4ps9esLsr7+93pwUmsWYfTkKyh+7I7dn6rMqzeC?=
 =?us-ascii?Q?+FwfzKFCIuJZTiYYEN95YlmC2BtgjnPModT9ShL/2qWU2URGjfv8WeOzOdOA?=
 =?us-ascii?Q?DKPAzb/FO04NM268ELDehKBZXeJQGNhuG+CXwt2RJcJqyXlCcmKXfKj9C7s/?=
 =?us-ascii?Q?sA6PG2OjJtBfLBviEFG/M3hTcqvh3j54FGrW8pRTWGN6fg5zpI7P+Er+Cpiq?=
 =?us-ascii?Q?R7wxqb7me18ofpJsW9LNfDyM0mLUgZgLzwmoF99gyfZyhojA3NWd4vZOe57n?=
 =?us-ascii?Q?ivkyVoAVgaa0Gn/xmYYHBrHYQxy4paAemw7jeXekeIBwkiLTdR5KTMEdFX/A?=
 =?us-ascii?Q?2y0JvYONLF0/OpjWC1/FxkdtxsNg9Bnl0l46eM0TVEz9eHCZ4AUh1HkbmtX0?=
 =?us-ascii?Q?NJD6HtP05q5doJv2nytcJADPEaHioKcWPfopgZ2CV6LH85o+E0Iwh01UKNnc?=
 =?us-ascii?Q?bjFbZWGECqioOusTUs0FDH3nEDHNIr1daQoQj03C1PP/uj4kNJMFwKLGHtG7?=
 =?us-ascii?Q?qyHgiplb1rxXZlJmoQySqocMoGRJcsA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a7020b-d7d8-4514-b54b-08df06ab6005
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:28:43.3311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DXOebjUt9IUAIfWkaXQMVgKxThCLBu2f3nQ6frekqkp/BczkaaKNAAWqBHxJM1yBlp3tc0iOfi4x30Gs31mAfXUepdots5TXGpmhP1AzQ9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0821

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
 .../pmdomain/riscv/riscv-rpmi-device-power.c  | 466 ++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h    |  11 +
 7 files changed, 499 insertions(+)
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
index 000000000000..6590d622c2a4
--- /dev/null
+++ b/drivers/pmdomain/riscv/riscv-rpmi-device-power.c
@@ -0,0 +1,466 @@
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
+#include <linux/mutex.h>
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
+/**
+ * struct rpmi_ctx - RPMI transport context shared by all power domains
+ *
+ * @chan: mailbox channel of the underlying SBI MPXY transport
+ * @client: mailbox client bound to @chan
+ * @lock: serialises RPMI transactions on @chan
+ */
+struct rpmi_ctx {
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	/* serialises RPMI transactions on @chan */
+	struct mutex lock;
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
+	__le32 event_id;
+};
+
+struct rpmi_pm_enable_notification_rx {
+	__le32 status;
+};
+
+/* Service: GET_POWER_DOMAINS */
+struct rpmi_pm_get_num_domain_rx {
+	__le32 status;
+	__le32 num_domains;
+};
+
+/* Service: GET_POWER_DOMAIN_ATTRS */
+struct rpmi_pm_get_domain_attrs_tx {
+	__le32 domain_id;
+};
+
+/* pm domain attributes response data */
+struct rpmi_pm_get_domain_attrs_rx {
+	__le32 status;
+	__le32 flags;
+	__le32 transition_latency;
+	char name[RPMI_PM_DOMAIN_NAME_LEN];
+};
+
+/* Service: SET_POWER_DOMAIN_STATE */
+struct rpmi_pm_set_power_state_tx {
+	__le32 domain_id;
+	__le32 power_state;
+};
+
+struct rpmi_pm_set_power_state_rx {
+	__le32 status;
+};
+
+/* Service: GET_POWER_DOMAIN_STATE */
+struct rpmi_pm_get_power_state_tx {
+	__le32 domain_id;
+};
+
+struct rpmi_pm_get_power_state_rx {
+	__le32 status;
+	__le32 power_state;
+};
+
+static int rpmi_pm_send_message(struct rpmi_ctx *mpxy_ctx,
+				struct rpmi_mbox_message *msg)
+{
+	guard(mutex)(&mpxy_ctx->lock);
+
+	return rpmi_mbox_send_message(mpxy_ctx->chan, msg);
+}
+
+static int rpmi_power_state_get(struct rpmi_device_power_domain *mpxy_pm_domain,
+				u32 domain_id, u32 *state)
+{
+	struct rpmi_pm_get_power_state_rx rx = { };
+	struct rpmi_pm_get_power_state_tx tx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(domain_id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_GET_STATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+
+	ret = rpmi_pm_send_message(mpxy_pm_domain->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	*state = le32_to_cpu(rx.power_state);
+
+	return 0;
+}
+
+static int rpmi_power_state_set(struct rpmi_device_power_domain *mpxy_pm_domain,
+				u32 domain_id, u32 state)
+{
+	struct rpmi_pm_set_power_state_rx rx = { };
+	struct rpmi_pm_set_power_state_tx tx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(domain_id);
+	tx.power_state = cpu_to_le32(state);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_SET_STATE,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_pm_send_message(mpxy_pm_domain->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
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
+	struct rpmi_pm_get_num_domain_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_GET_NUM_DOMAINS,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_pm_send_message(mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	*domain = le32_to_cpu(rx.num_domains);
+
+	return 0;
+}
+
+/* obtain the MPXY device power domain attributes */
+static int rpmi_device_power_get_attrs(u32 domain_id,
+				       struct rpmi_device_power_domain *mpxy_pm_domain)
+{
+	struct rpmi_pm_get_domain_attrs_rx rx = { };
+	struct rpmi_pm_get_domain_attrs_tx tx;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(domain_id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_DP_SRV_GET_ATTRS,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_pm_send_message(mpxy_pm_domain->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	mpxy_pm_domain->transition_latency = le32_to_cpu(rx.transition_latency);
+	strscpy(mpxy_pm_domain->name, rx.name, sizeof(mpxy_pm_domain->name));
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
+	ret = rpmi_pm_send_message(mpxy_ctx, &msg);
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
+	ret = rpmi_pm_send_message(mpxy_ctx, &msg);
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
+	ret = rpmi_pm_send_message(mpxy_ctx, &msg);
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
+	ret = devm_mutex_init(dev, &mpxy_ctx->lock);
+	if (ret)
+		return ret;
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
+	ret = of_genpd_add_provider_onecell(np, mpxy_pd_data);
+	if (ret) {
+		while (i--) {
+			if (domains[i])
+				pm_genpd_remove(domains[i]);
+		}
+
+		return dev_err_probe(dev, ret, "failed to add genpd provider\n");
+	}
+
+	return 0;
+}
+
+static const struct of_device_id rpmi_pm_domain_of_match[] = {
+	{ .compatible = "riscv,rpmi-device-power" },
+	{},
+};
+
+static struct platform_driver rpmi_pm_domain_platdrv = {
+	.driver = {
+		.name = "riscv-rpmi-device-power",
+		.of_match_table = rpmi_pm_domain_of_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = rpmi_pm_domain_probe,
+};
+
+builtin_platform_driver(rpmi_pm_domain_platdrv);
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


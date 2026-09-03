Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B513806C6;
	Thu,  3 Sep 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427483; cv=fail; b=dT98pz2qvL1K5OjGJpvu1cxGb9VeJX+pFVKwZOBgUHjKUfz/cG+57h4rFOs/HoUx0eWd5wnMHig2Z4peS1J4wG/5Tp2tp5hD7hCs76FWjTrLNjYEqSJYaVpItVwbyzr+e0rm7eKZ3C7jJsyPQfvofX17E3pOEDcWyBUWKIS3PK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427483; c=relaxed/simple;
	bh=1cgO8Q0Nve9AAej/f69aGa886O9GAAEa9nFXpAoAVmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDNOFLcE9GElMXHrU2lvf8FWkNvNwc3wxDK9n+svc2x3T5kDU47VsidglBRvsoJW1DzFa4oi4P0nCNcEZnu2x0URiKysTBFVssspe0yYA+fribQWcTOsMjogQx2uoKlETvlwll/JCiOQUDkGHBUcnHzFtwa3wrs7Vl6o+FJXvPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMIaipy83AHU2P9SzHzQh0keUZuYHXqc0J0uKI6hjDqfp+dRnabo67aEJ+dKpExvE94jAth1OBsEX9pliYdumJG+38P69eW7b6Nfui/yrKznUoORWdFbiHK8AuAubsMUWXl4gKWXuq0R+UfuvWUroo2nSeyt595lg0+nTlArlOKC5ty+IziLZnEXgw7SkZ0KYUdQXLBQrYpStuGuL9h2KmQk6pCfKuknsMPJEAt/GQ77qzisLxugNxaEf8nYF4SgkPrwmbJP9lsRNyW2HnPXkoI6zsLhqAZ6HU+LsGsm+X4gfbDao6oBIjXHZibWJgT5p266DrkSE+QpCo+L+4wZbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFZec7DirCKNAPrc1+BSPmo9qqPwIwIz6vRw8/iG2ec=;
 b=PKPGuxUKQ2uNN8/kt8Y00sLguarVRL51YI4nqpCxr5W6Ccmk7YJqRZyCnE2AOzpf+oQksN0YYXM/P7+6U+U1C3csS4NY+9473brp5updc3iTOrVQtKbQuRNDMIM8OQeMrZPhXGTFkAfqD8/OaPMjP+Z6jWKx29r+jXtzHwaxghHE9PkxYO+8XPHHZiEg5z0d3VZyPYUoIV9WfW1DtWJxO/h/wlT51PeOBzJ9yOpmnfGlYS3EMkIGZh918RsilKVYNJPVna5TVcmJKwrA5NklSRBqwvJhiE+7Eeg+RwXmeXAahgNPGFUxhBlmHhAfAVG7DJABrZpNALD1/rt/dVdIJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::23) by BJXPR01MB0680.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 3 Sep
 2026 09:24:25 +0000
Received: from BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
 ([fe80::e644:7bf5:5a3c:e548]) by
 BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn ([fe80::e644:7bf5:5a3c:e548%3])
 with mapi id 15.21.0315.011; Thu, 3 Sep 2026 09:24:25 +0000
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
Subject: [PATCH v3 2/3] pmdomain: riscv: Add RPMI device power service
Date: Thu,  3 Sep 2026 17:23:46 +0800
Message-ID: <20260903092347.620060-3-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ea99a0b-eef6-4ad4-1486-08df099d259a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|1800799024|376014|23010399003|3023799007|921020|56012099006|6133799003|22082099003|38350700014|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	bNZ/NMJWMr9pqLZd7zlB+gNjUEO0JkWztGKTWBtSG93rz6hVtBi7EgCPoDuqw0VyzcVt51gfV4RgUXgkVpNk48lrPVCNFGtv7sYVKa3brxVN4+3riuDdbYjIatbmb7SxKzb0qjXggMdumeDSR6p1Z6cdjW4eh+/ThpOoMk93uY6Nm4eG63ZnrYpUFl4gouWYdcqxpNwRn6IUj5Wg7QrLigcusqaTnFS3sQ1CG7k3WUCqy4FRz9SM1eghbDtSVLwVZXTkF0D5wumSs0wj3Dn7kE/cR4rB0KKJudauNCYJmsHGEh5ybS105YIjsgDheLOfL5JNiavizcDsGh5MObZPCObcY2cyy7H9FOuwgK49hI0Y7s1uOmkB1SrVDXyc9R7rpJ+AdjgaVT4rbw4kx9sn5zlU/8pNKjofNIKrMe2049zruoNGPE2wOS9UaCgny/4Cae1vImwKH1PO8FGgBV/HkJ1Oa7vEN2hoXI2NGMrVh/Q6zuNBVhS2uekSIg5ln+27Ur97JIEV58tSs/iRIyQhoSTIf8do8XRNd6IGlgMzDwWprv2jvseL/rEZ8kbBdrtNrEGDwtiF9ufuapWn370+Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(1800799024)(376014)(23010399003)(3023799007)(921020)(56012099006)(6133799003)(22082099003)(38350700014)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HglVBRA65D/1YL/4OhYJhMxRB47/+DGzKJj4G8GFVEM/W73tL65BHfXry5d2?=
 =?us-ascii?Q?oXsRQFetvQ5O5cKdgufI8f3sNQ75rwWlElbIimeVXDD46VVmxZFasTrp+gfk?=
 =?us-ascii?Q?Ecxv3BgWNUGY1ZKRN4MGh1d7nHZvDkvfrlZAyjGKwoQfCkSO+vsZpNoFq9Kf?=
 =?us-ascii?Q?XyEKKS0fhl81CcV++Dw6gTzFmB120qH+DcJkFufi7345DLgEkxl77uYuXaUw?=
 =?us-ascii?Q?jVfv8lgJw1W/24v5onbSikUkcdz8abW/4W+rO5+pwCxyXwhTBJ6QBD6OvjSz?=
 =?us-ascii?Q?yQ0CQ4lzTybz++WTr6z3J/DbIkeyhU9xOIA7cuz/18Yh5PzU+Cyr1PYfSZeU?=
 =?us-ascii?Q?fkkUNYcrfOfCUiURxxIVfkkjLarFG0cH3gywdNYszb2UdpUYK5SB1MSbnWCv?=
 =?us-ascii?Q?08bKBPMC9GTRNicoTe8Zxg5qNBpJIz1aCAM7yzQmWWKYfn3KxAsN9HDvYTKz?=
 =?us-ascii?Q?2vdbKnjM6oqFGdIT7ocYck6Di/hFP8/q/gUCo6cMFwFujA08fsZIiUhoZ30S?=
 =?us-ascii?Q?nusRfKDK3HlwmShz3q9Iv1jHl8+JHJ/SEUNhcc16cfKZQXFZI/0EPcjlUZ+g?=
 =?us-ascii?Q?TaP9DIk3x9UqG25YFLjogyFa8xXWi2hxGVIWN9WNmQioIvzzdn0ocMUFbb78?=
 =?us-ascii?Q?wjm21gSqW6D/ZA572UIqgzWy/nCUe3KmHtGYIF6O1Pb7HAUVPgsRfsxUpxyH?=
 =?us-ascii?Q?tXsCDcabjTk6/HbHbioyZZkHRSD08z5WbsypuI59uJ710UlohuO5ZwO0/T9L?=
 =?us-ascii?Q?MjBuB5mt1W61yUaJWe/yhb5+0DODXCsSFBdi0ArurMQefdh1trvyxlJnLR7S?=
 =?us-ascii?Q?mCzataq4Fz/nxeHHwo5TtZKSETq9BrHfb3YUI6cURFB2XSyW881P1bjZSkNC?=
 =?us-ascii?Q?qWLxeLygVFzPUiFhqOkTxyfhcANdNSYqF+SY+wTZgWSERK4RkTGjC7tDSc27?=
 =?us-ascii?Q?+gId4rqKO2Z/tJdR+nBSp4lTN2/dQjWbrnickCO9HFDjL+tPxJZyJI9NjnM0?=
 =?us-ascii?Q?iG8QazDgs8LDbs67C8fLKEC+cfM44gCD0J14gd3JJQvqSYzvT3exCKIOh2pB?=
 =?us-ascii?Q?oNXbA4Ge/hPnkNYUYJZ7z3KS+Klis/40hNdzIKqmniccErYNFarezwgM8ybh?=
 =?us-ascii?Q?V9GL7CBX5ScAf390lMVcSnOxjusNShjjdp4YZPKvGzLrYXAOCWS7dYE+c5Dr?=
 =?us-ascii?Q?JNj0fG2QgqDUCoq+AiG5eayV6VZit8m/7+stnEojxwA+4DxwfXbWFkkKMlvU?=
 =?us-ascii?Q?lAACbsxZm4R1Fwtg9UV5BI7I9vIWpgVJo6nxkiSWNmTKxPco7jAH4X0yynpy?=
 =?us-ascii?Q?2lI1sMKf9AFZAoop2PaMiGjm4H8Ny3TuR+F91ylMe2al7nxJw60dZmsKPc5M?=
 =?us-ascii?Q?Pl0Wb7qhtxhe++eOAeyU3UQOdboKRUMGi1ZyiqUotJ2IfLlg/GR5BkozO0QG?=
 =?us-ascii?Q?XU0AuuXT4vHqWNZLxzm6IZS4apR6aZaCzfsAkHeYsKZShPJ+q8+n2QNRXFuU?=
 =?us-ascii?Q?fwg/nLwG6aAsCJlKk5ITNS947nE3C8WNv5b1+pJUMyjBE4pQ7mVpve9s1Fvb?=
 =?us-ascii?Q?TZNgbSLge4IzUHy+fwoLLWYuf/v5I6F5m42Z3G+hTynwlKb+EHSoq5Cw4ky4?=
 =?us-ascii?Q?SjfBmAHi4zYbhrAetpPZ7LktdfiqwGEu/0bAEURF/aZYXeXOgbNBD0lcE7Yp?=
 =?us-ascii?Q?xyeFNdTiMz4ZBIuF8ErOVhbswq5HtRS3P5+/YZ/Zpcq6WwDL7GIerphrL8cD?=
 =?us-ascii?Q?K1MPPwCMobIcy/cFHMKCRDFMiMrE4WI=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea99a0b-eef6-4ad4-1486-08df099d259a
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0838.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:24:25.8345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bHfPz+3jqSTqSsOEgvYzfT585nID9uw8xIqs4HAfZmkZTwOQX90SzRETRcpjjOvLAhbFFtVzXA8qLSFhahN9RJcKdG7g6lIYlSrULyn7Svs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0680

Add a generic power domain provider on top of the RISC-V Platform
Management Interface (RPMI) device power service group, reached through
an SBI MPXY channel.

The driver enumerates the device power domains advertised by the
platform microcontroller, queries their attributes and initial state,
and registers them as an onecell genpd provider so that devices can
reference them through the "power-domains" property.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/pmdomain/Kconfig                      |   1 +
 drivers/pmdomain/Makefile                     |   1 +
 drivers/pmdomain/riscv/Kconfig                |  15 +
 drivers/pmdomain/riscv/Makefile               |   3 +
 .../pmdomain/riscv/riscv-rpmi-device-power.c  | 485 ++++++++++++++++++
 include/linux/mailbox/riscv-rpmi-message.h    |  11 +
 6 files changed, 516 insertions(+)
 create mode 100644 drivers/pmdomain/riscv/Kconfig
 create mode 100644 drivers/pmdomain/riscv/Makefile
 create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-device-power.c

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
index 000000000000..97232edc294a
--- /dev/null
+++ b/drivers/pmdomain/riscv/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RISCV_RPMI_DEVICE_POWER
+	bool "RISC-V RPMI Based Device Power driver"
+	depends on RISCV || COMPILE_TEST
+	depends on MAILBOX
+	depends on PM
+	default RISCV
+	select PM_GENERIC_DOMAINS
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
index 000000000000..c7c46717dd73
--- /dev/null
+++ b/drivers/pmdomain/riscv/riscv-rpmi-device-power.c
@@ -0,0 +1,485 @@
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
+ * @mpxy_ctx: RPMI transport context used to reach the PuC
+ * @genpd: generic power domain registered with the genpd core
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
+	if (ret)
+		return ret;
+
+	ret = rpmi_power_state_get(mpxy_pm_domain, domain_id, &ret_state);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(RPMI_POWER_STATE_VALUE_MASK, ret_state) !=
+	    FIELD_GET(RPMI_POWER_STATE_VALUE_MASK, state))
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
+	dev_info(&pdev->dev, "%u MPXY PM domains are found\n", num_domains);
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
+				 "power domain %u initialization failed\n",
+				 mpxy_pd->id);
+			domains[i] = NULL;
+			continue;
+		}
+
+		ret = rpmi_power_state_get(mpxy_pd, i, &state);
+		if (ret) {
+			dev_warn(mpxy_pd->dev,
+				 "failed to get state for power domain %u\n",
+				 mpxy_pd->id);
+			domains[i] = NULL;
+			continue;
+		}
+
+		state = FIELD_GET(RPMI_POWER_STATE_VALUE_MASK, state);
+		if (state != RPMI_POWER_STATE_VALUE_OFF &&
+		    state != RPMI_POWER_STATE_VALUE_ON) {
+			dev_warn(mpxy_pd->dev,
+				 "unsupported state 0x%x for power domain %u\n",
+				 state, mpxy_pd->id);
+			domains[i] = NULL;
+			continue;
+		}
+
+		mpxy_pd->genpd.name = mpxy_pd->name;
+		mpxy_pd->genpd.power_off = rpmi_pd_power_off;
+		mpxy_pd->genpd.power_on = rpmi_pd_power_on;
+		/*
+		 * Domain names come from the PuC and are not guaranteed to be
+		 * unique or non-empty, so let genpd derive unique device names
+		 * from them rather than using them verbatim.
+		 */
+		mpxy_pd->genpd.flags = GENPD_FLAG_DEV_NAME_FW;
+
+		ret = pm_genpd_init(&mpxy_pd->genpd, NULL,
+				    state == RPMI_POWER_STATE_VALUE_OFF);
+		if (ret) {
+			dev_warn(mpxy_pd->dev,
+				 "failed to init power domain %u\n",
+				 mpxy_pd->id);
+			domains[i] = NULL;
+			continue;
+		}
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


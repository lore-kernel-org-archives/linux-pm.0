Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5847F79D;
	Thu,  8 Oct 2026 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450770; cv=fail; b=fAkRyW1qtPBlUqks2PmKCaXOyDc5pRJ9dCl50aNL8Jg9tiNnP+ryusthOnh9PL0xIPtXr8zb8h+3ZwC7GzIcaKplimyO1of/PF4xv2B7c5gv5UcxwGlRJAy+9qIAitaAhiZwraINquN06mwmDOzpfWFGaIcirsu/WYxHb26IcMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450770; c=relaxed/simple;
	bh=3KiT+kznFfOJ4gMqeTXy72vNMy/m8pik1E8seO+/d8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mVaQqWVQ/N+44HFM4uZG9byeawryhlkLdnNmmPxdK2fSsmKQmM0llTZRqRM2cBi46Pkkre1chDiu+DA+8TPO8nIgrPFiVAvVVuhbI3IlpuBi7UTsbPETLklu+s2sXFB8yYUHGjpFwCoQPrsI+0iyYCB8TtodB8edEjdlMGexly4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebVDRlj3zfrWju2IEI9qXHdt9QMXKzRDEjnRid/Gw40z1+O3noNehoIs7jHnZscdJbBqTxSJdkkJaaNBZw5SnLReQjA5hCl6uDFihw8qsk2OpDeuLLCmwqNNlgPzjRBw2sXuxadjntxCaI+W7UPvuuYFB7frw7KPAL/bez19hB8yk98UnDB9+jUCQm2KYt6POqB3nyGPCxK0u5sxs2a1lGpopNdlHm5mbSBHldWcP5NROhSFbXP7AMfKFVO3nKnlK4ECNcZF3wsq98LotVEJQvF7MMLEdYraGf7ttcXqxNaB27gOYypRRcXhlBSypv2oHiWfzgP6qk/FICONsCUH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoMkA7vX4SPgXOTWSZMoalnZw2w2IKG/BcRntxApW88=;
 b=Gt47orO2HKnfJ/WuMpcrNrhow6K4jIYVU38tDodQclgTuWIMj32VoQ6X4eBISikn9rJvJgc4AuEht2xcA7khZlZOkimaktqndxUmlka0gsx6ZWuAHmf1Vv00ZGfkIYyEEeVokqSzjrUjAUMR6xROHWwHVxseSBf6eBjw5ffl3hiDKBJxNJIopR2Od85D/SqnI29VN8sRjcqTYX3NnYntS6cNg6pZBr5ijTlySA7PQCjMl/Y29fAsGN8pRuMjbXzFhuWmHntqJnz4MISOb3YJgLjUrBxeUwkJlb/ALg6zN0zksTknU3EW8XCZPJnr6nGtQqCuUcHkGDJl4CKUotC6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:12:23 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:12:23 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	ulfh@kernel.org,
	rahul@summations.net,
	anup@brainfault.org,
	lftan.linux@gmail.com
Cc: alex@ghiti.fr,
	joshua.yeong@starfivetech.com,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] firmware: riscv: Add RPMI performance service
Date: Thu,  8 Oct 2026 17:10:28 +0800
Message-ID: <20261008091032.2832333-5-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
References: <20261008091032.2832333-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1325:EE_|NT0PR01MB1309:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b931414-0b90-48d5-c685-08df251c4362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	TfymXaAMwRTh6Eypt93MN2+qqAHSVe3cY7IYRY2+oUKEDbCSn+ym5Hq3Ot2hTOLHtl7BYM8ZPu0n9yRAFkYdoQbunrLI98MTipQOYVXcKU8fo/Ph3QTbrOTVF/k4jyHhbPLRaa3qiom3GvVw5+64yG7MqVP6hj/jUX3Lu4yuY9g4F6S6JFtlOH1j1qBST4uMzFdb5QQO3VPjgaFn3hTBnzZ0h72k1WvXLAdblWRl4JMqH/WtIOGFjUskdgdFdsFG8oHDvpYlLiMmL8c7KZjVgFiPc3+CIqoOkyB9JLlHn5qjT6hnM1kn/XMuALQudeEobyEt8kXN0ezM5tEivdUJ8snGU+x6TIvarIPELA4g3vWduKO0Z9MsC/+tLI+hHKyC1L3bjny3rJyk8Vl5qBdh23z2KqCLMI29qv1b+sgPGagYTW+GKMxK5fAQI7RUxZOmQMjCFL2jbsdNSlHXM8r9kRK2weaZmmpCvt/OGoptqZ9DSyjp+v8nHBMMPP8n7uj/CaqrjxLzIRiKwGgExtm9fCdZG/nNWyNKsN+Hcg5bQ90GLY0w2pF8AiVnUfoMoEsEXnyDiL9T5YlzEfwumWQpDQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JH7rWFb0+oMT9pcVHGso2b2wP+AWCFiSQxMLlBY1PtCM4AEBMSiVbyO2Lluc?=
 =?us-ascii?Q?EftUts5BbAVD+JvnFCtmI/0pGROIUOBHFCCy0W8cBlMQh4uGCwe2FsLcnnHS?=
 =?us-ascii?Q?MA6jLwDTYZw1pTNRz+Nbhq2b1EDxh+o3EFJbkyoNFFcn3O6ks9qrbmwbkDrS?=
 =?us-ascii?Q?RT4HcUeqoNIJxOsRhcMEyFPCY6fU6KOiGjJujR3Gs1AZjmIwZhwCBO6C8LS9?=
 =?us-ascii?Q?Paro8qEnHigCpjsa5zbA+UizlQP6q2ufMmwif3WoAKhjyPSSGcgFhptLxYyD?=
 =?us-ascii?Q?DMpRzTATm0HfY4DU82lAmw9iCMLwdDiSLnGYlWLJXr4aE/IjHZudlWNlDH81?=
 =?us-ascii?Q?JYXr8z/JHnEVdTC4H0LoHMWvwOqFakLzPdYZV9jOFYyEoiAWBg55uvAOz2ge?=
 =?us-ascii?Q?U6Hc8Qvgw5Qvg28fZaGEz5v9KYi/UINcj6T/KcEjdazzjXlIQtw2FKfP3rm0?=
 =?us-ascii?Q?BMl2jrvkxk5BzVORLKHOd7om+1hVp0gQNabUEoN3z7ESXNrsejsVxPKPn+aD?=
 =?us-ascii?Q?IE9fIIJOCjUSJFhXfOiMT2ySzC5ilpQDieDEEcfJxjoDgodCM8c2lGzQPZOI?=
 =?us-ascii?Q?5/JDzqwRPNQEPxS+z+xB0l2aWCqYn3s0v1fWC70uJ4m2/PUTT60NElQo/1yb?=
 =?us-ascii?Q?s3gfUBL4GHyiNRs+EvW5dQCDf49Xm/8h6hD3Xkjcju+ijThly6+o+sfrE5G3?=
 =?us-ascii?Q?0raF8jmM9WYBjZsPzEgE1l/M/zdbRQIkLpwfeNkHr3Xo3oDb8AhUxgpcFUkv?=
 =?us-ascii?Q?+UHv6fA4bJHLVOMmeRPzmg//bwrZ4y+C0zvFxUVlikEjNkrwSFNH/Jf240dn?=
 =?us-ascii?Q?QcA61tL1xJZf13GOyieW4pMdjGnKUDtOFSeWmKBbQBZ55NMCvzUhOL3yADf1?=
 =?us-ascii?Q?/pZ23vHyZARjWmY8XFt48+SWr4P+YWqmgU4zorJhmlDzaxmQHFI4XS3OqSqu?=
 =?us-ascii?Q?aAqKxIi1hIxrgjgT6umUv/0GEN77cJTBmkRhzTKpXnddx4JHV4jRylxaUBkw?=
 =?us-ascii?Q?aP8sfdmO43IqwL8O/8siEktLph9GYCzMvSmxq+SrKc88mfgMIgsTZRUFqEix?=
 =?us-ascii?Q?6n9bT8m0rbWv+JAdZv12UueawV8zMYJvXRgzCEvPZOHd7ZkDzfYzPKPeMEPJ?=
 =?us-ascii?Q?Q04LosxZg/qM3s+0BGVtHimeIxYHk1SJjSZA3VfemcpVg3kH/lkvNV9BLXSH?=
 =?us-ascii?Q?utiV/MJEu86dB0PceXcraZNJX2wrSKaiqAr3QD+IMNZPAjA8zWbYNQMlgb02?=
 =?us-ascii?Q?lfAZDtoKZ6r+RqhPl+vxH+H3VhLwhSeW279WUkIlMr75/iIFKCN1F5d/e4Oi?=
 =?us-ascii?Q?yaUG29ig08F58OMeygCylpimLuoO1yT2jtDMbO7/Ij3ReeNVy9kRELRScNjF?=
 =?us-ascii?Q?26jZxXiOptbba4E5Fahdc6zlfwMdZ7UraRZ6F3N8zqrZf5rNgVZqubeQbyNo?=
 =?us-ascii?Q?nO4TOjbdOQCeeaNiPVsv2MF8+QB/R8dq2pubE308x7k99ifRn2QkVMdJc2Zi?=
 =?us-ascii?Q?ZEFCeLVqpvbdRsyZFQPwTz7x4Kc4x99/pFGdSDMiYRyF82ZOCuuRrWJNEJ+t?=
 =?us-ascii?Q?wGmUGbciVuXlEtWVXPLIbQJnVuFNzy/ERPbhTkhGPxhDhfDEoSt5S4K6tUN/?=
 =?us-ascii?Q?k0UW0rNrQH/G7AHk9viKyUm53MLny2G0C9lhdfsAQ2Ydn/24sGTXn+TMclkV?=
 =?us-ascii?Q?PkE9Ry6NdVJtyhKOG+WlMOJqz5ZFRjS+ECwTva47CXLQyG2Ng6A/khMfAXR4?=
 =?us-ascii?Q?IP9XUjmd8v1SVzVlrFicDXCZRZcNK8g=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b931414-0b90-48d5-c685-08df251c4362
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:12:23.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SiwcC4xgbySqMnigFlgR/4zV3Si7BzQujEblCmBp4Y0AaA20bijtF5PNQOoSCfhDjNHp05Gy5O3C18a4KetrdEfUUCd300MqZ6cQwuzK4BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

The RPMI specification defines a performance service group which can be
accessed via SBI MPXY extension or dedicated S-mode RPMI transport.

Add a mailbox client based core for the RISC-V RPMI performance service
group. It owns the mailbox channel, which cannot be shared, enumerates
the performance domains advertised by the platform microcontroller, and
exports an interface to read and set their levels and limits, through
the fast channel where a domain has one. The front-ends that drive the
domains build on it and are added separately.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/firmware/Kconfig                      |    1 +
 drivers/firmware/Makefile                     |    1 +
 drivers/firmware/riscv/Kconfig                |   17 +
 drivers/firmware/riscv/Makefile               |    3 +
 .../firmware/riscv/riscv-rpmi-performance.c   | 1105 +++++++++++++++++
 .../firmware/riscv/riscv-rpmi-performance.h   |  148 +++
 include/linux/mailbox/riscv-rpmi-message.h    |   16 +
 7 files changed, 1291 insertions(+)
 create mode 100644 drivers/firmware/riscv/Kconfig
 create mode 100644 drivers/firmware/riscv/Makefile
 create mode 100644 drivers/firmware/riscv/riscv-rpmi-performance.c
 create mode 100644 include/linux/firmware/riscv/riscv-rpmi-performance.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b7cc11e4fbfa..cf0212576dfd 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -306,6 +306,7 @@ source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/microchip/Kconfig"
 source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/qcom/Kconfig"
+source "drivers/firmware/riscv/Kconfig"
 source "drivers/firmware/samsung/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index be46f1e1dc77..879953c316dc 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -35,6 +35,7 @@ obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
 obj-y				+= qcom/
+obj-y				+= riscv/
 obj-y				+= samsung/
 obj-y				+= smccc/
 obj-y				+= tegra/
diff --git a/drivers/firmware/riscv/Kconfig b/drivers/firmware/riscv/Kconfig
new file mode 100644
index 000000000000..309f43bdb6d1
--- /dev/null
+++ b/drivers/firmware/riscv/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "RISC-V Firmware Drivers"
+	depends on RISCV || COMPILE_TEST
+
+config RISCV_RPMI_PERFORMANCE
+	tristate "RISC-V RPMI performance service group"
+	depends on RISCV || COMPILE_TEST
+	depends on MAILBOX
+	default RISCV
+	select PM_OPP
+	help
+	  Support for the performance service group defined by the RISC-V
+	  platform management interface (RPMI) specification. The performance
+	  domains advertised by the platform microcontroller are enumerated
+	  here and made available to the front-end drivers that control them.
+
+endmenu
diff --git a/drivers/firmware/riscv/Makefile b/drivers/firmware/riscv/Makefile
new file mode 100644
index 000000000000..4020f828704a
--- /dev/null
+++ b/drivers/firmware/riscv/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_RISCV_RPMI_PERFORMANCE)	+= riscv-rpmi-performance.o
diff --git a/drivers/firmware/riscv/riscv-rpmi-performance.c b/drivers/firmware/riscv/riscv-rpmi-performance.c
new file mode 100644
index 000000000000..d44802f07ab0
--- /dev/null
+++ b/drivers/firmware/riscv/riscv-rpmi-performance.c
@@ -0,0 +1,1105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V RPMI performance service group core
+ *
+ * Copyright (C) 2026 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Owns the MPXY mailbox channel of the RPMI performance service group and the
+ * enumeration of the performance domains behind it, and hands both to the
+ * front-ends that drive a domain. The channel cannot be shared, so it has a
+ * single owner here and the front-ends sit on top of it.
+ */
+
+#define pr_fmt(fmt) "riscv-rpmi-performance: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/bsearch.h>
+#include <linux/firmware/riscv/riscv-rpmi-performance.h>
+#include <linux/io.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+
+#define RPMI_PERF_DOMAIN_NAME_LEN	16
+
+struct rpmi_fc_db_info {
+	int width;
+	u32 set;
+	void __iomem *addr;
+};
+
+struct rpmi_fc_info {
+	void __iomem *set_addr;
+	void __iomem *get_addr;
+	struct rpmi_fc_db_info *set_db;
+};
+
+struct rpmi_ctx {
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	/* serialises RPMI transactions on @chan */
+	struct mutex lock;
+	u32 max_msg_size;
+};
+
+struct rpmi_fast_channel {
+	u64 addr;
+	u64 size;
+};
+
+struct rpmi_perf_domain {
+	u32 id;
+	bool enumerated;
+	bool set_limit;
+	bool set_level;
+	bool has_fastchannels;
+	u32 level_count;
+	u32 rate_limit_us;
+	char name[RPMI_PERF_DOMAIN_NAME_LEN];
+	struct rpmi_perf_level *level;
+	struct rpmi_fc_info *fc_info;
+	struct rpmi_ctx *mpxy_ctx;
+	struct device *dev;
+	struct rpmi_perf *perf;
+};
+
+struct rpmi_perf {
+	u32 num_domains;
+	struct rpmi_fast_channel fast_channel;
+	struct device *dev;
+	struct rpmi_perf_domain *domain;
+};
+
+enum {
+	RPMI_PERF_FC_LEVEL,
+	RPMI_PERF_FC_MAX,
+};
+
+/* Service: ENABLE_NOTIFICATION */
+struct rpmi_perf_enable_notification_tx {
+	__le32 event_id;
+};
+
+struct rpmi_perf_enable_notification_rx {
+	__le32 status;
+};
+
+/* Service: GET_NUM_DOMAINS */
+struct rpmi_perf_get_num_domain_rx {
+	__le32 status;
+	__le32 num_domains;
+};
+
+/* Service: GET_ATTRS */
+struct rpmi_perf_get_attrs_tx {
+	__le32 domain_id;
+};
+
+struct rpmi_perf_get_attrs_rx {
+	__le32 status;
+	__le32 flags;
+#define PERF_LIMIT_SETTING(f)		(FIELD_GET(BIT(2), (f)))
+#define PERF_LEVEL_SETTING(f)		(FIELD_GET(BIT(1), (f)))
+#define FAST_CHANNEL_SUPPORT(f)		(FIELD_GET(BIT(0), (f)))
+	__le32 num_levels;
+	__le32 trans_latency_us;
+	char name[RPMI_PERF_DOMAIN_NAME_LEN];
+};
+
+/* Service: GET_SUPPORTED_LEVELS */
+struct rpmi_perf_get_supported_level_tx {
+	__le32 domain_id;
+	__le32 level_index;
+};
+
+struct rpmi_perf_supported_level {
+	__le32 index;
+	__le32 clock_freq;
+	__le32 power_cost;
+	__le32 trans_latency_us;
+};
+
+struct rpmi_perf_get_supported_level_rx {
+	__le32 status;
+	__le32 flags;
+	__le32 remaining;
+	__le32 returned;
+	struct rpmi_perf_supported_level level[];
+};
+
+/* Service: GET_LEVEL */
+struct rpmi_perf_get_level_tx {
+	__le32 domain_id;
+};
+
+struct rpmi_perf_get_level_rx {
+	__le32 status;
+	__le32 level_index;
+};
+
+/* Service: SET_LEVEL */
+struct rpmi_perf_set_level_tx {
+	__le32 domain_id;
+	__le32 level_index;
+};
+
+struct rpmi_perf_set_level_rx {
+	__le32 status;
+};
+
+/* Service: GET_LIMIT */
+struct rpmi_perf_get_limit_tx {
+	__le32 domain_id;
+};
+
+struct rpmi_perf_get_limit_rx {
+	__le32 status;
+	__le32 max_level;
+	__le32 min_level;
+};
+
+/* Service: SET_LIMIT */
+struct rpmi_perf_set_limit_tx {
+	__le32 domain_id;
+	__le32 max_level;
+	__le32 min_level;
+};
+
+struct rpmi_perf_set_limit_rx {
+	__le32 status;
+};
+
+/* Service: GET_FAST_CHANNEL_REGION */
+struct rpmi_perf_get_fast_channel_region_rx {
+	__le32 status;
+	__le32 addr_low;
+	__le32 addr_high;
+	__le32 size_low;
+	__le32 size_high;
+};
+
+/* Service: GET_FAST_CHANNEL_ATTRIBUTES */
+struct rpmi_perf_get_fast_channel_attributes_tx {
+	__le32 domain_id;
+	__le32 service_id;
+};
+
+struct rpmi_perf_get_fast_channel_attributes_rx {
+	__le32 status;
+	__le32 flags;
+#define DOORBELL_REG_WIDTH(f)		(FIELD_GET(GENMASK(2, 1), (f)))
+#define DOORBELL_REG_WIDTH_RESERVED	0x3
+#define SUPPORTS_DOORBELL(f)		(FIELD_GET(BIT(0), (f)))
+	__le32 offset_low;
+	__le32 offset_high;
+	__le32 size;
+	__le32 db_addr_low;
+	__le32 db_addr_high;
+	__le32 db_id;
+};
+
+static void rpmi_perf_fastchannel_db_ring(struct rpmi_fc_db_info *db)
+{
+	if (!db || !db->addr)
+		return;
+
+	switch (db->width) {
+	case 8:
+		iowrite8((u8)db->set, db->addr);
+		break;
+	case 16:
+		iowrite16((u16)db->set, db->addr);
+		break;
+	case 32:
+		iowrite32(db->set, db->addr);
+		break;
+	}
+}
+
+static int rpmi_perf_send_message(struct rpmi_ctx *mpxy_ctx,
+				  struct rpmi_mbox_message *msg)
+{
+	guard(mutex)(&mpxy_ctx->lock);
+
+	return rpmi_mbox_send_message(mpxy_ctx->chan, msg);
+}
+
+static int rpmi_perf_get_num_domains(struct rpmi_ctx *mpxy_ctx, u32 *domain)
+{
+	struct rpmi_perf_get_num_domain_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_NUM_DOMAINS,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(mpxy_ctx, &msg);
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
+static int rpmi_perf_get_attrs(struct rpmi_perf *mpxy_perf, struct rpmi_perf_domain *perf_domain)
+{
+	struct rpmi_perf_get_attrs_tx tx;
+	struct rpmi_perf_get_attrs_rx rx = { };
+	struct rpmi_mbox_message msg;
+	u32 flags;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(perf_domain->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_ATTRIBUTES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(perf_domain->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	flags = le32_to_cpu(rx.flags);
+
+	perf_domain->set_limit = PERF_LIMIT_SETTING(flags);
+	perf_domain->set_level = PERF_LEVEL_SETTING(flags);
+	perf_domain->has_fastchannels = mpxy_perf->fast_channel.size &&
+					(perf_domain->set_limit || perf_domain->set_level) ?
+					FAST_CHANNEL_SUPPORT(flags) : false;
+	perf_domain->level_count = le32_to_cpu(rx.num_levels);
+	perf_domain->rate_limit_us = le32_to_cpu(rx.trans_latency_us);
+	strscpy(perf_domain->name, rx.name, RPMI_PERF_DOMAIN_NAME_LEN);
+
+	if (!perf_domain->level_count)
+		return -EINVAL;
+
+	perf_domain->level = devm_kcalloc(mpxy_perf->dev, perf_domain->level_count,
+					  sizeof(struct rpmi_perf_level), GFP_KERNEL);
+	if (!perf_domain->level)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int rpmi_perf_get_supported_levels(struct rpmi_perf_domain *perf_domain)
+{
+	struct rpmi_perf_get_supported_level_tx tx;
+	struct rpmi_perf_get_supported_level_rx *rx;
+	struct rpmi_mbox_message msg;
+	struct rpmi_perf_level *level;
+	u32 index = 0, remaining, returned;
+	int ret = 0;
+
+	/*
+	 * A reply carries as many levels as fit in one message, so size it
+	 * for the largest message the channel carries. max_msg_size is in
+	 * bytes, and was checked to hold at least one level.
+	 */
+	rx = kzalloc(perf_domain->mpxy_ctx->max_msg_size, GFP_KERNEL);
+	if (!rx)
+		return -ENOMEM;
+
+	do {
+		tx.domain_id = cpu_to_le32(perf_domain->id);
+		tx.level_index = cpu_to_le32(index);
+
+		rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_SUPPORTED_LEVELS,
+						  &tx, sizeof(tx), rx,
+						  perf_domain->mpxy_ctx->max_msg_size);
+		ret = rpmi_perf_send_message(perf_domain->mpxy_ctx, &msg);
+		if (ret)
+			goto exit;
+
+		if (rx->status) {
+			ret = rpmi_to_linux_error(le32_to_cpu(rx->status));
+			goto exit;
+		}
+
+		if (msg.data.out_response_len < sizeof(*rx)) {
+			ret = -EPROTO;
+			goto exit;
+		}
+
+		remaining = le32_to_cpu(rx->remaining);
+		returned = le32_to_cpu(rx->returned);
+
+		if (!returned || returned > perf_domain->level_count - index ||
+		    returned > (msg.data.out_response_len - sizeof(*rx)) /
+			       sizeof(rx->level[0]) ||
+		    remaining != perf_domain->level_count - index - returned) {
+			ret = -EPROTO;
+			goto exit;
+		}
+
+		for (u32 i = 0; i < returned; i++) {
+			level = &perf_domain->level[index + i];
+			level->index = le32_to_cpu(rx->level[i].index);
+			level->clock_freq = le32_to_cpu(rx->level[i].clock_freq);
+			level->power_cost = le32_to_cpu(rx->level[i].power_cost);
+			level->trans_latency_us = le32_to_cpu(rx->level[i].trans_latency_us);
+		}
+
+		index += returned;
+
+	} while (remaining);
+
+exit:
+	kfree(rx);
+
+	return ret;
+}
+
+static int rpmi_perf_get_fast_channel_regions(struct rpmi_ctx *mpxy_ctx, struct rpmi_perf *perf)
+{
+	struct rpmi_perf_get_fast_channel_region_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_FAST_CHANNEL_REGION,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	perf->fast_channel.addr = le32_to_cpu(rx.addr_low) |
+				  ((u64)le32_to_cpu(rx.addr_high) << 32);
+	perf->fast_channel.size = le32_to_cpu(rx.size_low) |
+				  ((u64)le32_to_cpu(rx.size_high) << 32);
+
+	/* Every fast channel is checked against this region, so it must not wrap. */
+	if (perf->fast_channel.addr + perf->fast_channel.size < perf->fast_channel.addr) {
+		perf->fast_channel.size = 0;
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int rpmi_perf_extract_attributes(struct rpmi_perf_get_fast_channel_attributes_rx *rx,
+					struct rpmi_perf_domain *domain,
+					struct rpmi_fc_info *fc, u32 service_id)
+{
+	u64 region_size = domain->perf->fast_channel.size;
+	u64 phys_offset, phys_addr, db_phys_addr;
+	struct rpmi_fc_db_info *db = NULL;
+	void __iomem *addr, *db_addr;
+	u32 flags, size;
+	u8 db_addr_width;
+	int ret;
+
+	flags = le32_to_cpu(rx->flags);
+	phys_offset = le32_to_cpu(rx->offset_low);
+	phys_offset |= (u64)le32_to_cpu(rx->offset_high) << 32;
+	size = le32_to_cpu(rx->size);
+
+	/*
+	 * The fast channels all lie in the region PERF_GET_FAST_CHANNEL_REGION
+	 * describes, at an offset from its base, so refuse one that does not
+	 * fit in it or is too small for its payload, a 32-bit level.
+	 */
+	if (size < sizeof(u32) || phys_offset > region_size ||
+	    size > region_size - phys_offset)
+		return -EPROTO;
+
+	phys_addr = domain->perf->fast_channel.addr + phys_offset;
+
+	addr = devm_ioremap(domain->dev, phys_addr, size);
+	if (!addr) {
+		dev_err(domain->dev,
+			"failed to get fastchannel virtual addr in domain: %d\n",
+			domain->id);
+		return -EADDRNOTAVAIL;
+	}
+
+	switch (service_id) {
+	case RPMI_PERF_SRV_GET_LEVEL:
+		fc->get_addr = addr;
+		break;
+	case RPMI_PERF_SRV_SET_LEVEL:
+		if (SUPPORTS_DOORBELL(flags)) {
+			db = devm_kzalloc(domain->dev,
+					  sizeof(struct rpmi_fc_db_info),
+					  GFP_KERNEL);
+			if (!db) {
+				ret = -ENOMEM;
+				goto err_unmap;
+			}
+
+			db_addr_width = 1 << (DOORBELL_REG_WIDTH(flags) + 3);
+			db_phys_addr = le32_to_cpu(rx->db_addr_low);
+			db_phys_addr |= (u64)le32_to_cpu(rx->db_addr_high) << 32;
+
+			/* The doorbell can be any register; map only its width. */
+			db_addr = devm_ioremap(domain->dev, db_phys_addr,
+					       db_addr_width / BITS_PER_BYTE);
+			if (!db_addr) {
+				devm_kfree(domain->dev, db);
+				ret = -EADDRNOTAVAIL;
+				goto err_unmap;
+			}
+
+			db->addr = db_addr;
+			db->width = db_addr_width;
+			db->set = le32_to_cpu(rx->db_id);
+			fc->set_db = db;
+		}
+		fc->set_addr = addr;
+
+		break;
+	}
+
+	return 0;
+
+err_unmap:
+	/*
+	 * The platform asked for a doorbell, so without one a request would
+	 * never reach it. Leave the service on the mailbox.
+	 */
+	devm_iounmap(domain->dev, addr);
+
+	return ret;
+}
+
+static int rpmi_perf_get_fast_channel_attributes(struct rpmi_perf_domain *perf_domain,
+						 struct rpmi_fc_info *fc,
+						 u32 service_id)
+{
+	struct rpmi_perf_get_fast_channel_attributes_tx tx;
+	struct rpmi_perf_get_fast_channel_attributes_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(perf_domain->id);
+	tx.service_id = cpu_to_le32(service_id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_FAST_CHANNEL_ATTRS,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(perf_domain->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	/*
+	 * The doorbell words are unused without a doorbell, and a platform
+	 * may leave them out of the reply, so only require them with one.
+	 */
+	if (msg.data.out_response_len < offsetof(typeof(rx), db_addr_low) ||
+	    (SUPPORTS_DOORBELL(le32_to_cpu(rx.flags)) &&
+	     msg.data.out_response_len < sizeof(rx)))
+		return -EPROTO;
+
+	/* A doorbell of the reserved width could not be rung at all. */
+	if (SUPPORTS_DOORBELL(le32_to_cpu(rx.flags)) &&
+	    DOORBELL_REG_WIDTH(le32_to_cpu(rx.flags)) == DOORBELL_REG_WIDTH_RESERVED)
+		return -EPROTO;
+
+	ret = rpmi_perf_extract_attributes(&rx, perf_domain, fc, service_id);
+
+	return ret;
+}
+
+/*
+ * A service without a fast channel goes through the mailbox, so a fast channel
+ * that cannot be set up only costs speed. The platform may say it implements
+ * none; any other failure is reported, since nothing else would show it.
+ */
+static void rpmi_perf_setup_fast_channel(struct rpmi_perf_domain *domain,
+					 struct rpmi_fc_info *fc, u32 service_id)
+{
+	int ret;
+
+	ret = rpmi_perf_get_fast_channel_attributes(domain, fc, service_id);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(domain->dev,
+			 "perf domain #%u: no fast channel for service %#x: %d\n",
+			 domain->id, service_id, ret);
+}
+
+static int rpmi_perf_cmp_freq(const void *a, const void *b)
+{
+	const struct rpmi_perf_level *la = a, *lb = b;
+
+	return (la->clock_freq > lb->clock_freq) - (la->clock_freq < lb->clock_freq);
+}
+
+static int rpmi_perf_enumerate(struct rpmi_perf *mpxy_perf, struct rpmi_perf_domain *domain)
+{
+	struct rpmi_fc_info *fc;
+	int ret, id;
+
+	id = domain->id;
+
+	ret = rpmi_perf_get_attrs(mpxy_perf, domain);
+	if (ret) {
+		dev_err(domain->dev,
+			"Failed to get attributes of perf domain: #%u\n", id);
+		return ret;
+	}
+
+	ret = rpmi_perf_get_supported_levels(domain);
+	if (ret) {
+		dev_err(domain->dev,
+			"Failed to get supported level of perf domain: #%u\n", id);
+		return ret;
+	}
+
+	/*
+	 * The platform may return its levels in any order. A level index is a
+	 * point on the platform's performance scale, so a higher index is a
+	 * higher level, but the indices need not be contiguous. Keep the table
+	 * in ascending order of frequency, which the frequency lookup and every
+	 * front-end walking the levels rely on.
+	 */
+	sort(domain->level, domain->level_count, sizeof(domain->level[0]),
+	     rpmi_perf_cmp_freq, NULL);
+
+	if (domain->has_fastchannels) {
+		fc = devm_kcalloc(domain->dev, RPMI_PERF_FC_MAX, sizeof(*fc), GFP_KERNEL);
+		if (!fc)
+			return -ENOMEM;
+
+		if (domain->set_level)
+			rpmi_perf_setup_fast_channel(domain, &fc[RPMI_PERF_FC_LEVEL],
+						     RPMI_PERF_SRV_SET_LEVEL);
+
+		rpmi_perf_setup_fast_channel(domain, &fc[RPMI_PERF_FC_LEVEL],
+					     RPMI_PERF_SRV_GET_LEVEL);
+
+		/*
+		 * Limits always go through the mailbox, whose reply says
+		 * whether the platform took them, so their fast channels are
+		 * not set up.
+		 */
+
+		domain->fc_info = fc;
+	}
+
+	return 0;
+}
+
+/*
+ * Domain accessors. A consumer only ever sees an opaque handle, so the
+ * enumeration above stays private to this file.
+ */
+
+const char *rpmi_perf_domain_name(struct rpmi_perf_domain *pd)
+{
+	return pd->name;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_name);
+
+u32 rpmi_perf_domain_level_count(struct rpmi_perf_domain *pd)
+{
+	return pd->level_count;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_level_count);
+
+/**
+ * rpmi_perf_domain_level_info() - get one level of a performance domain
+ * @pd: performance domain
+ * @idx: position in the level table, from 0 to rpmi_perf_domain_level_count() - 1
+ * @level: filled in with the level
+ *
+ * The table is in ascending order of frequency. @idx is a position in it, not
+ * an RPMI level index, which is in @level->index.
+ *
+ * Return: 0 on success, -EINVAL if @idx is out of range.
+ */
+int rpmi_perf_domain_level_info(struct rpmi_perf_domain *pd, u32 idx,
+				struct rpmi_perf_level *level)
+{
+	if (idx >= pd->level_count)
+		return -EINVAL;
+
+	*level = pd->level[idx];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_level_info);
+
+bool rpmi_perf_domain_can_set_level(struct rpmi_perf_domain *pd)
+{
+	return pd->set_level;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_can_set_level);
+
+bool rpmi_perf_domain_has_fast_channel(struct rpmi_perf_domain *pd)
+{
+	return pd->fc_info && pd->fc_info[RPMI_PERF_FC_LEVEL].set_addr;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_has_fast_channel);
+
+u32 rpmi_perf_domain_trans_latency_us(struct rpmi_perf_domain *pd)
+{
+	return pd->rate_limit_us;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_trans_latency_us);
+
+/**
+ * rpmi_perf_domain_by_id() - look up a performance domain
+ * @perf: performance service group
+ * @id: RPMI domain ID
+ *
+ * Return: the domain, or NULL if @id is out of range or the domain could not
+ * be enumerated. Such a domain has no level table to work from, so no
+ * consumer is ever handed one.
+ */
+struct rpmi_perf_domain *rpmi_perf_domain_by_id(struct rpmi_perf *perf, u32 id)
+{
+	if (!perf || id >= perf->num_domains || !perf->domain[id].enumerated)
+		return NULL;
+
+	return &perf->domain[id];
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_by_id);
+
+u32 rpmi_perf_num_domains(struct rpmi_perf *perf)
+{
+	return perf ? perf->num_domains : 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_num_domains);
+
+/**
+ * rpmi_perf_domain_get_level() - read the level a domain is running at
+ * @pd: performance domain
+ * @level: where the level index is stored
+ *
+ * Reads through the fast channel when the domain has one, and over the
+ * mailbox otherwise. Either way the value comes from the platform
+ * microcontroller rather than from a cached copy.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
+int rpmi_perf_domain_get_level(struct rpmi_perf_domain *pd, u32 *level)
+{
+	struct rpmi_perf_get_level_tx tx;
+	struct rpmi_perf_get_level_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	if (pd->fc_info && pd->fc_info[RPMI_PERF_FC_LEVEL].get_addr) {
+		*level = ioread32(pd->fc_info[RPMI_PERF_FC_LEVEL].get_addr);
+		return 0;
+	}
+
+	tx.domain_id = cpu_to_le32(pd->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_LEVEL,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(pd->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	*level = le32_to_cpu(rx.level_index);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_get_level);
+
+/**
+ * rpmi_perf_domain_set_level() - ask a domain to run at a level
+ * @pd: performance domain
+ * @level: level index, as advertised by the domain
+ *
+ * May sleep, because it goes over the mailbox. Use
+ * rpmi_perf_domain_set_level_fast() from a context that must not.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
+int rpmi_perf_domain_set_level(struct rpmi_perf_domain *pd, u32 level)
+{
+	struct rpmi_perf_set_level_tx tx;
+	struct rpmi_perf_set_level_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	if (!pd->set_level)
+		return -EOPNOTSUPP;
+
+	tx.domain_id = cpu_to_le32(pd->id);
+	tx.level_index = cpu_to_le32(level);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_SET_LEVEL,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(pd->mpxy_ctx, &msg);
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
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_set_level);
+
+/**
+ * rpmi_perf_domain_set_level_fast() - set a level without sleeping
+ * @pd: performance domain
+ * @level: level index, as advertised by the domain
+ *
+ * Writes the level through the domain's fast channel and rings its doorbell.
+ * The platform microcontroller applies it asynchronously and there is no
+ * status to read back, so this only reports whether the request was posted.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the domain has no fast channel.
+ */
+int rpmi_perf_domain_set_level_fast(struct rpmi_perf_domain *pd, u32 level)
+{
+	if (!rpmi_perf_domain_has_fast_channel(pd))
+		return -EOPNOTSUPP;
+
+	iowrite32(level, pd->fc_info[RPMI_PERF_FC_LEVEL].set_addr);
+	rpmi_perf_fastchannel_db_ring(pd->fc_info[RPMI_PERF_FC_LEVEL].set_db);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_set_level_fast);
+
+int rpmi_perf_domain_get_limit(struct rpmi_perf_domain *pd, u32 *min, u32 *max)
+{
+	struct rpmi_perf_get_limit_tx tx;
+	struct rpmi_perf_get_limit_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	tx.domain_id = cpu_to_le32(pd->id);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_GET_LIMIT,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(pd->mpxy_ctx, &msg);
+	if (ret)
+		return ret;
+
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (msg.data.out_response_len < sizeof(rx))
+		return -EPROTO;
+
+	*max = le32_to_cpu(rx.max_level);
+	*min = le32_to_cpu(rx.min_level);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_get_limit);
+
+int rpmi_perf_domain_set_limit(struct rpmi_perf_domain *pd, u32 min, u32 max)
+{
+	struct rpmi_perf_set_limit_tx tx;
+	struct rpmi_perf_set_limit_rx rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	if (!pd->set_limit)
+		return -EOPNOTSUPP;
+
+	tx.domain_id = cpu_to_le32(pd->id);
+	tx.max_level = cpu_to_le32(max);
+	tx.min_level = cpu_to_le32(min);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_PERF_SRV_SET_LIMIT,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = rpmi_perf_send_message(pd->mpxy_ctx, &msg);
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
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_set_limit);
+
+static int rpmi_perf_search_freq(const void *id, const void *level)
+{
+	u32 khz = *(const u32 *)id;
+	u32 freq = ((const struct rpmi_perf_level *)level)->clock_freq;
+
+	return (khz > freq) - (khz < freq);
+}
+
+int rpmi_perf_domain_level_to_freq(struct rpmi_perf_domain *pd, u32 level, u32 *khz)
+{
+	/* The table is sorted by frequency, not by level index. */
+	for (u32 i = 0; i < pd->level_count; i++) {
+		if (pd->level[i].index == level) {
+			*khz = pd->level[i].clock_freq;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_level_to_freq);
+
+int rpmi_perf_domain_freq_to_level(struct rpmi_perf_domain *pd, u32 khz, u32 *level)
+{
+	struct rpmi_perf_level *found;
+
+	found = bsearch(&khz, pd->level, pd->level_count,
+			sizeof(pd->level[0]), rpmi_perf_search_freq);
+	if (!found)
+		return -EINVAL;
+
+	*level = found->index;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_freq_to_level);
+
+/**
+ * rpmi_perf_domain_opps_add() - give @dev an OPP for every level of @pd
+ * @pd: performance domain
+ * @dev: device that runs in the domain
+ *
+ * The levels come from the platform microcontroller, so there is no
+ * operating-points-v2 table in the device tree to parse. The OPP frequency is
+ * the level's clock frequency in Hz and the OPP level is the RPMI level
+ * index, which is what the set and get services take.
+ *
+ * Return: 0 on success, a negative errno otherwise.
+ */
+int rpmi_perf_domain_opps_add(struct rpmi_perf_domain *pd, struct device *dev)
+{
+	struct dev_pm_opp_data data = {};
+	struct rpmi_perf_level *level;
+	int idx, ret;
+
+	for (level = pd->level, idx = 0; idx < pd->level_count; idx++, level++) {
+		/* Frequency from RPMI is in kHz */
+		data.freq = (unsigned long)level->clock_freq * 1000;
+		data.level = level->index;
+
+		ret = dev_pm_opp_add_dynamic(dev, &data);
+		if (ret) {
+			dev_warn(dev, "failed to add opp %luHz\n", data.freq);
+
+			while (idx-- > 0) {
+				/* Frequency from RPMI is in kHz */
+				dev_pm_opp_remove(dev,
+						  (unsigned long)(--level)->clock_freq * 1000);
+			}
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rpmi_perf_domain_opps_add);
+
+static int rpmi_perf_attr_setup(struct device *dev, struct rpmi_ctx *mpxy_ctx)
+{
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	/* Validate RPMI specification version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SPEC_VERSION);
+	ret = rpmi_perf_send_message(mpxy_ctx, &msg);
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
+	/* Validate performance service group ID */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = rpmi_perf_send_message(mpxy_ctx, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get service group ID\n");
+		return ret;
+	}
+
+	if (msg.attr.value != RPMI_SRVGRP_PERFORMANCE) {
+		dev_dbg(dev,
+			"service group match failed, expected 0x%x, found 0x%x\n",
+			RPMI_SRVGRP_PERFORMANCE, msg.attr.value);
+		return -EINVAL;
+	}
+
+	/* Validate performance service group version */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_VERSION);
+	ret = rpmi_perf_send_message(mpxy_ctx, &msg);
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
+	/* Get max message size */
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE);
+	ret = rpmi_perf_send_message(mpxy_ctx, &msg);
+	if (ret) {
+		dev_dbg(dev, "Failed to get max message data size\n");
+		return ret;
+	}
+
+	if (msg.attr.value < sizeof(struct rpmi_perf_get_supported_level_rx) +
+			     sizeof(struct rpmi_perf_supported_level)) {
+		dev_dbg(dev, "max message data size %u too small\n",
+			msg.attr.value);
+		return -EINVAL;
+	}
+	mpxy_ctx->max_msg_size = msg.attr.value;
+
+	return 0;
+}
+
+static void rpmi_perf_mbox_chan_release(void *data)
+{
+	mbox_free_channel((struct mbox_chan *)data);
+}
+
+static int rpmi_perf_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rpmi_perf *mpxy_perf;
+	struct rpmi_ctx *mpxy_ctx;
+	u32 num_domains = 0;
+	int ret;
+	u32 i;
+
+	mpxy_ctx = devm_kzalloc(dev, sizeof(*mpxy_ctx), GFP_KERNEL);
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
+	ret = devm_add_action_or_reset(dev, rpmi_perf_mbox_chan_release,
+				       mpxy_ctx->chan);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add rpmi mbox channel cleanup\n");
+
+	ret = rpmi_perf_attr_setup(dev, mpxy_ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to verify RPMI attribute\n");
+
+	/* Get number of performance domain */
+	ret = rpmi_perf_get_num_domains(mpxy_ctx, &num_domains);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "invalid number of perf domains\n");
+
+	if (!num_domains)
+		return dev_err_probe(dev, -EINVAL, "No perf domains found!\n");
+
+	mpxy_perf = devm_kzalloc(dev, sizeof(*mpxy_perf), GFP_KERNEL);
+	if (!mpxy_perf)
+		return -ENOMEM;
+
+	mpxy_perf->domain = devm_kcalloc(dev, num_domains,
+					 sizeof(struct rpmi_perf_domain),
+					 GFP_KERNEL);
+	if (!mpxy_perf->domain)
+		return -ENOMEM;
+
+	mpxy_perf->num_domains = num_domains;
+	mpxy_perf->dev = dev;
+
+	/*
+	 * Without a fast-channel region every domain goes through the mailbox.
+	 * The platform may implement none; any other failure is reported.
+	 */
+	ret = rpmi_perf_get_fast_channel_regions(mpxy_ctx, mpxy_perf);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(dev, "no fast channel region, using the mailbox: %d\n", ret);
+
+	for (i = 0; i < num_domains; i++) {
+		struct rpmi_perf_domain *domain = &mpxy_perf->domain[i];
+
+		domain->id = i;
+		domain->mpxy_ctx = mpxy_ctx;
+		domain->dev = dev;
+		domain->perf = mpxy_perf;
+
+		domain->enumerated = !rpmi_perf_enumerate(mpxy_perf, domain);
+	}
+
+	dev_set_drvdata(dev, mpxy_perf);
+
+	dev_info(dev, "%d MPXY performance domains registered\n", num_domains);
+
+	return 0;
+}
+
+static const struct of_device_id rpmi_perf_of_match[] = {
+	{ .compatible = "riscv,rpmi-performance" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rpmi_perf_of_match);
+
+static struct platform_driver rpmi_perf_platdrv = {
+	.driver = {
+		.name = "riscv-rpmi-performance",
+		.of_match_table = rpmi_perf_of_match,
+	},
+	.probe = rpmi_perf_probe,
+};
+
+module_platform_driver(rpmi_perf_platdrv);
+
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_DESCRIPTION("RISC-V RPMI performance service group core");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/riscv/riscv-rpmi-performance.h b/include/linux/firmware/riscv/riscv-rpmi-performance.h
new file mode 100644
index 000000000000..c65ea924b75d
--- /dev/null
+++ b/include/linux/firmware/riscv/riscv-rpmi-performance.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V RPMI performance service group interface
+ *
+ * Copyright (C) 2026 Shanghai StarFive Technology Co., Ltd.
+ *
+ * The RPMI performance service group is a provider of performance domains.
+ * The front-ends that drive a domain reach the platform microcontroller
+ * through this interface, so that the mailbox channel and the domain
+ * enumeration have a single owner.
+ */
+
+#ifndef _LINUX_RISCV_RPMI_PERFORMANCE_H_
+#define _LINUX_RISCV_RPMI_PERFORMANCE_H_
+
+#include <linux/types.h>
+
+struct device;
+struct rpmi_perf;
+struct rpmi_perf_domain;
+
+/**
+ * struct rpmi_perf_level - one level of a performance domain
+ *
+ * @index: level index, which is what the RPMI services take and return
+ * @clock_freq: clock frequency of the level, in kHz
+ * @power_cost: power cost of the level, in uW
+ * @trans_latency_us: worst case time to switch to this level, in us
+ */
+struct rpmi_perf_level {
+	u32 index;
+	u32 clock_freq;
+	u32 power_cost;
+	u32 trans_latency_us;
+};
+
+#if IS_ENABLED(CONFIG_RISCV_RPMI_PERFORMANCE)
+
+struct rpmi_perf_domain *rpmi_perf_domain_by_id(struct rpmi_perf *perf, u32 id);
+u32 rpmi_perf_num_domains(struct rpmi_perf *perf);
+
+const char *rpmi_perf_domain_name(struct rpmi_perf_domain *pd);
+u32 rpmi_perf_domain_level_count(struct rpmi_perf_domain *pd);
+int rpmi_perf_domain_level_info(struct rpmi_perf_domain *pd, u32 idx,
+				struct rpmi_perf_level *level);
+bool rpmi_perf_domain_can_set_level(struct rpmi_perf_domain *pd);
+bool rpmi_perf_domain_has_fast_channel(struct rpmi_perf_domain *pd);
+u32 rpmi_perf_domain_trans_latency_us(struct rpmi_perf_domain *pd);
+
+int rpmi_perf_domain_get_level(struct rpmi_perf_domain *pd, u32 *level);
+int rpmi_perf_domain_set_level(struct rpmi_perf_domain *pd, u32 level);
+int rpmi_perf_domain_set_level_fast(struct rpmi_perf_domain *pd, u32 level);
+int rpmi_perf_domain_get_limit(struct rpmi_perf_domain *pd, u32 *min, u32 *max);
+int rpmi_perf_domain_set_limit(struct rpmi_perf_domain *pd, u32 min, u32 max);
+
+int rpmi_perf_domain_level_to_freq(struct rpmi_perf_domain *pd, u32 level, u32 *khz);
+int rpmi_perf_domain_freq_to_level(struct rpmi_perf_domain *pd, u32 khz, u32 *level);
+int rpmi_perf_domain_opps_add(struct rpmi_perf_domain *pd, struct device *dev);
+
+#else
+
+static inline struct rpmi_perf_domain *
+rpmi_perf_domain_by_id(struct rpmi_perf *perf, u32 id)
+{
+	return NULL;
+}
+
+static inline u32 rpmi_perf_num_domains(struct rpmi_perf *perf)
+{
+	return 0;
+}
+
+static inline const char *rpmi_perf_domain_name(struct rpmi_perf_domain *pd)
+{
+	return NULL;
+}
+
+static inline u32 rpmi_perf_domain_level_count(struct rpmi_perf_domain *pd)
+{
+	return 0;
+}
+
+static inline int rpmi_perf_domain_level_info(struct rpmi_perf_domain *pd, u32 idx,
+					      struct rpmi_perf_level *level)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool rpmi_perf_domain_can_set_level(struct rpmi_perf_domain *pd)
+{
+	return false;
+}
+
+static inline bool rpmi_perf_domain_has_fast_channel(struct rpmi_perf_domain *pd)
+{
+	return false;
+}
+
+static inline u32 rpmi_perf_domain_trans_latency_us(struct rpmi_perf_domain *pd)
+{
+	return 0;
+}
+
+static inline int rpmi_perf_domain_get_level(struct rpmi_perf_domain *pd, u32 *level)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_set_level(struct rpmi_perf_domain *pd, u32 level)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_set_level_fast(struct rpmi_perf_domain *pd, u32 level)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_get_limit(struct rpmi_perf_domain *pd, u32 *min, u32 *max)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_set_limit(struct rpmi_perf_domain *pd, u32 min, u32 max)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_level_to_freq(struct rpmi_perf_domain *pd, u32 level,
+						 u32 *khz)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_freq_to_level(struct rpmi_perf_domain *pd, u32 khz,
+						 u32 *level)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rpmi_perf_domain_opps_add(struct rpmi_perf_domain *pd, struct device *dev)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif /* CONFIG_RISCV_RPMI_PERFORMANCE */
+
+#endif /* _LINUX_RISCV_RPMI_PERFORMANCE_H_ */
diff --git a/include/linux/mailbox/riscv-rpmi-message.h b/include/linux/mailbox/riscv-rpmi-message.h
index d5362b5821f9..fbef6e721435 100644
--- a/include/linux/mailbox/riscv-rpmi-message.h
+++ b/include/linux/mailbox/riscv-rpmi-message.h
@@ -94,6 +94,7 @@ static inline int rpmi_to_linux_error(int rpmi_error)
 #define RPMI_SRVGRP_SYSTEM_MSI		0x00002
 #define RPMI_SRVGRP_CLOCK		0x00008
 #define RPMI_SRVGRP_DEVICE_POWER	0x00009
+#define RPMI_SRVGRP_PERFORMANCE		0x0000A
 
 /* RPMI clock service IDs */
 enum rpmi_clock_service_id {
@@ -130,6 +131,21 @@ enum rpmi_device_power_service_id {
 	RPMI_DP_SRV_ID_MAX_COUNT,
 };
 
+/* RPMI performances service IDs */
+enum rpmi_perf_service_id {
+	RPMI_PERF_SRV_ENABLE_NOTIFICATION = 0x01,
+	RPMI_PERF_SRV_GET_NUM_DOMAINS = 0x02,
+	RPMI_PERF_SRV_GET_ATTRIBUTES = 0x03,
+	RPMI_PERF_SRV_GET_SUPPORTED_LEVELS = 0x04,
+	RPMI_PERF_SRV_GET_LEVEL = 0x05,
+	RPMI_PERF_SRV_SET_LEVEL = 0x06,
+	RPMI_PERF_SRV_GET_LIMIT = 0x07,
+	RPMI_PERF_SRV_SET_LIMIT = 0x08,
+	RPMI_PERF_SRV_GET_FAST_CHANNEL_REGION = 0x09,
+	RPMI_PERF_SRV_GET_FAST_CHANNEL_ATTRS = 0x0a,
+	RPMI_PERF_SRV_ID_MAX_COUNT,
+};
+
 /* RPMI Linux mailbox attribute IDs */
 enum rpmi_mbox_attribute_id {
 	RPMI_MBOX_ATTR_SPEC_VERSION,
-- 
2.43.0


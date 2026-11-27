Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803618;
	b=ET4Q8nqOsKZDaii+IaTU5iR/b0EFnXCiI3VrET2oz5oNmnXX3B+6ezsZr2tIs7ybWcHp
	 5fXaQ7Rk4w00/JfOlMMMzFYBt4BXXwo3Dtos2eJHN7Pa6pakN1FF8RCRQ3y/BezXxR8A4
	 xw2CHE40i88T7SeSOCB7a6EMnjyxFZzfYoLMERgWtdLtxsTAHZaxSQo7XiT20rEWlajVx
	 JT+VeMr49taF9jqRb9mQVwOlSCvoTzUMjXB/ObObGazJUWwXHiwTpWFIw80eFXZ5X41Vt
	 Ts/DHa7gMW0VX2/7Radjzi+JNLF1KEFJU2E0j+JxeX1GvbO3ys8bDJWC+7RWBkIOQjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803618;
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
	bh=cKDmFtQxjEjfN/poHEzfiVV8irOBYWXfSAdyUjzl51Y=;
	b=DEmRAaZ+FoQxV+QGtNBG4hvHNN6QxPMXB51G7KBmGtftP89DzBWZvTidj2xZ0MOkYvwP
	 H8j+bC1eAUeFGG386HyiT+DKM28lBUEZd4c5nTtnui6Db2212GL7LMYMN37B+0Ftco1TK
	 aa4UUAlnlm7TpQKt7KgzlIXLt7CBjI1yXugWPOza5wu1rvjf98Gr1Vexl5qZS/+Al86u8
	 ZF2McRNpNqlKfFYKlAszUr/YTWqwKzOJx3qo3mqw9FIOLC2Iur8jzpktSdny/jQYygNmr
	 0qIvSaWoVo0aHOW+ebuyRhqyJ4FagqNZiHwXl7MfyIRTHwbNnKrf1O3uCmFzO8PgzKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HCQ20TzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.41
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C90606A339;
	Fri, 27 Nov 2026 18:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C90606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HCQ20TzO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDfmT5mOxppNNgAEIuEK2chNZT9lTufKTebELE+jDvegwB0g8DA7eoSWxxFusPDIBG2+aqL3eOvw5yvZLDBXwycs3e4bIhXXK6/vy7nGy8jRxwVg3WI7Lv84ZyutCepj2yVVlU6Xafz1PecS+wWF/0KjQWTlOJoP5frNRS0QpIG+eyyH5UFSTIhxQcgvQmR4nvzLxUxoaU9IR6pMLgRv5GTXT8IKx72BSqBWF4WVTRnbwOqm5tqAaL5rlYYWrm1iRNtkM7WjnKWxQudahncqyjeMt6OqwwV7hSfk39LClnhhFS9iW/R4QuOLjANWiRLmbTiYiWPeENxWY89aIploHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKDmFtQxjEjfN/poHEzfiVV8irOBYWXfSAdyUjzl51Y=;
 b=CTeKX4RqZ0OgIibXEgmM0hJnkYqfidr195eqAExmLsRkWMFmUFzv77tedELd9WbMR2HBhOgjDVIQcGhzVby4Gd8izuO8N2KCq3aSd5i04Sqf5Bw343FwQeOnebl55mOw4t6uFcZA5xsglieejNHSRSrfSzXvnAQ/Hh8lxyt42fIyrGPHZNkPj1c4uPUL3B8oU6lVNcFKBHMKju6Z6SfsP4TsJXVKu398/WIJMGDEellSIQsEv/WnLqxhGGEg8a7kBMcf5Tp4RcQCjAWsKLzRhjuhSpMgU6TDLDY9B1KVx6NupgBy/YNAZKRy4eNaNmN+ljz7LaljvsYz5CY2bBGIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKDmFtQxjEjfN/poHEzfiVV8irOBYWXfSAdyUjzl51Y=;
 b=HCQ20TzOFSWSo7jXAm59p5fd6ASIIPj0W3WkFNgcVvTOfaT1NvK7vXwPB3SiFMhyangQaPyTcx5SqkkOrqxygSIHp8RuXByZfO+7cdhDmmBZFSKV7mQrB/0jHRa6VYfPrrPgzuzyWJglE32R2iMj+6nlcELT8o7MSQ/OnIhCVMFI0Fz1p8/Nl9MsGF8KkHsx8MXcoetnbAwAO4xe+WNFtkLtTEOOPnEqvjBVHAPnTsTclUbhmzu4qDfUQGogevQZekBJB3g1mHJm/7yG76lAtexL0AS9bBE9Ww6jvuPewY4vvVUXw1UB+jiJAHkefm4xIFXo+OOmKQl1hb2JgGBAOQ==
Received: from PA7P264CA0268.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::16)
 by PAXPR10MB5229.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:276::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 18:20:07 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:102:375:cafe::2c) by PA7P264CA0268.outlook.office365.com
 (2603:10a6:102:375::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 18:20:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM7PEPF00000052.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 27 Nov 2026 18:20:07 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 19:20:57 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 27 Nov
 2026 19:20:06 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v2 2/7] pmdomain: st: add STM32MP power domain
Date: Fri, 27 Nov 2026 19:18:26 +0100
Message-ID: <20261127191823.v2.2.I59b2ea87f07947037b772c49c277092c887f4310@changeid>
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
X-MS-TrafficTypeDiagnostic: AM7PEPF00000052:EE_|PAXPR10MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7055ec-8ff9-4754-ae4e-08df4cb310c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|11063799006|22082099003|18002099003|3023799007|261009223027099003|261102123227099003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261022075727099003|261021135927099003|44046007;
X-Microsoft-Antispam-Message-Info:
	XiOpzl+Cy0YjS/VTiL1lm0wjvnOWTuDU7sUCPbzHQtN6cE68+gJQ+DWbqjp2EV53hI0DQyAaXhSQlRhCvF1/y1+zphDap5LrbALmvpVKMFu5QYNRuG6jJF1OBWjY4xawSprUGwVo/UWm8g/qt050ZyB1riHubR4m/x5DIYfWQJS0HNxKCjH1utW0jex9AS5ZOLFO4MUF7ZIaZ6KaZwaIW4ysNJR669OP8WEyYRA3CS0aA2Gb2BvdUceQRtOnVU0boBnV2pVUe54vJjjSGNhMj2ciJJAgzbFnCVxb6VA/KMq51upv132tenuvM8illPp6m1W4BFfxYfRSiX94Sg2h5l9q67sGIwaJGrAveaqdl4xiTgkNdSTtRAIhvZ/J3VzobBy13RPqtMaY8ccFxGz/YCDgKUr9woHjydlVOcxwYHHr/VAmg4nBs2kokfB26DHdJYbZxiRQkbYtGC6k2MBj7H6bbmzGGtdcnHeSRL7e/xpygoJvoTL4QRy7O67WjYM//U0Am3hqwBkJw/gFKRXh7s92LUchK0c6xwK0FBBBzGGX8fts8pTVr9nC6E8PJt+iHl2q4KxOuivmWmz4kvNMMFp/X3JfH4m6h6ieFmrEfTCYlRztUL+R+7JbtKn9MqUr73TcVDYmbtTT0fRKk9rrMVf0Wx+rGV8NqGVnmA0cYzDyMjIRCXsR77rofqGN8ELiMT7zEoO+AwuxsR5+FRsnKFtpIJyjpoACcYquYqXQQL+qGxgopqXM3jOig/6cCs4h
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(11063799006)(22082099003)(18002099003)(3023799007)(261009223027099003)(261102123227099003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021135927099003)(44046007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eJfdBCEcQ1ia9JqYusICiQWfbigfxVhXCwzUHKxSmjg6aWlHISw5TogoAy0huRJMrEaErHGqW5+hNfu3s0AJr49Cv7qW19MtwRcnaipJJQzqzHSks7n9Bq6m9gIwInKffJDwDJQqjQtfOTcwTm10j8xQoO0obJA7UhCzoZXnJ0Zpv/gCqFIfHCC/nWOL5rNkD7+Y06vNs0a/LoIX5dROxKZP1G6A7uJQrJf3Pvjdf224cTde2E2VXs5/KheadgQ/8q7Apt7I9BkeZVZ0lT3+S7N/bpy4kKgX21ReRQNXVf/+Q8TOT7vwN5x2Wd503Shu6TPXf+GTFJQabuq3FQ/lJsjMXQMxxwUtb+EjmisedHeWGnwl30yhOXLgE5UO3IfcubnNcG+gin6EwTVgJoZQ9vQeTnIDVUc9+K0mI7bVvOaXVxYMvgePoj5WPyXUchq6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:20:07.3355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7055ec-8ff9-4754-ae4e-08df4cb310c5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5229

Register the STM32MP D1 functional-dependency domain as a generic
power domain below the PSCI cluster domain.

Devices attached to D1 require the cluster to remain active while they
need their RCC clocks. D1 has no hardware power-switch operations and
does not propagate active-wakeup constraints; wakeup routing is handled
separately by EXTI1 and the retention domain.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

Changes in v2:
- update commit message

 drivers/pmdomain/st/Kconfig             |  14 +++
 drivers/pmdomain/st/Makefile            |   1 +
 drivers/pmdomain/st/stm32mp-pm-domain.c | 128 ++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/pmdomain/st/stm32mp-pm-domain.c

diff --git a/drivers/pmdomain/st/Kconfig b/drivers/pmdomain/st/Kconfig
index a77a70211f61..da8a54d44158 100644
--- a/drivers/pmdomain/st/Kconfig
+++ b/drivers/pmdomain/st/Kconfig
@@ -1,4 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config STM32MP_PM_DOMAIN
+	tristate "STM32MP PM domain"
+	depends on ARCH_STM32 || COMPILE_TEST
+	select PM_GENERIC_DOMAINS
+	default y
+	help
+	  Enable support for the STM32MP Power Management (PM) domain driver.
+	  This driver implements a generic PM domain for STM32MP SoCs, allowing
+	  the kernel to manage power domains for various hardware blocks using
+	  the generic power management framework. It is typically used to
+	  control the power state of devices and peripherals on STM32MP
+	  platforms. If unsure, say Y.
+
 config UX500_PM_DOMAIN
 	bool "ST-Ericsson ux500 Power Domain"
 	depends on ARCH_U8500 || COMPILE_TEST
diff --git a/drivers/pmdomain/st/Makefile b/drivers/pmdomain/st/Makefile
index 6d8b617eb834..0e8131b7fe9d 100644
--- a/drivers/pmdomain/st/Makefile
+++ b/drivers/pmdomain/st/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_STM32MP_PM_DOMAIN)		+= stm32mp-pm-domain.o
 obj-$(CONFIG_UX500_PM_DOMAIN)		+= ste-ux500-pm-domain.o
diff --git a/drivers/pmdomain/st/stm32mp-pm-domain.c b/drivers/pmdomain/st/stm32mp-pm-domain.c
new file mode 100644
index 000000000000..1a6393840f56
--- /dev/null
+++ b/drivers/pmdomain/st/stm32mp-pm-domain.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Implements PM domain using the generic PM domain for STM32MP SoC.
+ *
+ * Copyright (C) STMicroelectronics 2026
+ * Author(s): Patrick Delaunay <patrick.delaunay@foss.st.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+
+struct stm32mp_pm_subdomain_link {
+	struct generic_pm_domain *domain;
+	struct generic_pm_domain *subdomain;
+};
+
+static void stm32mp_pm_domain_genpd_remove(void *data)
+{
+	struct generic_pm_domain *genpd = data;
+
+	pm_genpd_remove(genpd);
+}
+
+static void stm32mp_pm_domain_release_subdomain(void *data)
+{
+	struct stm32mp_pm_subdomain_link *link = data;
+
+	pm_genpd_remove_subdomain(link->domain, link->subdomain);
+}
+
+static void stm32mp_pm_domain_release_genpd_provider(void *data)
+{
+	struct device_node *np = data;
+
+	of_genpd_del_provider(np);
+}
+
+static int stm32mp_pm_domain_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct generic_pm_domain *pd;
+	struct stm32mp_pm_subdomain_link *link;
+	int ret;
+
+	if (!np)
+		return -ENODEV;
+
+	/* The OF node must specify us as a power-domain provider. */
+	if (!of_property_present(np, "#power-domain-cells")) {
+		dev_warn(dev, "%pOF lacks #power-domain-cells\n", np);
+		return 0;
+	}
+
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->name = dev_name(dev);
+
+	/*
+	 * Domain based only on PM clk framework, no GENPD_FLAG_ACTIVE_WAKEUP
+	 * support, the wake-up path is handled by interrupt driver with its
+	 * power domain. GENPD_FLAG_NO_STAY_ON as domain no required sync state,
+	 * domain allow low power modes even if devices are not probed
+	 */
+	pd->flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_NO_STAY_ON;
+
+	ret = pm_genpd_init(pd, NULL, false);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init power domain\n");
+
+	ret = devm_add_action_or_reset(dev, stm32mp_pm_domain_genpd_remove, pd);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
+	link = devm_kzalloc(dev, sizeof(*link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+	link->domain = pd_to_genpd(dev->pm_domain);
+	link->subdomain = pd;
+
+	ret = pm_genpd_add_subdomain(link->domain, link->subdomain);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add subdomain\n");
+
+	ret = devm_add_action_or_reset(dev, stm32mp_pm_domain_release_subdomain, link);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add power domain provider\n");
+
+	ret = devm_add_action_or_reset(dev, stm32mp_pm_domain_release_genpd_provider, np);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add action\n");
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable pm-runtime\n");
+
+	return 0;
+}
+
+static const struct of_device_id stm32mp_pm_domain_matches[] = {
+	{ .compatible = "st,stm32mp-pm-domain", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, stm32mp_pm_domain_matches);
+
+static struct platform_driver stm32mp_pm_domain_driver = {
+	.driver = {
+		.name = "stm32mp_pm_domain",
+		.of_match_table = stm32mp_pm_domain_matches,
+	},
+	.probe  = stm32mp_pm_domain_probe,
+};
+
+module_platform_driver(stm32mp_pm_domain_driver);
+
+MODULE_AUTHOR("Patrick Delaunay <patrick.delaunay@foss.st.com>");
+MODULE_DESCRIPTION("ST STM32MP power domain driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


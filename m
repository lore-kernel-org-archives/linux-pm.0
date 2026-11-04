Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793800947;
	b=HI5BafssHGdgjmmAwDtB9k8rxgveLV2lCbDRFtLRGEVeVD2rAsmDqkRMXPOiYo9XoHhG
	 /Kq0hQrMZPSKDNasKgkerT5lJu6uNUv6BDlQNLdh3ezx77mai6s1L/qLybzJovdu5PPJ5
	 6TjA+L1TkmOAi7stc+xyonSrWvYgqNbI4lFsv8X/1Dd8UXB0oBhS0IeLd1p5QecA9bqMq
	 qzU4Lm02SrmsKwzYajvfiECv33+nA9Aiyo5R2l16+PueaPY4jCy+5ix+5l590YC41BIpG
	 C1lZLGd3BW7caZuuvI7MVoe5nH0TcbWldQeXYUcbPyLk7+2IhcAd7nx7HjPIZg/0yZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793800947;
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
	bh=clgnn/l0xxn+YplSr3tGwTORb9AMKRayHqXQE17fBq8=;
	b=XPEGgdRujym01LClqoyjBNhVjiyeUJrqNxVvnBAOGl+3BrnUmqpRriNi97PgKahfQ/DB
	 2Td5A+is2IRCEFHmzY18AoDibTKcrc0MznQc6LTyu+9dZGSXHoCkqOzudti9hKJBsiRKk
	 b91BVrcQdNNEkHFE/jwDaF4EHnG6amobvv3VcTgND5BR4KS3Kql/z3I7YoR6RKtkGyzz/
	 bDbKAdyi4Ua3/5vwEjgHo0FWDszybXO8M9xg7YJDEmeuPJ9UVC3m1n17BlZ6OKmA0CoMz
	 65icBR5W+T8rdeZXwfxWzv/eZWxBpDlww1p//Xd+h2l9Nm3VJ/Tqo1L7dgz/oeu274w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SE4c+EIu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.25
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE9606A335;
	Wed,  4 Nov 2026 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1FE9606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SE4c+EIu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYWf9PwAtyH/xmuQUH1XSY8yzhSTmU/5QmVFBnQQpI3RLWzG0RgZ7yFFVJxDz78ARyHXyn5/oae6tWMEetCNeWkRrzdI/IvcmhPXD8f3ToTZ+uSYUCUBQroprJyyOwvomBBCuQsdbOgfSfYUNmPute7Hhjjy0dRDwAU82OD+JhDOUWr0gHdu9B/Jpmet0XkVcvVAER8GqPMeCHVabOVE0+CYmuFwRnEIea6lqOt7ccuA09+cuVibYIyMQEVE4NgIZEwo1UGKwvn5LdhemHGaNv80f0sMPVVhcdM9SPaq7pRiB7GOav6dAZ3h/sePvnhncf2u4mnVb3Bb15U0ijlirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clgnn/l0xxn+YplSr3tGwTORb9AMKRayHqXQE17fBq8=;
 b=ue5sgeEcMobs3k79fq2J65BVTZ2NMX5MqkcX6qJaMylJI6kC9+63AsMJbVVznLlyKHXV8EFYXsyjhUqLwlNRVH5T62+1EbiIf46OVaCPiag5goe/0Y9d7dXc8bJ+Y2QH1cA01d/Hpgu98H19kJoJf4kK2O5Pl7Mi50EnGQIvN+y1sdPArW6lE3ZxqLEMZLcWJ8X77HbbGMDIQm2giLnviUUEOs8wXjK8zs9FEdg/OYkNkLfDOg7+6VTO4iwyYi2m/+fVjVzPK0BzJRtSGi3VxIU8e77QEmfdSTWJfQLJv72njJfK42vnBrcenpf9YH5WFwL2IG4YkOuh1lBVBpWx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clgnn/l0xxn+YplSr3tGwTORb9AMKRayHqXQE17fBq8=;
 b=SE4c+EIuDvpWGLv6MzGjSqErUegMg328m5mwtTUZxQN2VTDkcRw8w6JT1uk+/oTBpWILNS8KBsyzym+2LuZdvuyCuU7Bna3HUQeL8qgA4HjlOK9n5qDhGDyEjW+0lvMOZ770f3A3cnyr7iS99ZErehsijqJOSamsJeTyes/8j+GJT+LvimwE9GrjmcNA1w0dNu7Nku9K+oirGtPUQqBCTdnIkZwX0bwm0e/DOB+PqmZShMhEDERgVoMaE//73I9uLdkfD6dvo/pACw3bY0N8BSoYT3pK85KT7MiK2yBq8YkiujXV0OinCNFhgrTfdYPzCzKBMQXTrKK7vT2180uVtg==
Received: from MI1P293CA0018.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::12) by
 PAXPR10MB7927.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 14:02:24 +0000
Received: from MI3PEPF0000848B.eurprd02.prod.outlook.com
 (2603:10a6:290:3:cafe::ac) by MI1P293CA0018.outlook.office365.com
 (2603:10a6:290:3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 14:02:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848B.mail.protection.outlook.com (10.167.240.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 14:02:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 15:03:05 +0100
Received: from localhost (10.48.87.100) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 15:02:20 +0100
From: Patrick Delaunay <patrick.delaunay@foss.st.com>
To: Ulf Hansson <ulfh@kernel.org>, Patrick Delaunay
	<patrick.delaunay@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Linux STM32 <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
Subject: [PATCH 2/7] pmdomain: st: add STM32MP power domain
Date: Wed, 4 Nov 2026 14:55:05 +0100
Message-ID: <20261104145502.2.I59b2ea87f07947037b772c49c277092c887f4310@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104135604.907283-1-patrick.delaunay@foss.st.com>
References: <20261104135604.907283-1-patrick.delaunay@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848B:EE_|PAXPR10MB7927:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eca88c4-5af3-4fe8-ebfe-08df3a7c4096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261022075727099003|11063799006|56012099006|261026140227099003|261009223027099003|261022105027099003|261028144727099003|261021135927099003|261102123227099003|261026121527099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O1tDYRQ/H56abgnZw4xSOE4gz9fGTGSfD8KL3fzE3U1V1rcHWbL3kpwLcmYD2eBjbpFfjmTa3mHbzrScnYMvagPT7E+s7NpbLw0JX7bvyZfK+aLhqoOifwySf8meZmnzKeZCz9iWPDw6moxOaeUymjreuqQYfZxSNQsFeNqfmukXIaNTIT0hWFN77Lh/7CT8CcHK7769Ksrn3mB3Lv49vSG0Q7o9DEOpcJfgWg3WlEwfyMUWtsLGr+UTBA+k5D9y9t8kRfDlLdvsLeMCTnc8UXhQBpGs73u3QzAeK9oz8pwYD2AGoAXVNjlM3NcFXXgQFUgFf3Ye6P/DwS2sx0AXaVnGVjYPbataxuDkItrY3qM97Vw/6SXm755uSLlDx8OVmTqnWCJQuMMxoOeUNPX1hZKmWAt5o3Npdl44iUD5hsFlS4i5vYai/Fp+LO+jdmVvrHJ81lkD7UgdFHY4w5pE/4M97Zv2FF4inLDw1uFy+0EkwoLVL0e4zU9+KFxa/oi9PEyMPC3J5Tl2Ftm+GxezK/8NCng17wBErzelMNqvJztmrfcxSj4FeH6WvjgepfDmiF25FcZ2NTzSbGAVNWWLVSAZWhd61RomNOJaKwpwbQ55+EKGx8jTdSbSsRjquTSZSotLSfH1NwsdtfnpG6Lv6si04vWp/Wosn/BIeZNOXiHg9JDbe4uFQzkmZEyU2ClTGfmMRHVdcrWspRdJ04w+wg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261022075727099003)(11063799006)(56012099006)(261026140227099003)(261009223027099003)(261022105027099003)(261028144727099003)(261021135927099003)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YbaaWHY60epF3TWZWBYK0r77jH8PpXdBNFIWo7XHy04pwS8xqbp6cX6DkB6a26rVOdgIvyz3/20an31BSFC+xn/UMtBbtNNlwYRdfnSYe/aBtaBiuK2zeywZc3zMC+XevsHaqFSnocQ2moZEgdVp/t8uqOUcKMpFYmxTVS7W4Tii4COUZol5GX2mny7fjPo+BxK/5q2R84mw6CCymzol2W7fOCxHVSn0F++JTsR9UP1XZaOQiAOlE8hPLlOiERy3c6LT3SUA237TVPxkz3W55jegJA7lQcMYP2SwwfXzggqDcDyBQIuJP+/8vny5M3AnHPqeeMzNXzIsaRnLXxeUI8ij6Vo9gR4hKefRUP8R1fkiHCFLjzCSUlPp5fYmDkusjg58QdB9Rh3Ten7uuPgE/QkwHSZbo7g+8yFVPWB3+Zr5owleKa+CKDU65NgMgY7R
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 14:02:24.3518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eca88c4-5af3-4fe8-ebfe-08df3a7c4096
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000848B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB7927

Add a generic PM domain for the STM32MP D1 domain, using the PM
framework to manage attached devices.

Make D1 a subdomain of the PSCI cluster domain, so active devices keep
the Cortex-A35 cluster in Run1. Do not set GENPD_FLAG_ACTIVE_WAKEUP on
D1: system wakeups are handled by EXTI1 through the RET_PD PSCI domain.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
---

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


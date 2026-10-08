Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E58480DC7;
	Thu,  8 Oct 2026 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450778; cv=fail; b=uBTZSkKh2s/eIhktxopUJOcjUG8Xaup52gatzLJx0r9c0IgH2i9/Ie8AwVZsZYeZqChKQlTAfN+MU7tp16+BymV4rZL3bj67ErwjAzPrsleK3hXzcBPzd2nhmhDZ5bKgstO620rbjhHI+hOJIOWylGfol26+T4njlUSb88FW4HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450778; c=relaxed/simple;
	bh=MrVvVU5LGrJ1R9PCNBvDukFgDRejm+F1RH3PBa56ll0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fq0R8iBsTnPNWIBWk0pDMCrcmKiiz7VDGSg0eobVu6yNIctrgikBXlDz4k4e5NGIwsvj95qWgBED3Xl7oSrrW2ApcTCA567SQxF8FMC4GhKDj/AsCtexBBiXGqtFBwFCxfXC9+0mR9XF6q74UMO9hXsxw/enLSUsl7DSuaeZNgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5lG8exXzJB5u+UJFr6SczygA8FrG+hnZ7Hn8xvSGX8wXG4oL2R30lqkn6QxIQIYutZxK4j/vWZEQwuKqU8798ZX7LnJlJLdf1ZXUwlblC8TOAmt6DR5dUlxs7dOwyEFgRYUMPphyO7WvkX6nCWbk1WASrVi061oo3bHT+I9jKrbMwJLG6giSDsJW6NEOcT9JU9zYiylE678nBnZ91AlpYPFqXHOSMuxr51ncCDO+F0Zu3nYNHvKqqyQV2TADTQNUYeGztVDmyUZ2G/D0xF5lekWM+oq/cXnV1DYl1jJJNlsSOjKOjJ4h8no6Uf49T9cr+IKwLNtmVbF6068Ov/wSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw7+U8InCvvpAgTpCrKgzFEuTHHQl7hpGuLyIWVffGc=;
 b=Zfe8PczSvbqTpIfSQk0GMuEvMYi+iynRr9kGKNnIGc06vqQym2BMJUIBjkAdBI1/EwkDa001Qs3UtxXoItcJP+1Q9RGzMmg+uwDzukike8zvaJGYVEUDc8YQqurFEhOZ7ZUedrC6SHEHdEhn7hBQ9fNzt0BhbvbJjNSB45cgVzl+yO4nEdDx9XPUPOhYF12T/gz1e52MkaYN9jn42vbIi5EUCMW/ZH0xXWx+rjmdRUwShkB+ohNYgUR+lojTtkfNg/d4D2OL+ESSJeFI0vKfT30oJCMXNKjfd5H/0Jcecb/2CGbQAxC7fug6mLmPT6r9UZaQ7GJkFvl1kyVaQQ7n7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::11) by NT0PR01MB1309.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 09:12:33 +0000
Received: from NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24]) by NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
 ([fe80::6da4:f1ae:9ce:9a24%6]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 09:12:33 +0000
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
Subject: [PATCH v2 6/7] pmdomain: riscv: Add RPMI performance domains as power domains
Date: Thu,  8 Oct 2026 17:10:30 +0800
Message-ID: <20261008091032.2832333-7-joshua.yeong@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3476aa43-6fe4-4067-d032-08df251c49af
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|52116014|921020|38350700014|5023799004|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	GVVBM3bMac7DoJpVsuKrzgraxzjhZQ8dD43PwPQOt18mdH3vgXs/+hRhx3NDvyeSdRupTAd6RSU7uKsuVhF0vFNs2Wnagd5DYxSfaFNxjcabQpHPBoJjhH5p8lxlZ/iaOM6JnccSvnn0iwnuLFuKfk3fvoMMjPunLoaamHOXscsQzTGxDpOENxS4XKEBzJHdYN0vYASAIAYpsZl3QgZhTHPop7Cv87Jl7rPSSf2F6VKx+2zMeJNKCZJuRA/UyUXfBfvTWZX8mHu41dlKm7YKBrdfNNJGnFLCw7Nu23zxQGvIHhgwbQuMc30NOS8rdtS44jIXAI/Z+HBNgvS7UQP2Egwl2LyHkDnlUgj4XadF2sM7wRboRSEUMEG9ZVeUCy+ee6oX7B6tzbxC8F9rCW6gYrolKj6iqiutYHoIej/vkKX0QVbJSS4kFTl2aF5vD2LaUDZNA0w90WguVpoeJQ/Y/tqXQ7C6wnGDNPkN848L79beGOPGDm9G4XdFyQtOVpw+SSprzprRWAzKp/s6fs7a7sxIGqo09vWh0i+rgwBhK49RRzp9SvL3DmEt8qi17VMOoRTBHAMAPs2XPgLo0Tp2qA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(52116014)(921020)(38350700014)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kfz8QkBZOoRbdF2ChPeRtBTiuXXJZ4X6VbxgLSCvTJkJRVbfHGtj05DS33q5?=
 =?us-ascii?Q?rzrdjv+SWlabQJXV1bYmkzOY8c1dpXlRlNWg/Rj7YQXwK7/fvaiOk1yCzRMq?=
 =?us-ascii?Q?/UuvzQ+l/+DJMJTwRLdNAcpTOeYifqLkPOM4Cr4iwa8NGxui/ZvE1DOPoDHZ?=
 =?us-ascii?Q?A3Z+OyZEUKCMfxnnE+ManbDmNjOM8cqqZjEHhx2ye8KMDB5eoDiiaYObPOon?=
 =?us-ascii?Q?JXH2rxyl1E4JG257Dhk46AM5VK2KzjopggT3agBOeGTMLpdHBgWCAhjvOCMu?=
 =?us-ascii?Q?Cw7LDvBTwsh91Z1I+jfYHwZrdO4LAmD/ti3s2EqnZY70voNOJ3jxryJsttlA?=
 =?us-ascii?Q?FrwUt+roYyNXepmvOEkAOWtJJ0aS/W9M/qLCqsphWS+nHt+/phSA4K5KDRbl?=
 =?us-ascii?Q?0PTrS66IUF4WLYRGYjlUkwNN3zdQ12kbjqR7L5Qfbhu+SXwKKC19MkjOjr3k?=
 =?us-ascii?Q?JlZAIUJNu0pTyTsREo3wphmaLcj6c3j4KyvD3eh2cZGzMlYbpJBbARj9InD5?=
 =?us-ascii?Q?AOQ5y41KC1CaemMGXT2HKeT/ZZX8FNsjQ/jBrlZQEteBz1kb8CIU8x9pJgRy?=
 =?us-ascii?Q?hs4m1zY/EleOpk2OcWBlpQ/lQdDU/xTlhLWwOvDr2scbUNHfiV3kPBnJcpGK?=
 =?us-ascii?Q?RwNx4RvAM1YPvJ3zQiI2D2Sujwa0ar75R0H7aT3Lwfl53XZsxT3K3vGB6bzW?=
 =?us-ascii?Q?UWJQFTGmdSExQbovJe5/5SD516OrZ9i0TcfYysk5q5aBiVOwPCGZr8AzQYHS?=
 =?us-ascii?Q?oBKkF8g+2MXcTrwZZquIPNKCyFxfY+6Haq5Sf69zeU8V+2K99w9eVV6mtFL7?=
 =?us-ascii?Q?c+/7i1hLCSkKJgLe7yqGBiQolIm6jKTFAUt0QJgRo2cXbqQZa/Md99KHaNQP?=
 =?us-ascii?Q?27my9ynuu27Ol+eTJTrWqnizCZyrQ/qAVZmWkdtJnOHWwl0Rg9EJJXejsRqg?=
 =?us-ascii?Q?UMAt3f0FI3E9hU/0NHuArVNdUpyf2y9KQjBOy4VuzZVHYa9JUrAuBc+uQYQ8?=
 =?us-ascii?Q?F0chPtewhKDdRRe2T8TlXjVA6NN0YB7K/ZF9yf6XG6Vct+yRefebLlSrbo7S?=
 =?us-ascii?Q?wqFTB6TeKFlqQ74DuVs46ENKXBoQ/B8rYceudQx6rtXL3KA1caC/eqZg0dSo?=
 =?us-ascii?Q?g0lJadvspsto+o9tVshRt0UnYLLFaVgHeUfyn0qcIN1Jo4tNYUJpHnhtsPtX?=
 =?us-ascii?Q?3og2IlxlFhrg+qR3faQPDU/GXFEoSKH/d3nvZBU6Ffr7ZuRnuqp0E60GkPR3?=
 =?us-ascii?Q?fsC4HHKzxtFl5jQasarXa69z7Laaa9R/R1elW1Ih4bXzljDiEzS1rEPEpexP?=
 =?us-ascii?Q?SUKWdRg4NqK6FDGgztfbqzwvQZtNsDnsjFEepOVQHSfc6msLzmw7/VP5xS0L?=
 =?us-ascii?Q?fwdvb30BCn1IGwVMZpKFipOkZPwiDm3uE9UdtUqeMZC2Vj5RFXk7OvKr2nUf?=
 =?us-ascii?Q?ThlVSFbF/i73SJb82k/Ak/b/lW/MBzCSh9sB5wgcDW0AMax9P5MXVlJlnsiS?=
 =?us-ascii?Q?1rVWfad3uarSymvif5GgMLI9UsXbS+J1LDgkqWBwvvHnOcvQVD0J3HksPyOS?=
 =?us-ascii?Q?Lbpj6z2sLbAjXsyl5a0WUXr3+rDaEuPDczOYFXFN7FChdi/oBTV33tFV8p2s?=
 =?us-ascii?Q?HaghBd53FyM/YJECOcWVeTLY70KU1ogj56Jwo5mqxnIJF6rejWO/UPQ35nvv?=
 =?us-ascii?Q?c6GnBuGezA0MLXZAlw2mn7dxwxnzjl6lOcdy3Q43TSOxfg/TtZuTz4VF/p3F?=
 =?us-ascii?Q?bZD7DzqI7lbHcTGAOVdYTu0qICgoCtE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3476aa43-6fe4-4067-d032-08df251c49af
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1325.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:12:33.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oaqu7xmDQKqVq+YTwXMbFDeuQ+eeYUxpBIZixC3YzN44T+VYTRouNETnDTW4ZmQ67fxOAAOIWnzHgVM0jqKJGsy89NEC7x7HjriFzvKs1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1309

A device that is not a CPU has no generic way to drive an RPMI
performance domain: "performance-domains" is only resolved by cpufreq,
which would leave a device driver to call into RPMI directly, with
nothing to arbitrate between devices that share a domain.

A device names its domain through "power-domains", is handed an
operating point per level when it attaches, and drives the domain
through the OPP library, while genpd settles on the highest state any
device in the domain asks for.

Like cpufreq, this is a front-end over the performance service group
core, which creates the device it binds to when the node carries
"#power-domain-cells".

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../firmware/riscv/riscv-rpmi-performance.c   |  26 ++
 drivers/pmdomain/riscv/Kconfig                |  16 ++
 drivers/pmdomain/riscv/Makefile               |   1 +
 .../pmdomain/riscv/riscv-rpmi-perf-domain.c   | 265 ++++++++++++++++++
 4 files changed, 308 insertions(+)
 create mode 100644 drivers/pmdomain/riscv/riscv-rpmi-perf-domain.c

diff --git a/drivers/firmware/riscv/riscv-rpmi-performance.c b/drivers/firmware/riscv/riscv-rpmi-performance.c
index f91f2d861dc0..d532d41ecbba 100644
--- a/drivers/firmware/riscv/riscv-rpmi-performance.c
+++ b/drivers/firmware/riscv/riscv-rpmi-performance.c
@@ -1046,6 +1046,28 @@ static int rpmi_perf_cpufreq_register(struct device *dev, struct rpmi_perf *perf
 	return devm_add_action_or_reset(dev, rpmi_perf_frontend_unregister, pdev);
 }
 
+/*
+ * A device that is not a CPU names its domain through "power-domains", which
+ * the power domain front-end serves on this node. Create the device it binds
+ * to, but only when the node is a power domain provider at all.
+ */
+static int rpmi_perf_genpd_register(struct device *dev, struct rpmi_perf *perf)
+{
+	struct platform_device *pdev;
+
+	if (!IS_ENABLED(CONFIG_RISCV_RPMI_PERF_DOMAIN) ||
+	    !of_property_present(dev_of_node(dev), "#power-domain-cells"))
+		return 0;
+
+	pdev = platform_device_register_data(dev, "riscv-rpmi-perf-domain",
+					     PLATFORM_DEVID_AUTO, &perf,
+					     sizeof(perf));
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return devm_add_action_or_reset(dev, rpmi_perf_frontend_unregister, pdev);
+}
+
 static int rpmi_perf_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1133,6 +1155,10 @@ static int rpmi_perf_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register cpufreq device\n");
 
+	ret = rpmi_perf_genpd_register(dev, mpxy_perf);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register power domain device\n");
+
 	dev_info(dev, "%d MPXY performance domains registered\n", num_domains);
 
 	return 0;
diff --git a/drivers/pmdomain/riscv/Kconfig b/drivers/pmdomain/riscv/Kconfig
index 97232edc294a..6f3006d3220a 100644
--- a/drivers/pmdomain/riscv/Kconfig
+++ b/drivers/pmdomain/riscv/Kconfig
@@ -13,3 +13,19 @@ config RISCV_RPMI_DEVICE_POWER
 	  specification. The power domains advertised by the platform
 	  microcontroller are registered as generic power domains, so that
 	  devices can reference them through the "power-domains" property.
+
+config RISCV_RPMI_PERF_DOMAIN
+	tristate "RISC-V RPMI performance domains as power domains"
+	depends on RISCV_RPMI_PERFORMANCE
+	depends on PM
+	default RISCV
+	select PM_GENERIC_DOMAINS
+	help
+	  Register the performance domains of the RISC-V platform management
+	  interface (RPMI) performance service group as generic power domains,
+	  with a performance state for each level the platform microcontroller
+	  advertises. A device that is not a CPU references its domain through
+	  the "power-domains" property and drives it through the OPP library.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called riscv-rpmi-perf-domain.
diff --git a/drivers/pmdomain/riscv/Makefile b/drivers/pmdomain/riscv/Makefile
index 2cb0ee8ad413..32fd12ebb9cd 100644
--- a/drivers/pmdomain/riscv/Makefile
+++ b/drivers/pmdomain/riscv/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_RISCV_RPMI_DEVICE_POWER)	+= riscv-rpmi-device-power.o
+obj-$(CONFIG_RISCV_RPMI_PERF_DOMAIN)	+= riscv-rpmi-perf-domain.o
diff --git a/drivers/pmdomain/riscv/riscv-rpmi-perf-domain.c b/drivers/pmdomain/riscv/riscv-rpmi-perf-domain.c
new file mode 100644
index 000000000000..fc5c512fe069
--- /dev/null
+++ b/drivers/pmdomain/riscv/riscv-rpmi-perf-domain.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V RPMI performance domains as generic power domains
+ *
+ * Copyright (C) 2026 Shanghai StarFive Technology Co., Ltd.
+ *
+ * A device that is not a CPU names its RPMI performance domain through
+ * "power-domains". Each domain is registered here as a generic power domain
+ * whose performance states are the levels the platform microcontroller
+ * advertises, so the device's driver drives it through the OPP library like
+ * any other power domain with performance states, and genpd settles on the
+ * highest state any device in the domain asks for.
+ *
+ * Performance state 0 means that no device in the domain asks for anything,
+ * while 0 is a valid RPMI level index. State N is therefore level index
+ * N - 1, and state 0 leaves the domain at whatever level it is running.
+ *
+ * genpd runs the domain at the highest state asked for, which is the highest
+ * level index. That is the level to run at: the specification makes the
+ * level index the platform's performance scale, which its limit services
+ * also order levels by, so a higher index is a higher level whatever the
+ * indices in between.
+ *
+ * A domain that CPUs name through "performance-domains" belongs to cpufreq,
+ * which sets its level directly, so no device is attached to it as well.
+ *
+ * The RPMI protocol and the domain enumeration live in the performance
+ * service group core, which owns the mailbox channel and creates the device
+ * this driver binds to.
+ */
+
+#include <linux/firmware/riscv/riscv-rpmi-performance.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
+#include <linux/units.h>
+
+struct rpmi_perf_genpd {
+	struct generic_pm_domain genpd;
+	struct rpmi_perf_domain *domain;
+	bool cpu_domain;
+};
+
+struct rpmi_perf_genpd_provider {
+	struct genpd_onecell_data data;
+	struct rpmi_perf_genpd *pds;
+};
+
+#define to_rpmi_perf_genpd(gpd) container_of(gpd, struct rpmi_perf_genpd, genpd)
+
+static int rpmi_perf_genpd_set_performance_state(struct generic_pm_domain *genpd,
+						 unsigned int state)
+{
+	struct rpmi_perf_genpd *pd = to_rpmi_perf_genpd(genpd);
+	int ret;
+
+	/* No device in the domain asks for a level, so leave it where it is. */
+	if (!state)
+		return 0;
+
+	ret = rpmi_perf_domain_set_level(pd->domain, state - 1);
+	if (ret)
+		dev_warn(&genpd->dev, "failed to set level %u: %d\n",
+			 state - 1, ret);
+
+	return ret;
+}
+
+/*
+ * The levels come from the platform microcontroller, so there is no
+ * operating-points-v2 table in the device tree. Hand each device that
+ * attaches an operating point per level instead, carrying the level's
+ * frequency and its performance state.
+ */
+static int rpmi_perf_genpd_attach_dev(struct generic_pm_domain *genpd,
+				      struct device *dev)
+{
+	struct rpmi_perf_genpd *pd = to_rpmi_perf_genpd(genpd);
+	struct dev_pm_opp_data data = {};
+	struct rpmi_perf_level level;
+	u32 idx;
+	int ret;
+
+	/* cpufreq and genpd would each set the level behind the other's back. */
+	if (pd->cpu_domain) {
+		dev_err(dev, "%s is the performance domain of a CPU\n", genpd->name);
+		return -EBUSY;
+	}
+
+	/* A domain whose level cannot be set has no state to offer. */
+	if (!rpmi_perf_domain_can_set_level(pd->domain))
+		return 0;
+
+	for (idx = 0; idx < rpmi_perf_domain_level_count(pd->domain); idx++) {
+		ret = rpmi_perf_domain_level_info(pd->domain, idx, &level);
+		if (ret)
+			goto err;
+
+		/* Frequency from RPMI is in kHz */
+		data.freq = (unsigned long)level.clock_freq * HZ_PER_KHZ;
+		data.level = level.index + 1;
+
+		ret = dev_pm_opp_add_dynamic(dev, &data);
+		if (ret)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	dev_warn(dev, "failed to add operating points for %s: %d\n",
+		 genpd->name, ret);
+	dev_pm_opp_remove_all_dynamic(dev);
+
+	return ret;
+}
+
+static void rpmi_perf_genpd_detach_dev(struct generic_pm_domain *genpd,
+				       struct device *dev)
+{
+	struct rpmi_perf_genpd *pd = to_rpmi_perf_genpd(genpd);
+
+	if (rpmi_perf_domain_can_set_level(pd->domain))
+		dev_pm_opp_remove_all_dynamic(dev);
+}
+
+/* Mark the domains that CPUs name through "performance-domains". */
+static void rpmi_perf_genpd_mark_cpu_domains(struct device_node *np,
+					     struct rpmi_perf_genpd *pds,
+					     u32 num_domains)
+{
+	struct of_phandle_args args;
+	struct device_node *cpu_np;
+
+	for_each_of_cpu_node(cpu_np) {
+		if (of_parse_phandle_with_args(cpu_np, "performance-domains",
+					       "#performance-domain-cells", 0,
+					       &args))
+			continue;
+
+		if (args.np == np && args.args_count >= 1 &&
+		    args.args[0] < num_domains)
+			pds[args.args[0]].cpu_domain = true;
+
+		of_node_put(args.np);
+	}
+}
+
+static int rpmi_perf_genpd_probe(struct platform_device *pdev)
+{
+	struct rpmi_perf **mpxy_perf = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct rpmi_perf_genpd_provider *provider;
+	struct generic_pm_domain **domains;
+	u32 i, num_domains, registered = 0;
+	int ret;
+
+	if (!mpxy_perf || !*mpxy_perf)
+		return -EINVAL;
+
+	num_domains = rpmi_perf_num_domains(*mpxy_perf);
+
+	provider = devm_kzalloc(dev, sizeof(*provider), GFP_KERNEL);
+	if (!provider)
+		return -ENOMEM;
+
+	provider->pds = devm_kcalloc(dev, num_domains, sizeof(*provider->pds),
+				     GFP_KERNEL);
+	if (!provider->pds)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	rpmi_perf_genpd_mark_cpu_domains(dev_of_node(dev->parent), provider->pds,
+					 num_domains);
+
+	for (i = 0; i < num_domains; i++) {
+		struct rpmi_perf_genpd *pd = &provider->pds[i];
+
+		/*
+		 * A domain that could not be enumerated is left out, the way
+		 * the device power provider leaves out a domain it cannot use.
+		 * A device that names it then never gets its power domain.
+		 */
+		pd->domain = rpmi_perf_domain_by_id(*mpxy_perf, i);
+		if (!pd->domain)
+			continue;
+
+		pd->genpd.name = rpmi_perf_domain_name(pd->domain);
+		/*
+		 * A performance domain has no off state, its operating points
+		 * come from the platform microcontroller rather than from the
+		 * device tree, and its name is not guaranteed to be unique.
+		 */
+		pd->genpd.flags = GENPD_FLAG_ALWAYS_ON |
+				  GENPD_FLAG_OPP_TABLE_FW |
+				  GENPD_FLAG_DEV_NAME_FW;
+		pd->genpd.set_performance_state = rpmi_perf_genpd_set_performance_state;
+		pd->genpd.attach_dev = rpmi_perf_genpd_attach_dev;
+		pd->genpd.detach_dev = rpmi_perf_genpd_detach_dev;
+
+		ret = pm_genpd_init(&pd->genpd, NULL, false);
+		if (ret)
+			goto err;
+
+		domains[i] = &pd->genpd;
+		registered++;
+	}
+
+	provider->data.domains = domains;
+	provider->data.num_domains = num_domains;
+
+	/* The domains belong to the node the core was probed from. */
+	ret = of_genpd_add_provider_onecell(dev_of_node(dev->parent),
+					    &provider->data);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, provider);
+
+	dev_info(dev, "%u MPXY performance domains registered as power domains\n",
+		 registered);
+
+	return 0;
+
+err:
+	while (i--) {
+		if (domains[i])
+			pm_genpd_remove(domains[i]);
+	}
+
+	return dev_err_probe(dev, ret, "failed to register power domains\n");
+}
+
+static void rpmi_perf_genpd_remove(struct platform_device *pdev)
+{
+	struct rpmi_perf_genpd_provider *provider = platform_get_drvdata(pdev);
+	u32 i;
+
+	of_genpd_del_provider(dev_of_node(pdev->dev.parent));
+
+	for (i = 0; i < provider->data.num_domains; i++) {
+		if (provider->data.domains[i])
+			pm_genpd_remove(provider->data.domains[i]);
+	}
+}
+
+static struct platform_driver rpmi_perf_genpd_platdrv = {
+	.driver = {
+		.name = "riscv-rpmi-perf-domain",
+	},
+	.probe = rpmi_perf_genpd_probe,
+	.remove = rpmi_perf_genpd_remove,
+};
+
+module_platform_driver(rpmi_perf_genpd_platdrv);
+
+MODULE_ALIAS("platform:riscv-rpmi-perf-domain");
+MODULE_AUTHOR("Joshua Yeong <joshua.yeong@starfivetech.com>");
+MODULE_DESCRIPTION("Power domains for the RISC-V RPMI performance service");
+MODULE_LICENSE("GPL");
-- 
2.43.0


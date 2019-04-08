Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99728C10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46271208E3
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="aKIJ8OKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfDHLM6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:12:58 -0400
Received: from mail-eopbgr780054.outbound.protection.outlook.com ([40.107.78.54]:14670
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbfDHLM4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 07:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeU7scvmT36loRemui8+L7kyIvmTNssrknKnyKbdkFw=;
 b=aKIJ8OKkYKZk0ezBDSAvlrCsWOGga5CKBKmBQbbsFpaKYsoTX7SUn2jdzxhSpNsiTflVjunaknP1ETA8z57/L0RFOLEQeuoLdMeKq+Ssy9BAW+jK5MXy2gr8InpestzqqTEx52b8yZbERfnfJ6jgjSIJK1+n6SYWzPYgXiGOgX8=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:405:6f::30)
 by DM5PR03MB3129.namprd03.prod.outlook.com (2603:10b6:4:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.21; Mon, 8 Apr
 2019 11:12:48 +0000
Received: from CY1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BN6PR03CA0092.outlook.office365.com
 (2603:10b6:405:6f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.13 via Frontend
 Transport; Mon, 8 Apr 2019 11:12:47 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT032.mail.protection.outlook.com (10.152.75.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 8 Apr 2019 11:12:47 +0000
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x38BCkJ3026968
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 8 Apr 2019 04:12:46 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS8.ad.analog.com
 (10.64.69.108) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 07:12:46 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id x38BCgQU024818;  Mon, 8 Apr 2019 07:12:44 -0400
From:   <michael.hennerich@analog.com>
To:     <mike.looijmans@topic.nl>, <sre@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robin.getz@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2 2/2] power: supply: ltc3651-charger: Fix device name (rename files)
Date:   Mon, 8 Apr 2019 13:17:20 +0200
Message-ID: <1554722240-22183-2-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554722240-22183-1-git-send-email-michael.hennerich@analog.com>
References: <1554722240-22183-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(136003)(2980300002)(189003)(199004)(51416003)(316002)(72206003)(76176011)(16586007)(246002)(106002)(48376002)(106466001)(50466002)(107886003)(8676002)(86152003)(8936002)(36756003)(126002)(14444005)(2616005)(476003)(2876002)(11346002)(50226002)(426003)(446003)(26005)(7636002)(47776003)(4326008)(478600001)(305945005)(186003)(49486002)(110136005)(54906003)(2906002)(30864003)(486006)(77096007)(356004)(86362001)(6666004)(5660300002)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3129;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7eeef64-92f2-4195-a588-08d6bc1321af
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:DM5PR03MB3129;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3129:
X-Microsoft-Antispam-PRVS: <DM5PR03MB3129305B5F7C8B718E1A1FF48E2C0@DM5PR03MB3129.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0001227049
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: HV7b+zBkBdxeBkAOiR5wcdfj4LzaD55mOV6WGbX96IfeoPbydN2W4Tz2F1Ru0n9fHgd1PO99UOKWOQAoPOUdxEFM67RSGS6Badqx0guq0OZNJHCiy99qW5y0pbxxvUGPWNofWOadkvJ94oKIU1yI0YzWxeCQRuvLTQt9ODm9DrjXMSmTGd2JYaGDWX1lmQYIYtdjFoI/v74/mnpfecHImyKcVw5hnXsE+IkgS+ahFiycKB3Ye/p7wdxWJ/BS/itc/PCFAY1Rc8QbznzTpJ7QPTve51FY99K1czgLNPYCtybF0LlepFaJvoOY8K8AZWcE+f3qLmoFfa2XPTYbMtpx0x/e69MnGmwbQBt6m3DrGBdslLNc07VGkMw3P78zpmwMAy6FyFHVslYTGDXUrpjjrpzSAUh150HL5Ur8Bk0RO4A=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2019 11:12:47.1030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7eeef64-92f2-4195-a588-08d6bc1321af
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3129
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

rename only - no functional changes

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 .../bindings/power/supply/lt3651-charger.txt       |  29 +++
 .../bindings/power/supply/ltc3651-charger.txt      |  29 ---
 drivers/power/supply/Makefile                      |   2 +-
 drivers/power/supply/lt3651-charger.c              | 207 +++++++++++++++++++++
 drivers/power/supply/ltc3651-charger.c             | 207 ---------------------
 5 files changed, 237 insertions(+), 237 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
 delete mode 100644 Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
 create mode 100644 drivers/power/supply/lt3651-charger.c
 delete mode 100644 drivers/power/supply/ltc3651-charger.c

diff --git a/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt b/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
new file mode 100644
index 0000000..40811ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/lt3651-charger.txt
@@ -0,0 +1,29 @@
+Analog Devices LT3651 Charger Power Supply bindings: lt3651-charger
+
+Required properties:
+- compatible: Should contain one of the following:
+ * "lltc,ltc3651-charger", (DEPRECATED: Use "lltc,lt3651-charger")
+ * "lltc,lt3651-charger"
+ - lltc,acpr-gpios: Connect to ACPR output. See remark below.
+
+Optional properties:
+ - lltc,fault-gpios: Connect to FAULT output. See remark below.
+ - lltc,chrg-gpios: Connect to CHRG output. See remark below.
+
+The lt3651 outputs are open-drain type and active low. The driver assumes the
+GPIO reports "active" when the output is asserted, so if the pins have been
+connected directly, the GPIO flags should be set to active low also.
+
+The driver will attempt to aquire interrupts for all GPIOs to detect changes in
+line state. If the system is not capabale of providing interrupts, the driver
+cannot report changes and userspace will need to periodically read the sysfs
+attributes to detect changes.
+
+Example:
+
+	charger: battery-charger {
+		compatible = "lltc,lt3651-charger";
+		lltc,acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
+		lltc,fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
+		lltc,chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
+	};
diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
deleted file mode 100644
index 40811ff..0000000
--- a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Analog Devices LT3651 Charger Power Supply bindings: lt3651-charger
-
-Required properties:
-- compatible: Should contain one of the following:
- * "lltc,ltc3651-charger", (DEPRECATED: Use "lltc,lt3651-charger")
- * "lltc,lt3651-charger"
- - lltc,acpr-gpios: Connect to ACPR output. See remark below.
-
-Optional properties:
- - lltc,fault-gpios: Connect to FAULT output. See remark below.
- - lltc,chrg-gpios: Connect to CHRG output. See remark below.
-
-The lt3651 outputs are open-drain type and active low. The driver assumes the
-GPIO reports "active" when the output is asserted, so if the pins have been
-connected directly, the GPIO flags should be set to active low also.
-
-The driver will attempt to aquire interrupts for all GPIOs to detect changes in
-line state. If the system is not capabale of providing interrupts, the driver
-cannot report changes and userspace will need to periodically read the sysfs
-attributes to detect changes.
-
-Example:
-
-	charger: battery-charger {
-		compatible = "lltc,lt3651-charger";
-		lltc,acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
-		lltc,fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
-		lltc,chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
-	};
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index 714c602..a2b3ab1 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
 obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
-obj-$(CONFIG_CHARGER_LT3651)	+= ltc3651-charger.o
+obj-$(CONFIG_CHARGER_LT3651)	+= lt3651-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
diff --git a/drivers/power/supply/lt3651-charger.c b/drivers/power/supply/lt3651-charger.c
new file mode 100644
index 0000000..8de500f
--- /dev/null
+++ b/drivers/power/supply/lt3651-charger.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
+ *  Copyright (C) 2017, Topic Embedded Products
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+
+struct lt3651_charger {
+	struct power_supply *charger;
+	struct power_supply_desc charger_desc;
+	struct gpio_desc *acpr_gpio;
+	struct gpio_desc *fault_gpio;
+	struct gpio_desc *chrg_gpio;
+};
+
+static irqreturn_t lt3651_charger_irq(int irq, void *devid)
+{
+	struct power_supply *charger = devid;
+
+	power_supply_changed(charger);
+
+	return IRQ_HANDLED;
+}
+
+static inline struct lt3651_charger *psy_to_lt3651_charger(
+	struct power_supply *psy)
+{
+	return power_supply_get_drvdata(psy);
+}
+
+static int lt3651_charger_get_property(struct power_supply *psy,
+		enum power_supply_property psp, union power_supply_propval *val)
+{
+	struct lt3651_charger *lt3651_charger = psy_to_lt3651_charger(psy);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		if (!lt3651_charger->chrg_gpio) {
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			break;
+		}
+		if (gpiod_get_value(lt3651_charger->chrg_gpio))
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+		break;
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = gpiod_get_value(lt3651_charger->acpr_gpio);
+		break;
+	case POWER_SUPPLY_PROP_HEALTH:
+		if (!lt3651_charger->fault_gpio) {
+			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
+			break;
+		}
+		if (!gpiod_get_value(lt3651_charger->fault_gpio)) {
+			val->intval = POWER_SUPPLY_HEALTH_GOOD;
+			break;
+		}
+		/*
+		 * If the fault pin is active, the chrg pin explains the type
+		 * of failure.
+		 */
+		if (!lt3651_charger->chrg_gpio) {
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+			break;
+		}
+		val->intval = gpiod_get_value(lt3651_charger->chrg_gpio) ?
+				POWER_SUPPLY_HEALTH_OVERHEAT :
+				POWER_SUPPLY_HEALTH_DEAD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static enum power_supply_property lt3651_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_ONLINE,
+	POWER_SUPPLY_PROP_HEALTH,
+};
+
+static int lt3651_charger_probe(struct platform_device *pdev)
+{
+	struct power_supply_config psy_cfg = {};
+	struct lt3651_charger *lt3651_charger;
+	struct power_supply_desc *charger_desc;
+	int ret;
+
+	lt3651_charger = devm_kzalloc(&pdev->dev, sizeof(*lt3651_charger),
+					GFP_KERNEL);
+	if (!lt3651_charger)
+		return -ENOMEM;
+
+	lt3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
+					"lltc,acpr", GPIOD_IN);
+	if (IS_ERR(lt3651_charger->acpr_gpio)) {
+		ret = PTR_ERR(lt3651_charger->acpr_gpio);
+		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
+		return ret;
+	}
+	lt3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
+					"lltc,fault", GPIOD_IN);
+	if (IS_ERR(lt3651_charger->fault_gpio)) {
+		ret = PTR_ERR(lt3651_charger->fault_gpio);
+		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
+		return ret;
+	}
+	lt3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
+					"lltc,chrg", GPIOD_IN);
+	if (IS_ERR(lt3651_charger->chrg_gpio)) {
+		ret = PTR_ERR(lt3651_charger->chrg_gpio);
+		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
+		return ret;
+	}
+
+	charger_desc = &lt3651_charger->charger_desc;
+	charger_desc->name = pdev->dev.of_node->name;
+	charger_desc->type = POWER_SUPPLY_TYPE_MAINS;
+	charger_desc->properties = lt3651_charger_properties;
+	charger_desc->num_properties = ARRAY_SIZE(lt3651_charger_properties);
+	charger_desc->get_property = lt3651_charger_get_property;
+	psy_cfg.of_node = pdev->dev.of_node;
+	psy_cfg.drv_data = lt3651_charger;
+
+	lt3651_charger->charger = devm_power_supply_register(&pdev->dev,
+						      charger_desc, &psy_cfg);
+	if (IS_ERR(lt3651_charger->charger)) {
+		ret = PTR_ERR(lt3651_charger->charger);
+		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Acquire IRQs for the GPIO pins if possible. If the system does not
+	 * support IRQs on these pins, userspace will have to poll the sysfs
+	 * files manually.
+	 */
+	if (lt3651_charger->acpr_gpio) {
+		ret = gpiod_to_irq(lt3651_charger->acpr_gpio);
+		if (ret >= 0)
+			ret = devm_request_any_context_irq(&pdev->dev, ret,
+				lt3651_charger_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), lt3651_charger->charger);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
+	}
+	if (lt3651_charger->fault_gpio) {
+		ret = gpiod_to_irq(lt3651_charger->fault_gpio);
+		if (ret >= 0)
+			ret = devm_request_any_context_irq(&pdev->dev, ret,
+				lt3651_charger_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), lt3651_charger->charger);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to request fault irq\n");
+	}
+	if (lt3651_charger->chrg_gpio) {
+		ret = gpiod_to_irq(lt3651_charger->chrg_gpio);
+		if (ret >= 0)
+			ret = devm_request_any_context_irq(&pdev->dev, ret,
+				lt3651_charger_irq,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				dev_name(&pdev->dev), lt3651_charger->charger);
+		if (ret < 0)
+			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
+	}
+
+	platform_set_drvdata(pdev, lt3651_charger);
+
+	return 0;
+}
+
+static const struct of_device_id lt3651_charger_match[] = {
+	{ .compatible = "lltc,ltc3651-charger" }, /* DEPRECATED */
+	{ .compatible = "lltc,lt3651-charger" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lt3651_charger_match);
+
+static struct platform_driver lt3651_charger_driver = {
+	.probe = lt3651_charger_probe,
+	.driver = {
+		.name = "lt3651-charger",
+		.of_match_table = lt3651_charger_match,
+	},
+};
+
+module_platform_driver(lt3651_charger_driver);
+
+MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
+MODULE_DESCRIPTION("Driver for LT3651 charger");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:lt3651-charger");
diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
deleted file mode 100644
index 8de500f..0000000
--- a/drivers/power/supply/ltc3651-charger.c
+++ /dev/null
@@ -1,207 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
- *  Copyright (C) 2017, Topic Embedded Products
- */
-
-#include <linux/device.h>
-#include <linux/gpio/consumer.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/power_supply.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-
-struct lt3651_charger {
-	struct power_supply *charger;
-	struct power_supply_desc charger_desc;
-	struct gpio_desc *acpr_gpio;
-	struct gpio_desc *fault_gpio;
-	struct gpio_desc *chrg_gpio;
-};
-
-static irqreturn_t lt3651_charger_irq(int irq, void *devid)
-{
-	struct power_supply *charger = devid;
-
-	power_supply_changed(charger);
-
-	return IRQ_HANDLED;
-}
-
-static inline struct lt3651_charger *psy_to_lt3651_charger(
-	struct power_supply *psy)
-{
-	return power_supply_get_drvdata(psy);
-}
-
-static int lt3651_charger_get_property(struct power_supply *psy,
-		enum power_supply_property psp, union power_supply_propval *val)
-{
-	struct lt3651_charger *lt3651_charger = psy_to_lt3651_charger(psy);
-
-	switch (psp) {
-	case POWER_SUPPLY_PROP_STATUS:
-		if (!lt3651_charger->chrg_gpio) {
-			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
-			break;
-		}
-		if (gpiod_get_value(lt3651_charger->chrg_gpio))
-			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else
-			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
-		break;
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = gpiod_get_value(lt3651_charger->acpr_gpio);
-		break;
-	case POWER_SUPPLY_PROP_HEALTH:
-		if (!lt3651_charger->fault_gpio) {
-			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
-			break;
-		}
-		if (!gpiod_get_value(lt3651_charger->fault_gpio)) {
-			val->intval = POWER_SUPPLY_HEALTH_GOOD;
-			break;
-		}
-		/*
-		 * If the fault pin is active, the chrg pin explains the type
-		 * of failure.
-		 */
-		if (!lt3651_charger->chrg_gpio) {
-			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
-			break;
-		}
-		val->intval = gpiod_get_value(lt3651_charger->chrg_gpio) ?
-				POWER_SUPPLY_HEALTH_OVERHEAT :
-				POWER_SUPPLY_HEALTH_DEAD;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-static enum power_supply_property lt3651_charger_properties[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_ONLINE,
-	POWER_SUPPLY_PROP_HEALTH,
-};
-
-static int lt3651_charger_probe(struct platform_device *pdev)
-{
-	struct power_supply_config psy_cfg = {};
-	struct lt3651_charger *lt3651_charger;
-	struct power_supply_desc *charger_desc;
-	int ret;
-
-	lt3651_charger = devm_kzalloc(&pdev->dev, sizeof(*lt3651_charger),
-					GFP_KERNEL);
-	if (!lt3651_charger)
-		return -ENOMEM;
-
-	lt3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
-					"lltc,acpr", GPIOD_IN);
-	if (IS_ERR(lt3651_charger->acpr_gpio)) {
-		ret = PTR_ERR(lt3651_charger->acpr_gpio);
-		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
-		return ret;
-	}
-	lt3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
-					"lltc,fault", GPIOD_IN);
-	if (IS_ERR(lt3651_charger->fault_gpio)) {
-		ret = PTR_ERR(lt3651_charger->fault_gpio);
-		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
-		return ret;
-	}
-	lt3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
-					"lltc,chrg", GPIOD_IN);
-	if (IS_ERR(lt3651_charger->chrg_gpio)) {
-		ret = PTR_ERR(lt3651_charger->chrg_gpio);
-		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
-		return ret;
-	}
-
-	charger_desc = &lt3651_charger->charger_desc;
-	charger_desc->name = pdev->dev.of_node->name;
-	charger_desc->type = POWER_SUPPLY_TYPE_MAINS;
-	charger_desc->properties = lt3651_charger_properties;
-	charger_desc->num_properties = ARRAY_SIZE(lt3651_charger_properties);
-	charger_desc->get_property = lt3651_charger_get_property;
-	psy_cfg.of_node = pdev->dev.of_node;
-	psy_cfg.drv_data = lt3651_charger;
-
-	lt3651_charger->charger = devm_power_supply_register(&pdev->dev,
-						      charger_desc, &psy_cfg);
-	if (IS_ERR(lt3651_charger->charger)) {
-		ret = PTR_ERR(lt3651_charger->charger);
-		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
-			ret);
-		return ret;
-	}
-
-	/*
-	 * Acquire IRQs for the GPIO pins if possible. If the system does not
-	 * support IRQs on these pins, userspace will have to poll the sysfs
-	 * files manually.
-	 */
-	if (lt3651_charger->acpr_gpio) {
-		ret = gpiod_to_irq(lt3651_charger->acpr_gpio);
-		if (ret >= 0)
-			ret = devm_request_any_context_irq(&pdev->dev, ret,
-				lt3651_charger_irq,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), lt3651_charger->charger);
-		if (ret < 0)
-			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
-	}
-	if (lt3651_charger->fault_gpio) {
-		ret = gpiod_to_irq(lt3651_charger->fault_gpio);
-		if (ret >= 0)
-			ret = devm_request_any_context_irq(&pdev->dev, ret,
-				lt3651_charger_irq,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), lt3651_charger->charger);
-		if (ret < 0)
-			dev_warn(&pdev->dev, "Failed to request fault irq\n");
-	}
-	if (lt3651_charger->chrg_gpio) {
-		ret = gpiod_to_irq(lt3651_charger->chrg_gpio);
-		if (ret >= 0)
-			ret = devm_request_any_context_irq(&pdev->dev, ret,
-				lt3651_charger_irq,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), lt3651_charger->charger);
-		if (ret < 0)
-			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
-	}
-
-	platform_set_drvdata(pdev, lt3651_charger);
-
-	return 0;
-}
-
-static const struct of_device_id lt3651_charger_match[] = {
-	{ .compatible = "lltc,ltc3651-charger" }, /* DEPRECATED */
-	{ .compatible = "lltc,lt3651-charger" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, lt3651_charger_match);
-
-static struct platform_driver lt3651_charger_driver = {
-	.probe = lt3651_charger_probe,
-	.driver = {
-		.name = "lt3651-charger",
-		.of_match_table = lt3651_charger_match,
-	},
-};
-
-module_platform_driver(lt3651_charger_driver);
-
-MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
-MODULE_DESCRIPTION("Driver for LT3651 charger");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:lt3651-charger");
-- 
2.7.4


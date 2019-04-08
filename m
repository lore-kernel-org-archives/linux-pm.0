Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD778C10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E52148D
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="ijfpftcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDHLMu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:12:50 -0400
Received: from mail-eopbgr800048.outbound.protection.outlook.com ([40.107.80.48]:3851
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfDHLMt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Apr 2019 07:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8+Z+ZfExsxMa0lDcKw14iNWgiEpus0lzAKYYHyyhcA=;
 b=ijfpftcL1KGTYqh1su0+4ifPkiuirp2XRXgOy7X/gReSHACcPeX74LesSQZ6fJs80ewJf4Nokz+K22SijZ70GK+jUS3/0Fyajm+5EaxCXaXJzpcd007WotMfTJYbWgPYre79Z7yNGcf5esRP7Fff/eTckjGFCOVd72dxEH9h/Vo=
Received: from BN6PR03CA0022.namprd03.prod.outlook.com (2603:10b6:404:23::32)
 by BL2PR03MB546.namprd03.prod.outlook.com (2a01:111:e400:c24::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.19; Mon, 8 Apr
 2019 11:12:45 +0000
Received: from CY1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN6PR03CA0022.outlook.office365.com
 (2603:10b6:404:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Mon, 8 Apr 2019 11:12:45 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT042.mail.protection.outlook.com (10.152.75.136) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Mon, 8 Apr 2019 11:12:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x38BCisk022738
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 8 Apr 2019 04:12:44 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 07:12:44 -0400
Received: from localhost.localdomain ([10.44.3.40])     by zeus.spd.analog.com
 (8.15.1/8.15.1) with ESMTP id x38BCgQT024818;  Mon, 8 Apr 2019 07:12:42 -0400
From:   <michael.hennerich@analog.com>
To:     <mike.looijmans@topic.nl>, <sre@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robin.getz@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH v2 1/2] power: supply: ltc3651-charger: Fix device name
Date:   Mon, 8 Apr 2019 13:17:19 +0200
Message-ID: <1554722240-22183-1-git-send-email-michael.hennerich@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(189003)(199004)(86152003)(48376002)(106002)(72206003)(336012)(478600001)(4326008)(106466001)(49486002)(30864003)(50226002)(107886003)(5660300002)(316002)(16586007)(36756003)(54906003)(110136005)(50466002)(356004)(246002)(6666004)(47776003)(51416003)(2616005)(126002)(2876002)(86362001)(426003)(14444005)(486006)(8936002)(8676002)(26005)(7636002)(186003)(77096007)(2906002)(305945005)(476003)(2004002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB546;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7745f57a-9394-4c4d-468e-08d6bc132088
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:BL2PR03MB546;
X-MS-TrafficTypeDiagnostic: BL2PR03MB546:
X-Microsoft-Antispam-PRVS: <BL2PR03MB5460D3BAD373D47BB7F10428E2C0@BL2PR03MB546.namprd03.prod.outlook.com>
X-Forefront-PRVS: 0001227049
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ShbeqEFWGtmEI75ZCDylj7C4Bh6s2nWRoM8wcyJa6ZgkAo4f2ra6ebjn1bSiLUXjFGnTS13vtCwsQqCn06QYLdinqiGWOWv4FHmOIlwttOuVhOZLfUt5qcVuvfe20Tc7gI5R57uyAUZ58nr1vnzFoCJLSPNIjKBq7karZRwIdmyHFqw4v12Cx0NDjgKnoJ/LVHKFRAqzLV1kJTy/e+8rq72X//3F0tNSJte0m9Zm1jReMhc2cWMmczHAJHagacXXeXeKCuTdH7N1ceoTlI8hN85KV09IU2VXCAaqWtnThrPFUNRON/3t7i+7tfTcDxG6KUaB1ddH15TLgbN7/8lPxFzG827B2/O3uGXRmwmZUxc356+GmJBQ1nrzCDUfP7rZsIp03FeY4L0qhs7rmO55MoV4MpMjMSqr+ufFS5GVw18=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2019 11:12:45.1562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7745f57a-9394-4c4d-468e-08d6bc132088
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB546
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

There never was a device called LTC3651, it always was just LT3651.
This circumstance makes it pretty difficult to identify what this
driver is meant to control.channges since

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

---
Changes in v2:
 - Mark erronous compatible strings as deprecated
 - change patch title
 - rename all occrurances of ltc3651
 - rename kconfig name
 - rename files
---
 .../bindings/power/supply/ltc3651-charger.txt      |  10 +-
 drivers/power/supply/Kconfig                       |   8 +-
 drivers/power/supply/Makefile                      |   2 +-
 drivers/power/supply/ltc3651-charger.c             | 123 ++++++++++-----------
 4 files changed, 71 insertions(+), 72 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
index 71f2840..40811ff 100644
--- a/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
+++ b/Documentation/devicetree/bindings/power/supply/ltc3651-charger.txt
@@ -1,14 +1,16 @@
-ltc3651-charger
+Analog Devices LT3651 Charger Power Supply bindings: lt3651-charger
 
 Required properties:
- - compatible: "lltc,ltc3651-charger"
+- compatible: Should contain one of the following:
+ * "lltc,ltc3651-charger", (DEPRECATED: Use "lltc,lt3651-charger")
+ * "lltc,lt3651-charger"
  - lltc,acpr-gpios: Connect to ACPR output. See remark below.
 
 Optional properties:
  - lltc,fault-gpios: Connect to FAULT output. See remark below.
  - lltc,chrg-gpios: Connect to CHRG output. See remark below.
 
-The ltc3651 outputs are open-drain type and active low. The driver assumes the
+The lt3651 outputs are open-drain type and active low. The driver assumes the
 GPIO reports "active" when the output is asserted, so if the pins have been
 connected directly, the GPIO flags should be set to active low also.
 
@@ -20,7 +22,7 @@ attributes to detect changes.
 Example:
 
 	charger: battery-charger {
-		compatible = "lltc,ltc3651-charger";
+		compatible = "lltc,lt3651-charger";
 		lltc,acpr-gpios = <&gpio0 68 GPIO_ACTIVE_LOW>;
 		lltc,fault-gpios = <&gpio0 64 GPIO_ACTIVE_LOW>;
 		lltc,chrg-gpios = <&gpio0 63 GPIO_ACTIVE_LOW>;
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e901b9879..e907521 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -475,12 +475,12 @@ config CHARGER_MANAGER
           runtime and in suspend-to-RAM by waking up the system periodically
           with help of suspend_again support.
 
-config CHARGER_LTC3651
-	tristate "LTC3651 charger"
+config CHARGER_LT3651
+	tristate "Analog Devices LT3651 charger"
 	depends on GPIOLIB
 	help
-	  Say Y to include support for the LTC3651 battery charger which reports
-	  its status via GPIO lines.
+	  Say Y to include support for the Analog Devices (Linear Technology)
+	  LT3651 battery charger which reports its status via GPIO lines.
 
 config CHARGER_MAX14577
 	tristate "Maxim MAX14577/77836 battery charger driver"
diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
index b731c2a..714c602 100644
--- a/drivers/power/supply/Makefile
+++ b/drivers/power/supply/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_CHARGER_LP8727)	+= lp8727_charger.o
 obj-$(CONFIG_CHARGER_LP8788)	+= lp8788-charger.o
 obj-$(CONFIG_CHARGER_GPIO)	+= gpio-charger.o
 obj-$(CONFIG_CHARGER_MANAGER)	+= charger-manager.o
-obj-$(CONFIG_CHARGER_LTC3651)	+= ltc3651-charger.o
+obj-$(CONFIG_CHARGER_LT3651)	+= ltc3651-charger.o
 obj-$(CONFIG_CHARGER_MAX14577)	+= max14577_charger.o
 obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+= max14656_charger_detector.o
 obj-$(CONFIG_CHARGER_MAX77693)	+= max77693_charger.o
diff --git a/drivers/power/supply/ltc3651-charger.c b/drivers/power/supply/ltc3651-charger.c
index eea63ff..8de500f 100644
--- a/drivers/power/supply/ltc3651-charger.c
+++ b/drivers/power/supply/ltc3651-charger.c
@@ -1,11 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
+ *  Driver for Analog Devices (Linear Technology) LT3651 charger IC.
  *  Copyright (C) 2017, Topic Embedded Products
- *  Driver for LTC3651 charger IC.
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
  */
 
 #include <linux/device.h>
@@ -19,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 
-struct ltc3651_charger {
+struct lt3651_charger {
 	struct power_supply *charger;
 	struct power_supply_desc charger_desc;
 	struct gpio_desc *acpr_gpio;
@@ -27,7 +23,7 @@ struct ltc3651_charger {
 	struct gpio_desc *chrg_gpio;
 };
 
-static irqreturn_t ltc3651_charger_irq(int irq, void *devid)
+static irqreturn_t lt3651_charger_irq(int irq, void *devid)
 {
 	struct power_supply *charger = devid;
 
@@ -36,37 +32,37 @@ static irqreturn_t ltc3651_charger_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-static inline struct ltc3651_charger *psy_to_ltc3651_charger(
+static inline struct lt3651_charger *psy_to_lt3651_charger(
 	struct power_supply *psy)
 {
 	return power_supply_get_drvdata(psy);
 }
 
-static int ltc3651_charger_get_property(struct power_supply *psy,
+static int lt3651_charger_get_property(struct power_supply *psy,
 		enum power_supply_property psp, union power_supply_propval *val)
 {
-	struct ltc3651_charger *ltc3651_charger = psy_to_ltc3651_charger(psy);
+	struct lt3651_charger *lt3651_charger = psy_to_lt3651_charger(psy);
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (!ltc3651_charger->chrg_gpio) {
+		if (!lt3651_charger->chrg_gpio) {
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 			break;
 		}
-		if (gpiod_get_value(ltc3651_charger->chrg_gpio))
+		if (gpiod_get_value(lt3651_charger->chrg_gpio))
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = gpiod_get_value(ltc3651_charger->acpr_gpio);
+		val->intval = gpiod_get_value(lt3651_charger->acpr_gpio);
 		break;
 	case POWER_SUPPLY_PROP_HEALTH:
-		if (!ltc3651_charger->fault_gpio) {
+		if (!lt3651_charger->fault_gpio) {
 			val->intval = POWER_SUPPLY_HEALTH_UNKNOWN;
 			break;
 		}
-		if (!gpiod_get_value(ltc3651_charger->fault_gpio)) {
+		if (!gpiod_get_value(lt3651_charger->fault_gpio)) {
 			val->intval = POWER_SUPPLY_HEALTH_GOOD;
 			break;
 		}
@@ -74,11 +70,11 @@ static int ltc3651_charger_get_property(struct power_supply *psy,
 		 * If the fault pin is active, the chrg pin explains the type
 		 * of failure.
 		 */
-		if (!ltc3651_charger->chrg_gpio) {
+		if (!lt3651_charger->chrg_gpio) {
 			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
 			break;
 		}
-		val->intval = gpiod_get_value(ltc3651_charger->chrg_gpio) ?
+		val->intval = gpiod_get_value(lt3651_charger->chrg_gpio) ?
 				POWER_SUPPLY_HEALTH_OVERHEAT :
 				POWER_SUPPLY_HEALTH_DEAD;
 		break;
@@ -89,59 +85,59 @@ static int ltc3651_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
-static enum power_supply_property ltc3651_charger_properties[] = {
+static enum power_supply_property lt3651_charger_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
 };
 
-static int ltc3651_charger_probe(struct platform_device *pdev)
+static int lt3651_charger_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
-	struct ltc3651_charger *ltc3651_charger;
+	struct lt3651_charger *lt3651_charger;
 	struct power_supply_desc *charger_desc;
 	int ret;
 
-	ltc3651_charger = devm_kzalloc(&pdev->dev, sizeof(*ltc3651_charger),
+	lt3651_charger = devm_kzalloc(&pdev->dev, sizeof(*lt3651_charger),
 					GFP_KERNEL);
-	if (!ltc3651_charger)
+	if (!lt3651_charger)
 		return -ENOMEM;
 
-	ltc3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
+	lt3651_charger->acpr_gpio = devm_gpiod_get(&pdev->dev,
 					"lltc,acpr", GPIOD_IN);
-	if (IS_ERR(ltc3651_charger->acpr_gpio)) {
-		ret = PTR_ERR(ltc3651_charger->acpr_gpio);
+	if (IS_ERR(lt3651_charger->acpr_gpio)) {
+		ret = PTR_ERR(lt3651_charger->acpr_gpio);
 		dev_err(&pdev->dev, "Failed to acquire acpr GPIO: %d\n", ret);
 		return ret;
 	}
-	ltc3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
+	lt3651_charger->fault_gpio = devm_gpiod_get_optional(&pdev->dev,
 					"lltc,fault", GPIOD_IN);
-	if (IS_ERR(ltc3651_charger->fault_gpio)) {
-		ret = PTR_ERR(ltc3651_charger->fault_gpio);
+	if (IS_ERR(lt3651_charger->fault_gpio)) {
+		ret = PTR_ERR(lt3651_charger->fault_gpio);
 		dev_err(&pdev->dev, "Failed to acquire fault GPIO: %d\n", ret);
 		return ret;
 	}
-	ltc3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
+	lt3651_charger->chrg_gpio = devm_gpiod_get_optional(&pdev->dev,
 					"lltc,chrg", GPIOD_IN);
-	if (IS_ERR(ltc3651_charger->chrg_gpio)) {
-		ret = PTR_ERR(ltc3651_charger->chrg_gpio);
+	if (IS_ERR(lt3651_charger->chrg_gpio)) {
+		ret = PTR_ERR(lt3651_charger->chrg_gpio);
 		dev_err(&pdev->dev, "Failed to acquire chrg GPIO: %d\n", ret);
 		return ret;
 	}
 
-	charger_desc = &ltc3651_charger->charger_desc;
+	charger_desc = &lt3651_charger->charger_desc;
 	charger_desc->name = pdev->dev.of_node->name;
 	charger_desc->type = POWER_SUPPLY_TYPE_MAINS;
-	charger_desc->properties = ltc3651_charger_properties;
-	charger_desc->num_properties = ARRAY_SIZE(ltc3651_charger_properties);
-	charger_desc->get_property = ltc3651_charger_get_property;
+	charger_desc->properties = lt3651_charger_properties;
+	charger_desc->num_properties = ARRAY_SIZE(lt3651_charger_properties);
+	charger_desc->get_property = lt3651_charger_get_property;
 	psy_cfg.of_node = pdev->dev.of_node;
-	psy_cfg.drv_data = ltc3651_charger;
+	psy_cfg.drv_data = lt3651_charger;
 
-	ltc3651_charger->charger = devm_power_supply_register(&pdev->dev,
+	lt3651_charger->charger = devm_power_supply_register(&pdev->dev,
 						      charger_desc, &psy_cfg);
-	if (IS_ERR(ltc3651_charger->charger)) {
-		ret = PTR_ERR(ltc3651_charger->charger);
+	if (IS_ERR(lt3651_charger->charger)) {
+		ret = PTR_ERR(lt3651_charger->charger);
 		dev_err(&pdev->dev, "Failed to register power supply: %d\n",
 			ret);
 		return ret;
@@ -152,59 +148,60 @@ static int ltc3651_charger_probe(struct platform_device *pdev)
 	 * support IRQs on these pins, userspace will have to poll the sysfs
 	 * files manually.
 	 */
-	if (ltc3651_charger->acpr_gpio) {
-		ret = gpiod_to_irq(ltc3651_charger->acpr_gpio);
+	if (lt3651_charger->acpr_gpio) {
+		ret = gpiod_to_irq(lt3651_charger->acpr_gpio);
 		if (ret >= 0)
 			ret = devm_request_any_context_irq(&pdev->dev, ret,
-				ltc3651_charger_irq,
+				lt3651_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), ltc3651_charger->charger);
+				dev_name(&pdev->dev), lt3651_charger->charger);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Failed to request acpr irq\n");
 	}
-	if (ltc3651_charger->fault_gpio) {
-		ret = gpiod_to_irq(ltc3651_charger->fault_gpio);
+	if (lt3651_charger->fault_gpio) {
+		ret = gpiod_to_irq(lt3651_charger->fault_gpio);
 		if (ret >= 0)
 			ret = devm_request_any_context_irq(&pdev->dev, ret,
-				ltc3651_charger_irq,
+				lt3651_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), ltc3651_charger->charger);
+				dev_name(&pdev->dev), lt3651_charger->charger);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Failed to request fault irq\n");
 	}
-	if (ltc3651_charger->chrg_gpio) {
-		ret = gpiod_to_irq(ltc3651_charger->chrg_gpio);
+	if (lt3651_charger->chrg_gpio) {
+		ret = gpiod_to_irq(lt3651_charger->chrg_gpio);
 		if (ret >= 0)
 			ret = devm_request_any_context_irq(&pdev->dev, ret,
-				ltc3651_charger_irq,
+				lt3651_charger_irq,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-				dev_name(&pdev->dev), ltc3651_charger->charger);
+				dev_name(&pdev->dev), lt3651_charger->charger);
 		if (ret < 0)
 			dev_warn(&pdev->dev, "Failed to request chrg irq\n");
 	}
 
-	platform_set_drvdata(pdev, ltc3651_charger);
+	platform_set_drvdata(pdev, lt3651_charger);
 
 	return 0;
 }
 
-static const struct of_device_id ltc3651_charger_match[] = {
-	{ .compatible = "lltc,ltc3651-charger" },
+static const struct of_device_id lt3651_charger_match[] = {
+	{ .compatible = "lltc,ltc3651-charger" }, /* DEPRECATED */
+	{ .compatible = "lltc,lt3651-charger" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, ltc3651_charger_match);
+MODULE_DEVICE_TABLE(of, lt3651_charger_match);
 
-static struct platform_driver ltc3651_charger_driver = {
-	.probe = ltc3651_charger_probe,
+static struct platform_driver lt3651_charger_driver = {
+	.probe = lt3651_charger_probe,
 	.driver = {
-		.name = "ltc3651-charger",
-		.of_match_table = ltc3651_charger_match,
+		.name = "lt3651-charger",
+		.of_match_table = lt3651_charger_match,
 	},
 };
 
-module_platform_driver(ltc3651_charger_driver);
+module_platform_driver(lt3651_charger_driver);
 
 MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
-MODULE_DESCRIPTION("Driver for LTC3651 charger");
+MODULE_DESCRIPTION("Driver for LT3651 charger");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ltc3651-charger");
+MODULE_ALIAS("platform:lt3651-charger");
-- 
2.7.4


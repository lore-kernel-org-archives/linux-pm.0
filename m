Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DFC74A5B
	for <linux-pm@archiver.kernel.org>; Wed,  8 Mar 2023 11:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjCHLXO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCHLXG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Mar 2023 06:23:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173523678;
        Wed,  8 Mar 2023 03:23:04 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-248-211-125.ewe-ip-backbone.de [91.248.211.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57CC66602FFC;
        Wed,  8 Mar 2023 11:23:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678274580;
        bh=P2ft93FWXTemxzQ8C/EHp+Dj03svT31iQWu2KAbnX0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HykMhQRXq7pyOp2K5r4lUDxZ726rxWMK9gw8yXIf2xFFt6cY5dt3V6qneeWF/84Ud
         bR/I85tuCkQffZ8QRSWqxYS6G0AG8iw5XHHTYg6jF7zBUObqQoRqdFJkLYfUwW+Wl1
         +TGCPe1gMa9aMarJol3tHhIICIvkwJsGFueMkhG0BGF40tnLF/7KGBqaIJw3sohal5
         JCKbxJkO5Sns0OqqGxDU42tD0NRvK60rkhd/YtLUzBJuXsLIx9PVu3ErHdPApflQD5
         aksipwBNC7mn/rrvu2kiUeAPkTn5f/6vzDTqvQxph3v8ANGM/mtFQh67HxoCfpDyVd
         qZ/JslmJW00jA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7563F48011D; Wed,  8 Mar 2023 12:22:55 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [RESEND] [PATCHv3 5/7] thermal: rockchip: Support dynamic sized sensor array
Date:   Wed,  8 Mar 2023 12:22:51 +0100
Message-Id: <20230308112253.15659-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308112253.15659-1-sebastian.reichel@collabora.com>
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dynamically allocate the sensors array based on the amount
of platform sensors in preparation for rk3588 support, which
needs 7 sensors.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index bcbdd618daae..1a1435a2836b 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -51,12 +51,6 @@ enum adc_sort_mode {
 
 #include "thermal_hwmon.h"
 
-/*
- * The max sensors is two in rockchip SoCs.
- * Two sensors: CPU and GPU sensor.
- */
-#define SOC_MAX_SENSORS	2
-
 /**
  * struct chip_tsadc_table - hold information about chip-specific differences
  * @id: conversion table
@@ -147,7 +141,7 @@ struct rockchip_thermal_data {
 	struct platform_device *pdev;
 	struct reset_control *reset;
 
-	struct rockchip_thermal_sensor sensors[SOC_MAX_SENSORS];
+	struct rockchip_thermal_sensor *sensors;
 
 	struct clk *clk;
 	struct clk *pclk;
@@ -1366,6 +1360,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (!thermal->chip)
 		return -EINVAL;
 
+	thermal->sensors = devm_kcalloc(&pdev->dev, thermal->chip->chn_num,
+					sizeof(*thermal->sensors), GFP_KERNEL);
+	if (!thermal->sensors)
+		return -ENOMEM;
+
 	thermal->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(thermal->regs))
 		return PTR_ERR(thermal->regs);
-- 
2.39.2


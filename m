Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F233C433C1
	for <linux-pm@archiver.kernel.org>; Sat, 20 Mar 2021 11:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B2861936
	for <linux-pm@archiver.kernel.org>; Sat, 20 Mar 2021 11:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbhCTLYr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhCTLYd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 20 Mar 2021 07:24:33 -0400
X-Greylist: delayed 899 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Mar 2021 03:45:03 PDT
Received: from mxwww.masterlogin.de (mxwww.masterlogin.de [IPv6:2a03:2900:1:1::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE97C0613B2
        for <linux-pm@vger.kernel.org>; Sat, 20 Mar 2021 03:45:03 -0700 (PDT)
Received: from mxout2.routing.net (unknown [192.168.10.82])
        by backup.mxwww.masterlogin.de (Postfix) with ESMTPS id 9ECD02C513;
        Sat, 20 Mar 2021 08:12:19 +0000 (UTC)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout2.routing.net (Postfix) with ESMTP id 1F3185FC87;
        Sat, 20 Mar 2021 08:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1616227633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5rx54XOq4cGnoyPqTNXPmFBrLR2RTFNWgo85VwjcYYA=;
        b=fSq/cy9z1JhQI222WTEyqmkz+WPc4kVwaDBiNLRXQhn97ey2tRbg5VxNT6FiHw8Hzwef5G
        btKEzXN762UAgMAxR3GTxyrk1n8QNU3xReOn/lzlSsZIXC+BmEQzvgdiaTzIW0QyKNLCIi
        DHzgCyNJK0KLFXi9MZ7Ss+R6esX6JrA=
Received: from localhost.localdomain (fttx-pool-217.61.145.178.bambit.de [217.61.145.178])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 2BB0F80269;
        Sat, 20 Mar 2021 08:07:12 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: mediatek: add sensors-support
Date:   Sat, 20 Mar 2021 09:06:46 +0100
Message-Id: <20210320080646.49615-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: d03ccc71-1dc6-4253-aa41-7875f90d3cb0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

add HWMON-support to mediateks thermanl driver to allow lm-sensors
userspace tools read soc temperature

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mtk_thermal.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 149c6d7fd5a0..e22d77d57458 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -23,6 +23,8 @@
 #include <linux/reset.h>
 #include <linux/types.h>
 
+#include "thermal_hwmon.h"
+
 /* AUXADC Registers */
 #define AUXADC_CON1_SET_V	0x008
 #define AUXADC_CON1_CLR_V	0x00c
@@ -983,6 +985,13 @@ static void mtk_thermal_release_periodic_ts(struct mtk_thermal *mt,
 	writel((tmp & (~0x10e)), mt->thermal_base + TEMP_MSRCTL1);
 }
 
+static void mtk_thermal_hwmon_action(void *data)
+{
+	struct thermal_zone_device *zone = data;
+
+	thermal_remove_hwmon_sysfs(zone);
+}
+
 static int mtk_thermal_probe(struct platform_device *pdev)
 {
 	int ret, i, ctrl_id;
@@ -1087,6 +1096,19 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 		goto err_disable_clk_peri_therm;
 	}
 
+#ifdef CONFIG_THERMAL_HWMON
+	tzdev->tzp->no_hwmon = false;
+	ret = thermal_add_hwmon_sysfs(tzdev);
+	if (ret)
+		dev_err(&pdev->dev, "error in thermal_add_hwmon_sysfs");
+
+	ret = devm_add_action(&pdev->dev, mtk_thermal_hwmon_action, tzdev);
+	if (ret) {
+		dev_err(&pdev->dev, "error in devm_add_action");
+		mtk_thermal_hwmon_action(tzdev);
+	}
+#endif
+
 	return 0;
 
 err_disable_clk_peri_therm:
-- 
2.25.1


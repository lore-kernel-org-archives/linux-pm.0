From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2] drivers: qcom: spm: avoid module usage in non-modular SPM driver
Date: Mon,  4 Jan 2016 10:58:28 -0700
Message-ID: <1451930308-8087-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34873 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbcADR6h (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2016 12:58:37 -0500
Received: by mail-pa0-f48.google.com with SMTP id ho8so2223790pac.2
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2016 09:58:37 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: andy.gross@linaro.org, sboyd@codeaurora.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>, Paul Gortmaker <paul.gortmaker@windriver.com>

SPM driver provides cpuidle support on some QC SoC's. The functionality
is non-modular and there is no need for module support. Convert module
platform init to builtin platform driver init. The driver functionality
is not affected by this change.

Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/spm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b04b05a..8ee5192 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -2,6 +2,8 @@
  * Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
  * Copyright (c) 2014,2015, Linaro Ltd.
  *
+ * SAW power controller driver
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
  * only version 2 as published by the Free Software Foundation.
@@ -12,7 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -378,8 +379,5 @@ static struct platform_driver spm_driver = {
 		.of_match_table = spm_match_table,
 	},
 };
-module_platform_driver(spm_driver);
 
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("SAW power controller driver");
-MODULE_ALIAS("platform:saw");
+builtin_platform_driver(spm_driver);
-- 
2.1.4


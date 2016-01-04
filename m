From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] drivers: qcom: spm: avoid module usage in non-modular SPM driver
Date: Mon,  4 Jan 2016 10:15:25 -0700
Message-ID: <1451927725-7257-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34739 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbcADRPp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jan 2016 12:15:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id e65so152098945pfe.1
        for <linux-pm@vger.kernel.org>; Mon, 04 Jan 2016 09:15:45 -0800 (PST)
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
 drivers/soc/qcom/spm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b04b05a..199c085 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -12,7 +12,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -378,8 +377,4 @@ static struct platform_driver spm_driver = {
 		.of_match_table = spm_match_table,
 	},
 };
-module_platform_driver(spm_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("SAW power controller driver");
-MODULE_ALIAS("platform:saw");
+builtin_platform_driver(spm_driver);
-- 
2.1.4


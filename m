From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] thermal: broadcom: ns: specify myself as MODULE_AUTHOR
Date: Mon, 17 Apr 2017 23:02:01 +0200
Message-ID: <20170417210201.15921-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36207 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdDQVCT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 17:02:19 -0400
Received: by mail-lf0-f66.google.com with SMTP id 75so17464842lfs.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2017 14:02:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Jon Mason <jonmason@broadcom.com>, linux-pm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>

From: Rafał Miłecki <rafal@milecki.pl>

Just in case someone uses modinfo to find (blame) me.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/thermal/broadcom/ns-thermal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
index 80ad32c6b2df..322e741a2463 100644
--- a/drivers/thermal/broadcom/ns-thermal.c
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -101,5 +101,6 @@ static struct platform_driver ns_thermal_driver = {
 };
 module_platform_driver(ns_thermal_driver);
 
+MODULE_AUTHOR("Rafał Miłecki <rafal@milecki.pl>");
 MODULE_DESCRIPTION("Northstar thermal driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0

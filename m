From: Daniel Axtens <dja@axtens.net>
Subject: [PATCH] power: reset: zx-reboot: add MODULE_LICENSE
Date: Sat,  2 Dec 2017 18:13:38 +1100
Message-ID: <20171202071338.17975-1-dja@axtens.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41617 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbdLBHOA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Dec 2017 02:14:00 -0500
Received: by mail-pl0-f67.google.com with SMTP id g2so7546636pli.8
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2017 23:14:00 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org
Cc: trivial@kernel.org, Daniel Axtens <dja@axtens.net>

This fixes the following warning when building allmodconfig:
WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o

The license matches the one at the top of the file.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/power/reset/zx-reboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index 7549c7f74a3c..19d0096a4846 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -82,3 +82,5 @@ static struct platform_driver zx_reboot_driver = {
 	},
 };
 module_platform_driver(zx_reboot_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH] power/reset: zx: Remove unnecessary include file
Date: Mon, 27 Jul 2015 14:59:06 +0800
Message-ID: <1437980346-1966-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34729 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG0G7X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 02:59:23 -0400
Received: by pdbbh15 with SMTP id bh15so46930280pdb.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2015 23:59:22 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, sfr@canb.auug.org.au
Cc: linux-pm@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Including ARM related header file cause build failure
in i386 build because COMILE_TEST also involve building
zx driver. Remove the unnecessary include file.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/power/reset/zx-reboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/reset/zx-reboot.c b/drivers/power/reset/zx-reboot.c
index e930a44..20703ff 100644
--- a/drivers/power/reset/zx-reboot.c
+++ b/drivers/power/reset/zx-reboot.c
@@ -18,8 +18,6 @@
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 
-#include <asm/proc-fns.h>
-
 static void __iomem *base;
 static void __iomem *pcu_base;
 
-- 
1.9.1


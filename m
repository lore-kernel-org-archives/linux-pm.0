From: Allen Wild <allenwild93@gmail.com>
Subject: [PATCH 1/2] thermal: enable broadcom menu for arm64 bcm2835
Date: Wed, 30 Aug 2017 23:43:05 -0400
Message-ID: <20170831034306.13413-1-allenwild93@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34254 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdHaDne (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2017 23:43:34 -0400
Received: by mail-oi0-f68.google.com with SMTP id w10so7241139oie.1
        for <linux-pm@vger.kernel.org>; Wed, 30 Aug 2017 20:43:34 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Allen Wild <allenwild93@gmail.com>

The bcm2835 thermal driver works for arm64 (Raspberry Pi 3), but the
Broadcom thermal Kconfig menu depends on the 32-bit ARCH_BCM config so the
driver can't be enabled.

Fix this by enabling the Broadcom thermal menu for ARCH_BCM2835 or ARCH_BCM

Signed-off-by: Allen Wild <allenwild93@gmail.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index b5b5facb8747..962620925878 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -408,7 +408,7 @@ config MTK_THERMAL
 	  controller present in Mediatek SoCs
 
 menu "Broadcom thermal drivers"
-depends on ARCH_BCM || COMPILE_TEST
+depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
 source "drivers/thermal/broadcom/Kconfig"
 endmenu
 
-- 
2.14.1

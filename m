From: Allen Wild <allenwild93@gmail.com>
Subject: [PATCH v2] thermal: enable broadcom menu for arm64 bcm2835
Date: Fri,  1 Sep 2017 23:36:39 -0400
Message-ID: <20170902033639.26774-1-allenwild93@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37360 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbdIBDgu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Sep 2017 23:36:50 -0400
Received: by mail-oi0-f66.google.com with SMTP id b184so1538842oih.4
        for <linux-pm@vger.kernel.org>; Fri, 01 Sep 2017 20:36:50 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Allen Wild <allenwild93@gmail.com>, linux-rpi-kernel@lists.infradead.org

Moving the bcm2835 thermal driver to the broadcom directory prevented it
from getting enabled for arm64 builds, since the broadcom directory is only
available when 32-bit specific ARCH_BCM is set.

Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.

Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
Cc: linux-rpi-kernel@lists.infradead.org
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

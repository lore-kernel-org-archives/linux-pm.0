From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH] thermal: enable broadcom menu for arm64 bcm2835
Date: Tue, 26 Sep 2017 19:37:44 +0200
Message-ID: <1506447464-3234-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Allen Wild <allenwild93@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-pm@vger.kernel.org

From: Allen Wild <allenwild93@gmail.com>

Moving the bcm2835 thermal driver to the broadcom directory prevented it
from getting enabled for arm64 builds, since the broadcom directory is only
available when 32-bit specific ARCH_BCM is set.

Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.

Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
Signed-off-by: Allen Wild <allenwild93@gmail.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 07002df..e3f0d1f 100644
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
2.7.4

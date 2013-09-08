From: Regid Ichira <regid23@nt1.in>
Subject: [PATCH] typo in drivers/thermal/Kconfig: lpatform instead of platform
Date: Mon, 9 Sep 2013 00:58:53 +0300
Message-ID: <20130908215853.GD8821@nt1.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.nt1.in ([62.90.139.210]:41433 "EHLO mail.nt1.in"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab3IHWml (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 8 Sep 2013 18:42:41 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Applied to the HEAD of linux.git,
                       VERSION = 3 PATCHLEVEL = 11 SUBLEVEL = 0
Signed-off-by: Regid Ichira <regid23@nt1.in>
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e988c81..3f99f79 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -47,7 +47,7 @@ config THERMAL_DEFAULT_GOV_USER_SPACE
 	select THERMAL_GOV_USER_SPACE
 	help
 	  Select this if you want to let the user space manage the
-	  lpatform thermals.
+	  platform thermals.
 
 endchoice
 
-- 
1.8.4.rc3

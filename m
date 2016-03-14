From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] PM / devfreq: Spelling s/frequnecy/frequency/
Date: Mon, 14 Mar 2016 16:29:02 +0100
Message-ID: <1457969342-23672-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from baptiste.telenet-ops.be ([195.130.132.51]:58475 "EHLO
	baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965289AbcCNP3E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 11:29:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jiri Kosina <trivial@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/devfreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 64281bb2f6503c5a..4de78c552251a5a5 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -61,7 +61,7 @@ config DEVFREQ_GOV_USERSPACE
 	  Sets the frequency at the user specified one.
 	  This governor returns the user configured frequency if there
 	  has been an input to /sys/devices/.../power/devfreq_set_freq.
-	  Otherwise, the governor does not change the frequnecy
+	  Otherwise, the governor does not change the frequency
 	  given at the initialization.
 
 comment "DEVFREQ Drivers"
-- 
1.9.1


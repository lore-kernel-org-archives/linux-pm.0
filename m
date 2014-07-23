From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle: Remove manual selection of the multiple driver support
Date: Wed, 23 Jul 2014 19:02:47 +0200
Message-ID: <1406134968-6483-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51782 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756793AbaGWRCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 13:02:49 -0400
Received: by mail-wg0-f52.google.com with SMTP id a1so1441037wgh.23
        for <linux-pm@vger.kernel.org>; Wed, 23 Jul 2014 10:02:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Like the coupled idle state, it is not up to the user to set this option
but the driver to select it.

Remove the interactive selection of this option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/Kconfig |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 1b96fb9..32748c3 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -15,12 +15,7 @@ config CPU_IDLE
 if CPU_IDLE
 
 config CPU_IDLE_MULTIPLE_DRIVERS
-        bool "Support multiple cpuidle drivers"
-        default n
-        help
-         Allows the cpuidle framework to use different drivers for each CPU.
-         This is useful if you have a system with different CPU latencies and
-         states. If unsure say N.
+        bool
 
 config CPU_IDLE_GOV_LADDER
 	bool "Ladder governor (for periodic timer tick)"
-- 
1.7.9.5


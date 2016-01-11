From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 2/3] cpuidle: Default to ladder governor on ticking systems
Date: Mon, 11 Jan 2016 17:41:53 +0100
Message-ID: <20160111174153.3918f419@endymion.delvare>
References: <20160111173915.63ec1bcd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50088 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761187AbcAKQmA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 11:42:00 -0500
In-Reply-To: <20160111173915.63ec1bcd@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

The menu governor is currently the default on all systems. However the
documentation claims that the ladder governor is preferred on ticking
systems. So bump the rating of the ladder governor when NO_HZ is
disabled, or when booting with nohz=off.

This fixes the first half of bug #65531:
https://bugzilla.kernel.org/show_bug.cgi?id=65531

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpuidle/governors/ladder.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-4.4.orig/drivers/cpuidle/governors/ladder.c	2016-01-11 16:14:57.962027330 +0100
+++ linux-4.4/drivers/cpuidle/governors/ladder.c	2016-01-11 16:15:57.217301178 +0100
@@ -17,6 +17,7 @@
 #include <linux/pm_qos.h>
 #include <linux/module.h>
 #include <linux/jiffies.h>
+#include <linux/tick.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -184,6 +185,14 @@ static struct cpuidle_governor ladder_go
  */
 static int __init init_ladder(void)
 {
+	/*
+	 * When NO_HZ is disabled, or when booting with nohz=off, the ladder
+	 * governor is better so give it a higher rating than the menu
+	 * governor.
+	 */
+	if (!tick_nohz_enabled)
+		ladder_governor.rating = 25;
+
 	return cpuidle_register_governor(&ladder_governor);
 }
 

-- 
Jean Delvare
SUSE L3 Support

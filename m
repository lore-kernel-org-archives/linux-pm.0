From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 3/3] cpuidle: Don't enable all governors by default
Date: Mon, 11 Jan 2016 17:43:02 +0100
Message-ID: <20160111174302.34294818@endymion.delvare>
References: <20160111173915.63ec1bcd@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50217 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761258AbcAKQnI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Jan 2016 11:43:08 -0500
In-Reply-To: <20160111173915.63ec1bcd@endymion.delvare>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Since commit d6f346f2d2 ("cpuidle: improve governor Kconfig options")
the best cpuidle governor is selected automatically. There is little
point in additionally selecting the other as it will not be used. So
don't make it the default.

Being able to select more than one governor is still good for
developers booting with cpuidle_sysfs_switch.

This fixes the second half of bug #65531:
https://bugzilla.kernel.org/show_bug.cgi?id=65531

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpuidle/Kconfig |    2 --
 1 file changed, 2 deletions(-)

--- linux-4.4.orig/drivers/cpuidle/Kconfig	2016-01-11 00:01:32.000000000 +0100
+++ linux-4.4/drivers/cpuidle/Kconfig	2016-01-11 17:06:44.294720023 +0100
@@ -19,11 +19,9 @@ config CPU_IDLE_MULTIPLE_DRIVERS
 
 config CPU_IDLE_GOV_LADDER
 	bool "Ladder governor (for periodic timer tick)"
-	default y
 
 config CPU_IDLE_GOV_MENU
 	bool "Menu governor (for tickless system)"
-	default y
 
 config DT_IDLE_STATES
 	bool

-- 
Jean Delvare
SUSE L3 Support

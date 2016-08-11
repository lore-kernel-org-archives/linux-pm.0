From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/2][RFC] PM / sleep: Make DPM watchdog depend on PM_SLEEP
Date: Thu, 11 Aug 2016 20:29:38 +0800
Message-ID: <5134abc1ff41c139f46b6ff9c77092bd1f0095b1.1470908324.git.yu.c.chen@intel.com>
References: <cover.1470908324.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:62740 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbcHKMVs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Aug 2016 08:21:48 -0400
In-Reply-To: <cover.1470908324.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM List <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Takashi Iwai <tiwai@suse.de>, Benoit Goby <benoit@android.com>, Chen Yu <yu.c.chen@intel.com>

The DPM watchdog is implemented only when PM_SLEEP is
set, so make it depending on the latter.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/power/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 68d3ebc..a359bc5 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -186,7 +186,7 @@ config PM_SLEEP_DEBUG
 
 config DPM_WATCHDOG
 	bool "Device suspend/resume watchdog"
-	depends on PM_DEBUG && PSTORE
+	depends on PM_DEBUG && PSTORE && PM_SLEEP
 	---help---
 	  Sets up a watchdog timer to capture drivers that are
 	  locked up attempting to suspend/resume a device.
-- 
2.7.4


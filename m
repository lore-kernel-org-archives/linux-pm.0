From: Jin Qian <jinqian@android.com>
Subject: [PATCHv3 1/3] power: validate wakeup source before activating it.
Date: Fri, 15 May 2015 18:08:49 -0700
Message-ID: <1431738529-38087-1-git-send-email-jinqian@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:34753 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934479AbbEPBJZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 21:09:25 -0400
Received: by ieczm2 with SMTP id zm2so62909173iec.1
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2015 18:09:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jin Qian <jinqian@android.com>

A rogue wakeup source not registered in wakeup_sources list is not visible
from wakeup_sources_stats_show. Check if the wakeup source is registered
properly by looking at the timer struct.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 drivers/base/power/wakeup.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7726200..457c04f 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -351,6 +351,20 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
 
+/**
+ * wakeup_source_not_registered - validate the given wakeup source.
+ * @ws: Wakeup source to be validated.
+ */
+static bool wakeup_source_not_registered(struct wakeup_source *ws)
+{
+	/*
+	 * Use timer struct to check if the given source is initialized
+	 * by wakeup_source_add.
+	 */
+	return ws->timer.function != pm_wakeup_timer_fn ||
+		   ws->timer.data != (unsigned long)ws;
+}
+
 /*
  * The functions below use the observation that each wakeup event starts a
  * period in which the system should not be suspended.  The moment this period
@@ -391,6 +405,10 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 {
 	unsigned int cec;
 
+	if (WARN(wakeup_source_not_registered(ws),
+			"unregistered wakeup source\n"))
+		return;
+
 	/*
 	 * active wakeup source should bring the system
 	 * out of PM_SUSPEND_FREEZE state
-- 
2.2.0.rc0.207.ga3a616c


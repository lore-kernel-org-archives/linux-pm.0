From: Jin Qian <jinqian@android.com>
Subject: [PATCH 1/3] power: validate wakeup source before activating it.
Date: Wed, 22 Apr 2015 17:50:10 -0700
Message-ID: <1429750212-28659-2-git-send-email-jinqian@android.com>
References: <1429750212-28659-1-git-send-email-jinqian@android.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33612 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119AbbDWAun (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 20:50:43 -0400
Received: by iecrt8 with SMTP id rt8so50373525iec.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 17:50:42 -0700 (PDT)
In-Reply-To: <1429750212-28659-1-git-send-email-jinqian@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jin Qian <jinqian@android.com>

A rogue wakeup source not registered in wakeup_sources list is not visible
from wakeup_sources_stats_show. Check if the wakeup source is registered
properly by looking at the timer function.

Signed-off-by: Jin Qian <jinqian@android.com>
---
 drivers/base/power/wakeup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7726200..f24c622 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -14,6 +14,7 @@
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
 #include <linux/debugfs.h>
+#include <linux/types.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -351,6 +352,19 @@ int device_set_wakeup_enable(struct device *dev, bool enable)
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
 
+/**
+ * validate_wakeup_source - validate the given wakeup source.
+ * @ws: Wakeup source to be validated.
+ */
+static bool validate_wakeup_source(struct wakeup_source *ws)
+{
+	/*
+	 * Use timer function to check if the given source is initialized
+	 * by wakeup_source_add.
+	 */
+	return ws->timer.function == pm_wakeup_timer_fn;
+}
+
 /*
  * The functions below use the observation that each wakeup event starts a
  * period in which the system should not be suspended.  The moment this period
@@ -391,6 +405,11 @@ static void wakeup_source_activate(struct wakeup_source *ws)
 {
 	unsigned int cec;
 
+	if (!validate_wakeup_source(ws)) {
+		pr_err("unregistered wakeup source: %s\n", ws->name);
+		return;
+	}
+
 	/*
 	 * active wakeup source should bring the system
 	 * out of PM_SUSPEND_FREEZE state
-- 
2.2.0.rc0.207.ga3a616c


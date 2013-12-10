From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2 1/3] PM / Runtime: Add second macro for definition of runtime PM callbacks
Date: Tue, 10 Dec 2013 14:37:40 +0100
Message-ID: <1386682662-17633-2-git-send-email-ulf.hansson@linaro.org>
References: <1386682662-17633-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:41737 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3LJNiE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2013 08:38:04 -0500
Received: by mail-la0-f48.google.com with SMTP id n7so2655652lam.21
        for <linux-pm@vger.kernel.org>; Tue, 10 Dec 2013 05:38:03 -0800 (PST)
In-Reply-To: <1386682662-17633-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

By having the runtime PM callbacks implemented for CONFIG_PM, these
becomes available in all combinations of CONFIG_PM_SLEEP and
CONFIG_PM_RUNTIME.

The benefit using this, is that we don't need to implement the wrapper
functions which handles runtime PM resourses, typically called from
both runtime PM and system PM callbacks. Instead the runtime PM
callbacks can be invoked directly from system PM callbacks, which is
useful for some drivers, subsystems and power domains.

Use the new macro SET_PM_RUNTIME_PM_OPS in cases were the above makes
sense. Make sure the callbacks are encapsulated within CONFIG_PM
instead of CONFIG_PM_RUNTIME.

Do note that the old macro SET_RUNTIME_PM_OPS, which is being quite
widely used right now, requires the callbacks to be defined for
CONFIG_PM_RUNTIME. In many cases it will certainly be convenient to
convert to the new macro above, but that will have to be distinguished
in case by case.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index a224c7f..7a830a7 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -320,6 +320,15 @@ struct dev_pm_ops {
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
 #endif
 
+#ifdef CONFIG_PM
+#define SET_PM_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
+	.runtime_suspend = suspend_fn, \
+	.runtime_resume = resume_fn, \
+	.runtime_idle = idle_fn,
+#else
+#define SET_PM_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
+#endif
+
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
  * to RAM and hibernation.
-- 
1.7.9.5


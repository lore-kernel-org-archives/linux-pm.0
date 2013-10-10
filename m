From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: core: Use autosuspend when applicable at runtime idle
Date: Thu, 10 Oct 2013 12:01:47 +0200
Message-ID: <1381399307-21534-3-git-send-email-ulf.hansson@linaro.org>
References: <1381399307-21534-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:33992 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299Ab3JJKCU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Oct 2013 06:02:20 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz10so874177bkb.31
        for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2013 03:02:19 -0700 (PDT)
In-Reply-To: <1381399307-21534-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, " Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Typically the runtime idle function is triggered after resume and
probe. Instead of immediately requesting the device to go into
in-active state we make use of the autosuspend, if we have enabled
it earlier.

Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index cdca8a7..7f0e900 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -205,6 +205,12 @@ static int mmc_runtime_resume(struct device *dev)
 
 static int mmc_runtime_idle(struct device *dev)
 {
+	if (pm_runtime_autosuspend_used(dev)) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_autosuspend(dev);
+		return -EBUSY;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5


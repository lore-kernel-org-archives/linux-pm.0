From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Runtime: Fix error path for prepare
Date: Wed, 13 Nov 2013 15:45:03 +0100
Message-ID: <1384353903-29661-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:47158 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759259Ab3KMOpO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2013 09:45:14 -0500
Received: by mail-wg0-f45.google.com with SMTP id a1so513085wgh.0
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2013 06:45:12 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

If a device prepare callback for some reason would fail, the PM core
prevented the device from going inactive forever.

In this case, to reverse the pm_runtime_get_noresume() we invokes the
asyncronous pm_runtime_put(), thus restoring the usage count.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/main.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index ee039af..2a1b06a 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1350,6 +1350,9 @@ static int device_prepare(struct device *dev, pm_message_t state)
 
 	device_unlock(dev);
 
+	if (error)
+		pm_runtime_put(dev);
+
 	return error;
 }
 
-- 
1.7.9.5


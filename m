From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Tue, 17 May 2016 13:41:36 +0200
Message-ID: <1463485296-22742-5-git-send-email-ulf.hansson@linaro.org>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33010 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbcEQLlx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 07:41:53 -0400
Received: by mail-lf0-f54.google.com with SMTP id y84so5585402lfc.0
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2016 04:41:53 -0700 (PDT)
In-Reply-To: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

When the pm_runtime_force_suspend|resume() helpers were invented, we still
had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.

To make sure these helpers worked for all combinations and without
introducing too much of complexity, the device was always resumed in
pm_runtime_force_resume().

More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
unset, we needed to resume the device as the subsystem/driver couldn't
rely on using runtime PM to do it.

As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
removed this combination, of using CONFIG_PM_SLEEP without the earlier
CONFIG_PM_RUNTIME.

For this reason we can now rely on the subsystem/driver to use runtime PM
to resume the device, instead of forcing that to be done in all cases. In
other words, let's defer this to a later point when it's actually needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 09e4eb1..1db7b46 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1509,6 +1509,17 @@ int pm_runtime_force_resume(struct device *dev)
 	if (!pm_runtime_status_suspended(dev))
 		goto out;
 
+	/*
+	 * The PM core increases the runtime PM usage count in the system PM
+	 * prepare phase. If the count is greather than 1 at this point, someone
+	 * else has also increased it. In that case, invoke the runtime resume
+	 * callback for the device as that is likely what is expected. In other
+	 * case we trust the subsystem/driver to runtime resume the device when
+	 * it's actually needed.
+	 */
+	if (atomic_read(&dev->power.usage_count) < 2)
+		goto out;
+
 	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto out;
-- 
1.9.1


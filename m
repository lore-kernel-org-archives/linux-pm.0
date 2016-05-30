From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 5/5] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Mon, 30 May 2016 11:33:15 +0200
Message-ID: <1464600795-26307-6-git-send-email-ulf.hansson@linaro.org>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:34651 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbcE3Jdc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 05:33:32 -0400
Received: by mail-lf0-f53.google.com with SMTP id k98so69928199lfi.1
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 02:33:32 -0700 (PDT)
In-Reply-To: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
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
other words, let's defer the runtime resume to a later point when it's
actually needed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated changelog.
	- Updated comment in the code.

---
 drivers/base/power/runtime.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 09e4eb1..81731a2 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1509,6 +1509,17 @@ int pm_runtime_force_resume(struct device *dev)
 	if (!pm_runtime_status_suspended(dev))
 		goto out;
 
+	/*
+	 * The PM core increases the runtime PM usage count in the system PM
+	 * prepare phase. If the count is greater than 1 at this point, a real
+	 * user (such as a subsystem, driver, userspace, etc.) has also
+	 * increased it, indicating that the device was used when system suspend
+	 * was invoked. In this case, the device is expected to be used on
+	 * system resume as well, so invoke the ->runtime_resume() callback.
+	 */
+	if (atomic_read(&dev->power.usage_count) < 2)
+		goto out;
+
 	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto out;
-- 
1.9.1


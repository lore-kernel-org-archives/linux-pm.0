From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/5] PM / Runtime: Prevent re-resuming devices in pm_runtime_force_resume()
Date: Mon, 30 May 2016 11:33:12 +0200
Message-ID: <1464600795-26307-3-git-send-email-ulf.hansson@linaro.org>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36277 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbcE3Jd1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 05:33:27 -0400
Received: by mail-lf0-f42.google.com with SMTP id b73so47339293lfb.3
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 02:33:27 -0700 (PDT)
In-Reply-To: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If the runtime PM status of the device isn't RPM_SUSPENDED, prevent the
pm_runtime_force_resume() to call the ->runtime_resume() callback for the
device, as it's not the expected behaviour from the subsystem/driver.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated changelog.

---
 drivers/base/power/runtime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b746904..09e4eb1 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1506,6 +1506,9 @@ int pm_runtime_force_resume(struct device *dev)
 		goto out;
 	}
 
+	if (!pm_runtime_status_suspended(dev))
+		goto out;
+
 	ret = pm_runtime_set_active(dev);
 	if (ret)
 		goto out;
-- 
1.9.1


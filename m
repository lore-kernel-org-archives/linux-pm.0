From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/5] PM / Domains: Remove redundant call to pm_request_idle() in genpd
Date: Mon, 30 May 2016 11:33:11 +0200
Message-ID: <1464600795-26307-2-git-send-email-ulf.hansson@linaro.org>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34625 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307AbcE3Jd0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 05:33:26 -0400
Received: by mail-lf0-f54.google.com with SMTP id k98so69927103lfi.1
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 02:33:25 -0700 (PDT)
In-Reply-To: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The PM core increases the runtime PM usage count at the system PM prepare
phase. Later when the system resumes, it does a pm_runtime_put() in the
complete phase, which in addition to decrementing the usage count, does
the equivalent of a pm_request_idle().

Therefore the call to pm_request_idle() from within genpd's ->complete()
callback is redundant, so let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated changelog.

---
 drivers/base/power/domain.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 658eb1b..60a9971 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -938,7 +938,6 @@ static void pm_genpd_complete(struct device *dev)
 	pm_generic_complete(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-	pm_request_idle(dev);
 }
 
 /**
-- 
1.9.1


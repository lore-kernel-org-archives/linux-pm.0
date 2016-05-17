From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] PM / Domains: Remove redundant call to pm_request_idle() in genpd
Date: Tue, 17 May 2016 13:41:33 +0200
Message-ID: <1463485296-22742-2-git-send-email-ulf.hansson@linaro.org>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:34338 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcEQLls (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 07:41:48 -0400
Received: by mail-lb0-f171.google.com with SMTP id n11so4858506lbh.1
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2016 04:41:47 -0700 (PDT)
In-Reply-To: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The PM core increases the runtime PM usage count at the system PM prepare
phase. Later when the system has resumed and the ->complete() callback has
been invoked, it drops the usage count. In this way, it intentionally
prevents runtime PM suspend for the device throughout this period.

For this reason, let's remove the call to pm_request_idle() from within
genpd's ->complete() calllback as it's redundant.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
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


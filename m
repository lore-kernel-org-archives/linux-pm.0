From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] PM / Runtime: Clarify comment in rpm_resume() when resuming the parent
Date: Mon, 17 Oct 2016 20:16:59 +0200
Message-ID: <1476728221-26530-3-git-send-email-ulf.hansson@linaro.org>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33363 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755183AbcJQSRP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:17:15 -0400
Received: by mail-lf0-f51.google.com with SMTP id x79so307616673lff.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 11:17:15 -0700 (PDT)
In-Reply-To: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5e4e5ec..f47a345 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -713,8 +713,8 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 		spin_lock(&parent->power.lock);
 		/*
-		 * We can resume if the parent's runtime PM is disabled or it
-		 * is set to ignore children.
+		 * Resume the parent if it has runtime PM enabled and not been
+		 * set to ignore its children.
 		 */
 		if (!parent->power.disable_depth
 		    && !parent->power.ignore_children) {
-- 
1.9.1


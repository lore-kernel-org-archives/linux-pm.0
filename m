From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Runtime: Convert pm_runtime_set_suspended() to return an int
Date: Mon, 17 Oct 2016 20:17:00 +0200
Message-ID: <1476728221-26530-4-git-send-email-ulf.hansson@linaro.org>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34023 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755183AbcJQSRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:17:17 -0400
Received: by mail-lf0-f45.google.com with SMTP id b81so297291758lfe.1
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 11:17:17 -0700 (PDT)
In-Reply-To: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

Because pm_runtime_set_suspended() invokes __pm_runtime_set_status(), which
can fail, pm_runtime_set_suspended() can also fail.

Instead of hiding a potential error, let's propagate it by converting
pm_runtime_set_suspended() from a void to return an int. In this way users
are able to check the error code and act accordingly.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_runtime.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 61ea566..4957fc1 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -258,9 +258,9 @@ static inline int pm_runtime_set_active(struct device *dev)
 	return __pm_runtime_set_status(dev, RPM_ACTIVE);
 }
 
-static inline void pm_runtime_set_suspended(struct device *dev)
+static inline int pm_runtime_set_suspended(struct device *dev)
 {
-	__pm_runtime_set_status(dev, RPM_SUSPENDED);
+	return __pm_runtime_set_status(dev, RPM_SUSPENDED);
 }
 
 static inline void pm_runtime_disable(struct device *dev)
-- 
1.9.1


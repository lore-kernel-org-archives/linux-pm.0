From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/4] PM / Runtime: Don't allow to suspend a device with an active child
Date: Mon, 17 Oct 2016 20:17:01 +0200
Message-ID: <1476728221-26530-5-git-send-email-ulf.hansson@linaro.org>
References: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36044 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756892AbcJQSRU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2016 14:17:20 -0400
Received: by mail-lf0-f41.google.com with SMTP id b75so301180903lfg.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2016 11:17:19 -0700 (PDT)
In-Reply-To: <1476728221-26530-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

When resuming a device in __pm_runtime_set_status(), the prerequisite is
that its parent must already be active, else an error code is returned and
the device's status remains suspended.

When suspending a device there is no similar constraints being validated.
Let's change this to make the behaviour consistent, by not allowing to
suspend a device with an active child, unless it has been explicitly set to
ignore its children.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/runtime.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index f47a345..6f946a3 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1028,7 +1028,17 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		goto out_set;
 
 	if (status == RPM_SUSPENDED) {
-		/* It always is possible to set the status to 'suspended'. */
+		/*
+		 * It is invalid to suspend a device with an active child,
+		 * unless it has been set to ignore its children.
+		 */
+		if (!dev->power.ignore_children &&
+			atomic_read(&dev->power.child_count)) {
+			dev_err(dev, "runtime PM trying to suspend device but active child\n");
+			error = -EBUSY;
+			goto out;
+		}
+
 		if (parent) {
 			atomic_add_unless(&parent->power.child_count, -1, 0);
 			notify_parent = !parent->power.ignore_children;
-- 
1.9.1


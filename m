From: Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] PM / sleep: don't suspend parent when async child suspend_{noirq,early} fails
Date: Wed, 19 Oct 2016 17:26:10 -0700
Message-ID: <1476923170-111986-2-git-send-email-briannorris@chromium.org>
References: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36300 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbcJTA0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 20:26:49 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so24606290pfk.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 17:26:49 -0700 (PDT)
In-Reply-To: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Brian Norris <briannorris@chromium.org>

Consider two devices, A and B, where B is a child of A, and B utilizes
asynchronous suspend (it does not matter whether A is sync or async). If
B fails to suspend_noirq() or suspend_early(), or is interrupted by a
wakeup (pm_wakeup_pending()), then it aborts and sets the async_error
variable. However, device A does not (immediately) check the async_error
variable; it may continue to run its own suspend_noirq()/suspend_early()
callback. This is bad.

We can resolve this problem by checking the async_error flag after
waiting for children to suspend, using the same logic for the noirq and
late suspend cases as we already do for __device_suspend().

It's easy to observe this erroneous behavior by, for example, forcing a
device to sleep a bit in its suspend_noirq() (to ensure the parent is
waiting for the child to complete), then return an error, and watch the
parent suspend_noirq() still get called. (Or similarly, fake a wakeup
event at the right (or is it wrong?) time.)

Fixes: de377b397272 ("PM / sleep: Asynchronous threads for suspend_late")
Fixes: 28b6fd6e3779 ("PM / sleep: Asynchronous threads for suspend_noirq")
Reported-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Tested mostly on 4.4, but the code (and seemingly the bug) is mostly untouched
since then. I can try to conjure up a proper upstream test if required.

 drivers/base/power/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index c58563581345..eaf6b53463a5 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1040,6 +1040,9 @@ static int __device_suspend_noirq(struct device *dev, pm_message_t state, bool a
 
 	dpm_wait_for_children(dev, async);
 
+	if (async_error)
+		goto Complete;
+
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
 		callback = pm_noirq_op(&dev->pm_domain->ops, state);
@@ -1187,6 +1190,9 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
 
 	dpm_wait_for_children(dev, async);
 
+	if (async_error)
+		goto Complete;
+
 	if (dev->pm_domain) {
 		info = "late power domain ";
 		callback = pm_late_early_op(&dev->pm_domain->ops, state);
-- 
2.8.0.rc3.226.g39d4020


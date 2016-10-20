From: Brian Norris <briannorris@chromium.org>
Subject: [RESEND PATCH 1/2] PM / sleep: print function name of callbacks
Date: Wed, 19 Oct 2016 17:26:09 -0700
Message-ID: <1476923170-111986-1-git-send-email-briannorris@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <computersforpeace@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-pm@vger.kernel.org, Chuansheng Liu <chuansheng.liu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Brian Norris <briannorris@chromium.org>
List-Id: linux-pm@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

The printouts writen to the logs by suspend can be a bit opaque: it can
be hard to track them down to the actual function called.  You might
see:

  calling  rfkill1+ @ 19473, parent: phy0
  call rfkill1+ returned 0 after 1 usecs
  calling  phy0+ @ 19473, parent: mmc2:0001:1
  call phy0+ returned 0 after 19 usecs

It's a bit hard to know what's actually happening.  Instead, it's nice
to see:

  calling  rfkill1+ @ 15793, parent: phy0, cb: rfkill_suspend
  call rfkill1+ returned 0 after 1 usecs
  calling  phy0+ @ 15793, parent: mmc2:0001:1, cb: wiphy_suspend [cfg80211]
  call phy0+ returned 0 after 7 usecs

That makes it very obvious what's going on.  It also has the nice side
effect of making the suspend/resume spew a little more obvious, since
many resume functions have the word "resume" in the name:

  calling  phy0+ @ 15793, parent: mmc2:0001:1, cb: wiphy_resume [cfg80211]
  call phy0+ returned 0 after 12 usecs
  calling  rfkill1+ @ 15793, parent: phy0, cb: rfkill_resume
  call rfkill1+ returned 0 after 1 usecs

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This is a resend of the following patch (w/ minor $subject alteration):

https://patchwork.kernel.org/patch/7241641/

It was useful for debugging the following patch, so I thought I'd resend. It
received an Ack the first time.

 drivers/base/power/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index e44944f4be77..c58563581345 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -190,14 +190,14 @@ void device_pm_move_last(struct device *dev)
 	list_move_tail(&dev->power.entry, &dpm_list);
 }
 
-static ktime_t initcall_debug_start(struct device *dev)
+static ktime_t initcall_debug_start(struct device *dev, void *cb)
 {
 	ktime_t calltime = ktime_set(0, 0);
 
 	if (pm_print_times_enabled) {
-		pr_info("calling  %s+ @ %i, parent: %s\n",
+		pr_info("calling  %s+ @ %i, parent: %s, cb: %pf\n",
 			dev_name(dev), task_pid_nr(current),
-			dev->parent ? dev_name(dev->parent) : "none");
+			dev->parent ? dev_name(dev->parent) : "none", cb);
 		calltime = ktime_get();
 	}
 
@@ -384,7 +384,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 	if (!cb)
 		return 0;
 
-	calltime = initcall_debug_start(dev);
+	calltime = initcall_debug_start(dev, cb);
 
 	pm_dev_dbg(dev, state, info);
 	trace_device_pm_callback_start(dev, info, state.event);
@@ -1330,7 +1330,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	int error;
 	ktime_t calltime;
 
-	calltime = initcall_debug_start(dev);
+	calltime = initcall_debug_start(dev, cb);
 
 	trace_device_pm_callback_start(dev, info, state.event);
 	error = cb(dev, state);
-- 
2.8.0.rc3.226.g39d4020

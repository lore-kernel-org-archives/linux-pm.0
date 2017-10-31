From: Rajat Jain <rajatja@google.com>
Subject: [PATCH] PM / s2idle: Clear the events_check_enabled flag
Date: Tue, 31 Oct 2017 14:44:24 -0700
Message-ID: <20171031214424.84783-1-rajatja@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dtor@google.com, rajatxjain@gmail.com
Cc: Rajat Jain <rajatja@google.com>
List-Id: linux-pm@vger.kernel.org

Problem: This flag does not get cleared currently in the suspend or
resume path in the following cases:

* In case some driver's suspend routine returns an error.
* Successful s2idle case
* etc?

Why is this a problem: What happens is that the next suspend attempt
could fail even though the user did not enable the flag by writing to
/sys/power/wakeup_count. This is 1 use case how the issue can be seen
(but similar use case with driver suspend failure can be thought of):

1. Read /sys/power/wakeup_count
2. echo count > /sys/power/wakeup_count
3. echo freeze > /sys/power/wakeup_count
4. Let the system suspend, and wakeup the system using some wake source
   that calls pm_wakeup_event() e.g. power button or something.
5. Note that the combined wakeup count would be incremented due
   to the pm_wakeup_event() in the resume path.
6. After resuming the events_check_enabled flag is still set.

At this point if the user attempts to freeze again (without writing to
/sys/power/wakeup_count), the suspend would fail even though there has
been no wake event since the past resume.

What this patch does:

It moves the clearing of the flag to just before a resume is completed,
so that it is always cleared for the corner cases mentioned above.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 kernel/power/suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index ccd2d20e6b06..0685c4499431 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -437,7 +437,6 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 			error = suspend_ops->enter(state);
 			trace_suspend_resume(TPS("machine_suspend"),
 				state, false);
-			events_check_enabled = false;
 		} else if (*wakeup) {
 			error = -EBUSY;
 		}
@@ -582,6 +581,7 @@ static int enter_state(suspend_state_t state)
 	pm_restore_gfp_mask();
 
  Finish:
+	events_check_enabled = false;
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
-- 
2.15.0.403.gc27cc4dac6-goog

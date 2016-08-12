From: Thomas Garnier <thgarnie@google.com>
Subject: [PATCH v2] x86/power/64: Restore processor state before using per-cpu variables
Date: Fri, 12 Aug 2016 10:52:44 -0700
Message-ID: <1471024364-46217-1-git-send-email-thgarnie@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, keescook@chromium.org, kernel-hardening@lists.openwall.com, jikos@kernel.org, bpetkov@suse.de, yinghai@kernel.org, Thomas Garnier <thgarnie@google.com>
List-Id: linux-pm@vger.kernel.org

Restore the processor state before calling any other function to ensure
per-cpu variables can be used with KASLR memory randomization.

Tracing functions use per-cpu variables (gs based) and one was called
just before restoring the processor state fully. It resulted in a double
fault when both the tracing & the exception handler functions tried to
use a per-cpu variable.

Reported-by: Jiri Kosina <jkosina@suse.cz>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reported-and-tested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
Based on next-20160808

Thanks to Rafael, Jiri & Borislav in tracking down this bug and help
testing this fix.
---
 kernel/power/hibernate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a881c6a..33c79b6 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -300,12 +300,12 @@ static int create_image(int platform_mode)
 	save_processor_state();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, true);
 	error = swsusp_arch_suspend();
+	/* Restore control flow magically appears here */
+	restore_processor_state();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, false);
 	if (error)
 		printk(KERN_ERR "PM: Error %d creating hibernation image\n",
 			error);
-	/* Restore control flow magically appears here */
-	restore_processor_state();
 	if (!in_suspend)
 		events_check_enabled = false;
 
-- 
2.8.0.rc3.226.g39d4020

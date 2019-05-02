From: Nikitas Angelinas <nikitas.angelinas@gmail.com>
Subject: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Date: Thu, 2 May 2019 00:43:05 -0700
Message-ID: <20190502074305.GA6039@vostro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: nikitas.angelinas@gmail.com
List-Id: linux-pm@vger.kernel.org

There is no need to keep sysrq_poweroff_op after initialization, so mark
it with __initdata. Mark some of the function parameters with __maybe_unused
to avoid compilation warnings.

Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
---
 kernel/power/poweroff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index 7ef6866..d507152 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -11,26 +11,27 @@
 #include <linux/workqueue.h>
 #include <linux/reboot.h>
 #include <linux/cpumask.h>
+#include <linux/compiler_attributes.h>
 
 /*
  * When the user hits Sys-Rq o to power down the machine this is the
  * callback we use.
  */
 
-static void do_poweroff(struct work_struct *dummy)
+static void do_poweroff(struct work_struct *dummy __maybe_unused)
 {
 	kernel_power_off();
 }
 
 static DECLARE_WORK(poweroff_work, do_poweroff);
 
-static void handle_poweroff(int key)
+static void handle_poweroff(int key __maybe_unused)
 {
 	/* run sysrq poweroff on boot cpu */
 	schedule_work_on(cpumask_first(cpu_online_mask), &poweroff_work);
 }
 
-static struct sysrq_key_op	sysrq_poweroff_op = {
+static struct sysrq_key_op sysrq_poweroff_op __initdata = {
 	.handler        = handle_poweroff,
 	.help_msg       = "poweroff(o)",
 	.action_msg     = "Power Off",
-- 
2.10.0

From: Augusto Mecking Caringi <augustocaringi@gmail.com>
Subject: [PATCH] thermal/intel_powerclamp: Remove set-but-not-used variables
Date: Mon, 30 Jan 2017 10:47:36 +0000
Message-ID: <1485773289-19844-1-git-send-email-augustocaringi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34287 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbdA3Ks2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jan 2017 05:48:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Augusto Mecking Caringi <augustocaringi@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

In poll_pkg_cstate() function, the variables jiffies_last and
jiffies_now are set but never used.

This has been detected by building the driver with W=1:

drivers/thermal/intel_powerclamp.c: In function ‘poll_pkg_cstate’:
drivers/thermal/intel_powerclamp.c:464:23: warning: variable
‘jiffies_last’ set but not used [-Wunused-but-set-variable]
static unsigned long jiffies_last;
                       ^

Signed-off-by: Augusto Mecking Caringi <augustocaringi@gmail.com>
---
 drivers/thermal/intel_powerclamp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
index df64692..a47103a 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -461,16 +461,13 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 {
 	static u64 msr_last;
 	static u64 tsc_last;
-	static unsigned long jiffies_last;
 
 	u64 msr_now;
-	unsigned long jiffies_now;
 	u64 tsc_now;
 	u64 val64;
 
 	msr_now = pkg_state_counter();
 	tsc_now = rdtsc();
-	jiffies_now = jiffies;
 
 	/* calculate pkg cstate vs tsc ratio */
 	if (!msr_last || !tsc_last)
@@ -485,7 +482,6 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 
 	/* update record */
 	msr_last = msr_now;
-	jiffies_last = jiffies_now;
 	tsc_last = tsc_now;
 
 	if (true == clamping)
-- 
2.7.4


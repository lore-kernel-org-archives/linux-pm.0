From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFD PATCH 05/10] cpuidle: Remove unused headers for tick
Date: Wed, 22 Oct 2014 15:57:48 +0200
Message-ID: <1413986273-28522-6-git-send-email-daniel.lezcano@linaro.org>
References: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413986273-28522-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@kernel.dk, rafael.j.wysocki@intel.com, mingo@kernel.org, peterz@infradead.org, preeti@linux.vnet.ibm.com, Morten.Rasmussen@arm.com, mturquette@linaro.org, tuukka.tikkanen@linaro.org, nicolas.pitre@linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

Moving around the different functions dealing with the time made the time
headers no longer necessary in cpuidle.c.

Remove them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 658be9f..1abd5a0 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -8,16 +8,12 @@
  * This code is licenced under the GPL.
  */
 
-#include <linux/clockchips.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
-#include <linux/sched.h>
 #include <linux/notifier.h>
 #include <linux/pm_qos.h>
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
-#include <linux/ktime.h>
-#include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <trace/events/power.h>
 
-- 
1.9.1

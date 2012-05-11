From: Youquan Song <youquan.song@intel.com>
Subject: [PATCH 3/3] x86,idle: Set residency to 0 if target Cstate not really enter
Date: Fri, 11 May 2012 11:15:57 -0400
Message-ID: <1336749357-9133-4-git-send-email-youquan.song@intel.com>
References: <1336749357-9133-1-git-send-email-youquan.song@intel.com>
 <1336749357-9133-2-git-send-email-youquan.song@intel.com>
 <1336749357-9133-3-git-send-email-youquan.song@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1336749357-9133-3-git-send-email-youquan.song@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, len.brown@intel.com, akpm@linux-foundation.org
Cc: arjan@linux.intel.com, len.brown@linux.intel.com, suresh.b.siddha@intel.com, Youquan Song <youquan.song@linux.intel.com>, Youquan Song <youquan.song@intel.com>
List-Id: linux-pm@vger.kernel.org

When cpuidle governor choose a C-state to enter for idle CPU, but it notice that
there is tasks request to be executed. So the idle CPU will not really enter
the target C-state and go to run task.

In this situation, it will use the residency of previous really entered target 
C-states. Obviously, it is not reasonable. 

So, this patch fix it by set the target C-state residency to 0. 

Signed-off-by: Youquan Song <youquan.song@intel.com>
---
 drivers/cpuidle/cpuidle.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 2f0083a..7992417 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -136,6 +136,10 @@ int cpuidle_idle_call(void)
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(drv, dev);
 	if (need_resched()) {
+		dev->last_residency = 0;
+		/* give the governor an opportunity to reflect on the outcome */
+		if (cpuidle_curr_governor->reflect)
+			cpuidle_curr_governor->reflect(dev, next_state);
 		local_irq_enable();
 		return 0;
 	}

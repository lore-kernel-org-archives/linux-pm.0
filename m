From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v8 08/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead of MAX_POWERNV_IDLE_STATES
Date: Fri,  8 Jul 2016 11:50:50 +0530
Message-ID: <1467958853-35841-9-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467958853-35841-1-git-send-email-shreyas@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467958853-35841-1-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use cpuidle's CPUIDLE_STATE_MAX macro instead of powernv specific
MAX_POWERNV_IDLE_STATES.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 - No changes after v5

Changes in v5
=============
 - New in v5

 drivers/cpuidle/cpuidle-powernv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index e12dc30..3a763a8 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -20,8 +20,6 @@
 #include <asm/opal.h>
 #include <asm/runlatch.h>
 
-#define MAX_POWERNV_IDLE_STATES	8
-
 struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
 	.owner            = THIS_MODULE,
@@ -96,7 +94,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state powernv_states[MAX_POWERNV_IDLE_STATES] = {
+static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
-- 
2.4.11

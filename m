From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle:powernv: Add the CPUIDLE_FLAG_POLLING for snooze
Date: Tue,  3 Jul 2018 10:54:16 +0530
Message-ID: <1530595456-32352-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akshay.adiga@linux.vnet.ibm.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

In the situations where snooze is the only cpuidle state due to
firmware not exposing any platform idle states, the idle CPUs will
remain in snooze for a long time with interrupts disabled causing the
Hard-lockup detector to complain.

watchdog: CPU 51 detected hard LOCKUP on other CPUs 59
watchdog: CPU 51 TB:535296107736, last SMP heartbeat TB:527472229239 (15281ms ago)
watchdog: CPU 59 Hard LOCKUP
watchdog: CPU 59 TB:535296252849, last heartbeat TB:526554725466 (17073ms ago)

Fix this by adding CPUIDLE_FLAG_POLLING flag to the state, so that the
cpuidle governor will do the right thing, such as not stopping the
tick if it is going to put the idle cpu to snooze.

Reported-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index d29e4f0..b73041b 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -156,6 +156,7 @@ static int stop_loop(struct cpuidle_device *dev,
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
+		.flags = CPUIDLE_FLAG_POLLING,
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = snooze_loop },
-- 
1.9.4

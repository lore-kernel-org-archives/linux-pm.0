From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/3] cpuidle: powerpc: cpuidle set polling before enabling irqs
Date: Wed, 14 Jun 2017 23:02:39 +1000
Message-ID: <20170614130241.19865-2-npiggin@gmail.com>
References: <20170614130241.19865-1-npiggin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170614130241.19865-1-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

local_irq_enable can cause interrupts to be taken which could
take significant amount of processing time. The idle process
should set its polling flag before this, so another process that
wakes it during this time will not have to send an IPI.

Expand the TIF_POLLING_NRFLAG coverage to as large as possible.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 4 +++-
 drivers/cpuidle/cpuidle-pseries.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 45eaf06462ae..77bc50ad9f57 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -51,9 +51,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 {
 	u64 snooze_exit_time;
 
-	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
+	local_irq_enable();
+
 	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
 	HMT_very_low();
@@ -66,6 +67,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	ppc64_runlatch_on();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
 	smp_mb();
+
 	return index;
 }
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 166ccd711ec9..7b12bb2ea70f 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -62,9 +62,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 	unsigned long in_purr;
 	u64 snooze_exit_time;
 
+	set_thread_flag(TIF_POLLING_NRFLAG);
+
 	idle_loop_prolog(&in_purr);
 	local_irq_enable();
-	set_thread_flag(TIF_POLLING_NRFLAG);
 	snooze_exit_time = get_tb() + snooze_timeout;
 
 	while (!need_resched()) {
-- 
2.11.0

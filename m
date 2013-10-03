From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/16] cpuidle: Fix comments in cpuidle core
Date: Thu,  3 Oct 2013 21:26:41 +0530
Message-ID: <7122b66c349eb4a1ec1451e24a78fd8affe478be.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380815504.git.viresh.kumar@linaro.org>
References: <cover.1380815504.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl, daniel.lezcano@linaro.org
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Few comments in cpuidle core files have trivial mistakes. This patch fixes them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpuidle/coupled.c | 2 +-
 drivers/cpuidle/cpuidle.c | 2 +-
 drivers/cpuidle/driver.c  | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index f8a8636..e952936 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -147,7 +147,7 @@ static cpumask_t cpuidle_coupled_poked;
  * has returned from this function, the barrier is immediately available for
  * reuse.
  *
- * The atomic variable a must be initialized to 0 before any cpu calls
+ * The atomic variable must be initialized to 0 before any cpu calls
  * this function, will be reset to 0 before any cpu returns from this function.
  *
  * Must only be called from within a coupled idle state handler
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d75040d..8827c02 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -516,7 +516,7 @@ int cpuidle_register(struct cpuidle_driver *drv,
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 		/*
-		 * On multiplatform for ARM, the coupled idle states could
+		 * On multiplatform for ARM, the coupled idle states could be
 		 * enabled in the kernel even if the cpuidle driver does not
 		 * use it. Note, coupled_cpus is a struct copy.
 		 */
diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 6e11701..ced1df6 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -56,7 +56,7 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
 }
 
 /**
- * __cpuidle_set_driver - set per CPU driver variables the the given driver.
+ * __cpuidle_set_driver - set per CPU driver variables for the given driver.
  * @drv: a valid pointer to a struct cpuidle_driver
  *
  * For each CPU in the driver's cpumask, unset the registered driver per CPU
@@ -132,7 +132,7 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
  * cpuidle_setup_broadcast_timer - enable/disable the broadcast timer
  * @arg: a void pointer used to match the SMP cross call API
  *
- * @arg is used as a value of type 'long' with on of the two values:
+ * @arg is used as a value of type 'long' with one of the two values:
  * - CLOCK_EVT_NOTIFY_BROADCAST_ON
  * - CLOCK_EVT_NOTIFY_BROADCAST_OFF
  *
@@ -169,7 +169,7 @@ static int __cpuidle_driver_init(struct cpuidle_driver *drv)
 	/*
 	 * Look for the timer stop flag in the different states, so that we know
 	 * if the broadcast timer has to be set up.  The loop is in the reverse
-	 * order, because usually on of the the deeper states has this flag set.
+	 * order, because usually one of the deeper states have this flag set.
 	 */
 	for (i = drv->state_count - 1; i >= 0 ; i--) {
 
-- 
1.7.12.rc2.18.g61b472e

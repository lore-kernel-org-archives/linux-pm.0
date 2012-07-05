From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/4] cpuidle: define the enter function in the driver structure
Date: Thu,  5 Jul 2012 15:23:26 +0200
Message-ID: <1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

We have the state index passed as parameter to the 'enter' function.
Most of the drivers assign their 'enter' functions several times in
the cpuidle_state structure, as we have the index, we can delegate
to the driver to handle their own callback array.

That will have the benefit of removing multiple lines of code in the
different drivers.

In order to smoothly modify the driver, the 'enter' function are in
the driver structure and in the cpuidle state structure. That will
let the time to modify the different drivers one by one.
So the 'cpuidle_enter' function checks if the 'enter' callback is
assigned in the driver structure and use it, otherwise it invokes
the 'enter' assigned to the cpuidle_state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c |    4 +++-
 include/linux/cpuidle.h   |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0132706..c064144 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -46,7 +46,9 @@ static inline int cpuidle_enter(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int index)
 {
 	struct cpuidle_state *target_state = &drv->states[index];
-	return target_state->enter(dev, drv, index);
+
+	return drv->enter ? drv->enter(dev, drv, index) :
+		target_state->enter(dev, drv, index);
 }
 
 static inline int cpuidle_enter_tk(struct cpuidle_device *dev,
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a6b3f2e..4d816c7 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -131,6 +131,7 @@ struct cpuidle_driver {
 	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
 	int			state_count;
 	int			safe_state_index;
+	int (*enter)(struct cpuidle_device *, struct cpuidle_driver *, int);
 };
 
 #ifdef CONFIG_CPU_IDLE
-- 
1.7.5.4


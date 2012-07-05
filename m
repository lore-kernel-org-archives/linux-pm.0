From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/4] cpuidle: move enter_dead to the driver structure
Date: Thu,  5 Jul 2012 15:23:27 +0200
Message-ID: <1341494608-16591-3-git-send-email-daniel.lezcano@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

The 'enter_dead' function is only used for processor_idle.c
and the same function is used several times. We fall into the
same abuse with the multiple callbacks for the same function.

This patch fixes that by moving the 'enter_dead' function to the
driver structure. A flag CPUIDLE_FLAG_DEAD_VALID has been added
to handle the callback conditional invokation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    7 +++----
 drivers/cpuidle/cpuidle.c     |    4 ++--
 include/linux/cpuidle.h       |   26 ++++++++++++++++++++------
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6d9ec3e..33310fb 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1024,6 +1024,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 struct cpuidle_driver acpi_idle_driver = {
 	.name =		"acpi_idle",
 	.owner =	THIS_MODULE,
+	.enter_dead = acpi_idle_play_dead,
 };
 
 /**
@@ -1132,16 +1133,14 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
 			case ACPI_STATE_C1:
 			if (cx->entry_method == ACPI_CSTATE_FFH)
 				state->flags |= CPUIDLE_FLAG_TIME_VALID;
-
+			state->flags |= CPUIDLE_FLAG_DEAD_VALID;
 			state->enter = acpi_idle_enter_c1;
-			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
 			break;
 
 			case ACPI_STATE_C2:
-			state->flags |= CPUIDLE_FLAG_TIME_VALID;
+			state->flags |= CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_DEAD_VALID;
 			state->enter = acpi_idle_enter_simple;
-			state->enter_dead = acpi_idle_play_dead;
 			drv->safe_state_index = count;
 			break;
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c064144..7dcfa45 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -81,14 +81,14 @@ int cpuidle_play_dead(void)
 	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 
-		if (s->power_usage < power_usage && s->enter_dead) {
+		if (s->power_usage < power_usage && (s->flags & CPUIDLE_FLAG_DEAD_VALID)) {
 			power_usage = s->power_usage;
 			dead_state = i;
 		}
 	}
 
 	if (dead_state != -1)
-		return drv->states[dead_state].enter_dead(dev, dead_state);
+		return drv->enter_dead(dev, dead_state);
 
 	return -ENODEV;
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4d816c7..730e12e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -52,14 +52,25 @@ struct cpuidle_state {
 	int (*enter)	(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index);
-
-	int (*enter_dead) (struct cpuidle_device *dev, int index);
 };
 
-/* Idle State Flags */
-#define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
-
-#define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
+/********************************************************************************
+ * Idle State Flags:                                                            *
+ * CPUIDLE_FLAG_TIME_VALID  : the drivers could measure the state residency     *
+ *                            time and store it in the 'target_residency'field. *
+ *                            This flag will tell the cpuidle core to use this  *
+ *                            value to compute an accurate prediction.          *
+ *                                                                              *
+ * CPUIDLE_FLAG_COUPLED     : state applies to multiple cpus                    *
+ *                                                                              *
+ * CPUIDLE_FLAG_DEAD_VALID  : the driver may want to deal with dead cpus, tell  *
+ *                            the cpuidle core the specified state can use the  *
+ *                            enter_dead function.                              *
+ *                                                                              *
+ *******************************************************************************/
+#define CPUIDLE_FLAG_TIME_VALID	(0x01)
+#define CPUIDLE_FLAG_COUPLED	(0x02)
+#define CPUIDLE_FLAG_DEAD_VALID (0x04)
 
 /**
  * cpuidle_get_statedata - retrieves private driver state data
@@ -132,6 +143,9 @@ struct cpuidle_driver {
 	int			state_count;
 	int			safe_state_index;
 	int (*enter)(struct cpuidle_device *, struct cpuidle_driver *, int);
+#ifdef CONFIG_ACPI
+	int (*enter_dead)(struct cpuidle_device *, int);
+#endif
 };
 
 #ifdef CONFIG_CPU_IDLE
-- 
1.7.5.4


From: "Ai Li" <aili@codeaurora.org>
Subject: [RFC] cpuidle: proposal to extend cpuidle
Date: Thu, 17 Jun 2010 09:43:06 -0600
Message-ID: <000c01cb0e33$c7fd0540$57f70fc0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, dwalker@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Sorry about this resend.  I messed up my email accounts and sent the
previous one from the wrong account.

----------- start of real message ----------------

On our SoC chips, some HW resources may be in use during any
particular idle period.  As a consequence, the cpuidle states that
the SoC is safe to enter can change from idle period to idle period.
In addition, the latencies and thresholds of each cpuidle state
depend on the current operating condition, e.g. the current cpu
frequency, the current state of the HW blocks, etc.

The central issue appears to be that cpuidle core and the menu
governor, in the current form, are geared towards cpuidle states that
are static, i.e. the availabiltiy of the states, the latencies, the
thresholds of the states are non-changing during run time.  I may
have missed something but cpuidle does not seem to provide any hook
that cpuidle drivers can use to adjust those values on the fly before
menu governor selects the target cpuidle state.

Using the patch below as something concrete to start a discussion, I
would like to propose extending cpuidle core and the menu governor to
handle states that are dynamic.

There are three additions in the patch and the patch maintains
backwards-compatibility with existing cpuidle drivers.

1) add prepare() to struct cpuidle_device.
Any cpuidle drivers can hook into this callback and the menu governor
will call prepare() in  menu_select().  The callback gives cpuidle
drivers a chance to update the dynamic information of the cpuidle
states for the current idle period, e.g. state availability,
latencies, thresholds, power_usage values, etc.

2) add CPUIDLE_FLAG_IGNORE as one of the state flags.
In the prepare() function, the cpuidle drivers can set/clear the flag
to indicate to the menu governor whether a cpuidle state should be
ignored, i.e. not available, during the current idle period.

3) add compare_power bit to struct cpuidle_device.
The menu governor currently assumes the cpuidle states are arranged
in the order of increasing latency, threshold, and power savings.
This is true or can be made true for static states.  Once the state
parameters are dynamic, the latencies, thresholds, and power savings
for the cpuidle states can increase or decrease by different amounts
from idle period to idle period.  So the assumption of increasing
latency, threshold, and power savings from Cn to C(n+1) can no longer
be guaranteed.

IMO, it would be straight forward to calculate the power consumption
of each available state for the predicted idle period.
The menu governor then selects the state that has the lowest power
consumption and that still satisfies all other critieria.  In the
example patch below, when the compare_power bit is true, the menu
governor uses the power_usage fields to find the lowest power state
instead of relying on the above assumption.  I think it makes the
cpuidle governor and cpuidle drivers easier to write and understand
for dynamic states.  With power numbers available to the governors,
it enables future tradeoff/optimization between power and latency.

~Ai


--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -52,6 +52,7 @@ struct cpuidle_state {
 #define CPUIDLE_FLAG_SHALLOW	(0x20) /* low latency, minimal
savings */
 #define CPUIDLE_FLAG_BALANCED	(0x40) /* medium latency, moderate
savings */
 #define CPUIDLE_FLAG_DEEP	(0x80) /* high latency, large savings
*/
+#define CPUIDLE_FLAG_IGNORE	(0x100) /* ignore during this idle
period */
 
 #define CPUIDLE_DRIVER_FLAGS_MASK (0xFFFF0000)
 
@@ -84,6 +85,7 @@ struct cpuidle_state_kobj {  struct cpuidle_device
{
 	unsigned int		registered:1;
 	unsigned int		enabled:1;
+	unsigned int		compare_power:1;
 	unsigned int		cpu;
 
 	int			last_residency;
@@ -97,6 +99,8 @@ struct cpuidle_device {
 	struct completion	kobj_unregister;
 	void			*governor_data;
 	struct cpuidle_state	*safe_state;
+
+	int (*prepare)          (struct cpuidle_device *dev, int
idle_us);
 };
 
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -219,6 +219,9 @@ static int menu_select(struct cpuidle_device
*dev)
 	data->predicted_us = div_round64(data->expected_us *
data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
 
+	if (dev->prepare)
+		dev->prepare(dev, data->predicted_us);
+
 	/*
 	 * We want to default to C1 (hlt), not to busy polling
 	 * unless the timer is happening really really soon.
@@ -226,19 +229,48 @@ static int menu_select(struct cpuidle_device
*dev)
 	if (data->expected_us > 5)
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
 
-
-	/* find the deepest idle state that satisfies our constraints
*/
-	for (i = CPUIDLE_DRIVER_STATE_START; i < dev->state_count;
i++) {
-		struct cpuidle_state *s = &dev->states[i];
-
-		if (s->target_residency > data->predicted_us)
-			break;
-		if (s->exit_latency > latency_req)
-			break;
-		if (s->exit_latency * multiplier >
data->predicted_us)
-			break;
-		data->exit_us = s->exit_latency;
-		data->last_state_idx = i;
+	if (dev->compare_power) {
+		/* find the idle state with the lowest power while
satisfying
+		 * our constraints
+		 */
+		unsigned int power_usage = ~0UL;
+
+		for (i=CPUIDLE_DRIVER_STATE_START;
i<dev->state_count; i++) {
+			struct cpuidle_state *s = &dev->states[i];
+
+			if (s->flags & CPUIDLE_FLAG_IGNORE)
+				continue;
+			if (s->target_residency > data->predicted_us)
+				continue;
+			if (s->exit_latency > latency_req)
+				continue;
+			if (s->exit_latency * multiplier >
data->predicted_us)
+				continue;
+
+			if (s->power_usage < power_usage) {
+				power_usage = s->power_usage;
+				data->exit_us = s->exit_latency;
+				data->last_state_idx = i;
+			}
+		}
+	} else {
+		/* find the deepest idle state that satisfies our
+		 * constraints
+		 */
+		for (i=CPUIDLE_DRIVER_STATE_START;
i<dev->state_count; i++) {
+			struct cpuidle_state *s = &dev->states[i];
+
+			if (s->flags & CPUIDLE_FLAG_IGNORE)
+				continue;
+			if (s->target_residency > data->predicted_us)
+				break;
+			if (s->exit_latency > latency_req)
+				break;
+			if (s->exit_latency * multiplier >
data->predicted_us)
+				break;
+			data->exit_us = s->exit_latency;
+			data->last_state_idx = i;
+		}
 	}
 
 	return data->last_state_idx;

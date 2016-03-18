From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 15:29:57 -0400
Message-ID: <20160318152957.5c3b91bc@annuminas.surriel.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	<20160316121400.680a6a46@annuminas.surriel.com>
	<10828426.sI6CaBvZhk@vostro.rjw.lan>
	<000701d180df$e8a14340$b9e3c9c0$@net>
	<CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	<003301d18144$87bb8df0$9732a9d0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56357 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751795AbcCRTaC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 15:30:02 -0400
In-Reply-To: <003301d18144$87bb8df0$9732a9d0$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, "'Chen, Yu C'" <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, 'Arto Jantunen' <viiru@iki.fi>, 'Len Brown' <lenb@kernel.org>

On Fri, 18 Mar 2016 11:32:28 -0700
"Doug Smythies" <dsmythies@telus.net> wrote:
> On 2016.03.18 06:12 Rafael J. Wysocki wrote:

> > I'm wondering what happens if you replace the expected_interval in the
> > "expected_interval >
> > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency" test with
> > data->next_timer_us (with the Rik's patch applied, of course).  Can
> > you please try doing that?  
> 
> O.K. my reference: rvr6 is the above modification to rvr5
> It works as well as "reverted"/
> 
> State	k45rc7-rjw10-rvr6 (mins)
> 0.00	0.87
> 1.00	24.20
> 2.00	4.05
> 3.00	1.72
> 4.00	147.50
> 
> total	178.34
> 
> Energy:
> Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> 
> Trace data (very crude summary):
> Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load (idle state 0)
> Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less, CPU load (not all idle state 0)

What does "long duration" mean? 
Dozens of microseconds?
Hundreds of microseconds?
Milliseconds?

Either way, it appears there is something wrong with the
code in get_typical_interval.  One of the problems is
that calculating in microseconds, when working with a
threshold of 1-2 microseconds is not going to work well,
and secondly the code declares success the moment the
standard deviation is below 20 microseconds, which is
also not the best idea when dealing with 1-2 microsecond
thresholds :)

Does the below patch help?

If it does, we will probably want to change the values in
the driver tables to nanoseconds too, so we can get rid of
the multiplications :)

---8<---

Subject: cpuidle: track time in nsecs not usecs

The cpuidle code currently tracks time in microseconds, which
has a few issues. For one, the kernel natively tracks time in
nanoseconds, and we do a divide by 1000 when tracking how long
the CPU spent in an idle state.

Secondly, get_typical_interval in the menu governor cannot do
very useful math when working with small numbers, while the
HLT cutoff is only 1 or 2 microseconds on many CPUs.

Converting to nanoseconds avoids the expensive divide, and
also allows get_typical_interval to do calculations that
may make more sense for smaller intervals.

While we're there, also remove the code that allows
get_typical_interval to return a value as soon as the
standard deviation is under 20 microseconds.  That
threshold makes little sense when C1 and C2 both
have latencies much lower than that.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/cpuidle.c          | 10 ++---
 drivers/cpuidle/governors/ladder.c |  2 +-
 drivers/cpuidle/governors/menu.c   | 90 +++++++++++++++++---------------------
 drivers/cpuidle/sysfs.c            |  8 +++-
 include/linux/cpuidle.h            |  4 +-
 5 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f996efc56605..8a0673880fbe 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -217,18 +217,18 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, entered_state))
 		local_irq_enable();
 
-	diff = ktime_to_us(ktime_sub(time_end, time_start));
-	if (diff > INT_MAX)
-		diff = INT_MAX;
+	diff = ktime_to_ns(ktime_sub(time_end, time_start));
+	if (diff > LONG_MAX)
+		diff = LONG_MAX;
 
-	dev->last_residency = (int) diff;
+	dev->last_residency = diff;
 
 	if (entered_state >= 0) {
 		/* Update cpuidle counters */
 		/* This can be moved to within driver enter routine
 		 * but that results in multiple copies of same code.
 		 */
-		dev->states_usage[entered_state].time += dev->last_residency;
+		dev->states_usage[entered_state].time += diff;
 		dev->states_usage[entered_state].usage++;
 	} else {
 		dev->last_residency = 0;
diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 63bd5a403e22..6b480a3a3a2e 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
+	last_residency = ktime_to_us(cpuidle_get_last_residency(dev)) - drv->states[last_idx].exit_latency;
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index fba867d917f7..69adb6ab7b8c 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -33,9 +33,9 @@
 #define BUCKETS 12
 #define INTERVAL_SHIFT 3
 #define INTERVALS (1UL << INTERVAL_SHIFT)
-#define RESOLUTION 1024
+#define RESOLUTION NSEC_PER_USEC
 #define DECAY 8
-#define MAX_INTERESTING 50000
+#define MAX_INTERESTING 4000000
 
 
 /*
@@ -122,11 +122,11 @@ struct menu_device {
 	int		last_state_idx;
 	int             needs_update;
 
-	unsigned int	next_timer_us;
-	unsigned int	predicted_us;
+	u64		next_timer_ns;
+	u64		predicted_ns;
 	unsigned int	bucket;
 	unsigned int	correction_factor[BUCKETS];
-	unsigned int	intervals[INTERVALS];
+	u64		intervals[INTERVALS];
 	int		interval_ptr;
 };
 
@@ -152,15 +152,15 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
 	if (nr_iowaiters)
 		bucket = BUCKETS/2;
 
-	if (duration < 10)
+	if (duration < 10000)
 		return bucket;
-	if (duration < 100)
+	if (duration < 100000)
 		return bucket + 1;
-	if (duration < 1000)
+	if (duration < 1000000)
 		return bucket + 2;
-	if (duration < 10000)
+	if (duration < 10000000)
 		return bucket + 3;
-	if (duration < 100000)
+	if (duration < 100000000)
 		return bucket + 4;
 	return bucket + 5;
 }
@@ -242,21 +242,12 @@ static unsigned int get_typical_interval(struct menu_device *data)
 	 * The typical interval is obtained when standard deviation is small
 	 * or standard deviation is small compared to the average interval.
 	 *
-	 * int_sqrt() formal parameter type is unsigned long. When the
-	 * greatest difference to an outlier exceeds ~65 ms * sqrt(divisor)
-	 * the resulting squared standard deviation exceeds the input domain
-	 * of int_sqrt on platforms where unsigned long is 32 bits in size.
-	 * In such case reject the candidate average.
-	 *
-	 * Use this result only if there is no timer to wake us up sooner.
+	 * Instead of taking the square root of the standard deviation,
+	 * use the square of the average. Be careful to avoid overflow.
 	 */
-	if (likely(stddev <= ULONG_MAX)) {
-		stddev = int_sqrt(stddev);
-		if (((avg > stddev * 6) && (divisor * 4 >= INTERVALS * 3))
-							|| stddev <= 20) {
-			return avg;
-		}
-	}
+	if (avg < INT_MAX && (avg * avg) > stddev * 9 &&
+					divisor * 4 >= INTERVALS * 3)
+		return avg;
 
 	/*
 	 * If we have outliers to the upside in our distribution, discard
@@ -282,10 +273,10 @@ static unsigned int get_typical_interval(struct menu_device *data)
 static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
-	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
+	u64 latency_req = NSEC_PER_USEC * pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
-	unsigned int interactivity_req;
-	unsigned int expected_interval;
+	u64 interactivity_req;
+	u64 expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
 
 	if (data->needs_update) {
@@ -298,22 +289,21 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		return 0;
 
 	/* determine the expected residency time, round up */
-	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length());
+	data->next_timer_ns = ktime_to_ns(tick_nohz_get_sleep_length());
 
-	get_iowait_load(&nr_iowaiters, &cpu_load);
-	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
+	data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
 
 	/*
 	 * Force the result of multiplication to be 64 bits even if both
 	 * operands are 32 bits.
-	 * Make sure to round up for half microseconds.
+	 * Make sure to round up for half nanoseconds.
 	 */
-	data->predicted_us = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_us *
+	data->predicted_ns = DIV_ROUND_CLOSEST_ULL((uint64_t)data->next_timer_ns *
 					 data->correction_factor[data->bucket],
 					 RESOLUTION * DECAY);
 
 	expected_interval = get_typical_interval(data);
-	expected_interval = min(expected_interval, data->next_timer_us);
+	expected_interval = min(expected_interval, data->next_timer_ns);
 
 	if (CPUIDLE_DRIVER_STATE_START > 0) {
 		data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
@@ -322,8 +312,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		 * unless the timer is happening really really soon, or
 		 * C1's exit latency exceeds the user configured limit.
 		 */
-		if (expected_interval > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency &&
-		    latency_req > drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency &&
+		if (expected_interval > drv->states[CPUIDLE_DRIVER_STATE_START].target_residency * NSEC_PER_USEC &&
+		    latency_req > drv->states[CPUIDLE_DRIVER_STATE_START].exit_latency * NSEC_PER_USEC &&
 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
 		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
@@ -334,13 +324,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	/*
 	 * Use the lowest expected idle interval to pick the idle state.
 	 */
-	data->predicted_us = min(data->predicted_us, expected_interval);
+	data->predicted_ns = min(data->predicted_ns, expected_interval);
 
 	/*
 	 * Use the performance multiplier and the user-configurable
 	 * latency_req to determine the maximum exit latency.
 	 */
-	interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
+	get_iowait_load(&nr_iowaiters, &cpu_load);
+	interactivity_req = data->predicted_ns;
+	do_div(interactivity_req, performance_multiplier(nr_iowaiters, cpu_load));
 	if (latency_req > interactivity_req)
 		latency_req = interactivity_req;
 
@@ -354,9 +346,9 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 
 		if (s->disabled || su->disable)
 			continue;
-		if (s->target_residency > data->predicted_us)
+		if (s->target_residency * NSEC_PER_USEC > data->predicted_ns)
 			continue;
-		if (s->exit_latency > latency_req)
+		if (s->exit_latency * NSEC_PER_USEC > latency_req)
 			continue;
 
 		data->last_state_idx = i;
@@ -391,8 +383,8 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	int last_idx = data->last_state_idx;
 	struct cpuidle_state *target = &drv->states[last_idx];
-	unsigned int measured_us;
 	unsigned int new_factor;
+	u64 measured_ns;
 
 	/*
 	 * Try to figure out how much time passed between entry to low
@@ -410,24 +402,24 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 */
 
 	/* measured value */
-	measured_us = cpuidle_get_last_residency(dev);
+	measured_ns = cpuidle_get_last_residency(dev);
 
 	/* Deduct exit latency */
-	if (measured_us > 2 * target->exit_latency)
-		measured_us -= target->exit_latency;
+	if (measured_ns > 2 * NSEC_PER_USEC * target->exit_latency)
+		measured_ns -= NSEC_PER_USEC * target->exit_latency;
 	else
-		measured_us /= 2;
+		measured_ns /= 2;
 
 	/* Make sure our coefficients do not exceed unity */
-	if (measured_us > data->next_timer_us)
-		measured_us = data->next_timer_us;
+	if (measured_ns > data->next_timer_ns)
+		measured_ns = data->next_timer_ns;
 
 	/* Update our correction ratio */
 	new_factor = data->correction_factor[data->bucket];
 	new_factor -= new_factor / DECAY;
 
-	if (data->next_timer_us > 0 && measured_us < MAX_INTERESTING)
-		new_factor += RESOLUTION * measured_us / data->next_timer_us;
+	if (data->next_timer_ns > 0 && measured_ns < MAX_INTERESTING)
+		new_factor += measured_ns / data->next_timer_ns;
 	else
 		/*
 		 * we were idle so long that we count it as a perfect
@@ -447,7 +439,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	data->correction_factor[data->bucket] = new_factor;
 
 	/* update the repeating-pattern data */
-	data->intervals[data->interval_ptr++] = measured_us;
+	data->intervals[data->interval_ptr++] = measured_ns;
 	if (data->interval_ptr >= INTERVALS)
 		data->interval_ptr = 0;
 }
diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index 832a2c3f01ff..e2fa2cf4f8a5 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -292,11 +292,17 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 	return sprintf(buf, "%s\n", state->_name);\
 }
 
+static ssize_t show_state_time(struct cpuidle_state *state,
+				  struct cpuidle_state_usage *state_usage,
+				  char *buf)
+{
+	return sprintf(buf, "%llu\n", NSEC_PER_USEC * state_usage->time);
+}
+
 define_show_state_function(exit_latency)
 define_show_state_function(target_residency)
 define_show_state_function(power_usage)
 define_show_state_ull_function(usage)
-define_show_state_ull_function(time)
 define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(disable)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 786ad32631a6..e6bab06d5502 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -76,7 +76,7 @@ struct cpuidle_device {
 	unsigned int		enabled:1;
 	unsigned int		cpu;
 
-	int			last_residency;
+	u64			last_residency;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
 	struct cpuidle_state_kobj *kobjs[CPUIDLE_STATE_MAX];
 	struct cpuidle_driver_kobj *kobj_driver;
@@ -96,7 +96,7 @@ DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
  * cpuidle_get_last_residency - retrieves the last state's residency time
  * @dev: the target CPU
  */
-static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
+static inline u64 cpuidle_get_last_residency(struct cpuidle_device *dev)
 {
 	return dev->last_residency;
 }

From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before selecting an idle state
Date: Tue, 26 Feb 2019 15:54:14 +0100
Message-ID: <20190226145415.19411-8-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A common piece of data used by cpuidle governors, is the information about
when the next timer/tick is going to fire. Rather than having each governor
calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
the code by calling these functions before invoking the ->select() callback
of the governor - and store the output data in the struct cpuidle_device.

Besides the consolidation benefit, the purpose of this change is also to
make the information about the next timer/tick, available outside the
cpuidle framework. Following changes that implements a new genpd governor,
makes use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/cpuidle.c        | 2 ++
 drivers/cpuidle/governors/menu.c | 6 ++----
 drivers/cpuidle/governors/teo.c  | 6 ++----
 include/linux/cpuidle.h          | 2 ++
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..3b148253036b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -312,6 +312,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
+	dev->next_timer = tick_nohz_get_next_timer();
+	dev->next_hrtimer = tick_nohz_get_next_hrtimer();
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 95e9122d6047..cdbe434e783d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,8 +287,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned long nr_iowaiters;
 	ktime_t delta_next;
 	ktime_t now = ktime_get();
-	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
-	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -298,14 +296,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * Compute the duration before the next timer, whatever the origin
 	 */
-	delta_next = ktime_sub(next_timer, now);
+	delta_next = ktime_sub(dev->next_timer, now);
 	data->next_timer_us = ktime_to_us(delta_next);
 
 	/*
 	 * Compute the duration before next hrtimer which is the tick
 	 * or an earliest hrtimer
 	 */
-	delta_next = ktime_sub(next_hrtimer, now);
+	delta_next = ktime_sub(dev->next_hrtimer, now);
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index bef1e95c597e..7af9851d9d40 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -245,8 +245,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	int max_early_idx, idx, i;
 	ktime_t delta_tick;
 	ktime_t now = ktime_get();
-	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
-	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (cpu_data->last_state >= 0) {
 		teo_update(drv, dev);
@@ -255,8 +253,8 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	cpu_data->time_span_ns = local_clock();
 
-	cpu_data->sleep_length_ns = ktime_sub(next_timer, now);
-	delta_tick = ktime_sub(next_hrtimer, now);
+	cpu_data->sleep_length_ns = ktime_sub(dev->next_timer, now);
+	delta_tick = ktime_sub(dev->next_hrtimer, now);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
 	count = 0;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..81ec924206f0 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,6 +83,8 @@ struct cpuidle_device {
 	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
+	ktime_t			next_timer;
+	ktime_t			next_hrtimer;
 
 	int			last_residency;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
-- 
2.17.1

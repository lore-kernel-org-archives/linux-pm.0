From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v11 4/8] cpuidle: menu: Convert to tick_nohz_get_next_timer|hrtimer()
Date: Tue, 26 Feb 2019 15:54:11 +0100
Message-ID: <20190226145415.19411-5-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Rather than using tick_nohz_get_sleep_length(), let's convert to use the
more flexible tick_nohz_get_next_timer|hrtimer() APIs. This should have no
functional change, but allows following changes to later drop the
tick_nohz_get_sleep_length() API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/governors/menu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 61316fc51548..95e9122d6047 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -286,14 +286,26 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int predicted_us;
 	unsigned long nr_iowaiters;
 	ktime_t delta_next;
+	ktime_t now = ktime_get();
+	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
+	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
 	}
 
-	/* determine the expected residency time, round up */
-	data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
+	/*
+	 * Compute the duration before the next timer, whatever the origin
+	 */
+	delta_next = ktime_sub(next_timer, now);
+	data->next_timer_us = ktime_to_us(delta_next);
+
+	/*
+	 * Compute the duration before next hrtimer which is the tick
+	 * or an earliest hrtimer
+	 */
+	delta_next = ktime_sub(next_hrtimer, now);
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
-- 
2.17.1

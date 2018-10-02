From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/6] cpuidle: menu: Avoid computations for very close timers
Date: Tue, 02 Oct 2018 23:46:28 +0200
Message-ID: <2753018.aK9edJ7Dvu@aspire.rjw.lan>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the next timer event (with the tick excluded) is closer than the
target residency of the second state or the PM QoS latency constraint
is below its exit latency, state[0] will be used regardless of any
other factors, so skip the computations in menu_select() then and
return 0 straight away from it.

Still, do that after the bucket has been determined to avoid
disturbing the wakeup statistics in general.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -309,6 +309,18 @@ static int menu_select(struct cpuidle_dr
 	get_iowait_load(&nr_iowaiters, &cpu_load);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
 
+	if (unlikely(drv->state_count <= 1) ||
+	    ((data->next_timer_us < drv->states[1].target_residency ||
+	      latency_req < drv->states[1].exit_latency) &&
+	     !drv->states[0].disabled && !dev->states_usage[0].disable)) {
+		/*
+		 * In this case state[0] will be used no matter what, so return
+		 * it right away and keep the tick running.
+		 */
+		*stop_tick = false;
+		return 0;
+	}
+
 	/*
 	 * Force the result of multiplication to be 64 bits even if both
 	 * operands are 32 bits.

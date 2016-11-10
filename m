From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2] drivers: cpuidle: assign enter_freeze to same as enter callback function
Date: Thu, 10 Nov 2016 14:24:33 +0000
Message-ID: <1478787873-18180-1-git-send-email-sudeep.holla@arm.com>
References: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andy Gross <andy.gross@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

enter_freeze() callback is expected atleast to do the same as enter()
but it has to guarantee that interrupts aren't enabled at any point
in its execution, as the tick is frozen.

CPUs execute ->enter_freeze with the local tick or entire timekeeping
suspended, so it must not re-enable interrupts at any point (even
temporarily) or attempt to change states of clock event devices.

It will be called when the system goes to suspend-to-idle and will
reduce power usage because CPUs won't be awaken for unnecessary IRQs
(i.e. woken up only on IRQs from "wakeup sources")

We can reuse the same code for both the enter() and enter_freeze()
callbacks as along as they don't re-enable interrupts. Only "coupled"
cpuidle mechanism enables interrupts and doing that with timekeeping
suspended is generally not safe.

Since this generic DT based idle driver doesn't support "coupled"
states, it is safe to assume that the interrupts are not re-enabled.

This patch assign enter_freeze to same as enter callback function which
helps to save power without any intermittent spurious wakeups from
suspend-to-idle.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpuidle/dt_idle_states.c | 6 ++++++
 1 file changed, 6 insertions(+)

v1->v2:
	- Dropped checking and using only states with CPUIDLE_FLAG_TIMER_STOP
	  enabled.

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index a5c111b67f37..ffca4fc0061d 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -38,6 +38,12 @@ static int init_state_node(struct cpuidle_state *idle_state,
 	 * state enter function.
 	 */
 	idle_state->enter = match_id->data;
+	/*
+	 * Since this is not a "coupled" state, it's safe to assume interrupts
+	 * won't be enabled when it exits allowing the tick to be frozen
+	 * safely. So enter() can be also enter_freeze() callback.
+	 */
+	idle_state->enter_freeze = match_id->data;

 	err = of_property_read_u32(state_node, "wakeup-latency-us",
 				   &idle_state->exit_latency);
--
2.7.4

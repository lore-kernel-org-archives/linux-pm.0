From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] drivers: cpuidle: assign enter_freeze to same as enter callback function
Date: Wed,  9 Nov 2016 17:43:30 +0000
Message-ID: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
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

Since for all the states that have CPUIDLE_FLAG_TIMER_STOP flag set,
local tick is stopped, we can reuse the same code for both the enter()
and enter_freeze() callbacks. Only "coupled" cpuidle mechanism enables
interrupts and doing that with timekeeping suspended is generally not
safe. Since this generic DT based idle driver doesn't support "coupled"
states, it is safe to assume that the interrupts are not re-enabled.

This patch assign enter_freeze to same as enter callback function which
helps to save power without any intermittent spurious wakeups from
suspend-to-idle.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpuidle/dt_idle_states.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index a5c111b67f37..5a087d108475 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -79,8 +79,17 @@ static int init_state_node(struct cpuidle_state *idle_state,
 		desc = state_node->name;

 	idle_state->flags = 0;
-	if (of_property_read_bool(state_node, "local-timer-stop"))
+	if (of_property_read_bool(state_node, "local-timer-stop")) {
 		idle_state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+		/*
+		 * CPUIDLE_FLAG_TIMER_STOP guarantees that the local tick is
+		 * stopped and since this is not a "coupled" state interrupts
+		 * won't be enabled when it exits allowing the tick to be
+		 * frozen safely. So enter() can be also enter_freeze()
+		 * callback.
+		 */
+		idle_state->enter_freeze = match_id->data;
+	}
 	/*
 	 * TODO:
 	 *	replace with kstrdup and pointer assignment when name
--
2.7.4

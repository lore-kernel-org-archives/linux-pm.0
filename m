From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: Fix coupled state parameter in cpuidle_enter()
Date: Tue, 17 May 2016 16:54:00 +0200
Message-ID: <1463496840-2858-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: gregory.clement@free-electrons.com, linux-pm@vger.kernel.org, linux@armlinux.org.uk, paul.burton@imgtec.com, stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The commit 0b89e9aa2856 rightfully fixed a regression by letting the couple
idle state framework to handle local interrupt enabling when the cpu is
exiting an idle state.

The current code check if the idle state is a coupled one and, if so, it will
let the couple code to enable the interrupt. This way, it can decrement the
ready-count before handling the interrupts. This mechanism prevents the other
cpus to wait for a cpu which is handling interrupts.

But the check is done against the state index returned by the back end driver
'enter' functions which could be different from the initial index passed as
parameter to the cpuidle_enter_state() function.

 entered_state = target_state->enter(dev, drv, index);

 [ ... ]

 if (!cpuidle_state_is_coupled(drv, entered_state))
	local_irq_enable();

 [ ... ]

If the 'index' is referring to a coupled idle state but the 'entered_state'
is *not* coupled, then the interrupts are enabled again. All cpus blocked on
the sync barrier may busy loop longer if the cpu has interrupts to handle
before decrementing the ready-count. Thus consuming more energy than saving.

Fixes: 0b89e9aa2856 "cpuidle: delay enabling interrupts until all coupled CPUs leave idle"
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index f996efc..cd021ed 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -214,7 +214,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		tick_broadcast_exit();
 	}
 
-	if (!cpuidle_state_is_coupled(drv, entered_state))
+	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
 
 	diff = ktime_to_us(ktime_sub(time_end, time_start));
-- 
1.9.1

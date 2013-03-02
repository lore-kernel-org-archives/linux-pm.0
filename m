From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/4][V2] time : pass broadcast parameter
Date: Sat,  2 Mar 2013 11:10:10 +0100
Message-ID: <1362219013-18173-2-git-send-email-daniel.lezcano@linaro.org>
References: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362219013-18173-1-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: john.stultz@linaro.org, tglx@linutronix.de
Cc: jacob.jun.pan@linux.intel.com, vincent.guittot@linaro.org, linus.walleij@stericsson.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, rickard.andersson@stericsson.com, linaro-kernel@lists.linaro.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

The broadcast timer could be passed as parameter to the function
instead of using again tick_broadcast_device.evtdev which was
previously used in the caller function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/time/tick-broadcast.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 2fb8cb8..6197ac0 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -406,10 +406,9 @@ struct cpumask *tick_get_broadcast_oneshot_mask(void)
 	return to_cpumask(tick_broadcast_oneshot_mask);
 }
 
-static int tick_broadcast_set_event(ktime_t expires, int force)
+static int tick_broadcast_set_event(struct clock_event_device *bc,
+				    ktime_t expires, int force)
 {
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
-
 	if (bc->mode != CLOCK_EVT_MODE_ONESHOT)
 		clockevents_set_mode(bc, CLOCK_EVT_MODE_ONESHOT);
 
@@ -479,7 +478,7 @@ again:
 		 * Rearm the broadcast device. If event expired,
 		 * repeat the above
 		 */
-		if (tick_broadcast_set_event(next_event, 0))
+		if (tick_broadcast_set_event(dev, next_event, 0))
 			goto again;
 	}
 	raw_spin_unlock(&tick_broadcast_lock);
@@ -522,7 +521,7 @@ void tick_broadcast_oneshot_control(unsigned long reason)
 			cpumask_set_cpu(cpu, tick_get_broadcast_oneshot_mask());
 			clockevents_set_mode(dev, CLOCK_EVT_MODE_SHUTDOWN);
 			if (dev->next_event.tv64 < bc->next_event.tv64)
-				tick_broadcast_set_event(dev->next_event, 1);
+				tick_broadcast_set_event(bc, dev->next_event, 1);
 		}
 	} else {
 		if (cpumask_test_cpu(cpu, tick_get_broadcast_oneshot_mask())) {
@@ -591,7 +590,7 @@ void tick_broadcast_setup_oneshot(struct clock_event_device *bc)
 			clockevents_set_mode(bc, CLOCK_EVT_MODE_ONESHOT);
 			tick_broadcast_init_next_event(to_cpumask(tmpmask),
 						       tick_next_period);
-			tick_broadcast_set_event(tick_next_period, 1);
+			tick_broadcast_set_event(bc, tick_next_period, 1);
 		} else
 			bc->next_event.tv64 = KTIME_MAX;
 	} else {
-- 
1.7.9.5

From: "Wei, Gang" <gang.wei@intel.com>
Subject: RE: [linux-pm] [RFC-PATCH] Improve Menu Governor Prediction of interrupted C states.
Date: Tue, 22 Jul 2008 15:59:14 +0800
Message-ID: <094BCE01AFBE9646AF220B0B3F367AAB034DBB7A@pdsmsx413.ccr.corp.intel.com>
References: <13B9B4C6EF24D648824FF11BE8967162035BEA0EDF@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753750AbYGVH7a@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162035BEA0EDF@dlee02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Linux Power Management List <linux-pm@lists.osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

I also found current cpuidle Menu governor should have some problems
while predicting next non-expected break-event after some expected
break-events. The measured_us/elapsed_us/predicted_us will become larger
and larger once (measured_us + BREAK_FUZZ >= data->expected_us -
target->exit_latency). The major point is that it should be
last_residency, not measured_us, that need to be used to do comparing
and distinguish between expected & non-expected events.

Below is my draft patch (not tested) for this. It is simple and should
also be effective for high interrupt rates case.

Jimmy

Signed-off-by: Wei Gang <gang.wei@intel.com>

diff --git a/drivers/cpuidle/governors/menu.c
b/drivers/cpuidle/governors/menu.c
index 78d77c5..dea5250 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -80,18 +80,19 @@ static void menu_reflect(struct cpuidle_device *dev)
        if (!(target->flags & CPUIDLE_FLAG_TIME_VALID))
                measured_us = USEC_PER_SEC / HZ;

+       /* if wrapping, set to max uint (-1) */
+       measured_us = (data->elapsed_us < measured_us) ? measured_us :
-1;
+
        /* Predict time remaining until next break event */
-       if (measured_us + BREAK_FUZZ < data->expected_us -
target->exit_latency) {
-               data->predicted_us = max(measured_us,
data->last_measured_us);
+       data->predicted_us = max(measured_us, data->last_measured_us);
+
+       /* Distinguish between expected & non-expected events */
+       if (cpuidle_get_last_residency(dev) + BREAK_FUZZ
+               < data->expected_us - target->exit_latency) {
                data->last_measured_us = measured_us;
                data->elapsed_us = 0;
-       } else {
-               if (data->elapsed_us < data->elapsed_us + measured_us)
-                       data->elapsed_us = measured_us;
-               else
-                       data->elapsed_us = -1;
-               data->predicted_us = max(measured_us,
data->last_measured_us);
-       }
+       } else
+               data->elapsed_us = measured_us;
 }

 /**


On Tuesday, July 15, 2008 5:02 AM, Woodruff, Richard wrote:
> Hi,
> 
> Any comments on the following?
> 
> I'm finding with high interrupt rates for some USB devices the menu
governor
> guesses wrong enough that throughput drops. 
> 
> With the below tweak tests with fixed data sizes which were taking 12s
to
> complete drop back to 9s.  Also my standby idle doesn't change before
and
> after activity with our with out the patch.  
> 
> What it does is simply timestamp incoming irqs, then in the menu
governor
> will use current & last irq time delta to refine its guess as to how
long
> sleep will happen.  
> 
> Regards,
> Richard W.

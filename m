From: Rik van Riel <riel@redhat.com>
Subject: Re: SKL BOOT FAILURE unless idle=nomwait (was Re: PROBLEM: Cpufreq
 constantly keeps frequency at maximum on 4.5-rc4)
Date: Fri, 11 Mar 2016 09:03:06 -0500
Message-ID: <20160311090306.1bfe380b@annuminas.surriel.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	<87si087tsr.fsf@iki.fi>
	<CAJvTdKmg=H2hqFd+fwu0t8Rx4PV8E3vNGc-j8zzVKLFX4nprYg@mail.gmail.com>
	<87a8m74mcc.fsf@iki.fi>
	<002d01d17a57$ec417030$c4c45090$@net>
	<CAJZ5v0i0cx_xYUwFWDX5nE+rNgbX4TY0ATYuD3rEi86Ky5cA5A@mail.gmail.com>
	<003701d17a5d$cab287a0$601796e0$@net>
	<CAJZ5v0gaO3vB7Bz+URiwdXx2jypqPSJ3Pc_aJ5VGgh4wJyB9Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49430 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628AbcCKODL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Mar 2016 09:03:11 -0500
In-Reply-To: <CAJZ5v0gaO3vB7Bz+URiwdXx2jypqPSJ3Pc_aJ5VGgh4wJyB9Kg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>

On Thu, 10 Mar 2016 00:59:01 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> OK, thanks.
> 
> Rik, that seems to go against the changelog of
> a9ceb78bc75ca47972096372ff3d48648b16317a:
> 
> "This is not a big deal on most x86 CPUs, which have very low C1
> latencies, and the patch should not have any effect on those CPUs."
> 
> The effect is actually measurable and quite substantial to my eyes.

Indeed, my mistake was testing not just against the predicted
latency, but against the predicted latency multiplied by the
load correction factor, which can be as much as 10x the load...

The patch below should fix that.

It didn't for Arto, due to the other issues on his system, but
it might resolve the issue for Doug, where cstate/pstate is
otherwise working fine.

Doug, does the patch below solve your issue?

If it does not, we should figure out why the idle state selection
loop is not selecting the right mode.

Is the latency_req "load correction" too aggressive?

Or is it only too aggressive for IDLE->HLT selection, and fine to
drive choices between deeper C states?

After all, if it causes the IDLE->HLT selection to go wrong, maybe
it is also causing us to pick shallower C states when we should be
picking deeper ones?

        /*
         * Find the idle state with the lowest power while satisfying
         * our constraints.
         */
        for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
                struct cpuidle_state *s = &drv->states[i];
                struct cpuidle_state_usage *su = &dev->states_usage[i];

                if (s->disabled || su->disable)
                        continue;
                if (s->target_residency > data->predicted_us)
                        continue;
                if (s->exit_latency > latency_req)
                        continue;

                data->last_state_idx = i;
        }

---8<---

Subject: cpuidle: use predicted_us not interactivity_req to consider polling

The interactivity_req variable is the expected sleep time, divided
by the CPU load. This can be too aggressive a factor in deciding
whether or not to consider polling in the cpuidle state selection.

Use the (not corrected for load) predicted_us instead.

Signed-off-by: Rik van Riel <riel@redhat.com>
---
 drivers/cpuidle/governors/menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 0742b3296673..97022ae01d2e 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -330,7 +330,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		 * We want to default to C1 (hlt), not to busy polling
 		 * unless the timer is happening really really soon.
 		 */
-		if (interactivity_req > 20 &&
+		if (data->predicted_us > 20 &&
 		    !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
 			dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable == 0)
 			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;

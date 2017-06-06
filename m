From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC] cpuidle: menu: nearby timer use lightest state; allow
 state 0 to be disabled
Date: Tue, 6 Jun 2017 11:15:55 +1000
Message-ID: <20170606111555.2881763e@roar.ozlabs.ibm.com>
References: <20170530162631.9073-1-npiggin@gmail.com>
        <20170605151906.GA2929@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33899 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdFFBQO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 21:16:14 -0400
Received: by mail-pg0-f68.google.com with SMTP id v14so7770354pgn.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2017 18:16:14 -0700 (PDT)
In-Reply-To: <20170605151906.GA2929@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

On Mon, 5 Jun 2017 20:49:06 +0530
Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:

> Hello Nicholas,
> 
> On Wed, May 31, 2017 at 02:26:31AM +1000, Nicholas Piggin wrote:
> > I've found the menu driver does not allow state0 to properly be disabled
> > because of all this poll logic selecting the first state and then trying
> > to iterate over subsequent states. Ripping most of that out and simplifying
> > it solved that issue but raised more questions about polling logic.  
> 
> At one point menu governor did allow state0 to be disabled. However,
> in cases where the predicted residency is so small that none of the
> higher idle states are valid, the menu governor would return -1 (no
> suitable state). As a result, the history would never get
> populated. Thus, the menu governor would always predict state0 which
> was disabled thus resulting in a viscious cycle where none of the idle
> states were entered into on a completely idle system.
> 
> This was fixed in commit 9c4b2867ed7c8c8784dd417ffd16e705e81eb145 ("
> cpuidle: menu: Fix menu_select() for CPUIDLE_DRIVER_STATE_START == 0")
> which had an unfortunate side-effect of not allowing state0 to be
> disabled.

Yeah, I appreciate there is a lot of complexity and heuristics.

> > Firstly polling logic is there only on architectures which define
> > ARCH_HAS_CPU_RELAX, which is only x86. Seems like if we think a
> > timer is so close that no powersave should be done, then surely just
> > picking the lightest mode (whether that is polling or something else)
> > would be best.
> > 
> > But looking further into it, it seems maybe like some x86 hack (as
> > the comments and changelog in 7884084f3bcc and subsequent attempts to
> > work around Atom and broken firmware suggests). I would have thought
> > such broken hard/firmware should get workarounds applied to fix the
> > state values rather than add such logic?
> > 
> > On the other hand, if (CPUIDLE_DRIVER_STATE_START > 0) is shorthand for
> > if (x86 hacks), that's fine I'm happy to leave that alone and just work
> > with the else parts...  
> 
> At least on POWER, CPUIDLE_DRIVER_START == 0.

That's true, it just seems like "x86 hack for state latency reporting
broken by firmware", which should be fixed as a chip quirk in their arch
code. I'll ignore it for now.

> > @@ -370,9 +372,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
> >  		if (s->exit_latency > latency_req)
> >  			break;
> > 
> > -		data->last_state_idx = i;
> > +		idx = i;
> >  	}
> > 
> > +	if (idx == -1) /* no states */
> > +		idx = 0;  
> 
> So even if state0 is disabled, when no suitable states are found we
> will still fallback to state0. The additional thing this patch does is
> to check inside the loop if state0 is disabled or not. This patch
> improves the readability by making the fallback to state0 on no
> suitable states being found.
> 
> Are you able to observe any functional difference with this patch ?

Yes for some tests, but it did have a bug where state0 was still
being used despite other states being available. This patch really
disables state0 (unless all states are disabled, then it falls back
to 0 again).

---
 drivers/cpuidle/governors/menu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index b2330fd69e34..61b64c2b2cb8 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -286,6 +286,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	struct device *device = get_cpu_device(dev->cpu);
 	int latency_req = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
 	int i;
+	int first_idx;
+	int idx;
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
@@ -335,11 +337,11 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		if (data->next_timer_us > polling_threshold &&
 		    latency_req > s->exit_latency && !s->disabled &&
 		    !dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable)
-			data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+			first_idx = CPUIDLE_DRIVER_STATE_START;
 		else
-			data->last_state_idx = CPUIDLE_DRIVER_STATE_START - 1;
+			first_idx = CPUIDLE_DRIVER_STATE_START - 1;
 	} else {
-		data->last_state_idx = CPUIDLE_DRIVER_STATE_START;
+		first_idx = 0;
 	}
 
 	/*
@@ -359,20 +361,28 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * Find the idle state with the lowest power while satisfying
 	 * our constraints.
 	 */
-	for (i = data->last_state_idx + 1; i < drv->state_count; i++) {
+	idx = -1;
+	for (i = first_idx; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
 		if (s->disabled || su->disable)
 			continue;
+		if (idx == -1)
+			idx = i; /* first enabled state */
 		if (s->target_residency > data->predicted_us)
 			break;
 		if (s->exit_latency > latency_req)
 			break;
 
-		data->last_state_idx = i;
+		idx = i;
 	}
 
+	if (idx == -1)
+		idx = 0; /* No states enabled. Must use 0. */
+
+	data->last_state_idx = idx;
+
 	return data->last_state_idx;
 }
 
-- 

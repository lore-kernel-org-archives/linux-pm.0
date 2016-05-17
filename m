From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH] cpuidle: mvebu: indicate failure to enter deeper
 sleep states
Date: Tue, 17 May 2016 10:20:49 +0100
Message-ID: <20160517092049.GA16467@n2100.armlinux.org.uk>
References: <E1ZiI7T-0002zo-Ez@rmk-PC.arm.linux.org.uk>
 <561262D1.5070506@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40241 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbcEQJVF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 05:21:05 -0400
Content-Disposition: inline
In-Reply-To: <561262D1.5070506@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Mon, Oct 05, 2015 at 01:45:21PM +0200, Daniel Lezcano wrote:
> On 10/03/2015 10:24 AM, Russell King wrote:
> >The cpuidle ->enter method expects the return value to be the sleep
> >state we entered.  Returning negative numbers or other codes is not
> >permissible since coupled CPU idle was merged.
> 
> 
> 
> >At least some of the mvebu_v7_cpu_suspend() implementations return the
> >value from cpu_suspend(), which returns zero if the CPU vectors back
> >into the kernel via cpu_resume() (the success case), or the non-zero
> >return value of the suspend actor, or one (failure cases).
> >
> >We do not want to be returning the failure case value back to CPU idle
> >as that indicates that we successfully entered one of the deeper idle
> >states.  Always return zero instead, indicating that we slept for the
> >shortest amount of time.
> >
> >Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >---
> >Please think about this - having only an Armada 388 platform, I can't
> >test this due to CPU idle being disabled there.  However, the code paths
> >indicate that if we fail to sleep in armada_370_xp_pmsu_idle_enter() or
> >armada_38x_do_cpu_suspend() fail to sleep, we end up reporting that we
> >successfully slept in CPU idle state 1 in both cases.
> >
> >Rafael - the code in cpuidle.c prior to the addition of coupled CPU idle
> >seems to allow the return of negative error numbers from the ->enter()
> >method:
> >
> >         if (entered_state >= 0) {
> >                 /* Update cpuidle counters */
> >                 /* This can be moved to within driver enter routine
> >                  * but that results in multiple copies of same code.
> >                  */
> >                 dev->states_usage[entered_state].time += dev->last_residency;
> >                 dev->states_usage[entered_state].usage++;
> >         } else {
> >                 dev->last_residency = 0;
> >         }
> >
> >Since coupled CPU idle, negative return codes will give a negative table
> >index inside cpuidle_state_is_coupled() - which is obviously buggy.  Does
> >this need fixing?  If so, this patch below is wrong, and we should be
> >returning a negative errno rather than zero on failure to enter a low
> >power state.
> 
> It is not possible since the commit 0b89e9aa2.
> 
> This change was to prevent to re-enable the local interrupt when we are in
> the process of coupling an idle state and let the coupled code to handle
> that.
> 
> If the backend driver changed the state in our back (for example to a
> shallower state) to a non coupled one, the local interrupt will be
> re-enabled. If at the contrary, the backend driver choose a deeper idle
> state which is coupled, we won't re-enable the interrupt. I don't know any
> driver doing this but the code allows it (not sure it is a good thing -
> anyway).
> 
> So the test:
> 
> if (!cpuidle_state_is_coupled(dev, drv, entered_state))
> 
> should be:
> 
> if (!cpuidle_state_is_coupled(dev, drv, *index*))
> 
> ... in order to have the decisions made when entering this function
> symmetric to the ones which will be taken when exiting the function because
> they will be based on the same index.

Is someone going to fix this seven month bug?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

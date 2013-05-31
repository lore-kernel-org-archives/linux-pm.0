From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 3/3] ARM: tegra114: cpuidle: add powered-down state
Date: Fri, 31 May 2013 19:44:40 +0800
Message-ID: <1370000680.7804.83.camel@jlo-ubuntu-64.nvidia.com>
References: <1369912782-30663-1-git-send-email-josephl@nvidia.com>
	 <1369912782-30663-4-git-send-email-josephl@nvidia.com>
	 <51A763BD.6070001@linaro.org>
	 <1369991550.7804.37.camel@jlo-ubuntu-64.nvidia.com>
	 <51A86D11.8060305@linaro.org>
	 <1369997278.7804.73.camel@jlo-ubuntu-64.nvidia.com>
	 <1369999870.7804.78.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:14389 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab3EaLoo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 31 May 2013 07:44:44 -0400
In-Reply-To: <1369999870.7804.78.camel@jlo-ubuntu-64.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

On Fri, 2013-05-31 at 19:31 +0800, Joseph Lo wrote:
> On Fri, 2013-05-31 at 18:47 +0800, Joseph Lo wrote:
> > On Fri, 2013-05-31 at 17:27 +0800, Daniel Lezcano wrote:
> > > On 05/31/2013 11:12 AM, Joseph Lo wrote:
> > > > Hi Daniel,
> > > > 
> > > > Thanks for your review.
> > > > 
> > > > On Thu, 2013-05-30 at 22:35 +0800, Daniel Lezcano wrote:
> > > >> On 05/30/2013 01:19 PM, Joseph Lo wrote:
> > > >>> This supports CPU core power down on each CPU when CPU idle. When CPU go
> > > >>> into this state, it saves it's context and needs a proper configuration
> > > >>> in flow controller to power gate the CPU when CPU runs into WFI
> > > >>> instruction. And the CPU also needs to set the IRQ as CPU power down idle
> > > >>> wake up event in flow controller.
> > > >>>
> > > >>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > > >>> ---
> > > >>
> > > >> Hi Joseph,
> > > >>
> > > >> a new flag has been added in the cpuidle framework to let this one to
> > > >> handle the timer broadcast : CPUIDLE_FLAG_TIMER_STOP
> > > >>
> > > >> It is the commit b60e6a0eb0273132cbb60a9806abf5f47a4aee1c
> > > >>
> > > >> You can get rid of the clockevent notify stuff by adding this flag to
> > > >> the state.
> > > >>
> > > > 
> > > > I just tested this flag on Tegra20, 30 and 114. It is only OK on
> > > > Tegra20. It caused a warning message below on Tegra30/114 at boot time.
> > > > 
> > > > I gave it a quick check I found it can't clean
> > > > tick_broadcast_pending_mask sometimes if apply the flag. But I keep the
> > > > code right now it's always OK. Not sure why? 
> > > 
> > > Is it possible you didn't intialized the timer broadcast with
> > > CLOCK_EVT_NOTIFY_BROADCAST_ON in the driver and then this one is
> > > actually disabled for you driver ?
> > > 
> > I found if I don't apply the CPUIDLE_FLAG_TIMER_STOP flag, the function
> > "cpuidle_setup_broadcast_timer" (drivers/cpuidle/driver.c) would not be
> > called. Then it's OK.
> > 
> > If I apply this flag (with no CONFIG_CPU_IDLE_MULTIPLE_DRIVERS), the
> > cpuidle_register_driver only register for CPU0. Then the
> > "cpuidle_setup_broadcast_timer" only turn on for CPU0. I think this
> > might be the root cause. Not sure this also can reproduce on the other
> > SoCs?
> > 
> Looks it's not related to CLOCK_EVT_NOTIFY_BROADCAST_ON. I still saw the
> warning message even enable CONFIG_CPU_IDLE_MULTIPLE_DRIVERS. But if I
> move the clockevent_notify of CLOCK_EVT_NOTIFY_BROADCAST_EXIT from idle
> framework back to driver, then everything is OK.
> 
Once I move the clockevent_notify of CLOCK_EVT_NOTIFY_BROADCAST_EXIT
right after "local_irq_enable" in the
"cpuidle_enter_state" (drivers/cpuidle/cpuidle.c). Then the warning
message shows up.



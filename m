From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/4][resend] cpuidle : handle clockevent notify from the
 cpuidle framework
Date: Thu, 21 Mar 2013 15:25:04 +0000
Message-ID: <20130321152502.GA7419@e102568-lin.cambridge.arm.com>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
 <514B0417.6020401@ti.com>
 <514B10AC.9090909@linaro.org>
 <514B1354.50506@ti.com>
 <514B1C06.6070401@linaro.org>
 <514B1EA5.20209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:49739 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab3CUPZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 11:25:12 -0400
In-Reply-To: <514B1EA5.20209@ti.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "patches@linaro.org" <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "rnayak@ti.com" <rnayak@ti.com>, "lenb@kernel.org" <lenb@kernel.org>

On Thu, Mar 21, 2013 at 02:52:21PM +0000, Santosh Shilimkar wrote:

[...]

> >>>> How about taking care of cpu_pm_notifiers() as well with some
> >>>> additional flag for CPU and cluster power state. That can help
> >>>> to reduce and consolidate the code. What you say ?
> >>>
> >>> Do you mean add a flag for different level of idle (idle, suspend, power
> >>> off) and then use the cpu_pm_enter/cpu_cluster_pm_enter in all the
> >>> drivers as a common framework ?
> >>>
> >> I mean only for CPUidle considering C-state already has the information
> >> about CPU and cluster power state. For suspend, we by-default run the notifiers
> >> so nothing needs to be done there.
> >>
> >> You may not even need a framework. Just like we know in a C-state, timer
> >> stops, same lines, we can say CPU state is going to be say off and hence
> >> cpu_pm_enter() notifier needs to be called. And same way for cluster.
> >>
> >> I still haven't given complete thought but thought crossed my mind
> >> after looking at your patches.
> > 
> > Right, that could be interesting.
> > 
> > I see may be one issue with this approach: when we enter an idle state
> > with power off, some checking are done before cpu_pm_enter and that
> > could lead to abort the current idle routine.
> > 
> I see your point.
> 
> > By moving this to the cpuidle framework, we will invoke always
> > cpu_pm_enter/exit even if the idle enter routine failed.
> > 
> If we at all decide to go on this path, we can always get around the
> issues. The key is these notifiers have to be run very close to the
> low power entry/exit since the saved context for CPU/CPU cluster
> at wrong points would lead to many issues.
> 
> > But, IMO, the idea is good.
> > 
> > For example in cpuidle34xx:
> > 
> > static int __omap3_enter_idle(struct cpuidle_device *dev,
> >                                 struct cpuidle_driver *drv,
> >                                 int index)
> > {
> >         struct omap3_idle_statedata *cx = &omap3_idle_data[index];
> > 
> >         local_fiq_disable();
> > 
> >         if (omap_irq_pending() || need_resched())
> >                 goto return_sleep_time;
> > 
> > 	...
> > 
> >         if (cx->mpu_state == PWRDM_POWER_OFF)
> >                 cpu_pm_enter();
> > 
> > 	...
> > }
> > 
> > The same for omap4 and tegra2/3.
> > 
> > With your knowledge of omap, do you think it is possible to move
> > cpu_pm_enter before entering the idle routine ?
> > 
> I will get back on this topic after some experiments most likely
> by next week.

Looks like the way to go, we could enhance the notifiers to be able to
save/restore specific subsystems with the C-state flags defining which
ones.

Notifiers actions should not be disruptive so the only drawback in
executing those before entering the idle routine could possibly be
a waste of cycles in case the C-state entry fails but certainly something
to verify on all platforms using them.

Lorenzo


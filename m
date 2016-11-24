From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] drivers: cpuidle: assign enter_freeze to same as enter callback function
Date: Thu, 24 Nov 2016 02:15:41 +0100
Message-ID: <27933980.8pxBHcNLmE@vostro.rjw.lan>
References: <1478713410-10727-1-git-send-email-sudeep.holla@arm.com> <1478787873-18180-1-git-send-email-sudeep.holla@arm.com> <e79767a7-03be-2073-b78e-3ec8d29d5f8a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56577 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935632AbcKXBHy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 20:07:54 -0500
In-Reply-To: <e79767a7-03be-2073-b78e-3ec8d29d5f8a@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Andy Gross <andy.gross@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Tuesday, November 15, 2016 02:20:21 PM Sudeep Holla wrote:
> Hi Rafael,
> 
> On 10/11/16 14:24, Sudeep Holla wrote:
> > enter_freeze() callback is expected atleast to do the same as enter()
> > but it has to guarantee that interrupts aren't enabled at any point
> > in its execution, as the tick is frozen.
> >
> > CPUs execute ->enter_freeze with the local tick or entire timekeeping
> > suspended, so it must not re-enable interrupts at any point (even
> > temporarily) or attempt to change states of clock event devices.
> >
> > It will be called when the system goes to suspend-to-idle and will
> > reduce power usage because CPUs won't be awaken for unnecessary IRQs
> > (i.e. woken up only on IRQs from "wakeup sources")
> >
> > We can reuse the same code for both the enter() and enter_freeze()
> > callbacks as along as they don't re-enable interrupts. Only "coupled"
> > cpuidle mechanism enables interrupts and doing that with timekeeping
> > suspended is generally not safe.
> >
> > Since this generic DT based idle driver doesn't support "coupled"
> > states, it is safe to assume that the interrupts are not re-enabled.
> >
> > This patch assign enter_freeze to same as enter callback function which
> > helps to save power without any intermittent spurious wakeups from
> > suspend-to-idle.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpuidle/dt_idle_states.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > v1->v2:
> > 	- Dropped checking and using only states with CPUIDLE_FLAG_TIMER_STOP
> > 	  enabled.
> >
> 
> Can you pick up this patch directly if there are no concerns ?

There were none, so it's been queued up for 4.10.

Thanks,
Rafael


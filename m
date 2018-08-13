From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RESEND PATCH v1 1/2] cpuidle: menu: Correct the criteria for
 stopping tick
Date: Mon, 13 Aug 2018 10:01:20 +0200
Message-ID: <CAJZ5v0g-ZaUe1AJ=4tixtacaGB-roMXLXj5HNHBqMk+jf3aYnA@mail.gmail.com>
References: <1533835203-5789-1-git-send-email-leo.yan@linaro.org>
 <1533835203-5789-2-git-send-email-leo.yan@linaro.org> <CAJZ5v0hU3Qp3ycJ=aGHtPMMC_6A+XsByYALYN22dz2VJ1Z0MgQ@mail.gmail.com>
 <20180810071321.GC11817@leoy-ThinkPad-X240s> <CAJZ5v0iyGFFDO83KGcET9a+UpPCDQ=_sxZeGxuG6fL4O+hcw+w@mail.gmail.com>
 <20180810084906.GD11817@leoy-ThinkPad-X240s> <20180810090327.GE11817@leoy-ThinkPad-X240s>
 <CAJZ5v0gM+PNnMH=Myn5yRLYg4SVV3JnF-htO_gueJp4odivT6w@mail.gmail.com> <20180812160740.GC28966@leoy-ThinkPad-X240s>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180812160740.GC28966@leoy-ThinkPad-X240s>
Sender: linux-kernel-owner@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 12, 2018 at 6:07 PM <leo.yan@linaro.org> wrote:
>
> On Sun, Aug 12, 2018 at 01:12:41PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 10, 2018 at 11:03 AM <leo.yan@linaro.org> wrote:

[cut]

> >
> > Assuming shot noise wakeups, if
> > drv->states[drv->state_count-1].target_residency is less than
> > TICK_USEC, the tick will be stopped for CPUs more often on average
> > with the patch applied (simply because the idle duration range for
> > which it will not be stopped is narrower then).
>
> Yes, good point, so in the new approach I try to change the code
> to compare with next tick delta rather than TICK_USEC, it can keeps
> running tick for the tick with long expire time (similiar with
> comparing with TICK_USEC) but we also can stop tick if the tick is likely
> to break idle residency.

We tried something similar and the results were not encouraging.
Please see https://lore.kernel.org/lkml/079e16b6-2e04-2518-0553-66becab226a6@tu-dresden.de/

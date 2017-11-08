From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Tue, 7 Nov 2017 17:04:28 -0800
Message-ID: <20171108010428.GT28152@atomide.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <4931157.VlYOOLbas7@aspire.rjw.lan>
 <952312f9-2c26-58bc-e34f-76ab1fb5f05d@gmail.com>
 <1827289.ayaZCGrVNF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1827289.ayaZCGrVNF@aspire.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ckeepax@opensource.wolfsonmicro.com, swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [171108 00:47]:
> On Wednesday, November 8, 2017 1:28:24 AM CET Florian Fainelli wrote:
> > On 11/07/2017 04:23 PM, Rafael J. Wysocki wrote:
> > > On Tuesday, November 7, 2017 5:00:06 PM CET Tony Lindgren wrote:
> > >> * Florian Fainelli <f.fainelli@gmail.com> [171104 17:21]:
> > >>>
> > >>>
> > >>> On 11/04/2017 05:25 AM, Rafael J. Wysocki wrote:
> > >>>> On Friday, November 3, 2017 6:33:53 PM CET Tony Lindgren wrote:
> > >>>>> * Florian Fainelli <f.fainelli@gmail.com> [171103 17:04]:
> > >>>>>> On 11/03/2017 09:11 AM, Tony Lindgren wrote:
> > >>>>>> The pinctrl provider is losing its state, hence these two patches.
> > >>>>>
> > >>>>> OK
> > >>>>>
> > >>>>>>> Anyways, the context lost flag should be managed in the PM core for
> > >>>>>>> the device, so adding linux-pm and Rafael to Cc.
> > >>>>>>
> > >>>>>> I don't think it's that simple but sure, why not.
> > >>>>>
> > >>>>> Just having bool context_lost in struct dev_pm_info would probably
> > >>>>> be enough to allow drivers to deal with it. This flag could then
> > >>>>> be set for a device by power domain related code that knows if
> > >>>>> context got lost.
> > >>>>
> > >>>> Something like: if the driver sees "context_lost" set, it should restore
> > >>>> the context to the device from memory?
> > >>>
> > >>> That is what is being proposed here, except that the actual mechanism
> > >>> where this matters needs to be in the core pinctrl code, otherwise the
> > >>> state (context) is not restored due to a check that attempts not to
> > >>> (re)apply a previous state.
> > >>>
> > >>>>
> > >>>> But the it would also need to save the context beforehand, so why not to
> > >>>> restore it unconditionally on resume?
> > >>>
> > >>> That's what my original attempts did here:
> > >>>
> > >>> https://patchwork.kernel.org/patch/9598969/
> > >>>
> > >>> but Linus rightfully requested this to be done differently, hence this
> > >>> attempt now to solve it in a slightly more flexible way based on DT
> > >>> properties.
> > >>
> > >> For runtime PM, restoring the state constantly is unnecessary and not
> > >> good for battery life. The logic can be just:
> > >>
> > >> 1. Device driver runtime PM suspend saves the state when needed
> > >>
> > >> 2. Device driver runtime PM resume checks if context_lost was set by
> > >>    the bus or power domain code
> > >>
> > >> 3. If context was lost, device driver restores the state, or in some
> > >>    cases may need re-run the driver register init related parts
> > >>    to bring the driver back up, then clears the context_lost flag
> > >>
> > >> How about something like the following patch? So far only compile
> > >> tested with CONFIG_PM enabled. If that looks like the way to go,
> > >> I'll test it properly and add some comments for the functions and
> > >> post a proper patch :)
> > > 
> > > Honestly, I'm not sure.
> > > 
> > > I'd rather have a context_lost flag to start with and see how/if
> > > drivers will use that before adding any common infra for handling
> > > this.
> > 
> > I am afraid we are being slightly side tracked here on this context_loss
> > flag, because the crux of the problem is not whether a driver knows or
> > not when it loses state, it's more than the pinctrl core refuses to
> > re-apply the same state upon resumption even when the consumer driver
> > tells it to, because it has not seen a transition (consider it as a
> > stale software cache of the state), and there is only one state defined.
> > 
> > I don't particularly care how its gets solved, at the generic device
> > driver model or at the pinctrl level, but I think the pinctrl code needs
> > to change in that regard no matter what we do, because right now, if you
> > call pinctrl_select_state() in your driver's resume function, and there
> > is only one state defined, nothing happens, that's a problem.
> 
> I see, thanks for explaining that clearly.
> 
> Then it looks like that there needs to be a way for the "cached" state to be
> invalidated and the question is what that way should be and how it is going to
> be triggered.

Yeah seems like that issue needs to be solved at the pinctrl level
even if the drivers were using a generic state for the context
lost for figuring out when to do it.

Regards,

Tony

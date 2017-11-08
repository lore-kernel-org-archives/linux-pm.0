From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Tue, 7 Nov 2017 17:02:22 -0800
Message-ID: <20171108010222.GS28152@atomide.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <7091cb38-e55b-fa20-114e-bd77950ea912@gmail.com>
 <20171107160006.GQ28152@atomide.com>
 <4931157.VlYOOLbas7@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4931157.VlYOOLbas7@aspire.rjw.lan>
Sender: linux-gpio-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ckeepax@opensource.wolfsonmicro.com, swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

* Rafael J. Wysocki <rjw@rjwysocki.net> [171108 00:25]:
> On Tuesday, November 7, 2017 5:00:06 PM CET Tony Lindgren wrote:
> > For runtime PM, restoring the state constantly is unnecessary and not
> > good for battery life. The logic can be just:
> > 
> > 1. Device driver runtime PM suspend saves the state when needed
> > 
> > 2. Device driver runtime PM resume checks if context_lost was set by
> >    the bus or power domain code
> > 
> > 3. If context was lost, device driver restores the state, or in some
> >    cases may need re-run the driver register init related parts
> >    to bring the driver back up, then clears the context_lost flag
> > 
> > How about something like the following patch? So far only compile
> > tested with CONFIG_PM enabled. If that looks like the way to go,
> > I'll test it properly and add some comments for the functions and
> > post a proper patch :)
> 
> Honestly, I'm not sure.
> 
> I'd rather have a context_lost flag to start with and see how/if
> drivers will use that before adding any common infra for handling
> this.

Right, I'll provide some use cases but it will be a little while.

Currently it's done in non-generic way at the interconnect code
for my use cases:

$ git grep "\.context_offs = " arch/arm/mach-omap2/*data.c | wc -l
276

It seems that we could have genpd take care of this in a generic
way with the patch I posted.

Regards,

Tony

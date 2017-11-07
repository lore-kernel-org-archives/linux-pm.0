From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Tue, 7 Nov 2017 08:00:47 -0800
Message-ID: <20171107160047.GR28152@atomide.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <20171103103707.3e5wb3c7foxbuvvg@localhost.localdomain>
 <20171103161120.GH28152@atomide.com>
 <da808465-dc64-6c33-0be6-e038e0f84bce@gmail.com>
 <20171103173353.GJ28152@atomide.com>
 <20171104083707.gtmnhbrzlqjulwe4@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171104083707.gtmnhbrzlqjulwe4-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

* Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org> [171104 08:38]:
> On Fri, Nov 03, 2017 at 10:33:53AM -0700, Tony Lindgren wrote:
> > * Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [171103 17:04]:
> > > On 11/03/2017 09:11 AM, Tony Lindgren wrote:
> > > The pinctrl provider is losing its state, hence these two patches.
> > 
> > OK
> > 
> > > > Anyways, the context lost flag should be managed in the PM core for
> > > > the device, so adding linux-pm and Rafael to Cc.
> > > 
> > > I don't think it's that simple but sure, why not.
> > 
> > Just having bool context_lost in struct dev_pm_info would probably
> > be enough to allow drivers to deal with it. This flag could then
> > be set for a device by power domain related code that knows if
> > context got lost.
> > 
> > Anybody got better ideas?
> > 
> 
> Should the provider driver not know its state will be lost since
> will have had its PM ops called, and it should be aware of the
> state it was in. So doesn't it just need to restore that state on
> resume? Feels a bit like we are over complicating this here.
> Apologies if I am missing some here.

Well any driver can lose context depending on the hardare, this
could be both the pinctrl provider and the pinctrl consumer drivers :)

If your pinctrl provider driver knows when it lost context and
knows when to restore it, then no generic code is needed
necessarily for your use case.

But as the drivers themselves are not aware themselves when they
lost context without checking that all registers are initialized
properly, I think we need something generic for tracking the context
lost. Typically it's the power domain hardware that knows when
context was lost.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

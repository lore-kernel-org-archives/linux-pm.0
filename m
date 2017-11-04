From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across suspend/resume
Date: Sat, 04 Nov 2017 13:25:43 +0100
Message-ID: <2452741.VnAOAIxsj2@aspire.rjw.lan>
References: <20171102231551.16220-1-f.fainelli@gmail.com> <da808465-dc64-6c33-0be6-e038e0f84bce@gmail.com> <20171103173353.GJ28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171103173353.GJ28152-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AA4QjBA90+/kJqQE7yCjDx5@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Friday, November 3, 2017 6:33:53 PM CET Tony Lindgren wrote:
> * Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [171103 17:04]:
> > On 11/03/2017 09:11 AM, Tony Lindgren wrote:
> > The pinctrl provider is losing its state, hence these two patches.
> 
> OK
> 
> > > Anyways, the context lost flag should be managed in the PM core for
> > > the device, so adding linux-pm and Rafael to Cc.
> > 
> > I don't think it's that simple but sure, why not.
> 
> Just having bool context_lost in struct dev_pm_info would probably
> be enough to allow drivers to deal with it. This flag could then
> be set for a device by power domain related code that knows if
> context got lost.

Something like: if the driver sees "context_lost" set, it should restore
the context to the device from memory?

But the it would also need to save the context beforehand, so why not to
restore it unconditionally on resume?

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

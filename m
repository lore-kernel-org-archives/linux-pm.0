From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Mon, 17 Nov 2014 21:37:37 +0100
Message-ID: <1618855.DXsjWXLqau@wuerfel>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com> <1600093.60yAP0Qpua@wuerfel> <7h389h3aif.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7h389h3aif.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Monday 17 November 2014 11:14:16 Kevin Hilman wrote:
> >> 
> >> So, The Keystone 2 Generic PM Controller is just a proxy PM layer here between
> >> device and Generic clock manipulation PM callbacks.
> >> It fills per-device clock list when device is attached to GPD and
> >> ensures that all clocks from that list enabled/disabled when device is
> >> started/stopped.
> >
> > The idea of such a generic power domain implementation sounds useful, but
> > it has absolutely no business in platform specific code.
> 
> Yes it does.  This isn't a generic power domain implementation, but
> rather just the platform-specific glue that hooks up the clocks to the
> right devices and power-domains so that the generic power-domain and
> generic pm_clocks code does the right thing.

How would you do this on an arm64 version of keystone then? With
the current approach, you'd need to add a machine specific directory,
and that seems completely pointless since this is not even about
a hardware requirement.

> > I suggest you either remove the power domain proxy from your drivers
> > and use the clocks directly, 
> 
> No.  That's a step in the wrong direction.  This change isn't affecting
> drivers directly.  It's the runtime PM and generic power domain layers
> that handle this, and runtime PM adapted drivers don't need any changes.
>  
> > or come up with an implementation that can be used across other
> > platforms and CPU architectures.
> 
> We already have those in the generic power domain and the pm_clock
> layers.  This series is just hooking those up for Keystone.

Then why not add the missing piece to the generic power domain
code to avoid having to add infrastructure to the platform
for it?

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

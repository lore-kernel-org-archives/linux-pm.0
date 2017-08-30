From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: r7s72100: Add reset handler
Date: Wed, 30 Aug 2017 17:57:10 +0200
Message-ID: <20170830155700.GA28162@verge.net.au>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-4-chris.brandt@renesas.com>
 <CAMuHMdVMBo9fNMTqz_XdU27FF5TX98r-OE5pJ5atJ1s4XLxcTw@mail.gmail.com>
 <20170830082940.GR10398@verge.net.au>
 <SG2PR06MB1165B8B815327A6768AE681A8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165B8B815327A6768AE681A8A9C0-ESzmfEwOt/xoAsOJh7vwSm0DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Watchdog Mailing List <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 30, 2017 at 01:22:32PM +0000, Chris Brandt wrote:
> Hi Simon,
> 
> On Wednesday, August 30, 2017, Simon Horman wrote:
> > On Fri, Feb 17, 2017 at 11:29:25AM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 16, 2017 at 6:23 PM, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > wrote:
> > > > For the RZ/A1, the only way to do a reset is to overflow the WDT.
> > > >
> > > > Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> > 
> > Hi Chris,
> > 
> > while going through old patches I noticed that I seem to have missed this
> > one. It looks like it needs a rebase. If it is still applicable could you
> > please consider doing so and reposting.
> 
> 
> It's in -next already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/r7s72100.dtsi?h=next-20170829&id=69ed50de582eff6307fd3fa050fdc505731f0a2d
> 
> Doesn't that mean it's queued up for 4.14?
> 
> Or, somehow it didn't make it into the pull request for Arnd's tree?

Thanks, I now see that it is included in v4.12.
Sorry for the noise.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

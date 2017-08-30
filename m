From: Chris Brandt <Chris.Brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH v2 3/3] ARM: dts: r7s72100: Add reset handler
Date: Wed, 30 Aug 2017 13:22:32 +0000
Message-ID: <SG2PR06MB1165B8B815327A6768AE681A8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-4-chris.brandt@renesas.com>
 <CAMuHMdVMBo9fNMTqz_XdU27FF5TX98r-OE5pJ5atJ1s4XLxcTw@mail.gmail.com>
 <20170830082940.GR10398@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830082940.GR10398-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Watchdog Mailing List <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Wednesday, August 30, 2017, Simon Horman wrote:
> On Fri, Feb 17, 2017 at 11:29:25AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 16, 2017 at 6:23 PM, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org=
>
> wrote:
> > > For the RZ/A1, the only way to do a reset is to overflow the WDT.
> > >
> > > Signed-off-by: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>=20
> Hi Chris,
>=20
> while going through old patches I noticed that I seem to have missed this
> one. It looks like it needs a rebase. If it is still applicable could you
> please consider doing so and reposting.


It's in -next already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
arch/arm/boot/dts/r7s72100.dtsi?h=3Dnext-20170829&id=3D69ed50de582eff6307fd=
3fa050fdc505731f0a2d

Doesn't that mean it's queued up for 4.14?

Or, somehow it didn't make it into the pull request for Arnd's tree?


Chris
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

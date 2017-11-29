From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH] PM / runtime: Drop children check from
 __pm_runtime_set_status()
Date: Wed, 29 Nov 2017 08:21:22 +0000
Message-ID: <TY1PR06MB0992899AE427576E3F83CF54D83B0@TY1PR06MB0992.apcprd06.prod.outlook.com>
References: <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
 <Pine.LNX.4.44L0.1711281004170.1467-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1711281004170.1467-100000@iolanthe.rowland.org>
Content-Language: ja-JP
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> From: Alan Stern, Sent: Wednesday, November 29, 2017 12:07 AM
>=20
> On Tue, 28 Nov 2017, Yoshihiro Shimoda wrote:
>=20
> > Hi Geert-san,
> >
> > > From: Geert Uytterhoeven, Sent: Tuesday, November 28, 2017 7:58 PM
> > >
> > > Hi Rafael, Shimoda-san,
> > >
> > > On Sun, Nov 12, 2017 at 1:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net=
> wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
<snip>
> > > JFTR, this triggered before during system resume on e.g. Salvator-XS =
with
> > > R-Car H3:
> > >
> > >     ohci-platform ee080000.usb: runtime PM trying to suspend device
> > > but active child
> > >     phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend
> > > device but active child
> > >     ohci-platform ee0c0000.usb: runtime PM trying to suspend device
> > > but active child
> > >     ohci-platform ee0a0000.usb: runtime PM trying to suspend device
> > > but active child
> > >     phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend
> > > device but active child
> > >     phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend
> > > device but active child
> > >
> > > so this was an existing issue with USB before.
> >
> > Thank you for the report!
> > I know that, but since this didn't cause any trouble until now,
> > I postponed to investigate the issue... But, I investigate it today.
> > I don't find the root cause yet. However, it seems related to usb host =
and/or usb core.
> > --> USB host related devices' child_count will be 1 in suspend timing.
> >  --> I guess remote wakeup feature is enabled? But, I don't find the po=
int yet.
> >
> > The renesas_usbhs also uses the phy_rcar_gen3_usb2 driver.

I'm so sorry, but this is mistake.
The renesas_usbhs doesn't use the phy_rcar_gen3_usb2 driver.
So,

> > --> If I only used the renesas_usbhs driver (in other words, I don't in=
stall
> >     [eo]hci-{hcd,platform} drivers), the issue disappeared.
> >  --> So, I think the phy_rcar_gen3_usb2 driver doesn't cause this issue=
.
> >     (But, it is possible to be related though.)

They are also mistake.

> > I'll continue to investigate this issue tomorrow.
>=20
> Does the phy_rcar_gen3_usb2 driver use runtime PM?

Yes, the phy_rcar_gen3_usb2 uses runtime PM.

>  It looks like the
> phy device somehow gets enabled for runtime PM when it shouldn't be.

I also think that now.
I don't find why for now, but the usage_count of a phy device was not 1 jus=
t before suspend.
(This "a phy device" means the child of ee0a0200.usb-phy device.)

> (And by the way, what device is the child of ee0a0200.usb-phy?)

It's a phy device:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/phy/phy-core.c?h=3Dv4.15-rc1#n773

Best regards,
Yoshihiro Shimoda

> Alan Stern

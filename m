From: Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 28 Nov 2017 10:06:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1711281004170.1467-100000@iolanthe.rowland.org>
References: <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY1PR06MB09928D43D4E5E5752A6A604ED83A0@TY1PR06MB0992.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, USB list <linux-usb@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Nov 2017, Yoshihiro Shimoda wrote:

> Hi Geert-san,
> 
> > From: Geert Uytterhoeven, Sent: Tuesday, November 28, 2017 7:58 PM
> > 
> > Hi Rafael, Shimoda-san,
> > 
> > On Sun, Nov 12, 2017 at 1:27 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The check for "active" children in __pm_runtime_set_status(), when
> > > trying to set the parent device status to "suspended", doesn't
> > > really make sense, because in fact it is not invalid to set the
> > > status of a device with runtime PM disabled to "suspended" in any
> > > case.  It is invalid to enable runtime PM for a device with its
> > > status set to "suspended" while its child_count reference counter
> > > is nonzero, but the check in __pm_runtime_set_status() doesn't
> > > really cover that situation.
> > >
> > > For this reason, drop the children check from __pm_runtime_set_status()
> > > and add a check against child_count reference counters of "suspended"
> > > devices to pm_runtime_enable().
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/base/power/runtime.c |   30 ++++++++++--------------------
> > >  1 file changed, 10 insertions(+), 20 deletions(-)
> > >
> > > Index: linux-pm/drivers/base/power/runtime.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > +++ linux-pm/drivers/base/power/runtime.c
> > > @@ -1101,29 +1101,13 @@ int __pm_runtime_set_status(struct devic
> > >                 goto out;
> > >         }
> > >
> > > -       if (dev->power.runtime_status == status)
> > > +       if (dev->power.runtime_status == status || !parent)
> > >                 goto out_set;
> > >
> > >         if (status == RPM_SUSPENDED) {
> > > -               /*
> > > -                * It is invalid to suspend a device with an active child,
> > > -                * unless it has been set to ignore its children.
> > > -                */
> > > -               if (!dev->power.ignore_children &&
> > > -                       atomic_read(&dev->power.child_count)) {
> > > -                       dev_err(dev, "runtime PM trying to suspend device but active child\n");
> > 
> > JFTR, this triggered before during system resume on e.g. Salvator-XS with
> > R-Car H3:
> > 
> >     ohci-platform ee080000.usb: runtime PM trying to suspend device
> > but active child
> >     phy_rcar_gen3_usb2 ee080200.usb-phy: runtime PM trying to suspend
> > device but active child
> >     ohci-platform ee0c0000.usb: runtime PM trying to suspend device
> > but active child
> >     ohci-platform ee0a0000.usb: runtime PM trying to suspend device
> > but active child
> >     phy_rcar_gen3_usb2 ee0c0200.usb-phy: runtime PM trying to suspend
> > device but active child
> >     phy_rcar_gen3_usb2 ee0a0200.usb-phy: runtime PM trying to suspend
> > device but active child
> > 
> > so this was an existing issue with USB before.
> 
> Thank you for the report!
> I know that, but since this didn't cause any trouble until now,
> I postponed to investigate the issue... But, I investigate it today.
> I don't find the root cause yet. However, it seems related to usb host and/or usb core.
> --> USB host related devices' child_count will be 1 in suspend timing.
>  --> I guess remote wakeup feature is enabled? But, I don't find the point yet.
> 
> The renesas_usbhs also uses the phy_rcar_gen3_usb2 driver.
> --> If I only used the renesas_usbhs driver (in other words, I don't install
>     [eo]hci-{hcd,platform} drivers), the issue disappeared.
>  --> So, I think the phy_rcar_gen3_usb2 driver doesn't cause this issue.
>     (But, it is possible to be related though.)
> 
> I'll continue to investigate this issue tomorrow.

Does the phy_rcar_gen3_usb2 driver use runtime PM?  It looks like the 
phy device somehow gets enabled for runtime PM when it shouldn't be.

(And by the way, what device is the child of ee0a0200.usb-phy?)

Alan Stern

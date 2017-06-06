From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v14 4/7] usb: core: add power sequence handling for USB
 devices
Date: Tue, 6 Jun 2017 09:32:17 +0800
Message-ID: <20170606013217.GA26189@b29397-desktop>
References: <20170605065537.GE20014@b29397-desktop>
 <Pine.LNX.4.44L0.1706051013300.1795-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:21728
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751107AbdFFBc1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jun 2017 21:32:27 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1706051013300.1795-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, dbaryshkov@gmail.com, mark.rutland@arm.com, heiko@sntech.de, stephen.boyd@linaro.org, frank.li@nxp.com, gary.bisson@boundarydevices.com, festevam@gmail.com, stillcompiling@gmail.com, arnd@arndb.de, vaibhav.hiremath@linaro.org, krzk@kernel.org, mka@chromium.org, devicetree@vger.kernel.org, mail@maciej.szmigiero.name, pawel.moll@arm.com, Linux-pm mailing list <linux-pm@vger.kernel.org>, s.hauer@pengutronix.de, troy.kisky@boundarydevices.com, linux-arm-kernel@lists.infradead.org, hverkuil@xs4all.nl, oscar@naiandei.net, USB

On Mon, Jun 05, 2017 at 10:16:34AM -0400, Alan Stern wrote:
> On Mon, 5 Jun 2017, Peter Chen wrote:
> 
> > On Thu, May 18, 2017 at 08:49:00AM +0800, Peter Chen wrote:
> > > Some hard-wired USB devices need to do power sequence to let the
> > > device work normally, the typical power sequence like: enable USB
> > > PHY clock, toggle reset pin, etc. But current Linux USB driver
> > > lacks of such code to do it, it may cause some hard-wired USB devices
> > > works abnormal or can't be recognized by controller at all.
> > > 
> > > In this patch, it calls power sequence library APIs to finish
> > > the power sequence events. It will do power on sequence at hub's
> > > probe for all devices under this hub (includes root hub).
> > > At hub_disconnect, it will do power off sequence which is at powered
> > > on list.
> > > 
> > 
> > Greg, Alan, would you please help on reviewing it? It seems Rafael
> > is waiting for USB MAINTAINERS's comments or ack. It resolves some
> > USB HUB issues for several persons.
> > 
> > Peter
> > 
> > > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > > Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > Reviewed-by: Vaibhav Hiremath <hvaibhav.linux@gmail.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> > > ---
> > >  drivers/usb/Kconfig    |  1 +
> > >  drivers/usb/core/hub.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
> > >  drivers/usb/core/hub.h |  1 +
> > >  3 files changed, 47 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > > index 939a63b..b6f626e 100644
> > > --- a/drivers/usb/Kconfig
> > > +++ b/drivers/usb/Kconfig
> > > @@ -39,6 +39,7 @@ config USB
> > >  	tristate "Support for Host-side USB"
> > >  	depends on USB_ARCH_HAS_HCD
> > >  	select USB_COMMON
> > > +	select POWER_SEQUENCE
> > >  	select NLS  # for UTF-8 strings
> > >  	---help---
> > >  	  Universal Serial Bus (USB) is a specification for a serial bus
> > > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > > index 9dca59e..7a67296 100644
> > > --- a/drivers/usb/core/hub.c
> > > +++ b/drivers/usb/core/hub.c
> > > @@ -28,6 +28,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/random.h>
> > >  #include <linux/pm_qos.h>
> > > +#include <linux/power/pwrseq.h>
> > >  
> > >  #include <linux/uaccess.h>
> > >  #include <asm/byteorder.h>
> > > @@ -1619,6 +1620,7 @@ static void hub_disconnect(struct usb_interface *intf)
> > >  	hub->error = 0;
> > >  	hub_quiesce(hub, HUB_DISCONNECT);
> > >  
> > > +	of_pwrseq_off_list(&hub->pwrseq_on_list);
> 
> Things like this look a little peculiar -- you are passing an "on_list" 
> to a function named "...off_list".
> 
> How about naming the new field hub->pwrseq_list instead?
> 

Thanks, Alan. I will change it at next revision.

-- 

Best Regards,
Peter Chen

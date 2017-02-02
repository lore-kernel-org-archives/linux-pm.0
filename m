From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / docs: linux/pm.h kerneldocs update and conversion of two docs to reST
Date: Thu, 02 Feb 2017 01:06:59 +0100
Message-ID: <21248446.r6y1HENFuA@aspire.rjw.lan>
References: <17467778.bsRBpnPicc@aspire.rjw.lan> <20170109013439.GA23364@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52740 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750896AbdBBALl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2017 19:11:41 -0500
In-Reply-To: <20170109013439.GA23364@wunner.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

On Monday, January 09, 2017 02:34:39 AM Lukas Wunner wrote:
> On Fri, Jan 06, 2017 at 02:38:13AM +0100, Rafael J. Wysocki wrote:
> > I sent patches [1-2/3] previosly a couple of weeks ago and there have not
> > been any comments since then, so either they are fine by everybody or the
> > timing was particularly bad and no one had the time to look at them.
> 
> So far I was only able to peruse the "Device Power Management Data Types"
> section (which is generated from include/linux/pm.h) and came across the
> following:
> 
> The description for the ->prepare hook says:
> 
> 	If the transition is a suspend to memory or standby (that
>         is, not related to hibernation), the return value of @prepare() may be
>         used to indicate to the PM core to leave the device in runtime suspend
>         if applicable.
> 
> Maybe I'm missing something

You are.  Please see device_prepare().

> but in the places where the direct_complete
> flag is calculated (e.g. in pci_dev_keep_suspended()) or where it's checked,
> I don't see that we're differentiating anywhere whether we're going through
> a suspend-to-RAM versus suspend-to-disk transition.  So in the above snippet,
> the portion "If the transition is a suspend to memory or standby (that is,
> not related to hibernation)" seems wrong and should probably be removed.
> 
> I know you're not touching this paragraph in the present commits, it's just
> something that caught my eye while going over the rendered output.
> 
> 
> Furthermore, the description for the ->freeze hook says:
> 
>         Analogous to @suspend(), but it should not enable the device to signal
>         wakeup events or change its power state.
> 
> However looking at the PCI core it looks like this constraint isn't
> satisfied, pci_dev_keep_suspended() (which gets called from ->prepare)
> disables PME only if:
> 
>         if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
>             !device_may_wakeup(dev))
>                 __pci_pme_active(pci_dev, false);
> 
> Shouldn't this be something like:
> 
>         if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
>             (!device_may_wakeup(dev) || (system_entering_hibernation() &&
> 					 system_state != SYSTEM_POWER_OFF)))
>                 __pci_pme_active(pci_dev, false);
> 
> So that PME is disabled before entering the freeze phase for direct_complete
> devices, but not before entering the poweroff phase.

It should be safe to leave PME as is for the non-poweroff phases of hibernation,
which is why the code is the way it is.

Besides, this comment is about ->freeze, not about ->prepare. :-)

Thanks,
Rafael


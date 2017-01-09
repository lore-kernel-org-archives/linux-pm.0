From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 0/3] PM / docs: linux/pm.h kerneldocs update and
 conversion of two docs to reST
Date: Mon, 9 Jan 2017 02:34:39 +0100
Message-ID: <20170109013439.GA23364@wunner.de>
References: <17467778.bsRBpnPicc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <17467778.bsRBpnPicc@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 06, 2017 at 02:38:13AM +0100, Rafael J. Wysocki wrote:
> I sent patches [1-2/3] previosly a couple of weeks ago and there have not
> been any comments since then, so either they are fine by everybody or the
> timing was particularly bad and no one had the time to look at them.

So far I was only able to peruse the "Device Power Management Data Types"
section (which is generated from include/linux/pm.h) and came across the
following:

The description for the ->prepare hook says:

	If the transition is a suspend to memory or standby (that
        is, not related to hibernation), the return value of @prepare() may be
        used to indicate to the PM core to leave the device in runtime suspend
        if applicable.

Maybe I'm missing something but in the places where the direct_complete
flag is calculated (e.g. in pci_dev_keep_suspended()) or where it's checked,
I don't see that we're differentiating anywhere whether we're going through
a suspend-to-RAM versus suspend-to-disk transition.  So in the above snippet,
the portion "If the transition is a suspend to memory or standby (that is,
not related to hibernation)" seems wrong and should probably be removed.

I know you're not touching this paragraph in the present commits, it's just
something that caught my eye while going over the rendered output.


Furthermore, the description for the ->freeze hook says:

        Analogous to @suspend(), but it should not enable the device to signal
        wakeup events or change its power state.

However looking at the PCI core it looks like this constraint isn't
satisfied, pci_dev_keep_suspended() (which gets called from ->prepare)
disables PME only if:

        if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
            !device_may_wakeup(dev))
                __pci_pme_active(pci_dev, false);

Shouldn't this be something like:

        if (pm_runtime_suspended(dev) && pci_dev->current_state < PCI_D3cold &&
            (!device_may_wakeup(dev) || (system_entering_hibernation() &&
					 system_state != SYSTEM_POWER_OFF)))
                __pci_pme_active(pci_dev, false);

So that PME is disabled before entering the freeze phase for direct_complete
devices, but not before entering the poweroff phase.

Thanks,

Lukas

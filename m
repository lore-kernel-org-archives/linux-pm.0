From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/5] PCI: Avoid unnecessary resume on shutdown
Date: Sat, 24 Sep 2016 02:50:05 +0200
Message-ID: <19951801.HyPAFRyVuO@vostro.rjw.lan>
References: <cover.1474130360.git.lukas@wunner.de> <1474276343.2044.4.camel@suse.com> <20160919101402.GA2506@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20160919101402.GA2506@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Oliver Neukum <oneukum@suse.com>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday, September 19, 2016 12:14:02 PM Lukas Wunner wrote:
> On Mon, Sep 19, 2016 at 11:12:23AM +0200, Oliver Neukum wrote:
> > On Sun, 2016-09-18 at 05:39 +0200, Lukas Wunner wrote:
> > > We currently perform a mandatory runtime resume of all PCI devices on
> > > ->shutdown.  However it is pointless to wake devices only to immediately
> > > power them down afterwards.  (Or have the firmware reset them, in case
> > > of a reboot.)
> > > 
> > > It seems there are only two cases when a runtime resume is actually
> > > necessary:  If the driver has declared a ->shutdown callback or if kexec
> > > is in progress.
> > > 
> > > Constrain resume of a device to these cases and let it slumber
> > > otherwise, thereby conserving energy and speeding up shutdown.
> > 
> > What happens if you get a wakeup event while going down?
> 
> Hm, I should probably disable that with
> 
> 	__pci_enable_wake(pci_dev, pci_dev->current_state, true, false);
> 

What if the user wants, say, WoL to power on the system?

> 
> > Will it lead to a reboot when a shutdown has been requested?
> 
> That would depend on the platform, my guess is no, but only someone
> with extensive real world experience with such corner cases can answer
> this. (Rafael?)

That wakeup will be silently dropped on the floor as a rule AFAICS.

But there's another theoretical issue here.

On systems with ACPI some devices may need to be reconfigured for wakeup
from S5 even though they have been configured for signaling wakeup while
in S0.  Those would still need to be resumed.

Thanks,
Rafael

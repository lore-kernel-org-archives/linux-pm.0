From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2 5/5] PCI: Avoid unnecessary resume on shutdown
Date: Mon, 19 Sep 2016 12:14:02 +0200
Message-ID: <20160919101402.GA2506@wunner.de>
References: <cover.1474130360.git.lukas@wunner.de>
 <760eb8c67a02e35938a4fbd3b31cbe9bb1414c5a.1474130360.git.lukas@wunner.de>
 <1474276343.2044.4.camel@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474276343.2044.4.camel@suse.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Oliver Neukum <oneukum@suse.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <peter@lekensteyn.nl>, Andreas Noever <andreas.noever@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 19, 2016 at 11:12:23AM +0200, Oliver Neukum wrote:
> On Sun, 2016-09-18 at 05:39 +0200, Lukas Wunner wrote:
> > We currently perform a mandatory runtime resume of all PCI devices on
> > ->shutdown.  However it is pointless to wake devices only to immediately
> > power them down afterwards.  (Or have the firmware reset them, in case
> > of a reboot.)
> > 
> > It seems there are only two cases when a runtime resume is actually
> > necessary:  If the driver has declared a ->shutdown callback or if kexec
> > is in progress.
> > 
> > Constrain resume of a device to these cases and let it slumber
> > otherwise, thereby conserving energy and speeding up shutdown.
> 
> What happens if you get a wakeup event while going down?

Hm, I should probably disable that with

	__pci_enable_wake(pci_dev, pci_dev->current_state, true, false);


> Will it lead to a reboot when a shutdown has been requested?

That would depend on the platform, my guess is no, but only someone
with extensive real world experience with such corner cases can answer
this. (Rafael?)

Thanks,

Lukas

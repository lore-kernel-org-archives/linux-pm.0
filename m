From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/7] PCI PM: Fix handling of devices without
	drivers
Date: Wed, 4 Feb 2009 13:10:15 +0100
Message-ID: <200902041310.15761.rjw__18421.1608408534$1233749602$gmane$org@sisk.pl>
References: <200902040154.36018.rjw@sisk.pl> <200902040156.15200.rjw@sisk.pl>
	<alpine.LFD.2.00.0902031815550.3247@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902031815550.3247@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Sesterhenn <snakebyte@gmx.de>, Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 04 February 2009, Linus Torvalds wrote:
> 
> On Wed, 4 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > Suspend to RAM is reported to break on some machines as a result of
> > attempting to put one of driverless PCI devices into a low power
> > state.  Avoid that by not attepmting to power manage driverless
> > devices during suspend.
> > 
> > Fix up pci_pm_poweroff() after a previous incomplete fix for the same
> > thing during hibernation.
> 
> Ok, I really don't like this patch, because:
> 
> > -static void pci_pm_default_suspend(struct pci_dev *pci_dev)
> > +static void pci_pm_default_suspend(struct pci_dev *pci_dev, bool prepare)
> >  {
> >  	pci_pm_default_suspend_generic(pci_dev);
> >  
> > -	if (!pci_is_bridge(pci_dev))
> > +	if (prepare && !pci_is_bridge(pci_dev))
> >  		pci_prepare_to_sleep(pci_dev);
> >  
> >  	pci_fixup_device(pci_fixup_suspend, pci_dev);
> 
> This "helper" function really isn't helping anything at all any more. It's 
> really just confusing things.
> 
> Now that was true even before this all; mostly because your naming in this 
> area _really_ sucks. I mean, what the heck is the difference between 
> "pci_pm_default_suspend_generic()" and "pci_pm_default_suspend()", and 
> what do they do?
> 
> But you just made it worse. This trivial function that doesn't do anything 
> interesting, and isn't well-named enough to actually explain what it is 
> doing now became EVEN WORSE.  Now it's a trivial function that does two 
> things, except it does one of those things only if the magic flag (that is 
> also not helpfully named) is set.
> 
> Argh.
> 
> To make it worse, it's not at all obvious what the logic is:
> 
> > +	struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > +		pci_pm_default_suspend(pci_dev, !!pm);
> 
> Whaa? This is basically totally obfuscated code both in the caller _and_ 
> in the callee.
> 
> Now, it looks like this all then goes away in PATCH 7/7, so I guess I 
> shouldn't complain too much, but I just don't see much point in carrying 
> this broken patch around in the series, since it's then going away and 
> rewritten almost immediately again.

This is what has been tested by the bug reporter.

OK, I should have created a more sophisticated version, but that would go
away with patch 7/7 too, so ...

> Apart from that complaints, Acked-by: for the series. 

Thanks!

Rafael

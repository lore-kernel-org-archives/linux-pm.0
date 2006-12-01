From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [RFC] ACPI vs device ordering on resume
Date: Fri, 1 Dec 2006 11:25:49 +0100
Message-ID: <200612011125.50343.rjw@sisk.pl>
References: <20061114153026.730deb94@freekitty> <200611150203.30965.len.brown@intel.com> <20061130174825.7608c33b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061130174825.7608c33b@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Len Brown <lenb@kernel.org>, len.brown@intel.com, linux-pm@lists.osdl.org, Greg KH <greg@kroah.com>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Friday, 1 December 2006 02:48, Stephen Hemminger wrote:
> On Wed, 15 Nov 2006 02:03:30 -0500
> Len Brown <len.brown@intel.com> wrote:
> 
> > On Tuesday 14 November 2006 18:30, Stephen Hemminger wrote:
> > > If I do a suspend-to-ram then resume on a Sony Vaio laptop with sky2 driver,
> > > the first interrupt gets misrouted to the original shared IRQ, rather than
> > > to the MSI irq expected.
> > > 
> > > During the pci_restore process, the MSI information and the PCI command register 
> > > are restored properly. But later during resume, inside the ACPI evaluation of
> > > the WAK method, the PCI_COMMAND  INTX_DISABLE (0x400) flag is being cleared.
> > > My guess is that the BIOS ends up doing some resetting of devices.
> > > 
> > > I may be able to workaround the problem for this one device, but it brings up
> > > a more general issue about what the ordering should be during resume. If ACPI
> > > evaluation (which I assume talks to the BIOS), might change device state, it
> > > seems that ACPI code should execute before resuming devices not after. But changing
> > > the order here seems drastic.
> > > 
> > > An alternate solution would be to have two pm_ops, one for early_resume
> > > and another for late, and split the ACPI work.
> > > 
> > > --- 2.6.19-rc5.orig/kernel/power/main.c	2006-11-14 14:24:37.000000000 -0800
> > > +++ 2.6.19-rc5/kernel/power/main.c	2006-11-14 14:25:23.000000000 -0800
> > > @@ -132,12 +132,12 @@
> > >  
> > >  static void suspend_finish(suspend_state_t state)
> > >  {
> > > +	if (pm_ops && pm_ops->finish)
> > > +		pm_ops->finish(state);
> > >  	device_resume();
> > >  	resume_console();
> > >  	thaw_processes();
> > >  	enable_nonboot_cpus();
> > > -	if (pm_ops && pm_ops->finish)
> > > -		pm_ops->finish(state);
> > >  	pm_restore_console();
> > >  }
> > 
> > Yes, I agree that _WAK needs to come before device_resume().
> > Need to let any BIOS nasties happen and get over with before we restore device drivers.
> > This is consistent with the wording in ACPI 3.0b (section 7.4) that says
> > 11. _WAK is run
> > 12. OSPM notifies all native device drivefrs of the return from the sleep state transition
> > 
> > However, commit 1a38416cea8ac801ae8f261074721f35317613dc says that
> > _WAK must follow INIT -- ie finish() must come after enable_nonboot_cpus(),
> > and this patch as it stands would violate that.
> > 
> > So it looks like we need this sequence:
> > 
> > enable_nonboot_cpus() /* INIT */
> > finish()	/* _WAK */
> > device_resume()
> > 
> 
> Do you want to do this, or shall I? send off a patch.
> I can test on about 5 machines first.

Could we please wait with that a bit until we have the freezer fixed?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller


From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git 0/3] x86_pc and ACPI support
	/sys/devices/.../wakeup
Date: Thu, 19 Apr 2007 12:24:08 -0700
Message-ID: <200704191224.08474.david-b__31339.9749379188$1177011638$gmane$org@pacbell.net>
References: <200704051248.40745.david-b@pacbell.net>
	<200704180933.07601.david-b@pacbell.net>
	<1176976112.9072.54.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176976112.9072.54.camel@localhost.localdomain>
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
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > > The patches are:
> > > > 
> > > >  - Define a platform_enable_wakeup() PM hook and use it with PCI.  (This
> > > >    might help OLPC with its non-RTC events...)
> > > > 
> > > >  - Make ACPI init and use driver model wakeup flags for the (motherboard)
> > > >    devices in its table ... and implement that new platform hook.  Now
> > > >    /proc/acpi/wakeup is almost purely informative.
> > > 
> > > Yes.
> > > But /proc/acpi/wakeup is exporting the wrong information then.
> > 
> > I'd say it's always exported the wrong information ... and
> > since those /proc files are going away, this there's no
> > strong need to continue following that path.
> > 
> > The literal meaning hasn't changed:  it still reflects the
> > value of the acpi_device.wakeup.state.enabled flag.  This
> > version of the patch avoided changing that meaning, to make
> > the compatibility story simpler.
> > 
> > > I.e. when a physical device is set to may_wakeup, the corresponding
> > > GPE will be enabled before entering a system sleep state.
> > 
> > The GPE is not always enabled when device_may_wakeup(dev)
> > returns true.  When drivers aren't set up to handle wakeups,
> > they won't make requests that boil down to enabling GPEs.
> > 
> > What /proc/acpi/wakeup shows in those cases is the state
> > of what I called "manual overrides".  Drivers that aren't
> > wakeup-aware will use those settings ... same as always.
> > (Unless userspace disables wakeup for that device through
> > the driver model.)
> > 
> 
> > Wakeup-aware drivers will manage their GPEs directly, by
> > calling pci_enable_wake() -- or whatever -- according to
> > what device_may_wakeup(dev) tells them to do.
> > 
> 
> That's true.
> Now acpi_device.wakeup.state.enabled is handled by
> the wakeup-aware drivers of the "real" device.
> 
> I love the first two patches which help user space get rid of
> this ACPI specific GPE control.

OK, good -- we're on the same page then!


> What I meant yesterday is that, as /proc/acpi/wakeup won't be
> removed until we are able to map all the ACPI devices shown to
> the real device node, if they have one,
> it would be better if we either remove this GPE status information
> from /proc/acpi/wakeup, or export something that really makes sense.

That's a bit of a sticky situation.  I went back and forth
on it a bit ... and eventually decided the simplest, and
clearest, approach was not to change how /proc/acpi/wakeup
handles those flags.


> But now I think it's wrong. Because the other devices that are not
> mapped yet still need this I/F to enable/disable GPE, we can not
> remove/change this at the current stage.

Exactly!


> Then the first two patches are OK with me.:)
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Great -- thanks!  I'll append that to these patches and ask
Andrew to merge them.

Given these and the PNP patches, most /proc/acpi/wakeup
devices will now get the right annotations.  There will still
be some puzzles to work out over time though ... the PS2
devices, some ACPI buttons, and PCI bridges.

Plus of course the PCI issues addressed in the third patch.
I switched things around a bit; maybe it's now easier to
have something that won't break powerpc.

- Dave

 
> Thanks,
> Rui
> 

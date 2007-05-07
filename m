From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Sun, 6 May 2007 18:05:50 -0700
Message-ID: <200705061805.51366.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<200705041440.59023.david-b@pacbell.net>
	<200705050019.23856.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705050019.23856.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Friday 04 May 2007, Rafael J. Wysocki wrote:
> On Friday, 4 May 2007 23:40, David Brownell wrote:
> > On Friday 04 May 2007, Alan Stern wrote:

> > > 	1. Freeze tasks
> > > 	2. Quiesce devices and drivers
> > > 	3. Create snapshot
> > > 	4. Reactivate devices and drivers
> > > 	5. Save snapshot to disk
> > > 	6. Prepare devices for wakeup
> > > 	7. Power down (ACPI S4 on systems which support it)
> > > 
> > > Leaving hibernation involves a similar sequence which I won't discuss.
> > > 
> > > Notice that steps 1-5 above are _completely_ independent of all issues 
> > > concerning wakeup devices and S4 vs. S5 vs. whatever.  They have to be 
> > > carried out for hibernation to work, no matter how the system ends up 
> > > getting shut down.
> > 
> > Not exactly.  Step 2 is supposed to be aware of the target state's
> > capabilities, including what's wakeup-capable.  ACPI uses target
> > device states to choose which _SxD methods to execute, etc.  (Or it
> > should ... though come to think of it, I don't think I ever saw a
> > hook whereby PCI could trigger that.)

The hook is there, but it's not yet implemented ... patch in the
works.  Whoever implemented pci_choose_state() botched it up.

 
> Still, step 4 effectively undoes at least some things we did in 2.  At least
> the GPEs should be enabled for normal operation so that we can save the image.

And for that matter, wakeup shouldn't be limited to wake-from-sleep;
runtime device PM should be able to use it.  ACPI doesn't use GPEs
very well at all, except maybe runtime GPEs.  Step 6 needs to know
the same info, so it can enable the GPEs that work from S4.

 

> But then there's the nice picture in 9.3.3 (OS loading) that shows how OSPM
> (that would be us) can verify that the hardware configuration hasn't changed.
> 
> In fact we don't do this, because we always go to the "Load OS Images" block
> and load the hibernation image from this newly loaded OS (aka the boot kernel).
> 
> Thus our resume is always different from the "ACPI wake up from S4".

Right ... "slower" being one consequence.


> > ACPI is allowed to distinguish between S4 and S5 in more ways
> > than just the power usage.  It'd be fair for the AML to store
> > state in something that retains power, and rely on that.  It'd
> > be better not to do things that are allowed to confuse ACPI.
> 
> As far as I understand the specification, OSPM (ie. we) can always discard
> the fact that the system has entered S4 and reinitialize everything from
> scratch.

At the price of making some things needlessly misbehave.  Devices
that can wake from D3cold will detect state being trashed if you
re-init, which is at least sub-optimal if not wrong.


> >	 Still, the point is that these systems are now
> > documented to work in a particular way, and there really ought to
> > be a good reason to invalidate user training and documentation.
> 
> That's a very important point, IMO.

So I just re-quoted it.  ;)


> > A "Soft OFF" should be S5 to conform to specs and
> > documentation.

- Dave

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 00:19:22 +0200
Message-ID: <200705050019.23856.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
	<200705041440.59023.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705041440.59023.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 23:40, David Brownell wrote:
> On Friday 04 May 2007, Alan Stern wrote:
> > Rafael, David, and Pavel:
> > 
> > You all misunderstood the point I was trying to make.
> > 
> > ...
> > 
> > Let's look at the big picture.
> > 
> > Entering hibernation basically involves these steps:
> > 
> > 	1. Freeze tasks
> > 	2. Quiesce devices and drivers
> > 	3. Create snapshot
> > 	4. Reactivate devices and drivers
> > 	5. Save snapshot to disk
> > 	6. Prepare devices for wakeup
> > 	7. Power down (ACPI S4 on systems which support it)
> > 
> > Leaving hibernation involves a similar sequence which I won't discuss.
> > 
> > Notice that steps 1-5 above are _completely_ independent of all issues 
> > concerning wakeup devices and S4 vs. S5 vs. whatever.  They have to be 
> > carried out for hibernation to work, no matter how the system ends up 
> > getting shut down.
> 
> Not exactly.  Step 2 is supposed to be aware of the target state's
> capabilities, including what's wakeup-capable.  ACPI uses target
> device states to choose which _SxD methods to execute, etc.  (Or it
> should ... though come to think of it, I don't think I ever saw a
> hook whereby PCI could trigger that.)

Still, step 4 effectively undoes at least some things we did in 2.  At least
the GPEs should be enabled for normal operation so that we can save the image.

> > On the other hand, steps 6 and 7 aren't really needed for hibernation.  
> > You _could_ shut the system off completely (ACPI S5).  Automatic wakeup
> > wouldn't work, but the next time the user turned the computer on manually
> > it would still resume from hibernation.
> 
> I believe I did comment on your point that step 7 could use S5.
> 
> However, the ACPI spec *does* say up front (2.2 in ACPI 2.0C)
> that S5 == G2 "Soft OFF" is not a "sleeping" (G1) state.  (Then
> fuzzes the issue in 2.4, but those bits are less relevant here;
> 2.2 also mentions G3 = "Mechanical OFF", which is the only state
> in which machine disassembly/reassembly is expected to be safe.

But then there's the nice picture in 9.3.3 (OS loading) that shows how OSPM
(that would be us) can verify that the hardware configuration hasn't changed.

In fact we don't do this, because we always go to the "Load OS Images" block
and load the hibernation image from this newly loaded OS (aka the boot kernel).

Thus our resume is always different from the "ACPI wake up from S4".

> ACPI is allowed to distinguish between S4 and S5 in more ways
> than just the power usage.  It'd be fair for the AML to store
> state in something that retains power, and rely on that.  It'd
> be better not to do things that are allowed to confuse ACPI.

As far as I understand the specification, OSPM (ie. we) can always discard
the fact that the system has entered S4 and reinitialize everything from
scratch.

> > Conversely, steps 6 and 7 can make sense even in situations where you
> > don't want to hibernate.  For example, you might want a normal shutdown in
> > which the operating system does a full restart when the firmware is
> > signalled by a wakeup device.
> 
> Wakeup devices in S4 are expected to be a superset of those in S5,
> and system documentation often covers that.  Yeah, I know, "who
> bothers to RTFM".  Still, the point is that these systems are now
> documented to work in a particular way, and there really ought to
> be a good reason to invalidate user training and documentation.

That's a very important point, IMO.

> > So there should be separate data structures associated with 1-5 and 6-7.  
> > Maybe the one associated with 6-7 is what you are calling hibernation_ops;  
> > if so then fine.  But I still think that it should be usable for
> > situations where you are not entering hibernation, and we should be 
> > possible to enter hibernation without using it.  The system administrator 
> > should be able to choose which of S4 or S5 gets used for _any_ poweroff, 
> > regardless of whether it's to start hibernating.
> 
> But ... why?  What value would users see from that?
> 
> We do have /sys/power/disk today, but that's only for
> hibernation.  (And it's a bit confusing, too.)
> 
> A "Soft OFF" should be S5 to conform to specs and
> documentation.
> 
> 
> > The ACPI spec might refer to S4 as "hibernation" (does it? -- I'm too lazy
> > to check and see), but that doesn't mean we have to use the terms
> > synonymously.
> 
> It talks S4 as a "sleeping" state, like S1, S2, and S3.
> Or, about S4 as a "Non-Volatle sleep" state
> 
> I think it also assumes more intelligence on resume-from-S4
> than Linux has just now, which may partly explain why it
> takes so long for swsusp to finish its thing.

Well, please look at the picture in 9.3.3 and compare it to what we're
doing. ;-)

Greetings,
Rafael

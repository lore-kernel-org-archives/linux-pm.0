From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 19:50:17 +0200
Message-ID: <200705051950.18318.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705051152300.1976-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705051152300.1976-100000@netrider.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, 5 May 2007 18:08, Alan Stern wrote:
> On Fri, 4 May 2007, David Brownell wrote:
> 
> > > Entering hibernation basically involves these steps:
> > > 
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
> > capabilities, including what's wakeup-capable.
> 
> Not true.  Step 2 is (or should be) divorced from power-level
> considerations.  All it needs to do is quiesce things so that a consistent
> snapshot can be obtained; changing power levels would take time and
> ideally should be avoided.  Furthermore, anything done in step 2 should be
> reversed in step 4.
> 
> Did you mean to say that Step _6_ is supposed to be aware of the target 
> state's capabilities?  I'll agree to that.
> 
> 
> > However, the ACPI spec *does* say up front (2.2 in ACPI 2.0C)
> > that S5 == G2 "Soft OFF" is not a "sleeping" (G1) state.  (Then
> > fuzzes the issue in 2.4, but those bits are less relevant here;
> > 2.2 also mentions G3 = "Mechanical OFF", which is the only state
> > in which machine disassembly/reassembly is expected to be safe.
> 
> Sure.  But entering hibernation need not involve putting the system into a 
> "sleeping" state.  Going into G3 should also work for hibernation.
> 
> > ACPI is allowed to distinguish between S4 and S5 in more ways
> > than just the power usage.  It'd be fair for the AML to store
> > state in something that retains power, and rely on that.  It'd
> > be better not to do things that are allowed to confuse ACPI.
> 
> None of that should matter for post-snapshot-restore processing.  The 
> boot kernel interacts with ACPI when the system wakes up; the restored 
> kernel is handed an already-running BIOS, which it should do its best to 
> reinitialize from the existing hardware state.
> 
> 
> > > possible to enter hibernation without using it.  The system administrator 
> > > should be able to choose which of S4 or S5 gets used for _any_ poweroff, 
> > > regardless of whether it's to start hibernating.
> > 
> > But ... why?  What value would users see from that?
> > 
> > We do have /sys/power/disk today, but that's only for
> > hibernation.  (And it's a bit confusing, too.)
> 
> Yes.  I'm proposing that it be generalized.  (And it should be renamed,
> too -- that's a separate issue.)
> 
> I'm also pointing out that the policy choice decided by the contents of 
> /sys/power/disk comes into play during steps 6-7 above, but not at all in 
> steps 1-5.  Hence any associated software structures should explicitly be 
> connected only with steps 6 and 7.

At present, this policy choice does affect the earlier steps too.
 
> And since normal shutdown ought to have its own analog of steps 6 and 7, 
> the same software structures should be used there.  Hence naming them 
> "hibernation_ops" isn't a good idea.
> 
> 
> > I think it also assumes more intelligence on resume-from-S4
> > than Linux has just now, which may partly explain why it
> > takes so long for swsusp to finish its thing.
> 
> And it may explain some of the strange behavior people sometimes observe
> when they try to hibernate twice in a row.

Yes, this seems to be the case.

Greetings,
Rafael

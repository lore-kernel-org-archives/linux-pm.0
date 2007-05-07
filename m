From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Sun, 6 May 2007 18:31:08 -0700
Message-ID: <200705061831.08805.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705051152300.1976-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

On Saturday 05 May 2007, Alan Stern wrote:
> On Fri, 4 May 2007, David Brownell wrote:
> 
> Did you mean to say that Step _6_ is supposed to be aware of the target 
> state's capabilities?  I'll agree to that.

Yes ... but I don't see why it would be wrong for step 2 either.
If the device can't wake from S5, it wouldn't set up with the
assumption that was a possibility.


> > However, the ACPI spec *does* say up front (2.2 in ACPI 2.0C)
> > that S5 == G2 "Soft OFF" is not a "sleeping" (G1) state.  (Then
> > fuzzes the issue in 2.4, but those bits are less relevant here;
> > 2.2 also mentions G3 = "Mechanical OFF", which is the only state
> > in which machine disassembly/reassembly is expected to be safe.
> 
> Sure.  But entering hibernation need not involve putting the system into a 
> "sleeping" state.  Going into G3 should also work for hibernation.

For some definitions of "should"; that's where specs get fuzzy.

Since disassembly is allowed in G3, if you swapped a disk that
should prevent the system from resuming ... it should force a
boot-from-scratch.  But if you just swapped a power supply it
would probably work OK.


> I'm also pointing out that the policy choice decided by the contents of 
> /sys/power/disk comes into play during steps 6-7 above, but not at all in 
> steps 1-5.  Hence any associated software structures should explicitly be 
> connected only with steps 6 and 7.

The difference between S4 and S5 could matter to step 2 though.
Perhaps it's not the most likely thing, but certainly avoiding
the work to setup wake-from-S4 is reasonable when going to S5.

 
> And since normal shutdown ought to have its own analog of steps 6 and 7, 
> the same software structures should be used there.  Hence naming them 
> "hibernation_ops" isn't a good idea.

That's something of a different stance.  And it's untrue for
step 6 too ... suspend() and shutdown() differ a lot.  Maybe
if I saw some details, that would make more sense to me.


> > I think it also assumes more intelligence on resume-from-S4
> > than Linux has just now, which may partly explain why it
> > takes so long for swsusp to finish its thing.
> 
> And it may explain some of the strange behavior people sometimes observe
> when they try to hibernate twice in a row.

There's all kinds of bizarreness there.  I kind of get the
feeling the ACPI folk were so deluged by IRQ and other resource
setup issues (the "C" in ACPI) that the power management bits
(the "P") didn't get that much attention.  As pointed out very
recently by Rafael.  :)

Plus there's the issue that while this thread has touched a lot
on ACPI issues and models, Linux must not assume ACPI.

- Dave

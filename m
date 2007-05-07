From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Mon, 7 May 2007 12:33:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705071207100.3429-100000@iolanthe.rowland.org>
References: <200705061831.08805.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705061831.08805.david-b@pacbell.net>
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

On Sun, 6 May 2007, David Brownell wrote:

> On Saturday 05 May 2007, Alan Stern wrote:
> > On Fri, 4 May 2007, David Brownell wrote:
> > 
> > Did you mean to say that Step _6_ is supposed to be aware of the target 
> > state's capabilities?  I'll agree to that.
> 
> Yes ... but I don't see why it would be wrong for step 2 either.

The principle of information hiding: If step 2 doesn't _need_ to know 
the final target state (which it shouldn't!) then we ought not to tell it.

> If the device can't wake from S5, it wouldn't set up with the
> assumption that was a possibility.

But step 2 doesn't set up devices' wakeup functions.  It merely quiesces
them so the snapshot can be made safely.  Then step 4 reactivates the
devices, and step 6 takes care of setting up the devices for the final
sleep state.


> > Sure.  But entering hibernation need not involve putting the system into a 
> > "sleeping" state.  Going into G3 should also work for hibernation.
> 
> For some definitions of "should"; that's where specs get fuzzy.
> 
> Since disassembly is allowed in G3, if you swapped a disk that
> should prevent the system from resuming ... it should force a
> boot-from-scratch.  But if you just swapped a power supply it
> would probably work OK.

Yep.  The problem isn't so much in the specs; it's that no one has ever
(so far as I know) given a precise definition of what Linux's "hibernate"  
is supposed to do.  Is it supposed to be safe to disassemble a hibernating
computer?  Is remote wakeup necessarily supported?  I've never seen
answers to these questions.

> > I'm also pointing out that the policy choice decided by the contents of 
> > /sys/power/disk comes into play during steps 6-7 above, but not at all in 
> > steps 1-5.  Hence any associated software structures should explicitly be 
> > connected only with steps 6 and 7.
> 
> The difference between S4 and S5 could matter to step 2 though.
> Perhaps it's not the most likely thing, but certainly avoiding
> the work to setup wake-from-S4 is reasonable when going to S5.

I don't understand.  Step 2 doesn't do the work to set up wake-from-S4;  
step 6 does.  So why should the knowledge of S4 vs. S5 matter to step 2?

> > And since normal shutdown ought to have its own analog of steps 6 and 7, 
> > the same software structures should be used there.  Hence naming them 
> > "hibernation_ops" isn't a good idea.
> 
> That's something of a different stance.  And it's untrue for
> step 6 too ... suspend() and shutdown() differ a lot.  Maybe
> if I saw some details, that would make more sense to me.

It is true that for G3 type shutdown, step 6 can be empty.  We don't need 
to do anything to the devices or drivers, we just turn off all the power.  
Still, the empty set _is_ a set.  :-)

Here's another way to express my ideas: We want to support at least two 
different kinds of powered-down states:

	(A) Remote wakeup may be enabled on some devices, there can be
	    a certain power drain on the batteries or power line, it may 
	    not be safe to disassemble the machine, etc.

	(B) Remote wakeup is completely disabled, there is no power
	    drain at all, it is safe to disassemble the machine provided
	    you don't switch components like disks, etc.

(With (B) it should always be _physically_ safe to switch disks and other
components.  Whether it is _logically_ safe depends on what happens the
next time you start the machine: Will you try to restore a saved memory
image or not?  This isn't directly related to the nature of the
powered-down state except for the obvious fact that you can't restore an
image if no image has been saved.)

I don't see any reason why (A) and (B) shouldn't both be allowed for 
hibernate, as in fact they are now by way of /sys/power/disk.  And I don't 
see any reason why they shouldn't both be allowed for normal non-hibernate 
shutdowns as well.

Furthermore, the choice of whether to use (A) or (B) shouldn't matter 
during steps 1-5 of the hibernate sequence.  It should matter during steps 
6-7 and during normal shutdown (which doesn't have steps 1-5 since it 
doesn't save a memory image).

> Plus there's the issue that while this thread has touched a lot
> on ACPI issues and models, Linux must not assume ACPI.

Yes indeed.

Alan Stern

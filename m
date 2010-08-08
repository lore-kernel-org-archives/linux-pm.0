From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sun, 8 Aug 2010 11:36:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008081119370.4706-100000__33927.5962244303$1281281865$gmane$org@netrider.rowland.org>
References: <alpine.DEB.2.00.1008071338480.30564@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1008071338480.30564@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: tytso@mit.edu, peterz@infradead.org, swetland@google.com, Kernel development list <linux-kernel@vger.kernel.org>, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, swmike@swm.pp.se, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Sat, 7 Aug 2010 david@lang.hm wrote:

> > This may be controversial, but I think Rafael will agree when I say
> > that (in this one respect) Linus was wrong.  Separating hibernation
> > from suspend makes sense, and I agree that the differences between
> > deepest idle and suspend should be minimized.  But to get rid of them
> > altogether would be wrong (and probably not possible anyway).
> 
> if you thing the differences should be minimized, why do you think that 
> getting rid of them would be wrong?

Actually I meant that _attempting_ to get rid of them would be wrong,
because it would be a futile attempt to carry out an impossible task.

> >> As deep sleep gains the ability to use even less power and as suspend
> >> gains the ability to leave things on sometimes, the difference between
> >> them is dissapearing. I wouldn't be at all surprised to see them start
> >> overlaping soon. So it's not that I think Android should use deep sleeps
> >> instead of suspend, but rather that suspend should just be the deepest
> >> sleep, one mechanism instead of two.
> >
> > I disagree.  There are critical differences between them:
> >
> > 	Suspend uses the freezer and idle doesn't.
> >
> > 	Suspend generally forces devices to go into their low-power
> > 	states immediately, whereas idle tends to leave unused devices
> > 	at full power for some time before going to low power (to
> > 	minimize average latency).
> 
> this sounds like policy, not capability.

It isn't.  Suspend does not have the capability to leave a device at
full power for 100 ms and then switch it to low power if it hasn't been
used in that time.  (Or, it requires special hardware support to be
able to do this.)  Idle does have this capability.

> > 	Overall, suspend generally has longer latency than idle.  (This
> > 	varies among platforms.)
> 
> even different idle modes have different latency

But the difference between idle and suspend can be orders of magnitude 
larger.  That makes it qualitatively different, not just quantitatively 
different.

> > 	The set of wakeup sources (including timers) is different.
> 
> I agree that they are different, but don't they also vary within sleep or 
> suspend as well?

Suspend _is_ a form of sleep.  (The other form is hibernation.)  It's 
true that the set of wakeup sources can be customized to some extent.  
But in the usual implementations, timers are never a wakeup source for 
suspend whereas they always are for idle.

> > 	On some systems, suspend uses platform-specific mechanisms to
> > 	go into lower power states than are available to idle.
> 
> the exact mechanism to go into low-power states is platform specific to 
> start with (there are some very popular platforms admittedly, like the PC 
> ACPI modes)

Sure, the mechanism is platform-specific.  That doesn't change the fact
that ACPI systems can achieve lower power usage with suspend than they
can with idle.

> as I see it
> 
> Sleep

Do you mean "idle" or "deep-idle" rather than "sleep"?

> a policy engine to decide when to sleep, how deeply to sleep, what to 
> disable, what will wake you up (this includes taking into account desired 
> latency, and the amount of power/time needed to get in and out of the 
> various modes)
> 
> platform specific mechanisms for transitioning in and out of the modes.
> 
> 
> Suspend
> 
> a policy engine to decide when to suspend, what to leave enabled when you 
> supend, what will wake you i[

Suspend is initiated entirely by userspace, not by the kernel.  
Wakelocks provide a means for the kernel to delay or cancel a suspend 
request, not to initiate one.

> platform specific mechanisms for transition in and out of suspend. I view 
> use of the freezer to be one of these mechansims.

The freezer is not platform specific.

> Somewhere amoung this mess are things like spinning down drives, disabling 
> inactive network interfaces, etc. I don't knwo if those are run from the 
> sleep policy engine, or if there is a third policy engine to decide these 
> things.
> 
> 
> why should there be multiple different policy engines making power 
> management decisions? it seems to me like these policy engines can and 
> should be merged, with the resulting engine able to trigger all the 
> existing mechanisms for transitioning between modes.

There are multiple policy engines because one of them is in the kernel 
and the other is in userspace.  I don't see how you can merge the two.

Alan Stern

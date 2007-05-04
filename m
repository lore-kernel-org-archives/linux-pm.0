From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 10:40:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705041020530.3417-100000@iolanthe.rowland.org>
References: <200705032221.59285.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705032221.59285.rjw@sisk.pl>
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

Rafael, David, and Pavel:

You all misunderstood the point I was trying to make.

On Thu, 3 May 2007, Rafael J. Wysocki wrote:

> > But why shouldn't a "normal" poweroff enter ACPI S4?  And why shouldn't a 
> > "hibernate" poweroff enter ACPI S5?  The choice of which state to enter is 
> > independent of the reason for shutting down, right?
> 
> Well, not exactly.
> 
> > In other words, the choice for whether or not to call
> > acpi_enter_sleep_state(ACPI_STATE_S4) shouldn't depend on whether or not 
> > you're hibernating.  So it shouldn't affect the usage of hibernation_ops 
> > at all.
> 
> This works the other way around, I think. :-)
> 
> Granted, some boxes require us to call acpi_enter_sleep_state(ACPI_STATE_S4)
> as a 'power off method' so that they work correctly after the 'return' from hibernation.
> If we do acpi_enter_sleep_state(ACPI_STATE_S5) instead, some things might
> not work on them (this is an experimental observation, I don't know what
> exactly the reason of it is).
> 
> Now, since I have such a box, I need to do the
> acpi_enter_sleep_state(ACPI_STATE_S4) thing (IOW, use the 'platform' power off
> method) and not acpi_enter_sleep_state(ACPI_STATE_S5) (the 'shutdown' power
> off method).  *However*, acpi_enter_sleep_state(ACPI_STATE_S4) cannot be used
> without previous preparations, which are made with the help of hibernation_ops.
> 
> IOW, all hibernation_ops, including the ->enter() method that actually calls
> acpi_enter_sleep_state(ACPI_STATE_S4), are just different pieces of one
> (complicated) 'platform' power off method.  It doesn't make sense to use the
> (other) hibernation_ops without the ->enter() method.

Let's look at the big picture.

Entering hibernation basically involves these steps:

	1. Freeze tasks

	2. Quiesce devices and drivers

	3. Create snapshot

	4. Reactivate devices and drivers

	5. Save snapshot to disk

	6. Prepare devices for wakeup

	7. Power down (ACPI S4 on systems which support it)

Leaving hibernation involves a similar sequence which I won't discuss.

Notice that steps 1-5 above are _completely_ independent of all issues 
concerning wakeup devices and S4 vs. S5 vs. whatever.  They have to be 
carried out for hibernation to work, no matter how the system ends up 
getting shut down.

On the other hand, steps 6 and 7 aren't really needed for hibernation.  
You _could_ shut the system off completely (ACPI S5).  Automatic wakeup
wouldn't work, but the next time the user turned the computer on manually
it would still resume from hibernation.

Conversely, steps 6 and 7 can make sense even in situations where you
don't want to hibernate.  For example, you might want a normal shutdown in
which the operating system does a full restart when the firmware is
signalled by a wakeup device.

So there should be separate data structures associated with 1-5 and 6-7.  
Maybe the one associated with 6-7 is what you are calling hibernation_ops;  
if so then fine.  But I still think that it should be usable for
situations where you are not entering hibernation, and we should be 
possible to enter hibernation without using it.  The system administrator 
should be able to choose which of S4 or S5 gets used for _any_ poweroff, 
regardless of whether it's to start hibernating.

The ACPI spec might refer to S4 as "hibernation" (does it? -- I'm too lazy
to check and see), but that doesn't mean we have to use the terms
synonymously.

Does this make sense, or am I missing something very basic?

Alan Stern

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 16:08:57 +0200
Message-ID: <201008021608.57483.rjw__2782.65049350939$1280758349$gmane$org@sisk.pl>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100801210548.23f77ff6@infradead.org>
	<20100802122726.GA6247@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802122726.GA6247@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ted Ts'o <tytso@mit.edu>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 02, 2010, Ted Ts'o wrote:
> On Sun, Aug 01, 2010 at 09:05:48PM -0700, Arjan van de Ven wrote:
> > I'm a little worried that this whole "I need to block suspend" is
> > temporary. Yes today there is silicon from ARM and Intel where suspend
> > is a heavy operation, yet at the same time it's not all THAT heavy
> > anymore.... 
> 
> Part of the problem here may also be a naming problem.  There are
> multiple reasons why you might want to block suspend, and it goes far
> beyond what the CPU can do.
> 
> Let's give another example, from the laptop world.  If you close the
> the MacBook, it "suspends".  That is, all processes stop, and the CPU
> enters a sleep state.  Sounds just like Linux's suspend-to-ram, right?
> 
> Except for the fact that if you insert a USB cable connected to a
> iPod/iPad/iPhone, the CPU wakes up, and iTunes will do a sync, and
> then the machine goes back to sleep.  And if the Mail application is
> in the middle of manipulating the IMAP mailbox, it will be allowed to
> finish what it is doing, and then the system goes to sleep.

I _think_ you can implement that with the current kernel's interfaces and
an suitable power manager in user space.  At least you should be.

The question really boils down to where the "power manager" activity should be
located.  Should it be in the kernel or in user space?  Or is it better to have
a "collective power manager", like in the wakelocks case?  Moreover, what
should the power manager be responsible for and what the kernel's role should
be in deciding what "power" state to go into?

> So in the case of both the MacBook, where the user has closed the
> laptop, and in the case of Cell Phone, where the user has pushed the
> button saying he/she's done working with the application, the _normal_
> thing to do force all processes to go to sleep, and then let the CPU
> go to sleep.
> 
> But, you may have applications that are specially privileged so they
> can ignore the user command to suspend the machine.

I frankly don't think it's legitimate to overrule the user.  If the user tells
us "suspend" and specifies a set of devices that can be used for wakeup, we
should follow, possibly monitoring the wakeup devices for events.

However, that doesn't apply 100% to the cell phone case, because on cell phones
the software is actually owned by the device vendor and/or the network operator
and they may want to have a mechanism to overrule the person using the phone.
That is a more general issue, though.

> Maybe it's an iTunes-like situation, where in response to some hardware
> interrupt, it's allowed to wake up, do its thing, and then go back to sleep,
> allowing the hardware to go back to sleep.  Maybe it's a mail
> application that wants to wakeup every 15 minutes, suck down any new
> mail, and then go back to sleep.  The suspend blocker is a way to
> achieve this --- and this has nothing to do with chip technology, but
> with a specific use case.

Assuming that your "power manager activity" will be a collective one, along the
Android lines.  Still, in principle, you can obtain a functionally equivalent
behavior with the help of a power manager in user space.

Thanks,
Rafael

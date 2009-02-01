From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sun, 1 Feb 2009 12:43:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902011219170.27579-100000@netrider.rowland.org>
References: <200902011330.03579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902011330.03579.rjw@sisk.pl>
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
Cc: Brian Swetland <swetland@google.com>, Nigel Cunningham <ncunningham@crca.org.au>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, 1 Feb 2009, Rafael J. Wysocki wrote:

> > In that case, why are you against using wakelocks to abort the suspend
> > sequence? It covers the case where the driver knows that a call is
> > coming in, without any confusion about when the abort condition
> > clears. And, it avoids the overhead of freezing every process for an
> > operation that is doomed to fail.
> 
> I'm not really against (yet), I'm only trying to clearly understand the
> benefit.
> 
> The problem pointed out by Alan is real, the user expects the system to suspend
> as soon as the button is pressed and wakelocks may get in the way.
> 
> Your example is also good, but I think the problem in your example (phone
> call coming in while suspending) may be resolved without wakelocks.  Moreover,
> it is a general problem of a wake-up event coming in while suspending and
> it requires a general solution independent of wakelocks.

I'm beginning to get the impression that we're really talking about two 
different kinds of suspend here.  They can be described as 
"high-priority suspend" and "low-priority suspend".

A high-priority suspend occurs when userspace writes "mem" to 
/sys/power/state.  It should override wakelock settings and put the 
system to sleep as soon as possible (subject to abort by drivers, of 
course, but they better have a pretty good reason for aborting).

A low-priority suspend is what Arve has been talking about; it occurs
when the user pushes the phone's "power" button or the auto-suspend
mechanism activates.  It is subject to blocking by wakelocks, and there
should also be a way (although I don't recall seeing it described) to
cancel a low-priority suspend request while it is waiting for a
wakelock to be released.

The idea behind these low-priority suspends is that there are certain 
activities which should be atomic with respect to suspends, that is, 
the system should not normally be allowed to suspend while the activity 
is taking place.  These are things that last longer than a single 
interrupt handler.  Examples we have seen include waiting for all key 
presses to be released (because the keypad can't be enabled for wakeup 
if any keys are pressed) or waiting for a userspace process to finish 
playing a ring tone.

If a high-priority suspend occurs while some keys are pressed, the
keypad driver has a few possible courses of action: abort the suspend,
re-enable the interrupt circuitry, or disable keypad wakeups.  I'm not
sure which would be best; the issue probably won't arise much.  
Similarly, a high-priority suspend while a ring tone is being played
should cause the system to go to sleep right in the middle of playing.

Normally we would expect that on a desktop or laptop, the only source
of low-priority suspend requests would be the auto-suspend code.  On a
phone or other embedded device, we would not expect to see any
high-priority suspend requests under normal circumstances.  But of 
course there could always be exceptions, if someone wanted them.


Early-suspend seems to be a completely different matter.  In fact it 
isn't a suspend state at all, as far as I understand it.  It's more 
like what you get simply by doing a runtime suspend on some collection 
of devices.  I don't see that the kernel needs to treat it as a special 
state, and in might be possible to have a user program manage the whole 
thing -- provided the drivers in question implement runtime power 
management (as USB has done).

Alan Stern

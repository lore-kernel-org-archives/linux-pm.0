From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC] lp_events: an lternitive to suspend blocker
 user mode and kernel API
Date: Mon, 31 May 2010 15:10:35 -0700
Message-ID: <20100531221035.GB31155__11880.7490951896$1275343872$gmane$org@gvim.org>
References: <20100530200409.GA21632@gvim.org>
	<20100531095753.4c174f2d@notabene.brown>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100531095753.4c174f2d@notabene.brown>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Neil Brown <neilb@suse.de>
Cc: mark.gross@intel.com, 640e9920@gmail.com, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, May 31, 2010 at 09:57:53AM +1000, Neil Brown wrote:
> On Sun, 30 May 2010 13:04:10 -0700
> mark gross <640e9920@gmail.com> wrote:
> 
> > Low Power Events is a possible alternative to suspend blocker / wake
> > lock API used by Android.
> 
> Here is how I see your proposal.  It is of course possible that I
> misunderstood bits, so please correct me where I'm wrong.
> 
> 1/ You have introduced a new mechanism for requesting a transition
>   to a low power state.  This involves writing a number to /dev/lpe_enter.
>   It is not clear to me from your text what the magic number really means.
>   I think this parallels writing to /sys/power/state, but achieves the same
>   result though a different mechanism and adds some extra checking.
>   So: I don't understand the numbers, and I don't see why we need a
>    second way to request a low power state.  Probably I missed something
>    important.

You are not missing much.  Those numbers where an attempt at
generalization for the level of suspend that could be requested by user
mode.  The semantics of what I'm talking about are different form
/sys/power/state even though they both enter low power states.

> 
> 2/ Rather than tracking wake-events from the hardware up through possibly
>    several kernel modules, you go directly from hardware to user-space so each
>    event is potentially presented to user-space twice: once as a "wake up
>    from low power state" event and once following the normal path (maybe a
>    key-press event, maybe a serial-port event, maybe a network receive event).
>    I can see that this is a very tempting approach.  It allows all those
>    intermediate modules to remain unchanged and that is good.
>    However it isn't clear to me that this would be easy for user-space to use
>    correctly.

yeah, I think it needs some prototyping too.

>    When an lpe event arrived it would need to wait around for the real event
>    to arrive and then process that.  I probably wouldn't wait long, but it
>    would be an indeterminate wait, and it might not be  trivial to determine
>    if all events that would cause a wake-up have been consumed as a direct
>    mapping from lpe event to normal event may not always be possible.
>    Maybe this is more of a theoretical problem and in practice it would be
>    easy to get it right - I don't have enough concrete experience to be sure.

You suggest below adding a input class for wakeups.  I think using that
would make sense.
 
>    So: I like the idea of leaving the intermediate layers unchanged, but I'm
>    not convinced it would work.
> 

I'm not fully convinced yet either, but I still think it could work.

> 3/ You have created a new mechanism for passing events to user-space.  That
>    seems unnecessary.  We already have the input subsystem which is pretty
>    good at communication arbitrary events, and the events you are dealing
>    with a very much like input events.

really good idea!
 
> So I would suggest modifying your proposal to simply create a new 'input'
> device.  Any driver that supports wake-from-suspend queues an event to that
> device when a wakeup event occurs.  If the device is open and has any queued
> events, then a suspend request such as 'echo mem > /sys/power/state' completes
> without going into full suspend.

/me likes.
 
> Then you just need to convince us that this mechanism can be used without any
> race problems.  If it can, then it would certainly be a simple and
> unobtrusive approach.

Lets find out.

--mgross

> 
> Thanks,
> NeilBrown

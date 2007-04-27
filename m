From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 14:06:59 +0200
Message-ID: <200704271407.00879.rjw__49273.0661215775$1177675555$gmane$org@sisk.pl>
References: <alpine.LFD.0.98.0704241327180.9964@woody.linux-foundation.org>
	<20070425203150.GD17387@elf.ucw.cz>
	<1177669279.7828.55.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177669279.7828.55.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Nick Piggin <npiggin@suse.de>, suspend2-devel@lists.suspend2.net, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, linux-pm <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 12:21, Johannes Berg wrote:
> On Wed, 2007-04-25 at 22:31 +0200, Pavel Machek wrote:
> 
> > > So, the "suspend" and "resume" for the functions being called for that are
> > > wrong, but then we call them with PMSG_FREEZE. ;-)  Still, we could add
> > > .freeze() and .thaw() callbacks for hibernation just fine.  This wouldn't even
> > > be that difficult ...
> > 
> > It would be ugly big patch I'm afraid.
> 
> It'd be a lot of code churn, but well worth it. And most of the changes
> would be trivial too. You need to start looking beyond "this is ugly in
> the short term" and realise that it's much more maintainable in the long
> term if driver writers know what they're supposed to do as opposed to
> just hacking at it until it mostly works or just doing a full device
> down/up cycle including resetting full driver state.
> 
> Look at it now:
> 
>  * FREEZE       Quiesce operations so that a consistent image can be saved;
>  *              but do NOT otherwise enter a low power device state, and do
>  *              NOT emit system wakeup events.
>  *
>  * PRETHAW      Quiesce as if for FREEZE; additionally, prepare for restoring
>  *              the system from a snapshot taken after an earlier FREEZE.
>  *              Some drivers will need to reset their hardware state instead
>  *              of preserving it, to ensure that it's never mistaken for the
>  *              state which that earlier snapshot had set up.
> 
> Why is prethaw even necessary? As far as I can tell it's only necessary
> because resume() can't tell you whether you just want to thaw or need to
> reset since it doesn't tell you at what point it's invoked.
> 
> Having ->freeze(), ->thaw() and ->restart() (can somebody come up with a
> better name?) that are called at the appropriate places (with
> freeze/thaw around preparing the image and freeze/restart around
> restoring would go a long way of clearing up the confusion in all the
> drivers. Of course, it'd have to be documented that freeze/thaw isn't
> the only valid combination but that freeze/restart is used too, but
> that's not hard to do nor hard to understand.
> 
> And, incidentally, it could possibly make both suspend and hibernate
> work much faster too. The comments there talk about "minimally power
> management aware" drivers which always do the wrong thing for suspend,
> in that they always reset everything... Of course, some drivers will
> actually need to do that, but if freeze/suspend and thaw/restart/resume
> have the same prototypes (probably just int <function>(void)) then
> drivers can trivially assign the same there.
> And hibernate would benefit since a lot of drivers could do a lot less
> work for freeze/thaw.

I violently agree with all of the above.

Moreover, for the hibernation we have two special cases that are of no interest
for the suspend:
1) drivers compiled as modules and not loaded before we restore the image
2) drivers that need to allocate much memory in .freeze()

> Or, if we don't want to have five calls and use 40 bytes (on 64-bit)
> just for these callback pointers for each device we could just as well
> have a single callback ->pm(what) and make "what" indicate which one of
> these five things... But then drivers can't make that code depend on the
> swsusp configuration which would be doable with five callbacks.

Five callbacks are fine by me, especially if we can define reasonable defaults
for the hibernation (and can we?).

Rafael

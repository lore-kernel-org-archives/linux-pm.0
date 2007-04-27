From: David Brownell <david-b@pacbell.net>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 08:56:41 -0700
Message-ID: <200704270856.42524.david-b__2441.43559034473$1177690459$gmane$org@pacbell.net>
References: <alpine.LFD.0.98.0704241327180.9964@woody.linux-foundation.org>
	<20070425203150.GD17387@elf.ucw.cz>
	<1177669279.7828.55.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: linux-pm@lists.linux-foundation.org
Cc: Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>, suspend2-devel@lists.suspend2.net, Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday 27 April 2007, Johannes Berg wrote:
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
> Why is prethaw even necessary?

Read the patch comments for the patch adding that transition.  Briefly,
adding that transition to swsusp resume was a significant bugfix for
all drivers that rely on controller state to determine how to resume.

(That's mostly drivers that are intelligent about wakeup events... so
unless you're working with such drivers, the issue may be unclear.)


> As far as I can tell it's only necessary 
> because resume() can't tell you whether you just want to thaw or need to
> reset since it doesn't tell you at what point it's invoked.

More like:  because swsusp overloaded the suspend()/resume() code paths
to do double duty.

Instead of just putting devices into low power states (just *which* state
is another discussion), they evolved into support for swsusp transitions...
causing trouble (and sometimes breakage) for non-swsusp models.


> Having ->freeze(), ->thaw() and ->restart() (can somebody come up with a
> better name?) that are called at the appropriate places (with
> freeze/thaw around preparing the image and freeze/restart around
> restoring would go a long way of clearing up the confusion in all the
> drivers. Of course, it'd have to be documented that freeze/thaw isn't
> the only valid combination but that freeze/restart is used too, but
> that's not hard to do nor hard to understand.

I suspect that after snapshot resume restart() should always be used.
That shouldn't be hard to understand at all.  It'd be sub-optimal in
the same cases today's system resume is sub-optimal:  devices that
were in low power states before system suspend wouldn't be that way
after system resume.


> And, incidentally, it could possibly make both suspend and hibernate
> work much faster too. The comments there talk about "minimally power
> management aware" drivers which always do the wrong thing for suspend,
> in that they always reset everything...

That comment was purely about existing practice ... and was mostly
about resume() processing, not suspend() paths.

It's an unfortunate reality that most device drivers are stupid in
terms of power management, so we need to be clear about just how
stupid they're allowed to be without being terminally broken.

Additionally, it would be a Good Thing if changes to clean up the
swsusp-related code paths didn't make "real suspend" more painful.


> Of course, some drivers will 
> actually need to do that, but if freeze/suspend and thaw/restart/resume
> have the same prototypes (probably just int <function>(void)) then
> drivers can trivially assign the same there.
> And hibernate would benefit since a lot of drivers could do a lot less
> work for freeze/thaw.

That actually gets into discussions from a while back about wanting
to be able to quiesce() devices, as separate from actually putting
them into low power states.

- Dave

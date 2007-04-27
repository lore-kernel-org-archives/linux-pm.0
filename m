From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 10:34:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
References: <1177669279.7828.55.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177669279.7828.55.camel@johannes.berg>
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
Cc: Nick Piggin <npiggin@suse.de>, Ingo Molnar <mingo@elte.hu>, suspend2-devel@lists.suspend2.net, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Apr 2007, Johannes Berg wrote:

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

I think you're wrong here.  It's a little hard to say because the 
terminology is confusing and not yet standardized.

For the sake of argument, let's call the stages of STD and STR by these 
names (also noted are the current PSMG values):

	Suspend to disk:
	"prepare to create snapshot" (= FREEZE)
	"continue after snapshot" (= RESUME)

	Resume from disk:
	"prepare to restore snapshot" (= PRETHAW)
	"continue after restore" (= RESUME)

	Suspend to RAM:
	"suspend" (= SUSPEND)
	"resume" (= RESUME)

The real reason for adding PRETHAW was that drivers couldn't distinguish
between "continue after restore" and "resume", other than by examining the
device's state -- since the PM core doesn't pass any information to the
resume() method.

I suppose we could have modified the "prepare to create snapshot" code 
instead, but doing so would mean that "continue after snapshot" and 
"continue after restore" would always do the same thing, which is not 
necessarily a good idea.

Anyway, based on this analysis it seems reasonable to have Six (6) method 
pointers.  Suggested names (in the same order as above):

	pre_snaphot()
	post_snapshot()
	pre_restore()
	post_restore()
	suspend()
	resume()

People apparently assume that pre_snapshot() and pre_restore() would 
always do the same thing and hence be redundant.  I'm not so sure; time 
will tell.  Doing it this way certainly is more clear.

Then there's the question of having early_ and late_ versions of some of 
these things (i.e., one called with interrupts enabled, the other with 
interrupts disabled).  I don't know to what extent that would be 
necessary; perhaps the each method call should occur in two phases with 
the interrupt-enable status changed in between.  Then the interrupt-enable 
setting could be passed as an argument.

Alan Stern

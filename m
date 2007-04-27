From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: driver power operations (was Re: suspend2 merge)
Date: Fri, 27 Apr 2007 20:34:11 +0200
Message-ID: <200704272034.12535.rjw__35789.0979656533$1177698634$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0704271008540.3430-100000@iolanthe.rowland.org>
	<200704271720.08150.rjw@sisk.pl>
	<alpine.LFD.0.98.0704270842430.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0704270842430.9964@woody.linux-foundation.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, Mike Galbraith <efault@gmx.de>, Kernel development list <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, suspend2-devel@lists.suspend2.net, linux-pm <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 17:52, Linus Torvalds wrote:
> 
> On Fri, 27 Apr 2007, Rafael J. Wysocki wrote:
> > 
> > I think we can use 'stages' and pass them as arguments to the functions.
> 
> No, no NOOOO!
> 
> If you use stages, just describe them in the function name instead.	
> 
> > quiesce(PREPARE) -- that may be needed for drivers that allocate much memory
> > before quiescing devices (if any)
> > ...
> > quiesce(PRE_SNAPSHOT)
> > ...
> > quiesce(PRE_SNAPSHOT_IRQ_OFF)
> 
> There is *no* advantage to this (and _lots_ of disadvantages) compared to 
> saying
> 
> 	dev->snapshot_prepare(dev);
> 	dev->snapshot_freeze(dev);
> 	dev->snapshot(dev)
> 
> The latter is
>  - more readable
>  - MUCH easier for programmers to write readable code for (if-statements 
>    and case-statements are *by*definition* more complicated to parse both 
>    for humans and for CPU's - static information is good)
>  - allows for the different stages to have different arguments, and 
>    somewhat related to that, to have better static C type checking.
> 
> Look here, which one is more readable:
> 
> 	int some_mixed_function(int arg)
> 	{
> 		do_one_thing();
> 		if (arg == SLEEP)
> 			do_another_thing();
> 		else
> 			do_yet_another_thing();
> 	}
> 
> or
> 
> 	int do_sleep(void)
> 	{
> 		do_one_thing();
> 		do_another_thing();
> 	}
> 
> 	int prepare_to_sleep(void)
> 	{
> 		do_one_thing();
> 		do_yet_another_thing();
> 	}
> 
> and quite frankly, while the second case may take more lines of code, 
> anybody who says that it's not clearer what it does (because it can 
> "self-document" with function names etc) is either lying, or just a really 
> bad programmer. The second case is also likely faster and probably not 
> larger code-size-wise either, since it does static decisions _statically_ 
> (since all callers are realistically going to use a constant argument 
> anyway, and the argument really is static).
> 
> Finally, the second case is *much* easier to fix, exactly because it 
> doesn't mix up the cases. You can change the arguments, you can have 
> totally different locking, you don't need things like
> 
> 	int gfp = (arg == SLEEP) ? GFP_ATOMIC : GFP_KERNEL;
> 
> etc, and it's just more logical.
> 
> So don't overload a function. That's the *bug* with the current 
> "dev->suspend()" interface already. Don't re-create it. The current one 
> overloads two *totally*different* operations onto one function. 
> 
> Just don't do it. Not in the suspend part, not *ever*.

OK, I won't.

Greetings,
Rafael

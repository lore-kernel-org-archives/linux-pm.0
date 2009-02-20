From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFD] Automatic suspend
Date: Sat, 21 Feb 2009 00:12:01 +0100
Message-ID: <200902210012.08088.oliver__47969.8899820962$1235171546$gmane$org@neukum.org>
References: <200902192215.18365.rjw@sisk.pl>
	<d6200be20902200326g6caa211ai388d4aa9fc270a28@mail.gmail.com>
	<200902201657.01145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902201657.01145.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Am Freitag 20 Februar 2009 16:56:59 schrieb Rafael J. Wysocki:

> OK, so what about the following approach:
>
> * Keep the decision making logic (power manager etc.) in user space. 
> Reasons: - It may be arbitrarily complicated

Therefore something functionally equivalent to wakelocks
is needed.

>   - It may include such things as s2ram quirks or hal quirks needed for
> some graphics adapters

If you can't do that I'd say the situation is hopeless.
You need full support for all devices including graphics
cards.

> * Have a per-process (per-task or per-thread group, but the former would be
>   easier IMO) "I_do_not_want_automatic_suspend_to_occur" flag.

I think you got the default logic inverted.

> * Add a new callback, say ->acknowledge(), to the set of each driver's PM
>   operations, that will be called to check if the driver has anything
> against automatic suspend (true - suspend can happen right now, false -
> suspend can't happen).
>
> * Introduce /sys/power/sleep that will work like /sys/power/state, but:
>   - First, it will call ->acknowledge() for each driver (via bus types) to
>     check if any of them wants to postpone the suspend (this will prevent
> tasks from being frozen unnecessarily if it is known in advance that the
> suspend should not happen at the moment).

Ideally most devices should be already suspended, so I am not
sure a new callback is really needed. In any cases it is an optimization
only.

>   - Next, it will check the "I_do_not_want_automatic_suspend_to_occur" flag
>     of each process and the suspend will be aborted if it is true for any
> of them (quite frankly, I think that should be integrated with the freezer,
> in particular the tasks that have TIF_FREEZE set shouldn't be able to set
> this flag and it should be checked in the freezer loop for every task with
> TIF_FREEZE unset).

Why in this order?

>   - Next, it will proceed with suspending just like /sys/power/state does
> (the drivers that missed the opportunity to abort the suspend by returning
> 'false' from ->acknowledge() can still abort the suspend by failing their
> ->suspend() routines).
>
> Then, the decision making logic will be able to use /sys/power/sleep
> whenever it wishes to and the kernel will be able to refuse to suspend if
> it's not desirable at the moment.

I think everything that uses a "trigger" logic from user space is not
a good idea. This will necessary introduce a race between the decision
and the execution during which circumstances can change.

So it seems to me that an allow/disallow system from user space
would be better.

	Regards
		Oliver

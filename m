From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Wed, 25 Jul 2007 18:24:29 +0400
Message-ID: <20070725142429.GA299@tv-sign.ru>
References: <200707251401.48340.rjw@sisk.pl> <200707251409.40592.rjw@sisk.pl>
	<20070725132917.GA242@tv-sign.ru> <200707251603.02297.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707251603.02297.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On 07/25, Rafael J. Wysocki wrote:
>
> On Wednesday, 25 July 2007 15:29, Oleg Nesterov wrote:
> > On 07/25, Rafael J. Wysocki wrote:
> > >
> > >  void refrigerator(void)
> > >  {
> > > @@ -50,6 +73,9 @@ void refrigerator(void)
> > >  	   processes around? */
> > >  	long save;
> > >
> > > +	refrigerator_called = 1;
> > > +	wake_up(&refrigerator_waitq);
> > > +
> > 
> > This is a bit racy. Unless I missed something, the task should not set
> > refrigerator_called == 1 until it has PF_FROZEN.
> 
> No, it's just to signal that the task has entered the refrigerator, not that
> it has actually frozen.

Yes, I see.

> > Otherwise, try_to_freeze_tasks() can set refrigerator_called == 0 after
> > refrigerator() sets it == 1, the the main loop notices this unfrozen task,
> > and goes to sleep.
> 
> refrigerator_called is only reset after try_to_freeze_tasks() has found it
> equal to one.  There is only a small window between checking it in
> wait_event_timeout() and resetting it,

Yes.

> but then we go to send freeze requests
> to the remaining tasks and we count 'todo' from the start, so that shouldn't
> be a problem.

... and we find the task which is not frozen() yet, but which has already passed
the "set condition and wakeup", increment todo, and wait for the event. If it was
the last task, we will sleep until timeout.

I agree, this is not fatal and unlikely, but still it is a race. I think it is
better to move this code down, after frozen_process().

(offtopic: strictly speaking, we don't even need the "refrigerator_called", we
 only need the wait_queue_head_t. try_to_freeze_tasks() just adds the "current"
 to wq at the very start of the main loop).

Oleg.

From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Tue, 31 Jul 2007 11:39:23 +0200
Message-ID: <200707311139.24928.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <200707261424.49503.rjw@sisk.pl>
	<20070731080131.GF22419@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070731080131.GF22419@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, pm list <linux-pm@lists.linux-foundation.org>, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 31 July 2007 10:01, Pavel Machek wrote:
> Hi!
> 
> > > > refrigerator_called is only reset after try_to_freeze_tasks() has found it
> > > > equal to one.  There is only a small window between checking it in
> > > > wait_event_timeout() and resetting it,
> > > 
> > > Yes.
> > > 
> > > > but then we go to send freeze requests
> > > > to the remaining tasks and we count 'todo' from the start, so that shouldn't
> > > > be a problem.
> > > 
> > > ... and we find the task which is not frozen() yet, but which has already passed
> > > the "set condition and wakeup", increment todo, and wait for the event. If it was
> > > the last task, we will sleep until timeout.
> > > 
> > > I agree, this is not fatal and unlikely, but still it is a race. I think it is
> > > better to move this code down, after frozen_process().
> > 
> > OK, I see your point.  The updated patch is appended.
> > 
> > > (offtopic: strictly speaking, we don't even need the "refrigerator_called", we
> > >  only need the wait_queue_head_t. try_to_freeze_tasks() just adds the "current"
> > >  to wq at the very start of the main loop).
> > 
> > Hmm, yes, I think so.
> 
> Ok, could we just do schedule_timeout(HZ/10) or something, but when we
> _know_ we woke someone, wakeup() that task? No new variables, keep
> existing logic.

The logic doesn't change that much. :-)

> That should still get most of the benefits, and be two liner, no?

Well, I think we can avoid using refrigerator_called, if this is a problem, but
the patch won't be a two liner.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

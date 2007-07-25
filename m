From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Wed, 25 Jul 2007 16:03:01 +0200
Message-ID: <200707251603.02297.rjw@sisk.pl>
References: <200707251401.48340.rjw@sisk.pl> <200707251409.40592.rjw@sisk.pl>
	<20070725132917.GA242@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070725132917.GA242@tv-sign.ru>
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
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Andres Salomon <dilinger@debian.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Chris Ball <cjb@laptop.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 25 July 2007 15:29, Oleg Nesterov wrote:
> On 07/25, Rafael J. Wysocki wrote:
> >
> >  void refrigerator(void)
> >  {
> > @@ -50,6 +73,9 @@ void refrigerator(void)
> >  	   processes around? */
> >  	long save;
> >
> > +	refrigerator_called = 1;
> > +	wake_up(&refrigerator_waitq);
> > +
> 
> This is a bit racy. Unless I missed something, the task should not set
> refrigerator_called == 1 until it has PF_FROZEN.

No, it's just to signal that the task has entered the refrigerator, not that
it has actually frozen.

> Otherwise, try_to_freeze_tasks() can set refrigerator_called == 0 after
> refrigerator() sets it == 1, the the main loop notices this unfrozen task,
> and goes to sleep.

refrigerator_called is only reset after try_to_freeze_tasks() has found it
equal to one.  There is only a small window between checking it in
wait_event_timeout() and resetting it, but then we go to send freeze requests
to the remaining tasks and we count 'todo' from the start, so that shouldn't
be a problem.

> (I must admit, I agree with Pavel on that patch).

Well, I think it's a good idea (otherwise I wouldn't have posted it ;-)) and
the OLPC people really had a problem with try_to_freeze_tasks() looping too
fast (they reniced it to avoid this problem, but IMO the $subject patch is
nicer than that).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

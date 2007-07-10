From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Tue, 10 Jul 2007 21:54:02 +0200
Message-ID: <200707102154.03531.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
	<20070710185059.GA92@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070710185059.GA92@tv-sign.ru>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 10 July 2007 20:50, Oleg Nesterov wrote:
> On 07/10, Rafael J. Wysocki wrote:
> >
> > +	if (todo && freeze_user_space && !time_after(jiffies, end_time)) {
> > +		/*
> > +		 * Some tasks have not been able to freeze.  They might be stuck
> > +		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
> > +		 * thaw the tasks that have frozen without clearing the freeze
> > +		 * requests of the remaining tasks and repeat.
> > +		 */
> > +		read_lock(&tasklist_lock);
> > +		do_each_thread(g, p) {
> > +			if (frozen(p)) {
> > +				p->flags &= ~PF_FROZEN;
> > +				wake_up_process(p);
> 
> I just noticed we don't use thaw_process(), this means that the retry doesn't
> play well with wait_event_freezable() introduced in the previous patch.
> 
> Suppose that kthread_stop(T) hangs and blocks the freezer, and T does

The retry mechanism only applies to user land processes. :-)

> 	while (!kthread_should_stop()) {
> 		wait_event_freezable(...);
> 		do_something();
> 	}
> 
> and it is freezed. We clear PF_FROZEN but not TIF_FREEZE, wait_event_freezable
> checks freezing() and goes to refrigerator again.

PF_FROZEN and TIF_FREEZE are mutually exclusive as long as the thawing is
not racing with refrigerator().  I don't think that this is of concern here, but we can take
task_lock() in the freezing loop.

> Another problem is that we only count UNINTERRUPTIBLE tasks to make a decision
> about retry, while wait_event_freezable() sleeps NTERRUPTIBLE.

The retry thing doesn't cover kernel threads, because they aren't supposed to
block the freezer.  They are supposed to freeze voluntarily and to know
_exactly_ what they are doing.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth

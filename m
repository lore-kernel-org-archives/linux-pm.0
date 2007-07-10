From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Wed, 11 Jul 2007 00:35:05 +0400
Message-ID: <20070710203505.GA148@tv-sign.ru>
References: <200707092229.08898.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
	<20070710185059.GA92@tv-sign.ru> <200707102154.03531.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707102154.03531.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On 07/10, Rafael J. Wysocki wrote:
>
> On Tuesday, 10 July 2007 20:50, Oleg Nesterov wrote:
> > 
> > I just noticed we don't use thaw_process(), this means that the retry doesn't
> > play well with wait_event_freezable() introduced in the previous patch.
> > 
> > Suppose that kthread_stop(T) hangs and blocks the freezer, and T does
> 
> The retry mechanism only applies to user land processes. :-)
> 
> > 	while (!kthread_should_stop()) {
> > 		wait_event_freezable(...);
> > 		do_something();
> > 	}
> > 
> > and it is freezed. We clear PF_FROZEN but not TIF_FREEZE, wait_event_freezable
> > checks freezing() and goes to refrigerator again.
> 
> PF_FROZEN and TIF_FREEZE are mutually exclusive as long as the thawing is
> not racing with refrigerator().

Ah yes, I forgot. Thanks!

> > Another problem is that we only count UNINTERRUPTIBLE tasks to make a decision
> > about retry, while wait_event_freezable() sleeps NTERRUPTIBLE.
> 
> The retry thing doesn't cover kernel threads, because they aren't supposed to
> block the freezer.  They are supposed to freeze voluntarily and to know
> _exactly_ what they are doing.

Ok, I see... So, the plan is to eventually fix the "problematic" things like
kthread_stop(), yes?  Unless I missed something again, we can't reliably
kthread_stop() the thread above even if it does

	wait_event_freezable(my_condition || kthread_should_stop())

Oleg.

From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Wed, 11 Jul 2007 00:55:08 +0400
Message-ID: <20070710205508.GA173@tv-sign.ru>
References: <200707092229.08898.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
	<20070710171704.GA406@tv-sign.ru> <200707102230.33407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707102230.33407.rjw@sisk.pl>
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
> On Tuesday, 10 July 2007 19:17, Oleg Nesterov wrote:
> 
> > Just watch the "todo", it it doesn't decrease during BREAK_TIMEOUT, then retry.
> > No?
> 
> No, it is computed from the start in every interation and I compare the result
> from the previous iteration with the current result.  Still, I don't compare 'todo'
> with 'todo from the previous step' directly, because the lock up can only
> happen if 'todo' is equal to 'blocking'.  For this reason, it is sufficient to
> compare 'blocking' with 'prev_blocking' (ie. 'blocking' from the previous
> step) and 'todo' with 'blocking' (the test if 'todo' > 0 is not essential;
> well, I should remove it in accordance with my signature ;-)).

Yes, I see what the code does. My question was: why it is not good enough to just
compare 'todo' with 'todo from the previous step' ? If 'todo' does not decrease
during the BREAK_TIMEOUT period, probably we should retry. A fork() from user-space
should not succeed because we send a fake signal to all tasks.

> > > +	if (todo && freeze_user_space && !time_after(jiffies, end_time)) {
> > > +		/*
> > > +		 * Some tasks have not been able to freeze.  They might be stuck
> > > +		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
> > > +		 * thaw the tasks that have frozen without clearing the freeze
> > > +		 * requests of the remaining tasks and repeat.
> > > +		 */
> > 
> > Another question, why do we check "freeze_user_space" here?
> 
> Well, the assumption is that the freezable kernel threads won't lock up the
> freezer in such a way (that may be overoptimistic, but I'd like to make it
> for now).

OK, understand.

Oleg.

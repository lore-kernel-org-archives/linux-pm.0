From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Re: [RFC][PATCH -mm 5/6] Freezer: Use freezing timeout
	more efficiently
Date: Tue, 10 Jul 2007 22:50:59 +0400
Message-ID: <20070710185059.GA92@tv-sign.ru>
References: <200707092229.08898.rjw@sisk.pl> <20070709233414.GI1967@elf.ucw.cz>
	<200707100809.38466.rjw@sisk.pl> <200707101204.42687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707101204.42687.rjw@sisk.pl>
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
> +	if (todo && freeze_user_space && !time_after(jiffies, end_time)) {
> +		/*
> +		 * Some tasks have not been able to freeze.  They might be stuck
> +		 * in TASK_UNINTERRUPTIBLE waiting for the frozen tasks.  Try to
> +		 * thaw the tasks that have frozen without clearing the freeze
> +		 * requests of the remaining tasks and repeat.
> +		 */
> +		read_lock(&tasklist_lock);
> +		do_each_thread(g, p) {
> +			if (frozen(p)) {
> +				p->flags &= ~PF_FROZEN;
> +				wake_up_process(p);

I just noticed we don't use thaw_process(), this means that the retry doesn't
play well with wait_event_freezable() introduced in the previous patch.

Suppose that kthread_stop(T) hangs and blocks the freezer, and T does

	while (!kthread_should_stop()) {
		wait_event_freezable(...);
		do_something();
	}

and it is freezed. We clear PF_FROZEN but not TIF_FREEZE, wait_event_freezable
checks freezing() and goes to refrigerator again.

Another problem is that we only count UNINTERRUPTIBLE tasks to make a decision
about retry, while wait_event_freezable() sleeps NTERRUPTIBLE.

Oleg.

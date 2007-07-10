From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [RFC][PATCH -mm 2/6] Freezer: Do not send signals to
	kernel threads
Date: Tue, 10 Jul 2007 19:00:50 +0400
Message-ID: <20070710150050.GA158@tv-sign.ru>
References: <200707092229.08898.rjw@sisk.pl> <200707092232.01603.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707092232.01603.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 07/09, Rafael J. Wysocki wrote:
>
> Commit b74d0deb968e1f85942f17080eace015ce3c332c has changed
> recalc_sigpending_tsk() so that it doesn't clear TIF_SIGPENDING.  For this
> reason, the freezer should not send fake signals to kernel threads any more,
> since otherwise some of them may run with TIF_SIGPENDING set forever if the
> freezing of kernel threads fails.

I personally think it is very good to get rid of signals to kthread, regardless
of changed behaviour of recalc_sigpending_tsk().

> +static int freeze_user_process(struct task_struct *p)
> +{
> +	int ret = 1;
> +
> +	task_lock(p);
> +	if (has_mm(p)) {
> +		if (freezing(p)) {
> +			if (!signal_pending(p))
> +				fake_signal_wake_up(p, 0);
> +			else
> +				wake_up_state(p, TASK_INTERRUPTIBLE);

Why do we need the "else" branch? It is already a bug if the task sleeps
in TASK_INTERRUPTIBLE state but has signal_pending().

The same for freeze_task(). Actually, they look very similar. Imho, it would
be better to have a single function with a "user_space_only" parameter.

> @@ -99,7 +99,6 @@ static inline int has_pending_signals(si
>  static int recalc_sigpending_tsk(struct task_struct *t)
>  {
>  	if (t->signal->group_stop_count > 0 ||
> -	    (freezing(t)) ||
>  	    PENDING(&t->pending, &t->blocked) ||
>  	    PENDING(&t->signal->shared_pending, &t->blocked)) {
>  		set_tsk_thread_flag(t, TIF_SIGPENDING);

This is important (and imho good) change, but changelog says nothing about it.

I guess this should works because freeze_user_process/freeze_task repeatedly
"re-send" the signal in a loop when TIF_SIGPENDING is cleared, yes?

> +#define wait_event_freezable(wq, condition)				\
> +({									\
> +	int __ret;							\
> +	do {								\
> +		__ret = wait_event_interruptible(wq, 			\
> +				(condition) || freezing(current));	\
> +	} while (try_to_freeze());					\
> +	__ret;								\
> +})

I don't think this is right.

wait_event_freezable() should return success _only_ if "condition" == true.
What if TIF_FREEZE was cleared between freezing() and try_to_freeze() ?

> --- linux-2.6.22-rc6-mm1.orig/drivers/input/gameport/gameport.c
> +++ linux-2.6.22-rc6-mm1/drivers/input/gameport/gameport.c
> @@ -448,9 +448,8 @@ static int gameport_thread(void *nothing
>  	set_freezable();
>  	do {
>  		gameport_handle_event();
> -		wait_event_interruptible(gameport_wait,
> +		wait_event_freezable(gameport_wait,
>  			kthread_should_stop() || !list_empty(&gameport_event_list));
> -		try_to_freeze();
>  	} while (!kthread_should_stop());

Isn't it better to break this patch into 2 separate ones? The first adds
wait_event_freezable() and "fixes" gameport_thread() and friends in advance,
the second deals with TIF_SIGPENDING. (please ignore if this is not convenient).

Oleg.

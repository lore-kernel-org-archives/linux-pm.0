From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Mon, 20 Apr 2009 11:29:05 +0200
Message-ID: <20090420092905.GB8873@elf.ucw.cz>
References: <1239759692-28617-1-git-send-email-arve@android.com>
	<1239759692-28617-2-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1239759692-28617-2-git-send-email-arve@android.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj??nnev??g <arve@android.com>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!


> +Driver API
> +==========
> +
> +A driver can use the suspend block api by adding a suspend_blocker variable to
> +its state and calling suspend_blocker_init. For instance:
> +struct state {
> +	struct suspend_blocker suspend_blocker;
> +}
> +
> +init() {
> +	suspend_blocker_init(&state->suspend_blocker, "suspend-blocker-name");
> +}
> +
> +Before freeing the memory, suspend_blocker_destroy must be called:
> +
> +uninit() {
> +	suspend_blocker_destroy(&state->suspend_blocker);
> +}
> +
> +When the driver determines that it needs to run (usually in an interrupt
> +handler) it calls suspend_block:
> +	suspend_block(&state->suspend_blocker);
> +
> +When it no longer needs to run it calls suspend_unblock:
> +	suspend_unblock(&state->suspend_blocker);

Sounds reasonably sane. Maybe it should be block_suspend(), because
suspend_block() sounds like... something that builds suspend, but I
guess it is good enough.

> +/* A suspend_blocker prevents the system from entering suspend when active.
> + */
> +

linuxdoc?

> +struct suspend_blocker {
> +#ifdef CONFIG_SUSPEND_BLOCK
> +	atomic_t            flags;
> +	const char         *name;
> +#endif
> +};
> +
> +#ifdef CONFIG_SUSPEND_BLOCK
> +
> +void suspend_blocker_init(struct suspend_blocker *blocker, const char *name);
> +void suspend_blocker_destroy(struct suspend_blocker *blocker);
> +void suspend_block(struct suspend_blocker *blocker);
> +void suspend_unblock(struct suspend_blocker *blocker);
> +
> +/* is_blocking_suspend returns true if the suspend_blocker is currently active.
> + */
> +bool is_blocking_suspend(struct suspend_blocker *blocker);

Same here?

> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 23bd4da..9d1df13 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -116,6 +116,16 @@ config SUSPEND_FREEZER
>  
>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  
> +config SUSPEND_BLOCK
> +	bool "Suspend block"
> +	depends on PM
> +	select RTC_LIB

Is RTC_LIB okay to select?

> @@ -392,6 +393,9 @@ static void suspend_finish(void)
>  
>  
>  static const char * const pm_states[PM_SUSPEND_MAX] = {
> +#ifdef CONFIG_SUSPEND_BLOCK
> +	[PM_SUSPEND_ON]		= "on",
> +#endif
>  	[PM_SUSPEND_STANDBY]	= "standby",
>  	[PM_SUSPEND_MEM]	= "mem",
>  };

This allows you to write "on" to the other interfaces where that makes
no sense.... right?

> +static bool enable_suspend_blockers;

Uhuh... What is this good for... except debugging?

> +bool suspend_is_blocked(void)
> +{
> +	if (WARN_ONCE(!enable_suspend_blockers, "ignoring suspend blockers\n"))
> +		return 0;
> +	return !!atomic_read(&suspend_block_count);
> +}

Yes, if enable_suspend_blockers is one, we are in deep trouble.

> +/**
> + * suspend_blocker_init() - Initialize a suspend blocker
> + * @blocker:	The suspend blocker to initialize.
> + * @name:	The name of the suspend blocker to show in
> + *		/proc/suspend_blockers

I don't think suspend_blockers should go to /proc. They are not process-related.

> +/**
> + * suspend_block() - Block suspend
> + * @blocker:	The suspend blocker to use
> + */
> +void suspend_block(struct suspend_blocker *blocker)
> +{
> +	BUG_ON(!(atomic_read(&blocker->flags) & SB_INITIALIZED));
As blocker->flags seem to be used mostly for debugging; do they have
to use "atomic"? Normally, "magic" variable is used, instead. (Single
bit is probably not enough to guard against using uninitialized
memory.)

> + * suspend_unblock() - Unblock suspend
> + * @blocker:	The suspend blocker to unblock.
> + *
> + * If no other suspend blockers block suspend, the system will suspend.
> + */
> +void suspend_unblock(struct suspend_blocker *blocker)
> +{

...BUG_ON(!(atomic_read(&blocker->flags) & SB_INITIALIZED)); ?

> +	if (debug_mask & DEBUG_SUSPEND_BLOCKER)
> +		pr_info("suspend_unblock: %s\n", blocker->name);
> +
> +	if (atomic_cmpxchg(&blocker->flags, SB_INITIALIZED | SB_ACTIVE,
> +	    SB_INITIALIZED) == (SB_INITIALIZED | SB_ACTIVE))
> +		if (atomic_dec_and_test(&suspend_block_count))
> +			queue_work(suspend_work_queue, &suspend_work);
> +}
> +EXPORT_SYMBOL(suspend_unblock);

Uhuh... can we "loose a oportunity to suspend" here? If someone is
just updating the flags...? Is it guaranteed that if two people do
suspend_unblock at the same time, one of them will pass?

> +void request_suspend_state(suspend_state_t state)
> +{
> +	unsigned long irqflags;
> +	spin_lock_irqsave(&state_lock, irqflags);
> +	if (debug_mask & DEBUG_USER_STATE) {
> +		struct timespec ts;
> +		struct rtc_time tm;
> +		getnstimeofday(&ts);
> +		rtc_time_to_tm(ts.tv_sec, &tm);
> +		pr_info("request_suspend_state: %s (%d->%d) at %lld "
> +			"(%d-%02d-%02d %02d:%02d:%02d.%09lu UTC)\n",
> +			state != PM_SUSPEND_ON ? "sleep" : "wakeup",
> +			requested_suspend_state, state,
> +			ktime_to_ns(ktime_get()),
> +			tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec, ts.tv_nsec);

Introduce macro for printing time?

Otherwise, it looks good...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Thu, 5 Feb 2009 10:16:20 +0100
Message-ID: <20090205091620.GI2077@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1233802226-23386-4-git-send-email-arve@android.com>
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


> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 23bd4da..6e3da6e 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -116,6 +116,25 @@ config SUSPEND_FREEZER
>  
>  	  Turning OFF this setting is NOT recommended! If in doubt, say Y.
>  
> +config HAS_WAKELOCK
> +	bool
> +
> +config WAKELOCK
> +	bool "Wake lock"
> +	depends on PM && RTC_CLASS

?

> +	default n
> +	select HAS_WAKELOCK
> +	---help---
> +	  Enable wakelocks. When user space request a sleep state the
> +	  sleep request will be delayed until no wake locks are held.

Not true... for /sys/power/state anyway.

> +int get_expired_time(struct wake_lock *lock, ktime_t *expire_time)
> +{
> +	struct timespec ts;
> +	struct timespec kt;
> +	struct timespec tomono;
> +	struct timespec delta;
> +	unsigned long seq;
> +	long timeout;
> +
> +	if (!(lock->flags & WAKE_LOCK_AUTO_EXPIRE))
> +		return 0;
> +	do {
> +		seq = read_seqbegin(&xtime_lock);
> +		timeout = lock->expires - jiffies;
> +		if (timeout > 0)
> +			return 0;
> +		kt = current_kernel_time();
> +		tomono = wall_to_monotonic;
> +	} while (read_seqretry(&xtime_lock, seq));
> +	jiffies_to_timespec(-timeout, &delta);
> +	set_normalized_timespec(&ts, kt.tv_sec + tomono.tv_sec - delta.tv_sec,
> +				kt.tv_nsec + tomono.tv_nsec - delta.tv_nsec);
> +	*expire_time = timespec_to_ktime(ts);
> +	return 1;
> +}
> +
> +
> +static int print_lock_stat(char *buf, struct wake_lock *lock)
> +{
> +	int lock_count = lock->stat.count;
> +	int expire_count = lock->stat.expire_count;
> +	ktime_t active_time = ktime_set(0, 0);
> +	ktime_t total_time = lock->stat.total_time;
> +	ktime_t max_time = lock->stat.max_time;
> +	ktime_t prevent_suspend_time = lock->stat.prevent_suspend_time;
> +	if (lock->flags & WAKE_LOCK_ACTIVE) {
> +		ktime_t now, add_time;
> +		int expired = get_expired_time(lock, &now);
> +		if (!expired)
> +			now = ktime_get();
> +		add_time = ktime_sub(now, lock->stat.last_time);
> +		lock_count++;
> +		if (!expired)
> +			active_time = add_time;
> +		else
> +			expire_count++;
> +		total_time = ktime_add(total_time, add_time);
> +		if (lock->flags & WAKE_LOCK_PREVENTING_SUSPEND)
> +			prevent_suspend_time = ktime_add(prevent_suspend_time,
> +					ktime_sub(now, last_sleep_time_update));
> +		if (add_time.tv64 > max_time.tv64)
> +			max_time = add_time;
> +	}
> +
> +	return sprintf(buf, "\"%s\"\t%d\t%d\t%d\t%lld\t%lld\t%lld\t%lld\t"
> +		       "%lld\n", lock->name, lock_count, expire_count,
> +		       lock->stat.wakeup_count, ktime_to_ns(active_time),
> +		       ktime_to_ns(total_time),
> +		       ktime_to_ns(prevent_suspend_time), ktime_to_ns(max_time),
> +		       ktime_to_ns(lock->stat.last_time));
> +}

I guess these should be documented somewhere.

> +static void  __exit wakelocks_exit(void)
> +{
> +#ifdef CONFIG_WAKELOCK_STAT
> +	remove_proc_entry("wakelocks", NULL);
> +#endif

You certainly do not want /proc/wakelocks. Seems like debugfs
material.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

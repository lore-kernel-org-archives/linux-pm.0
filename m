From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Tue, 10 Feb 2009 18:52:43 -0800
Message-ID: <d6200be20902101852k43304736o70c6dd4598b76bb1@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<200902072327.11251.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902072327.11251.rjw@sisk.pl>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 7, 2009 at 2:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> +{
>> +     struct timespec ts;
>> +     struct timespec kt;
>> +     struct timespec tomono;
>> +     struct timespec delta;
>> +     unsigned long seq;
>> +     long timeout;
>> +
>> +     if (!(lock->flags & WAKE_LOCK_AUTO_EXPIRE))
>> +             return 0;
>> +     do {
>> +             seq =3D read_seqbegin(&xtime_lock);
>> +             timeout =3D lock->expires - jiffies;
>
> Can it overflow?

Yes, but I have not fixed this since you have to hold a wakelock for
several months to hit it. I could fix it may expiring wakelocks at
least every MAX_JIFFY_OFFSET or by moving to jiffies_64.

> Anyway, you are using struct timespec in computations, so why don't you
> store it in the lock structure?

I only use struct timespec for the stats.

>> +
>> +static int print_lock_stat(char *buf, struct wake_lock *lock)
>> +{
>> +     int lock_count =3D lock->stat.count;
>> +     int expire_count =3D lock->stat.expire_count;
>> +     ktime_t active_time =3D ktime_set(0, 0);
>> +     ktime_t total_time =3D lock->stat.total_time;
>> +     ktime_t max_time =3D lock->stat.max_time;
>> +     ktime_t prevent_suspend_time =3D lock->stat.prevent_suspend_time;
>> +     if (lock->flags & WAKE_LOCK_ACTIVE) {
>> +             ktime_t now, add_time;
>> +             int expired =3D get_expired_time(lock, &now);
>> +             if (!expired)
>> +                     now =3D ktime_get();
>> +             add_time =3D ktime_sub(now, lock->stat.last_time);
>> +             lock_count++;
>> +             if (!expired)
>> +                     active_time =3D add_time;
>> +             else
>> +                     expire_count++;
>> +             total_time =3D ktime_add(total_time, add_time);
>> +             if (lock->flags & WAKE_LOCK_PREVENTING_SUSPEND)
>> +                     prevent_suspend_time =3D ktime_add(prevent_suspend=
_time,
>> +                                     ktime_sub(now, last_sleep_time_upd=
ate));
>> +             if (add_time.tv64 > max_time.tv64)
>> +                     max_time =3D add_time;
>> +     }
>> +
>> +     return sprintf(buf, "\"%s\"\t%d\t%d\t%d\t%lld\t%lld\t%lld\t%lld\t"
>> +                    "%lld\n", lock->name, lock_count, expire_count,
>> +                    lock->stat.wakeup_count, ktime_to_ns(active_time),
>> +                    ktime_to_ns(total_time),
>> +                    ktime_to_ns(prevent_suspend_time), ktime_to_ns(max_=
time),
>> +                    ktime_to_ns(lock->stat.last_time));
>> +}
>> +
>
> Why did you decide to put that in /proc ?

That's where most other stats are reported.

>> +static long has_wake_lock_locked(int type)
>
> I'd change the name, it suggests something different from what the functi=
on
> does.

It does what the name suggest, and more. The code that just cares if
there are lock held or not is easier to read this way.

>> +{
>> +     struct wake_lock *lock, *n;
>> +     long max_timeout =3D 0;
>> +
>> +     BUG_ON(type >=3D WAKE_LOCK_TYPE_COUNT);
>> +     list_for_each_entry_safe(lock, n, &active_wake_locks[type], link) {
>> +             if (lock->flags & WAKE_LOCK_AUTO_EXPIRE) {
>> +                     long timeout =3D lock->expires - jiffies;
>
> I think time_after() is for things like this.

time_after does not return the timeout, which I need here. I changed
another instance though.

>> +static void suspend(struct work_struct *work)
>> +{
>> +     int ret;
>> +     int entry_event_num;
>> +
>> +     if (has_wake_lock(WAKE_LOCK_SUSPEND)) {
>> +             if (debug_mask & DEBUG_SUSPEND)
>> +                     pr_info("suspend: abort suspend\n");
>> +             return;
>> +     }
>> +
>> +     entry_event_num =3D current_event_num;
>> +     sys_sync();
>
> pm_suspend() will do it, you don't need to.

Removed.

>
>> +     if (debug_mask & DEBUG_SUSPEND)
>> +             pr_info("suspend: enter suspend\n");
>
> Shouldn't that check if someone has taken a wakelock in the meantime?

It checks at the top of the function. With sys_sync gone, another
check would not be useful.

>> +     ret =3D pm_suspend(requested_suspend_state);


>> +static int power_suspend_late(struct platform_device *pdev, pm_message_=
t state)
>> +{
>> +     int ret =3D has_wake_lock(WAKE_LOCK_SUSPEND) ? -EAGAIN : 0;
>> +#ifdef CONFIG_WAKELOCK_STAT
>> +     wait_for_wakeup =3D 1;
>> +#endif
>> +     if (debug_mask & DEBUG_SUSPEND)
>> +             pr_info("power_suspend_late return %d\n", ret);
>> +     return ret;
>> +}
>> +
>> +static struct platform_driver power_driver =3D {
>> +     .driver.name =3D "power",
>> +     .suspend_late =3D power_suspend_late,
>> +};
>> +static struct platform_device power_device =3D {
>> +     .name =3D "power",
>> +};
>
> What's this and what's it for?

It makes sure suspend fails if a wakelock is locked while suspending.
Is there a simpler way to register a suspend_late handler?

>> +void wake_lock_init(struct wake_lock *lock, int type, const char *name)
>> +{
>> +     unsigned long irqflags =3D 0;
>> +
>> +     if (name)
>> +             lock->name =3D name;
>
> Hm.  I'd rather reserve memory for the name and copy it from the address
> provided by the caller.

I'd rather not. With the current interface, wake_lock_init can never fail.

>> +     BUG_ON(!lock->name);
>
> Isn't it a bit too drastic?  Perhaps make it return a value so that the c=
aller
> can check if it has the lock?

I think a BUG_ON is appropriate. Calling wake_lock_init with an
invalid argument is a driver bug.

>> +static void wake_lock_internal(
>
> What  about __wake_lock() ?

OK.

>
>> +     struct wake_lock *lock, long timeout, int has_timeout)
>
> What's the point of the last argument?  Wouldn't timeout =3D=3D 0 be suff=
icient?

No, timeout =3D=3D 0 means expire immediately.

> Also, does it make sense to pass negative timeout to it?

A negative timeout is fine, as long as it does not underflow.

>
>> +{
>> +     int type;
>> +     unsigned long irqflags;
>> +     long expire_in;
>> +
>> +     spin_lock_irqsave(&list_lock, irqflags);
>> +     type =3D lock->flags & WAKE_LOCK_TYPE_MASK;
>> +     BUG_ON(type >=3D WAKE_LOCK_TYPE_COUNT);
>> +     BUG_ON(!(lock->flags & WAKE_LOCK_INITIALIZED));
>
> I don't like these BUG_ON()s.  Please do something less drastic instead.
>
>> +#ifdef CONFIG_WAKELOCK_STAT
>> +     if (type =3D=3D WAKE_LOCK_SUSPEND && wait_for_wakeup) {
>> +             if (debug_mask & DEBUG_WAKEUP)
>> +                     pr_info("wakeup wake lock: %s\n", lock->name);
>> +             wait_for_wakeup =3D 0;
>> +             lock->stat.wakeup_count++;
>> +     }
>> +     if ((lock->flags & WAKE_LOCK_AUTO_EXPIRE) &&
>> +         (long)(lock->expires - jiffies) <=3D 0) {
>> +             wake_unlock_stat_locked(lock, 0);
>> +             lock->stat.last_time =3D ktime_get();
>> +     }
>> +#endif
>> +     if (!(lock->flags & WAKE_LOCK_ACTIVE)) {
>> +             lock->flags |=3D WAKE_LOCK_ACTIVE;
>> +#ifdef CONFIG_WAKELOCK_STAT
>> +             lock->stat.last_time =3D ktime_get();
>> +#endif
>> +     }
>> +     list_del(&lock->link);
>> +     if (has_timeout) {
>> +             if (debug_mask & DEBUG_WAKE_LOCK)
>> +                     pr_info("wake_lock: %s, type %d, timeout %ld.%03lu=
\n",
>> +                             lock->name, type, timeout / HZ,
>> +                             (timeout % HZ) * MSEC_PER_SEC / HZ);
>> +             lock->expires =3D jiffies + timeout;
>> +             lock->flags |=3D WAKE_LOCK_AUTO_EXPIRE;
>> +             list_add_tail(&lock->link, &active_wake_locks[type]);
>> +     } else {
>> +             if (debug_mask & DEBUG_WAKE_LOCK)
>> +                     pr_info("wake_lock: %s, type %d\n", lock->name, ty=
pe);
>> +             lock->expires =3D LONG_MAX;
>> +             lock->flags &=3D ~WAKE_LOCK_AUTO_EXPIRE;
>> +             list_add(&lock->link, &active_wake_locks[type]);
>> +     }
>
> Why not to use list_add_tail() in both cases?

If you add a wakelock with no timeout, there is no reason for
has_wake_lock_locked to look at more than one wakelock.

>
>> +     if (type =3D=3D WAKE_LOCK_SUSPEND) {
>> +             current_event_num++;
>> +#ifdef CONFIG_WAKELOCK_STAT
>> +             if (lock =3D=3D &main_wake_lock)
>> +                     update_sleep_wait_stats_locked(1);
>> +             else if (!wake_lock_active(&main_wake_lock))
>> +                     update_sleep_wait_stats_locked(0);
>> +#endif
>> +             if (has_timeout)
>> +                     expire_in =3D has_wake_lock_locked(type);
>> +             else
>> +                     expire_in =3D -1;
>
>        expire_i =3D has_timeout ? has_wake_lock_locked(type) : -1;
>
> (there is something like this above too).
>
>> +             if (expire_in > 0) {
>> +                     if (debug_mask & DEBUG_EXPIRE)
>> +                             pr_info("wake_lock: %s, start expire timer=
, "
>> +                                     "%ld\n", lock->name, expire_in);
>> +                     mod_timer(&expire_timer, jiffies + expire_in);
>
> What exactly are you trying to achieve here?

Unlock wakelocks with timeouts when doing so can allow the system to
go to sleep.

>
>> +             } else {
>> +                     if (del_timer(&expire_timer))
>> +                             if (debug_mask & DEBUG_EXPIRE)
>> +                                     pr_info("wake_lock: %s, stop expir=
e "
>> +                                             "timer\n", lock->name);
>> +                     if (expire_in =3D=3D 0)
>> +                             queue_work(suspend_work_queue, &suspend_wo=
rk);
>
> This appears to only happen if timeout =3D 0 is passed to this function w=
hile
> has_timeout =3D=3D true.  Is it correct?

Unless you are on a system where jiffies can change while this
function is running, then yes.

>> +     ret =3D platform_device_register(&power_device);
>> +     if (ret) {
>> +             pr_err("wakelocks_init: platform_device_register failed\n"=
);
>> +             goto err_platform_device_register;
>> +     }
>> +     ret =3D platform_driver_register(&power_driver);
>> +     if (ret) {
>> +             pr_err("wakelocks_init: platform_driver_register failed\n"=
);
>> +             goto err_platform_driver_register;
>> +     }
>
> Is this really a platform thing?
>
> What exactly is the benefit of having the 'power_device' and 'power_drive=
r'
> registered?.

I need both for suspend_late to be called.


> Also, I'd really prefer to see the patch without the CONFIG_WAKELOCK_STAT
> thing included, first.  It would have been much easier to read.

I moved more of the stats code to the CONFIG_WAKELOCK_STAT section
which should help.

-- =

Arve Hj=F8nnev=E5g

From: mark gross <mgross@linux.intel.com>
Subject: Re: [PATCH 03/13] PM: Implement wakelock api.
Date: Fri, 6 Feb 2009 16:33:35 -0800
Message-ID: <20090207003334.GA13923@linux.intel.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-2-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<1233802226-23386-4-git-send-email-arve@android.com>
	<20090206001020.GC19577@linux.intel.com>
	<d6200be20902051638p37fb012do8e0aad0e67cf4305@mail.gmail.com>
Reply-To: mgross@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d6200be20902051638p37fb012do8e0aad0e67cf4305@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 05, 2009 at 04:38:04PM -0800, Arve Hj=F8nnev=E5g wrote:
> On Thu, Feb 5, 2009 at 4:10 PM, mark gross <mgross@linux.intel.com> wrote:
> > On Wed, Feb 04, 2009 at 06:50:16PM -0800, Arve Hj=F8nnev=E5g wrote:
> >> +static void update_sleep_wait_stats_locked(int done)
> >> +{
> >> +     struct wake_lock *lock;
> >> +     ktime_t now, etime, elapsed, add;
> >> +     int expired;
> >> +
> >> +     now =3D ktime_get();
> >> +     elapsed =3D ktime_sub(now, last_sleep_time_update);
> >> +     list_for_each_entry(lock, &active_wake_locks[WAKE_LOCK_SUSPEND],=
 link) {
> >
> > Is this list opperation SMP safe?  what if some on on the other CPU
> > removes a lock form user mode while walking this guy?  this goes for all
> > your list walking.
> =

> I have not tested the code on an SMP system, but the list is protected
> by a spinlock.

ok, I was just looking for it and didn't notice it in the calling code.

> =

> >> +static void expire_wake_lock(struct wake_lock *lock)
> >> +{
> >> +#ifdef CONFIG_WAKELOCK_STAT
> >> +     wake_unlock_stat_locked(lock, 1);
> >> +#endif
> >> +     lock->flags &=3D ~(WAKE_LOCK_ACTIVE | WAKE_LOCK_AUTO_EXPIRE);
> >> +     list_del(&lock->link);
> >> +     list_add(&lock->link, &inactive_locks);
> >> +     if (debug_mask & (DEBUG_WAKE_LOCK | DEBUG_EXPIRE))
> >> +             pr_info("expired wake lock %s\n", lock->name);
> >> +}
> >
> > Are we missing locking for this list opperation?
> =

> No.

ok.

> =

> >> +static void suspend(struct work_struct *work)
> >
> > there are a lot of "suspend" functions in the kernel already that have
> > different calling semantics, can we change this name so my TAG file is
> > more sane?
> =

> OK.
> =

> >
> >> +{
> >> +     int ret;
> >> +     int entry_event_num;
> >> +
> >> +     if (has_wake_lock(WAKE_LOCK_SUSPEND)) {
> >> +             if (debug_mask & DEBUG_SUSPEND)
> >> +                     pr_info("suspend: abort suspend\n");
> >> +             return;
> >> +     }
> >> +
> >> +     entry_event_num =3D current_event_num;
> >> +     sys_sync();
> >
> > um, this feel wrong to me.
> =

> Wrong or redundant? I can remove sys_sync here since pm_suspend calls it =
anyway.

its just a latency enhanced api call I wouldn't expect to see called.

> =

> >
> >> +     if (debug_mask & DEBUG_SUSPEND)
> >> +             pr_info("suspend: enter suspend\n");
> >> +     ret =3D pm_suspend(requested_suspend_state);
> >
> > oh, you are adding yet another path to getting the system into a
> > suspended state.  is this necessary?
> =

> Yes.
> =

> >> +#ifdef CONFIG_WAKELOCK_STAT
> >> +     create_proc_read_entry("wakelocks", S_IRUGO, NULL,
> >> +                             wakelocks_read_proc, NULL);
> >
> > Shouldn't we *not* be using /proc?  I think this should be under sysfs.
> =

> It is not allowed under sysfs. Debugfs has been suggested, but we
> don't have debugfs mounted, and we include the wakelock stats in debug
> reports.
> =


why not under sysfs?  =


--mgross

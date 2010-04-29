From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Thu, 29 Apr 2010 23:16:14 +0200
Message-ID: <201004292316.14524.rjw@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004282250.44200.rjw@sisk.pl>
	<l2yd6200be21004282037rc063266by91db7f732ceaa529@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <l2yd6200be21004282037rc063266by91db7f732ceaa529@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 April 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> ...
> >>
> >> +/**
> >> + *   policy - set policy for state
> >> + */
> >> +
> >> +static ssize_t policy_show(struct kobject *kobj,
> >> +                        struct kobj_attribute *attr, char *buf)
> >> +{
> >> +     char *s =3D buf;
> >> +     int i;
> >> +
> >> +     for (i =3D 0; i < ARRAY_SIZE(policies); i++) {
> >> +             if (i =3D=3D policy)
> >> +                     s +=3D sprintf(s, "[%s] ", policies[i].name);
> >> +             else
> >> +                     s +=3D sprintf(s, "%s ", policies[i].name);
> >> +     }
> >> +     if (s !=3D buf)
> >> +             /* convert the last space to a newline */
> >> +             *(s-1) =3D '\n';
> >> +     return (s - buf);
> >> +}
> >> +
> >> +static ssize_t policy_store(struct kobject *kobj,
> >> +                         struct kobj_attribute *attr,
> >> +                         const char *buf, size_t n)
> >> +{
> >> +     const char *s;
> >> +     char *p;
> >> +     int len;
> >> +     int i;
> >> +
> >> +     p =3D memchr(buf, '\n', n);
> >> +     len =3D p ? p - buf : n;
> >> +
> >> +     for (i =3D 0; i < ARRAY_SIZE(policies); i++) {
> >> +             s =3D policies[i].name;
> >> +             if (s && len =3D=3D strlen(s) && !strncmp(buf, s, len)) {
> >> +                     mutex_lock(&pm_mutex);
> >> +                     policies[policy].set_state(PM_SUSPEND_ON);
> >> +                     policy =3D i;
> >> +                     mutex_unlock(&pm_mutex);
> >> +                     return n;
> >> +             }
> >> +     }
> >> +     return -EINVAL;
> >> +}
> >> +
> >> +power_attr(policy);
> >> +
> >>  #ifdef CONFIG_PM_TRACE
> >>  int pm_trace_enabled;
> >>
> >
> > Would you mind if I changed the above so that "policy" doesn't even sho=
w up
> > if CONFIG_OPPORTUNISTIC_SUSPEND is unset?
> >
> I don't mind, but It did not seem worth the trouble to hide it. It
> will only list the supported policies, and it is easy to add or remove
> policies this way.
> =

> > ...
> >> +static void suspend_worker(struct work_struct *work)
> >> +{
> >> +     int ret;
> >> +     int entry_event_num;
> >> +
> >> +     enable_suspend_blockers =3D true;
> >> +     while (!suspend_is_blocked()) {
> >> +             entry_event_num =3D current_event_num;
> >> +
> >> +             if (debug_mask & DEBUG_SUSPEND)
> >> +                     pr_info("suspend: enter suspend\n");
> >> +
> >> +             ret =3D pm_suspend(requested_suspend_state);
> >> +
> >> +             if (debug_mask & DEBUG_EXIT_SUSPEND)
> >> +                     pr_info_time("suspend: exit suspend, ret =3D %d =
", ret);
> >> +
> >> +             if (current_event_num =3D=3D entry_event_num)
> >> +                     pr_info("suspend: pm_suspend returned with no ev=
ent\n");
> >
> > Hmm, what exactly is this for?  It looks like a debug thing to me.  I'd=
 use
> > pr_debug() here and in both debug printk()s above.  Would you agree?
> >
> =

> If the driver that caused the wakeup does not use suspend blockers, we
> the only choice is to try to suspend again. I want to know if this
> happened. The stats patch disable this printk by default since it will
> show up in the stats, and the timeout patch (not included here) delays
> the retry.
> =

> ...
> >> +EXPORT_SYMBOL(suspend_blocker_init);
> >
> > Is there a strong objection to changing that (and the other instances b=
elow) to
> > EXPORT_SYMBOL_GPL?
> >
> =

> I don't know if it is a strong objection, but I prefer that this api
> is available to all drivers. I don't want to prevent a user from using
> opportunistic suspend because a non-gpl driver could not use suspend
> blockers. I changed the suspend blocking work functions to be gpl only
> though, since they are not required, and the workqueue api is
> available to gpl code anyway.
> =

> ...
> >> +bool request_suspend_valid_state(suspend_state_t state)
> >> +{
> >> +     return (state =3D=3D PM_SUSPEND_ON) || valid_state(state);
> >> +}
> >> +
> >> +int request_suspend_state(suspend_state_t state)
> >> +{
> >> +     unsigned long irqflags;
> >> +
> >> +     if (!request_suspend_valid_state(state))
> >> +             return -ENODEV;
> >> +
> >> +     spin_lock_irqsave(&state_lock, irqflags);
> >> +
> >> +     if (debug_mask & DEBUG_USER_STATE)
> >> +             pr_info_time("request_suspend_state: %s (%d->%d) at %lld=
 ",
> >> +                          state !=3D PM_SUSPEND_ON ? "sleep" : "wakeu=
p",
> >> +                          requested_suspend_state, state,
> >> +                          ktime_to_ns(ktime_get()));
> >> +
> >> +     requested_suspend_state =3D state;
> >> +     if (state =3D=3D PM_SUSPEND_ON)
> >> +             suspend_block(&main_suspend_blocker);
> >> +     else
> >> +             suspend_unblock(&main_suspend_blocker);
> >> +     spin_unlock_irqrestore(&state_lock, irqflags);
> >> +     return 0;
> >> +}
> >
> > I think the two functions above should be static, shouldn't they?
> =

> No, they are used from main.c.
> =

> >
> >> +static int __init suspend_block_init(void)
> >> +{
> >> +     suspend_work_queue =3D create_singlethread_workqueue("suspend");
> >> +     if (!suspend_work_queue)
> >> +             return -ENOMEM;
> >> +
> >> +     suspend_blocker_init(&main_suspend_blocker, "main");
> >> +     suspend_block(&main_suspend_blocker);
> >> +     return 0;
> >> +}
> >> +
> >> +core_initcall(suspend_block_init);
> >
> > Hmm.  Why don't you want to put that initialization into pm_init() (in
> > kernel/power/main.c)?
> =

> It was not needed before, but I changed pm_init to call
> suspend_block_init after creating pm_wq.
> =

> >
> > Also, we already have one PM workqueue.  It is used for runtime PM, but=
 I guess
> > it may be used just as well for the opportunistic suspend.  It is freez=
able,
> > but would it hurt?
> =

> No, it works, the freezable flag is just ignored when I call
> pm_suspend and I don't run anything else on the workqueue while
> threads are frozen. It does need to be a single threaded workqueue
> though, so make sure you don't just change that.

Freezable workqueues have to be singlethread or else there will be unfixable
races, so you can safely assume things will stay as they are in this respec=
t.

Rafael


> =

> =

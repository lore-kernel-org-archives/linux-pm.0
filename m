From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Wed, 28 Apr 2010 20:37:57 -0700
Message-ID: <l2yd6200be21004282037rc063266by91db7f732ceaa529__28311.4796424799$1272512365$gmane$org@mail.gmail.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<1272429119-12103-2-git-send-email-arve@android.com>
	<201004282250.44200.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004282250.44200.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
...
>>
>> +/**
>> + * =A0 policy - set policy for state
>> + */
>> +
>> +static ssize_t policy_show(struct kobject *kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct kobj_attribute *=
attr, char *buf)
>> +{
>> + =A0 =A0 char *s =3D buf;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(policies); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (i =3D=3D policy)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s +=3D sprintf(s, "[%s] ", pol=
icies[i].name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s +=3D sprintf(s, "%s ", polic=
ies[i].name);
>> + =A0 =A0 }
>> + =A0 =A0 if (s !=3D buf)
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* convert the last space to a newline */
>> + =A0 =A0 =A0 =A0 =A0 =A0 *(s-1) =3D '\n';
>> + =A0 =A0 return (s - buf);
>> +}
>> +
>> +static ssize_t policy_store(struct kobject *kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct kobj_attribute =
*attr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_=
t n)
>> +{
>> + =A0 =A0 const char *s;
>> + =A0 =A0 char *p;
>> + =A0 =A0 int len;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 p =3D memchr(buf, '\n', n);
>> + =A0 =A0 len =3D p ? p - buf : n;
>> +
>> + =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(policies); i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 s =3D policies[i].name;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (s && len =3D=3D strlen(s) && !strncmp(buf,=
 s, len)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&pm_mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policies[policy].set_state(PM_=
SUSPEND_ON);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 policy =3D i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&pm_mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return n;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 return -EINVAL;
>> +}
>> +
>> +power_attr(policy);
>> +
>> =A0#ifdef CONFIG_PM_TRACE
>> =A0int pm_trace_enabled;
>>
>
> Would you mind if I changed the above so that "policy" doesn't even show =
up
> if CONFIG_OPPORTUNISTIC_SUSPEND is unset?
>
I don't mind, but It did not seem worth the trouble to hide it. It
will only list the supported policies, and it is easy to add or remove
policies this way.

> ...
>> +static void suspend_worker(struct work_struct *work)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 int entry_event_num;
>> +
>> + =A0 =A0 enable_suspend_blockers =3D true;
>> + =A0 =A0 while (!suspend_is_blocked()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 entry_event_num =3D current_event_num;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug_mask & DEBUG_SUSPEND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: enter suspen=
d\n");
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_suspend(requested_suspend_state);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug_mask & DEBUG_EXIT_SUSPEND)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info_time("suspend: exit su=
spend, ret =3D %d ", ret);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (current_event_num =3D=3D entry_event_num)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("suspend: pm_suspend r=
eturned with no event\n");
>
> Hmm, what exactly is this for? =A0It looks like a debug thing to me. =A0I=
'd use
> pr_debug() here and in both debug printk()s above. =A0Would you agree?
>

If the driver that caused the wakeup does not use suspend blockers, we
the only choice is to try to suspend again. I want to know if this
happened. The stats patch disable this printk by default since it will
show up in the stats, and the timeout patch (not included here) delays
the retry.

...
>> +EXPORT_SYMBOL(suspend_blocker_init);
>
> Is there a strong objection to changing that (and the other instances bel=
ow) to
> EXPORT_SYMBOL_GPL?
>

I don't know if it is a strong objection, but I prefer that this api
is available to all drivers. I don't want to prevent a user from using
opportunistic suspend because a non-gpl driver could not use suspend
blockers. I changed the suspend blocking work functions to be gpl only
though, since they are not required, and the workqueue api is
available to gpl code anyway.

...
>> +bool request_suspend_valid_state(suspend_state_t state)
>> +{
>> + =A0 =A0 return (state =3D=3D PM_SUSPEND_ON) || valid_state(state);
>> +}
>> +
>> +int request_suspend_state(suspend_state_t state)
>> +{
>> + =A0 =A0 unsigned long irqflags;
>> +
>> + =A0 =A0 if (!request_suspend_valid_state(state))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>> +
>> + =A0 =A0 spin_lock_irqsave(&state_lock, irqflags);
>> +
>> + =A0 =A0 if (debug_mask & DEBUG_USER_STATE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_info_time("request_suspend_state: %s (%d->%=
d) at %lld ",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state !=3D PM_SUSPE=
ND_ON ? "sleep" : "wakeup",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0requested_suspend_s=
tate, state,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ktime_to_ns(ktime_g=
et()));
>> +
>> + =A0 =A0 requested_suspend_state =3D state;
>> + =A0 =A0 if (state =3D=3D PM_SUSPEND_ON)
>> + =A0 =A0 =A0 =A0 =A0 =A0 suspend_block(&main_suspend_blocker);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 suspend_unblock(&main_suspend_blocker);
>> + =A0 =A0 spin_unlock_irqrestore(&state_lock, irqflags);
>> + =A0 =A0 return 0;
>> +}
>
> I think the two functions above should be static, shouldn't they?

No, they are used from main.c.

>
>> +static int __init suspend_block_init(void)
>> +{
>> + =A0 =A0 suspend_work_queue =3D create_singlethread_workqueue("suspend"=
);
>> + =A0 =A0 if (!suspend_work_queue)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 suspend_blocker_init(&main_suspend_blocker, "main");
>> + =A0 =A0 suspend_block(&main_suspend_blocker);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +core_initcall(suspend_block_init);
>
> Hmm. =A0Why don't you want to put that initialization into pm_init() (in
> kernel/power/main.c)?

It was not needed before, but I changed pm_init to call
suspend_block_init after creating pm_wq.

>
> Also, we already have one PM workqueue. =A0It is used for runtime PM, but=
 I guess
> it may be used just as well for the opportunistic suspend. =A0It is freez=
able,
> but would it hurt?

No, it works, the freezable flag is just ignored when I call
pm_suspend and I don't run anything else on the workqueue while
threads are frozen. It does need to be a single threaded workqueue
though, so make sure you don't just change that.

-- =

Arve Hj=F8nnev=E5g

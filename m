From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Fri, 30 Jan 2015 23:57:38 +0100
Message-ID: <4152512.pDYbpiR2EP@vostro.rjw.lan>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: santosh.shilimkar@oracle.com, ethan.zhao@oracle.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, January 30, 2015 06:43:12 AM Viresh Kumar wrote:
> cpufreq_cpu_data is protected by cpufreq_driver_lock and one of the instances
> has missed this.

No, it isn't.  cpufreq_cpu_data is a pointer and doesn't need any locks to
protect it.  What the lock does is to guarantee the callers of cpufreq_cpu_get()
that the policy object won't go away from under them (it is used for some other
purposes too, but they are unrelated).

What technically happens is an ordering problem.  per_cpu(cpufreq_cpu_data, cpu)
needs to be cleared before calling kobject_put(&policy->kobj) *and* under the
lock, because otherwise if someone else calls cpufreq_cpu_get() in parallel
with that, they can obtain a non-NULL from it *after* kobject_put(&policy->kobj)
was executed.

So the lock is needed not just because it protects cpufreq_cpu_data, but because
it is supposed to prevent writes to cpufreq_cpu_data from happening between the
read from it and the kobject_get(&policy->kobj) in cpufreq_cpu_get().

> And as a result we get this:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 4 at include/linux/kref.h:47
>  kobject_get+0x41/0x50()
>  Modules linked in: acpi_cpufreq(+) nfsd auth_rpcgss nfs_acl
>  lockd grace sunrpc xfs libcrc32c sd_mod ixgbe igb mdio ahci hwmon
>  ...
>  Call Trace:
>   [<ffffffff81661b14>] dump_stack+0x46/0x58
>   [<ffffffff81072b61>] warn_slowpath_common+0x81/0xa0
>   [<ffffffff81072c7a>] warn_slowpath_null+0x1a/0x20
>   [<ffffffff812e16d1>] kobject_get+0x41/0x50
>   [<ffffffff815262a5>] cpufreq_cpu_get+0x75/0xc0
>   [<ffffffff81527c3e>] cpufreq_update_policy+0x2e/0x1f0
>   [<ffffffff810b8cb2>] ? up+0x32/0x50
>   [<ffffffff81381aa9>] ? acpi_ns_get_node+0xcb/0xf2
>   [<ffffffff81381efd>] ? acpi_evaluate_object+0x22c/0x252
>   [<ffffffff813824f6>] ? acpi_get_handle+0x95/0xc0
>   [<ffffffff81360967>] ? acpi_has_method+0x25/0x40
>   [<ffffffff81391e08>] acpi_processor_ppc_has_changed+0x77/0x82
>   [<ffffffff81089566>] ? move_linked_works+0x66/0x90
>   [<ffffffff8138e8ed>] acpi_processor_notify+0x58/0xe7
>   [<ffffffff8137410c>] acpi_ev_notify_dispatch+0x44/0x5c
>   [<ffffffff8135f293>] acpi_os_execute_deferred+0x15/0x22
>   [<ffffffff8108c910>] process_one_work+0x160/0x410
>   [<ffffffff8108d05b>] worker_thread+0x11b/0x520
>   [<ffffffff8108cf40>] ? rescuer_thread+0x380/0x380
>   [<ffffffff81092421>] kthread+0xe1/0x100
>   [<ffffffff81092340>] ? kthread_create_on_node+0x1b0/0x1b0
>   [<ffffffff81669ebc>] ret_from_fork+0x7c/0xb0
>   [<ffffffff81092340>] ? kthread_create_on_node+0x1b0/0x1b0
>  ---[ end trace 89e66eb9795efdf7 ]---
> 
> And here is the race:
>
>  Thread A: Workqueue: kacpi_notify
> 
>  acpi_processor_notify()
>    acpi_processor_ppc_has_changed()
>          cpufreq_update_policy()
>            cpufreq_cpu_get()
>              kobject_get()
> 
>  Thread B: xenbus_thread()
> 
>  xenbus_thread()
>    msg->u.watch.handle->callback()
>      handle_vcpu_hotplug_event()
>        vcpu_hotplug()
>          cpu_down()
>            __cpu_notify(CPU_POST_DEAD..)
>              cpufreq_cpu_callback()
>                __cpufreq_remove_dev_finish()
>                  cpufreq_policy_put_kobj()
>                    kobject_put()
> 
> cpufreq_cpu_get() gets the policy from per-cpu variable cpufreq_cpu_data under
> cpufreq_driver_lock, and once it gets a valid policy it expects it to not be
> freed until cpufreq_cpu_put() is called.

Because it does the kobject_get() under the lock too.

> But the race happens when another thread puts the kobject first and updates
> cpufreq_cpu_data later

This is an ordering problem.

> and that too without these locks.

And this is racy.

> And so the first thread
> gets a valid policy structure and before it does kobject_get() on it, the second
> one does kobject_put(). And so this WARN().
> 
> Fix this by setting cpufreq_cpu_data to NULL before putting the kobject and that
> too under locks.

That's almost correct.  In addition to the above (albeit maybe unintentionally)
the patch also fixes the possible race between two instances of
__cpufreq_remove_dev_finish() with the same arguments running in parallel with
each other.  The proof is left as an exercise to the reader. :-)

Please try to improve the changelog ...

> Cc: <stable@vger.kernel.org>        # 3.12+
> Reported-by: Ethan Zhao <ethan.zhao@oracle.com>
> Reported-and-tested-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Santosh: I have changed read locks to write locks here and so you need to test
> again.
> 
>  drivers/cpufreq/cpufreq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 4473eba1d6b0..e3bf702b5588 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1409,9 +1409,10 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  	unsigned long flags;
>  	struct cpufreq_policy *policy;
>  
> -	read_lock_irqsave(&cpufreq_driver_lock, flags);
> +	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  	policy = per_cpu(cpufreq_cpu_data, cpu);
> -	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
> +	per_cpu(cpufreq_cpu_data, cpu) = NULL;
> +	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>  
>  	if (!policy) {
>  		pr_debug("%s: No cpu_data found\n", __func__);
> @@ -1466,7 +1467,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>  		}
>  	}
>  
> -	per_cpu(cpufreq_cpu_data, cpu) = NULL;
>  	return 0;
>  }
>  
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

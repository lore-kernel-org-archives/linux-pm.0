From: Jeremy Cline <jcline@redhat.com>
Subject: Re: [PATCH] cpufreq: governor: Protect cpufreq governor_data
Date: Thu, 13 Sep 2018 10:29:33 -0400
Message-ID: <8c3a0da6-5a2b-d20a-fd9f-72c01a65d7b8@redhat.com>
References: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534291262-4207-1-git-send-email-henry.willard@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Henry Willard <henry.willard@oracle.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi folks,

On 08/14/2018 08:01 PM, Henry Willard wrote:
> If cppc_cpufreq.ko is deleted at the same time that tuned-adm is,
> changing profiles, there is a small chance that a race can occur
> between cpufreq_dbs_governor_exit() and cpufreq_dbs_governor_limits()
> resulting in a system failure when the latter tries to use
> policy->governor_data that has been freed by the former.
> 
> This patch uses gov_dbs_data_mutex to synchronize access.
> 
> Signed-off-by: Henry Willard <henry.willard@oracle.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 1d50e97d49f1..43416ee55849 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -555,12 +555,20 @@ void cpufreq_dbs_governor_stop(struct cpufreq_policy *policy)
>  
>  void cpufreq_dbs_governor_limits(struct cpufreq_policy *policy)
>  {
> -	struct policy_dbs_info *policy_dbs = policy->governor_data;
> +	struct policy_dbs_info *policy_dbs;
> +
> +	/* Protect gov->gdbs_data against cpufreq_dbs_governor_exit */
> +	mutex_lock(&gov_dbs_data_mutex);
> +	policy_dbs = policy->governor_data;
> +	if (!policy_dbs)
> +		goto out;
>  
>  	mutex_lock(&policy_dbs->update_mutex);
>  	cpufreq_policy_apply_limits(policy);
>  	gov_update_sample_delay(policy_dbs, 0);
>  
>  	mutex_unlock(&policy_dbs->update_mutex);
> +out:
> +	mutex_unlock(&gov_dbs_data_mutex);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_dbs_governor_limits);
> 

Fedora has gotten a report[0] of possible circular locking which looks
like might have been introduced by this patch.

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1627950

User-provided log (attached to the bug report) is:

 ======================================================
 WARNING: possible circular locking dependency detected
 4.19.0-0.rc2.git3.1.fc30.x86_64 #1 Not tainted
 ------------------------------------------------------
 kworker/0:3/101 is trying to acquire lock:
 000000003b2babfd ((work_completion)(&wfc.work)){+.+.}, at:
__flush_work+0x28c/0x320

 but task is already holding lock:
 0000000084d461de (&policy_dbs->update_mutex){+.+.}, at:
dbs_work_handler+0x2b/0x70

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #5 (&policy_dbs->update_mutex){+.+.}:
        cpufreq_dbs_governor_limits+0x31/0x80
        cpufreq_start_governor+0x65/0xa0
        cpufreq_set_policy+0x2b7/0x330
        cpufreq_init_policy+0x76/0xe0
        cpufreq_online+0x535/0x6b0
        cpufreq_add_dev+0x6b/0x80
        subsys_interface_register+0xf3/0x150
        cpufreq_register_driver+0x11e/0x230
        powernowk8_init+0x134/0x18f [powernow_k8]
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #4 (gov_dbs_data_mutex){+.+.}:
        cpufreq_dbs_governor_init+0x117/0x240
        cpufreq_init_governor+0x62/0xe0
        cpufreq_set_policy+0x1ca/0x330
        cpufreq_init_policy+0x76/0xe0
        cpufreq_online+0x535/0x6b0
        cpufreq_add_dev+0x6b/0x80
        subsys_interface_register+0xf3/0x150
        cpufreq_register_driver+0x11e/0x230
        powernowk8_init+0x134/0x18f [powernow_k8]
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #3 (&policy->rwsem){+.+.}:
        cpufreq_policy_free+0xba/0x140
        cpufreq_online+0xec/0x6b0
        cpufreq_add_dev+0x6b/0x80
        subsys_interface_register+0xf3/0x150
        cpufreq_register_driver+0x11e/0x230
        0xffffffffc05fc25a
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #2 (subsys mutex#7){+.+.}:
        subsys_interface_register+0x73/0x150
        cpufreq_register_driver+0x11e/0x230
        0xffffffffc05fc25a
        do_one_initcall+0x5d/0x2be
        do_init_module+0x5a/0x210
        load_module+0x2134/0x2400
        __do_sys_init_module+0x150/0x1a0
        do_syscall_64+0x60/0x1f0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #1 (cpu_hotplug_lock.rw_sem){.+.+}:
        apply_workqueue_attrs+0x12/0x50
        __alloc_workqueue_key+0x303/0x480
        scsi_host_alloc+0x3be/0x450
        ata_scsi_add_hosts+0xc9/0x150
        ata_host_register+0x120/0x1d0
        ata_host_activate+0xc1/0x140
        svia_init_one+0x6c7/0x7f6 [sata_via]
        local_pci_probe+0x41/0x90
        work_for_cpu_fn+0x16/0x20
        process_one_work+0x27d/0x5c0
        worker_thread+0x3c/0x390
        kthread+0x120/0x140
        ret_from_fork+0x3a/0x50

 -> #0 ((work_completion)(&wfc.work)){+.+.}:
        __flush_work+0x2ac/0x320
        work_on_cpu+0x9b/0xd0
        powernowk8_target+0x33/0x50 [powernow_k8]
        __cpufreq_driver_target+0x2d2/0x580
        od_dbs_update+0xbb/0x190
        dbs_work_handler+0x3a/0x70
        process_one_work+0x27d/0x5c0
        worker_thread+0x3c/0x390
        kthread+0x120/0x140
        ret_from_fork+0x3a/0x50

 other info that might help us debug this:
 Chain exists of:
   (work_completion)(&wfc.work) --> gov_dbs_data_mutex -->
&policy_dbs->update_mutex
  Possible unsafe locking scenario:
        CPU0                    CPU1
        ----                    ----
   lock(&policy_dbs->update_mutex);
                                lock(gov_dbs_data_mutex);
                                lock(&policy_dbs->update_mutex);
   lock((work_completion)(&wfc.work));

  *** DEADLOCK ***
 3 locks held by kworker/0:3/101:
  #0: 000000009eaebf60 ((wq_completion)"events"){+.+.}, at:
process_one_work+0x1f3/0x5c0
  #1: 00000000ac2fb241 ((work_completion)(&policy_dbs->work)){+.+.}, at:
process_one_work+0x1f3/0x5c0
  #2: 0000000084d461de (&policy_dbs->update_mutex){+.+.}, at:
dbs_work_handler+0x2b/0x70

 stack backtrace:
 CPU: 0 PID: 101 Comm: kworker/0:3 Not tainted
4.19.0-0.rc2.git3.1.fc30.x86_64 #1
 Hardware name: Acer Aspire T135/K8VM800MAE, BIOS R01-A3 06/27/2005
 Workqueue: events dbs_work_handler
 Call Trace:
  dump_stack+0x85/0xc0
  print_circular_bug.isra.36.cold.55+0x15c/0x195
  __lock_acquire+0x139a/0x16c0
  ? __lock_acquire+0x112b/0x16c0
  lock_acquire+0x9e/0x180
  ? __flush_work+0x28c/0x320
  __flush_work+0x2ac/0x320
  ? __flush_work+0x28c/0x320
  ? native_sched_clock+0x3e/0xa0
  ? mark_held_locks+0x57/0x80
  ? queue_work_on+0x5d/0x90
  ? lockdep_hardirqs_on+0xed/0x180
  work_on_cpu+0x9b/0xd0
  ? work_is_static_object+0x10/0x10
  ? write_new_fid+0xe0/0xe0 [powernow_k8]
  powernowk8_target+0x33/0x50 [powernow_k8]
  __cpufreq_driver_target+0x2d2/0x580
  od_dbs_update+0xbb/0x190
  dbs_work_handler+0x3a/0x70
  process_one_work+0x27d/0x5c0
  worker_thread+0x3c/0x390
  ? process_one_work+0x5c0/0x5c0
  kthread+0x120/0x140
  ? kthread_create_worker_on_cpu+0x70/0x70
  ret_from_fork+0x3a/0x50
 clocksource: timekeeping watchdog on CPU0: Marking clocksource 'tsc' as
unstable because the skew is too large:
 clocksource:                       'acpi_pm' wd_now: 61cb7c wd_last:
5e7744 mask: ffffff
 clocksource:                       'tsc' cs_now: 2b9d83ad41 cs_last:
299dc3ef91 mask: ffffffffffffffff
 tsc: Marking TSC unstable due to clocksource watchdog
 TSC found unstable after boot, most likely due to broken BIOS. Use
'tsc=unstable'.
 sched_clock: Marking unstable (55064379271, 12383389)<-(55179340298,
-102501740)
 clocksource: Switched to clocksource acpi_pm


Cheers,
Jeremy

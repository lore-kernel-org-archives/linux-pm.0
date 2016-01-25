From: Ricky Liang <jcliang@chromium.org>
Subject: Re: [RFCv6 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Mon, 25 Jan 2016 20:06:24 +0800
Message-ID: <CAAJzSMfrtFuj2kZQh5j6KD_Nj4NMgbSH+k38LG+_n8U4epbG6A@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
	<1449641971-20827-4-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449641971-20827-4-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Steve,

On Wed, Dec 9, 2015 at 2:19 PM, Steve Muckle <steve.muckle@linaro.org> wrote:

[...]

> +/*
> + * we pass in struct cpufreq_policy. This is safe because changing out the
> + * policy requires a call to __cpufreq_governor(policy, CPUFREQ_GOV_STOP),
> + * which tears down all of the data structures and __cpufreq_governor(policy,
> + * CPUFREQ_GOV_START) will do a full rebuild, including this kthread with the
> + * new policy pointer
> + */
> +static int cpufreq_sched_thread(void *data)
> +{
> +       struct sched_param param;
> +       struct cpufreq_policy *policy;
> +       struct gov_data *gd;
> +       unsigned int new_request = 0;
> +       unsigned int last_request = 0;
> +       int ret;
> +
> +       policy = (struct cpufreq_policy *) data;
> +       gd = policy->governor_data;
> +
> +       param.sched_priority = 50;
> +       ret = sched_setscheduler_nocheck(gd->task, SCHED_FIFO, &param);
> +       if (ret) {
> +               pr_warn("%s: failed to set SCHED_FIFO\n", __func__);
> +               do_exit(-EINVAL);
> +       } else {
> +               pr_debug("%s: kthread (%d) set to SCHED_FIFO\n",
> +                               __func__, gd->task->pid);
> +       }
> +
> +       do {
> +               set_current_state(TASK_INTERRUPTIBLE);
> +               new_request = gd->requested_freq;
> +               if (new_request == last_request) {
> +                       schedule();

Should we check kthread_should_stop() after
set_current_state(TASK_INTERRUPTIBLE), probably right before
schedule()? Something like:

               set_current_state(TASK_INTERRUPTIBLE);
               new_request = gd->requested_freq;
               if (new_request == last_request) {
                       if (kthread_should_stop())
                               break;
                       schedule();
               } else {
                       ...
               }

On the previous version of the scheduler-driver cpu frequency
selection I had the following:

<3>[ 1920.233598] INFO: task autotest:32443 blocked for more than 120 seconds.
<3>[ 1920.233625]       Not tainted 3.18.0-09696-g4312b25 #1
<3>[ 1920.233641] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
<6>[ 1920.233659] autotest        D ffffffc0002057a0     0 32443
32403 0x00400000
<0>[ 1920.233693] Call trace:
<4>[ 1920.233724] [<ffffffc0002057a0>] __switch_to+0x80/0x8c
<4>[ 1920.233748] [<ffffffc000897908>] __schedule+0x550/0x7d8
<4>[ 1920.233769] [<ffffffc000897c08>] schedule+0x78/0x84
<4>[ 1920.233786] [<ffffffc00089bf9c>] schedule_timeout+0x40/0x2ac
<4>[ 1920.233804] [<ffffffc000898960>] wait_for_common+0x154/0x18c
<4>[ 1920.233820] [<ffffffc0008989bc>] wait_for_completion+0x24/0x34
<4>[ 1920.233840] [<ffffffc000242f84>] kthread_stop+0x130/0x22c
<4>[ 1920.233859] [<ffffffc00026ce84>] cpufreq_sched_setup+0x21c/0x308
<4>[ 1920.233881] [<ffffffc0006dcd30>] __cpufreq_governor+0x114/0x1c8
<4>[ 1920.233901] [<ffffffc0006dd168>] cpufreq_set_policy+0x120/0x1b8
<4>[ 1920.233920] [<ffffffc0006ddb64>] store_scaling_governor+0x8c/0xd4
<4>[ 1920.233937] [<ffffffc0006dc494>] store+0x98/0xd0
<4>[ 1920.233958] [<ffffffc0003b4158>] sysfs_kf_write+0x54/0x64
<4>[ 1920.233977] [<ffffffc0003b34d0>] kernfs_fop_write+0x108/0x150
<4>[ 1920.233999] [<ffffffc000344d2c>] vfs_write+0xc4/0x1a0
<4>[ 1920.234018] [<ffffffc000345478>] SyS_write+0x60/0xb4
<4>[ 1920.234031] INFO: lockdep is turned off.
<6>[ 1920.234043]   task                        PC stack   pid father
<6>[ 1920.234161] autotest        D ffffffc0002057a0     0 32443
32403 0x00400000
<0>[ 1920.234193] Call trace:
<4>[ 1920.234211] [<ffffffc0002057a0>] __switch_to+0x80/0x8c
<4>[ 1920.234232] [<ffffffc000897908>] __schedule+0x550/0x7d8
<4>[ 1920.234251] [<ffffffc000897c08>] schedule+0x78/0x84
<4>[ 1920.234268] [<ffffffc00089bf9c>] schedule_timeout+0x40/0x2ac
<4>[ 1920.234285] [<ffffffc000898960>] wait_for_common+0x154/0x18c
<4>[ 1920.234301] [<ffffffc0008989bc>] wait_for_completion+0x24/0x34
<4>[ 1920.234319] [<ffffffc000242f84>] kthread_stop+0x130/0x22c
<4>[ 1920.234335] [<ffffffc00026ce84>] cpufreq_sched_setup+0x21c/0x308
<4>[ 1920.234355] [<ffffffc0006dcd30>] __cpufreq_governor+0x114/0x1c8
<4>[ 1920.234375] [<ffffffc0006dd168>] cpufreq_set_policy+0x120/0x1b8
<4>[ 1920.234395] [<ffffffc0006ddb64>] store_scaling_governor+0x8c/0xd4
<4>[ 1920.234413] [<ffffffc0006dc494>] store+0x98/0xd0
<4>[ 1920.234432] [<ffffffc0003b4158>] sysfs_kf_write+0x54/0x64
<4>[ 1920.234449] [<ffffffc0003b34d0>] kernfs_fop_write+0x108/0x150
<4>[ 1920.234470] [<ffffffc000344d2c>] vfs_write+0xc4/0x1a0
<4>[ 1920.234489] [<ffffffc000345478>] SyS_write+0x60/0xb4

This happened while the kernel is switching from the sched governor to
the userspace governor. There's a race between kthread_stop() and
cpufreq_sched_thread(). On the previous version I was testing, I can
easily reproduce the lockup if I add a msleep(100) right before
set_current_state(TASK_INTERRUPTIBLE), and then switching between the
two governors through sysfs.

> +               } else {
> +                       /*
> +                        * if the frequency thread sleeps while waiting to be
> +                        * unthrottled, start over to check for a newer request
> +                        */
> +                       if (finish_last_request(gd))
> +                               continue;
> +                       last_request = new_request;
> +                       cpufreq_sched_try_driver_target(policy, new_request);
> +               }
> +       } while (!kthread_should_stop());
> +
> +       return 0;
> +}

[...]

Best,
Ricky

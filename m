From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Thu, 4 Feb 2016 00:50:30 +0100
Message-ID: <CAJZ5v0hbhoS+1AaU12SFxz=r1-TOWq10yJ+ST7mVWcUubTbxFw@mail.gmail.com>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
	<20160203155428.GY3947@e106622-lin>
	<20160203161059.GH3469@vireshk>
	<20160203172009.GC12132@e106622-lin>
	<CAJZ5v0hdn6bM8J97O_GFrvi2O7LfuGv0oaZu7KH+cj1TJy+4CQ@mail.gmail.com>
	<CAMSceqiFG47G=mvzY8-tUL=sHdkkjVQaWzEA1aN+-ym0F_n6Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMSceqiFG47G=mvzY8-tUL=sHdkkjVQaWzEA1aN+-ym0F_n6Gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shilpa Bhat <shilpabhatppc@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 4, 2016 at 12:31 AM, Shilpa Bhat <shilpabhatppc@gmail.com> wrote:
> Hi,
>
> On 02/03/2016 10:50 PM, Rafael J. Wysocki wrote:
>> On Wed, Feb 3, 2016 at 6:20 PM, Juri Lelli <juri.lelli@arm.com> wrote:
>>> On 03/02/16 21:40, Viresh Kumar wrote:
>>>> On 03-02-16, 15:54, Juri Lelli wrote:
>>>>> Ouch, I've just got this executing -f basic on Juno. :(
>>>>> It happens with the hotplug_1_by_1 test.
>>>>>
>>>
>>> [...]
>>>
>>>>
>>>> Urg..
>>>>
>>>> I failed to understand it for now though. Please test only the first 4
>>>> patches and leave the bottom three. AFAICT, this is caused by the 6th
>>>> patch.
>>>>
>>>> The first 4 are important for 4.5 and must be tested soonish.
>>>>
>>>
>>> First 4 look ok from a testing viewpoint.
>>
>> Good, thanks for the confirmation!
>>
>> I'm going to apply them and they will go to Linus next week.
>>
>> Thanks,
>> Rafael
>
> Sorry for the delayed report. But I see the below backtrace on Power8 box. It
> has 4 chips with 128 cpus.

Thanks for the report.

> I see the below trace with the first four patches on running tests
> from Viresh's testcase.
> './runme.sh -f basic'
>  hit this trace at 'shuffle_governors_for_all_cpus' test.
>
> [  906.762045] ======================================================
> [  906.762114] [ INFO: possible circular locking dependency detected ]
> [  906.762172] 4.5.0-rc2-sgb+ #96 Not tainted
> [  906.762207] -------------------------------------------------------
> [  906.762263] runme.sh/2840 is trying to acquire lock:
> [  906.762309]  (s_active#91){++++.+}, at: [<c000000000407db8>]
> kernfs_remove+0x48/0x70
> [  906.762419]
> but task is already holding lock:
> [  906.762476]  (od_dbs_cdata.mutex){+.+.+.}, at: [<c000000000ad7594>]
> cpufreq_governor_dbs+0x64/0x7e0
> [  906.762592]
> which lock already depends on the new lock.
>
> [  906.762659]
> the existing dependency chain (in reverse order) is:
> [  906.762727]
> -> #2 (od_dbs_cdata.mutex){+.+.+.}:
> [  906.762807]        [<c000000000d485b0>] mutex_lock_nested+0x90/0x590
> [  906.762877]        [<c000000000ad57f8>] update_sampling_rate+0x88/0x1c0
> [  906.762946]        [<c000000000ad5990>] store_sampling_rate+0x60/0xa0
> [  906.763013]        [<c000000000ad6af0>] governor_store+0x80/0xc0
> [  906.763070]        [<c00000000040a8a4>] sysfs_kf_write+0x94/0xc0
> [  906.763128]        [<c0000000004094a8>] kernfs_fop_write+0x188/0x1f0
> [  906.763196]        [<c000000000347b8c>] __vfs_write+0x6c/0x180
> [  906.763254]        [<c0000000003490a0>] vfs_write+0xc0/0x200
> [  906.763311]        [<c00000000034a3cc>] SyS_write+0x6c/0x110
> [  906.763369]        [<c00000000000926c>] system_call+0x38/0xd0
> [  906.763427]
> -> #1 (&dbs_data->mutex){+.+...}:
> [  906.763495]        [<c000000000d485b0>] mutex_lock_nested+0x90/0x590
> [  906.763563]        [<c000000000ad6ac0>] governor_store+0x50/0xc0
> [  906.763620]        [<c00000000040a8a4>] sysfs_kf_write+0x94/0xc0
> [  906.763677]        [<c0000000004094a8>] kernfs_fop_write+0x188/0x1f0
> [  906.763745]        [<c000000000347b8c>] __vfs_write+0x6c/0x180
> [  906.763801]        [<c0000000003490a0>] vfs_write+0xc0/0x200
> [  906.763859]        [<c00000000034a3cc>] SyS_write+0x6c/0x110
> [  906.763916]        [<c00000000000926c>] system_call+0x38/0xd0
> [  906.763973]
> -> #0 (s_active#91){++++.+}:
> [  906.764052]        [<c00000000015f318>] lock_acquire+0xd8/0x1a0
> [  906.764111]        [<c0000000004065f4>] __kernfs_remove+0x344/0x410
> [  906.764179]        [<c000000000407db8>] kernfs_remove+0x48/0x70
> [  906.764236]        [<c00000000040b868>] sysfs_remove_dir+0x78/0xd0
> [  906.764304]        [<c0000000005eccec>] kobject_del+0x2c/0x80
> [  906.764362]        [<c0000000005ec9e8>] kobject_release+0xa8/0x250
> [  906.764430]        [<c000000000ad7c28>] cpufreq_governor_dbs+0x6f8/0x7e0
> [  906.764497]        [<c000000000ad4bdc>] od_cpufreq_governor_dbs+0x3c/0x60
> [  906.764567]        [<c000000000acf830>] __cpufreq_governor+0x1d0/0x390
> [  906.764634]        [<c000000000ad0750>] cpufreq_set_policy+0x3b0/0x450
> [  906.764703]        [<c000000000ad12cc>] store_scaling_governor+0x8c/0xf0
> [  906.764771]        [<c000000000aced34>] store+0xb4/0x110
> [  906.764828]        [<c00000000040a8a4>] sysfs_kf_write+0x94/0xc0
> [  906.764885]        [<c0000000004094a8>] kernfs_fop_write+0x188/0x1f0
> [  906.764952]        [<c000000000347b8c>] __vfs_write+0x6c/0x180
> [  906.765048]        [<c0000000003490a0>] vfs_write+0xc0/0x200
> [  906.765160]        [<c00000000034a3cc>] SyS_write+0x6c/0x110
> [  906.765272]        [<c00000000000926c>] system_call+0x38/0xd0
> [  906.765384]
> other info that might help us debug this:
>
> [  906.765522] Chain exists of:
>   s_active#91 --> &dbs_data->mutex --> od_dbs_cdata.mutex
>
> [  906.765768]  Possible unsafe locking scenario:
>
> [  906.765880]        CPU0                    CPU1
> [  906.765969]        ----                    ----
> [  906.766058]   lock(od_dbs_cdata.mutex);
> [  906.766170]                                lock(&dbs_data->mutex);
> [  906.766304]                                lock(od_dbs_cdata.mutex);
> [  906.766461]   lock(s_active#91);
> [  906.766572]
>  *** DEADLOCK ***

This is exactly right.  We've avoided one deadlock only to trip into
another one.

This happens because update_sampling_rate() acquires
od_dbs_cdata.mutex which is held around cpufreq_governor_exit() by
cpufreq_governor_dbs().

Worse yet, a deadlock can still happen without (the new)
dbs_data->mutex, just between s_active and od_dbs_cdata.mutex if
update_sampling_rate() runs in parallel with
cpufreq_governor_dbs()->cpufreq_governor_exit() and the latter wins
the race.

It looks like we need to drop the governor mutex before putting the
kobject in cpufreq_governor_exit().

Thanks,
Rafael

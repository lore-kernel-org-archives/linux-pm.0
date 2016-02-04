From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Fri, 05 Feb 2016 02:20:56 +0530
Message-ID: <56B3B9B0.4010401@linux.vnet.ibm.com>
References: <cover.1454507872.git.viresh.kumar@linaro.org> <20160203155428.GY3947@e106622-lin> <20160203161059.GH3469@vireshk> <20160204062439.GZ3469@vireshk> <20160204121727.GH3469@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160204121727.GH3469@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

> 
> FWIW, Juri has reported on IRC that the above diff fixed the lockdep
> he reported yesterday and all the 7 patches are working fine on his
> test machine, Juno.
> 

I could see the previous lockdep warnings on pm/next and on top of patch[4].
On Patch[5-7] I see the below lockdep trace on running './runme' on a Power8 box.

[  710.332841] ======================================================
[  710.332911] [ INFO: possible circular locking dependency detected ]
[  710.332969] 4.5.0-rc2-sgb+ #104 Not tainted
[  710.333004] -------------------------------------------------------
[  710.333060] runme.sh/2476 is trying to acquire lock:
[  710.333107]  (s_active#91){++++.+}, at: [<c000000000407db8>]
kernfs_remove+0x48/0x70
[  710.333215]
but task is already holding lock:
[  710.333272]  (od_dbs_cdata.mutex){+.+.+.}, at: [<c000000000ad7434>]
cpufreq_governor_dbs+0x64/0x7e0
[  710.333388]
which lock already depends on the new lock.

[  710.333456]
the existing dependency chain (in reverse order) is:
[  710.333523]
-> #2 (od_dbs_cdata.mutex){+.+.+.}:
[  710.333604]        [<c000000000d48450>] mutex_lock_nested+0x90/0x590
[  710.333673]        [<c000000000ad5698>] update_sampling_rate+0x88/0x1c0
[  710.333741]        [<c000000000ad5830>] store_sampling_rate+0x60/0xa0
[  710.333809]        [<c000000000ad6990>] governor_store+0x80/0xc0
[  710.333865]        [<c00000000040a8a4>] sysfs_kf_write+0x94/0xc0
[  710.333923]        [<c0000000004094a8>] kernfs_fop_write+0x188/0x1f0
[  710.333991]        [<c000000000347b8c>] __vfs_write+0x6c/0x180
[  710.334049]        [<c0000000003490a0>] vfs_write+0xc0/0x200
[  710.334107]        [<c00000000034a3cc>] SyS_write+0x6c/0x110
[  710.334163]        [<c00000000000926c>] system_call+0x38/0xd0
[  710.334222]
-> #1 (&dbs_data->mutex){+.+...}:
[  710.334290]        [<c000000000d48450>] mutex_lock_nested+0x90/0x590
[  710.334358]        [<c000000000ad6960>] governor_store+0x50/0xc0
[  710.334415]        [<c00000000040a8a4>] sysfs_kf_write+0x94/0xc0
[  710.334471]        [<c0000000004094a8>] kernfs_fop_write+0x188/0x1f0
[  710.334539]        [<c000000000347b8c>] __vfs_write+0x6c/0x180
[  710.334596]        [<c0000000003490a0>] vfs_write+0xc0/0x200
[  710.334653]        [<c00000000034a3cc>] SyS_write+0x6c/0x110
[  710.334710]        [<c00000000000926c>] system_call+0x38/0xd0
[  710.334767]
-> #0 (s_active#91){++++.+}:
[  710.334847]        [<c00000000015f318>] lock_acquire+0xd8/0x1a0
[  710.334905]        [<c0000000004065f4>] __kernfs_remove+0x344/0x410
[  710.334973]        [<c000000000407db8>] kernfs_remove+0x48/0x70
[  710.335030]        [<c00000000040b868>] sysfs_remove_dir+0x78/0xd0
[  710.335098]        [<c0000000005eccec>] kobject_del+0x2c/0x80
[  710.335156]        [<c0000000005ec9e8>] kobject_release+0xa8/0x250
[  710.335224]        [<c000000000ad7ac8>] cpufreq_governor_dbs+0x6f8/0x7e0
[  710.335292]        [<c000000000ad4a7c>] od_cpufreq_governor_dbs+0x3c/0x60
[  710.335361]        [<c000000000acf7c4>] __cpufreq_governor+0x164/0x300
[  710.335429]        [<c000000000ad0600>] cpufreq_set_policy+0x3b0/0x450
[  710.335497]        [<c000000000ad117c>] store_scaling_governor+0x8c/0xf0
[  710.335565]        [<c000000000aced34>] store+0xb4/0x110
[  710.335622]        [<c00000000040a8a4>] sysfs_kf_write+0x94/0xc0
[  710.335679]        [<c0000000004094a8>] kernfs_fop_write+0x188/0x1f0
[  710.335747]        [<c000000000347b8c>] __vfs_write+0x6c/0x180
[  710.335803]        [<c0000000003490a0>] vfs_write+0xc0/0x200
[  710.335861]        [<c00000000034a3cc>] SyS_write+0x6c/0x110
[  710.335918]        [<c00000000000926c>] system_call+0x38/0xd0
[  710.335993]
other info that might help us debug this:

[  710.336130] Chain exists of:
  s_active#91 --> &dbs_data->mutex --> od_dbs_cdata.mutex

[  710.336376]  Possible unsafe locking scenario:

[  710.336488]        CPU0                    CPU1
[  710.336577]        ----                    ----
[  710.336666]   lock(od_dbs_cdata.mutex);
[  710.336778]                                lock(&dbs_data->mutex);
[  710.336911]                                lock(od_dbs_cdata.mutex);
[  710.337064]   lock(s_active#91);
[  710.337176]
 *** DEADLOCK ***

[  710.337289] 6 locks held by runme.sh/2476:
[  710.337355]  #0:  (sb_writers#6){.+.+.+}, at: [<c00000000034cf10>]
__sb_start_write+0x120/0x150
[  710.337600]  #1:  (&of->mutex){+.+.+.}, at: [<c00000000040939c>]
kernfs_fop_write+0x7c/0x1f0
[  710.337824]  #2:  (s_active#82){.+.+.+}, at: [<c0000000004093a8>]
kernfs_fop_write+0x88/0x1f0
[  710.338070]  #3:  (cpu_hotplug.lock){++++++}, at: [<c0000000000e06d8>]
get_online_cpus+0x48/0xc0
[  710.338276]  #4:  (&policy->rwsem){+++++.}, at: [<c000000000aced04>]
store+0x84/0x110
[  710.338476]  #5:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c000000000ad7434>]
cpufreq_governor_dbs+0x64/0x7e0
[  710.338722]
stack backtrace:
[  710.338813] CPU: 0 PID: 2476 Comm: runme.sh Not tainted 4.5.0-rc2-sgb+ #104
[  710.338929] Call Trace:
[  710.338978] [c000005fd40eaec0] [c000000000d563d0] dump_stack+0x90/0xbc
(unreliable)
[  710.339138] [c000005fd40eaef0] [c00000000015884c] print_circular_bug+0x28c/0x3e0
[  710.339295] [c000005fd40eaf90] [c00000000015ed88] __lock_acquire+0x2278/0x22d0
[  710.339455] [c000005fd40eb120] [c00000000015f318] lock_acquire+0xd8/0x1a0
[  710.339589] [c000005fd40eb1e0] [c0000000004065f4] __kernfs_remove+0x344/0x410
[  710.339724] [c000005fd40eb2e0] [c000000000407db8] kernfs_remove+0x48/0x70
[  710.339859] [c000005fd40eb310] [c00000000040b868] sysfs_remove_dir+0x78/0xd0
[  710.339993] [c000005fd40eb350] [c0000000005eccec] kobject_del+0x2c/0x80
[  710.340128] [c000005fd40eb380] [c0000000005ec9e8] kobject_release+0xa8/0x250
[  710.340265] [c000005fd40eb410] [c000000000ad7ac8]
cpufreq_governor_dbs+0x6f8/0x7e0
[  710.340423] [c000005fd40eb4c0] [c000000000ad4a7c]
od_cpufreq_governor_dbs+0x3c/0x60
[  710.340561] [c000005fd40eb500] [c000000000acf7c4] __cpufreq_governor+0x164/0x300
[  710.340639] [c000005fd40eb580] [c000000000ad0600] cpufreq_set_policy+0x3b0/0x450
[  710.340719] [c000005fd40eb610] [c000000000ad117c]
store_scaling_governor+0x8c/0xf0
[  710.340797] [c000005fd40ebc10] [c000000000aced34] store+0xb4/0x110
[  710.340866] [c000005fd40ebc60] [c00000000040a8a4] sysfs_kf_write+0x94/0xc0
[  710.340934] [c000005fd40ebca0] [c0000000004094a8] kernfs_fop_write+0x188/0x1f0
[  710.341013] [c000005fd40ebcf0] [c000000000347b8c] __vfs_write+0x6c/0x180
[  710.341081] [c000005fd40ebd90] [c0000000003490a0] vfs_write+0xc0/0x200
[  710.341151] [c000005fd40ebde0] [c00000000034a3cc] SyS_write+0x6c/0x110
[  710.341219] [c000005fd40ebe30] [c00000000000926c] system_call+0x38/0xd0

Thanks and Regards,
Shilpa

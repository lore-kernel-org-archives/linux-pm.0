From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH V2 0/7] cpufreq: governors: Fix ABBA lockups
Date: Wed, 3 Feb 2016 15:54:28 +0000
Message-ID: <20160203155428.GY3947@e106622-lin>
References: <cover.1454507872.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1454507872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 03/02/16 19:32, Viresh Kumar wrote:
> Hi Rafael,
> 
> Here is the V2 with updated patches as suggested by you guys.
> 
> These are pushed here:
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject
> 
> The first four patches are for 4.5, if possible and others you can keep
> for 4.6.
> 
> V1->V2:
> - Improved changelogs, thanks Rafael.
> - Added new dbs_data->mutex to avoid concurrent updates to tunables.
> - Moved kobj_type to common_dbs_data.
> - Updated macros to static inline routines
> - s/show/governor_show
> - s/store/governor_store
> - Improved comments
> 
> @Juri: More testing requested :)
> 

Ouch, I've just got this executing -f basic on Juno. :(
It happens with the hotplug_1_by_1 test.


[ 1086.531252] IRQ1 no longer affine to CPU1
[ 1086.531495] CPU1: shutdown
[ 1086.538199] psci: CPU1 killed.
[ 1086.583396]
[ 1086.584881] ======================================================
[ 1086.590999] [ INFO: possible circular locking dependency detected ]
[ 1086.597205] 4.5.0-rc2+ #37 Not tainted
[ 1086.600914] -------------------------------------------------------
[ 1086.607118] runme.sh/1052 is trying to acquire lock:
[ 1086.612031]  (sb_writers#7){.+.+.+}, at: [<ffffffc000249500>] __sb_start_write+0xcc/0xe0
[ 1086.620090]
[ 1086.620090] but task is already holding lock:
[ 1086.625865]  (&policy->rwsem){+++++.}, at: [<ffffffc0005c8ee4>] cpufreq_offline+0x7c/0x278
[ 1086.634081]
[ 1086.634081] which lock already depends on the new lock.
[ 1086.634081]
[ 1086.642180]
[ 1086.642180] the existing dependency chain (in reverse order) is:
[ 1086.649589]
-> #1 (&policy->rwsem){+++++.}:
[ 1086.653929]        [<ffffffc00011d9a4>] check_prev_add+0x670/0x754
[ 1086.660060]        [<ffffffc00011e1ac>] validate_chain.isra.36+0x724/0xa0c
[ 1086.666876]        [<ffffffc00011f904>] __lock_acquire+0x4e4/0xba0
[ 1086.673001]        [<ffffffc000120b58>] lock_release+0x244/0x570
[ 1086.678955]        [<ffffffc0007351d0>] __mutex_unlock_slowpath+0xa0/0x18c
[ 1086.685771]        [<ffffffc0007352dc>] mutex_unlock+0x20/0x2c
[ 1086.691553]        [<ffffffc0002ccd24>] kernfs_fop_write+0xb0/0x194
[ 1086.697768]        [<ffffffc00024478c>] __vfs_write+0x48/0x104
[ 1086.703550]        [<ffffffc0002457a4>] vfs_write+0x98/0x198
[ 1086.709161]        [<ffffffc0002465e4>] SyS_write+0x54/0xb0
[ 1086.714684]        [<ffffffc000085d30>] el0_svc_naked+0x24/0x28
[ 1086.720555]
-> #0 (sb_writers#7){.+.+.+}:
[ 1086.724730]        [<ffffffc00011c574>] print_circular_bug+0x80/0x2e4
[ 1086.731116]        [<ffffffc00011d470>] check_prev_add+0x13c/0x754
[ 1086.737243]        [<ffffffc00011e1ac>] validate_chain.isra.36+0x724/0xa0c
[ 1086.744059]        [<ffffffc00011f904>] __lock_acquire+0x4e4/0xba0
[ 1086.750184]        [<ffffffc0001207f4>] lock_acquire+0xe4/0x204
[ 1086.756052]        [<ffffffc000118da0>] percpu_down_read+0x50/0xe4
[ 1086.762180]        [<ffffffc000249500>] __sb_start_write+0xcc/0xe0
[ 1086.768306]        [<ffffffc00026ae90>] mnt_want_write+0x28/0x54
[ 1086.774263]        [<ffffffc0002555f8>] do_last+0x660/0xcb8
[ 1086.779788]        [<ffffffc000255cdc>] path_openat+0x8c/0x2b0
[ 1086.785570]        [<ffffffc000256fbc>] do_filp_open+0x78/0xf0
[ 1086.791353]        [<ffffffc000244058>] do_sys_open+0x150/0x214
[ 1086.797222]        [<ffffffc0002441a0>] SyS_openat+0x3c/0x48
[ 1086.802831]        [<ffffffc000085d30>] el0_svc_naked+0x24/0x28
[ 1086.808700]
[ 1086.808700] other info that might help us debug this:
[ 1086.808700]
[ 1086.816627]  Possible unsafe locking scenario:
[ 1086.816627]
[ 1086.822488]        CPU0                    CPU1
[ 1086.826971]        ----                    ----
[ 1086.831453]   lock(&policy->rwsem);
[ 1086.834918]                                lock(sb_writers#7);
[ 1086.840713]                                lock(&policy->rwsem);
[ 1086.846671]   lock(sb_writers#7);
[ 1086.849972]
[ 1086.849972]  *** DEADLOCK ***
[ 1086.849972]
[ 1086.855836] 1 lock held by runme.sh/1052:
[ 1086.859802]  #0:  (&policy->rwsem){+++++.}, at: [<ffffffc0005c8ee4>] cpufreq_offline+0x7c/0x278
[ 1086.868453]
[ 1086.868453] stack backtrace:
[ 1086.872769] CPU: 5 PID: 1052 Comm: runme.sh Not tainted 4.5.0-rc2+ #37
[ 1086.879229] Hardware name: ARM Juno development board (r2) (DT)
[ 1086.885089] Call trace:
[ 1086.887511] [<ffffffc00008a788>] dump_backtrace+0x0/0x1f4
[ 1086.892858] [<ffffffc00008a99c>] show_stack+0x20/0x28
[ 1086.897861] [<ffffffc00041a380>] dump_stack+0x84/0xc0
[ 1086.902863] [<ffffffc00011c6c8>] print_circular_bug+0x1d4/0x2e4
[ 1086.908725] [<ffffffc00011d470>] check_prev_add+0x13c/0x754
[ 1086.914244] [<ffffffc00011e1ac>] validate_chain.isra.36+0x724/0xa0c
[ 1086.920448] [<ffffffc00011f904>] __lock_acquire+0x4e4/0xba0
[ 1086.925965] [<ffffffc0001207f4>] lock_acquire+0xe4/0x204
[ 1086.931224] [<ffffffc000118da0>] percpu_down_read+0x50/0xe4
[ 1086.936742] [<ffffffc000249500>] __sb_start_write+0xcc/0xe0
[ 1086.942260] [<ffffffc00026ae90>] mnt_want_write+0x28/0x54
[ 1086.947605] [<ffffffc0002555f8>] do_last+0x660/0xcb8
[ 1086.952520] [<ffffffc000255cdc>] path_openat+0x8c/0x2b0
[ 1086.957693] [<ffffffc000256fbc>] do_filp_open+0x78/0xf0
[ 1086.962865] [<ffffffc000244058>] do_sys_open+0x150/0x214
[ 1086.968123] [<ffffffc0002441a0>] SyS_openat+0x3c/0x48
[ 1086.973124] [<ffffffc000085d30>] el0_svc_naked+0x24/0x28
[ 1087.019315] Detected PIPT I-cache on CPU1
[ 1087.019373] CPU1: Booted secondary processor [410fd080]

Best,

- Juri

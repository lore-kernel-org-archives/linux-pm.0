From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Date: Thu, 14 Feb 2019 19:01:36 +0100
Message-ID: <1771fe9e-c107-f133-7b39-f4d7dbb004c5@partner.samsung.com>
References: <20190214013042.254790-1-mka@chromium.org>
        <CGME20190214013154epcas1p31326fdc127b3a75d566426e4f785121b@epcas1p3.samsung.com>
        <20190214013042.254790-5-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214013042.254790-5-mka@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Matthias,

I have compiled and run your changes on Odroid xu3 and v5.0-rc6.
There are kernel warnings because of mutex not held in function
devfreq_monitor_[start|stop]() in use cases:
  1) a few times during registration of new devices devfreq_add_device()
  2) poking the device from sysfs

ad 1)
-----8<--------------------------------------------------------
[   10.146986] exynos5-dmc 10c20000.memory-controller: Linked as a 
consumer to regulator.39
[   10.154619] ------------[ cut here ]------------
[   10.158210] WARNING: CPU: 6 PID: 58 at drivers/devfreq/devfreq.c:414 
devfreq_monitor_start+0xbc/0xdc
[   10.167370] devfreq->lock must be held by the caller.
[   10.172329] Modules linked in:
[   10.175405] CPU: 6 PID: 58 Comm: kworker/6:1 Tainted: G        W 
    5.0.0-rc6-00015-gd7c6e73 #43
[   10.184565] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   10.190624] Workqueue: events deferred_probe_work_func
[   10.195732] [<c0111a28>] (unwind_backtrace) from [<c010d8d4>] 
(show_stack+0x10/0x14)
[   10.203454] [<c010d8d4>] (show_stack) from [<c09efac0>] 
(dump_stack+0x90/0xc8)
[   10.210643] [<c09efac0>] (dump_stack) from [<c012591c>] 
(__warn+0xf8/0x124)
[   10.217573] [<c012591c>] (__warn) from [<c0125a08>] 
(warn_slowpath_fmt+0x38/0x48)
[   10.225029] [<c0125a08>] (warn_slowpath_fmt) from [<c07160ec>] 
(devfreq_monitor_start+0xbc/0xdc)
[   10.233786] [<c07160ec>] (devfreq_monitor_start) from [<c0716144>] 
(devfreq_governor_start+0x38/0x84)
[   10.242973] [<c0716144>] (devfreq_governor_start) from [<c07167b0>] 
(devfreq_add_device+0x270/0x454)
[   10.252072] [<c07167b0>] (devfreq_add_device) from [<c07169e0>] 
(devm_devfreq_add_device+0x4c/0x80)
[   10.261083] [<c07169e0>] (devm_devfreq_add_device) from [<c0719760>] 
(exynos5_dmc_probe+0x490/0x6b4)
[   10.270183] [<c0719760>] (exynos5_dmc_probe) from [<c054cb34>] 
(platform_drv_probe+0x48/0x98)
[   10.278672] [<c054cb34>] (platform_drv_probe) from [<c054a6b4>] 
(really_probe+0x224/0x3f4)
[   10.286903] [<c054a6b4>] (really_probe) from [<c054aad8>] 
(driver_probe_device+0x70/0x1c4)
[   10.295135] [<c054aad8>] (driver_probe_device) from [<c0548888>] 
(bus_for_each_drv+0x44/0x8c)
[   10.303628] [<c0548888>] (bus_for_each_drv) from [<c054a970>] 
(__device_attach+0xa0/0x138)
[   10.311859] [<c054a970>] (__device_attach) from [<c05497e8>] 
(bus_probe_device+0x88/0x90)
[   10.320005] [<c05497e8>] (bus_probe_device) from [<c0549d60>] 
(deferred_probe_work_func+0x6c/0xbc)
[   10.328933] [<c0549d60>] (deferred_probe_work_func) from [<c0143f1c>] 
(process_one_work+0x200/0x740)
[   10.338032] [<c0143f1c>] (process_one_work) from [<c0144484>] 
(process_scheduled_works+0x28/0x38)
[   10.346869] [<c0144484>] (process_scheduled_works) from [<c014469c>] 
(worker_thread+0x208/0x4c8)
[   10.355623] [<c014469c>] (worker_thread) from [<c014ac74>] 
(kthread+0x128/0x164)
[   10.362981] [<c014ac74>] (kthread) from [<c01010b4>] 
(ret_from_fork+0x14/0x20)
[   10.370171] Exception stack(0xee1d3fb0 to 0xee1d3ff8)
[   10.375187] 3fa0:                                     00000000 
00000000 00000000 00000000
[   10.383348] 3fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[   10.391493] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   10.398132] irq event stamp: 32781
[   10.401439] hardirqs last  enabled at (32789): [<c018c030>] 
console_unlock+0x474/0x700
[   10.409382] hardirqs last disabled at (32806): [<c018bc7c>] 
console_unlock+0xc0/0x700
[   10.417180] softirqs last  enabled at (32822): [<c01024cc>] 
__do_softirq+0x3a4/0x66c
[   10.424892] softirqs last disabled at (32833): [<c012d6b8>] 
irq_exit+0x140/0x168
[   10.432216] ---[ end trace 92e0ab098cadffbc ]---
[   10.436841] exynos5-dmc 10c20000.memory-controller: DMC init for 
prod_id=0xe5422001 pkg_id=0x2706832a
------->8------------------------------------------------------

ad 2)
-----8<--------------------------------------------------------
root@(none):/# echo simple_ondemand > /sys/class/devfreq/devfreq16/governor
[  594.577414] ------------[ cut here ]------------
[  594.581009] WARNING: CPU: 4 PID: 1 at drivers/devfreq/devfreq.c:436 
devfreq_monitor_stop+0x58/0x64
[  594.590032] devfreq->lock must be held by the caller.
[  594.596509] Modules linked in:
[  594.598149] CPU: 4 PID: 1 Comm: bash Tainted: G        W 
5.0.0-rc6-00015-gd7c6e73 #43
[  594.606618] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  594.612682] [<c0111a28>] (unwind_backtrace) from [<c010d8d4>] 
(show_stack+0x10/0x14)
[  594.620398] [<c010d8d4>] (show_stack) from [<c09efac0>] 
(dump_stack+0x90/0xc8)
[  594.627586] [<c09efac0>] (dump_stack) from [<c012591c>] 
(__warn+0xf8/0x124)
[  594.634515] [<c012591c>] (__warn) from [<c0125a08>] 
(warn_slowpath_fmt+0x38/0x48)
[  594.641972] [<c0125a08>] (warn_slowpath_fmt) from [<c0715968>] 
(devfreq_monitor_stop+0x58/0x64)
[  594.650642] [<c0715968>] (devfreq_monitor_stop) from [<c07159ac>] 
(devfreq_governor_stop+0x38/0x84)
[  594.659656] [<c07159ac>] (devfreq_governor_stop) from [<c0716224>] 
(governor_store+0x94/0x124)
[  594.668242] [<c0716224>] (governor_store) from [<c0544f54>] 
(dev_attr_store+0x18/0x24)
[  594.676118] [<c0544f54>] (dev_attr_store) from [<c02fba24>] 
(sysfs_kf_write+0x4c/0x50)
[  594.683999] [<c02fba24>] (sysfs_kf_write) from [<c02fab70>] 
(kernfs_fop_write+0xfc/0x1e4)
[  594.692150] [<c02fab70>] (kernfs_fop_write) from [<c027f3ec>] 
(__vfs_write+0x2c/0x160)
[  594.700031] [<c027f3ec>] (__vfs_write) from [<c027f6a8>] 
(vfs_write+0xa4/0x16c)
[  594.707308] [<c027f6a8>] (vfs_write) from [<c027f884>] 
(ksys_write+0x40/0x8c)
[  594.714412] [<c027f884>] (ksys_write) from [<c0101000>] 
(ret_fast_syscall+0x0/0x28)
[  594.722037] Exception stack(0xee8fbfa8 to 0xee8fbff0)
[  594.727053] bfa0:                   00000010 000d0408 00000001 
000d0408 00000010 00000000
[  594.735213] bfc0: 00000010 000d0408 b6e84d60 00000004 00000000 
000c8164 000c5730 000c5760
[  594.743357] bfe0: 00000000 be8908ac b6de801b b6e23b46
[  594.748470] irq event stamp: 411445
[  594.751832] hardirqs last  enabled at (411453): [<c018c030>] 
console_unlock+0x474/0x700
[  594.759875] hardirqs last disabled at (411476): [<c018bc7c>] 
console_unlock+0xc0/0x700
[  594.767749] softirqs last  enabled at (411494): [<c01024cc>] 
__do_softirq+0x3a4/0x66c
[  594.775598] softirqs last disabled at (411505): [<c012d6b8>] 
irq_exit+0x140/0x168
[  594.783064] ---[ end trace 92e0ab098cadffbd ]---
[  594.787535]
[  594.788987] =====================================
[  594.793668] WARNING: bad unlock balance detected!
[  594.798348] 5.0.0-rc6-00015-gd7c6e73 #43 Tainted: G        W
[  594.804674] -------------------------------------
[  594.809353] bash/1 is trying to release lock (&devfreq->lock) at:
[  594.815421] [<c0715930>] devfreq_monitor_stop+0x20/0x64
[  594.820618] but there are no more locks to release!
[  594.825470]
[  594.825470] other info that might help us debug this:
[  594.831972] 4 locks held by bash/1:
[  594.835434]  #0: a7707d8c (sb_writers#6){.+.+}, at: vfs_write+0x130/0x16c
[  594.842196]  #1: a7f34c9a (&of->mutex){+.+.}, at: 
kernfs_fop_write+0xc0/0x1e4
[  594.849301]  #2: ce189988 (kn->count#35){.+.+}, at: 
kernfs_fop_write+0xc8/0x1e4
[  594.856581]  #3: ab1648d8 (devfreq_list_lock){+.+.}, at: 
governor_store+0x44/0x124
[  594.864120]
[  594.864120] stack backtrace:
[  594.868453] CPU: 4 PID: 1 Comm: bash Tainted: G        W 
5.0.0-rc6-00015-gd7c6e73 #43
[  594.876946] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  594.883014] [<c0111a28>] (unwind_backtrace) from [<c010d8d4>] 
(show_stack+0x10/0x14)
[  594.890727] [<c010d8d4>] (show_stack) from [<c09efac0>] 
(dump_stack+0x90/0xc8)
[  594.897920] [<c09efac0>] (dump_stack) from [<c017e094>] 
(print_unlock_imbalance_bug+0xb0/0xe0)
[  594.906499] [<c017e094>] (print_unlock_imbalance_bug) from 
[<c01811b0>] (lock_release+0x190/0x380)
[  594.915427] [<c01811b0>] (lock_release) from [<c0a0aa08>] 
(__mutex_unlock_slowpath+0x30/0x274)
[  594.924004] [<c0a0aa08>] (__mutex_unlock_slowpath) from [<c0715930>] 
(devfreq_monitor_stop+0x20/0x64)
[  594.933189] [<c0715930>] (devfreq_monitor_stop) from [<c07159ac>] 
(devfreq_governor_stop+0x38/0x84)
[  594.942201] [<c07159ac>] (devfreq_governor_stop) from [<c0716224>] 
(governor_store+0x94/0x124)
[  594.950781] [<c0716224>] (governor_store) from [<c0544f54>] 
(dev_attr_store+0x18/0x24)
[  594.958665] [<c0544f54>] (dev_attr_store) from [<c02fba24>] 
(sysfs_kf_write+0x4c/0x50)
[  594.966549] [<c02fba24>] (sysfs_kf_write) from [<c02fab70>] 
(kernfs_fop_write+0xfc/0x1e4)
[  594.974696] [<c02fab70>] (kernfs_fop_write) from [<c027f3ec>] 
(__vfs_write+0x2c/0x160)
[  594.982581] [<c027f3ec>] (__vfs_write) from [<c027f6a8>] 
(vfs_write+0xa4/0x16c)
[  594.989860] [<c027f6a8>] (vfs_write) from [<c027f884>] 
(ksys_write+0x40/0x8c)
[  594.996964] [<c027f884>] (ksys_write) from [<c0101000>] 
(ret_fast_syscall+0x0/0x28)
[  595.004588] Exception stack(0xee8fbfa8 to 0xee8fbff0)
[  595.009613] bfa0:                   00000010 000d0408 00000001 
000d0408 00000010 00000000
[  595.017761] bfc0: 00000010 000d0408 b6e84d60 00000004 00000000 
000c8164 000c5730 000c5760
[  595.025906] bfe0: 00000000 be8908ac b6de801b b6e23b46
[  595.031013] ------------[ cut here ]------------
[  595.035572] WARNING: CPU: 4 PID: 1 at drivers/devfreq/devfreq.c:414 
devfreq_monitor_start+0xbc/0xdc
[  595.044590] devfreq->lock must be held by the caller.
[  595.049570] Modules linked in:
[  595.052656] CPU: 4 PID: 1 Comm: bash Tainted: G        W 
5.0.0-rc6-00015-gd7c6e73 #43
[  595.061106] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  595.067168] [<c0111a28>] (unwind_backtrace) from [<c010d8d4>] 
(show_stack+0x10/0x14)
[  595.074886] [<c010d8d4>] (show_stack) from [<c09efac0>] 
(dump_stack+0x90/0xc8)
[  595.082074] [<c09efac0>] (dump_stack) from [<c012591c>] 
(__warn+0xf8/0x124)
[  595.089005] [<c012591c>] (__warn) from [<c0125a08>] 
(warn_slowpath_fmt+0x38/0x48)
[  595.096461] [<c0125a08>] (warn_slowpath_fmt) from [<c07160ec>] 
(devfreq_monitor_start+0xbc/0xdc)
[  595.105217] [<c07160ec>] (devfreq_monitor_start) from [<c0716144>] 
(devfreq_governor_start+0x38/0x84)
[  595.114404] [<c0716144>] (devfreq_governor_start) from [<c0716248>] 
(governor_store+0xb8/0x124)
[  595.123069] [<c0716248>] (governor_store) from [<c0544f54>] 
(dev_attr_store+0x18/0x24)
[  595.130951] [<c0544f54>] (dev_attr_store) from [<c02fba24>] 
(sysfs_kf_write+0x4c/0x50)
[  595.138835] [<c02fba24>] (sysfs_kf_write) from [<c02fab70>] 
(kernfs_fop_write+0xfc/0x1e4)
[  595.146983] [<c02fab70>] (kernfs_fop_write) from [<c027f3ec>] 
(__vfs_write+0x2c/0x160)
[  595.154868] [<c027f3ec>] (__vfs_write) from [<c027f6a8>] 
(vfs_write+0xa4/0x16c)
[  595.162145] [<c027f6a8>] (vfs_write) from [<c027f884>] 
(ksys_write+0x40/0x8c)
[  595.169248] [<c027f884>] (ksys_write) from [<c0101000>] 
(ret_fast_syscall+0x0/0x28)
[  595.176874] Exception stack(0xee8fbfa8 to 0xee8fbff0)
[  595.181893] bfa0:                   00000010 000d0408 00000001 
000d0408 00000010 00000000
[  595.190049] bfc0: 00000010 000d0408 b6e84d60 00000004 00000000 
000c8164 000c5730 000c5760
[  595.198193] bfe0: 00000000 be8908ac b6de801b b6e23b46
[  595.203283] irq event stamp: 411551
[  595.206672] hardirqs last  enabled at (411551): [<c018c030>] 
console_unlock+0x474/0x700
[  595.214690] hardirqs last disabled at (411550): [<c018bc7c>] 
console_unlock+0xc0/0x700
[  595.222572] softirqs last  enabled at (411540): [<c01024cc>] 
__do_softirq+0x3a4/0x66c
[  595.230342] softirqs last disabled at (411527): [<c012d6b8>] 
irq_exit+0x140/0x168
[  595.237852] ---[ end trace 92e0ab098cadffbe ]---
root@(none):/# echo 50 > /sys/class/devfreq/devfreq16/polling_interval
[  595.472717] ------------[ cut here ]------------
[  595.475872] WARNING: CPU: 7 PID: 1 at drivers/devfreq/devfreq.c:414 
devfreq_monitor_start+0xbc/0xdc
[  595.484926] devfreq->lock must be held by the caller.
[  595.489903] Modules linked in:
[  595.492963] CPU: 7 PID: 1 Comm: bash Tainted: G        W 
5.0.0-rc6-00015-gd7c6e73 #43
[  595.501439] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  595.507502] [<c0111a28>] (unwind_backtrace) from [<c010d8d4>] 
(show_stack+0x10/0x14)
[  595.515218] [<c010d8d4>] (show_stack) from [<c09efac0>] 
(dump_stack+0x90/0xc8)
[  595.522409] [<c09efac0>] (dump_stack) from [<c012591c>] 
(__warn+0xf8/0x124)
[  595.529339] [<c012591c>] (__warn) from [<c0125a08>] 
(warn_slowpath_fmt+0x38/0x48)
[  595.536795] [<c0125a08>] (warn_slowpath_fmt) from [<c07160ec>] 
(devfreq_monitor_start+0xbc/0xdc)
[  595.545550] [<c07160ec>] (devfreq_monitor_start) from [<c0716434>] 
(devfreq_interval_update+0x78/0x90)
[  595.554825] [<c0716434>] (devfreq_interval_update) from [<c0717970>] 
(devfreq_simple_ondemand_handler+0x14/0)
[  595.564966] [<c0717970>] (devfreq_simple_ondemand_handler) from 
[<c071575c>] (polling_interval_store+0x50/0x)
[  595.575019] [<c071575c>] (polling_interval_store) from [<c0544f54>] 
(dev_attr_store+0x18/0x24)
[  595.583592] [<c0544f54>] (dev_attr_store) from [<c02fba24>] 
(sysfs_kf_write+0x4c/0x50)
[  595.591474] [<c02fba24>] (sysfs_kf_write) from [<c02fab70>] 
(kernfs_fop_write+0xfc/0x1e4)
[  595.599621] [<c02fab70>] (kernfs_fop_write) from [<c027f3ec>] 
(__vfs_write+0x2c/0x160)
[  595.607506] [<c027f3ec>] (__vfs_write) from [<c027f6a8>] 
(vfs_write+0xa4/0x16c)
[  595.614783] [<c027f6a8>] (vfs_write) from [<c027f884>] 
(ksys_write+0x40/0x8c)
[  595.621887] [<c027f884>] (ksys_write) from [<c0101000>] 
(ret_fast_syscall+0x0/0x28)
[  595.629512] Exception stack(0xee8fbfa8 to 0xee8fbff0)
[  595.634531] bfa0:                   00000003 000d0408 00000001 
000d0408 00000003 00000000
[  595.642686] bfc0: 00000003 000d0408 b6e84d60 00000004 00000000 
000c8164 000c5730 000c5760
[  595.650830] bfe0: 00000000 be8908ac b6de801b b6e23b46
[  595.655877] irq event stamp: 411551
[  595.659309] hardirqs last  enabled at (411551): [<c018c030>] 
console_unlock+0x474/0x700
[  595.667324] hardirqs last disabled at (411550): [<c018bc7c>] 
console_unlock+0xc0/0x700
[  595.675210] softirqs last  enabled at (411540): [<c01024cc>] 
__do_softirq+0x3a4/0x66c
[  595.683009] softirqs last disabled at (411527): [<c012d6b8>] 
irq_exit+0x140/0x168
[  595.690430] ---[ end trace 92e0ab098cadffbf ]---

------->8------------------------------------------------------


Regards,
Lukasz

On 2/14/19 2:30 AM, Matthias Kaehlcke wrote:
> devfreq expects governors to call devfreq_monitor_start/stop()
> in response to DEVFREQ_GOV_START/STOP events. Since the devfreq
> core itself generates these events and invokes the governor's event
> handler the start/stop of the load monitor can be done in the common
> code.
> 
> Call devfreq_monitor_start/stop() when the governor reports a
> successful handling of DEVFREQ_GOV_START/STOP and remove these
> calls from the simpleondemand and tegra governors. Make
> devfreq_monitor_start/stop() static since these functions are now
> only used by the devfreq core. For better integration with the
> callers the functions must now be called with devfreq->lock held.
> 
> Also stop manipulating the monitor workqueue directly, use
> devfreq_monitor_start/stop() instead.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   drivers/devfreq/devfreq.c                 | 45 +++++++++++------------
>   drivers/devfreq/governor.h                |  2 -
>   drivers/devfreq/governor_simpleondemand.c |  8 ----
>   drivers/devfreq/tegra-devfreq.c           |  2 -
>   4 files changed, 22 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index eb86461648d74..ac553c00f6790 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -404,14 +404,14 @@ static void devfreq_monitor(struct work_struct *work)
>    * devfreq_monitor_start() - Start load monitoring of devfreq instance
>    * @devfreq:	the devfreq instance.
>    *
> - * Helper function for starting devfreq device load monitoing. By
> - * default delayed work based monitoring is supported. Function
> - * to be called from governor in response to DEVFREQ_GOV_START
> - * event when device is added to devfreq framework.
> + * Helper function for starting devfreq device load monitoring. By
> + * default delayed work based monitoring is supported. Must be called
> + * with devfreq->lock held.
>    */
> -void devfreq_monitor_start(struct devfreq *devfreq)
> +static void devfreq_monitor_start(struct devfreq *devfreq)
>   {
> -	mutex_lock(&devfreq->lock);
> +	WARN(!mutex_is_locked(&devfreq->lock),
> +	     "devfreq->lock must be held by the caller.\n");
>   
>   	if (devfreq->profile->polling_ms) {
>   		INIT_DEFERRABLE_WORK(&devfreq->work, devfreq_monitor);
> @@ -420,28 +420,28 @@ void devfreq_monitor_start(struct devfreq *devfreq)
>   
>   		devfreq->monitor_state = DEVFREQ_MONITOR_RUNNING;
>   	}
> -
> -	mutex_unlock(&devfreq->lock);
>   }
> -EXPORT_SYMBOL(devfreq_monitor_start);
>   
>   /**
>    * devfreq_monitor_stop() - Stop load monitoring of a devfreq instance
>    * @devfreq:	the devfreq instance.
>    *
> - * Helper function to stop devfreq device load monitoing. Function
> - * to be called from governor in response to DEVFREQ_GOV_STOP
> - * event when device is removed from devfreq framework.
> + * Helper function to stop devfreq device load monitoring. Must be
> + * called with devfreq->lock held.
>    */
> -void devfreq_monitor_stop(struct devfreq *devfreq)
> +static void devfreq_monitor_stop(struct devfreq *devfreq)
>   {
> +	/* mutex must be held for symmetry with _start() */
> +	WARN(!mutex_is_locked(&devfreq->lock),
> +	     "devfreq->lock must be held by the caller.\n");
> +
> +	mutex_unlock(&devfreq->lock);
>   	cancel_delayed_work_sync(&devfreq->work);
>   
>   	mutex_lock(&devfreq->lock);
>   	devfreq->monitor_state = DEVFREQ_MONITOR_STOPPED;
>   	mutex_unlock(&devfreq->lock);
>   }
> -EXPORT_SYMBOL(devfreq_monitor_stop);
>   
>   /**
>    * devfreq_monitor_suspend() - Suspend load monitoring of a devfreq instance
> @@ -518,27 +518,22 @@ void devfreq_interval_update(struct devfreq *devfreq, unsigned int *delay)
>   
>   	/* if new delay is zero, stop polling */
>   	if (!new_delay) {
> +		devfreq_monitor_stop(devfreq);
>   		mutex_unlock(&devfreq->lock);
> -		cancel_delayed_work_sync(&devfreq->work);
> -		devfreq->monitor_state == DEVFREQ_MONITOR_STOPPED;
>   		return;
>   	}
>   
>   	/* if current delay is zero, start polling with new delay */
>   	if (!cur_delay) {
> -		queue_delayed_work(devfreq_wq, &devfreq->work,
> -			msecs_to_jiffies(devfreq->profile->polling_ms));
> +		devfreq_monitor_start(devfreq);
>   		goto out;
>   	}
>   
>   	/* if current delay is greater than new delay, restart polling */
>   	if (cur_delay > new_delay) {
> -		mutex_unlock(&devfreq->lock);
> -		cancel_delayed_work_sync(&devfreq->work);
> -		mutex_lock(&devfreq->lock);
> +		devfreq_monitor_stop(devfreq);
>   		if (devfreq->monitor_state != DEVFREQ_MONITOR_SUSPENDED)
> -			queue_delayed_work(devfreq_wq, &devfreq->work,
> -			      msecs_to_jiffies(devfreq->profile->polling_ms));
> +			devfreq_monitor_start(devfreq);
>   	}
>   out:
>   	mutex_unlock(&devfreq->lock);
> @@ -601,6 +596,8 @@ static int devfreq_governor_start(struct devfreq *devfreq)
>   		return err;
>   	}
>   
> +	devfreq_monitor_start(devfreq);
> +
>   	return 0;
>   }
>   
> @@ -624,6 +621,8 @@ static int devfreq_governor_stop(struct devfreq *devfreq)
>   		return err;
>   	}
>   
> +	devfreq_monitor_stop(devfreq);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> index d136792c0cc91..47efe747b6f79 100644
> --- a/drivers/devfreq/governor.h
> +++ b/drivers/devfreq/governor.h
> @@ -57,8 +57,6 @@ struct devfreq_governor {
>   				unsigned int event, void *data);
>   };
>   
> -extern void devfreq_monitor_start(struct devfreq *devfreq);
> -extern void devfreq_monitor_stop(struct devfreq *devfreq);
>   extern void devfreq_interval_update(struct devfreq *devfreq,
>   					unsigned int *delay);
>   
> diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
> index 52eb0c734b312..e0f0944a9c7aa 100644
> --- a/drivers/devfreq/governor_simpleondemand.c
> +++ b/drivers/devfreq/governor_simpleondemand.c
> @@ -91,14 +91,6 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
>   				unsigned int event, void *data)
>   {
>   	switch (event) {
> -	case DEVFREQ_GOV_START:
> -		devfreq_monitor_start(devfreq);
> -		break;
> -
> -	case DEVFREQ_GOV_STOP:
> -		devfreq_monitor_stop(devfreq);
> -		break;
> -
>   	case DEVFREQ_GOV_INTERVAL:
>   		devfreq_interval_update(devfreq, (unsigned int *)data);
>   		break;
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index 79efa1e51bd06..515fb852dbad6 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -580,13 +580,11 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>   
>   	switch (event) {
>   	case DEVFREQ_GOV_START:
> -		devfreq_monitor_start(devfreq);
>   		tegra_actmon_enable_interrupts(tegra);
>   		break;
>   
>   	case DEVFREQ_GOV_STOP:
>   		tegra_actmon_disable_interrupts(tegra);
> -		devfreq_monitor_stop(devfreq);
>   		break;
>   
>   	case DEVFREQ_GOV_SUSPEND:
> 

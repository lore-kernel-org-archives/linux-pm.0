From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH V5] thermal: Add cooling device's statistics in sysfs
Date: Mon, 13 Aug 2018 19:06:46 +0300
Message-ID: <d78a41e0-6602-e0f2-c00c-30b4766bb82c@gmail.com>
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02.04.2018 13:56, Viresh Kumar wrote:
> This extends the sysfs interface for thermal cooling devices and exposes
> some pretty useful statistics. These statistics have proven to be quite
> useful specially while doing benchmarks related to the task scheduler,
> where we want to make sure that nothing has disrupted the test,
> specially the cooling device which may have put constraints on the CPUs.
> The information exposed here tells us to what extent the CPUs were
> constrained by the thermal framework.
> 
> The write-only "reset" file is used to reset the statistics.
> 
> The read-only "time_in_state_ms" file shows the time (in msec) spent by the
> device in the respective cooling states, and it prints one line per
> cooling state.
> 
> The read-only "total_trans" file shows single positive integer value
> showing the total number of cooling state transitions the device has
> gone through since the time the cooling device is registered or the time
> when statistics were reset last.
> 
> The read-only "trans_table" file shows a two dimensional matrix, where
> an entry <i,j> (row i, column j) represents the number of transitions
> from State_i to State_j.
> 
> This is how the directory structure looks like for a single cooling
> device:
> 
> $ ls -R /sys/class/thermal/cooling_device0/
> /sys/class/thermal/cooling_device0/:
> cur_state  max_state  power  stats  subsystem  type  uevent
> 
> /sys/class/thermal/cooling_device0/power:
> autosuspend_delay_ms  runtime_active_time  runtime_suspended_time
> control               runtime_status
> 
> /sys/class/thermal/cooling_device0/stats:
> reset  time_in_state_ms  total_trans  trans_table
> 
> This is tested on ARM 64-bit Hisilicon hikey620 board running Ubuntu and
> ARM 64-bit Hisilicon hikey960 board running Android.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Hello,

I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30 CPUFreq driver and stumbled upon a bug that is introduced by this patch. It is triggered on the driver module unload.

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab982309e6a..de53c821a282 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
        mutex_unlock(&thermal_list_lock);
 
        ida_simple_remove(&thermal_cdev_ida, cdev->id);
-       device_unregister(&cdev->device);
        thermal_cooling_device_destroy_sysfs(cdev);
+       device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);

This patch fixes the issue with the "cooling_device", but I'm not sure that it won't break thermal_zone". Also see KASAN report below.


[   65.553469] ==================================================================
[   65.572514] BUG: KASAN: use-after-free in thermal_cooling_device_destroy_sysfs+0x24/0x40
[   65.592300] Read of size 4 at addr ced17c80 by task rmmod/206

[   65.632387] CPU: 1 PID: 206 Comm: rmmod Not tainted 4.18.0-rc8-next-20180810-00148-g2863c2b33049-dirty #361
[   65.654241] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   65.676552] [<c0116784>] (unwind_backtrace) from [<c010fd54>] (show_stack+0x20/0x24)
[   65.699719] [<c010fd54>] (show_stack) from [<c10861b4>] (dump_stack+0x9c/0xb0)
[   65.723224] [<c10861b4>] (dump_stack) from [<c03012ac>] (print_address_description+0x60/0x268)
[   65.747525] [<c03012ac>] (print_address_description) from [<c03018c8>] (kasan_report+0x120/0x388)
[   65.771873] [<c03018c8>] (kasan_report) from [<c02fff44>] (__asan_load4+0x64/0xb4)
[   65.796324] [<c02fff44>] (__asan_load4) from [<c0b76d00>] (thermal_cooling_device_destroy_sysfs+0x24/0x40)
[   65.820990] [<c0b76d00>] (thermal_cooling_device_destroy_sysfs) from [<c0b73804>] (thermal_cooling_device_unregister+0x130/0x238)
[   65.846039] [<c0b73804>] (thermal_cooling_device_unregister) from [<c0b7a26c>] (cpufreq_cooling_unregister+0xa8/0xfc)
[   65.870897] [<c0b7a26c>] (cpufreq_cooling_unregister) from [<bf0003c0>] (tegra_cpu_exit+0x2c/0x74 [tegra20_cpufreq])
[   65.895940] [<bf0003c0>] (tegra_cpu_exit [tegra20_cpufreq]) from [<c0b83fa4>] (cpufreq_offline+0x160/0x298)
[   65.920899] [<c0b83fa4>] (cpufreq_offline) from [<c0b841cc>] (cpufreq_remove_dev+0xd0/0xd4)
[   65.945804] [<c0b841cc>] (cpufreq_remove_dev) from [<c0867c90>] (subsys_interface_unregister+0xe4/0x130)
[   65.971622] [<c0867c90>] (subsys_interface_unregister) from [<c0b823f0>] (cpufreq_unregister_driver+0x44/0x8c)
[   65.998135] [<c0b823f0>] (cpufreq_unregister_driver) from [<bf00002c>] (tegra20_cpufreq_remove+0x2c/0x34 [tegra20_cpufreq])
[   66.025805] [<bf00002c>] (tegra20_cpufreq_remove [tegra20_cpufreq]) from [<c086cde4>] (platform_drv_remove+0x44/0x64)
[   66.053768] [<c086cde4>] (platform_drv_remove) from [<c086a93c>] (device_release_driver_internal+0x1f0/0x2e0)
[   66.081707] [<c086a93c>] (device_release_driver_internal) from [<c086aab8>] (driver_detach+0x68/0xb8)
[   66.110346] [<c086aab8>] (driver_detach) from [<c0869128>] (bus_remove_driver+0x84/0xfc)
[   66.139530] [<c0869128>] (bus_remove_driver) from [<c086b898>] (driver_unregister+0x4c/0x6c)
[   66.169514] [<c086b898>] (driver_unregister) from [<c086cee8>] (platform_driver_unregister+0x1c/0x20)
[   66.200091] [<c086cee8>] (platform_driver_unregister) from [<bf000980>] (tegra20_cpufreq_driver_exit+0x18/0x698 [tegra20_cpufreq])
[   66.232017] [<bf000980>] (tegra20_cpufreq_driver_exit [tegra20_cpufreq]) from [<c01ff02c>] (sys_delete_module+0x198/0x224)
[   66.264804] [<c01ff02c>] (sys_delete_module) from [<c0101000>] (ret_fast_syscall+0x0/0x58)
[   66.298137] Exception stack(0xce94bfa8 to 0xce94bff0)
[   66.331825] bfa0:                   0003f0d0 00000002 0003f10c 00000800 5e6a7500 5e6a7500
[   66.366665] bfc0: 0003f0d0 00000002 0003f0d0 00000081 b6a723d0 b6a7207c b6a7226c 00000001
[   66.401864] bfe0: aec42610 b6a72014 00022408 aec4261c

[   66.472603] Allocated by task 151:
[   66.508377]  kasan_kmalloc+0xd4/0x174
[   66.544570]  kmem_cache_alloc_trace+0x198/0x2e8
[   66.581197]  __thermal_cooling_device_register+0x9c/0x4c0
[   66.618085]  thermal_of_cooling_device_register+0x18/0x1c
[   66.655387]  __cpufreq_cooling_register+0x4c4/0x604
[   66.692976]  of_cpufreq_cooling_register+0x88/0xe8
[   66.730726]  tegra_cpu_ready+0x28/0x3c [tegra20_cpufreq]
[   66.768872]  cpufreq_online+0x798/0x8d0
[   66.807262]  cpufreq_add_dev+0xa0/0xac
[   66.845892]  subsys_interface_register+0x104/0x148
[   66.884167]  cpufreq_register_driver+0x1d0/0x264
[   66.922070]  tegra20_cpufreq_probe+0x1f8/0x27c [tegra20_cpufreq]
[   66.959803]  platform_drv_probe+0x70/0xc8
[   66.997149]  really_probe+0x284/0x3d4
[   67.034006]  driver_probe_device+0x80/0x1b8
[   67.070515]  __driver_attach+0x130/0x134
[   67.106447]  bus_for_each_dev+0x98/0xc4
[   67.141867]  driver_attach+0x38/0x3c
[   67.177010]  bus_add_driver+0x238/0x2cc
[   67.211717]  driver_register+0xdc/0x1b0
[   67.245684]  __platform_driver_register+0x7c/0x84
[   67.279456]  0xbf005028
[   67.312693]  do_one_initcall+0x60/0x344
[   67.345795]  do_init_module+0xe4/0x30c
[   67.378294]  load_module+0x3008/0x3784
[   67.410423]  sys_finit_module+0xac/0xc4
[   67.442102]  ret_fast_syscall+0x0/0x58
[   67.472788]  0xb6781c10

[   67.531724] Freed by task 206:
[   67.560135]  __kasan_slab_free+0x12c/0x204
[   67.587993]  kasan_slab_free+0x14/0x18
[   67.615343]  kfree+0x90/0x294
[   67.642143]  thermal_release+0x6c/0x98
[   67.668309]  device_release+0x4c/0xe8
[   67.693667]  kobject_put+0xac/0x11c
[   67.718166]  device_unregister+0x2c/0x30
[   67.742308]  thermal_cooling_device_unregister+0x128/0x238
[   67.766189]  cpufreq_cooling_unregister+0xa8/0xfc
[   67.789630]  tegra_cpu_exit+0x2c/0x74 [tegra20_cpufreq]
[   67.812973]  cpufreq_offline+0x160/0x298
[   67.835506]  cpufreq_remove_dev+0xd0/0xd4
[   67.857115]  subsys_interface_unregister+0xe4/0x130
[   67.878280]  cpufreq_unregister_driver+0x44/0x8c
[   67.899235]  tegra20_cpufreq_remove+0x2c/0x34 [tegra20_cpufreq]
[   67.919948]  platform_drv_remove+0x44/0x64
[   67.940467]  device_release_driver_internal+0x1f0/0x2e0
[   67.960895]  driver_detach+0x68/0xb8
[   67.981161]  bus_remove_driver+0x84/0xfc
[   68.001382]  driver_unregister+0x4c/0x6c
[   68.021561]  platform_driver_unregister+0x1c/0x20
[   68.041879]  tegra20_cpufreq_driver_exit+0x18/0x698 [tegra20_cpufreq]
[   68.062376]  sys_delete_module+0x198/0x224
[   68.082826]  ret_fast_syscall+0x0/0x58
[   68.103010]  0xb6a72014

-- 
Dmitry

From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: [BUG] v4.11-rc1: CPUFREQ Circular locking dependency
Date: Fri, 10 Mar 2017 15:02:18 +0000
Message-ID: <20170310150218.GW21222@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38682 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbdCJPC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2017 10:02:28 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

======================================================
[ INFO: possible circular locking dependency detected ]
4.11.0-rc1+ #2121 Not tainted
-------------------------------------------------------
ondemand/1005 is trying to acquire lock:
 (cooling_list_lock){+.+...}, at: [<c052d074>] cpufreq_thermal_notifier+0x2c/0xcc
               but task is already holding lock:
 ((cpufreq_policy_notifier_list).rwsem){++++..}, at: [<c0058ff8>] __blocking_notifier_call_chain+0x34/0x68
               which lock already depends on the new lock.

               the existing dependency chain (in reverse order) is:
-> #1 ((cpufreq_policy_notifier_list).rwsem){++++..}:
       down_write+0x44/0x98
       blocking_notifier_chain_register+0x28/0xd8
       cpufreq_register_notifier+0xa4/0xe4
       __cpufreq_cooling_register+0x4cc/0x578
       cpufreq_cooling_register+0x20/0x24
       imx_thermal_probe+0x1c4/0x5f4 [imx_thermal]
       platform_drv_probe+0x58/0xb8
       driver_probe_device+0x204/0x2c8
       __driver_attach+0xbc/0xc0
       bus_for_each_dev+0x5c/0x90
       driver_attach+0x24/0x28
       bus_add_driver+0xf4/0x200
       driver_register+0x80/0xfc
       __platform_driver_register+0x48/0x4c
       0xbf04d018
       do_one_initcall+0x44/0x170
       do_init_module+0x68/0x1d8
       load_module+0x1968/0x208c
       SyS_finit_module+0x94/0xa0
       ret_fast_syscall+0x0/0x1c
-> #0 (cooling_list_lock){+.+...}:
       lock_acquire+0xd8/0x250
       __mutex_lock+0x58/0x930
       mutex_lock_nested+0x24/0x2c
       cpufreq_thermal_notifier+0x2c/0xcc
       notifier_call_chain+0x4c/0x8c
       __blocking_notifier_call_chain+0x50/0x68
       blocking_notifier_call_chain+0x20/0x28
       cpufreq_set_policy+0x74/0x1a4
       store_scaling_governor+0x68/0x84
       store+0x70/0x94
       sysfs_kf_write+0x54/0x58
       kernfs_fop_write+0x138/0x204
       __vfs_write+0x34/0x11c
       vfs_write+0xac/0x16c
       SyS_write+0x44/0x90
       ret_fast_syscall+0x0/0x1c

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock((cpufreq_policy_notifier_list).rwsem);
                               lock(cooling_list_lock);
                               lock((cpufreq_policy_notifier_list).rwsem);
  lock(cooling_list_lock);

      *** DEADLOCK ***

6 locks held by ondemand/1005:
 #0:  (sb_writers#6){.+.+.+}, at: [<c017cf38>] vfs_write+0x150/0x16c
 #1:  (&of->mutex){+.+.+.}, at: [<c01fbd7c>] kernfs_fop_write+0xf8/0x204
 #2:  (s_active#135){.+.+.+}, at: [<c01fbd84>] kernfs_fop_write+0x100/0x204
 #3:  (cpu_hotplug.dep_map){++++++}, at: [<c0034028>] get_online_cpus+0x34/0xa8
 #4:  (&policy->rwsem){+++++.}, at: [<c052edd8>] store+0x5c/0x94
 #5:  ((cpufreq_policy_notifier_list).rwsem){++++..}, at: [<c0058ff8>] __blocking_notifier_call_chain+0x34/0x68

stack backtrace:
CPU: 1 PID: 1005 Comm: ondemand Not tainted 4.11.0-rc1+ #2121
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
Backtrace:
[<c0013ba4>] (dump_backtrace) from [<c0013de4>] (show_stack+0x18/0x1c)
 r6:600e0093 r5:ffffffff r4:00000000 r3:00000000
[<c0013dcc>] (show_stack) from [<c033ea48>] (dump_stack+0xa4/0xdc)
[<c033e9a4>] (dump_stack) from [<c011db2c>] (print_circular_bug+0x28c/0x2e0)
 r6:c0bf2d84 r5:c0bf2e94 r4:c0bf2d84 r3:c09e84a8
[<c011d8a0>] (print_circular_bug) from [<c008b08c>] (__lock_acquire+0x16c8/0x17b0)
 r10:ee75aa48 r8:00000006 r7:c0a531c8 r6:ee75aa28 r5:ee75a4c0 r4:c141aa58
[<c00899c4>] (__lock_acquire) from [<c008b6d8>] (lock_acquire+0xd8/0x250)
 r10:00000000 r9:c0a8a8a4 r8:00000000 r7:00000000 r6:c0a74fe4 r5:600e0013
 r4:00000000
[<c008b600>] (lock_acquire) from [<c070ce18>] (__mutex_lock+0x58/0x930)
 r10:00000002 r9:00000000 r8:c141aa58 r7:edc8bca0 r6:00000000 r5:00000000
 r4:c0a74fb0
[<c070cdc0>] (__mutex_lock) from [<c070d798>] (mutex_lock_nested+0x24/0x2c)
 r10:00000008 r9:00000000 r8:00000000 r7:edc8bca0 r6:00000000 r5:c0a74fb0
 r4:edc8bca0
[<c070d774>] (mutex_lock_nested) from [<c052d074>] (cpufreq_thermal_notifier+0x2c/0xcc)
[<c052d048>] (cpufreq_thermal_notifier) from [<c0058c54>] (notifier_call_chain+0x4c/0x8c)
 r5:00000000 r4:ffffffff
[<c0058c08>] (notifier_call_chain) from [<c0059014>] (__blocking_notifier_call_chain+0x50/0x68)
 r8:d014e400 r7:00000000 r6:edc8bca0 r5:ffffffff r4:c0a7521c r3:ffffffff
[<c0058fc4>] (__blocking_notifier_call_chain) from [<c005904c>] (blocking_notifier_call_chain+0x20/0x28)
 r7:c1437a4c r6:00000000 r5:d014e400 r4:edc8bca0
[<c005902c>] (blocking_notifier_call_chain) from [<c05318d0>] (cpufreq_set_policy+0x74/0x1a4)
[<c053185c>] (cpufreq_set_policy) from [<c0531a68>] (store_scaling_governor+0x68/0x84)
 r8:d014e400 r7:c0a75410 r6:00000008 r5:d8f83480 r4:d014e400 r3:00000000
[<c0531a00>] (store_scaling_governor) from [<c052edec>] (store+0x70/0x94)
 r6:d8f83480 r5:00000008 r4:d014e4e0
[<c052ed7c>] (store) from [<c01fcc54>] (sysfs_kf_write+0x54/0x58)
 r8:00000000 r7:d8f83480 r6:d8f83480 r5:00000008 r4:d01c1240 r3:00000008
[<c01fcc00>] (sysfs_kf_write) from [<c01fbdbc>] (kernfs_fop_write+0x138/0x204)
 r6:d01c1240 r5:d01c1250 r4:00000000 r3:ee75a4c0
[<c01fbc84>] (kernfs_fop_write) from [<c017b6f0>] (__vfs_write+0x34/0x11c)
 r10:809f5d08 r9:edc8a000 r8:00000008 r7:edc8bf78 r6:d5af4b40 r5:809f5d08
 r4:c071eebc
[<c017b6bc>] (__vfs_write) from [<c017ce94>] (vfs_write+0xac/0x16c)
 r8:edc8bf78 r7:00000000 r6:809f5d08 r5:00000008 r4:d5af4b40
[<c017cde8>] (vfs_write) from [<c017d144>] (SyS_write+0x44/0x90)
 r10:809f5d08 r8:00000008 r7:d5af4b40 r6:d5af4b40 r5:00000000 r4:00000000
[<c017d100>] (SyS_write) from [<c000fd60>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r8:c000ff04 r7:00000004 r6:7f8a8d08 r5:809f5d08 r4:00000008

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

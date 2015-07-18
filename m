From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: BUG: cpufreq on imx6solo warns
Date: Sat, 18 Jul 2015 17:31:50 +0100
Message-ID: <20150718163149.GP7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:51733 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbbGRQcE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jul 2015 12:32:04 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

Post-rc1, cpufreq on iMX6 now warns at boot as per the below message.

iMX6 solo only has one CPU, but it is treated as a SMP platform with
two CPUs, the second one is offline.

The boot state is:
	possible: cpu 0,1
	present: cpu 0,1
	online: cpu 0

This seems to cause cpufreq_add_dev() for CPU0 to add a symlink for
cpu1/cpufreq pointing at ../cpu0/cpufreq.  Then cpufreq_add_dev() is
called for CPU1, which tries also to create a symlink, which fails.
This is clearly incorrect behaviour.

Not sure what the right fix would be for this.

[    2.786733] ------------[ cut here ]------------
[    2.794795] WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x60/0x7c()
[    2.807930] sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/cpufreq'
[    2.819335] Modules linked in:
[    2.825920] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc2+ #1704
[    2.835958] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.845982] Backtrace:
[    2.851920] [<c0013248>] (dump_backtrace) from [<c00133e4>] (show_stack+0x18/0x1c)
[    2.863143]  r6:c01a1f30 r5:0000001f r4:00000000 r3:00000000
[    2.872534] [<c00133cc>] (show_stack) from [<c076920c>] (dump_stack+0x7c/0x98)
[    2.883339] [<c0769190>] (dump_stack) from [<c0029ab4>] (warn_slowpath_common+0x80/0xbc)
[    2.895028]  r4:d74abbd0 r3:d74c0000
[    2.902307] [<c0029a34>] (warn_slowpath_common) from [<c0029b94>] (warn_slowpath_fmt+0x38/0x40)
[    2.914663]  r8:ffffffef r7:00000000 r6:d75a8960 r5:c0993280 r4:d6b4d000
[    2.925253] [<c0029b60>] (warn_slowpath_fmt) from [<c01a1f30>] (sysfs_warn_dup+0x60/0x7c)
[    2.937143]  r3:d6b4dfe7 r2:c0930750
[    2.944531] [<c01a1ed0>] (sysfs_warn_dup) from [<c01a22c8>] (sysfs_do_create_link_sd+0xb8/0xc0)
[    2.956998]  r6:d75a8960 r5:c0993280 r4:d00aba20
[    2.965540] [<c01a2210>] (sysfs_do_create_link_sd) from [<c01a22fc>] (sysfs_create_link+0x2c/0x3c)
[    2.978349]  r10:00000001 r8:c14db3c8 r7:d7b89010 r6:c0ae7c60 r5:d7b89010 r4:d00d1200
[    2.990275] [<c01a22d0>] (sysfs_create_link) from [<c0506160>] (add_cpu_dev_symlink+0x34/0x5c)
[    3.002792] [<c050612c>] (add_cpu_dev_symlink) from [<c05084d0>] (cpufreq_add_dev+0x674/0x794)
[    3.015274]  r5:00000001 r4:00000000
[    3.022857] [<c0507e5c>] (cpufreq_add_dev) from [<c03db114>] (subsys_interface_register+0x8c/0xd0)
[    3.035770]  r10:00000003 r9:d7bb01f0 r8:c14db3c8 r7:00106738 r6:c0ae7c60 r5:c0acbd08
[    3.047792]  r4:c0ae7e20
[    3.054411] [<c03db088>] (subsys_interface_register) from [<c0508a2c>] (cpufreq_register_driver+0x104/0x1f4)
[    3.068333]  r5:c14db254 r4:c0ae86dc
[    3.076110] [<c0508928>] (cpufreq_register_driver) from [<c050d3f8>] (imx6q_cpufreq_probe+0x4d0/0x674)
[    3.089610]  r6:c0b09310 r5:001312d0 r4:c14db3c8 r3:c14db3c8
[    3.099667] [<c050cf28>] (imx6q_cpufreq_probe) from [<c03ddb68>] (platform_drv_probe+0x50/0xac)
[    3.112613]  r10:00000000 r9:00000000 r8:00000000 r7:c0ae8694 r6:fffffdfb r5:c0a85c98
[    3.124949]  r4:ffffffed
[    3.131802] [<c03ddb18>] (platform_drv_probe) from [<c03dc12c>] (driver_probe_device+0x1d4/0x278)
[    3.144973]  r7:c0ae8694 r6:00000000 r5:c14d6c3c r4:c0a85c98
[    3.155114] [<c03dbf58>] (driver_probe_device) from [<c03dc474>] (__device_attach_driver+0x88/0x94)
[    3.168487]  r8:c14d6bf8 r7:00000001 r6:c0a85c98 r5:d74abdd0 r4:c0ae8694 r3:00000000
[    3.180792] [<c03dc3ec>] (__device_attach_driver) from [<c03da610>] (bus_for_each_drv+0x4c/0x94)
[    3.193952]  r6:c03dc3ec r5:d74abdd0 r4:00000000 r3:d006c8e0
[    3.204152] [<c03da5c4>] (bus_for_each_drv) from [<c03dbec4>] (__device_attach+0x98/0xe8)
[    3.216707]  r6:c0acb9f0 r5:c0a85ccc r4:c0a85c98
[    3.225857] [<c03dbe2c>] (__device_attach) from [<c03dc494>] (device_initial_probe+0x14/0x18)
[    3.238805]  r7:c0acba80 r6:c0acb9f0 r5:c0a85c98 r4:c0a85c98
[    3.249051] [<c03dc480>] (device_initial_probe) from [<c03db5d4>] (bus_probe_device+0x90/0x98)
[    3.262118] [<c03db544>] (bus_probe_device) from [<c03d9868>] (device_add+0x344/0x534)
[    3.274494]  r6:c0a85ca0 r5:00000000 r4:c0a85c98 r3:00000000
[    3.284764] [<c03d9524>] (device_add) from [<c03ddd1c>] (platform_device_add+0xb4/0x21c)
[    3.297315]  r10:00000000 r9:c0a688e0 r8:c0a09a20 r7:000000d5 r6:c0a85c98 r5:c0a85c88
[    3.309859]  r4:00000000
[    3.316890] [<c03ddc68>] (platform_device_add) from [<c03de3ac>] (platform_device_register+0x28/0x2c)
[    3.330627]  r7:000000d5 r6:00000002 r5:e0af0000 r4:c0a85c88
[    3.340922] [<c03de384>] (platform_device_register) from [<c0a0fdc8>] (imx6q_init_late+0x148/0x178)
[    3.354411]  r4:d7b7c010 r3:c001e8f0
[    3.362455] [<c0a0fc80>] (imx6q_init_late) from [<c0a09a44>] (init_machine_late+0x24/0x94)
[    3.375078]  r6:d00c5000 r5:c0a82c18 r4:c0a82c18 r3:c0a0fc80
[    3.385244] [<c0a09a20>] (init_machine_late) from [<c00097bc>] (do_one_initcall+0x88/0x1dc)
[    3.397906]  r4:c0a82c18 r3:00000000
[    3.405893] [<c0009734>] (do_one_initcall) from [<c0a06e8c>] (kernel_init_freeable+0x12c/0x1f4)
[    3.418960]  r10:00000000 r9:c0a688e0 r8:c0a688d8 r7:000000d5 r6:c0b0db40 r5:00000007
[    3.431397]  r4:c0a75394
[    3.438410] [<c0a06d60>] (kernel_init_freeable) from [<c0762630>] (kernel_init+0x10/0xec)
[    3.451074]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0762620
[    3.463650]  r4:00000000
[    3.470759] [<c0762620>] (kernel_init) from [<c000faf8>] (ret_from_fork+0x14/0x3c)
[    3.482860]  r4:00000000 r3:00000000
[    3.491119] ---[ end trace 1012f24ca7aedfe5 ]---

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

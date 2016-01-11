From: Juri Lelli <juri.lelli@arm.com>
Subject: [RFC PATCH 08/19] cpufreq: fix warning for cpufreq_init_policy unlocked access to cpufreq_governor_list
Date: Mon, 11 Jan 2016 17:35:49 +0000
Message-ID: <1452533760-13787-9-git-send-email-juri.lelli@arm.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, juri.lelli@arm.com
List-Id: linux-pm@vger.kernel.org

cpufreq_init_policy calls find_governor, which iterates through
cpufreq_governor_list.  cpufreq_governor_mutex has to be held before
calling that function or the following warning will be generated:

[    8.100161] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
[    8.164477] ------------[ cut here ]------------
[    8.225164] WARNING: CPU: 2 PID: 1 at kernel/drivers/cpufreq/cpufreq.c:512 find_governor+0x57/0x68()
[    8.356296] Modules linked in:
[    8.411252] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc2+ #298
[    8.477501] Hardware name: ARM-Versatile Express
[    8.538416] [<c0014215>] (unwind_backtrace) from [<c0010e25>] (show_stack+0x11/0x14)
[    8.657973] [<c0010e25>] (show_stack) from [<c02eca5d>] (dump_stack+0x55/0x78)
[    8.778347] [<c02eca5d>] (dump_stack) from [<c00202cd>] (warn_slowpath_common+0x59/0x84)
[    8.888775] usb 1-1.2: new high-speed USB device number 3 using isp1760
[    8.981012] [<c00202cd>] (warn_slowpath_common) from [<c002030f>] (warn_slowpath_null+0x17/0x1c)
[    8.993193] usb-storage 1-1.2:1.0: USB Mass Storage device detected
[    8.995167] scsi host0: usb-storage 1-1.2:1.0
[    9.260384] [<c002030f>] (warn_slowpath_null) from [<c03b7caf>] (find_governor+0x57/0x68)
[    9.395241] [<c03b7caf>] (find_governor) from [<c03b917d>] (cpufreq_init_policy+0x21/0x50)
[    9.532811] [<c03b917d>] (cpufreq_init_policy) from [<c03b9391>] (cpufreq_online+0x1e5/0x530)
[    9.676622] [<c03b9391>] (cpufreq_online) from [<c033fc9f>] (subsys_interface_register+0x53/0x78)
[    9.826894] [<c033fc9f>] (subsys_interface_register) from [<c03b986f>] (cpufreq_register_driver+0x9f/0x108)
[    9.981174] [<c03b986f>] (cpufreq_register_driver) from [<c03bb9b1>] (bL_cpufreq_register+0x49/0x98)
[   10.002780] scsi 0:0:0:0: Direct-Access     General  USB Flash Disk   1.0  PQ: 0 ANSI: 2
[   10.024039] sd 0:0:0:0: [sda] 7831552 512-byte logical blocks: (4.00 GB/3.73 GiB)
[   10.030505] sd 0:0:0:0: [sda] Write Protect is off
[   10.030544] sd 0:0:0:0: [sda] Mode Sense: 03 00 00 00
[   10.039631] sd 0:0:0:0: [sda] No Caching mode page found
[   10.039672] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   10.093331]  sda: sda1 sda2
[   10.138827] sd 0:0:0:0: [sda] Attached SCSI removable disk
[   10.883930] [<c03bb9b1>] (bL_cpufreq_register) from [<c034203f>] (platform_drv_probe+0x3b/0x6c)
[   11.024538] [<c034203f>] (platform_drv_probe) from [<c0340e2f>] (driver_probe_device+0x16f/0x1c0)
[   11.167217] [<c0340e2f>] (driver_probe_device) from [<c0340ed7>] (__driver_attach+0x57/0x58)
[   11.308084] [<c0340ed7>] (__driver_attach) from [<c033fd41>] (bus_for_each_dev+0x2d/0x4c)
[   11.448056] [<c033fd41>] (bus_for_each_dev) from [<c034077f>] (bus_add_driver+0xa3/0x14c)
[   11.587859] [<c034077f>] (bus_add_driver) from [<c0341727>] (driver_register+0x3b/0x88)
[   11.726813] [<c0341727>] (driver_register) from [<c0009613>] (do_one_initcall+0x5b/0x150)
[   11.866247] [<c0009613>] (do_one_initcall) from [<c0732b45>] (kernel_init_freeable+0x18d/0x22c)
[   12.008765] [<c0732b45>] (kernel_init_freeable) from [<c04f24ed>] (kernel_init+0xd/0xa4)
[   12.150461] [<c04f24ed>] (kernel_init) from [<c000dfb9>] (ret_from_fork+0x11/0x38)
[   12.294473] ---[ end trace 545905b1fdc9cd96 ]---
[   12.371823] atkbd serio0: keyboard reset failed on 1c060000.kmi
[   12.372910] cpu cpu1: bL_cpufreq_init: CPU 1 initialized
[   12.373741] ------------[ cut here ]------------

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7dae7f3..d065435 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -969,6 +969,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 
 	memcpy(&new_policy, policy, sizeof(*policy));
 
+	mutex_lock(&cpufreq_governor_mutex);
 	/* Update governor of new_policy to the governor used before hotplug */
 	gov = find_governor(policy->last_governor);
 	if (gov)
@@ -976,6 +977,7 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
 				policy->governor->name, policy->cpu);
 	else
 		gov = CPUFREQ_DEFAULT_GOVERNOR;
+	mutex_unlock(&cpufreq_governor_mutex);
 
 	new_policy.governor = gov;
 
-- 
2.2.2

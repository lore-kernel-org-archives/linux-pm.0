From: Ming Lei <tom.leiming@gmail.com>
Subject: 2.6.30-rc2 BUG: using smp_processor_id() in preemptible
Date: Sun, 19 Apr 2009 13:32:23 +0800
Message-ID: <20090419133223.293e5a10@linux-lm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


[ 5532.990752] Enabling non-boot CPUs ...
[ 5532.992515] lockdep: fixing up alternatives.
[ 5532.992518] SMP alternatives: switching to SMP code
[ 5532.996878] Booting processor 1 APIC 0x1 ip 0x6000
[ 5532.987607] Initializing CPU#1
[ 5532.987607] Calibrating delay using timer specific routine.. 3988.87 BogoMIPS (lpj=1994436)
[ 5532.987607] CPU: L1 I cache: 32K, L1 D cache: 32K
[ 5532.987607] CPU: L2 cache: 2048K
[ 5532.987607] [ds] using Core 2/Atom configuration
[ 5532.987607] CPU 1/0x1 -> Node 0
[ 5532.987607] CPU: Physical Processor ID: 0
[ 5532.987607] CPU: Processor Core ID: 1
[ 5532.987607] CPU1: Thermal monitoring enabled (TM2)
[ 5533.067483] CPU1: Intel(R) Core(TM)2 Duo CPU     T7250  @ 2.00GHz stepping 0d
[ 5533.067529] CPU0 attaching NULL sched-domain.
[ 5533.068265] Switched to high resolution mode on CPU 1
[ 5533.071043] CPU0 attaching sched-domain:
[ 5533.071046]  domain 0: span 0-1 level MC
[ 5533.071049]   groups: 0 (__cpu_power = 1024) 1 (__cpu_power = 1024)
[ 5533.071057] CPU1 attaching sched-domain:
[ 5533.071059]  domain 0: span 0-1 level MC
[ 5533.071062]   groups: 1 (__cpu_power = 1024) 0 (__cpu_power = 1024)
[ 5533.071769] Registering sys device of class 'machinecheck'
[ 5533.071776] Registering sys device 'machinecheck1'
[ 5533.072254] BUG: using smp_processor_id() in preemptible [00000000] code: pm-suspend/20128
[ 5533.072260] caller is smp_call_function_many+0x24/0x1c0
[ 5533.072264] Pid: 20128, comm: pm-suspend Tainted: G        W  2.6.30-rc2 #94
[ 5533.072266] Call Trace:
[ 5533.072272]  [<ffffffff80360346>] debug_smp_processor_id+0xd2/0xe8
[ 5533.072276]  [<ffffffff8026dc8c>] smp_call_function_many+0x24/0x1c0
[ 5533.072283]  [<ffffffffa02ca1b1>] ? do_drv_write+0x0/0x6c [acpi_cpufreq]
[ 5533.072288]  [<ffffffffa02ca754>] acpi_cpufreq_target+0x251/0x332 [acpi_cpufreq]
[ 5533.072293]  [<ffffffff8048c491>] ? _spin_unlock_irqrestore+0x46/0x76
[ 5533.072299]  [<ffffffff803eedb6>] __cpufreq_driver_target+0x67/0x77
[ 5533.072303]  [<ffffffff803f0b26>] cpufreq_governor_performance+0x46/0x4c
[ 5533.072308]  [<ffffffff803ee91c>] __cpufreq_governor+0xda/0x117
[ 5533.072312]  [<ffffffff803eeb25>] __cpufreq_set_policy+0x195/0x211
[ 5533.072316]  [<ffffffff803f012f>] cpufreq_add_dev+0x5b2/0x6f3
[ 5533.072320]  [<ffffffff803ef0ea>] ? cpufreq_cpu_get+0xf8/0x104
[ 5533.072324]  [<ffffffff803f0426>] ? handle_update+0x0/0x33
[ 5533.072330]  [<ffffffff8048885c>] cpufreq_cpu_callback+0x6c/0x7a
[ 5533.072334]  [<ffffffff8025a197>] notifier_call_chain+0x33/0x5b
[ 5533.072339]  [<ffffffff8025a22f>] raw_notifier_call_chain+0xf/0x11
[ 5533.072343]  [<ffffffff80486a21>] _cpu_up+0xe0/0x12f
[ 5533.072347]  [<ffffffff80478781>] enable_nonboot_cpus+0x48/0xb1
[ 5533.072352]  [<ffffffff80272b11>] suspend_devices_and_enter+0xff/0x153
[ 5533.072356]  [<ffffffff80272d36>] enter_state+0x177/0x24c
[ 5533.072359]  [<ffffffff80272ec2>] state_store+0xb7/0xd7
[ 5533.072364]  [<ffffffff80355e27>] kobj_attr_store+0x17/0x19
[ 5533.072368]  [<ffffffff8031a516>] sysfs_write_file+0xe4/0x119
[ 5533.072373]  [<ffffffff802c93f0>] vfs_write+0xae/0x137
[ 5533.072377]  [<ffffffff802c953d>] sys_write+0x47/0x6e
[ 5533.072382]  [<ffffffff8020b142>] system_call_fastpath+0x16/0x1b
[ 5533.073285] CPU1 is up
[ 5533.073288] ACPI: Waking up from system sleep state S3

-- 
Lei Ming

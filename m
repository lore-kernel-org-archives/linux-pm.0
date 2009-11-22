From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ACPI/ACPICA: resume hang (battery related)
Date: Sun, 22 Nov 2009 14:20:48 +0200
Message-ID: <1258892448.3231.23.camel__45664.9829204709$1258892535$gmane$org@maxim-laptop>
References: <1258664394.3611.8.camel@maxim-laptop>
	<200911192255.45447.rjw@sisk.pl>
	<1258670277.27524.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1258670277.27524.4.camel@maxim-laptop>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I blacklisted battery driver, and now I got same backtrace in the AC
driver.


<7>[ 1617.430020] CPU0: Thermal monitoring handled by SMI
<4>[ 1617.430020] Enabling non-boot CPUs ...
<4>[ 1617.450349] lockdep: fixing up alternatives.
<6>[ 1617.450569] SMP alternatives: switching to SMP code
<6>[ 1617.458575] Booting processor 1 APIC 0x1 ip 0x6000
<6>[ 1617.422535] Initializing CPU#1
<6>[ 1617.422535] Calibrating delay using timer specific routine.. 3421.80 BogoMIPS (lpj=17109034)
<6>[ 1617.422535] CPU: L1 I cache: 32K, L1 D cache: 32K
<6>[ 1617.422535] CPU: L2 cache: 2048K
<6>[ 1617.422535] CPU: Physical Processor ID: 0
<6>[ 1617.422535] CPU: Processor Core ID: 1
<6>[ 1617.422535] CPU1: Thermal monitoring enabled (TM1)
<6>[ 1617.610123] CPU1: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz stepping 0d
<4>[ 1617.630722] CPU1 is up
<3>[ 1800.680133] INFO: task tee:4850 blocked for more than 120 seconds.
<3>[ 1800.680451] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>[ 1800.680840] tee           D 0000000000000000     0  4850   4231 0x00000000
<3>[ 1800.681485] BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/369
<4>[ 1800.681881] caller is show_stack_log_lvl+0x32/0x170
<4>[ 1800.682145] Pid: 369, comm: khungtaskd Not tainted 2.6.32-rc8-wl #194
<4>[ 1800.682463] Call Trace:
<4>[ 1800.682648]  [<ffffffff811e44ab>] debug_smp_processor_id+0xcb/0xe0
<4>[ 1800.682961]  [<ffffffff8100f282>] show_stack_log_lvl+0x32/0x170
<4>[ 1800.683272]  [<ffffffff81394803>] ? printk+0x3c/0x41
<4>[ 1800.683538]  [<ffffffff81010977>] show_stack+0x17/0x20
<4>[ 1800.683808]  [<ffffffff8103c952>] sched_show_task+0x92/0x100
<4>[ 1800.684089]  [<ffffffff81086a2d>] watchdog+0x27d/0x2e0
<4>[ 1800.684351]  [<ffffffff8108681d>] ? watchdog+0x6d/0x2e0
<4>[ 1800.684626]  [<ffffffff813982ee>] ? _spin_unlock_irqrestore+0x6e/0x80
<4>[ 1800.684934]  [<ffffffff810867b0>] ? watchdog+0x0/0x2e0
<4>[ 1800.685202]  [<ffffffff8105bbce>] kthread+0x8e/0xa0
<4>[ 1800.685456]  [<ffffffff8100cf1a>] child_rip+0xa/0x20
<4>[ 1800.685727]  [<ffffffff8100c880>] ? restore_args+0x0/0x30
<4>[ 1800.685999]  [<ffffffff8105bb40>] ? kthread+0x0/0xa0
<4>[ 1800.686255]  [<ffffffff8100cf10>] ? child_rip+0x0/0x20
<4>[ 1800.686515]  ffff88007e0cf828 0000000000000046 0000000000000000 0000000000000000
<4>[ 1800.687149]  0000000000000000 0000000000000000 ffff880002213c58 0000000000000002
<4>[ 1800.687784]  ffff88000220efc8 00000001000202b4 ffff88007f932218 ffff88007e0cffd8
<4>[ 1800.688421] Call Trace:
<4>[ 1800.688594]  [<ffffffff81395ba5>] schedule_timeout+0x205/0x270
<4>[ 1800.688888]  [<ffffffff8106d03b>] ? mark_held_locks+0x6b/0xa0
<4>[ 1800.689172]  [<ffffffff8139824b>] ? _spin_unlock_irq+0x2b/0x60
<4>[ 1800.689462]  [<ffffffff8106d335>] ? trace_hardirqs_on_caller+0x145/0x190
<4>[ 1800.689781]  [<ffffffff8139726d>] __down_timeout+0x6d/0xb0
<4>[ 1800.690095]  [<ffffffff810609bf>] ? down_timeout+0x1f/0x60
<4>[ 1800.690387]  [<ffffffff810609f8>] down_timeout+0x58/0x60
<4>[ 1800.690659]  [<ffffffff81213bcc>] acpi_os_wait_semaphore+0x49/0x57
<4>[ 1800.690964]  [<ffffffff81226786>] acpi_ex_system_wait_semaphore+0x3c/0x4f
<4>[ 1800.691285]  [<ffffffff81221339>] acpi_ev_acquire_global_lock+0xbf/0xc3
<4>[ 1800.691600]  [<ffffffff81228354>] acpi_ex_acquire_mutex_object+0x39/0x63
<4>[ 1800.691917]  [<ffffffff81227fd0>] acpi_ex_acquire_global_lock+0x24/0x46
<4>[ 1800.692233]  [<ffffffff81223a72>] acpi_ex_read_data_from_field+0x121/0x16f
<4>[ 1800.692566]  [<ffffffff8106d38d>] ? trace_hardirqs_on+0xd/0x10
<4>[ 1800.692865]  [<ffffffff81228868>] acpi_ex_resolve_node_to_value+0x18c/0x218
<4>[ 1800.693207]  [<ffffffff812244b7>] acpi_ex_resolve_to_value+0x203/0x20c
<4>[ 1800.693521]  [<ffffffff8121eab9>] acpi_ds_evaluate_name_path+0x79/0xf5
<4>[ 1800.693838]  [<ffffffff8121d738>] acpi_ds_exec_end_op+0x96/0x3d6
<4>[ 1800.694132]  [<ffffffff8122f0ef>] acpi_ps_parse_loop+0x7bb/0x940
<4>[ 1800.694427]  [<ffffffff8122e1f9>] acpi_ps_parse_aml+0x9a/0x2d9
<4>[ 1800.694716]  [<ffffffff8122f90a>] acpi_ps_execute_method+0x1e4/0x2b6
<4>[ 1800.695024]  [<ffffffff8122b25d>] acpi_ns_evaluate+0xe1/0x1a8
<4>[ 1800.695309]  [<ffffffff8122acb5>] acpi_evaluate_object+0x13d/0x236
<4>[ 1800.695612]  [<ffffffff8106d03b>] ? mark_held_locks+0x6b/0xa0
<4>[ 1800.695897]  [<ffffffff8121449f>] acpi_evaluate_integer+0x2f/0x4d
<4>[ 1800.696198]  [<ffffffff8106d335>] ? trace_hardirqs_on_caller+0x145/0x190
<4>[ 1800.696516]  [<ffffffff81235815>] acpi_ac_get_state+0x36/0x6a
<4>[ 1800.696806]  [<ffffffff812358e3>] acpi_ac_resume+0x27/0x59
<4>[ 1800.697082]  [<ffffffff81215dd4>] acpi_device_resume+0x25/0x2b
<4>[ 1800.697373]  [<ffffffff8126945a>] dpm_resume_end+0x4aa/0x500
<4>[ 1800.697658]  [<ffffffff8107d9b9>] hibernation_snapshot+0xc9/0x280
<4>[ 1800.697953]  [<ffffffff8107dc5d>] hibernate+0xed/0x1f0
<4>[ 1800.698218]  [<ffffffff8107c46c>] state_store+0xec/0x100
<4>[ 1800.698488]  [<ffffffff811d7ae7>] kobj_attr_store+0x17/0x20
<4>[ 1800.698780]  [<ffffffff81137924>] sysfs_write_file+0xd4/0x150
<4>[ 1800.699066]  [<ffffffff810d3d38>] vfs_write+0xb8/0x1a0
<4>[ 1800.699342]  [<ffffffff810d3efc>] sys_write+0x4c/0x80
<4>[ 1800.699602]  [<ffffffff8100beab>] system_call_fastpath+0x16/0x1b
<4>[ 1800.699914] 2 locks held by tee/4850:
<4>[ 1800.700179]  #0:  (&buffer->mutex){+.+.+.}, at: [<ffffffff8113788f>] sysfs_write_file+0x3f/0x150
<4>[ 1800.700838]  #1:  (pm_mutex){+.+.+.}, at: [<ffffffff8107db87>] hibernate+0x17/0x1f0
<0>[ 1800.701438] Kernel panic - not syncing: hung_task: blocked tasks
<4>[ 1800.701716] Pid: 369, comm: khungtaskd Not tainted 2.6.32-rc8-wl #194
<4>[ 1800.702009] Call Trace:
<4>[ 1800.702169]  [<ffffffff8139470a>] panic+0x7d/0x13a
<4>[ 1800.702408]  [<ffffffff81086a59>] watchdog+0x2a9/0x2e0
<4>[ 1800.702664]  [<ffffffff8108681d>] ? watchdog+0x6d/0x2e0
<4>[ 1800.702945]  [<ffffffff813982ee>] ? _spin_unlock_irqrestore+0x6e/0x80
<4>[ 1800.703238]  [<ffffffff810867b0>] ? watchdog+0x0/0x2e0
<4>[ 1800.703489]  [<ffffffff8105bbce>] kthread+0x8e/0xa0
<4>[ 1800.703731]  [<ffffffff8100cf1a>] child_rip+0xa/0x20
<4>[ 1800.703975]  [<ffffffff8100c880>] ? restore_args+0x0/0x30
<4>[ 1800.704234]  [<ffffffff8105bb40>] ? kthread+0x0/0xa0
<4>[ 1800.704482]  [<ffffffff8100cf10>] ? child_rip+0x0/0x20
<0>[ 1800.704796] Rebooting in 60 seconds..

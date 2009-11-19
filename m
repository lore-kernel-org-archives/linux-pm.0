From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ACPI/ACPICA: resume hang (battery related)
Date: Fri, 20 Nov 2009 00:37:57 +0200
Message-ID: <1258670277.27524.4.camel__22083.7161913098$1258670354$gmane$org@maxim-laptop>
References: <1258664394.3611.8.camel@maxim-laptop>
	<200911192255.45447.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911192255.45447.rjw@sisk.pl>
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

On Thu, 2009-11-19 at 22:55 +0100, Rafael J. Wysocki wrote: 
> On Thursday 19 November 2009, Maxim Levitsky wrote:
> > Hi,
> > 
> > I have set up a script that cycles my system through hibernation,
> > because I am tired of 90% of time working suspend to disk.
> > I also set up the kernel to log directly into video memory which happens
> > to be preserved during reboots.
> > 
> > One bug is already fixed (I posted about it on linux-wireless)
> > 
> > Here is another bug:
> > 
> > <3>[  360.670152] INFO: task tee:3466 blocked for more than 120 seconds.
> > <3>[  360.670469] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > <6>[  360.670859] tee           D 0000000000000000     0  3466   3320 0x00000000
> > <3>[  360.671386] BUG: using smp_processor_id() in preemptible [00000000] code: khungtaskd/354
> > <4>[  360.671783] caller is show_stack_log_lvl+0x32/0x170
> > <4>[  360.672053] Pid: 354, comm: khungtaskd Not tainted 2.6.32-rc7-wl #192
> > <4>[  360.672373] Call Trace:
> > <4>[  360.672554]  [<ffffffff811e212b>] debug_smp_processor_id+0xcb/0xe0
> > <4>[  360.672869]  [<ffffffff8100f282>] show_stack_log_lvl+0x32/0x170
> > <4>[  360.673172]  [<ffffffff8139212d>] ? printk+0x3c/0x3f
> > <4>[  360.673440]  [<ffffffff81010977>] show_stack+0x17/0x20
> > <4>[  360.673705]  [<ffffffff8103c8b2>] sched_show_task+0x92/0x100
> > <4>[  360.673991]  [<ffffffff8108696d>] watchdog+0x27d/0x2e0
> > <4>[  360.674253]  [<ffffffff8108675d>] ? watchdog+0x6d/0x2e0
> > <4>[  360.674527]  [<ffffffff810866f0>] ? watchdog+0x0/0x2e0
> > <4>[  360.674792]  [<ffffffff8105bb0e>] kthread+0x8e/0xa0
> > <4>[  360.675047]  [<ffffffff8100cf1a>] child_rip+0xa/0x20
> > <4>[  360.675309]  [<ffffffff8100c880>] ? restore_args+0x0/0x30
> > <4>[  360.675582]  [<ffffffff8105ba80>] ? kthread+0x0/0xa0
> > <4>[  360.675840]  [<ffffffff8100cf10>] ? child_rip+0x0/0x20
> > <4>[  360.676100]  ffff88007de137b8 0000000000000046 0000000000000000 0000000000000002
> > <4>[  360.676725]  ffff88007de137f8 0000000000000000 ffff880002213c18 0000000000000002
> > <4>[  360.677353]  ffff88000220efc8 00000000ffffcae7 ffff88007e6402b8 ffff88007de13fd8
> > <4>[  360.677987] Call Trace:
> > <4>[  360.678159]  [<ffffffff813934c5>] schedule_timeout+0x205/0x270
> > <4>[  360.678458]  [<ffffffff8106cf7b>] ? mark_held_locks+0x6b/0xa0
> > <4>[  360.678742]  [<ffffffff81395b6b>] ? _spin_unlock_irq+0x2b/0x60
> > <4>[  360.679030]  [<ffffffff8106d275>] ? trace_hardirqs_on_caller+0x145/0x190
> > <4>[  360.679348]  [<ffffffff81394b8d>] __down_timeout+0x6d/0xb0
> > <4>[  360.679632]  [<ffffffff810608ff>] ? down_timeout+0x1f/0x60
> > <4>[  360.679908]  [<ffffffff81060938>] down_timeout+0x58/0x60
> > <4>[  360.680229]  [<ffffffff81211dfc>] acpi_os_wait_semaphore+0x49/0x57
> > <4>[  360.680545]  [<ffffffff81225b5e>] acpi_ex_system_wait_semaphore+0x3c/0x4f
> > <4>[  360.680875]  [<ffffffff8122070d>] acpi_ev_acquire_global_lock+0xbf/0xc3
> > <4>[  360.681190]  [<ffffffff8122772c>] acpi_ex_acquire_mutex_object+0x39/0x63
> > <4>[  360.681513]  [<ffffffff812273a8>] acpi_ex_acquire_global_lock+0x24/0x46
> > <4>[  360.681828]  [<ffffffff81222e46>] acpi_ex_read_data_from_field+0x121/0x16f
> > <4>[  360.682154]  [<ffffffff8106d2cd>] ? trace_hardirqs_on+0xd/0x10
> > <4>[  360.682444]  [<ffffffff81227c40>] acpi_ex_resolve_node_to_value+0x18c/0x218
> > <4>[  360.682780]  [<ffffffff8122388f>] acpi_ex_resolve_to_value+0x203/0x20c
> > <4>[  360.683104]  [<ffffffff8121de8d>] acpi_ds_evaluate_name_path+0x79/0xf5
> > <4>[  360.683438]  [<ffffffff8121cb0c>] acpi_ds_exec_end_op+0x96/0x3d6
> > <4>[  360.683732]  [<ffffffff8122e4c7>] acpi_ps_parse_loop+0x7bb/0x940
> > <4>[  360.684026]  [<ffffffff8122d5d1>] acpi_ps_parse_aml+0x9a/0x2d9
> > <4>[  360.684314]  [<ffffffff8122ece2>] acpi_ps_execute_method+0x1e4/0x2b6
> > <4>[  360.684625]  [<ffffffff8122a635>] acpi_ns_evaluate+0xe1/0x1a8
> > <4>[  360.684909]  [<ffffffff8122a08d>] acpi_evaluate_object+0x13d/0x236
> > <4>[  360.685211]  [<ffffffff812126cf>] acpi_evaluate_integer+0x2f/0x4d
> > <4>[  360.685509]  [<ffffffff8106cf7b>] ? mark_held_locks+0x6b/0xa0
> > <4>[  360.685794]  [<ffffffff81213785>] acpi_bus_get_status_handle+0x1d/0x33
> > <4>[  360.686106]  [<ffffffff812137b4>] acpi_bus_get_status+0x19/0x34
> > <4>[  360.686400]  [<ffffffff8123aa32>] acpi_battery_update+0x1e/0x24d
> > <4>[  360.686693]  [<ffffffff8106d2cd>] ? trace_hardirqs_on+0xd/0x10
> > <4>[  360.686980]  [<ffffffff81395bdd>] ? _spin_unlock_irqrestore+0x3d/0x80
> > <4>[  360.687289]  [<ffffffff8123acf8>] acpi_battery_resume+0x25/0x29
> > <4>[  360.687578]  [<ffffffff81214004>] acpi_device_resume+0x25/0x2b
> > <4>[  360.687867]  [<ffffffff8126944a>] dpm_resume_end+0x4aa/0x500
> > <4>[  360.688152]  [<ffffffff8107d8f9>] hibernation_snapshot+0xc9/0x280
> > <4>[  360.688449]  [<ffffffff8107db9d>] hibernate+0xed/0x1f0
> > <4>[  360.688712]  [<ffffffff8107c3ac>] state_store+0xec/0x100
> > <4>[  360.688985]  [<ffffffff811d5777>] kobj_attr_store+0x17/0x20
> > <4>[  360.689266]  [<ffffffff811355f4>] sysfs_write_file+0xd4/0x150
> > <4>[  360.689555]  [<ffffffff810d1a08>] vfs_write+0xb8/0x1a0
> > <4>[  360.689819]  [<ffffffff810d1bcc>] sys_write+0x4c/0x80
> > <4>[  360.690117]  [<ffffffff8100beab>] system_call_fastpath+0x16/0x1b
> > <4>[  360.690431] 2 locks held by tee/3466:
> > 
> > 
> > I attach the dmesg (copied from video ram) too.
> > and acpidump output.
> 
> Is this a regression and if so, which is the last known working kernel?
It might be, as I remember that few kernel versions ago, s2disk used to
work reliably.
However I say 'few' because I didn't do such thoughtful test. 
This problem shows very rarely, and thus bisect is unfeasible.

BTW, sorry about duplicate mail, this was technical problem with
internet connection.


> 
> Rafael
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

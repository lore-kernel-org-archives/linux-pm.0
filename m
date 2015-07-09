From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [BUG] Kernel splat when taking CPUs offline
Date: Wed, 8 Jul 2015 23:34:48 -0400
Message-ID: <20150708233448.11015ba7@gandalf.local.home>
References: <20150708152456.4438d60f@gandalf.local.home>
	<1625417.XZkzNdoaJA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:36693 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752633AbbGIDew (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 23:34:52 -0400
In-Reply-To: <1625417.XZkzNdoaJA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Saravana Kannan <skannan@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, 09 Jul 2015 02:13:45 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:


> > Initializing CPU#1
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1609 at /home/rostedt/work/git/linux-trace.git/drivers/cpufreq/cpufreq.c:2350 cpufreq_update_policy+0xc8/0x139()
> 
> So the cpufreq driver's ->get() callback returns 0 for the given CPU and
> that's what triggers the WARN_ON().  And it most likely returns 0, because
> its internal data structure for that CPU is not present.
> 
> I *guess* that before the above commit policy was NULL in cpufreq_update_policy()
> and we didn't get to the point where ->get() was called.

Just some more info. That ->get() is get_cur_freq_on_cpu() (I added a
printk to find out what that was).

Also, adding more printks() (patch of printk's added below) I got this:

 # trace-cmd start -p mmiotrace  # offlines all but one CPU
 # trace-cmd start -p nop        # onlines the CPUs
 # trace-cmd start -p mmiotrace  # again offlines all but one CPU
 # trace-cmd start -p nop        # again onlines the CPUs

produces:


in mmio_trace_init
mmiotrace: Disabling non-boot CPUs...
smpboot: CPU 1 is now offline
exit free f252c180 (1)
mmiotrace: CPU1 is down.
Broke affinity for irq 28
smpboot: CPU 2 is now offline
exit free f252c260 (2)
mmiotrace: CPU2 is down.
Broke affinity for irq 4
Broke affinity for irq 25
Broke affinity for irq 26
Broke affinity for irq 27
Broke affinity for irq 28
smpboot: CPU 3 is now offline
exit free f252c280 (3)
mmiotrace: CPU3 is down.
mmiotrace: enabled.
in mmio_trace_start
in mmio_trace_reset
mmiotrace: Re-enabling CPUs...
x86: Booting SMP configuration:
smpboot: Booting Node 0 Processor 1 APIC 0x2
Initializing CPU#1
INIT data = f05a6b40 (1)
data=f05a6b40
data-acpi_data=f3539634
data-freq_table_data=f2073b00
exit free f05a6b40 (1)
mmiotrace: enabled CPU1.
smpboot: Booting Node 0 Processor 2 APIC 0x1
Initializing CPU#2
INIT data = efe567a0 (2)
data=efe567a0
data-acpi_data=f368b634
data-freq_table_data=ef849100
exit free efe567a0 (2)
mmiotrace: enabled CPU2.
smpboot: Booting Node 0 Processor 3 APIC 0x3
Initializing CPU#3
INIT data = efe56760 (3)
data=efe56760
data-acpi_data=f37dd634
data-freq_table_data=ef840600
exit free efe56760 (3)
mmiotrace: enabled CPU3.
mmiotrace: disabled.
in mmio_trace_init
mmiotrace: Disabling non-boot CPUs...
cpufreq: __cpufreq_remove_dev_prepare: Failed to stop governor
smpboot: CPU 1 is now offline
mmiotrace: CPU1 is down.
cpufreq: __cpufreq_remove_dev_prepare: Failed to stop governor
Broke affinity for irq 28
smpboot: CPU 2 is now offline
mmiotrace: CPU2 is down.
cpufreq: __cpufreq_remove_dev_prepare: Failed to stop governor
Broke affinity for irq 28
smpboot: CPU 3 is now offline
mmiotrace: CPU3 is down.
mmiotrace: enabled.
in mmio_trace_start
in mmio_trace_reset
mmiotrace: Re-enabling CPUs...
x86: Booting SMP configuration:
smpboot: Booting Node 0 Processor 1 APIC 0x2
Initializing CPU#1
get=get_cur_freq_on_cpu+0x0/0xe9
data=  (null)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1994 at /home/rostedt/work/git/linux-trace.git/drivers/cpufreq/cpufreq.c:2351 cpufreq_update_policy+0xe8/0x159()
Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 microcode r8169 ppdev parport_pc parport
CPU: 0 PID: 1994 Comm: trace-cmd Not tainted 4.2.0-rc1-test+ #30
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
 00000000 00000000 efa11b54 c0cd0386 c10d4414 efa11b84 c0440fbe c101046c
 00000000 000007ca c10d4414 0000092f c0a6db4a c0a6db4a f146cc00 00000000
 efa11d60 efa11b94 c0440ff7 00000009 00000000 efa11d6c c0a6db4a c10d4e15
Call Trace:
 [<c0cd0386>] dump_stack+0x41/0x52
 [<c0440fbe>] warn_slowpath_common+0x9d/0xb4
 [<c0a6db4a>] ? cpufreq_update_policy+0xe8/0x159
 [<c0a6db4a>] ? cpufreq_update_policy+0xe8/0x159
 [<c0440ff7>] warn_slowpath_null+0x22/0x24
 [<c0a6db4a>] cpufreq_update_policy+0xe8/0x159
 [<c0a704ef>] ? extract_freq+0xa1/0xa1
 [<c0a6dbbb>] ? cpufreq_update_policy+0x159/0x159
 [<c0a6da9d>] ? cpufreq_update_policy+0x3b/0x159
 [<c0a6bd5f>] ? cpufreq_freq_transition_begin+0x97/0xd9
 [<c046ea90>] ? __wake_up+0x1a/0x47
 [<c07726a2>] acpi_processor_ppc_has_changed+0x54/0x5d
 [<c076f6d9>] acpi_cpu_soft_notify+0xb0/0xf1
 [<c06d2879>] ? compute_batch_value+0xd/0x22
 [<c06d2a58>] ? percpu_counter_hotcpu_callback+0x11/0x80
 [<c0458c35>] notifier_call_chain+0x68/0x91
 [<c0458c7c>] __raw_notifier_call_chain+0x1e/0x23
 [<c04410c2>] __cpu_notify+0x24/0x39
 [<c04414d9>] _cpu_up+0xef/0x105
 [<c044153d>] cpu_up+0x4e/0x5f
 [<c06bcbdb>] ? find_next_bit+0x1a/0x20
 [<c043dfa6>] disable_mmiotrace+0xd4/0x13e
 [<c04d854b>] mmio_trace_reset+0x36/0x5e
 [<c04d3c83>] tracing_set_tracer+0xb1/0x155
 [<c06b7f22>] ? _copy_from_user+0x42/0x57
 [<c04d3d91>] tracing_set_trace_write+0x6a/0x80
 [<c0516935>] ? handle_mm_fault+0x75b/0xc42
 [<c0532d45>] ? file_start_write+0x27/0x29
 [<c04d3d27>] ? tracing_set_tracer+0x155/0x155
 [<c0532e5a>] __vfs_write+0x24/0x9b
 [<c0532d45>] ? file_start_write+0x27/0x29
 [<c0533375>] ? rw_verify_area+0xce/0xef
 [<c04370f2>] ? __do_page_fault+0x2be/0x3be
 [<c0533863>] vfs_write+0x7a/0xc4
 [<c0533a29>] SyS_write+0x54/0x7f
 [<c0cdad58>] sysenter_do_call+0x12/0x12
---[ end trace 47cc28ca9538eb2d ]---
mmiotrace: enabled CPU1.
smpboot: Booting Node 0 Processor 2 APIC 0x1
Initializing CPU#2
get=get_cur_freq_on_cpu+0x0/0xe9
data=  (null)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1994 at /home/rostedt/work/git/linux-trace.git/drivers/cpufreq/cpufreq.c:2351 cpufreq_update_policy+0xe8/0x159()
Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 microcode r8169 ppdev parport_pc parport
CPU: 1 PID: 1994 Comm: trace-cmd Tainted: G        W       4.2.0-rc1-test+ #30
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
 00000000 00000000 efa11b54 c0cd0386 c10d4414 efa11b84 c0440fbe c101046c
 00000001 000007ca c10d4414 0000092f c0a6db4a c0a6db4a f146ce00 00000000
 efa11d60 efa11b94 c0440ff7 00000009 00000000 efa11d6c c0a6db4a c10d4e15
Call Trace:
 [<c0cd0386>] dump_stack+0x41/0x52
 [<c0440fbe>] warn_slowpath_common+0x9d/0xb4
 [<c0a6db4a>] ? cpufreq_update_policy+0xe8/0x159
 [<c0a6db4a>] ? cpufreq_update_policy+0xe8/0x159
 [<c0440ff7>] warn_slowpath_null+0x22/0x24
 [<c0a6db4a>] cpufreq_update_policy+0xe8/0x159
 [<c0a704ef>] ? extract_freq+0xa1/0xa1
 [<c0a6dbbb>] ? cpufreq_update_policy+0x159/0x159
 [<c0a6da9d>] ? cpufreq_update_policy+0x3b/0x159
 [<c0a6bd5f>] ? cpufreq_freq_transition_begin+0x97/0xd9
 [<c046ea90>] ? __wake_up+0x1a/0x47
 [<c07726a2>] acpi_processor_ppc_has_changed+0x54/0x5d
 [<c076f6d9>] acpi_cpu_soft_notify+0xb0/0xf1
 [<c06d2879>] ? compute_batch_value+0xd/0x22
 [<c06d2a58>] ? percpu_counter_hotcpu_callback+0x11/0x80
 [<c0458c35>] notifier_call_chain+0x68/0x91
 [<c0458c7c>] __raw_notifier_call_chain+0x1e/0x23
 [<c04410c2>] __cpu_notify+0x24/0x39
 [<c04414d9>] _cpu_up+0xef/0x105
 [<c044153d>] cpu_up+0x4e/0x5f
 [<c06bcbdb>] ? find_next_bit+0x1a/0x20
 [<c043dfa6>] disable_mmiotrace+0xd4/0x13e
 [<c04d854b>] mmio_trace_reset+0x36/0x5e
 [<c04d3c83>] tracing_set_tracer+0xb1/0x155
 [<c06b7f22>] ? _copy_from_user+0x42/0x57
 [<c04d3d91>] tracing_set_trace_write+0x6a/0x80
 [<c0516935>] ? handle_mm_fault+0x75b/0xc42
 [<c0532d45>] ? file_start_write+0x27/0x29
 [<c04d3d27>] ? tracing_set_tracer+0x155/0x155
 [<c0532e5a>] __vfs_write+0x24/0x9b
 [<c0532d45>] ? file_start_write+0x27/0x29
 [<c0533375>] ? rw_verify_area+0xce/0xef
 [<c04370f2>] ? __do_page_fault+0x2be/0x3be
 [<c0533863>] vfs_write+0x7a/0xc4
 [<c0533a29>] SyS_write+0x54/0x7f
 [<c0cdad58>] sysenter_do_call+0x12/0x12
---[ end trace 47cc28ca9538eb2e ]---
mmiotrace: enabled CPU2.
smpboot: Booting Node 0 Processor 3 APIC 0x3
Initializing CPU#3
get=get_cur_freq_on_cpu+0x0/0xe9
data=  (null)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1994 at /home/rostedt/work/git/linux-trace.git/drivers/cpufreq/cpufreq.c:2351 cpufreq_update_policy+0xe8/0x159()
Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 microcode r8169 ppdev parport_pc parport
CPU: 0 PID: 1994 Comm: trace-cmd Tainted: G        W       4.2.0-rc1-test+ #30
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
 00000000 00000000 efa11b54 c0cd0386 c10d4414 efa11b84 c0440fbe c101046c
 00000000 000007ca c10d4414 0000092f c0a6db4a c0a6db4a f146d000 00000000
 efa11d60 efa11b94 c0440ff7 00000009 00000000 efa11d6c c0a6db4a c10d4e15
Call Trace:
 [<c0cd0386>] dump_stack+0x41/0x52
 [<c0440fbe>] warn_slowpath_common+0x9d/0xb4
 [<c0a6db4a>] ? cpufreq_update_policy+0xe8/0x159
 [<c0a6db4a>] ? cpufreq_update_policy+0xe8/0x159
 [<c0440ff7>] warn_slowpath_null+0x22/0x24
 [<c0a6db4a>] cpufreq_update_policy+0xe8/0x159
 [<c0a704ef>] ? extract_freq+0xa1/0xa1
 [<c0a6dbbb>] ? cpufreq_update_policy+0x159/0x159
 [<c0a6da9d>] ? cpufreq_update_policy+0x3b/0x159
 [<c0a6bd5f>] ? cpufreq_freq_transition_begin+0x97/0xd9
 [<c046ea90>] ? __wake_up+0x1a/0x47
 [<c07726a2>] acpi_processor_ppc_has_changed+0x54/0x5d
 [<c076f6d9>] acpi_cpu_soft_notify+0xb0/0xf1
 [<c06d2879>] ? compute_batch_value+0xd/0x22
 [<c06d2a58>] ? percpu_counter_hotcpu_callback+0x11/0x80
 [<c0458c35>] notifier_call_chain+0x68/0x91
 [<c0458c7c>] __raw_notifier_call_chain+0x1e/0x23
 [<c04410c2>] __cpu_notify+0x24/0x39
 [<c04414d9>] _cpu_up+0xef/0x105
 [<c044153d>] cpu_up+0x4e/0x5f
 [<c06bcbdb>] ? find_next_bit+0x1a/0x20
 [<c043dfa6>] disable_mmiotrace+0xd4/0x13e
 [<c04d854b>] mmio_trace_reset+0x36/0x5e
 [<c04d3c83>] tracing_set_tracer+0xb1/0x155
 [<c06b7f22>] ? _copy_from_user+0x42/0x57
 [<c04d3d91>] tracing_set_trace_write+0x6a/0x80
 [<c0516935>] ? handle_mm_fault+0x75b/0xc42
 [<c0532d45>] ? file_start_write+0x27/0x29
 [<c04d3d27>] ? tracing_set_tracer+0x155/0x155
 [<c0532e5a>] __vfs_write+0x24/0x9b
 [<c0532d45>] ? file_start_write+0x27/0x29
 [<c0533375>] ? rw_verify_area+0xce/0xef
 [<c04370f2>] ? __do_page_fault+0x2be/0x3be
 [<c0533863>] vfs_write+0x7a/0xc4
 [<c0533a29>] SyS_write+0x54/0x7f
 [<c0cdad58>] sysenter_do_call+0x12/0x12
---[ end trace 47cc28ca9538eb2f ]---
mmiotrace: enabled CPU3.
mmiotrace: disabled.


This behavior is very predictable. The data is freed when taking the
CPUs offline, and then it is allocated and freed when coming back up!
Then nothing is done to the data the next time the CPU is taken offline
(it's NULL), but when it comes online, this triggers the warning.

Debug patch I used:

-- Steve


diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 0136dfcdabf0..c614698faab3 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -370,6 +370,11 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
 
 	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
 
+	printk("data=%p\n", data);
+	if (data) {
+		printk("data-acpi_data=%p\n", data->acpi_data);
+		printk("data-freq_table_data=%p\n", data->freq_table);
+	}
 	if (unlikely(data == NULL ||
 		     data->acpi_data == NULL || data->freq_table == NULL)) {
 		return 0;
@@ -674,6 +679,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	data->acpi_data = per_cpu_ptr(acpi_perf_data, cpu);
 	per_cpu(acfreq_data, cpu) = data;
+	printk("INIT data = %p (%d)\n", data, cpu);
 
 	if (cpu_has(c, X86_FEATURE_CONSTANT_TSC))
 		acpi_cpufreq_driver.flags |= CPUFREQ_CONST_LOOPS;
@@ -861,6 +867,7 @@ static int acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 		free_cpumask_var(data->freqdomain_cpus);
 		kfree(data->freq_table);
 		kfree(data);
+		printk("exit free %p (%d)\n", data, policy->cpu);
 	}
 
 	return 0;
@@ -871,6 +878,7 @@ static int acpi_cpufreq_resume(struct cpufreq_policy *policy)
 	struct acpi_cpufreq_data *data = per_cpu(acfreq_data, policy->cpu);
 
 	pr_debug("acpi_cpufreq_resume\n");
+	printk("resume %p (%d)\n", data, policy->cpu);
 
 	data->resume = 1;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b612411655f9..68458db0390a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2346,6 +2346,7 @@ int cpufreq_update_policy(unsigned int cpu)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
+		printk("get=%pS\n", cpufreq_driver->get);
 		new_policy.cur = cpufreq_driver->get(cpu);
 		if (WARN_ON(!new_policy.cur)) {
 			ret = -EIO;

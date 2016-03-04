From: Joe Perches <joe@perches.com>
Subject: [PATCH] kernel/...: Convert pr_warning to pr_warn
Date: Fri,  4 Mar 2016 10:15:26 -0800
Message-ID: <1c47e70d5aa4ac129621e4c49a8b896b5cab4b64.1457092467.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jens Axboe <axboe@kernel.dk>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-block@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use the more common logging method with the eventual goal
of removing pr_warning altogether.

Miscellanea:

o Realign arguments
o Coalesce formats
o Add missing space between a few coalesced formats

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/irq/manage.c                  |  4 ++--
 kernel/power/suspend.c               |  3 +--
 kernel/time/tick-sched.c             |  8 ++++----
 kernel/trace/blktrace.c              |  4 ++--
 kernel/trace/ftrace.c                |  7 +++----
 kernel/trace/trace.c                 | 40 ++++++++++++++++++------------------
 kernel/trace/trace_functions_graph.c |  6 +++---
 kernel/trace/trace_kprobe.c          | 27 ++++++++++--------------
 kernel/trace/trace_mmiotrace.c       |  2 +-
 kernel/trace/trace_probe.c           |  4 ++--
 kernel/trace/trace_stat.c            |  3 +--
 kernel/trace/trace_uprobe.c          |  2 +-
 kernel/tracepoint.c                  |  2 +-
 13 files changed, 52 insertions(+), 60 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3ddd229..083ddd5 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1322,8 +1322,8 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 
 		if (nmsk != omsk)
 			/* hope the handler works with current  trigger mode */
-			pr_warning("irq %d uses trigger mode %u; requested %u\n",
-				   irq, nmsk, omsk);
+			pr_warn("irq %d uses trigger mode %u; requested %u\n",
+				irq, nmsk, omsk);
 	}
 
 	*old_ptr = new;
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 230a772..5b70d64 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -473,8 +473,7 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_FREEZE) {
 #ifdef CONFIG_PM_DEBUG
 		if (pm_test_level != TEST_NONE && pm_test_level <= TEST_CPUS) {
-			pr_warning("PM: Unsupported test mode for suspend to idle,"
-				   "please choose none/freezer/devices/platform.\n");
+			pr_warn("PM: Unsupported test mode for suspend to idle, please choose none/freezer/devices/platform.\n");
 			return -EAGAIN;
 		}
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c4646cd..3f68d17 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -281,7 +281,7 @@ static int __init tick_nohz_full_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&tick_nohz_full_mask);
 	if (cpulist_parse(str, tick_nohz_full_mask) < 0) {
-		pr_warning("NOHZ: Incorrect nohz_full cpumask\n");
+		pr_warn("NO_HZ: Incorrect nohz_full cpumask\n");
 		free_bootmem_cpumask_var(tick_nohz_full_mask);
 		return 1;
 	}
@@ -349,8 +349,7 @@ void __init tick_nohz_init(void)
 	 * interrupts to avoid circular dependency on the tick
 	 */
 	if (!arch_irq_work_has_interrupt()) {
-		pr_warning("NO_HZ: Can't run full dynticks because arch doesn't "
-			   "support irq work self-IPIs\n");
+		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support irq work self-IPIs\n");
 		cpumask_clear(tick_nohz_full_mask);
 		cpumask_copy(housekeeping_mask, cpu_possible_mask);
 		tick_nohz_full_running = false;
@@ -360,7 +359,8 @@ void __init tick_nohz_init(void)
 	cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
-		pr_warning("NO_HZ: Clearing %d from nohz_full range for timekeeping\n", cpu);
+		pr_warn("NO_HZ: Clearing %d from nohz_full range for timekeeping\n",
+			cpu);
 		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
 	}
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2aeb6ff..f94e7a2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1437,12 +1437,12 @@ static struct trace_event trace_blk_event = {
 static int __init init_blk_tracer(void)
 {
 	if (!register_trace_event(&trace_blk_event)) {
-		pr_warning("Warning: could not register block events\n");
+		pr_warn("Warning: could not register block events\n");
 		return 1;
 	}
 
 	if (register_tracer(&blk_tracer) != 0) {
-		pr_warning("Warning: could not register the block tracer\n");
+		pr_warn("Warning: could not register the block tracer\n");
 		unregister_trace_event(&trace_blk_event);
 		return 1;
 	}
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 57a6eea..2ece9f1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1058,8 +1058,7 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 	entry = tracefs_create_file("function_profile_enabled", 0644,
 				    d_tracer, NULL, &ftrace_profile_fops);
 	if (!entry)
-		pr_warning("Could not create tracefs "
-			   "'function_profile_enabled' entry\n");
+		pr_warn("Could not create tracefs 'function_profile_enabled' entry\n");
 }
 
 #else /* CONFIG_FUNCTION_PROFILER */
@@ -2314,8 +2313,8 @@ unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec)
 	if (rec->flags & FTRACE_FL_TRAMP_EN) {
 		ops = ftrace_find_tramp_ops_curr(rec);
 		if (FTRACE_WARN_ON(!ops)) {
-			pr_warning("Bad trampoline accounting at: %p (%pS)\n",
-				    (void *)rec->ip, (void *)rec->ip);
+			pr_warn("Bad trampoline accounting at: %p (%pS)\n",
+				(void *)rec->ip, (void *)rec->ip);
 			/* Ftrace is shutting down, return anything */
 			return (unsigned long)FTRACE_ADDR;
 		}
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d929340..032b388 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2071,20 +2071,20 @@ void trace_printk_init_buffers(void)
 
 	/* trace_printk() is for debug use only. Don't use it in production. */
 
-	pr_warning("\n");
-	pr_warning("**********************************************************\n");
-	pr_warning("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warning("**                                                      **\n");
-	pr_warning("** trace_printk() being used. Allocating extra memory.  **\n");
-	pr_warning("**                                                      **\n");
-	pr_warning("** This means that this is a DEBUG kernel and it is     **\n");
-	pr_warning("** unsafe for production use.                           **\n");
-	pr_warning("**                                                      **\n");
-	pr_warning("** If you see this message and you are not debugging    **\n");
-	pr_warning("** the kernel, report this immediately to your vendor!  **\n");
-	pr_warning("**                                                      **\n");
-	pr_warning("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
-	pr_warning("**********************************************************\n");
+	pr_warn("\n");
+	pr_warn("**********************************************************\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** trace_printk() being used. Allocating extra memory.  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** This means that this is a DEBUG kernel and it is     **\n");
+	pr_warn("** unsafe for production use.                           **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("** If you see this message and you are not debugging    **\n");
+	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
+	pr_warn("**                                                      **\n");
+	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
+	pr_warn("**********************************************************\n");
 
 	/* Expand the buffers to set size */
 	tracing_update_buffers();
@@ -4101,7 +4101,7 @@ trace_insert_enum_map_file(struct module *mod, struct trace_enum_map **start,
 	 */
 	map_array = kmalloc(sizeof(*map_array) * (len + 2), GFP_KERNEL);
 	if (!map_array) {
-		pr_warning("Unable to allocate trace enum mapping\n");
+		pr_warn("Unable to allocate trace enum mapping\n");
 		return;
 	}
 
@@ -6131,7 +6131,7 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 	snprintf(cpu_dir, 30, "cpu%ld", cpu);
 	d_cpu = tracefs_create_dir(cpu_dir, d_percpu);
 	if (!d_cpu) {
-		pr_warning("Could not create tracefs '%s' entry\n", cpu_dir);
+		pr_warn("Could not create tracefs '%s' entry\n", cpu_dir);
 		return;
 	}
 
@@ -6318,7 +6318,7 @@ struct dentry *trace_create_file(const char *name,
 
 	ret = tracefs_create_file(name, mode, parent, data, fops);
 	if (!ret)
-		pr_warning("Could not create tracefs '%s' entry\n", name);
+		pr_warn("Could not create tracefs '%s' entry\n", name);
 
 	return ret;
 }
@@ -6337,7 +6337,7 @@ static struct dentry *trace_options_init_dentry(struct trace_array *tr)
 
 	tr->options = tracefs_create_dir("options", d_tracer);
 	if (!tr->options) {
-		pr_warning("Could not create tracefs directory 'options'\n");
+		pr_warn("Could not create tracefs directory 'options'\n");
 		return NULL;
 	}
 
@@ -7248,8 +7248,8 @@ __init static int tracer_alloc_buffers(void)
 	if (trace_boot_clock) {
 		ret = tracing_set_clock(&global_trace, trace_boot_clock);
 		if (ret < 0)
-			pr_warning("Trace clock %s not defined, going back to default\n",
-				   trace_boot_clock);
+			pr_warn("Trace clock %s not defined, going back to default\n",
+				trace_boot_clock);
 	}
 
 	/*
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index a663cbb..91d6a63 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -1350,7 +1350,7 @@ void graph_trace_open(struct trace_iterator *iter)
  out_err_free:
 	kfree(data);
  out_err:
-	pr_warning("function graph tracer: not enough memory\n");
+	pr_warn("function graph tracer: not enough memory\n");
 }
 
 void graph_trace_close(struct trace_iterator *iter)
@@ -1468,12 +1468,12 @@ static __init int init_graph_trace(void)
 	max_bytes_for_cpu = snprintf(NULL, 0, "%d", nr_cpu_ids - 1);
 
 	if (!register_trace_event(&graph_trace_entry_event)) {
-		pr_warning("Warning: could not register graph trace events\n");
+		pr_warn("Warning: could not register graph trace events\n");
 		return 1;
 	}
 
 	if (!register_trace_event(&graph_trace_ret_event)) {
-		pr_warning("Warning: could not register graph trace events\n");
+		pr_warn("Warning: could not register graph trace events\n");
 		return 1;
 	}
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 21b81a4..919e0dd 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -459,16 +459,14 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (ret == 0)
 		tk->tp.flags |= TP_FLAG_REGISTERED;
 	else {
-		pr_warning("Could not insert probe at %s+%lu: %d\n",
-			   trace_kprobe_symbol(tk), trace_kprobe_offset(tk), ret);
+		pr_warn("Could not insert probe at %s+%lu: %d\n",
+			trace_kprobe_symbol(tk), trace_kprobe_offset(tk), ret);
 		if (ret == -ENOENT && trace_kprobe_is_on_module(tk)) {
-			pr_warning("This probe might be able to register after"
-				   "target module is loaded. Continue.\n");
+			pr_warn("This probe might be able to register after target module is loaded. Continue.\n");
 			ret = 0;
 		} else if (ret == -EILSEQ) {
-			pr_warning("Probing address(0x%p) is not an "
-				   "instruction boundary.\n",
-				   tk->rp.kp.addr);
+			pr_warn("Probing address(0x%p) is not an instruction boundary.\n",
+				tk->rp.kp.addr);
 			ret = -EINVAL;
 		}
 	}
@@ -529,7 +527,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	/* Register new event */
 	ret = register_kprobe_event(tk);
 	if (ret) {
-		pr_warning("Failed to register probe event(%d)\n", ret);
+		pr_warn("Failed to register probe event(%d)\n", ret);
 		goto end;
 	}
 
@@ -564,10 +562,9 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 			__unregister_trace_kprobe(tk);
 			ret = __register_trace_kprobe(tk);
 			if (ret)
-				pr_warning("Failed to re-register probe %s on"
-					   "%s: %d\n",
-					   trace_event_name(&tk->tp.call),
-					   mod->name, ret);
+				pr_warn("Failed to re-register probe %s on %s: %d\n",
+					trace_event_name(&tk->tp.call),
+					mod->name, ret);
 		}
 	}
 	mutex_unlock(&probe_lock);
@@ -1336,16 +1333,14 @@ static __init int init_kprobe_trace(void)
 
 	/* Event list interface */
 	if (!entry)
-		pr_warning("Could not create tracefs "
-			   "'kprobe_events' entry\n");
+		pr_warn("Could not create tracefs 'kprobe_events' entry\n");
 
 	/* Profile interface */
 	entry = tracefs_create_file("kprobe_profile", 0444, d_tracer,
 				    NULL, &kprobe_profile_ops);
 
 	if (!entry)
-		pr_warning("Could not create tracefs "
-			   "'kprobe_profile' entry\n");
+		pr_warn("Could not create tracefs 'kprobe_profile' entry\n");
 	return 0;
 }
 fs_initcall(init_kprobe_trace);
diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 2be8c4f..68f376c 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -146,7 +146,7 @@ static ssize_t mmio_read(struct trace_iterator *iter, struct file *filp,
 		/* XXX: This is later than where events were lost. */
 		trace_seq_printf(s, "MARK 0.000000 Lost %lu events.\n", n);
 		if (!overrun_detected)
-			pr_warning("mmiotrace has lost events.\n");
+			pr_warn("mmiotrace has lost events\n");
 		overrun_detected = true;
 		goto print_out;
 	}
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 1769a81..1d372fa 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -636,8 +636,8 @@ ssize_t traceprobe_probes_write(struct file *file, const char __user *buffer,
 			*tmp = '\0';
 			size = tmp - kbuf + 1;
 		} else if (done + size < count) {
-			pr_warning("Line length is too long: "
-				   "Should be less than %d.", WRITE_BUFSIZE);
+			pr_warn("Line length is too long: Should be less than %d\n",
+				WRITE_BUFSIZE);
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index 6cf9353..413ff10 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -281,8 +281,7 @@ static int tracing_stat_init(void)
 
 	stat_dir = tracefs_create_dir("trace_stat", d_tracing);
 	if (!stat_dir)
-		pr_warning("Could not create tracefs "
-			   "'trace_stat' entry\n");
+		pr_warn("Could not create tracefs 'trace_stat' entry\n");
 	return 0;
 }
 
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index d2f6d0b..7915142 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -334,7 +334,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 
 	ret = register_uprobe_event(tu);
 	if (ret) {
-		pr_warning("Failed to register probe event(%d)\n", ret);
+		pr_warn("Failed to register probe event(%d)\n", ret);
 		goto end;
 	}
 
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index ecd536d..d0639d9 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -491,7 +491,7 @@ static __init int init_tracepoints(void)
 
 	ret = register_module_notifier(&tracepoint_module_nb);
 	if (ret)
-		pr_warning("Failed to register tracepoint module enter notifier\n");
+		pr_warn("Failed to register tracepoint module enter notifier\n");
 
 	return ret;
 }
-- 
2.6.3.368.gf34be46

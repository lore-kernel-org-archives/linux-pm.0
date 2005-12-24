From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sat, 24 Dec 2005 10:29:18 +1000
Message-ID: <1135384157.9616.167.camel@localhost>
References: <20051223172057.GA15357@elf.ucw.cz>
	<Pine.LNX.4.44L0.0512231619010.28577-100000@netrider.rowland.org>
	<20051223212827.GA17350@kroah.com>
	<1135375796.9616.155.camel@localhost>
	<20051223223142.GA16104@elf.ucw.cz>
	<1135377631.9616.158.camel@localhost>
	<20051223224859.GB16104@elf.ucw.cz>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============10436346568749566=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051223224859.GB16104@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============10436346568749566==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Sat, 2005-12-24 at 08:48, Pavel Machek wrote:
> Ahha, ok. Forget it, then. Or just send a patch without the
> refrigerator changes, so Alan knows where to hack. It does not have to
> work in order to be useful :-).

Maybe it would be helpful if I sent more than that first reply. I'm not
suggesting for a moment that you'll want all of this, but it might be
helpful anyway.

I particularly find taking the freezer definitions out of sched.h
helpful - there are too many files dependant on sched.h already, and
little changes to freezing should mean recompiling half the kernel.

By the way, yes - there are little bits here and there that I can
remove. I'm still removing the vestiges of earlier methods of doing
things.

Regards,

Nigel.

diff -ruN linux-2.6.15-rc6/include/linux/freezer.h build-2.6.15-rc6/include/linux/freezer.h
--- linux-2.6.15-rc6/include/linux/freezer.h	1970-01-01 10:00:00.000000000 +1000
+++ build-2.6.15-rc6/include/linux/freezer.h	2005-12-21 10:18:39.000000000 +1000
@@ -0,0 +1,29 @@
+/* Freezer declarations */
+
+#define FREEZER_ON 0
+#define ABORT_FREEZING 1
+#define LRU_FREEZE 2
+
+#define FREEZER_KERNEL_THREADS 0
+#define FREEZER_ALL_THREADS 1
+
+#ifdef CONFIG_PM
+extern unsigned long freezer_state;
+
+#define test_freezer_state(bit) test_bit(bit, &freezer_state)
+#define set_freezer_state(bit) set_bit(bit, &freezer_state)
+#define clear_freezer_state(bit) clear_bit(bit, &freezer_state)
+
+#define freezer_is_on() (test_freezer_state(FREEZER_ON))
+
+extern void do_freeze_process(struct notifier_block *nl);
+
+#else
+
+#define test_freezer_state(bit) (0)
+#define set_freezer_state(bit) do { } while(0)
+#define clear_freezer_state(bit) do { } while(0)
+
+#define freezer_is_on() (0)
+
+#endif
diff -ruN linux-2.6.15-rc6/include/linux/sched.h build-2.6.15-rc6/include/linux/sched.h
--- linux-2.6.15-rc6/include/linux/sched.h	2005-12-20 19:46:36.000000000 +1000
+++ build-2.6.15-rc6/include/linux/sched.h	2005-12-21 10:18:39.000000000 +1000
@@ -34,6 +34,7 @@
 #include <linux/percpu.h>
 #include <linux/topology.h>
 #include <linux/seccomp.h>
+#include <linux/notifier.h>
 
 #include <linux/auxvec.h>	/* For AT_VECTOR_SIZE */
 
@@ -807,7 +808,10 @@
 	int (*notifier)(void *priv);
 	void *notifier_data;
 	sigset_t *notifier_mask;
-	
+
+	/* todo list to be executed in the context of this thread */
+	struct notifier_block *todo;
+
 	void *security;
 	struct audit_context *audit_context;
 	seccomp_t seccomp;
@@ -898,7 +902,6 @@
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
 #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
-#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
@@ -1385,79 +1388,37 @@
 
 #endif
 
-#ifdef CONFIG_PM
 /*
- * Check if a process has been frozen
+ * Check if there is a todo list request
  */
-static inline int frozen(struct task_struct *p)
+static inline int todo_list_active(void)
 {
-	return p->flags & PF_FROZEN;
+	return current->todo != NULL;
 }
 
-/*
- * Check if there is a request to freeze a process
- */
-static inline int freezing(struct task_struct *p)
+static inline void run_todo_list(void)
 {
-	return p->flags & PF_FREEZE;
+	notifier_call_chain(&current->todo, 0, current);
 }
 
-/*
- * Request that a process be frozen
- * FIXME: SMP problem. We may not modify other process' flags!
- */
-static inline void freeze(struct task_struct *p)
+static inline int try_todo_list(void)
 {
-	p->flags |= PF_FREEZE;
-}
-
-/*
- * Wake up a frozen process
- */
-static inline int thaw_process(struct task_struct *p)
-{
-	if (frozen(p)) {
-		p->flags &= ~PF_FROZEN;
-		wake_up_process(p);
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * freezing is complete, mark process as frozen
- */
-static inline void frozen_process(struct task_struct *p)
-{
-	p->flags = (p->flags & ~PF_FREEZE) | PF_FROZEN;
-}
-
-extern void refrigerator(void);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
-
-static inline int try_to_freeze(void)
-{
-	if (freezing(current)) {
-		refrigerator();
+	if (todo_list_active()) {
+		run_todo_list();
 		return 1;
 	} else
 		return 0;
 }
-#else
-static inline int frozen(struct task_struct *p) { return 0; }
-static inline int freezing(struct task_struct *p) { return 0; }
-static inline void freeze(struct task_struct *p) { BUG(); }
-static inline int thaw_process(struct task_struct *p) { return 1; }
-static inline void frozen_process(struct task_struct *p) { BUG(); }
-
-static inline void refrigerator(void) {}
-static inline int freeze_processes(void) { BUG(); return 0; }
-static inline void thaw_processes(void) {}
 
-static inline int try_to_freeze(void) { return 0; }
+/*
+ * Compatibility definitions to use the suspend checkpoints for the task todo
+ * list. These may be removed once all uses of try_to_free,  refrigerator and
+ * freezing have been removed.
+ */
+#define try_to_freeze try_todo_list
+#define refrigerator run_todo_list
+#define freezing(p) todo_list_active()
 
-#endif /* CONFIG_PM */
 #endif /* __KERNEL__ */
 
 #endif
diff -ruN linux-2.6.15-rc6/include/linux/suspend.h build-2.6.15-rc6/include/linux/suspend.h
--- linux-2.6.15-rc6/include/linux/suspend.h	2005-12-20 19:46:36.000000000 +1000
+++ build-2.6.15-rc6/include/linux/suspend.h	2005-12-21 10:18:41.000000000 +1000
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/pm.h>
+#include <linux/suspend2.h>
 
 /* page backup entry */
 typedef struct pbe {
@@ -50,14 +51,20 @@
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
 
+extern int freeze_processes(void);
+extern void thaw_processes(int which_threads);
 #else
 static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
+static inline int freeze_processes(void) { return 0; }
+static inline void thaw_processes(int which_threads) { }
 #endif
 
+extern char resume2_file[256];
+
 #ifdef CONFIG_SUSPEND_SMP
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
diff -ruN linux-2.6.15-rc6/kernel/power/process.c build-2.6.15-rc6/kernel/power/process.c
--- linux-2.6.15-rc6/kernel/power/process.c	2005-12-20 19:46:36.000000000 +1000
+++ build-2.6.15-rc6/kernel/power/process.c	2005-12-21 10:18:39.000000000 +1000
@@ -1,134 +1,431 @@
 /*
- * drivers/power/process.c - Functions for starting/stopping processes on 
- *                           suspend transitions.
+ * kernel/power/process.c
  *
- * Originally from swsusp.
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Freeze_and_free contains the routines software suspend uses to freeze other
+ * processes during the suspend cycle and to (if necessary) free up memory in
+ * accordance with limitations on the image size.
+ *
+ * Ideally, the image saved to disk would be an atomic copy of the entire 
+ * contents of all RAM and related hardware state. One of the first 
+ * prerequisites for getting our approximation of this is stopping the activity
+ * of other processes. We can't stop all other processes, however, since some 
+ * are needed in doing the I/O to save the image. Freeze_and_free.c contains 
+ * the routines that control suspension and resuming of these processes.
+ * 
+ * Under high I/O load, we need to be careful about the order in which we
+ * freeze processes. If we freeze processes in the wrong order, we could
+ * deadlock others. The freeze_order array this specifies the order in which
+ * critical processes are frozen. All others are suspended after these have
+ * entered the refrigerator.
+ *
+ * Another complicating factor is that freeing memory requires the processes
+ * to not be frozen, but at the end of freeing memory, they need to be frozen
+ * so that we can be sure we actually have eaten enough memory. This is why
+ * freezing and freeing are in the one file. The freezer is not called from
+ * the main logic, but indirectly, via the code for eating memory. The eat
+ * memory logic is iterative, first freezing processes and checking the stats,
+ * then (if necessary) unfreezing them and eating more memory until it looks 
+ * like the criteria are met (at which point processes are frozen & stats
+ * checked again).
  */
 
-
-#undef DEBUG
-
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
 #include <linux/suspend.h>
+#include <linux/freezer.h>
 #include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namespace.h>
+#include <linux/buffer_head.h>
+#include <asm/tlbflush.h>
+
+unsigned long freezer_state = 0;
+
+#ifdef CONFIG_PM_DEBUG
+#define freezer_message(msg, a...) do { printk(msg, ##a); } while(0)
+#else
+#define freezer_message(msg, a...) do { } while(0)
+#endif
+
+/* Timeouts when freezing */
+#define FREEZER_TOTAL_TIMEOUT (5 * HZ)
+#define FREEZER_CHECK_TIMEOUT (HZ / 10)
+
+DECLARE_COMPLETION(kernelspace_thaw);
+DECLARE_COMPLETION(userspace_thaw);
+static atomic_t nr_userspace_frozen;
+static atomic_t nr_kernelspace_frozen;
+
+struct frozen_fs
+{
+	struct list_head fsb_list;
+	struct super_block *sb;
+};
+
+LIST_HEAD(frozen_fs_list);
+
+void freezer_make_fses_rw(void)
+{
+	struct frozen_fs *fs, *next_fs;
+
+	list_for_each_entry_safe(fs, next_fs, &frozen_fs_list, fsb_list) {
+		thaw_bdev(fs->sb->s_bdev, fs->sb);
+
+		list_del(&fs->fsb_list);
+		kfree(fs);
+	}
+}
 
 /* 
- * Timeout for stopping processes
+ * Done after userspace is frozen, so there should be no danger of
+ * fses being unmounted while we're in here.
  */
-#define TIMEOUT	(6 * HZ)
+int freezer_make_fses_ro(void)
+{
+	struct frozen_fs *fs;
+	struct super_block *sb;
+
+	/* Generate the list */
+	list_for_each_entry(sb, &super_blocks, s_list) {
+		if (!sb->s_root || !sb->s_bdev ||
+		    (sb->s_frozen == SB_FREEZE_TRANS) ||
+		    (sb->s_flags & MS_RDONLY))
+			continue;
 
+		fs = kmalloc(sizeof(struct frozen_fs), GFP_ATOMIC);
+		fs->sb = sb;
+		list_add_tail(&fs->fsb_list, &frozen_fs_list);
+	};
+
+	/* Do the freezing in reverse order so filesystems dependant
+	 * upon others are frozen in the right order. (Eg loopback
+	 * on ext3). */
+	list_for_each_entry_reverse(fs, &frozen_fs_list, fsb_list)
+		freeze_bdev(fs->sb->s_bdev);
 
-static inline int freezeable(struct task_struct * p)
+	return 0;
+}
+
+/*
+ * freezeable
+ *
+ * Description:	Determine whether a process should be frozen yet.
+ * Parameters:	struct task_struct *	The process to consider.
+ * 		int			Boolean - 0 = userspace else all.
+ * Returns:	int			0 if don't freeze yet, otherwise do.
+ */
+static inline int freezeable(struct task_struct * p, int all_freezable)
 {
 	if ((p == current) || 
+	    (p->flags & PF_FROZEN) ||
 	    (p->flags & PF_NOFREEZE) ||
 	    (p->exit_state == EXIT_ZOMBIE) ||
 	    (p->exit_state == EXIT_DEAD) ||
 	    (p->state == TASK_STOPPED) ||
-	    (p->state == TASK_TRACED))
+	    (p->state == TASK_TRACED) ||
+	    (!p->mm && !all_freezable))
 		return 0;
 	return 1;
 }
 
-/* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(void)
+static void __freeze_process(struct completion *completion_handler,
+				atomic_t *nr_frozen)
 {
-	/* Hmm, should we be allowed to suspend when there are realtime
-	   processes around? */
 	long save;
-	save = current->state;
-	pr_debug("%s entered refrigerator\n", current->comm);
-	printk("=");
 
-	frozen_process(current);
-	spin_lock_irq(&current->sighand->siglock);
-	recalc_sigpending(); /* We sent fake signal, clean it up */
-	spin_unlock_irq(&current->sighand->siglock);
-
-	while (frozen(current)) {
-		current->state = TASK_UNINTERRUPTIBLE;
-		schedule();
-	}
-	pr_debug("%s left refrigerator\n", current->comm);
+	freezer_message("%s (%d) frozen.\n",
+			current->comm, current->pid);
+	save = current->state;
+	
+	atomic_inc(nr_frozen);
+	wait_for_completion(completion_handler);
+	atomic_dec(nr_frozen);
+	
 	current->state = save;
+	freezer_message("%s (%d) leaving freezer.\n",
+			current->comm, current->pid);
 }
 
-/* 0 = success, else # of processes that we failed to stop */
-int freeze_processes(void)
+/*
+ * Invoked by the task todo list notifier when the task to be
+ * frozen is running.
+ */
+static int freeze_process(struct notifier_block *nl, unsigned long x, void *v)
 {
-	int todo;
-	unsigned long start_time;
-	struct task_struct *g, *p;
 	unsigned long flags;
 
-	printk( "Stopping tasks: " );
-	start_time = jiffies;
-	do {
-		todo = 0;
-		read_lock(&tasklist_lock);
-		do_each_thread(g, p) {
-			if (!freezeable(p))
-				continue;
-			if (frozen(p))
-				continue;
+	might_sleep();
 
-			freeze(p);
-			spin_lock_irqsave(&p->sighand->siglock, flags);
-			signal_wake_up(p, 0);
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			todo++;
-		} while_each_thread(g, p);
-		read_unlock(&tasklist_lock);
-		yield();			/* Yield is okay here */
-		if (todo && time_after(jiffies, start_time + TIMEOUT)) {
-			printk( "\n" );
-			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
-			break;
-		}
-	} while(todo);
-
-	/* This does not unfreeze processes that are already frozen
-	 * (we have slightly ugly calling convention in that respect,
-	 * and caller must call thaw_processes() if something fails),
-	 * but it cleans up leftover PF_FREEZE requests.
-	 */
-	if (todo) {
-		read_lock(&tasklist_lock);
-		do_each_thread(g, p)
-			if (freezing(p)) {
-				pr_debug("  clean up: %s\n", p->comm);
-				p->flags &= ~PF_FREEZE;
-				spin_lock_irqsave(&p->sighand->siglock, flags);
-				recalc_sigpending_tsk(p);
-				spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			}
-		while_each_thread(g, p);
-		read_unlock(&tasklist_lock);
-		return todo;
+	/* Locking to handle race against waking the process in
+	 * freeze threads. */
+	spin_lock_irqsave(&current->sighand->siglock, flags);
+	current->flags |= PF_FROZEN;
+
+	if (nl)
+		notifier_chain_unregister(&current->todo, nl);
+
+	recalc_sigpending();
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+
+	if (nl)
+		kfree(nl);
+
+	if (test_freezer_state(FREEZER_ON)) {
+		if (current->mm)
+			__freeze_process(&userspace_thaw, &nr_userspace_frozen);
+		else
+			__freeze_process(&kernelspace_thaw,
+					&nr_kernelspace_frozen);
 	}
 
-	printk( "|\n" );
-	BUG_ON(in_atomic());
+	spin_lock_irqsave(&current->sighand->siglock, flags);
+	recalc_sigpending();
+	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+
+	current->flags &= ~PF_FROZEN;
+
 	return 0;
 }
 
-void thaw_processes(void)
+void thaw_processes(int do_all_threads)
 {
+	if (do_all_threads) {
+		clear_freezer_state(FREEZER_ON);
+		clear_freezer_state(ABORT_FREEZING);
+	}
+
+	complete_all(&kernelspace_thaw);
+	while (atomic_read(&nr_kernelspace_frozen) > 0)
+		yield();
+
+	init_completion(&kernelspace_thaw);
+	freezer_make_fses_rw();
+
+	if (do_all_threads) {
+		complete_all(&userspace_thaw);
+		while (atomic_read(&nr_userspace_frozen) > 0)
+			yield();
+		init_completion(&userspace_thaw);
+	}
+}
+
+/*
+ * num_freezeable
+ *
+ * Description:	Determine how many processes of our type are still to be
+ * 		frozen. As a side effect, update the progress bar too.
+ * Parameters:	int	Which type we are trying to freeze.
+ * 		int	Whether we are displaying our progress.
+ */
+static int num_freezeable(int do_all_threads) {
+	
 	struct task_struct *g, *p;
+	int todo_this_type = 0;
 
-	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	do_each_thread(g, p) {
-		if (!freezeable(p))
+		if (freezeable(p, do_all_threads))
+			todo_this_type++;
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	return todo_this_type;
+}
+
+/*
+ * num_uninterruptible
+ *
+ * Description:	Determine how many processes of our type are in state
+ * 		task uninterruptible.
+ * Parameters:	int	Which type we are trying to freeze.
+ */
+static int num_uninterruptible(int do_all_threads) {
+	
+	struct task_struct *g, *p;
+	int count = 0;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (freezeable(p, do_all_threads) &&
+			p->state == TASK_UNINTERRUPTIBLE)
+			count++;
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+
+	return count;
+}
+
+/*
+ * Tell threads of the type to enter the freezer.
+ */
+static void signal_threads(int do_all_threads)
+{
+	struct task_struct *g, *p;
+	struct notifier_block *n;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p, do_all_threads))
 			continue;
-		if (!thaw_process(p))
-			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+
+		n = kmalloc(sizeof(struct notifier_block),
+					GFP_ATOMIC);
+
+		if (n) {
+			n->notifier_call = freeze_process;
+			n->priority = 0;
+			notifier_chain_register(&p->todo, n);
+ 		}
 	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
+/*
+ * Prod processes that haven't entered the refrigerator yet.
+ */
+static void prod_processes(int do_all_threads)
+{
+	struct task_struct *g, *p;
+	unsigned long flags;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p, do_all_threads))
+			continue;
+			
+		spin_lock_irqsave(&p->sighand->siglock, flags);
+		if (!(p->flags & PF_FROZEN)) {
+			recalc_sigpending();
+			signal_wake_up(p, 0);
+		}
+		spin_unlock_irqrestore(&p->sighand->siglock, flags);
+	} while_each_thread(g, p);
+	read_unlock(&tasklist_lock);
+}
+
+/*
+ * Freezer failure.
+ *
+ * Check whether we failed to freeze all the processes that
+ * should be frozen. If we find a task that failed to freeze,
+ * we give useful information on what failed and how.
+ */
+static int freezer_failure(int do_all_threads)
+{
+	int result = 0;
+	struct task_struct *g, *p;
+
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (!freezeable(p, do_all_threads) || 
+				p->state == TASK_UNINTERRUPTIBLE) 
+			continue;
 
+		if (!result) {
+			printk(KERN_ERR	"Stopping tasks failed.\n");
+			printk(KERN_ERR "Tasks that refused to be "
+			 "refrigerated and haven't since exited:\n");
+			set_freezer_state(ABORT_FREEZING);
+			result = 1;
+		}
+
+		if ((freezing(p))) {
+			printk(" - %s (#%d) signalled but "
+				"didn't enter refrigerator.\n",
+				p->comm, p->pid);
+		} else
+			printk(" - %s (#%d) signalled "
+				"and todo list empty.\n",
+				p->comm, p->pid);
+	} while_each_thread(g, p);
 	read_unlock(&tasklist_lock);
-	schedule();
-	printk( " done\n" );
+
+	return result;
+}
+
+/*
+ * freeze_threads
+ *
+ * Freeze a set of threads having particular attributes.
+ *
+ * Types:
+ * 2: User threads.
+ * 3: Kernel threads.
+ */
+static int freeze_threads(int do_all_threads)
+{
+	int result = 0, still_to_do;
+	unsigned long start_time = jiffies;
+
+	if (do_all_threads)	
+		freezer_make_fses_ro();
+
+	signal_threads(do_all_threads);
+
+	/* Watch them do it, wake them if they ignore us. */
+	do {
+		prod_processes(do_all_threads);
+
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		schedule_timeout(FREEZER_CHECK_TIMEOUT);
+
+		still_to_do = num_freezeable(do_all_threads) - 
+			num_uninterruptible(do_all_threads);
+
+	} while(still_to_do && (!test_freezer_state(ABORT_FREEZING)) &&
+		!time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT));
+
+	/*
+	 * Did we time out? See if we failed to freeze processes as well.
+	 *
+	 */
+	if ((time_after(jiffies, start_time + FREEZER_TOTAL_TIMEOUT))
+			&& (still_to_do))
+		result = freezer_failure(do_all_threads);
+
+	BUG_ON(in_atomic());
+	
+	return 0; 
+}
+
+/*
+ * freeze_processes - Freeze processes prior to saving an image of memory.
+ * 
+ * Return value: 0 = success, 1 = faulure.
+ */
+int freeze_processes(void)
+{
+	enum system_states old_state = system_state;
+	int result = 0;
+
+	if (!test_freezer_state(FREEZER_ON)) {
+		/* 
+		 * No race. While !FREEZER_ON, processes
+		 * won't enter __freeze_process
+		 */
+		init_completion(&userspace_thaw);
+		init_completion(&kernelspace_thaw);
+		set_freezer_state(FREEZER_ON);
+	}
+
+	/* Now freeze processes that were syncing and are still running */
+	if (freeze_threads(0) || (test_freezer_state(ABORT_FREEZING))) {
+		result = 1;
+		goto out;
+	}
+
+	/* Freeze kernel threads */
+	if (freeze_threads(1) || (test_freezer_state(ABORT_FREEZING)))
+		result = 1;
+
+out:
+	system_state = old_state;
+	return result;
 }
 
-EXPORT_SYMBOL(refrigerator);
+EXPORT_SYMBOL(freezer_state);



--===============10436346568749566==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============10436346568749566==--

From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 09/10] timer/migration: Add tracepoints
Date: Mon, 17 Apr 2017 20:32:50 +0200
Message-ID: <20170417184356.697789890@linutronix.de>
References: <20170417183241.244217993@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=timer-migration-Add-tracepoints.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

The timer pull logic needs proper debuging aids. Add tracepoints so the
hierarchical idle machinery can be diagnosed.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/trace/events/timer_migration.h |  173 +++++++++++++++++++++++++++++++++
 kernel/time/timer_migration.c          |   17 +++
 2 files changed, 190 insertions(+)

--- /dev/null
+++ b/include/trace/events/timer_migration.h
@@ -0,0 +1,173 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timer_migration
+
+#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMER_MIGRATION_H
+
+#include <linux/tracepoint.h>
+
+/* Group events */
+DECLARE_EVENT_CLASS(tmigr_group,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void *,	group	)
+		__field( unsigned int,	lvl	)
+		__field( unsigned int,	numa_node )
+		__field( unsigned int,	active )
+		__field( unsigned int,	migrator )
+		__field( unsigned int,	num_childs )
+		__field( void *,	parent	)
+		__field( u64,		nextevt	)
+		__field( unsigned int,	evtcpu	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+		__entry->active		= group->active;
+		__entry->migrator	= group->migrator;
+		__entry->num_childs	= group->num_childs;
+		__entry->parent		= group->parent;
+		__entry->nextevt	= group->groupevt.nextevt.expires;
+		__entry->evtcpu		= group->groupevt.cpu;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d active=%d migrator=%d num_childs=%d "
+		  "parent=%p nextevt=%llu evtcpu=%d",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator, __entry->num_childs,
+		  __entry->parent, __entry->nextevt, __entry->evtcpu)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_addevt,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_removeevt,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_set_cpu_inactive,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_set_cpu_active,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_free,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_set,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+DEFINE_EVENT(tmigr_group, tmigr_group_setup_parents,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group)
+);
+
+/* CPU events*/
+DECLARE_EVENT_CLASS(tmigr_cpugroup,
+
+	TP_PROTO(struct tmigr_cpu *tcpu, unsigned int cpu),
+
+	TP_ARGS(tcpu, cpu),
+
+	TP_STRUCT__entry(
+		__field( unsigned int,	cpu)
+		__field( void *,	parent)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= cpu;
+		__entry->parent		= tcpu->tmgroup;
+	),
+
+	TP_printk("cpu=%d parent=%p", __entry->cpu, __entry->parent)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_update_remote,
+
+	TP_PROTO(struct tmigr_cpu *tcpu, unsigned int cpu),
+
+	TP_ARGS(tcpu, cpu)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_add,
+
+	TP_PROTO(struct tmigr_cpu *tcpu, unsigned int cpu),
+
+	TP_ARGS(tcpu, cpu)
+);
+
+/* Other events */
+TRACE_EVENT(tmigr_handle_remote,
+
+	TP_PROTO(struct tmigr_group *group, unsigned int cpu),
+
+	TP_ARGS(group, cpu),
+
+	TP_STRUCT__entry(
+		__field( void *,	group	)
+		__field( unsigned int,	lvl	)
+		__field( unsigned int,	numa_node )
+		__field( unsigned int,	active )
+		__field( unsigned int,	migrator )
+		__field( unsigned int,	num_childs )
+		__field( void *,	parent	)
+		__field( u64,		nextevt	)
+		__field( unsigned int,	evtcpu	)
+		__field( unsigned int,	cpu	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+		__entry->active		= group->active;
+		__entry->migrator	= group->migrator;
+		__entry->num_childs	= group->num_childs;
+		__entry->parent		= group->parent;
+		__entry->nextevt	= group->groupevt.nextevt.expires;
+		__entry->evtcpu		= group->groupevt.cpu;
+		__entry->cpu		= cpu;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d active=%d migrator=%d num_childs=%d "
+		  "parent=%p nextevt=%llu evtcpu=%d cpu=%d",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator, __entry->num_childs,
+		  __entry->parent, __entry->nextevt, __entry->evtcpu, __entry->cpu)
+);
+
+#endif /*  _TRACE_TIMER_MIGRATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -16,6 +16,9 @@
 #include "timer_migration.h"
 #include "tick-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
 #ifdef DEBUG
 # define DBG_BUG_ON(x)	BUG_ON(x)
 #else
@@ -53,6 +56,8 @@ static void tmigr_add_evt(struct tmigr_g
 		group->groupevt.nextevt.expires = evt->nextevt.expires;
 		group->groupevt.cpu = evt->cpu;
 	}
+
+	trace_tmigr_group_addevt(group);
 }
 
 static void tmigr_remove_evt(struct tmigr_group *group, struct tmigr_event *evt)
@@ -86,6 +91,8 @@ static void tmigr_remove_evt(struct tmig
 		group->groupevt.nextevt.expires = nextevt->nextevt.expires;
 		group->groupevt.cpu = nextevt->cpu;
 	}
+
+	trace_tmigr_group_removeevt(group);
 }
 
 static void tmigr_update_remote(unsigned int cpu, u64 now, unsigned long jif)
@@ -142,6 +149,7 @@ static void tmigr_update_remote(unsigned
 	tmigr_add_evt(group, &tmc->cpuevt);
 
 done:
+	trace_tmigr_cpu_update_remote(tmc, cpu);
 	raw_spin_unlock(&group->lock);
 	raw_spin_unlock_irq(&tmc->lock);
 }
@@ -153,6 +161,8 @@ static void __tmigr_handle_remote(struct
 	struct tmigr_group *parent;
 	struct tmigr_event *evt;
 
+	trace_tmigr_handle_remote(group, cpu);
+
 again:
 	raw_spin_lock_irq(&group->lock);
 	/*
@@ -332,6 +342,7 @@ static u64 tmigr_set_cpu_inactive(struct
 		nextevt = group->groupevt.nextevt.expires;
 	}
 done:
+	trace_tmigr_group_set_cpu_inactive(group);
 	raw_spin_unlock(&group->lock);
 	return nextevt;
 }
@@ -390,6 +401,9 @@ static void tmigr_set_cpu_active(struct
 		if (parent)
 			tmigr_set_cpu_active(parent, &group->groupevt, cpu);
 	}
+
+	trace_tmigr_group_set_cpu_active(group);
+
 	/*
 	 * Update groupevt and dequeue @evt. Must be called after parent
 	 * groups have been updated above so @group->groupevt is inactive.
@@ -425,6 +439,7 @@ static void tmigr_free_group(struct tmig
 		if (!group->parent->num_childs)
 			tmigr_free_group(group->parent);
 	}
+	trace_tmigr_group_free(group);
 	list_del(&group->list);
 	free_cpumask_var(group->cpus);
 	kfree(group);
@@ -475,6 +490,7 @@ static struct tmigr_group *tmigr_get_gro
 	tmigr_init_group(group, lvl, node);
 	/* Setup successful. Add it to the hierarchy */
 	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
 	return group;
 }
 
@@ -502,6 +518,7 @@ static int tmigr_setup_parents(unsigned
 		if (group->active)
 			tmigr_set_cpu_active(parent, NULL, group->migrator);
 		raw_spin_unlock_irq(&group->lock);
+		trace_tmigr_group_setup_parents(group);
 		ret = 1;
 	}
 	return ret;

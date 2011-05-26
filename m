From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/3] export some perf interfaces
Date: Thu, 26 May 2011 16:34:13 +0800
Message-ID: <1306398853.2207.155.camel__31899.2025954232$1306399111$gmane$org@rui>
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
To: LKML <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
Cc: acme@redhat.com, mingo@elte.hu, a.p.zijlstra@chello.nl, ming.m.lin@intel.com
List-Id: linux-pm@vger.kernel.org


Export perf interfaces.

Needed by the next patch, which exports the
Package/Core/Uncore/DRAM energy consumption via perf tool.

Singed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 include/linux/perf_event.h |    3 +++
 kernel/events/core.c       |   11 ++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/perf_event.h
===================================================================
--- linux-2.6.orig/include/linux/perf_event.h
+++ linux-2.6/include/linux/perf_event.h
@@ -1153,6 +1153,9 @@ extern void perf_swevent_put_recursion_c
 extern void perf_event_enable(struct perf_event *event);
 extern void perf_event_disable(struct perf_event *event);
 extern void perf_event_task_tick(void);
+extern void perf_swevent_init_hrtimer(struct perf_event *event);
+extern void perf_swevent_start_hrtimer(struct perf_event *event);
+extern void perf_swevent_cancel_hrtimer(struct perf_event *event);
 #else
 static inline void
 perf_event_task_sched_in(struct task_struct *task)			{ }
Index: linux-2.6/kernel/events/core.c
===================================================================
--- linux-2.6.orig/kernel/events/core.c
+++ linux-2.6/kernel/events/core.c
@@ -5648,7 +5648,7 @@ static enum hrtimer_restart perf_swevent
 	return ret;
 }
 
-static void perf_swevent_start_hrtimer(struct perf_event *event)
+void perf_swevent_start_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	s64 period;
@@ -5669,8 +5669,9 @@ static void perf_swevent_start_hrtimer(s
 				ns_to_ktime(period), 0,
 				HRTIMER_MODE_REL_PINNED, 0);
 }
+EXPORT_SYMBOL_GPL(perf_swevent_start_hrtimer);
 
-static void perf_swevent_cancel_hrtimer(struct perf_event *event)
+void perf_swevent_cancel_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -5681,8 +5682,9 @@ static void perf_swevent_cancel_hrtimer(
 		hrtimer_cancel(&hwc->hrtimer);
 	}
 }
+EXPORT_SYMBOL_GPL(perf_swevent_cancel_hrtimer);
 
-static void perf_swevent_init_hrtimer(struct perf_event *event)
+void perf_swevent_init_hrtimer(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
@@ -5705,6 +5707,7 @@ static void perf_swevent_init_hrtimer(st
 		event->attr.freq = 0;
 	}
 }
+EXPORT_SYMBOL_GPL(perf_swevent_init_hrtimer);
 
 /*
  * Software event: cpu wall time clock
@@ -6077,6 +6080,7 @@ free_pdc:
 	free_percpu(pmu->pmu_disable_count);
 	goto unlock;
 }
+EXPORT_SYMBOL_GPL(perf_pmu_register);
 
 void perf_pmu_unregister(struct pmu *pmu)
 {
@@ -6098,6 +6102,7 @@ void perf_pmu_unregister(struct pmu *pmu
 	put_device(pmu->dev);
 	free_pmu_context(pmu);
 }
+EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
 struct pmu *perf_init_event(struct perf_event *event)
 {

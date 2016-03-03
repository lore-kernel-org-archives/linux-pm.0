From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 17:28:29 +0100
Message-ID: <20160303162829.GB6375@twins.programming.kicks-ass.net>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAJZ5v0gC_S+a43FvgpB25WnpAANkDQk7agwSx4gRJvdmnPFkeQ@mail.gmail.com>
 <CAKfTPtDRvM9PAwQQ2KjUjPjnMmKkdi6sCoX4YisKaunDBqLf-A@mail.gmail.com>
 <20160303153817.GO6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:41730 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239AbcCCQ2f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Mar 2016 11:28:35 -0500
Content-Disposition: inline
In-Reply-To: <20160303153817.GO6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 03, 2016 at 04:38:17PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 03, 2016 at 03:01:15PM +0100, Vincent Guittot wrote:
> > > In case a more formal derivation of this formula is needed, it is
> > > based on the following 3 assumptions:
> > >
> > > (1) Performance is a linear function of frequency.
> > > (2) Required performance is a linear function of the utilization ratio
> > > x = util/max as provided by the scheduler (0 <= x <= 1).
> > 
> > Just to mention that the utilization that you are using, varies with
> > the frequency which add another variable in your equation
> 
> Right, x86 hasn't implemented arch_scale_freq_capacity(), so the
> utilization values we use are all over the map. If we lower freq, the
> util will go up, which would result in us bumping the freq again, etc..

Something like the completely untested below should maybe work.

Rafael?

---
 arch/x86/include/asm/topology.h | 19 +++++++++++++++++++
 arch/x86/kernel/smpboot.c       | 24 ++++++++++++++++++++++++
 kernel/sched/core.c             |  1 +
 kernel/sched/sched.h            |  7 +++++++
 4 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 7f991bd5031b..af7b7259db94 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -146,4 +146,23 @@ struct pci_bus;
 int x86_pci_root_bus_node(int bus);
 void x86_pci_root_bus_resources(int bus, struct list_head *resources);
 
+#ifdef CONFIG_SMP
+
+#define arch_scale_freq_tick arch_scale_freq_tick
+#define arch_scale_freq_capacity arch_scale_freq_capacity
+
+DECLARE_PER_CPU(unsigned long, arch_cpu_freq);
+
+static inline arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
+{
+	if (static_cpu_has(X86_FEATURE_APERFMPERF))
+		return per_cpu(arch_cpu_freq, cpu);
+	else
+		return SCHED_CAPACITY_SCALE;
+}
+
+extern void arch_scale_freq_tick(void);
+
+#endif
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3bf1e0b5f827..7d459577ee44 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1647,3 +1647,27 @@ void native_play_dead(void)
 }
 
 #endif
+
+static DEFINE_PER_CPU(u64, arch_prev_aperf);
+static DEFINE_PER_CPU(u64, arch_prev_mperf);
+DEFINE_PER_CPU(unsigned long, arch_cpu_freq);
+
+void arch_scale_freq_tick(void)
+{
+	u64 aperf, mperf;
+	u64 acnt, mcnt;
+
+	if (!static_cpu_has(X86_FEATURE_APERFMPERF))
+		return;
+
+	aperf = rdmsrl(MSR_IA32_APERF);
+	mperf = rdmsrl(MSR_IA32_APERF);
+
+	acnt = aperf - this_cpu_read(arch_prev_aperf);
+	mcnt = mperf - this_cpu_read(arch_prev_mperf);
+
+	this_cpu_write(arch_prev_aperf, aperf);
+	this_cpu_write(arch_prev_mperf, mperf);
+
+	this_cpu_write(arch_cpu_freq, div64_u64(acnt * SCHED_CAPACITY_SCALE, mcnt));
+}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96e323b26ea9..35dbf909afb2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2901,6 +2901,7 @@ void scheduler_tick(void)
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr = rq->curr;
 
+	arch_scale_freq_tick();
 	sched_clock_tick();
 
 	raw_spin_lock(&rq->lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index baa32075f98e..c3825c920e3f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1408,6 +1408,13 @@ unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
 }
 #endif
 
+#ifndef arch_scale_freq_tick
+static __always_inline
+void arch_scale_freq_tick(void)
+{
+}
+#endif
+
 #ifndef arch_scale_cpu_capacity
 static __always_inline
 unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)

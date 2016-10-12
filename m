From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v5 5/9] x86/sysctl: Add sysctl for ITMT scheduling feature
Date: Wed, 12 Oct 2016 09:50:42 -0700
Message-ID: <20161012165042.GA24463@linux.intel.com>
References: <1475322326-160112-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1475322326-160112-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <alpine.DEB.2.20.1610051624590.8953@nanos>
 <1475684673.3916.299.camel@linux.intel.com>
 <alpine.DEB.2.20.1610061307030.22338@nanos>
Reply-To: tim.c.chen@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24006 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755789AbcJLQxu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 12:53:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1610061307030.22338@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net, mingo@redhat.com, bp@suse.de, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, peterz@infradead.org, jolsa@redhat.com

On Thu, Oct 06, 2016 at 01:13:08PM +0200, Thomas Gleixner wrote:
> On Wed, 5 Oct 2016, Tim Chen wrote:
> > On Wed, 2016-10-05 at 16:35 +0200, Thomas Gleixner wrote:
> > > > +	if (itmt_supported) {
> > > > +		itmt_sysctl_header =
> > > > +			register_sysctl_table(itmt_root_table);
> > > > +		if (!itmt_sysctl_header) {
> > > > +			mutex_unlock(&itmt_update_mutex);
> > > > +			return;
> > > So you now have a state of capable which cannot be enabled. Whats the
> > > point?
> > 
> > For multi-socket system where ITMT is not enabled by default, the operator
> > can still decide to enable it via sysctl.
> 
> With a sysctl which failed to be installed. Good luck with that.
>  
> > > > +		}
> > > > +		/*
> > > > +		 * ITMT capability automatically enables ITMT
> > > > +		 * scheduling for small systems (single node).
> > > > +		 */
> > > > +		if (topology_num_packages() == 1)
> > > > +			sysctl_sched_itmt_enabled = 1;
> > > > +	} else {
> > > > +		if (itmt_sysctl_header)
> > > > +			unregister_sysctl_table(itmt_sysctl_header);
> > > > +	}
> > > > +
> > > > +	if (sysctl_sched_itmt_enabled) {
> > > > +		/* disable sched_itmt if we are no longer ITMT capable */
> > > > +		if (!itmt_supported)
> > > 
> > > How do you get here if itmt is not supported? 
> > 
> > If the OS decides to turn off ITMT for any reason, (i.e. invoke 
> > sched_set_itmt_support(false) after it has turned on itmt_support
> > before), this is the logic to do it.  We don't turn off ITMT support
> > after it has been turned on today, in the future the OS may.
> 
> Then please make this two functions (set/clear) so one can actually follow
> the logic. The above is just too convoluted.
> 

Thomas,

Will the update patch below address your concerns for this patch?
Please let us know if you have any other additional comments about
this series.  We'll like to address all of them before we post
an update to the series.

Thanks.

Tim

--->8---

From: Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 5/6 v5 - update proposal] x86/sysctl: Add sysctl for ITMT scheduling feature

Intel Turbo Boost Max Technology 3.0 (ITMT) feature
allows some cores to be boosted to higher turbo
frequency than others.

Add /proc/sys/kernel/sched_itmt_enabled so operator
can enable/disable scheduling of tasks that favor cores
with higher turbo boost frequency potential.

By default, system that is ITMT capable and single
socket has this feature turned on.  It is more likely
to be lightly loaded and operates in Turbo range.

When there is a change in the ITMT scheduling operation
desired, a rebuild of the sched domain is initiated
so the scheduler can set up sched domains with appropriate
flag to enable/disable ITMT scheduling operations.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 arch/x86/include/asm/topology.h |   2 +
 arch/x86/kernel/itmt.c          | 105 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1cd8d12..46ebdd1 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -155,6 +155,7 @@ extern bool x86_topology_update;
 #include <asm/percpu.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
+extern unsigned int __read_mostly sysctl_sched_itmt_enabled;
 
 /* Interface to set priority of a cpu */
 void sched_set_itmt_core_prio(int prio, int core_cpu);
@@ -167,6 +168,7 @@ void sched_clear_itmt_support(void);
 
 #else /* CONFIG_SCHED_ITMT */
 
+#define sysctl_sched_itmt_enabled	0
 static inline void sched_set_itmt_core_prio(int prio, int core_cpu)
 {
 }
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index 4be3d81..b104368 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -34,6 +34,67 @@ DEFINE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
 /* Boolean to track if system has ITMT capabilities */
 static bool __read_mostly sched_itmt_capable;
 
+/*
+ * Boolean to control whether we want to move processes to cpu capable
+ * of higher turbo frequency for cpus supporting Intel Turbo Boost Max
+ * Technology 3.0.
+ *
+ * It can be set via /proc/sys/kernel/sched_itmt_enabled
+ */
+unsigned int __read_mostly sysctl_sched_itmt_enabled;
+
+static int sched_itmt_update_handler(struct ctl_table *table, int write,
+			      void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+	unsigned int old_sysctl;
+
+	mutex_lock(&itmt_update_mutex);
+
+	if (!sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return -EINVAL;
+	}
+
+	old_sysctl = sysctl_sched_itmt_enabled;
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (!ret && write && old_sysctl != sysctl_sched_itmt_enabled) {
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
+	mutex_unlock(&itmt_update_mutex);
+
+	return ret;
+}
+
+static unsigned int zero;
+static unsigned int one = 1;
+static struct ctl_table itmt_kern_table[] = {
+	{
+		.procname	= "sched_itmt_enabled",
+		.data		= &sysctl_sched_itmt_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_itmt_update_handler,
+		.extra1		= &zero,
+		.extra2		= &one,
+	},
+	{}
+};
+
+static struct ctl_table itmt_root_table[] = {
+	{
+		.procname	= "kernel",
+		.mode		= 0555,
+		.child		= itmt_kern_table,
+	},
+	{}
+};
+
+static struct ctl_table_header *itmt_sysctl_header;
+
 /**
  * sched_set_itmt_support - Indicate platform supports ITMT
  *
@@ -47,13 +108,40 @@ static bool __read_mostly sched_itmt_capable;
  *
  * This must be done only after sched_set_itmt_core_prio
  * has been called to set the cpus' priorities.
+ *
+ * It must not be called with cpu hot plug lock
+ * held as we need to acquire the lock to rebuild sched domains
+ * later.
  */
 int sched_set_itmt_support(void)
 {
 	mutex_lock(&itmt_update_mutex);
 
+	if (sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return 0;
+	}
+
+	itmt_sysctl_header = register_sysctl_table(itmt_root_table);
+	if (!itmt_sysctl_header) {
+		mutex_unlock(&itmt_update_mutex);
+		return -ENOMEM;
+	}
+
 	sched_itmt_capable = true;
 
+	/*
+	 * ITMT capability automatically enables ITMT
+	 * scheduling for small systems (single node).
+	 */
+	if (topology_num_packages() == 1)
+		sysctl_sched_itmt_enabled = 1;
+
+	if (sysctl_sched_itmt_enabled) {
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
 	mutex_unlock(&itmt_update_mutex);
 	return 0;
 }
@@ -64,13 +152,30 @@ int sched_set_itmt_support(void)
  * This function is used by the OS to indicate that it has
  * revoked the platform's support of ITMT feature.
  *
+ * It must not be called with cpu hot plug lock
+ * held as we need to acquire the lock to rebuild sched domains
+ * later.
  */
 void sched_clear_itmt_support(void)
 {
 	mutex_lock(&itmt_update_mutex);
 
+	if (!sched_itmt_capable) {
+		mutex_unlock(&itmt_update_mutex);
+		return;
+	}
 	sched_itmt_capable = false;
 
+	if (itmt_sysctl_header)
+		unregister_sysctl_table(itmt_sysctl_header);
+
+	if (sysctl_sched_itmt_enabled) {
+		/* disable sched_itmt if we are no longer ITMT capable */
+		sysctl_sched_itmt_enabled = 0;
+		x86_topology_update = true;
+		rebuild_sched_domains();
+	}
+
 	mutex_unlock(&itmt_update_mutex);
 }
 
-- 
2.5.5


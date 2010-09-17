From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Fri, 17 Sep 2010 23:58:17 +0200
Message-ID: <201009172358.18652.trenn__44499.5945123539$1284760815$gmane$org@suse.de>
References: <AANLkTinUmbSUUuxUzc8++pcb9gd1CZFdyTQFrveTBXyV@mail.gmail.com>
	<201009171508.46471.trenn@suse.de>
	<AANLkTi=W_Lo2m=hkA2F48oUziqGzt4Tr8y6KhfgqRnbz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=W_Lo2m=hkA2F48oUziqGzt4Tr8y6KhfgqRnbz@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Len Brown <len.brown@intel.com>, linux-trace-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, discuss@lesswatts.org, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@lists.linux-foundation.org, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Some patches for cleanup...
compile tested only...
Should not break existing user space apps, but they should
get converted asap to use power_swtich_state...

---

power-trace: Rename power frequency to power_switch_state

this interface/function is not intended for frequency changes
only, but should get used for any P- (processor frequency),
C- (processor sleep), T- (processor throttling), or S- (machine sleep)
state.

Since it's used in cpufreq.c which must be compiled in
and not in acpi-cpufreq.c anymore there is no need to export it
for modules.

Signed-off-by: Thomas Renninger <trenn@suse.de>

---
 drivers/cpufreq/cpufreq.c    |    1 +
 include/trace/events/power.h |    7 +++++++
 kernel/trace/power-traces.c  |    1 -
 3 files changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.35-master/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.35-master.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.35-master/drivers/cpufreq/cpufreq.c
@@ -354,6 +354,7 @@ void cpufreq_notify_transition(struct cp
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		dprintk("FREQ: %lu - CPU: %lu", (unsigned long)freqs->new,
 			(unsigned long)freqs->cpu);
+		trace_power_switch_state(POWER_PSTATE, freqs->new, freqs->cpu);
 		trace_power_frequency(POWER_PSTATE, freqs->new, freqs->cpu);
 		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_POSTCHANGE, freqs);
Index: linux-2.6.35-master/include/trace/events/power.h
===================================================================
--- linux-2.6.35-master.orig/include/trace/events/power.h
+++ linux-2.6.35-master/include/trace/events/power.h
@@ -38,6 +38,13 @@ DECLARE_EVENT_CLASS(power,
 		(unsigned long)__entry->state, (unsigned long)__entry->cpu_id)
 );
 
+DEFINE_EVENT(power, power_switch_state,
+
+	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
+
+	TP_ARGS(type, state, cpu_id)
+);
+
 DEFINE_EVENT(power, power_start,
 
 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
Index: linux-2.6.35-master/kernel/trace/power-traces.c
===================================================================
--- linux-2.6.35-master.orig/kernel/trace/power-traces.c
+++ linux-2.6.35-master/kernel/trace/power-traces.c
@@ -13,5 +13,4 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/power.h>
 
-EXPORT_TRACEPOINT_SYMBOL_GPL(power_frequency);
 

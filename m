From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] tracing, perf: add more power related events
Date: Sat, 18 Sep 2010 00:17:03 +0200
Message-ID: <201009180017.03821.trenn__6060.86951816014$1284761892$gmane$org@suse.de>
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

DO NOT APPLY THIS ONE!!!
	
The others should go into a mainline tree if Jean is ok with them.

This one does not work, due to some include dependencies or whatever
else I can't see right now.

The idea: Provide old trace power interfaces via .config option to not break
existing perf/powertop/.. binaries.
Not sure whether it's worth looking at it further. It shouldn't be needed...

       Thomas

---
 include/trace/events/power.h |   11 +++++++++++
 kernel/trace/Kconfig         |    4 ++++
 2 files changed, 15 insertions(+)

Index: linux-2.6.35-master/kernel/trace/Kconfig
===================================================================
--- linux-2.6.35-master.orig/kernel/trace/Kconfig
+++ linux-2.6.35-master/kernel/trace/Kconfig
@@ -64,6 +64,10 @@ config EVENT_TRACING
 	select CONTEXT_SWITCH_TRACER
 	bool
 
+config DEPRECATED_POWER_EVENT_TRACING
+       bool
+       default n
+
 config CONTEXT_SWITCH_TRACER
 	bool
 
Index: linux-2.6.35-master/include/trace/events/power.h
===================================================================
--- linux-2.6.35-master.orig/include/trace/events/power.h
+++ linux-2.6.35-master/include/trace/events/power.h
@@ -50,6 +50,7 @@ DEFINE_EVENT(power, power_switch_state,
 	TP_ARGS(type, state, cpu_id)
 );
 
+#ifdef CONFIG_DEPRECATED_POWER_EVENT_TRACING
 DEFINE_EVENT(power, power_start,
 
 	TP_PROTO(unsigned int type, unsigned int state, unsigned int cpu_id),
@@ -81,6 +82,16 @@ TRACE_EVENT(power_end,
 	TP_printk("cpu_id=%lu", (unsigned long)__entry->cpu_id)
 
 );
+#else
+inline void trace_power_end(unsigned int cpu_id)
+{}
+inline void trace_power_start(unsigned int type, unsigned int state,
+			      unsigned int cpu_id)
+{}
+inline void trace_power_frequency(unsigned int type, unsigned int state,
+				  unsigned int cpu_id)
+{}
+#endif
 
 /*
  * The clock events are used for clock enable/disable and for

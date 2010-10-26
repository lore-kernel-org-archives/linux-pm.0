From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH] PERF(kernel): Cleanup power events V2
Date: Tue, 26 Oct 2010 10:32:44 -0500
Message-ID: <AANLkTikWCLTgAGJJ_eH0e016kPfB2K8LtR9g25wbPJXF__45734.7169555307$1288107291$gmane$org@mail.gmail.com>
References: <1287488171-25303-3-git-send-email-trenn@suse.de>
	<1288049630-10947-1-git-send-email-trenn@suse.de>
	<20101026071020.GC13036@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101026071020.GC13036@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-trace-users@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Jean Pihet <jean.pihet@newoldbits.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Frank Eigler <fche@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 26, 2010 at 2:10 AM, Ingo Molnar <mingo@elte.hu> wrote:

> How will future PCI (or other device) power saving tracepoints be called?
>
> Might be more consistent to use:
>
> =A0power:cpu_idle
> =A0power:machine_idle
> =A0power:device_idle
Agree with this.

FYI, I have a runtime_pm tracepoint currently cooking. Here is
preliminary patch.
Can this be a candidate for a "power:device_idle" tracepoint?

Regards,
Pierre
----
>From 3d5e03405f590d470ecfa59c8b9759915bf29307 Mon Sep 17 00:00:00 2001
From: Pierre Tardy <pierre.tardy@intel.com>
Date: Fri, 22 Oct 2010 03:07:07 -0500
Subject: [PATCH] trace/runtime_pm: add runtime_pm trace event

based on the recent hook from Arjan for powertop statistics
we add a tracepoint in order for pytimechart to display
the runtime_pm activity over time, and versus other events.

Signed-off-by: Pierre Tardy <pierre.tardy@intel.com>
---
 drivers/base/power/runtime.c |    3 ++-
 include/trace/events/power.h |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index b78c401..0f38447 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/pm_runtime.h>
 #include <linux/jiffies.h>
+#include <trace/events/power.h>

 static int __pm_runtime_resume(struct device *dev, bool from_wq);
 static int __pm_request_idle(struct device *dev);
@@ -159,9 +160,9 @@ void update_pm_runtime_accounting(struct device *dev)
 static void __update_runtime_status(struct device *dev, enum rpm_status st=
atus)
 {
 	update_pm_runtime_accounting(dev);
+	trace_runtime_pm_status(dev, status);
 	dev->power.runtime_status =3D status;
 }
-
 /**
  * __pm_runtime_suspend - Carry out run-time suspend of given device.
  * @dev: Device to suspend.
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 286784d..dd57c29 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -6,6 +6,7 @@

 #include <linux/ktime.h>
 #include <linux/tracepoint.h>
+#include <linux/device.h>

 #ifndef _TRACE_POWER_ENUM_
 #define _TRACE_POWER_ENUM_
@@ -75,6 +76,40 @@ TRACE_EVENT(power_end,

 );

+#ifdef CONFIG_PM_RUNTIME
+#define rpm_status_name(status) { RPM_##status, #status }
+#define show_rpm_status_name(val)				\
+	__print_symbolic(val,					\
+		rpm_status_name(SUSPENDED),			\
+		rpm_status_name(SUSPENDING),			\
+		rpm_status_name(RESUMING),			\
+		rpm_status_name(ACTIVE)		                \
+		)
+TRACE_EVENT(runtime_pm_status,
+
+	TP_PROTO(struct device *dev, int new_status),
+
+	TP_ARGS(dev, new_status),
+
+	TP_STRUCT__entry(
+		__string(devname,dev_name(dev))
+		__string(drivername,dev_driver_string(dev))
+		__field(u32, prev_status)
+		__field(u32, status)
+	),
+
+	TP_fast_assign(
+		__assign_str(devname, dev_name(dev));
+		__assign_str(drivername, dev_driver_string(dev));
+		__entry->prev_status =3D (u32)dev->power.runtime_status;
+		__entry->status =3D (u32)new_status;
+	),
+
+	TP_printk("driver=3D%s dev=3D%s prev_status=3D%s status=3D%s",
__get_str(drivername),__get_str(devname),
+		  show_rpm_status_name(__entry->prev_status),
show_rpm_status_name(__entry->status))
+);
+#endif /* CONFIG_PM_RUNTIME */
+
 /*
  * The clock events are used for clock enable/disable and for
  *  clock rate change
-- =

1.7.2.3

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 23:20:59 +0200
Message-ID: <4080948.V5DMHR9bsk@vostro.rjw.lan>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com> <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58839 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751560AbcETVRZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 17:17:25 -0400
In-Reply-To: <CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>

On Friday, May 20, 2016 03:32:43 PM Fabio Estevam wrote:
> On Fri, May 20, 2016 at 3:05 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > Rafael,
> >
> > Running the 'reboot' command works fine on a 4.5 kernel running on a
> > mx6ul platform (ARM single core SoC), but it crashes on 4.6.
> >
> > Running bisect I got 9be4fd2c7723a3057b0b39676 ("cpufreq: governor:
> > Replace timers with utilization update callbacks") as the first bad
> > commit.
> >
> > Below is the output crash log.
> >
> > Not sure if this issue is related to the problem reported by Guenter here:
> > http://lkml.iu.edu/hypermail/linux/kernel/1602.1/06075.html
> >
> > Any ideas?
> 
> If I rebuilt a kernel with SMP=n then the reboot command works as expected.

Does it work if you boot with maxcpus=1 or nosmp in the kernel command line?

Also, please try if the appended patch makes any difference.

---
 drivers/base/core.c       |    3 +++
 drivers/cpufreq/cpufreq.c |   11 -----------
 2 files changed, 3 insertions(+), 11 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -27,7 +27,6 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/syscore_ops.h>
 #include <linux/tick.h>
 #include <trace/events/power.h>
 
@@ -2556,14 +2555,6 @@ int cpufreq_unregister_driver(struct cpu
 }
 EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
 
-/*
- * Stop cpufreq at shutdown to make sure it isn't holding any locks
- * or mutexes when secondary CPUs are halted.
- */
-static struct syscore_ops cpufreq_syscore_ops = {
-	.shutdown = cpufreq_suspend,
-};
-
 struct kobject *cpufreq_global_kobject;
 EXPORT_SYMBOL(cpufreq_global_kobject);
 
@@ -2575,8 +2566,6 @@ static int __init cpufreq_core_init(void
 	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
 	BUG_ON(!cpufreq_global_kobject);
 
-	register_syscore_ops(&cpufreq_syscore_ops);
-
 	return 0;
 }
 core_initcall(cpufreq_core_init);
Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode.h>
@@ -2042,6 +2043,8 @@ void device_shutdown(void)
 {
 	struct device *dev, *parent;
 
+	cpufreq_suspend();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.


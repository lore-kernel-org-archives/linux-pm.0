From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: Add cpuidle.governor= command line parameter
Date: Wed, 05 Dec 2018 23:45:34 +0100
Message-ID: <1752296.bicKxrytZO@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add cpuidle.governor= command line parameter to allow the default
cpuidle governor to be replaced.

That is useful, for example, if someone running a tickful kernel
wants to use the menu governor on it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/10714995/ and
https://patchwork.kernel.org/patch/10705317/

---
 Documentation/admin-guide/kernel-parameters.txt |    3 +++
 Documentation/admin-guide/pm/cpuidle.rst        |    7 +++++++
 drivers/cpuidle/cpuidle.c                       |    1 +
 drivers/cpuidle/cpuidle.h                       |    1 +
 drivers/cpuidle/governor.c                      |    9 +++++++--
 5 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpuidle/governor.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governor.c
+++ linux-pm/drivers/cpuidle/governor.c
@@ -11,10 +11,13 @@
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/mutex.h>
+#include <linux/module.h>
 #include <linux/pm_qos.h>
 
 #include "cpuidle.h"
 
+char param_governor[CPUIDLE_NAME_LEN];
+
 LIST_HEAD(cpuidle_governors);
 struct cpuidle_governor *cpuidle_curr_governor;
 
@@ -86,9 +89,11 @@ int cpuidle_register_governor(struct cpu
 	mutex_lock(&cpuidle_lock);
 	if (__cpuidle_find_governor(gov->name) == NULL) {
 		ret = 0;
-		list_add_tail(&gov->governor_list, &cpuidle_governors);
 		if (!cpuidle_curr_governor ||
-		    cpuidle_curr_governor->rating < gov->rating)
+		    !strncasecmp(param_governor, gov->name, CPUIDLE_NAME_LEN) ||
+		    (cpuidle_curr_governor->rating < gov->rating &&
+		     strncasecmp(param_governor, cpuidle_curr_governor->name,
+				 CPUIDLE_NAME_LEN)))
 			cpuidle_switch_governor(gov);
 	}
 	mutex_unlock(&cpuidle_lock);
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -731,4 +731,5 @@ static int __init cpuidle_init(void)
 }
 
 module_param(off, int, 0444);
+module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
 core_initcall(cpuidle_init);
Index: linux-pm/drivers/cpuidle/cpuidle.h
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.h
+++ linux-pm/drivers/cpuidle/cpuidle.h
@@ -7,6 +7,7 @@
 #define __DRIVER_CPUIDLE_H
 
 /* For internal use only */
+extern char param_governor[];
 extern struct cpuidle_governor *cpuidle_curr_governor;
 extern struct list_head cpuidle_governors;
 extern struct list_head cpuidle_detected_devices;
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -576,6 +576,13 @@ processors implementing the architecture
 however, so it is rather crude and not very energy-efficient.  For this reason,
 it is not recommended for production use.
 
+The ``cpuidle.governor=`` kernel command line switch allows the ``CPUIdle``
+governor to use to be specified.  It has to be appended with a string matching
+the name of an available governor (e.g. ``cpuidle.governor=menu``) and that
+governor will be used instead of the default one.  It is possible to force
+the ``menu`` governor to be used on the systems that use the ``ladder`` governor
+by default this way, for example.
+
 The other kernel command line parameters controlling CPU idle time management
 described below are only relevant for the *x86* architecture and some of
 them affect Intel processors only.
Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -674,6 +674,9 @@
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
+	cpuidle.governor=
+			[CPU_IDLE] Name of the cpuidle governor to use.
+
 	cpufreq.off=1	[CPU_FREQ]
 			disable the cpufreq sub-system
 

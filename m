From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: intel_pstate: Do not include debugfs.h
Date: Fri, 30 Mar 2018 11:52:19 +0200
Message-ID: <1679361.0Gr8UWkMAK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The intel_pstate driver doesn't use debugfs any more, so drop
linux/debugfs.h from the list of included headers in it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -26,7 +26,6 @@
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/fs.h>
-#include <linux/debugfs.h>
 #include <linux/acpi.h>
 #include <linux/vmalloc.h>
 #include <trace/events/power.h>

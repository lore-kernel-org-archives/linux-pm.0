From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] Documentation: admin-guide: intel_pstate: Fix sysfs path
Date: Tue, 26 Jun 2018 12:09:51 +0200
Message-ID: <2419155.1rRbCxiQ6f@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Pawit Pornkitprasan <p.pawit@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Fix an incorrect sysfs path in the intel_pstate admin-guide
documentation.

Fixes: 33fc30b47098 (cpufreq: intel_pstate: Document the current behavior and user interface)
Reported-by: Pawit Pornkitprasan <p.pawit@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -324,8 +324,7 @@ Global Attributes
 
 ``intel_pstate`` exposes several global attributes (files) in ``sysfs`` to
 control its functionality at the system level.  They are located in the
-``/sys/devices/system/cpu/cpufreq/intel_pstate/`` directory and affect all
-CPUs.
+``/sys/devices/system/cpu/intel_pstate/`` directory and affect all CPUs.
 
 Some of them are not present if the ``intel_pstate=per_cpu_perf_limits``
 argument is passed to the kernel in the command line.

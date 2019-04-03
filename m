From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/4] Documentation: PM: Unify copyright notices
Date: Thu, 04 Apr 2019 00:06:15 +0200
Message-ID: <4546107.BrAdpSWmVg@aspire.rjw.lan>
References: <4546107.fVFrecLk33@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4546107.fVFrecLk33@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Unify copyright notices in the .rst files under
Documentation/driver-api/pm and Documentation/admin-quide/pm.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq.rst      |    6 ++++--
 Documentation/admin-guide/pm/cpuidle.rst      |    6 ++++--
 Documentation/admin-guide/pm/intel_pstate.rst |    5 +++--
 Documentation/admin-guide/pm/sleep-states.rst |    6 ++++--
 Documentation/admin-guide/pm/strategies.rst   |    6 ++++--
 Documentation/driver-api/pm/cpuidle.rst       |    5 +++--
 Documentation/driver-api/pm/devices.rst       |   10 ++++++----
 Documentation/driver-api/pm/notifiers.rst     |    6 ++++--
 8 files changed, 32 insertions(+), 18 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 .. |struct cpufreq_policy| replace:: :c:type:`struct cpufreq_policy <cpufreq_policy>`
 .. |intel_pstate| replace:: :doc:`intel_pstate <intel_pstate>`
@@ -7,9 +8,10 @@
 CPU Performance Scaling
 =======================
 
-::
+:Copyright: |copy| 2017 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
- Copyright (c) 2017 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 The Concept of CPU Performance Scaling
 ======================================
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 .. |struct cpuidle_state| replace:: :c:type:`struct cpuidle_state <cpuidle_state>`
 .. |cpufreq| replace:: :doc:`CPU Performance Scaling <cpufreq>`
@@ -7,9 +8,10 @@
 CPU Idle Time Management
 ========================
 
-::
+:Copyright: |copy| 2018 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
- Copyright (c) 2018 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 Concepts
 ========
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -1,12 +1,13 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 ===============================================
 ``intel_pstate`` CPU Performance Scaling Driver
 ===============================================
 
-::
+:Copyright: |copy| 2017 Intel Corporation
 
- Copyright (c) 2017 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 
 General Information
Index: linux-pm/Documentation/admin-guide/pm/strategies.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/strategies.rst
+++ linux-pm/Documentation/admin-guide/pm/strategies.rst
@@ -1,12 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 ===========================
 Power Management Strategies
 ===========================
 
-::
+:Copyright: |copy| 2017 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
- Copyright (c) 2017 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 The Linux kernel supports two major high-level power management strategies.
 
Index: linux-pm/Documentation/driver-api/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/cpuidle.rst
+++ linux-pm/Documentation/driver-api/pm/cpuidle.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 .. |struct cpuidle_governor| replace:: :c:type:`struct cpuidle_governor <cpuidle_governor>`
 .. |struct cpuidle_device| replace:: :c:type:`struct cpuidle_device <cpuidle_device>`
@@ -9,9 +10,9 @@
 CPU Idle Time Management
 ========================
 
-::
+:Copyright: |copy| 2019 Intel Corporation
 
- Copyright (c) 2019 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 
 CPU Idle Time Management Subsystem
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -1,4 +1,5 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 .. |struct dev_pm_ops| replace:: :c:type:`struct dev_pm_ops <dev_pm_ops>`
 .. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
@@ -14,11 +15,12 @@
 Device Power Management Basics
 ==============================
 
-::
+:Copyright: |copy| 2010-2011 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+:Copyright: |copy| 2010 Alan Stern <stern@rowland.harvard.edu>
+:Copyright: |copy| 2016 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
- Copyright (c) 2010-2011 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
- Copyright (c) 2010 Alan Stern <stern@rowland.harvard.edu>
- Copyright (c) 2016 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 Most of the code in Linux is device drivers, so most of the Linux power
 management (PM) code is also driver-specific.  Most drivers will do very
Index: linux-pm/Documentation/driver-api/pm/notifiers.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/notifiers.rst
+++ linux-pm/Documentation/driver-api/pm/notifiers.rst
@@ -1,12 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 =============================
 Suspend/Hibernation Notifiers
 =============================
 
-::
+:Copyright: |copy| 2016 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
- Copyright (c) 2016 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 There are some operations that subsystems or drivers may want to carry out
 before hibernation/suspend or after restore/resume, but they require the system
Index: linux-pm/Documentation/admin-guide/pm/sleep-states.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/sleep-states.rst
+++ linux-pm/Documentation/admin-guide/pm/sleep-states.rst
@@ -1,12 +1,14 @@
 .. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
 ===================
 System Sleep States
 ===================
 
-::
+:Copyright: |copy| 2017 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
- Copyright (c) 2017 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
 
 Sleep states are global low-power states of the entire system in which user
 space code cannot be executed and the overall system activity is significantly

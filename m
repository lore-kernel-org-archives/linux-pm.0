From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] Documentation: PM: Add SPDX license tags to multiple files
Date: Thu, 04 Apr 2019 00:04:43 +0200
Message-ID: <30491576.jJB0AOblsF@aspire.rjw.lan>
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

Add SPDX license tags to .rst files under Documentation/driver-api/pm
and Documentation/admin-quide/pm.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq.rst       |    2 ++
 Documentation/admin-guide/pm/cpuidle.rst       |    2 ++
 Documentation/admin-guide/pm/index.rst         |    2 ++
 Documentation/admin-guide/pm/intel_pstate.rst  |    2 ++
 Documentation/admin-guide/pm/sleep-states.rst  |    2 ++
 Documentation/admin-guide/pm/strategies.rst    |    2 ++
 Documentation/admin-guide/pm/system-wide.rst   |    2 ++
 Documentation/admin-guide/pm/working-state.rst |    2 ++
 Documentation/driver-api/pm/cpuidle.rst        |    2 ++
 Documentation/driver-api/pm/devices.rst        |    2 ++
 Documentation/driver-api/pm/index.rst          |    2 ++
 Documentation/driver-api/pm/notifiers.rst      |    2 ++
 Documentation/driver-api/pm/types.rst          |    2 ++
 13 files changed, 26 insertions(+)

Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct cpufreq_policy| replace:: :c:type:`struct cpufreq_policy <cpufreq_policy>`
 .. |intel_pstate| replace:: :doc:`intel_pstate <intel_pstate>`
 
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct cpuidle_state| replace:: :c:type:`struct cpuidle_state <cpuidle_state>`
 .. |cpufreq| replace:: :doc:`CPU Performance Scaling <cpufreq>`
 
Index: linux-pm/Documentation/admin-guide/pm/index.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/index.rst
+++ linux-pm/Documentation/admin-guide/pm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ================
 Power Management
 ================
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============================================
 ``intel_pstate`` CPU Performance Scaling Driver
 ===============================================
Index: linux-pm/Documentation/admin-guide/pm/sleep-states.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/sleep-states.rst
+++ linux-pm/Documentation/admin-guide/pm/sleep-states.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 System Sleep States
 ===================
Index: linux-pm/Documentation/admin-guide/pm/strategies.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/strategies.rst
+++ linux-pm/Documentation/admin-guide/pm/strategies.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 Power Management Strategies
 ===========================
Index: linux-pm/Documentation/admin-guide/pm/system-wide.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/system-wide.rst
+++ linux-pm/Documentation/admin-guide/pm/system-wide.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ============================
 System-Wide Power Management
 ============================
Index: linux-pm/Documentation/admin-guide/pm/working-state.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/working-state.rst
+++ linux-pm/Documentation/admin-guide/pm/working-state.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 Working-State Power Management
 ==============================
Index: linux-pm/Documentation/driver-api/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/cpuidle.rst
+++ linux-pm/Documentation/driver-api/pm/cpuidle.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct cpuidle_governor| replace:: :c:type:`struct cpuidle_governor <cpuidle_governor>`
 .. |struct cpuidle_device| replace:: :c:type:`struct cpuidle_device <cpuidle_device>`
 .. |struct cpuidle_driver| replace:: :c:type:`struct cpuidle_driver <cpuidle_driver>`
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct dev_pm_ops| replace:: :c:type:`struct dev_pm_ops <dev_pm_ops>`
 .. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
 .. |struct bus_type| replace:: :c:type:`struct bus_type <bus_type>`
Index: linux-pm/Documentation/driver-api/pm/index.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/index.rst
+++ linux-pm/Documentation/driver-api/pm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============================
 CPU and Device Power Management
 ===============================
Index: linux-pm/Documentation/driver-api/pm/notifiers.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/notifiers.rst
+++ linux-pm/Documentation/driver-api/pm/notifiers.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =============================
 Suspend/Hibernation Notifiers
 =============================
Index: linux-pm/Documentation/driver-api/pm/types.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/types.rst
+++ linux-pm/Documentation/driver-api/pm/types.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==================================
 Device Power Management Data Types
 ==================================

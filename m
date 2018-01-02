From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpu_cooling: Remove static-power related documentation
Date: Tue,  2 Jan 2018 10:51:34 +0530
Message-ID: <09947bfdaf86f674f8495849b88118065841a4f2.1514870425.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34641 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeABFV6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 00:21:58 -0500
Received: by mail-pf0-f193.google.com with SMTP id a90so25286431pfk.1
        for <linux-pm@vger.kernel.org>; Mon, 01 Jan 2018 21:21:58 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

commit 84fe2cab4859 ("cpu_cooling: Drop static-power related stuff")
removed support for static-power in kernel, but it missed reflecting the
same in documentation. Remove the static power related documentation
bits as well.

Reported-by: Javi Merino <javi.merino@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/thermal/cpu-cooling-api.txt | 82 +------------------------------
 1 file changed, 2 insertions(+), 80 deletions(-)

diff --git a/Documentation/thermal/cpu-cooling-api.txt b/Documentation/thermal/cpu-cooling-api.txt
index 7a1c89db0419..7df567eaea1a 100644
--- a/Documentation/thermal/cpu-cooling-api.txt
+++ b/Documentation/thermal/cpu-cooling-api.txt
@@ -44,16 +44,14 @@ the user. The registration APIs returns the cooling device pointer.
 2. Power models
 
 The power API registration functions provide a simple power model for
-CPUs.  The current power is calculated as dynamic + (optionally)
-static power.  This power model requires that the operating-points of
+CPUs.  The current power is calculated as dynamic power (static power isn't
+supported currently).  This power model requires that the operating-points of
 the CPUs are registered using the kernel's opp library and the
 `cpufreq_frequency_table` is assigned to the `struct device` of the
 cpu.  If you are using CONFIG_CPUFREQ_DT then the
 `cpufreq_frequency_table` should already be assigned to the cpu
 device.
 
-2.1 Dynamic power
-
 The dynamic power consumption of a processor depends on many factors.
 For a given processor implementation the primary factors are:
 
@@ -92,79 +90,3 @@ mW/MHz/uVolt^2.  Typical values for mobile CPUs might lie in range
 from 100 to 500.  For reference, the approximate values for the SoC in
 ARM's Juno Development Platform are 530 for the Cortex-A57 cluster and
 140 for the Cortex-A53 cluster.
-
-
-2.2 Static power
-
-Static leakage power consumption depends on a number of factors.  For a
-given circuit implementation the primary factors are:
-
-- Time the circuit spends in each 'power state'
-- Temperature
-- Operating voltage
-- Process grade
-
-The time the circuit spends in each 'power state' for a given
-evaluation period at first order means OFF or ON.  However,
-'retention' states can also be supported that reduce power during
-inactive periods without loss of context.
-
-Note: The visibility of state entries to the OS can vary, according to
-platform specifics, and this can then impact the accuracy of a model
-based on OS state information alone.  It might be possible in some
-cases to extract more accurate information from system resources.
-
-The temperature, operating voltage and process 'grade' (slow to fast)
-of the circuit are all significant factors in static leakage power
-consumption.  All of these have complex relationships to static power.
-
-Circuit implementation specific factors include the chosen silicon
-process as well as the type, number and size of transistors in both
-the logic gates and any RAM elements included.
-
-The static power consumption modelling must take into account the
-power managed regions that are implemented.  Taking the example of an
-ARM processor cluster, the modelling would take into account whether
-each CPU can be powered OFF separately or if only a single power
-region is implemented for the complete cluster.
-
-In one view, there are others, a static power consumption model can
-then start from a set of reference values for each power managed
-region (e.g. CPU, Cluster/L2) in each state (e.g. ON, OFF) at an
-arbitrary process grade, voltage and temperature point.  These values
-are then scaled for all of the following: the time in each state, the
-process grade, the current temperature and the operating voltage.
-However, since both implementation specific and complex relationships
-dominate the estimate, the appropriate interface to the model from the
-cpu cooling device is to provide a function callback that calculates
-the static power in this platform.  When registering the cpu cooling
-device pass a function pointer that follows the `get_static_t`
-prototype:
-
-    int plat_get_static(cpumask_t *cpumask, int interval,
-                        unsigned long voltage, u32 &power);
-
-`cpumask` is the cpumask of the cpus involved in the calculation.
-`voltage` is the voltage at which they are operating.  The function
-should calculate the average static power for the last `interval`
-milliseconds.  It returns 0 on success, -E* on error.  If it
-succeeds, it should store the static power in `power`.  Reading the
-temperature of the cpus described by `cpumask` is left for
-plat_get_static() to do as the platform knows best which thermal
-sensor is closest to the cpu.
-
-If `plat_static_func` is NULL, static power is considered to be
-negligible for this platform and only dynamic power is considered.
-
-The platform specific callback can then use any combination of tables
-and/or equations to permute the estimated value.  Process grade
-information is not passed to the model since access to such data, from
-on-chip measurement capability or manufacture time data, is platform
-specific.
-
-Note: the significance of static power for CPUs in comparison to
-dynamic power is highly dependent on implementation.  Given the
-potential complexity in implementation, the importance and accuracy of
-its inclusion when using cpu cooling devices should be assessed on a
-case by case basis.
-
-- 
2.15.0.194.g9af6a3dea062

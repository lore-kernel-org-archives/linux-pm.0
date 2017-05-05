From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Resend][PATCH] cpufreq: intel_pstate: Document the current behavior and user interface
Date: Fri, 05 May 2017 23:38:42 +0200
Message-ID: <1740586.nd9tWxCWqD@aspire.rjw.lan>
References: <2025489.DxMTzKos7o@aspire.rjw.lan> <2495384.H9v0BLlUnK@aspire.rjw.lan> <4096353.uPKQmKGfWK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4096353.uPKQmKGfWK@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a document describing the current behavior and user space
interface of the intel_pstate driver in the RST format and
drop the existing outdated intel_pstate.txt document.

Also update admin-guide/pm/cpufreq.rst with proper RST references
to the new intel_pstate.rst document.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Hi Jon,

All of the dependencies for this patch have been merged, so I can route it
through the PM tree.

Please let me know if you prefer to take it into the documentation tree instead.

Thanks,
Rafael


---
 Documentation/admin-guide/pm/cpufreq.rst      |   19 
 Documentation/admin-guide/pm/index.rst        |    1 
 Documentation/admin-guide/pm/intel_pstate.rst |  755 ++++++++++++++++++++++++++
 Documentation/cpu-freq/intel-pstate.txt       |  281 ---------
 4 files changed, 766 insertions(+), 290 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/index.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/index.rst
+++ linux-pm/Documentation/admin-guide/pm/index.rst
@@ -6,6 +6,7 @@ Power Management
    :maxdepth: 2
 
    cpufreq
+   intel_pstate
 
 .. only::  subproject and html
 
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- /dev/null
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -0,0 +1,755 @@
+===============================================
+``intel_pstate`` CPU Performance Scaling Driver
+===============================================
+
+::
+
+ Copyright (c) 2017 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+
+
+General Information
+===================
+
+``intel_pstate`` is a part of the
+:doc:`CPU performance scaling subsystem <cpufreq>` in the Linux kernel
+(``CPUFreq``).  It is a scaling driver for the Sandy Bridge and later
+generations of Intel processors.  Note, however, that some of those processors
+may not be supported.  [To understand ``intel_pstate`` it is necessary to know
+how ``CPUFreq`` works in general, so this is the time to read :doc:`cpufreq` if
+you have not done that yet.]
+
+For the processors supported by ``intel_pstate``, the P-state concept is broader
+than just an operating frequency or an operating performance point (see the
+`LinuxCon Europe 2015 presentation by Kristen Accardi <LCEU2015_>`_ for more
+information about that).  For this reason, the representation of P-states used
+by ``intel_pstate`` internally follows the hardware specification (for details
+refer to `Intel® 64 and IA-32 Architectures Software Developer’s Manual
+Volume 3: System Programming Guide <SDM_>`_).  However, the ``CPUFreq`` core
+uses frequencies for identifying operating performance points of CPUs and
+frequencies are involved in the user space interface exposed by it, so
+``intel_pstate`` maps its internal representation of P-states to frequencies too
+(fortunately, that mapping is unambiguous).  At the same time, it would not be
+practical for ``intel_pstate`` to supply the ``CPUFreq`` core with a table of
+available frequencies due to the possible size of it, so the driver does not do
+that.  Some functionality of the core is limited by that.
+
+Since the hardware P-state selection interface used by ``intel_pstate`` is
+available at the logical CPU level, the driver always works with individual
+CPUs.  Consequently, if ``intel_pstate`` is in use, every ``CPUFreq`` policy
+object corresponds to one logical CPU and ``CPUFreq`` policies are effectively
+equivalent to CPUs.  In particular, this means that they become "inactive" every
+time the corresponding CPU is taken offline and need to be re-initialized when
+it goes back online.
+
+``intel_pstate`` is not modular, so it cannot be unloaded, which means that the
+only way to pass early-configuration-time parameters to it is via the kernel
+command line.  However, its configuration can be adjusted via ``sysfs`` to a
+great extent.  In some configurations it even is possible to unregister it via
+``sysfs`` which allows another ``CPUFreq`` scaling driver to be loaded and
+registered (see `below <status_attr_>`_).
+
+
+Operation Modes
+===============
+
+``intel_pstate`` can operate in three different modes: in the active mode with
+or without hardware-managed P-states support and in the passive mode.  Which of
+them will be in effect depends on what kernel command line options are used and
+on the capabilities of the processor.
+
+Active Mode
+-----------
+
+This is the default operation mode of ``intel_pstate``.  If it works in this
+mode, the ``scaling_driver`` policy attribute in ``sysfs`` for all ``CPUFreq``
+policies contains the string "intel_pstate".
+
+In this mode the driver bypasses the scaling governors layer of ``CPUFreq`` and
+provides its own scaling algorithms for P-state selection.  Those algorithms
+can be applied to ``CPUFreq`` policies in the same way as generic scaling
+governors (that is, through the ``scaling_governor`` policy attribute in
+``sysfs``).  [Note that different P-state selection algorithms may be chosen for
+different policies, but that is not recommended.]
+
+They are not generic scaling governors, but their names are the same as the
+names of some of those governors.  Moreover, confusingly enough, they generally
+do not work in the same way as the generic governors they share the names with.
+For example, the ``powersave`` P-state selection algorithm provided by
+``intel_pstate`` is not a counterpart of the generic ``powersave`` governor
+(roughly, it corresponds to the ``schedutil`` and ``ondemand`` governors).
+
+There are two P-state selection algorithms provided by ``intel_pstate`` in the
+active mode: ``powersave`` and ``performance``.  The way they both operate
+depends on whether or not the hardware-managed P-states (HWP) feature has been
+enabled in the processor and possibly on the processor model.
+
+Which of the P-state selection algorithms is used by default depends on the
+:c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option.
+Namely, if that option is set, the ``performance`` algorithm will be used by
+default, and the other one will be used by default if it is not set.
+
+Active Mode With HWP
+~~~~~~~~~~~~~~~~~~~~
+
+If the processor supports the HWP feature, it will be enabled during the
+processor initialization and cannot be disabled after that.  It is possible
+to avoid enabling it by passing the ``intel_pstate=no_hwp`` argument to the
+kernel in the command line.
+
+If the HWP feature has been enabled, ``intel_pstate`` relies on the processor to
+select P-states by itself, but still it can give hints to the processor's
+internal P-state selection logic.  What those hints are depends on which P-state
+selection algorithm has been applied to the given policy (or to the CPU it
+corresponds to).
+
+Even though the P-state selection is carried out by the processor automatically,
+``intel_pstate`` registers utilization update callbacks with the CPU scheduler
+in this mode.  However, they are not used for running a P-state selection
+algorithm, but for periodic updates of the current CPU frequency information to
+be made available from the ``scaling_cur_freq`` policy attribute in ``sysfs``.
+
+HWP + ``performance``
+.....................
+
+In this configuration ``intel_pstate`` will write 0 to the processor's
+Energy-Performance Preference (EPP) knob (if supported) or its
+Energy-Performance Bias (EPB) knob (otherwise), which means that the processor's
+internal P-state selection logic is expected to focus entirely on performance.
+
+This will override the EPP/EPB setting coming from the ``sysfs`` interface
+(see `Energy vs Performance Hints`_ below).
+
+Also, in this configuration the range of P-states available to the processor's
+internal P-state selection logic is always restricted to the upper boundary
+(that is, the maximum P-state that the driver is allowed to use).
+
+HWP + ``powersave``
+...................
+
+In this configuration ``intel_pstate`` will set the processor's
+Energy-Performance Preference (EPP) knob (if supported) or its
+Energy-Performance Bias (EPB) knob (otherwise) to whatever value it was
+previously set to via ``sysfs`` (or whatever default value it was
+set to by the platform firmware).  This usually causes the processor's
+internal P-state selection logic to be less performance-focused.
+
+Active Mode Without HWP
+~~~~~~~~~~~~~~~~~~~~~~~
+
+This is the default operation mode for processors that do not support the HWP
+feature.  It also is used by default with the ``intel_pstate=no_hwp`` argument
+in the kernel command line.  However, in this mode ``intel_pstate`` may refuse
+to work with the given processor if it does not recognize it.  [Note that
+``intel_pstate`` will never refuse to work with any processor with the HWP
+feature enabled.]
+
+In this mode ``intel_pstate`` registers utilization update callbacks with the
+CPU scheduler in order to run a P-state selection algorithm, either
+``powersave`` or ``performance``, depending on the ``scaling_cur_freq`` policy
+setting in ``sysfs``.  The current CPU frequency information to be made
+available from the ``scaling_cur_freq`` policy attribute in ``sysfs`` is
+periodically updated by those utilization update callbacks too.
+
+``performance``
+...............
+
+Without HWP, this P-state selection algorithm is always the same regardless of
+the processor model and platform configuration.
+
+It selects the maximum P-state it is allowed to use, subject to limits set via
+``sysfs``, every time the P-state selection computations are carried out by the
+driver's utilization update callback for the given CPU (that does not happen
+more often than every 10 ms), but the hardware configuration will not be changed
+if the new P-state is the same as the current one.
+
+This is the default P-state selection algorithm if the
+:c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
+is set.
+
+``powersave``
+.............
+
+Without HWP, this P-state selection algorithm generally depends on the
+processor model and/or the system profile setting in the ACPI tables and there
+are two variants of it.
+
+One of them is used with processors from the Atom line and (regardless of the
+processor model) on platforms with the system profile in the ACPI tables set to
+"mobile" (laptops mostly), "tablet", "appliance PC", "desktop", or
+"workstation".  It is also used with processors supporting the HWP feature if
+that feature has not been enabled (that is, with the ``intel_pstate=no_hwp``
+argument in the kernel command line).  It is similar to the algorithm
+implemented by the generic ``schedutil`` scaling governor except that the
+utilization metric used by it is based on numbers coming from feedback
+registers of the CPU.  It generally selects P-states proportional to the
+current CPU utilization, so it is referred to as the "proportional" algorithm.
+
+The second variant of the ``powersave`` P-state selection algorithm, used in all
+of the other cases (generally, on processors from the Core line, so it is
+referred to as the "Core" algorithm), is based on the values read from the APERF
+and MPERF feedback registers and the previously requested target P-state.
+It does not really take CPU utilization into account explicitly, but as a rule
+it causes the CPU P-state to ramp up very quickly in response to increased
+utilization which is generally desirable in server environments.
+
+Regardless of the variant, this algorithm is run by the driver's utilization
+update callback for the given CPU when it is invoked by the CPU scheduler, but
+not more often than every 10 ms (that can be tweaked via ``debugfs`` in `this
+particular case <Tuning Interface in debugfs_>`_).  Like in the ``performance``
+case, the hardware configuration is not touched if the new P-state turns out to
+be the same as the current one.
+
+This is the default P-state selection algorithm if the
+:c:macro:`CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE` kernel configuration option
+is not set.
+
+Passive Mode
+------------
+
+This mode is used if the ``intel_pstate=passive`` argument is passed to the
+kernel in the command line (it implies the ``intel_pstate=no_hwp`` setting too).
+Like in the active mode without HWP support, in this mode ``intel_pstate`` may
+refuse to work with the given processor if it does not recognize it.
+
+If the driver works in this mode, the ``scaling_driver`` policy attribute in
+``sysfs`` for all ``CPUFreq`` policies contains the string "intel_cpufreq".
+Then, the driver behaves like a regular ``CPUFreq`` scaling driver.  That is,
+it is invoked by generic scaling governors when necessary to talk to the
+hardware in order to change the P-state of a CPU (in particular, the
+``schedutil`` governor can invoke it directly from scheduler context).
+
+While in this mode, ``intel_pstate`` can be used with all of the (generic)
+scaling governors listed by the ``scaling_available_governors`` policy attribute
+in ``sysfs`` (and the P-state selection algorithms described above are not
+used).  Then, it is responsible for the configuration of policy objects
+corresponding to CPUs and provides the ``CPUFreq`` core (and the scaling
+governors attached to the policy objects) with accurate information on the
+maximum and minimum operating frequencies supported by the hardware (including
+the so-called "turbo" frequency ranges).  In other words, in the passive mode
+the entire range of available P-states is exposed by ``intel_pstate`` to the
+``CPUFreq`` core.  However, in this mode the driver does not register
+utilization update callbacks with the CPU scheduler and the ``scaling_cur_freq``
+information comes from the ``CPUFreq`` core (and is the last frequency selected
+by the current scaling governor for the given policy).
+
+
+.. _turbo:
+
+Turbo P-states Support
+======================
+
+In the majority of cases, the entire range of P-states available to
+``intel_pstate`` can be divided into two sub-ranges that correspond to
+different types of processor behavior, above and below a boundary that
+will be referred to as the "turbo threshold" in what follows.
+
+The P-states above the turbo threshold are referred to as "turbo P-states" and
+the whole sub-range of P-states they belong to is referred to as the "turbo
+range".  These names are related to the Turbo Boost technology allowing a
+multicore processor to opportunistically increase the P-state of one or more
+cores if there is enough power to do that and if that is not going to cause the
+thermal envelope of the processor package to be exceeded.
+
+Specifically, if software sets the P-state of a CPU core within the turbo range
+(that is, above the turbo threshold), the processor is permitted to take over
+performance scaling control for that core and put it into turbo P-states of its
+choice going forward.  However, that permission is interpreted differently by
+different processor generations.  Namely, the Sandy Bridge generation of
+processors will never use any P-states above the last one set by software for
+the given core, even if it is within the turbo range, whereas all of the later
+processor generations will take it as a license to use any P-states from the
+turbo range, even above the one set by software.  In other words, on those
+processors setting any P-state from the turbo range will enable the processor
+to put the given core into all turbo P-states up to and including the maximum
+supported one as it sees fit.
+
+One important property of turbo P-states is that they are not sustainable.  More
+precisely, there is no guarantee that any CPUs will be able to stay in any of
+those states indefinitely, because the power distribution within the processor
+package may change over time  or the thermal envelope it was designed for might
+be exceeded if a turbo P-state was used for too long.
+
+In turn, the P-states below the turbo threshold generally are sustainable.  In
+fact, if one of them is set by software, the processor is not expected to change
+it to a lower one unless in a thermal stress or a power limit violation
+situation (a higher P-state may still be used if it is set for another CPU in
+the same package at the same time, for example).
+
+Some processors allow multiple cores to be in turbo P-states at the same time,
+but the maximum P-state that can be set for them generally depends on the number
+of cores running concurrently.  The maximum turbo P-state that can be set for 3
+cores at the same time usually is lower than the analogous maximum P-state for
+2 cores, which in turn usually is lower than the maximum turbo P-state that can
+be set for 1 core.  The one-core maximum turbo P-state is thus the maximum
+supported one overall.
+
+The maximum supported turbo P-state, the turbo threshold (the maximum supported
+non-turbo P-state) and the minimum supported P-state are specific to the
+processor model and can be determined by reading the processor's model-specific
+registers (MSRs).  Moreover, some processors support the Configurable TDP
+(Thermal Design Power) feature and, when that feature is enabled, the turbo
+threshold effectively becomes a configurable value that can be set by the
+platform firmware.
+
+Unlike ``_PSS`` objects in the ACPI tables, ``intel_pstate`` always exposes
+the entire range of available P-states, including the whole turbo range, to the
+``CPUFreq`` core and (in the passive mode) to generic scaling governors.  This
+generally causes turbo P-states to be set more often when ``intel_pstate`` is
+used relative to ACPI-based CPU performance scaling (see `below <acpi-cpufreq_>`_
+for more information).
+
+Moreover, since ``intel_pstate`` always knows what the real turbo threshold is
+(even if the Configurable TDP feature is enabled in the processor), its
+``no_turbo`` attribute in ``sysfs`` (described `below <no_turbo_attr_>`_) should
+work as expected in all cases (that is, if set to disable turbo P-states, it
+always should prevent ``intel_pstate`` from using them).
+
+
+Processor Support
+=================
+
+To handle a given processor ``intel_pstate`` requires a number of different
+pieces of information on it to be known, including:
+
+ * The minimum supported P-state.
+
+ * The maximum supported `non-turbo P-state <turbo_>`_.
+
+ * Whether or not turbo P-states are supported at all.
+
+ * The maximum supported `one-core turbo P-state <turbo_>`_ (if turbo P-states
+   are supported).
+
+ * The scaling formula to translate the driver's internal representation
+   of P-states into frequencies and the other way around.
+
+Generally, ways to obtain that information are specific to the processor model
+or family.  Although it often is possible to obtain all of it from the processor
+itself (using model-specific registers), there are cases in which hardware
+manuals need to be consulted to get to it too.
+
+For this reason, there is a list of supported processors in ``intel_pstate`` and
+the driver initialization will fail if the detected processor is not in that
+list, unless it supports the `HWP feature <Active Mode_>`_.  [The interface to
+obtain all of the information listed above is the same for all of the processors
+supporting the HWP feature, which is why they all are supported by
+``intel_pstate``.]
+
+
+User Space Interface in ``sysfs``
+=================================
+
+Global Attributes
+-----------------
+
+``intel_pstate`` exposes several global attributes (files) in ``sysfs`` to
+control its functionality at the system level.  They are located in the
+``/sys/devices/system/cpu/cpufreq/intel_pstate/`` directory and affect all
+CPUs.
+
+Some of them are not present if the ``intel_pstate=per_cpu_perf_limits``
+argument is passed to the kernel in the command line.
+
+``max_perf_pct``
+	Maximum P-state the driver is allowed to set in percent of the
+	maximum supported performance level (the highest supported `turbo
+	P-state <turbo_>`_).
+
+	This attribute will not be exposed if the
+	``intel_pstate=per_cpu_perf_limits`` argument is present in the kernel
+	command line.
+
+``min_perf_pct``
+	Minimum P-state the driver is allowed to set in percent of the
+	maximum supported performance level (the highest supported `turbo
+	P-state <turbo_>`_).
+
+	This attribute will not be exposed if the
+	``intel_pstate=per_cpu_perf_limits`` argument is present in the kernel
+	command line.
+
+``num_pstates``
+	Number of P-states supported by the processor (between 0 and 255
+	inclusive) including both turbo and non-turbo P-states (see
+	`Turbo P-states Support`_).
+
+	The value of this attribute is not affected by the ``no_turbo``
+	setting described `below <no_turbo_attr_>`_.
+
+	This attribute is read-only.
+
+``turbo_pct``
+	Ratio of the `turbo range <turbo_>`_ size to the size of the entire
+	range of supported P-states, in percent.
+
+	This attribute is read-only.
+
+.. _no_turbo_attr:
+
+``no_turbo``
+	If set (equal to 1), the driver is not allowed to set any turbo P-states
+	(see `Turbo P-states Support`_).  If unset (equalt to 0, which is the
+	default), turbo P-states can be set by the driver.
+	[Note that ``intel_pstate`` does not support the general ``boost``
+	attribute (supported by some other scaling drivers) which is replaced
+	by this one.]
+
+	This attrubute does not affect the maximum supported frequency value
+	supplied to the ``CPUFreq`` core and exposed via the policy interface,
+	but it affects the maximum possible value of per-policy P-state	limits
+	(see `Interpretation of Policy Attributes`_ below for details).
+
+.. _status_attr:
+
+``status``
+	Operation mode of the driver: "active", "passive" or "off".
+
+	"active"
+		The driver is functional and in the `active mode
+		<Active Mode_>`_.
+
+	"passive"
+		The driver is functional and in the `passive mode
+		<Passive Mode_>`_.
+
+	"off"
+		The driver is not functional (it is not registered as a scaling
+		driver with the ``CPUFreq`` core).
+
+	This attribute can be written to in order to change the driver's
+	operation mode or to unregister it.  The string written to it must be
+	one of the possible values of it and, if successful, the write will
+	cause the driver to switch over to the operation mode represented by
+	that string - or to be unregistered in the "off" case.  [Actually,
+	switching over from the active mode to the passive mode or the other
+	way around causes the driver to be unregistered and registered again
+	with a different set of callbacks, so all of its settings (the global
+	as well as the per-policy ones) are then reset to their default
+	values, possibly depending on the target operation mode.]
+
+	That only is supported in some configurations, though (for example, if
+	the `HWP feature is enabled in the processor <Active Mode With HWP_>`_,
+	the operation mode of the driver cannot be changed), and if it is not
+	supported in the current configuration, writes to this attribute with
+	fail with an appropriate error.
+
+Interpretation of Policy Attributes
+-----------------------------------
+
+The interpretation of some ``CPUFreq`` policy attributes described in
+:doc:`cpufreq` is special with ``intel_pstate`` as the current scaling driver
+and it generally depends on the driver's `operation mode <Operation Modes_>`_.
+
+First of all, the values of the ``cpuinfo_max_freq``, ``cpuinfo_min_freq`` and
+``scaling_cur_freq`` attributes are produced by applying a processor-specific
+multiplier to the internal P-state representation used by ``intel_pstate``.
+Also, the values of the ``scaling_max_freq`` and ``scaling_min_freq``
+attributes are capped by the frequency corresponding to the maximum P-state that
+the driver is allowed to set.
+
+If the ``no_turbo`` `global attribute <no_turbo_attr_>`_ is set, the driver is
+not allowed to use turbo P-states, so the maximum value of ``scaling_max_freq``
+and ``scaling_min_freq`` is limited to the maximum non-turbo P-state frequency.
+Accordingly, setting ``no_turbo`` causes ``scaling_max_freq`` and
+``scaling_min_freq`` to go down to that value if they were above it before.
+However, the old values of ``scaling_max_freq`` and ``scaling_min_freq`` will be
+restored after unsetting ``no_turbo``, unless these attributes have been written
+to after ``no_turbo`` was set.
+
+If ``no_turbo`` is not set, the maximum possible value of ``scaling_max_freq``
+and ``scaling_min_freq`` corresponds to the maximum supported turbo P-state,
+which also is the value of ``cpuinfo_max_freq`` in either case.
+
+Next, the following policy attributes have special meaning if
+``intel_pstate`` works in the `active mode <Active Mode_>`_:
+
+``scaling_available_governors``
+	List of P-state selection algorithms provided by ``intel_pstate``.
+
+``scaling_governor``
+	P-state selection algorithm provided by ``intel_pstate`` currently in
+	use with the given policy.
+
+``scaling_cur_freq``
+	Frequency of the average P-state of the CPU represented by the given
+	policy for the time interval between the last two invocations of the
+	driver's utilization update callback by the CPU scheduler for that CPU.
+
+The meaning of these attributes in the `passive mode <Passive Mode_>`_ is the
+same as for other scaling drivers.
+
+Additionally, the value of the ``scaling_driver`` attribute for ``intel_pstate``
+depends on the operation mode of the driver.  Namely, it is either
+"intel_pstate" (in the `active mode <Active Mode_>`_) or "intel_cpufreq" (in the
+`passive mode <Passive Mode_>`_).
+
+Coordination of P-State Limits
+------------------------------
+
+``intel_pstate`` allows P-state limits to be set in two ways: with the help of
+the ``max_perf_pct`` and ``min_perf_pct`` `global attributes
+<Global Attributes_>`_ or via the ``scaling_max_freq`` and ``scaling_min_freq``
+``CPUFreq`` policy attributes.  The coordination between those limits is based
+on the following rules, regardless of the current operation mode of the driver:
+
+ 1. All CPUs are affected by the global limits (that is, none of them can be
+    requested to run faster than the global maximum and none of them can be
+    requested to run slower than the global minimum).
+
+ 2. Each individual CPU is affected by its own per-policy limits (that is, it
+    cannot be requested to run faster than its own per-policy maximum and it
+    cannot be requested to run slower than its own per-policy minimum).
+
+ 3. The global and per-policy limits can be set independently.
+
+If the `HWP feature is enabled in the processor <Active Mode With HWP_>`_, the
+resulting effective values are written into its registers whenever the limits
+change in order to request its internal P-state selection logic to always set
+P-states within these limits.  Otherwise, the limits are taken into account by
+scaling governors (in the `passive mode <Passive Mode_>`_) and by the driver
+every time before setting a new P-state for a CPU.
+
+Additionally, if the ``intel_pstate=per_cpu_perf_limits`` command line argument
+is passed to the kernel, ``max_perf_pct`` and ``min_perf_pct`` are not exposed
+at all and the only way to set the limits is by using the policy attributes.
+
+
+Energy vs Performance Hints
+---------------------------
+
+If ``intel_pstate`` works in the `active mode with the HWP feature enabled
+<Active Mode With HWP_>`_ in the processor, additional attributes are present
+in every ``CPUFreq`` policy directory in ``sysfs``.  They are intended to allow
+user space to help ``intel_pstate`` to adjust the processor's internal P-state
+selection logic by focusing it on performance or on energy-efficiency, or
+somewhere between the two extremes:
+
+``energy_performance_preference``
+	Current value of the energy vs performance hint for the given policy
+	(or the CPU represented by it).
+
+	The hint can be changed by writing to this attribute.
+
+``energy_performance_available_preferences``
+	List of strings that can be written to the
+	``energy_performance_preference`` attribute.
+
+	They represent different energy vs performance hints and should be
+	self-explanatory, except that ``default`` represents whatever hint
+	value was set by the platform firmware.
+
+Strings written to the ``energy_performance_preference`` attribute are
+internally translated to integer values written to the processor's
+Energy-Performance Preference (EPP) knob (if supported) or its
+Energy-Performance Bias (EPB) knob.
+
+[Note that tasks may by migrated from one CPU to another by the scheduler's
+load-balancing algorithm and if different energy vs performance hints are
+set for those CPUs, that may lead to undesirable outcomes.  To avoid such
+issues it is better to set the same energy vs performance hint for all CPUs
+or to pin every task potentially sensitive to them to a specific CPU.]
+
+.. _acpi-cpufreq:
+
+``intel_pstate`` vs ``acpi-cpufreq``
+====================================
+
+On the majority of systems supported by ``intel_pstate``, the ACPI tables
+provided by the platform firmware contain ``_PSS`` objects returning information
+that can be used for CPU performance scaling (refer to the `ACPI specification`_
+for details on the ``_PSS`` objects and the format of the information returned
+by them).
+
+The information returned by the ACPI ``_PSS`` objects is used by the
+``acpi-cpufreq`` scaling driver.  On systems supported by ``intel_pstate``
+the ``acpi-cpufreq`` driver uses the same hardware CPU performance scaling
+interface, but the set of P-states it can use is limited by the ``_PSS``
+output.
+
+On those systems each ``_PSS`` object returns a list of P-states supported by
+the corresponding CPU which basically is a subset of the P-states range that can
+be used by ``intel_pstate`` on the same system, with one exception: the whole
+`turbo range <turbo_>`_ is represented by one item in it (the topmost one).  By
+convention, the frequency returned by ``_PSS`` for that item is greater by 1 MHz
+than the frequency of the highest non-turbo P-state listed by it, but the
+corresponding P-state representation (following the hardware specification)
+returned for it matches the maximum supported turbo P-state (or is the
+special value 255 meaning essentially "go as high as you can get").
+
+The list of P-states returned by ``_PSS`` is reflected by the table of
+available frequencies supplied by ``acpi-cpufreq`` to the ``CPUFreq`` core and
+scaling governors and the minimum and maximum supported frequencies reported by
+it come from that list as well.  In particular, given the special representation
+of the turbo range described above, this means that the maximum supported
+frequency reported by ``acpi-cpufreq`` is higher by 1 MHz than the frequency
+of the highest supported non-turbo P-state listed by ``_PSS`` which, of course,
+affects decisions made by the scaling governors, except for ``powersave`` and
+``performance``.
+
+For example, if a given governor attempts to select a frequency proportional to
+estimated CPU load and maps the load of 100% to the maximum supported frequency
+(possibly multiplied by a constant), then it will tend to choose P-states below
+the turbo threshold if ``acpi-cpufreq`` is used as the scaling driver, because
+in that case the turbo range corresponds to a small fraction of the frequency
+band it can use (1 MHz vs 1 GHz or more).  In consequence, it will only go to
+the turbo range for the highest loads and the other loads above 50% that might
+benefit from running at turbo frequencies will be given non-turbo P-states
+instead.
+
+One more issue related to that may appear on systems supporting the
+`Configurable TDP feature <turbo_>`_ allowing the platform firmware to set the
+turbo threshold.  Namely, if that is not coordinated with the lists of P-states
+returned by ``_PSS`` properly, there may be more than one item corresponding to
+a turbo P-state in those lists and there may be a problem with avoiding the
+turbo range (if desirable or necessary).  Usually, to avoid using turbo
+P-states overall, ``acpi-cpufreq`` simply avoids using the topmost state listed
+by ``_PSS``, but that is not sufficient when there are other turbo P-states in
+the list returned by it.
+
+Apart from the above, ``acpi-cpufreq`` works like ``intel_pstate`` in the
+`passive mode <Passive Mode_>`_, except that the number of P-states it can set
+is limited to the ones listed by the ACPI ``_PSS`` objects.
+
+
+Kernel Command Line Options for ``intel_pstate``
+================================================
+
+Several kernel command line options can be used to pass early-configuration-time
+parameters to ``intel_pstate`` in order to enforce specific behavior of it.  All
+of them have to be prepended with the ``intel_pstate=`` prefix.
+
+``disable``
+	Do not register ``intel_pstate`` as the scaling driver even if the
+	processor is supported by it.
+
+``passive``
+	Register ``intel_pstate`` in the `passive mode <Passive Mode_>`_ to
+	start with.
+
+	This option implies the ``no_hwp`` one described below.
+
+``force``
+	Register ``intel_pstate`` as the scaling driver instead of
+	``acpi-cpufreq`` even if the latter is preferred on the given system.
+
+	This may prevent some platform features (such as thermal controls and
+	power capping) that rely on the availability of ACPI P-states
+	information from functioning as expected, so it should be used with
+	caution.
+
+	This option does not work with processors that are not supported by
+	``intel_pstate`` and on platforms where the ``pcc-cpufreq`` scaling
+	driver is used instead of ``acpi-cpufreq``.
+
+``no_hwp``
+	Do not enable the `hardware-managed P-states (HWP) feature
+	<Active Mode With HWP_>`_ even if it is supported by the processor.
+
+``hwp_only``
+	Register ``intel_pstate`` as the scaling driver only if the
+	`hardware-managed P-states (HWP) feature <Active Mode With HWP_>`_ is
+	supported by the processor.
+
+``support_acpi_ppc``
+	Take ACPI ``_PPC`` performance limits into account.
+
+	If the preferred power management profile in the FADT (Fixed ACPI
+	Description Table) is set to "Enterprise Server" or "Performance
+	Server", the ACPI ``_PPC`` limits are taken into account by default
+	and this option has no effect.
+
+``per_cpu_perf_limits``
+	Use per-logical-CPU P-State limits (see `Coordination of P-state
+	Limits`_ for details).
+
+
+Diagnostics and Tuning
+======================
+
+Trace Events
+------------
+
+There are two static trace events that can be used for ``intel_pstate``
+diagnostics.  One of them is the ``cpu_frequency`` trace event generally used
+by ``CPUFreq``, and the other one is the ``pstate_sample`` trace event specific
+to ``intel_pstate``.  Both of them are triggered by ``intel_pstate`` only if
+it works in the `active mode <Active Mode_>`_.
+
+The following sequence of shell commands can be used to enable them and see
+their output (if the kernel is generally configured to support event tracing)::
+
+ # cd /sys/kernel/debug/tracing/
+ # echo 1 > events/power/pstate_sample/enable
+ # echo 1 > events/power/cpu_frequency/enable
+ # cat trace
+ gnome-terminal--4510  [001] ..s.  1177.680733: pstate_sample: core_busy=107 scaled=94 from=26 to=26 mperf=1143818 aperf=1230607 tsc=29838618 freq=2474476
+ cat-5235  [002] ..s.  1177.681723: cpu_frequency: state=2900000 cpu_id=2
+
+If ``intel_pstate`` works in the `passive mode <Passive Mode_>`_, the
+``cpu_frequency`` trace event will be triggered either by the ``schedutil``
+scaling governor (for the policies it is attached to), or by the ``CPUFreq``
+core (for the policies with other scaling governors).
+
+``ftrace``
+----------
+
+The ``ftrace`` interface can be used for low-level diagnostics of
+``intel_pstate``.  For example, to check how often the function to set a
+P-state is called, the ``ftrace`` filter can be set to to
+:c:func:`intel_pstate_set_pstate`::
+
+ # cd /sys/kernel/debug/tracing/
+ # cat available_filter_functions | grep -i pstate
+ intel_pstate_set_pstate
+ intel_pstate_cpu_init
+ ...
+ # echo intel_pstate_set_pstate > set_ftrace_filter
+ # echo function > current_tracer
+ # cat trace | head -15
+ # tracer: function
+ #
+ # entries-in-buffer/entries-written: 80/80   #P:4
+ #
+ #                              _-----=> irqs-off
+ #                             / _----=> need-resched
+ #                            | / _---=> hardirq/softirq
+ #                            || / _--=> preempt-depth
+ #                            ||| /     delay
+ #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
+ #              | |       |   ||||       |         |
+             Xorg-3129  [000] ..s.  2537.644844: intel_pstate_set_pstate <-intel_pstate_timer_func
+  gnome-terminal--4510  [002] ..s.  2537.649844: intel_pstate_set_pstate <-intel_pstate_timer_func
+      gnome-shell-3409  [001] ..s.  2537.650850: intel_pstate_set_pstate <-intel_pstate_timer_func
+           <idle>-0     [000] ..s.  2537.654843: intel_pstate_set_pstate <-intel_pstate_timer_func
+
+Tuning Interface in ``debugfs``
+-------------------------------
+
+The ``powersave`` algorithm provided by ``intel_pstate`` for `the Core line of
+processors in the active mode <powersave_>`_ is based on a `PID controller`_
+whose parameters were chosen to address a number of different use cases at the
+same time.  However, it still is possible to fine-tune it to a specific workload
+and the ``debugfs`` interface under ``/sys/kernel/debug/pstate_snb/`` is
+provided for this purpose.  [Note that the ``pstate_snb`` directory will be
+present only if the specific P-state selection algorithm matching the interface
+in it actually is in use.]
+
+The following files present in that directory can be used to modify the PID
+controller parameters at run time:
+
+| ``deadband``
+| ``d_gain_pct``
+| ``i_gain_pct``
+| ``p_gain_pct``
+| ``sample_rate_ms``
+| ``setpoint``
+
+Note, however, that achieving desirable results this way generally requires
+expert-level understanding of the power vs performance tradeoff, so extra care
+is recommended when attempting to do that.
+
+
+.. _LCEU2015: http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
+.. _SDM: http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
+.. _ACPI specification: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf
+.. _PID controller: https://en.wikipedia.org/wiki/PID_controller
Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -1,4 +1,5 @@
 .. |struct cpufreq_policy| replace:: :c:type:`struct cpufreq_policy <cpufreq_policy>`
+.. |intel_pstate| replace:: :doc:`intel_pstate <intel_pstate>`
 
 =======================
 CPU Performance Scaling
@@ -75,7 +76,7 @@ feedback registers, as that information
 interface it comes from and may not be easily represented in an abstract,
 platform-independent way.  For this reason, ``CPUFreq`` allows scaling drivers
 to bypass the governor layer and implement their own performance scaling
-algorithms.  That is done by the ``intel_pstate`` scaling driver.
+algorithms.  That is done by the |intel_pstate| scaling driver.
 
 
 ``CPUFreq`` Policy Objects
@@ -174,13 +175,13 @@ necessary to restart the scaling governo
 into account.  That is achieved by invoking the governor's ``->stop`` and
 ``->start()`` callbacks, in this order, for the entire policy.
 
-As mentioned before, the ``intel_pstate`` scaling driver bypasses the scaling
+As mentioned before, the |intel_pstate| scaling driver bypasses the scaling
 governor layer of ``CPUFreq`` and provides its own P-state selection algorithms.
-Consequently, if ``intel_pstate`` is used, scaling governors are not attached to
+Consequently, if |intel_pstate| is used, scaling governors are not attached to
 new policy objects.  Instead, the driver's ``->setpolicy()`` callback is invoked
 to register per-CPU utilization update callbacks for each policy.  These
 callbacks are invoked by the CPU scheduler in the same way as for scaling
-governors, but in the ``intel_pstate`` case they both determine the P-state to
+governors, but in the |intel_pstate| case they both determine the P-state to
 use and change the hardware configuration accordingly in one go from scheduler
 context.
 
@@ -257,7 +258,7 @@ are the following:
 
 ``scaling_available_governors``
 	List of ``CPUFreq`` scaling governors present in the kernel that can
-	be attached to this policy or (if the ``intel_pstate`` scaling driver is
+	be attached to this policy or (if the |intel_pstate| scaling driver is
 	in use) list of scaling algorithms provided by the driver that can be
 	applied to this policy.
 
@@ -274,7 +275,7 @@ are the following:
 	the CPU is actually running at (due to hardware design and other
 	limitations).
 
-	Some scaling drivers (e.g. ``intel_pstate``) attempt to provide
+	Some scaling drivers (e.g. |intel_pstate|) attempt to provide
 	information more precisely reflecting the current CPU frequency through
 	this attribute, but that still may not be the exact current CPU
 	frequency as seen by the hardware at the moment.
@@ -284,13 +285,13 @@ are the following:
 
 ``scaling_governor``
 	The scaling governor currently attached to this policy or (if the
-	``intel_pstate`` scaling driver is in use) the scaling algorithm
+	|intel_pstate| scaling driver is in use) the scaling algorithm
 	provided by the driver that is currently applied to this policy.
 
 	This attribute is read-write and writing to it will cause a new scaling
 	governor to be attached to this policy or a new scaling algorithm
 	provided by the scaling driver to be applied to it (in the
-	``intel_pstate`` case), as indicated by the string written to this
+	|intel_pstate| case), as indicated by the string written to this
 	attribute (which must be one of the names listed by the
 	``scaling_available_governors`` attribute described above).
 
@@ -619,7 +620,7 @@ This file is located under :file:`/sys/d
 the "boost" setting for the whole system.  It is not present if the underlying
 scaling driver does not support the frequency boost mechanism (or supports it,
 but provides a driver-specific interface for controlling it, like
-``intel_pstate``).
+|intel_pstate|).
 
 If the value in this file is 1, the frequency boost mechanism is enabled.  This
 means that either the hardware can be put into states in which it is able to
Index: linux-pm/Documentation/cpu-freq/intel-pstate.txt
===================================================================
--- linux-pm.orig/Documentation/cpu-freq/intel-pstate.txt
+++ /dev/null
@@ -1,281 +0,0 @@
-Intel P-State driver
---------------------
-
-This driver provides an interface to control the P-State selection for the
-SandyBridge+ Intel processors.
-
-The following document explains P-States:
-http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
-As stated in the document, P-State doesn’t exactly mean a frequency. However, for
-the sake of the relationship with cpufreq, P-State and frequency are used
-interchangeably.
-
-Understanding the cpufreq core governors and policies are important before
-discussing more details about the Intel P-State driver. Based on what callbacks
-a cpufreq driver provides to the cpufreq core, it can support two types of
-drivers:
-- with target_index() callback: In this mode, the drivers using cpufreq core
-simply provide the minimum and maximum frequency limits and an additional
-interface target_index() to set the current frequency. The cpufreq subsystem
-has a number of scaling governors ("performance", "powersave", "ondemand",
-etc.). Depending on which governor is in use, cpufreq core will call for
-transitions to a specific frequency using target_index() callback.
-- setpolicy() callback: In this mode, drivers do not provide target_index()
-callback, so cpufreq core can't request a transition to a specific frequency.
-The driver provides minimum and maximum frequency limits and callbacks to set a
-policy. The policy in cpufreq sysfs is referred to as the "scaling governor".
-The cpufreq core can request the driver to operate in any of the two policies:
-"performance" and "powersave". The driver decides which frequency to use based
-on the above policy selection considering minimum and maximum frequency limits.
-
-The Intel P-State driver falls under the latter category, which implements the
-setpolicy() callback. This driver decides what P-State to use based on the
-requested policy from the cpufreq core. If the processor is capable of
-selecting its next P-State internally, then the driver will offload this
-responsibility to the processor (aka HWP: Hardware P-States). If not, the
-driver implements algorithms to select the next P-State.
-
-Since these policies are implemented in the driver, they are not same as the
-cpufreq scaling governors implementation, even if they have the same name in
-the cpufreq sysfs (scaling_governors). For example the "performance" policy is
-similar to cpufreq’s "performance" governor, but "powersave" is completely
-different than the cpufreq "powersave" governor. The strategy here is similar
-to cpufreq "ondemand", where the requested P-State is related to the system load.
-
-Sysfs Interface
-
-In addition to the frequency-controlling interfaces provided by the cpufreq
-core, the driver provides its own sysfs files to control the P-State selection.
-These files have been added to /sys/devices/system/cpu/intel_pstate/.
-Any changes made to these files are applicable to all CPUs (even in a
-multi-package system, Refer to later section on placing "Per-CPU limits").
-
-      max_perf_pct: Limits the maximum P-State that will be requested by
-      the driver. It states it as a percentage of the available performance. The
-      available (P-State) performance may be reduced by the no_turbo
-      setting described below.
-
-      min_perf_pct: Limits the minimum P-State that will be requested by
-      the driver. It states it as a percentage of the max (non-turbo)
-      performance level.
-
-      no_turbo: Limits the driver to selecting P-State below the turbo
-      frequency range.
-
-      turbo_pct: Displays the percentage of the total performance that
-      is supported by hardware that is in the turbo range. This number
-      is independent of whether turbo has been disabled or not.
-
-      num_pstates: Displays the number of P-States that are supported
-      by hardware. This number is independent of whether turbo has
-      been disabled or not.
-
-For example, if a system has these parameters:
-	Max 1 core turbo ratio: 0x21 (Max 1 core ratio is the maximum P-State)
-	Max non turbo ratio: 0x17
-	Minimum ratio : 0x08 (Here the ratio is called max efficiency ratio)
-
-Sysfs will show :
-	max_perf_pct:100, which corresponds to 1 core ratio
-	min_perf_pct:24, max_efficiency_ratio / max 1 Core ratio
-	no_turbo:0, turbo is not disabled
-	num_pstates:26 = (max 1 Core ratio - Max Efficiency Ratio + 1)
-	turbo_pct:39 = (max 1 core ratio - max non turbo ratio) / num_pstates
-
-Refer to "Intel® 64 and IA-32 Architectures Software Developer’s Manual
-Volume 3: System Programming Guide" to understand ratios.
-
-There is one more sysfs attribute in /sys/devices/system/cpu/intel_pstate/
-that can be used for controlling the operation mode of the driver:
-
-      status: Three settings are possible:
-      "off"     - The driver is not in use at this time.
-      "active"  - The driver works as a P-state governor (default).
-      "passive" - The driver works as a regular cpufreq one and collaborates
-                  with the generic cpufreq governors (it sets P-states as
-                  requested by those governors).
-      The current setting is returned by reads from this attribute.  Writing one
-      of the above strings to it changes the operation mode as indicated by that
-      string, if possible.  If HW-managed P-states (HWP) are enabled, it is not
-      possible to change the driver's operation mode and attempts to write to
-      this attribute will fail.
-
-cpufreq sysfs for Intel P-State
-
-Since this driver registers with cpufreq, cpufreq sysfs is also presented.
-There are some important differences, which need to be considered.
-
-scaling_cur_freq: This displays the real frequency which was used during
-the last sample period instead of what is requested. Some other cpufreq driver,
-like acpi-cpufreq, displays what is requested (Some changes are on the
-way to fix this for acpi-cpufreq driver). The same is true for frequencies
-displayed at /proc/cpuinfo.
-
-scaling_governor: This displays current active policy. Since each CPU has a
-cpufreq sysfs, it is possible to set a scaling governor to each CPU. But this
-is not possible with Intel P-States, as there is one common policy for all
-CPUs. Here, the last requested policy will be applicable to all CPUs. It is
-suggested that one use the cpupower utility to change policy to all CPUs at the
-same time.
-
-scaling_setspeed: This attribute can never be used with Intel P-State.
-
-scaling_max_freq/scaling_min_freq: This interface can be used similarly to
-the max_perf_pct/min_perf_pct of Intel P-State sysfs. However since frequencies
-are converted to nearest possible P-State, this is prone to rounding errors.
-This method is not preferred to limit performance.
-
-affected_cpus: Not used
-related_cpus: Not used
-
-For contemporary Intel processors, the frequency is controlled by the
-processor itself and the P-State exposed to software is related to
-performance levels.  The idea that frequency can be set to a single
-frequency is fictional for Intel Core processors. Even if the scaling
-driver selects a single P-State, the actual frequency the processor
-will run at is selected by the processor itself.
-
-Per-CPU limits
-
-The kernel command line option "intel_pstate=per_cpu_perf_limits" forces
-the intel_pstate driver to use per-CPU performance limits.  When it is set,
-the sysfs control interface described above is subject to limitations.
-- The following controls are not available for both read and write
-	/sys/devices/system/cpu/intel_pstate/max_perf_pct
-	/sys/devices/system/cpu/intel_pstate/min_perf_pct
-- The following controls can be used to set performance limits, as far as the
-architecture of the processor permits:
-	/sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
-	/sys/devices/system/cpu/cpu*/cpufreq/scaling_min_freq
-	/sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
-- User can still observe turbo percent and number of P-States from
-	/sys/devices/system/cpu/intel_pstate/turbo_pct
-	/sys/devices/system/cpu/intel_pstate/num_pstates
-- User can read write system wide turbo status
-	/sys/devices/system/cpu/no_turbo
-
-Support of energy performance hints
-It is possible to provide hints to the HWP algorithms in the processor
-to be more performance centric to more energy centric. When the driver
-is using HWP, two additional cpufreq sysfs attributes are presented for
-each logical CPU.
-These attributes are:
-	- energy_performance_available_preferences
-	- energy_performance_preference
-
-To get list of supported hints:
-$ cat energy_performance_available_preferences
-    default performance balance_performance balance_power power
-
-The current preference can be read or changed via cpufreq sysfs
-attribute "energy_performance_preference". Reading from this attribute
-will display current effective setting. User can write any of the valid
-preference string to this attribute. User can always restore to power-on
-default by writing "default".
-
-Since threads can migrate to different CPUs, this is possible that the
-new CPU may have different energy performance preference than the previous
-one. To avoid such issues, either threads can be pinned to specific CPUs
-or set the same energy performance preference value to all CPUs.
-
-Tuning Intel P-State driver
-
-When the performance can be tuned using PID (Proportional Integral
-Derivative) controller, debugfs files are provided for adjusting performance.
-They are presented under:
-/sys/kernel/debug/pstate_snb/
-
-The PID tunable parameters are:
-      deadband
-      d_gain_pct
-      i_gain_pct
-      p_gain_pct
-      sample_rate_ms
-      setpoint
-
-To adjust these parameters, some understanding of driver implementation is
-necessary. There are some tweeks described here, but be very careful. Adjusting
-them requires expert level understanding of power and performance relationship.
-These limits are only useful when the "powersave" policy is active.
-
--To make the system more responsive to load changes, sample_rate_ms can
-be adjusted  (current default is 10ms).
--To make the system use higher performance, even if the load is lower, setpoint
-can be adjusted to a lower number. This will also lead to faster ramp up time
-to reach the maximum P-State.
-If there are no derivative and integral coefficients, The next P-State will be
-equal to:
-	current P-State - ((setpoint - current cpu load) * p_gain_pct)
-
-For example, if the current PID parameters are (Which are defaults for the core
-processors like SandyBridge):
-      deadband = 0
-      d_gain_pct = 0
-      i_gain_pct = 0
-      p_gain_pct = 20
-      sample_rate_ms = 10
-      setpoint = 97
-
-If the current P-State = 0x08 and current load = 100, this will result in the
-next P-State = 0x08 - ((97 - 100) * 0.2) = 8.6 (rounded to 9). Here the P-State
-goes up by only 1. If during next sample interval the current load doesn't
-change and still 100, then P-State goes up by one again. This process will
-continue as long as the load is more than the setpoint until the maximum P-State
-is reached.
-
-For the same load at setpoint = 60, this will result in the next P-State
-= 0x08 - ((60 - 100) * 0.2) = 16
-So by changing the setpoint from 97 to 60, there is an increase of the
-next P-State from 9 to 16. So this will make processor execute at higher
-P-State for the same CPU load. If the load continues to be more than the
-setpoint during next sample intervals, then P-State will go up again till the
-maximum P-State is reached. But the ramp up time to reach the maximum P-State
-will be much faster when the setpoint is 60 compared to 97.
-
-Debugging Intel P-State driver
-
-Event tracing
-To debug P-State transition, the Linux event tracing interface can be used.
-There are two specific events, which can be enabled (Provided the kernel
-configs related to event tracing are enabled).
-
-# cd /sys/kernel/debug/tracing/
-# echo 1 > events/power/pstate_sample/enable
-# echo 1 > events/power/cpu_frequency/enable
-# cat trace
-gnome-terminal--4510  [001] ..s.  1177.680733: pstate_sample: core_busy=107
-	scaled=94 from=26 to=26 mperf=1143818 aperf=1230607 tsc=29838618
-		freq=2474476
-cat-5235  [002] ..s.  1177.681723: cpu_frequency: state=2900000 cpu_id=2
-
-
-Using ftrace
-
-If function level tracing is required, the Linux ftrace interface can be used.
-For example if we want to check how often a function to set a P-State is
-called, we can set ftrace filter to intel_pstate_set_pstate.
-
-# cd /sys/kernel/debug/tracing/
-# cat available_filter_functions | grep -i pstate
-intel_pstate_set_pstate
-intel_pstate_cpu_init
-...
-
-# echo intel_pstate_set_pstate > set_ftrace_filter
-# echo function > current_tracer
-# cat trace | head -15
-# tracer: function
-#
-# entries-in-buffer/entries-written: 80/80   #P:4
-#
-#                              _-----=> irqs-off
-#                             / _----=> need-resched
-#                            | / _---=> hardirq/softirq
-#                            || / _--=> preempt-depth
-#                            ||| /     delay
-#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
-#              | |       |   ||||       |         |
-            Xorg-3129  [000] ..s.  2537.644844: intel_pstate_set_pstate <-intel_pstate_timer_func
- gnome-terminal--4510  [002] ..s.  2537.649844: intel_pstate_set_pstate <-intel_pstate_timer_func
-     gnome-shell-3409  [001] ..s.  2537.650850: intel_pstate_set_pstate <-intel_pstate_timer_func
-          <idle>-0     [000] ..s.  2537.654843: intel_pstate_set_pstate <-intel_pstate_timer_func

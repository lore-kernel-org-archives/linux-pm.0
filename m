From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] Documentation: cpufreq: intel_pstate: enhance documentation
Date: Mon, 28 Dec 2015 10:15:26 -0800
Message-ID: <1451326526-6367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199AbbL1SRa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Dec 2015 13:17:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org, dsmythies@telus.net
Cc: len.brown@intel.com, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

This is an attempt to make documentation more user friendly.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
---
Changes in v2:
	Suggested by Doug Smythies
		- Grammar correction
		- Use default PID and impact of setpoint on ramp up times
=09

 Documentation/cpu-freq/intel-pstate.txt | 193 ++++++++++++++++++++++++=
+-------
 1 file changed, 151 insertions(+), 42 deletions(-)

diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cp=
u-freq/intel-pstate.txt
index be8d400..5398a66 100644
--- a/Documentation/cpu-freq/intel-pstate.txt
+++ b/Documentation/cpu-freq/intel-pstate.txt
@@ -1,61 +1,131 @@
-Intel P-state driver
+Intel P-State driver
 --------------------
=20
-This driver provides an interface to control the P state selection for
-SandyBridge+ Intel processors.  The driver can operate two different
-modes based on the processor model, legacy mode and Hardware P state (=
HWP)
-mode.
-
-In legacy mode, the Intel P-state implements two internal governors,
-performance and powersave, that differ from the general cpufreq govern=
ors of
-the same name (the general cpufreq governors implement target(), where=
as the
-internal Intel P-state governors implement setpolicy()).  The internal
-performance governor sets the max_perf_pct and min_perf_pct to 100; th=
at is,
-the governor selects the highest available P state to maximize the per=
formance
-of the core.  The internal powersave governor selects the appropriate =
P state
-based on the current load on the CPU.
-
-In HWP mode P state selection is implemented in the processor
-itself. The driver provides the interfaces between the cpufreq core an=
d
-the processor to control P state selection based on user preferences
-and reporting frequency to the cpufreq core.  In this mode the
-internal Intel P-state governor code is disabled.
-
-In addition to the interfaces provided by the cpufreq core for
-controlling frequency the driver provides sysfs files for
-controlling P state selection. These files have been added to
-/sys/devices/system/cpu/intel_pstate/
-
-      max_perf_pct: limits the maximum P state that will be requested =
by
-      the driver stated as a percentage of the available performance. =
The
-      available (P states) performance may be reduced by the no_turbo
+This driver provides an interface to control the P-State selection for=
 the
+SandyBridge+ Intel processors.
+
+The following document explains P-States:
+http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEu=
rope_2015.pdf
+As stated in the document, P-State doesn=E2=80=99t exactly mean a freq=
uency. However, for
+the sake of the relationship with cpufreq, P-State and frequency are u=
sed
+interchangeably.
+
+Understanding the cpufreq core governors and policies are important be=
fore
+discussing more details about the Intel P-State driver. Based on what =
callbacks
+a cpufreq driver provides to the cpufreq core, it can support two type=
s of
+drivers:
+- with target_index() callback: In this mode, the drivers using cpufre=
q core
+simply provide the minimum and maximum frequency limits and an additio=
nal
+interface target_index() to set the current frequency. The cpufreq sub=
system
+has a number of scaling governors ("performance", "powersave", "ondema=
nd",
+etc.). Depending on which governor is in use, cpufreq core will call f=
or
+transitions to a specific frequency using target_index() callback.
+- setpolicy() callback: In this mode, drivers do not provide target_in=
dex()
+callback, so cpufreq core can't request a transition to a specific fre=
quency.
+The driver provides minimum and maximum frequency limits and callbacks=
 to set a
+policy. The policy in cpufreq sysfs is referred to as the "scaling gov=
ernor".
+The cpufreq core can request the driver to operate in any of the two p=
olicies:
+"performance: and "powersave". The driver decides which frequency to u=
se based
+on the above policy selection considering minimum and maximum frequenc=
y limits.
+
+The Intel P-State driver falls under the latter category, which implem=
ents the
+setpolicy() callback. This driver decides what P-State to use based on=
 the
+requested policy from the cpufreq core. If the processor is capable of
+selecting its next P-State internally, then the driver will offload th=
is
+responsibility to the processor (aka HWP: Hardware P-States). If not, =
the
+driver implements algorithms to select the next P-State.
+
+Since these policies are implemented in the driver, they are not same =
as the
+cpufreq scaling governors implementation, even if they have the same n=
ame in
+the cpufreq sysfs (scaling_governors). For example the "performance" p=
olicy is
+similar to cpufreq=E2=80=99s "performance" governor, but "powersave" i=
s completely
+different than the cpufreq "powersave" governor. The strategy here is =
similar
+to cpufreq "ondemand", where the requested P-State is related to the s=
ystem load.
+
+Sysfs Interface
+
+In addition to the frequency-controlling interfaces provided by the cp=
ufreq
+core, the driver provides its own sysfs files to control the P-State s=
election.
+These files have been added to /sys/devices/system/cpu/intel_pstate/.
+Any changes made to these files are applicable to all CPUs (even in a
+multi-package system).
+
+      max_perf_pct: Limits the maximum P-State that will be requested =
by
+      the driver. It states it as a percentage of the available perfor=
mance. The
+      available (P-State) performance may be reduced by the no_turbo
       setting described below.
=20
-      min_perf_pct: limits the minimum P state that will be  requested=
 by
-      the driver stated as a percentage of the max (non-turbo)
+      min_perf_pct: Limits the minimum P-State that will be requested =
by
+      the driver. It states it as a percentage of the max (non-turbo)
       performance level.
=20
-      no_turbo: limits the driver to selecting P states below the turb=
o
+      no_turbo: Limits the driver to selecting P-State below the turbo
       frequency range.
=20
-      turbo_pct: displays the percentage of the total performance that
-      is supported by hardware that is in the turbo range.  This numbe=
r
+      turbo_pct: Displays the percentage of the total performance that
+      is supported by hardware that is in the turbo range. This number
       is independent of whether turbo has been disabled or not.
=20
-      num_pstates: displays the number of pstates that are supported
-      by hardware.  This number is independent of whether turbo has
+      num_pstates: Displays the number of P-States that are supported
+      by hardware. This number is independent of whether turbo has
       been disabled or not.
=20
+For example, if a system has these parameters:
+	Max 1 core turbo ratio: 0x21 (Max 1 core ratio is the maximum P-State=
)
+	Max non turbo ratio: 0x17
+	Minimum ratio : 0x08 (Here the ratio is called max efficiency ratio)
+
+Sysfs will show :
+	max_perf_pct:100, which corresponds to 1 core ratio
+	min_perf_pct:24, max_efficiency_ratio / max 1 Core ratio
+	no_turbo:0, turbo is not disabled
+	num_pstates:26 =3D (max 1 Core ratio - Max Efficiency Ratio + 1)
+	turbo_pct:39 =3D (max 1 core ratio - max non turbo ratio) / num_pstat=
es
+
+Refer to "Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=
=80=99s Manual
+Volume 3: System Programming Guide" to understand ratios.
+
+cpufreq sysfs for Intel P-State
+
+Since this driver registers with cpufreq, cpufreq sysfs is also presen=
ted.
+There are some important differences, which need to be considered.
+
+scaling_cur_freq: This displays the real frequency which was used duri=
ng
+the last sample period instead of what is requested. Some other cpufre=
q driver,
+like acpi-cpufreq, displays what is requested (Some changes are on the
+way to fix this for acpi-cpufreq driver). The same is true for frequen=
cies
+displayed at /proc/cpuinfo.
+
+scaling_governor: This displays current active policy. Since each CPU =
has a
+cpufreq sysfs, it is possible to set a scaling governor to each CPU. B=
ut this
+is not possible with Intel P-States, as there is one common policy for=
 all
+CPUs. Here, the last requested policy will be applicable to all CPUs. =
It is
+suggested that one use the cpupower utility to change policy to all CP=
Us at the
+same time.
+
+scaling_setspeed: This attribute can never be used with Intel P-State.
+
+scaling_max_freq/scaling_min_freq: This interface can be used similarl=
y to
+the max_perf_pct/min_perf_pct of Intel P-State sysfs. However since fr=
equencies
+are converted to nearest possible P-State, this is prone to rounding e=
rrors.
+This method is not preferred to limit performance.
+
+affected_cpus: Not used
+related_cpus: Not used
+
 For contemporary Intel processors, the frequency is controlled by the
-processor itself and the P-states exposed to software are related to
+processor itself and the P-State exposed to software are related to
 performance levels.  The idea that frequency can be set to a single
-frequency is fiction for Intel Core processors. Even if the scaling
-driver selects a single P state the actual frequency the processor
+frequency is fictional for Intel Core processors. Even if the scaling
+driver selects a single P-State, the actual frequency the processor
 will run at is selected by the processor itself.
=20
-For legacy mode debugfs files have also been added to allow tuning of
-the internal governor algorythm. These files are located at
-/sys/kernel/debug/pstate_snb/ These files are NOT present in HWP mode.
+Tuning Intel P-State driver
+
+When HWP mode is not used, debugfs files have also been added to allow=
 the
+tuning of the internal governor algorithm. These files are located at
+/sys/kernel/debug/pstate_snb/. The algorithm uses a PID (A proportiona=
l=E2=80=93
+integral=E2=80=93derivative) controller. The PID tuninable parameters =
are:
=20
       deadband
       d_gain_pct
@@ -63,3 +133,42 @@ the internal governor algorythm. These files are lo=
cated at
       p_gain_pct
       sample_rate_ms
       setpoint
+
+To adjust these parameters, some understanding of driver implementatio=
n is
+necessary. There are some tweeks described here, but be very careful. =
Adjusting
+them requires expert level understanding of power and performance rela=
tionship.
+These limits are only useful when the "powersave" policy is active.
+
+-To make the system more responsive to load changes, sample_rate_ms ca=
n
+be adjusted  (current default is 10ms).
+-To make the system use higher performance, even if the load is lower,=
 setpoint
+can be adjusted to a lower number. This will also lead to faster ramp =
up time
+to reach the maximum P-State.
+If there are no derivative and integral coefficients, The next P-State=
 will be
+equal to:
+	current P-State - ((setpoint - current cpu load) * p_gain_pct)
+
+For example, if the current PID parameters are (Which are defaults for=
 the core
+processors like SandyBridge):
+      deadband =3D 0
+      d_gain_pct =3D 0
+      i_gain_pct =3D 0
+      p_gain_pct =3D 20
+      sample_rate_ms =3D 10
+      setpoint =3D 97
+
+If the current P-State =3D 0x08 and current load =3D 100, this will re=
sult in the
+next P-State =3D 0x08 - ((97 - 100) * 0.2) =3D 8.6 (rounded to 9). Her=
e the P-State
+goes up by only 1. If during next sample interval the current load doe=
sn't
+change and still 100, then P-State goes up by one again. This process =
will
+continue as long as the load is more than the setpoint until the maxim=
um P-State
+is reached.
+
+For the same load at setpoint =3D 60, this will result in the next P-S=
tate
+=3D 0x08 - ((60 - 100) * 0.2) =3D 16
+So by changing the setpoint from 97 to 60, there is an increase of the
+next P-State from 9 to 16. So this will make processor execute at high=
er
+P-State for the same CPU load. If the load continues to be more than t=
he
+setpoint during next sample intervals, then P-State will go up again t=
ill the
+maximum P-State is reached. But the ramp up time to reach the maximum =
P-State
+will be much faster when the setpoint is 60 compared to 97.
--=20
2.4.3


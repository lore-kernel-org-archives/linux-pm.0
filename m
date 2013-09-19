From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 1/6] PowerCap: Documentation
Date: Thu, 19 Sep 2013 09:00:30 -0700
Message-ID: <1379606435-15871-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1379606435-15871-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, len.brown@intel.com, rjw@sisk.pl, arjan@linux.intel.com, jacob.jun.pan@linux.intel.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Added power cap framework documentation. This explains the use of power=
 capping
framework, sysfs and programming interface.
There are two documents:
Documentation/power/powercap/powercap.txt : Explains use case and APIs.
Documentation/ABI/testing/sysfs-class-powercap: Explains ABIs.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-class-powercap | 152 ++++++++++++++++
 Documentation/power/powercap/powercap.txt      | 236 +++++++++++++++++=
++++++++
 2 files changed, 388 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-powercap
 create mode 100644 Documentation/power/powercap/powercap.txt

diff --git a/Documentation/ABI/testing/sysfs-class-powercap b/Documenta=
tion/ABI/testing/sysfs-class-powercap
new file mode 100644
index 0000000..db3b3ff
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-powercap
@@ -0,0 +1,152 @@
+What:		/sys/class/powercap/
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		The powercap/ class sub directory belongs to the power cap
+		subsystem. Refer to
+		Documentation/power/powercap/powercap.txt for details.
+
+What:		/sys/class/powercap/<control type>
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		A <control type> is a unique name under /sys/class/powercap.
+		Here <control type> determines how the power is going to be
+		controlled. A <control type> can contain multiple power zones.
+
+What:		/sys/class/powercap/<control type>/enabled
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		This allows to enable/disable power capping for a "control type".
+		This status affects every power zone using this "control_type.
+
+What:		/sys/class/powercap/<control type>/<power zone>
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		A power zone is a single or a collection of devices, which can
+		be independently monitored and controlled. A power zone sysfs
+		entry is qualified with the name of the <control type>.
+		E.g. intel-rapl:0:1:1.
+
+What:		/sys/class/powercap/<control type>/<power zone>/<child power zo=
ne>
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Power zones may be organized in a hierarchy in which child
+		power zones provide monitoring and control for a subset of
+		devices under the parent. For example, if there is a parent
+		power zone for a whole CPU package, each CPU core in it can
+		be a child power zone.
+
+What:		/sys/class/powercap/.../<power zone>/name
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Specifies the name of this power zone.
+
+What:		/sys/class/powercap/.../<power zone>/energy_uj
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Current energy counter in micro-joules. Write "0" to reset.
+		If the counter can not be reset, then this attribute is
+		read-only.
+
+What:		/sys/class/powercap/.../<power zone>/max_energy_range_uj
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Range of the above energy counter in micro-joules.
+
+
+What:		/sys/class/powercap/.../<power zone>/power_uw
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Current power in micro-watts.
+
+What:		/sys/class/powercap/.../<power zone>/max_power_range_uw
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Range of the above power value in micro-watts.
+
+What:		/sys/class/powercap/.../<power zone>/constraint_X_name
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Each power zone can define one or more constraints. Each
+		constraint can have an optional name. Here "X" can have values
+		from 0 to max integer.
+
+What:		/sys/class/powercap/.../<power zone>/constraint_X_power_limit_u=
w
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Power limit in micro-watts should be applicable for
+		the time window specified by "constraint_X_time_window_us".
+		Here "X" can have values from 0 to max integer.
+
+What:		/sys/class/powercap/.../<power zone>/constraint_X_time_window_u=
s
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Time window in micro seconds. This is used along with
+		constraint_X_power_limit_uw to define a power constraint.
+		Here "X" can have values from 0 to max integer.
+
+
+What:		/sys/class/powercap/<control type>/.../constraint_X_max_power_u=
w
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowed power in micro watts for this constraint.
+		Here "X" can have values from 0 to max integer.
+
+What:		/sys/class/powercap/<control type>/.../constraint_X_min_power_u=
w
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum allowed power in micro watts for this constraint.
+		Here "X" can have values from 0 to max integer.
+
+What:		/sys/class/powercap/.../<power zone>/constraint_X_max_time_wind=
ow_us
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Maximum allowed time window in micro seconds for this
+		constraint. Here "X" can have values from 0 to max integer.
+
+What:		/sys/class/powercap/.../<power zone>/constraint_X_min_time_wind=
ow_us
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Minimum allowed time window in micro seconds for this
+		constraint. Here "X" can have values from 0 to max integer.
+
+What:		/sys/class/powercap/.../<power zone>/enabled
+Date:		September 2013
+KernelVersion:	3.13
+Contact:	linux-pm@vger.kernel.org
+Description
+		This allows to enable/disable power capping at power zone level.
+		This applies to current power zone and its children.
diff --git a/Documentation/power/powercap/powercap.txt b/Documentation/=
power/powercap/powercap.txt
new file mode 100644
index 0000000..8d83bb3
--- /dev/null
+++ b/Documentation/power/powercap/powercap.txt
@@ -0,0 +1,236 @@
+Power Capping Framework
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The power capping framework provides a consistent interface between th=
e kernel
+and the user space that allows power capping drivers to expose the set=
tings to
+user space in a uniform way.
+
+Terminology
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+The framework exposes power capping devices to user space via sysfs in=
 the
+form of a tree of objects. The objects at the root level of the tree r=
epresent
+'control types', which correspond to different methods of power cappin=
g.  For
+example, the intel-rapl control type represents the Intel "Running Ave=
rage
+Power Limit" (RAPL) technology, whereas the 'idle-injection' control t=
ype
+corresponds to the use of idle injection for controlling power.
+
+Power zones represent different parts of the system, which can be cont=
rolled and
+monitored using the power capping method determined by the control typ=
e the
+given zone belongs to. They each contain attributes for monitoring pow=
er, as
+well as controls represented in the form of power constraints.  If the=
 parts of
+the system represented by different power zones are hierarchical (that=
 is, one
+bigger part consists of multiple smaller parts that each have their ow=
n power
+controls), those power zones may also be organized in a hierarchy with=
 one
+parent power zone containing multiple subzones and so on to reflect th=
e power
+control topology of the system.  In that case, it is possible to apply=
 power
+capping to a set of devices together using the parent power zone and i=
f more
+fine grained control is required, it can be applied through the subzon=
es.
+
+
+Example sysfs interface tree:
+
+/sys/devices/virtual/powercap
+=E2=94=94=E2=94=80=E2=94=80 intel-rapl
+    =E2=94=9C=E2=94=80=E2=94=80 intel-rapl:0
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_0_nam=
e
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_0_pow=
er_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_0_tim=
e_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_1_nam=
e
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_1_pow=
er_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_1_tim=
e_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 device -> ../../=
intel-rapl
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 energy_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 intel-rapl:0:0
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 device -> ../../intel-rapl:0
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 energy_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 max_energy_range_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
=E2=94=9C=E2=94=80=E2=94=80 async
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
[]
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 subsystem -> ../../../../../../class/power_cap
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 uevent
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 intel-rapl:0:1
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 device -> ../../intel-rapl:0
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 energy_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 max_energy_range_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
=E2=94=9C=E2=94=80=E2=94=80 async
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
[]
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 subsystem -> ../../../../../../class/power_cap
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 uevent
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 max_energy_range=
_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 max_power_range_=
uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 async
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 []
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../=
=2E./../../../class/power_cap
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 uevent
+    =E2=94=9C=E2=94=80=E2=94=80 intel-rapl:1
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_0_nam=
e
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_0_pow=
er_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_0_tim=
e_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_1_nam=
e
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_1_pow=
er_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 constraint_1_tim=
e_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 device -> ../../=
intel-rapl
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 energy_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 intel-rapl:1:0
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 device -> ../../intel-rapl:1
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 energy_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 max_energy_range_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
=E2=94=9C=E2=94=80=E2=94=80 async
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
[]
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 subsystem -> ../../../../../../class/power_cap
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 uevent
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 intel-rapl:1:1
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_0_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_power_limit_uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 constraint_1_time_window_us
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 device -> ../../intel-rapl:1
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 energy_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 max_energy_range_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
=E2=94=9C=E2=94=80=E2=94=80 async
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =
[]
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 subsystem -> ../../../../../../class/power_cap
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=
=80 uevent
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 max_energy_range=
_uj
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 max_power_range_=
uw
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 name
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 enabled
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=
=80 async
+    =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 []
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../=
=2E./../../../class/power_cap
+    =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 uevent
+    =E2=94=9C=E2=94=80=E2=94=80 power
+    =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 async
+    =E2=94=82=C2=A0=C2=A0 []
+    =E2=94=9C=E2=94=80=E2=94=80 subsystem -> ../../../../class/power_c=
ap
+    =E2=94=9C=E2=94=80=E2=94=80 enabled
+    =E2=94=94=E2=94=80=E2=94=80 uevent
+
+The above example illustrates a case in which the Intel RAPL technolog=
y,
+available in Intel=C2=AE IA-64 and IA-32 Processor Architectures, is u=
sed. There is one
+control type called intel-rapl which contains two power zones, intel-r=
apl:0 and
+intel-rapl:1, representing CPU packages.  Each of these power zones co=
ntains
+two subzones, intel-rapl:j:0 and intel-rapl:j:1 (j =3D 0, 1), represen=
ting the
+"core" and the "uncore" parts of the given CPU package, respectively. =
 All of
+the zones and subzones contain energy monitoring attributes (energy_uj=
,
+max_energy_range_uj) and constraint attributes (constraint_*) allowing=
 controls
+to be applied (the constraints in the 'package' power zones apply to t=
he whole
+CPU packages and the subzone constraints only apply to the respective =
parts of
+the given package individually). Since Intel RAPL doesn't provide inst=
antaneous
+power value, there is no power_uw attribute.
+
+In addition to that, each power zone contains a name attribute, allowi=
ng the
+part of the system represented by that zone to be identified.
+For example:
+
+cat /sys/class/power_cap/intel-rapl/intel-rapl:0/name
+package-0
+
+The Intel RAPL technology allows two constraints, short term and long =
term,
+with two different time windows to be applied to each power zone.  Thu=
s for
+each zone there are 2 attributes representing the constraint names, 2 =
power
+limits and 2 attributes representing the sizes of the time windows. Su=
ch that,
+constraint_j_* attributes correspond to the jth constraint (j =3D 0,1)=
=2E
+
+For example:
+	constraint_0_name
+	constraint_0_power_limit_uw
+	constraint_0_time_window_us
+	constraint_1_name
+	constraint_1_power_limit_uw
+	constraint_1_time_window_us
+
+Power Zone Attributes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Monitoring attributes
+----------------------
+
+energy_uj (rw): Current energy counter in micro joules. Write "0" to r=
eset.
+If the counter can not be reset, then this attribute is read only.
+
+max_energy_range_uj (ro): Range of the above energy counter in micro-j=
oules.
+
+power_uw (ro): Current power in micro watts.
+
+max_power_range_uw (ro): Range of the above power value in micro-watts=
=2E
+
+name (ro): Name of this power zone.
+
+It is possible that some domains have both power ranges and energy cou=
nter ranges;
+however, only one is mandatory.
+
+Constraints
+----------------
+constraint_X_power_limit_uw (rw): Power limit in micro watts, which sh=
ould be
+applicable for the time window specified by "constraint_X_time_window_=
us".
+
+constraint_X_time_window_us (rw): Time window in micro seconds.
+
+constraint_X_name (ro): An optional name of the constraint
+
+constraint_X_max_power_uw(ro): Maximum allowed power in micro watts.
+
+constraint_X_min_power_uw(ro): Minimum allowed power in micro watts.
+
+constraint_X_max_time_window_us(ro): Maximum allowed time window in mi=
cro seconds.
+
+constraint_X_min_time_window_us(ro): Minimum allowed time window in mi=
cro seconds.
+
+Except power_limit_uw and time_window_us other fields are optional.
+
+Common zone and control type attributes
+----------------------------------------
+enabled (rw): Enable/Disable controls at zone level or for all zones u=
sing
+a control type.
+
+Power Cap Client Driver Interface
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+The API summary:
+
+Call powercap_register_control_type() to register control type object.
+Call powercap_register_zone() to register a power zone (under a given
+control type), either as a top-level power zone or as a subzone of ano=
ther
+power zone registered earlier.
+The number of constraints in a power zone and the corresponding callba=
cks have
+to be defined prior to calling powercap_register_zone() to register th=
at zone.
+
+To Free a power zone call powercap_unregister_zone().
+To free a control type object call powercap_unregister_control_type().
+Detailed API can be generated using kernel-doc on include/linux/powerc=
ap.h.
--=20
1.8.3.1

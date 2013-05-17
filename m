From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: =?UTF-8?q?=5BPATCH=203/3=5D=20Thermal=3A=20Documentation=20for=20x86=20package=20temperature=20thermal=20driver?=
Date: Fri, 17 May 2013 16:42:03 -0700
Message-ID: <1368834123-9591-4-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1368834123-9591-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:25402 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab3EQXhR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 May 2013 19:37:17 -0400
In-Reply-To: <1368834123-9591-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: eduardo.valentin@ti.com, rui.zhang@intel.com, tony.luck@intel.com, linux-edac@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added documentation describing details of the x86 package temperature
thermal driver.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com=
>
---
 Documentation/thermal/x86_pkg_temperature_thermal | 47 +++++++++++++++=
++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/thermal/x86_pkg_temperature_thermal

diff --git a/Documentation/thermal/x86_pkg_temperature_thermal b/Docume=
ntation/thermal/x86_pkg_temperature_thermal
new file mode 100644
index 0000000..17a3a4c
--- /dev/null
+++ b/Documentation/thermal/x86_pkg_temperature_thermal
@@ -0,0 +1,47 @@
+Kernel driver: x86_pkg_temp_thermal
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Supported chips:
+* x86: with package level thermal management
+(Verify using: CPUID.06H:EAX[bit 6] =3D1)
+
+Authors: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+
+Reference
+---
+Intel=C2=AE 64 and IA-32 Architectures Software Developer=E2=80=99s Ma=
nual (Jan, 2013):
+Chapter 14.6: PACKAGE LEVEL THERMAL MANAGEMENT
+
+Description
+---------
+
+This driver register CPU digital temperature package level sensor as a=
 thermal
+zone with maximum two user mode configurable trip points. Number of tr=
ip points
+depends on the capability of the package. Once the trip point is viola=
ted,
+user mode can receive notification via thermal notification mechanism =
and can
+take any action to control temperature.
+
+
+Threshold management
+--------------------
+Each package will register as a thermal zone under /sys/class/thermal.
+Example:
+/sys/class/thermal/thermal_zone1
+
+This contains two trip points:
+- trip_point_0_temp
+- trip_point_1_temp
+
+User can set any temperature between 0 to TJ-Max temperature. Temperat=
ure units
+are in milli-degree Celsius. Refer to "Documentation/thermal/sysfs-api=
=2Etxt" for
+thermal sys-fs details.
+
+Any value other than 0 in these trip points, can trigger thermal notif=
ications.
+Setting 0, stops sending thermal notifications.
+
+Thermal notifications: To get kobject-uevent notifications, set the th=
ermal zone
+policy to "user_space". For example: echo -n "user_space" > policy
+
+
+
+
--=20
1.7.11.7


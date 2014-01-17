From: Durgadoss R <durgadoss.r@intel.com>
Subject: [PATCHv5 RESEND 09/10] Thermal: Add ABI Documentation for sysfs interfaces
Date: Fri, 17 Jan 2014 18:57:02 +0530
Message-ID: <1389965222-2537-3-git-send-email-durgadoss.r@intel.com>
References: <1389965222-2537-1-git-send-email-durgadoss.r@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42490 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbaAQH7A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jan 2014 02:59:00 -0500
In-Reply-To: <1389965222-2537-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hongbo.zhang@freescale.com, wni@nvidia.com, Durgadoss R <durgadoss.r@intel.com>

This patch adds Documentation for ABI's introduced
for thermal subsystem (under /sys/class/thermal/).

Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
---
 Documentation/ABI/testing/sysfs-class-thermal |  161 +++++++++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-thermal

diff --git a/Documentation/ABI/testing/sysfs-class-thermal b/Documentation/ABI/testing/sysfs-class-thermal
new file mode 100644
index 0000000..144efc1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-thermal
@@ -0,0 +1,161 @@
+What:		/sys/class/thermal/sensorX/temp
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Exposes 'temperature' of a thermal sensor in mC
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/sensorX/name
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Name of the thermal sensor
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/sensorX/thresholdY
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Programmable threshold (in terms of mC). On reaching
+		this, the thermal governors may take action to control
+		temperature.
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/cdevX/type
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Type of the cooling device
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/cdevX/cur_state
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Current throttle state the cooling device is in
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/cdevX/max_state
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Maximum number of throttle states the cooling device supports
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/zone_name
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Name of the thermal zone.
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/sensorY
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Symlink to a sensor associated with this zone.
+Users:		User space thermal governors or applications
+
+What:		/sys/class/thermal/zoneX/cooling_deviceY
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Symlink to a cooling device associated with this zone.
+Users:		User space thermal governors or applications
+
+What:		/sys/class/thermal/zoneX/sensorY_trip_activeM
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Active Trip point temperature in mC for sensorY in
+		thermal zoneX.
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/sensorY_trip_passiveN
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Passive Trip point temperature in mC for sensorY in
+		thermal zoneX.
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/sensorY_trip_hot
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Hot trip point for 'sensorY' in 'zoneX' (in mC).
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/sensorY_trip_critical
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Critical trip point for 'sensorY' in 'zoneX' (in mC).
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/mapY_trip_type
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Mapping information between a sensor and a cooling device
+		in 'zoneX'. This interface provides the trip_type for a
+		particular map(Y).
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/mapY_sensor_name
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Mapping information between a sensor and a cooling device
+		in 'zoneX'. This interface provides the name of the sensor
+		used in this map(Y).
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/mapY_cdev_name
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Mapping information between a sensor and a cooling device
+		in 'zoneX'. This interface provides the name of the cooling
+		device used in this map(Y).
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/mapY_trip_mask
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Mapping information between a sensor and a cooling device
+		in 'zoneX'. This interface provides the trip point mask,
+		which defines whether or not to throttle a particular
+		cooling device. See Documentation/thermal/sysfs-api2.txt
+		for more information on this interface.
+Users:		Kernel/User space thermal governors
+
+What:		/sys/class/thermal/zoneX/mapY_weightN
+Date:		January 2014
+KernelVersion:	3.13
+Contact:	Linux PM Mailing list <linux-pm@vger.kernel.org>
+Description:
+		Mapping information between a sensor and a cooling device
+		in 'zoneX'. This interface provides the weights that can
+		be used to throttle a cooling device, on thermal violations.
+		See Documentation/thermal/sysfs-api2.txt for more details on
+		this interface.
+Users:		Kernel/User space thermal governors
-- 
1.7.9.5


From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 04/11] Doc: thermal: new irq-mode for trip point
Date: Wed,  7 Nov 2018 18:09:46 +0100
Message-ID: <1541610593-28542-5-git-send-email-l.luba@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171038eucas1p1eb5dce12a1f5f7a3587f82f8396fa075@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Thermal trip point gets new flag in DT: irq-mode.
Trip point may have a new explicit flag which indicate
IRQ support when the temperature is met (so the thermal framework
deos not need to set polling for it).
It is useful for 'passive' cooling trip point,
which now will not be register for polling the temperature.

Update documentation about irq-mode for trip points.
The new sysfs file shows 1 if the trip point supports IRQ.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 Documentation/thermal/sysfs-api.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
index 9113997..e405724 100644
--- a/Documentation/thermal/sysfs-api.txt
+++ b/Documentation/thermal/sysfs-api.txt
@@ -272,6 +272,7 @@ Thermal zone device sys I/F, created once it's registered:
     |---trip_point_[0-*]_temp:	Trip point temperature
     |---trip_point_[0-*]_type:	Trip point type
     |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
+    |---trip_point_[0-*]_irq:	Trip point supports triggering irq
     |---emul_temp:		Emulated temperature set node
     |---sustainable_power:      Sustainable dissipatable power
     |---k_po:                   Proportional term during temperature overshoot
@@ -365,6 +366,10 @@ trip_point_[0-*]_type
 	thermal zone.
 	RO, Optional
 
+trip_point_[0-*]_irq
+	Boolean which indicate that the trip point triggers irq.
+	RO, Optional
+
 trip_point_[0-*]_hyst
 	The hysteresis value for a trip point, represented as an integer
 	Unit: Celsius
@@ -544,12 +549,16 @@ method, the sys I/F structure will be built like this:
     |---available_policies:	step_wise fair_share
     |---trip_point_0_temp:	100000
     |---trip_point_0_type:	critical
+    |---trip_point_0_irq:	1
     |---trip_point_1_temp:	80000
     |---trip_point_1_type:	passive
+    |---trip_point_1_irq:	1
     |---trip_point_2_temp:	70000
     |---trip_point_2_type:	active0
+    |---trip_point_2_irq:	0
     |---trip_point_3_temp:	60000
     |---trip_point_3_type:	active1
+    |---trip_point_3_irq:	1
     |---cdev0:			--->/sys/class/thermal/cooling_device0
     |---cdev0_trip_point:	1	/* cdev0 can be used for passive */
     |---cdev0_weight:           1024
-- 
2.7.4

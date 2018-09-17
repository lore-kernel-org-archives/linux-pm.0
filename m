From: Karsten Mueller <mueller.k@efe-gmbh.de>
Subject: [PATCH 3/3] Add sysfs ABI for bq2416x
Date: Mon, 17 Sep 2018 14:37:29 +0200
Message-ID: <20180917123729.23461-3-mueller.k@efe-gmbh.de>
References: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917123729.23461-1-mueller.k@efe-gmbh.de>
Sender: linux-kernel-owner@vger.kernel.org
To: mueller.k@efe-gmbh.de
Cc: renner@efe-gmbh.de, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Karsten Mueller <mueller.k@efe-gmbh.de>
---
 Documentation/ABI/testing/sysfs-class-power | 118 ++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 5e23e22dc..3881485ca 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -587,3 +587,121 @@ Description:
 		Valid values:
 		- 1: enabled
 		- 0: disabled
+
+What:		/sys/class/power_supply/bq2416x-charger/usb_curr_limit
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports and sets the maximum current the "usb" supply can
+		support.
+
+		Access: Read, Write
+		Valid values:
+		- 100000, 150000, 500000, 800000, 900000, 1500000 (uA)
+
+What:		/sys/class/power_supply/bq2416x-charger/in_curr_limit
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports and sets the maximum current the "in" (wall) supply can
+		support.
+
+		Access: Read, Write
+		Valid values:
+		- 1500000, 2500000 (uA)
+
+What:		/sys/class/power_supply/bq2416x-charger/in_dpm_voltage
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry configures the "in" (wall) input dynamic power path
+		management voltage of bq2416x-type charger devices. Once the
+		supply drops to the configured voltage, the input current limit
+		is reduced down to prevent the further drop of the supply. When
+		the IC enters this mode, the charge current is lower than the
+		set value.
+
+		Access: Read, Write
+		Valid values:
+		- 4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
+		  4760000 (all uV)
+
+What:		/sys/class/power_supply/bq2416x-charger/usb_dpm_voltage
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry configures the "usb" input dynamic power path
+		management voltage of bq2416x-type charger devices. Once the
+		supply drops to the configured voltage, the input current limit
+		is reduced down to prevent the further drop of the supply. When
+		the IC enters this mode, the charge current is lower than the
+		set value.
+
+		Access: Read, Write
+		Valid values:
+		- 4200000, 4280000, 4360000, 4440000, 4520000, 4600000, 4680000,
+		  4760000 (all uV)
+
+What:		/sys/class/power_supply/bq2416x-charger/high_impedance_enable
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry allows enabling the high-impedance mode of
+		bq2416x-type charger devices. If enabled, it places the charger
+		IC into low power standby mode with the switch mode controller
+		disabled. When disabled, the charger operates normally.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/bq2416x-charger/dpm_status
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports whether dynamic power management is active, i.e. input
+		current of used source is limited to prevent further drop of
+		voltage.
+
+		Valid values:
+		- 0: not active
+		- 1: active
+
+What:		/sys/class/power_supply/bq2416x-charger/supply_sel
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		This entry configures which input ("in", "usb") should be
+		preferred as input source.
+
+		Valid values:
+		- "in", "usb"
+
+What:		/sys/class/power_supply/bq2416x-charger/ts_fault
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports state of NTC temperature monitor.
+
+		Valid values:
+		- "normal", "cold/hot(charge suspended)",
+		  "cool(half current charge)", "warm(voltage reduced)"
+
+What:		/sys/class/power_supply/bq2416x-charger/in_status
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports state of "in" input source.
+
+		Valid values:
+		- "Normal", "OVP", "Weak source", "Faulty Adapter"
+
+What:		/sys/class/power_supply/bq2416x-charger/usb_status
+Date:		September 2018
+Contact:	Karsten Mueller <mueller.k@efe-gmbh.de>
+Description:
+		Reports state of "usb" input source.
+
+		Valid values:
+		- "Normal", "OVP", "Weak source", "Faulty Adapter"
-- 
2.17.1

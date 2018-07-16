From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 3/3] regulator: bd9571mwv: Document "backup_mode" sysfs file
Date: Mon, 16 Jul 2018 17:30:52 +0200
Message-ID: <20180716153052.1830-4-geert+renesas@glider.be>
References: <20180716153052.1830-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716153052.1830-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
v4:
  - Add Acked-by,

v3:
  - New.
---
 .../testing/sysfs-driver-bd9571mwv-regulator  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator

diff --git a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
new file mode 100644
index 0000000000000000..4d63a7904b94a993
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
@@ -0,0 +1,27 @@
+What:		/sys/bus/i2c/devices/.../bd9571mwv-regulator.*.auto/backup_mode
+Date:		Jul 2018
+KernelVersion:	4.19
+Contact:	Geert Uytterhoeven <geert+renesas@glider.be>
+Description:	Read/write the current state of DDR Backup Mode, which controls
+		if DDR power rails will be kept powered during system suspend.
+		("on"/"1" = enabled, "off"/"0" = disabled).
+		Two types of power switches (or control signals) can be used:
+		  A. With a momentary power switch (or pulse signal), DDR
+		     Backup Mode is enabled by default when available, as the
+		     PMIC will be configured only during system suspend.
+		  B. With a toggle power switch (or level signal), the
+		     following steps must be followed exactly:
+		       1. Configure PMIC for backup mode, to change the role of
+			  the accessory power switch from a power switch to a
+			  wake-up switch,
+		       2. Switch accessory power switch off, to prepare for
+			  system suspend, which is a manual step not controlled
+			  by software,
+		       3. Suspend system,
+		       4. Switch accessory power switch on, to resume the
+			  system.
+		     DDR Backup Mode must be explicitly enabled by the user,
+		     to invoke step 1.
+		See also Documentation/devicetree/bindings/mfd/bd9571mwv.txt.
+Users:		User space applications for embedded boards equipped with a
+		BD9571MWV PMIC.
-- 
2.17.1

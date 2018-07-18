From: Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: bd9571mwv: Document "backup_mode" sysfs file" to the regulator tree
Date: Wed, 18 Jul 2018 13:29:38 +0100
Message-ID: <E1fflaM-0007Sj-2K@debutante>
References: <20180716153052.1830-4-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716153052.1830-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pavel Machek <pavel@ucw.cz>, Mark Brown <broonie@kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.orglinux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patch

   regulator: bd9571mwv: Document "backup_mode" sysfs file

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cf18fd01466d59263c615165341684a055206dd5 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 16 Jul 2018 17:30:52 +0200
Subject: [PATCH] regulator: bd9571mwv: Document "backup_mode" sysfs file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/sysfs-driver-bd9571mwv-regulator  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator

diff --git a/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator b/Documentation/ABI/testing/sysfs-driver-bd9571mwv-regulator
new file mode 100644
index 000000000000..4d63a7904b94
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
2.18.0

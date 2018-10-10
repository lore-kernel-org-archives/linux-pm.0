From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 05/15] Platform: OLPC: Move OLPC config symbol out of x86 tree
Date: Wed, 10 Oct 2018 19:22:50 +0200
Message-ID: <20181010172300.317643-6-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Cameron <quozl@laptop.org>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, devel@driverdev.osuosl.org, linux-pm@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

There are ARM OLPC machines that use mostly the same drivers, including
EC infrastructure, DCON and Battery.

While at that, fix Kconfig to allow building this as a module.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/x86/Kconfig                  | 11 -----------
 drivers/input/mouse/Kconfig       |  2 +-
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/olpc/Kconfig     | 11 +++++++++++
 drivers/staging/olpc_dcon/Kconfig |  2 +-
 5 files changed, 15 insertions(+), 13 deletions(-)
 create mode 100644 drivers/platform/olpc/Kconfig

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..be6af341a718 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2729,17 +2729,6 @@ config SCx200HR_TIMER
 	  processor goes idle (as is done by the scheduler).  The
 	  other workaround is idle=3Dpoll boot option.
=20
-config OLPC
-	bool "One Laptop Per Child support"
-	depends on !X86_PAE
-	select GPIOLIB
-	select OF
-	select OF_PROMTREE
-	select IRQ_DOMAIN
-	---help---
-	  Add support for detecting the unique features of the OLPC
-	  XO hardware.
-
 config OLPC_XO1_PM
 	bool "OLPC XO-1 Power Management"
 	depends on OLPC && MFD_CS5535 && PM_SLEEP
diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 566a1e3aa504..58034892a4df 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -165,7 +165,7 @@ config MOUSE_PS2_TOUCHKIT
=20
 config MOUSE_PS2_OLPC
 	bool "OLPC PS/2 mouse protocol extension"
-	depends on MOUSE_PS2 && OLPC
+	depends on MOUSE_PS2 && X86 && OLPC
 	help
 	  Say Y here if you have an OLPC XO-1 laptop (with built-in
 	  PS/2 touchpad/tablet device).  The manufacturer calls the
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index d4c2e424a700..4313d73d3618 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -10,3 +10,5 @@ source "drivers/platform/goldfish/Kconfig"
 source "drivers/platform/chrome/Kconfig"
=20
 source "drivers/platform/mellanox/Kconfig"
+
+source "drivers/platform/olpc/Kconfig"
diff --git a/drivers/platform/olpc/Kconfig b/drivers/platform/olpc/Kconfi=
g
new file mode 100644
index 000000000000..7b736c9e67ac
--- /dev/null
+++ b/drivers/platform/olpc/Kconfig
@@ -0,0 +1,11 @@
+config OLPC
+	tristate "One Laptop Per Child support"
+	depends on X86 || ARM || COMPILE_TEST
+	depends on !X86_PAE
+	select GPIOLIB
+	select OF
+	select OF_PROMTREE if X86
+	select IRQ_DOMAIN
+	help
+	  Add support for detecting the unique features of the OLPC
+	  XO hardware.
diff --git a/drivers/staging/olpc_dcon/Kconfig b/drivers/staging/olpc_dco=
n/Kconfig
index c91a56f77bcb..07f9f1de8667 100644
--- a/drivers/staging/olpc_dcon/Kconfig
+++ b/drivers/staging/olpc_dcon/Kconfig
@@ -1,6 +1,6 @@
 config FB_OLPC_DCON
 	tristate "One Laptop Per Child Display CONtroller support"
-	depends on OLPC && FB
+	depends on X86 && OLPC && FB
 	depends on I2C
 	depends on (GPIO_CS5535 || GPIO_CS5535=3Dn)
 	select BACKLIGHT_CLASS_DEVICE
--=20
2.19.0

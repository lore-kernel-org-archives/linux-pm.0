From: Phil Reid <preid@electromag.com.au>
Subject: [RFC 2/3] i2c: Kconfig: rename variable I2C_SMBUS to I2C_SMBUS_ALERT
Date: Tue, 21 Nov 2017 12:04:57 +0800
Message-ID: <1511237098-33250-3-git-send-email-preid@electromag.com.au>
References: <1511237098-33250-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1511237098-33250-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: realmz6@gmail.com, wsa@the-dreams.de, sre@kernel.org, preid@electromag.com.au, benjamin.tissoires@redhat.com, adi-buildroot-devel@lists.sourceforge.net, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, jdelvare@suse.de
List-Id: linux-pm@vger.kernel.org

i2c-smbus now only contains code related to the smbus_alert driver.
Other smbus protocols have been moved from this into the i2c-core-smbus.
Change the Kconfig variable name to reflect this.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 arch/blackfin/configs/BF527-TLL6527M_defconfig |  2 +-
 drivers/i2c/Kconfig                            | 11 +++++------
 drivers/i2c/Makefile                           |  2 +-
 drivers/i2c/busses/Kconfig                     |  8 ++++----
 drivers/i2c/i2c-core-smbus.c                   |  2 +-
 drivers/i2c/i2c-core.h                         |  2 +-
 drivers/power/supply/Kconfig                   |  2 +-
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/blackfin/configs/BF527-TLL6527M_defconfig b/arch/blackfin/configs/BF527-TLL6527M_defconfig
index cdeb518..30f3b5c 100644
--- a/arch/blackfin/configs/BF527-TLL6527M_defconfig
+++ b/arch/blackfin/configs/BF527-TLL6527M_defconfig
@@ -109,7 +109,7 @@ CONFIG_SERIAL_BFIN_UART1=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_I2C_SMBUS=y
+CONFIG_I2C_SMBUS_ALERT=y
 CONFIG_I2C_BLACKFIN_TWI=y
 CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ=100
 CONFIG_GPIOLIB=y
diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index efc3354..fcd4bea 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -55,7 +55,7 @@ config I2C_CHARDEV
 	  programs use the I2C bus.  Information on how to do this is
 	  contained in the file <file:Documentation/i2c/dev-interface>.
 
-	  This support is also available as a module.  If so, the module 
+	  This support is also available as a module.  If so, the module
 	  will be called i2c-dev.
 
 config I2C_MUX
@@ -84,12 +84,11 @@ config I2C_HELPER_AUTO
 
 	  In doubt, say Y.
 
-config I2C_SMBUS
-	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
+config I2C_SMBUS_ALERT
+	tristate "SMBus-alert protocol" if !I2C_HELPER_AUTO
 	help
-	  Say Y here if you want support for SMBus extensions to the I2C
-	  specification. At the moment, two extensions are supported:
-	  the SMBus Alert protocol and the SMBus Host Notify protocol.
+	  Say Y here if you want support for SMBus alert extensions to the I2C
+	  specification.
 
 	  This support is also available as a module.  If so, the module
 	  will be called i2c-smbus.
diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 7bb65a4..b0116a1 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -9,7 +9,7 @@ i2c-core-$(CONFIG_ACPI)		+= i2c-core-acpi.o
 i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
 i2c-core-$(CONFIG_OF) 		+= i2c-core-of.o
 
-obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
+obj-$(CONFIG_I2C_SMBUS_ALERT)	+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
 obj-$(CONFIG_I2C_MUX)		+= i2c-mux.o
 obj-y				+= algos/ busses/ muxes/
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 009345d..310d5ec 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -91,7 +91,7 @@ config I2C_I801
 	tristate "Intel 82801 (ICH/PCH)"
 	depends on PCI
 	select CHECK_SIGNATURE if X86 && DMI
-	select I2C_SMBUS
+	select I2C_SMBUS_ALERT
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
@@ -1056,7 +1056,7 @@ config I2C_OCTEON
 config I2C_THUNDERX
 	tristate "Cavium ThunderX I2C bus support"
 	depends on 64BIT && PCI && (ARM64 || COMPILE_TEST)
-	select I2C_SMBUS
+	select I2C_SMBUS_ALERT
 	help
 	  Say yes if you want to support the I2C serial bus on Cavium
 	  ThunderX SOC.
@@ -1132,7 +1132,7 @@ config I2C_PARPORT
 	tristate "Parallel port adapter"
 	depends on PARPORT
 	select I2C_ALGOBIT
-	select I2C_SMBUS
+	select I2C_SMBUS_ALERT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
@@ -1156,7 +1156,7 @@ config I2C_PARPORT
 config I2C_PARPORT_LIGHT
 	tristate "Parallel port adapter (light)"
 	select I2C_ALGOBIT
-	select I2C_SMBUS
+	select I2C_SMBUS_ALERT
 	help
 	  This supports parallel port I2C adapters such as the ones made by
 	  Philips or Velleman, Analog Devices evaluation boards, and more.
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 4bb9927..f4c3b18 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -626,7 +626,7 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 }
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
+#if IS_ENABLED(CONFIG_I2C_SMBUS_ALERT) && IS_ENABLED(CONFIG_OF)
 int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
 {
 	struct i2c_client *client;
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 8ef0402..2ee5396 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -61,7 +61,7 @@ static inline void of_i2c_register_devices(struct i2c_adapter *adap) { }
 #endif
 extern struct notifier_block i2c_of_notifier;
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
+#if IS_ENABLED(CONFIG_I2C_SMBUS_ALERT) && IS_ENABLED(CONFIG_OF)
 int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
 #else
 static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index fbca0ba..fac8252 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -187,7 +187,7 @@ config CHARGER_SBS
 config MANAGER_SBS
 	tristate "Smart Battery System Manager"
 	depends on I2C && I2C_MUX && GPIOLIB
-	select I2C_SMBUS
+	select I2C_SMBUS_ALERT
 	help
 	  Say Y here to include support for Smart Battery System Manager
 	  ICs. The driver reports online and charging status via sysfs.
-- 
1.8.3.1

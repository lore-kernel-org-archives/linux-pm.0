From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: [PATCH] iio / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 03:06:04 +0100
Message-ID: <202529361.GBbZ7zGgn8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
drivers/iio/.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/iio/accel/bmc150-accel.c |    4 ++--
 drivers/iio/accel/kxcjk-1013.c   |    4 ++--
 drivers/iio/gyro/bmg160.c        |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/iio/accel/bmc150-accel.c
===================================================================
--- linux-pm.orig/drivers/iio/accel/bmc150-accel.c
+++ linux-pm/drivers/iio/accel/bmc150-accel.c
@@ -510,7 +510,7 @@ static int bmc150_accel_get_bw(struct bm
 	return -EINVAL;
 }
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int bmc150_accel_get_startup_times(struct bmc150_accel_data *data)
 {
 	int i;
@@ -1349,7 +1349,7 @@ static int bmc150_accel_resume(struct de
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int bmc150_accel_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
Index: linux-pm/drivers/iio/accel/kxcjk-1013.c
===================================================================
--- linux-pm.orig/drivers/iio/accel/kxcjk-1013.c
+++ linux-pm/drivers/iio/accel/kxcjk-1013.c
@@ -358,7 +358,7 @@ static int kxcjk1013_chip_init(struct kx
 	return 0;
 }
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 {
 	int i;
@@ -1357,7 +1357,7 @@ static int kxcjk1013_resume(struct devic
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int kxcjk1013_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
Index: linux-pm/drivers/iio/gyro/bmg160.c
===================================================================
--- linux-pm.orig/drivers/iio/gyro/bmg160.c
+++ linux-pm/drivers/iio/gyro/bmg160.c
@@ -237,7 +237,7 @@ static int bmg160_chip_init(struct bmg16
 
 static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 {
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 	int ret;
 
 	if (on)
@@ -1164,7 +1164,7 @@ static int bmg160_resume(struct device *
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static int bmg160_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

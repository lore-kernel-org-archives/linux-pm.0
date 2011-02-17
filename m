From: Rabin Vincent <rabin.vincent@stericsson.com>
Subject: [PATCH] amba: move to pm ops
Date: Thu, 17 Feb 2011 13:19:46 +0530
Message-ID: <1297928986-31171-1-git-send-email-rabin.vincent__26142.1321229593$1297961429$gmane$org@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux@arm.linux.org.uk
Cc: Rabin Vincent <rabin.vincent@stericsson.com>, Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, linux-pm@lists.linux-foundation.org, Chris Ball <cjb@laptop.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Support pm_ops in the AMBA bus instead of the legacy ops.   pm_ops is needed
for runtime pm, and there is also a general move to convert drivers to
dev_pm_ops rather than bus specific PM ops in order to facilitate core
development.

Since there are only 6 AMBA drivers using suspend/resume, convert them all in
one go and directly use the GENERIC_SUBSYS_PM_OPS in the bus.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/amba/bus.c              |   25 ++-----------------------
 drivers/input/serio/ambakmi.c   |   13 ++++++++++---
 drivers/mmc/host/mmci.c         |   17 ++++++++++-------
 drivers/spi/amba-pl022.c        |   15 +++++++++------
 drivers/tty/serial/amba-pl010.c |   20 ++++++++++++++------
 drivers/tty/serial/amba-pl011.c |   22 +++++++++++++---------
 include/linux/amba/bus.h        |    4 ++--
 sound/arm/aaci.c                |   18 ++++++++++--------
 8 files changed, 70 insertions(+), 64 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index ca96b0a..402b07e 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -13,12 +13,12 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/pm.h>
 #include <linux/amba/bus.h>
 
 #include <asm/irq.h>
 #include <asm/sizes.h>
 
-#define to_amba_device(d)	container_of(d, struct amba_device, dev)
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
 static struct amba_id *
@@ -57,26 +57,6 @@ static int amba_uevent(struct device *dev, struct kobj_uevent_env *env)
 #define amba_uevent NULL
 #endif
 
-static int amba_suspend(struct device *dev, pm_message_t state)
-{
-	struct amba_driver *drv = to_amba_driver(dev->driver);
-	int ret = 0;
-
-	if (dev->driver && drv->suspend)
-		ret = drv->suspend(to_amba_device(dev), state);
-	return ret;
-}
-
-static int amba_resume(struct device *dev)
-{
-	struct amba_driver *drv = to_amba_driver(dev->driver);
-	int ret = 0;
-
-	if (dev->driver && drv->resume)
-		ret = drv->resume(to_amba_device(dev));
-	return ret;
-}
-
 #define amba_attr_func(name,fmt,arg...)					\
 static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
@@ -111,8 +91,7 @@ struct bus_type amba_bustype = {
 	.dev_attrs	= amba_dev_attrs,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
-	.suspend	= amba_suspend,
-	.resume		= amba_resume,
+	.pm		= GENERIC_SUBSYS_PM_OPS,
 };
 
 static int __init amba_init(void)
diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
index 92563a6..c710437 100644
--- a/drivers/input/serio/ambakmi.c
+++ b/drivers/input/serio/ambakmi.c
@@ -176,15 +176,22 @@ static int __devexit amba_kmi_remove(struct amba_device *dev)
 	return 0;
 }
 
-static int amba_kmi_resume(struct amba_device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int amba_kmi_resume(struct device *dev)
 {
-	struct amba_kmi_port *kmi = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct amba_kmi_port *kmi = amba_get_drvdata(adev);
 
 	/* kick the serio layer to rescan this port */
 	serio_reconnect(kmi->io);
 
 	return 0;
 }
+#else
+#define amba_kmi_resume	NULL
+#endif
+
+static SIMPLE_DEV_PM_OPS(amba_kmi_pm, NULL, amba_kmi_resume);
 
 static struct amba_id amba_kmi_idtable[] = {
 	{
@@ -198,11 +205,11 @@ static struct amba_driver ambakmi_driver = {
 	.drv		= {
 		.name	= "kmi-pl050",
 		.owner	= THIS_MODULE,
+		.pm	= &amba_kmi_pm,
 	},
 	.id_table	= amba_kmi_idtable,
 	.probe		= amba_kmi_probe,
 	.remove		= __devexit_p(amba_kmi_remove),
-	.resume		= amba_kmi_resume,
 };
 
 static int __init amba_kmi_init(void)
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8a29c9f..18e142b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1236,10 +1236,11 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int mmci_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int mmci_suspend(struct device *dev)
 {
-	struct mmc_host *mmc = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
 	int ret = 0;
 
 	if (mmc) {
@@ -1253,9 +1254,10 @@ static int mmci_suspend(struct amba_device *dev, pm_message_t state)
 	return ret;
 }
 
-static int mmci_resume(struct amba_device *dev)
+static int mmci_resume(struct device *dev)
 {
-	struct mmc_host *mmc = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
 	int ret = 0;
 
 	if (mmc) {
@@ -1273,6 +1275,8 @@ static int mmci_resume(struct amba_device *dev)
 #define mmci_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(mmci_pm, mmci_suspend, mmci_resume);
+
 static struct amba_id mmci_ids[] = {
 	{
 		.id	= 0x00041180,
@@ -1306,11 +1310,10 @@ static struct amba_id mmci_ids[] = {
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
+		.pm	= &mmci_pm,
 	},
 	.probe		= mmci_probe,
 	.remove		= __devexit_p(mmci_remove),
-	.suspend	= mmci_suspend,
-	.resume		= mmci_resume,
 	.id_table	= mmci_ids,
 };
 
diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 71a1219..eb16ea5 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -2184,9 +2184,10 @@ pl022_remove(struct amba_device *adev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pl022_suspend(struct amba_device *adev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int pl022_suspend(struct device *dev)
 {
+	struct amba_device *adev = to_amba_device(dev);
 	struct pl022 *pl022 = amba_get_drvdata(adev);
 	int status = 0;
 
@@ -2203,8 +2204,9 @@ static int pl022_suspend(struct amba_device *adev, pm_message_t state)
 	return 0;
 }
 
-static int pl022_resume(struct amba_device *adev)
+static int pl022_resume(struct device *dev)
 {
+	struct amba_device *adev = to_amba_device(dev);
 	struct pl022 *pl022 = amba_get_drvdata(adev);
 	int status = 0;
 
@@ -2220,7 +2222,9 @@ static int pl022_resume(struct amba_device *adev)
 #else
 #define pl022_suspend NULL
 #define pl022_resume NULL
-#endif	/* CONFIG_PM */
+#endif
+
+static SIMPLE_DEV_PM_OPS(pl022_pm, pl022_suspend, pl022_resume);
 
 static struct vendor_data vendor_arm = {
 	.fifodepth = 8,
@@ -2284,12 +2288,11 @@ static struct amba_id pl022_ids[] = {
 static struct amba_driver pl022_driver = {
 	.drv = {
 		.name	= "ssp-pl022",
+		.pm	= &pl022_pm,
 	},
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
 	.remove		= __devexit_p(pl022_remove),
-	.suspend        = pl022_suspend,
-	.resume         = pl022_resume,
 };
 
 
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index 2904aa0..5e0e62f 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -757,9 +757,11 @@ static int pl010_remove(struct amba_device *dev)
 	return 0;
 }
 
-static int pl010_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int pl010_suspend(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct uart_amba_port *uap = amba_get_drvdata(adev);
 
 	if (uap)
 		uart_suspend_port(&amba_reg, &uap->port);
@@ -767,15 +769,22 @@ static int pl010_suspend(struct amba_device *dev, pm_message_t state)
 	return 0;
 }
 
-static int pl010_resume(struct amba_device *dev)
+static int pl010_resume(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct uart_amba_port *uap = amba_get_drvdata(adev);
 
 	if (uap)
 		uart_resume_port(&amba_reg, &uap->port);
 
 	return 0;
 }
+#else
+#define pl010_suspend	NULL
+#define pl010_resume	NULL
+#endif
+
+static SIMPLE_DEV_PM_OPS(pl010_pm, pl010_suspend, pl010_resume);
 
 static struct amba_id pl010_ids[] = {
 	{
@@ -788,12 +797,11 @@ static struct amba_id pl010_ids[] = {
 static struct amba_driver pl010_driver = {
 	.drv = {
 		.name	= "uart-pl010",
+		.pm	= &pl010_pm,
 	},
 	.id_table	= pl010_ids,
 	.probe		= pl010_probe,
 	.remove		= pl010_remove,
-	.suspend	= pl010_suspend,
-	.resume		= pl010_resume,
 };
 
 static int __init pl010_init(void)
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e76d7d0..52a5e18 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1438,10 +1438,11 @@ static int pl011_remove(struct amba_device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pl011_suspend(struct amba_device *dev, pm_message_t state)
+#ifdef CONFIG_PM_SLEEP
+static int pl011_suspend(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct uart_amba_port *uap = amba_get_drvdata(adev);
 
 	if (!uap)
 		return -EINVAL;
@@ -1449,17 +1450,23 @@ static int pl011_suspend(struct amba_device *dev, pm_message_t state)
 	return uart_suspend_port(&amba_reg, &uap->port);
 }
 
-static int pl011_resume(struct amba_device *dev)
+static int pl011_resume(struct device *dev)
 {
-	struct uart_amba_port *uap = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct uart_amba_port *uap = amba_get_drvdata(adev);
 
 	if (!uap)
 		return -EINVAL;
 
 	return uart_resume_port(&amba_reg, &uap->port);
 }
+#else
+#define pl011_suspend	NULL
+#define pl011_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(pl011_pm, pl011_suspend, pl011_resume);
+
 static struct amba_id pl011_ids[] = {
 	{
 		.id	= 0x00041011,
@@ -1477,14 +1484,11 @@ static struct amba_id pl011_ids[] = {
 static struct amba_driver pl011_driver = {
 	.drv = {
 		.name	= "uart-pl011",
+		.pm	= &pl011_pm,
 	},
 	.id_table	= pl011_ids,
 	.probe		= pl011_probe,
 	.remove		= pl011_remove,
-#ifdef CONFIG_PM
-	.suspend	= pl011_suspend,
-	.resume		= pl011_resume,
-#endif
 };
 
 static int __init pl011_init(void)
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index a0ccf28..2f48827 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -46,8 +46,6 @@ struct amba_driver {
 	int			(*probe)(struct amba_device *, struct amba_id *);
 	int			(*remove)(struct amba_device *);
 	void			(*shutdown)(struct amba_device *);
-	int			(*suspend)(struct amba_device *, pm_message_t);
-	int			(*resume)(struct amba_device *);
 	struct amba_id		*id_table;
 };
 
@@ -58,6 +56,8 @@ enum amba_vendor {
 
 extern struct bus_type amba_bustype;
 
+#define to_amba_device(d)	container_of(d, struct amba_device, dev)
+
 #define amba_get_drvdata(d)	dev_get_drvdata(&d->dev)
 #define amba_set_drvdata(d,p)	dev_set_drvdata(&d->dev, p)
 
diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index af5a152..040c5f0 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -35,7 +35,7 @@
 /*
  * PM support is not complete.  Turn it off.
  */
-#undef CONFIG_PM
+#undef CONFIG_PM_SLEEP
 
 static void aaci_ac97_select_codec(struct aaci *aaci, struct snd_ac97 *ac97)
 {
@@ -752,7 +752,7 @@ static struct snd_pcm_ops aaci_capture_ops = {
 /*
  * Power Management.
  */
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int aaci_do_suspend(struct snd_card *card, unsigned int state)
 {
 	struct aaci *aaci = card->private_data;
@@ -767,15 +767,17 @@ static int aaci_do_resume(struct snd_card *card, unsigned int state)
 	return 0;
 }
 
-static int aaci_suspend(struct amba_device *dev, pm_message_t state)
+static int aaci_suspend(struct device *dev)
 {
-	struct snd_card *card = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct snd_card *card = amba_get_drvdata(adev);
 	return card ? aaci_do_suspend(card) : 0;
 }
 
-static int aaci_resume(struct amba_device *dev)
+static int aaci_resume(struct device *dev)
 {
-	struct snd_card *card = amba_get_drvdata(dev);
+	struct amba_device *adev = to_amba_device(dev);
+	struct snd_card *card = amba_get_drvdata(adev);
 	return card ? aaci_do_resume(card) : 0;
 }
 #else
@@ -785,6 +787,7 @@ static int aaci_resume(struct amba_device *dev)
 #define aaci_resume		NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(aaci_pm, aaci_suspend, aaci_resume);
 
 static struct ac97_pcm ac97_defs[] __devinitdata = {
 	[0] = {	/* Front PCM */
@@ -1099,11 +1102,10 @@ static struct amba_id aaci_ids[] = {
 static struct amba_driver aaci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
+		.pm	= &aaci_pm,
 	},
 	.probe		= aaci_probe,
 	.remove		= __devexit_p(aaci_remove),
-	.suspend	= aaci_suspend,
-	.resume		= aaci_resume,
 	.id_table	= aaci_ids,
 };
 
-- 
1.7.2.dirty

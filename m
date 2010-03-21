From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: runtime PM ops and PCMCIA bus
Date: Sun, 21 Mar 2010 23:45:46 +0100
Message-ID: <20100321224546.GA23626@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Magnus Damm <damm@igel.co.jp>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org
Cc: linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hey!

On the PCMCIA bus, implementing runtime PM "should" be simple.
However, there's a major caveat: the bus must be able to
force devices to suspend, or force them to resume during
runtime. Let's discuss this in detail:

(1) Converting the PCMCIA bus to dev_pm_ops seems easy:

    pcmcia_dev_suspend() needs to get rid of its second argument,
    then it's just a 

    SET_SYSTEM_SLEEP_PM_OPS(pcmcia_dev_suspend, pcmcia_dev_resume)


(2) Whenever two functions local to drivers/pcmcia/ds.c --
    runtime_suspend() or runtime_resume() -- are called,
    we need to force a synchronous call to pcmcia_dev_suspend(),
    or to pcmcia_dev_resume(). Currently, we do this by taking
    device_lock() and calling the function manually.


(3) However, it'd be much nicer to be able to use the new runtime
    PM interface. As the PCMCIA bus can always suspend,
    pcmcia_dev_idle() might only contain a call to

	pm_schedule_suspend(dev, 0) - or pm_runtime_suspend() ?

    To enable it, we should add

       pm_runtime_set_active(&p_dev->dev);
       pm_runtime_enable(&p_dev->dev);

    in pcmcia_device_add().


(4) What is then to be done to modify runtime_suspend() / runtime_resume() ?
    Is it:

+ static int runtime_suspend(struct device *dev)
+ {
+ 	pm_runtime_put_noidle(dev);
+ 	return pm_runtime_suspend(dev);
+ }
+ 
+ static int runtime_resume(struct device *dev)
+ {
+ 	return pm_runtime_get_sync(dev);
+ }


    or more something like


+  static int runtime_suspend(struct device *dev)
+ {
+ 	return pm_runtime_put_sync(dev);
+ }
+ 
+ static int runtime_resume(struct device *dev)
+ {
+ 	return pm_runtime_get_sync(dev);
+ }

    and modifying pcmcia_dev_idle() to call pm_runtime_suspend() instead of
    pm_schedule_suspend()?


(5) Another problem I'm seeing with the put/get approach: there are three
    different callpaths where runtime_suspend() / runtime_resume() might
    be called.[*] However, each one decreases the counter, which might get < 0.
    What to do? Using pm_runtime_suspended seems racy...


(6) As pcmcia_dev_resume() is used -- as per UNIVERSAL_DEV_PM_OPS -- what is
    needed there to set the runtime PM state correctly if we do not wake up
    the device during system sleep suspend?


Pseudo patch -- untested and probably broken [see at least (5) above]
attached. Any feedback is most welcome.

Best,
	Dominik

[*] 1) by echoing the state into a device sysfs file.
    2) by echoing the state into a socket sysfs file.
    3) during "resets" of the socket -- we need to suspend devices
           first, then physically reset the socket, then resume the devices
	   on the card.

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index caca50e..551fcdb 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -20,6 +20,7 @@ if PCCARD
 config PCMCIA
 	tristate "16-bit PCMCIA support"
 	select CRC32
+	select PM_RUNTIME
 	default y
 	---help---
 	   This option enables support for 16-bit PCMCIA cards. Most older
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index f4df4d0..ec9f56e 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/kref.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 
 #include <pcmcia/cs_types.h>
 #include <pcmcia/cs.h>
@@ -560,6 +561,9 @@ struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s, unsigned int fu
 	if (device_register(&p_dev->dev))
 		goto err_unreg;
 
+	pm_runtime_set_active(&p_dev->dev);
+	pm_runtime_enable(&p_dev->dev);
+
 	return p_dev;
 
  err_unreg:
@@ -952,28 +956,24 @@ static int pcmcia_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 #endif
 
 /************************ runtime PM support ***************************/
-
-static int pcmcia_dev_suspend(struct device *dev, pm_message_t state);
-static int pcmcia_dev_resume(struct device *dev);
-
 static int runtime_suspend(struct device *dev)
 {
-	int rc;
+	int ret;
 
-	device_lock(dev);
-	rc = pcmcia_dev_suspend(dev, PMSG_SUSPEND);
-	device_unlock(dev);
-	return rc;
+	dev_dbg(dev, "runtime_suspend\n");
+	ret = pm_runtime_put_sync(dev);
+	dev_dbg(dev, "runtime_suspend %d\n", ret);
+	return (ret >=0 ? 0 : ret);
 }
 
 static int runtime_resume(struct device *dev)
 {
-	int rc;
+	int ret;
 
-	device_lock(dev);
-	rc = pcmcia_dev_resume(dev);
-	device_unlock(dev);
-	return rc;
+	dev_dbg(dev, "runtime_resume\n");
+	ret = pm_runtime_get_sync(dev);
+	dev_dbg(dev, "runtime_resume %d\n", ret);
+	return (ret >=0 ? 0 : ret);
 }
 
 /************************ per-device sysfs output ***************************/
@@ -1085,7 +1085,7 @@ static struct device_attribute pcmcia_dev_attrs[] = {
 
 /* PM support, also needed for reset */
 
-static int pcmcia_dev_suspend(struct device *dev, pm_message_t state)
+static int pcmcia_dev_suspend(struct device *dev)
 {
 	struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
 	struct pcmcia_driver *p_drv = NULL;
@@ -1406,6 +1406,19 @@ static struct class_interface pcmcia_bus_interface __refdata = {
 };
 
 
+static int pcmcia_dev_idle(struct device *dev)
+{
+	int ret = pm_runtime_suspend(dev);
+
+	/* we can always suspend */
+	dev_dbg(dev, "idle callback -- pm_runtime_suspend returned %d\n", ret);
+
+	return ret;
+}
+
+UNIVERSAL_DEV_PM_OPS(pcmcia_bus_pm_ops, 
+		pcmcia_dev_suspend, pcmcia_dev_resume, pcmcia_dev_idle);
+
 struct bus_type pcmcia_bus_type = {
 	.name = "pcmcia",
 	.uevent = pcmcia_bus_uevent,
@@ -1413,8 +1426,7 @@ struct bus_type pcmcia_bus_type = {
 	.dev_attrs = pcmcia_dev_attrs,
 	.probe = pcmcia_device_probe,
 	.remove = pcmcia_device_remove,
-	.suspend = pcmcia_dev_suspend,
-	.resume = pcmcia_dev_resume,
+	.pm = &pcmcia_bus_pm_ops,
 };
 
 

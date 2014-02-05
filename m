From: Shuah Khan <shuah.kh@samsung.com>
Subject: Legacy pm ops to dev_pm_ops patches
Date: Tue, 04 Feb 2014 20:39:18 -0700
Message-ID: <52F1B266.9080207@samsung.com>
Reply-To: shuah.kh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Shuah Khan <shuah.kh@samsung.com>, "shuahkhan@gmail.com" <shuahkhan@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

I checked on the status of the legacy pm ops to dev_pm_ops conversion 
patches. Several went in. I have about 13 patches I would like to send. 
These patches are similar in nature. One of the issues I am having is 
being able to test these patches. Except for drivers/pcmcia/ds.c patch, 
others I am limited to compile testing only. Would it be okay to I send 
these as RFT patches cc'ing you and linux-pm and in addition to the 
maintainers for each of these patches?

Patch details below:

5 mmc host driver patches:

drivers/mmc/host/au1xmmc.c
drivers/mmc/host/bfin_sdh.c
drivers/mmc/host/cb710-mmc.c
drivers/mmc/host/msm_sdcc.c
drivers/mmc/host/tmio_mmc.c

3 arm platform driver patches:

arch/arm/common/locomo.c
arch/arm/common/sa1111.c
arch/arm/common/scoop.c

1 macintosh driver patch:
drivers/macintosh/adb.c

3 bus drivers patches:
drivers/base/isa.c
drivers/pcmcia/ds.c
drivers/s390/crypto/ap_bus.c

The nature if changes is very similar:
1. Define dev_pm_ops as in the example below:

+static const struct dev_pm_ops pcmcia_bus_dev_pm_ops = {
+       .suspend = pcmcia_dev_suspend,
+       .resume = pcmcia_dev_resume,
+       /* Hibernate callbacks */
+       .freeze = pcmcia_dev_freeze,
+       .thaw = pcmcia_dev_resume,
+       .poweroff = pcmcia_dev_poweroff,
+       .restore = pcmcia_dev_resume,
+};

  struct bus_type pcmcia_bus_type = {
         .name = "pcmcia",
@@ -1405,8 +1432,7 @@ struct bus_type pcmcia_bus_type = {
         .dev_groups = pcmcia_dev_groups,
         .probe = pcmcia_device_probe,
         .remove = pcmcia_device_remove,
-       .suspend = pcmcia_dev_suspend,
-       .resume = pcmcia_dev_resume,
+       .pm = &pcmcia_bus_dev_pm_ops,
  };

2. Define new interfaces for poweroff, freeze which in turn call 
existing suspend interface, as in the example below. thaw, resume, and 
restore are straight forward and just point to existing resume() hook

+static int pcmcia_dev_suspend(struct device *dev)
+{
+       __pcmcia_dev_suspend(dev, PMSG_SUSPEND);
+}
+
+static int pcmcia_dev_poweroff(struct device *dev)
+{
+       __pcmcia_dev_suspend(dev, PMSG_HIBERNATE);
+}
+
+static int pcmcia_dev_freeze(struct device *dev)
+{
+       __pcmcia_dev_suspend(dev, PMSG_FREEZE);
+}
+
+static int __pcmcia_dev_suspend(struct device *dev, pm_message_t state)
  {
         struct pcmcia_device *p_dev = to_pcmcia_dev(dev);
         struct pcmcia_driver *p_drv = NULL;
@@ -1397,6 +1415,15 @@ static struct class_interface 
pcmcia_bus_interface __refdata = {
         .remove_dev = &pcmcia_bus_remove_socket,
  };

thanks,
-- Shuah

-- 
Shuah Khan
Senior Linux Kernel Developer - Open Source Group
Samsung Research America(Silicon Valley)
shuah.kh@samsung.com | (970) 672-0658

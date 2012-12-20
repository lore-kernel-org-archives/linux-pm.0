From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pm:acpi-scan-temp-new 15/17] include/linux/acpi.h:518: warning:
 'acpi_dev_pm_get_node' defined but not used
Date: Thu, 20 Dec 2012 10:28:14 +0800
Message-ID: <50d277be.qZAL3KNg9jSIatvZ%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47393 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab2LTC3S (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Dec 2012 21:29:18 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-scan-temp-new
head:   9970b0ad27dc7970cdb101c79f9c99d699263744
commit: 44374289a89061d604187d122e70722b5625208b [15/17] ACPI / PCI: Rework the setup and cleanup of device wakeup
config: make ARCH=avr32 atngw100_defconfig

All warnings:

In file included from include/uapi/linux/param.h:4,
                 from include/linux/timex.h:63,
                 from include/linux/jiffies.h:8,
                 from include/linux/ktime.h:25,
                 from include/linux/timer.h:5,
                 from include/linux/workqueue.h:8,
                 from include/linux/srcu.h:32,
                 from include/linux/notifier.h:15,
                 from include/linux/memory_hotplug.h:6,
                 from include/linux/mmzone.h:738,
                 from include/linux/gfp.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from init/main.c:13:
arch/avr32/include/asm/param.h:6:1: warning: "HZ" redefined
In file included from arch/avr32/include/asm/param.h:4,
                 from include/uapi/linux/param.h:4,
                 from include/linux/timex.h:63,
                 from include/linux/jiffies.h:8,
                 from include/linux/ktime.h:25,
                 from include/linux/timer.h:5,
                 from include/linux/workqueue.h:8,
                 from include/linux/srcu.h:32,
                 from include/linux/notifier.h:15,
                 from include/linux/memory_hotplug.h:6,
                 from include/linux/mmzone.h:738,
                 from include/linux/gfp.h:4,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from init/main.c:13:
arch/avr32/include/uapi/asm/param.h:6:1: warning: this is the location of the previous definition
include/linux/acpi.h:518: warning: 'acpi_dev_pm_get_node' defined but not used

vim +/acpi_dev_pm_get_node +518 include/linux/acpi.h

e5cc8ef3 Rafael J. Wysocki 2012-11-02  502  int acpi_subsys_suspend_late(struct device *dev);
e5cc8ef3 Rafael J. Wysocki 2012-11-02  503  int acpi_subsys_resume_early(struct device *dev);
e5cc8ef3 Rafael J. Wysocki 2012-11-02  504  #else
e5cc8ef3 Rafael J. Wysocki 2012-11-02  505  static inline int acpi_dev_suspend_late(struct device *dev) { return 0; }
e5cc8ef3 Rafael J. Wysocki 2012-11-02  506  static inline int acpi_dev_resume_early(struct device *dev) { return 0; }
e5cc8ef3 Rafael J. Wysocki 2012-11-02  507  static inline int acpi_subsys_prepare(struct device *dev) { return 0; }
e5cc8ef3 Rafael J. Wysocki 2012-11-02  508  static inline int acpi_subsys_suspend_late(struct device *dev) { return 0; }
e5cc8ef3 Rafael J. Wysocki 2012-11-02  509  static inline int acpi_subsys_resume_early(struct device *dev) { return 0; }
e5cc8ef3 Rafael J. Wysocki 2012-11-02  510  #endif
e5cc8ef3 Rafael J. Wysocki 2012-11-02  511  
e5cc8ef3 Rafael J. Wysocki 2012-11-02  512  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
44374289 Rafael J. Wysocki 2012-12-20  513  struct acpi_device *acpi_dev_pm_get_node(struct device *dev);
b88ce2a4 Rafael J. Wysocki 2012-11-26  514  int acpi_dev_pm_attach(struct device *dev, bool power_on);
d71f2f88 Rafael J. Wysocki 2012-12-05  515  void acpi_dev_pm_detach(struct device *dev, bool power_off);
e5cc8ef3 Rafael J. Wysocki 2012-11-02  516  #else
44374289 Rafael J. Wysocki 2012-12-20  517  static struct acpi_device *acpi_dev_pm_get_node(struct device *dev)
44374289 Rafael J. Wysocki 2012-12-20 @518  {
44374289 Rafael J. Wysocki 2012-12-20  519  	return NULL;
44374289 Rafael J. Wysocki 2012-12-20  520  }
b88ce2a4 Rafael J. Wysocki 2012-11-26  521  static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
b88ce2a4 Rafael J. Wysocki 2012-11-26  522  {
b88ce2a4 Rafael J. Wysocki 2012-11-26  523  	return -ENODEV;
b88ce2a4 Rafael J. Wysocki 2012-11-26  524  }
b88ce2a4 Rafael J. Wysocki 2012-11-26  525  static inline void acpi_dev_pm_detach(struct device *dev, bool power_off) {}
e5cc8ef3 Rafael J. Wysocki 2012-11-02  526  #endif

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pm:acpi-dev-pm 9/10] include/linux/acpi.h:463:68: error:
 'ENODEV' undeclared
Date: Thu, 15 Nov 2012 09:45:43 +0800
Message-ID: <50a44947.moPp4aPN29u1CjRu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11271 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992631Ab2KOBp7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Nov 2012 20:45:59 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-pm@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-dev-pm
head:   99926a8cd36b6088448fec41aed4a3b5b05b3679
commit: e5cc8ef31267317f3e177415c84e3f3602e5bfc9 [9/10] ACPI / PM: Provide ACPI PM callback routines for subsystems
config: make ARCH=arm tegra_defconfig

All error/warnings:

In file included from drivers/pci/irq.c:7:0:
include/linux/acpi.h: In function 'acpi_dev_pm_attach':
include/linux/acpi.h:463:68: error: 'ENODEV' undeclared (first use in this function)
include/linux/acpi.h:463:68: note: each undeclared identifier is reported only once for each function it appears in

vim +463 +/ENODEV include/linux/acpi.h

e5cc8ef3 Rafael J. Wysocki 2012-11-02  457  #endif
e5cc8ef3 Rafael J. Wysocki 2012-11-02  458  
e5cc8ef3 Rafael J. Wysocki 2012-11-02  459  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
e5cc8ef3 Rafael J. Wysocki 2012-11-02  460  int acpi_dev_pm_attach(struct device *dev);
e5cc8ef3 Rafael J. Wysocki 2012-11-02  461  int acpi_dev_pm_detach(struct device *dev);
e5cc8ef3 Rafael J. Wysocki 2012-11-02  462  #else
e5cc8ef3 Rafael J. Wysocki 2012-11-02 @463  static inline int acpi_dev_pm_attach(struct device *dev) { return -ENODEV; }
e5cc8ef3 Rafael J. Wysocki 2012-11-02  464  static inline void acpi_dev_pm_detach(struct device *dev) {}
e5cc8ef3 Rafael J. Wysocki 2012-11-02  465  #endif
e5cc8ef3 Rafael J. Wysocki 2012-11-02  466  

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

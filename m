From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / PM: Fix build problem when CONFIG_ACPI or CONFIG_PM is not set
Date: Fri, 16 Nov 2012 00:12:54 +0100
Message-ID: <1812129.dYO2ty2NF7@vostro.rjw.lan>
References: <50a44947.moPp4aPN29u1CjRu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:47165 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2KOXIb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Nov 2012 18:08:31 -0500
In-Reply-To: <50a44947.moPp4aPN29u1CjRu%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Thursday, November 15, 2012 09:45:43 AM kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-dev-pm
> head:   99926a8cd36b6088448fec41aed4a3b5b05b3679
> commit: e5cc8ef31267317f3e177415c84e3f3602e5bfc9 [9/10] ACPI / PM: Provide ACPI PM callback routines for subsystems
> config: make ARCH=arm tegra_defconfig
> 
> All error/warnings:
> 
> In file included from drivers/pci/irq.c:7:0:
> include/linux/acpi.h: In function 'acpi_dev_pm_attach':
> include/linux/acpi.h:463:68: error: 'ENODEV' undeclared (first use in this function)
> include/linux/acpi.h:463:68: note: each undeclared identifier is reported only once for each function it appears in
> 
> vim +463 +/ENODEV include/linux/acpi.h
> 
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  457  #endif
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  458  
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  459  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  460  int acpi_dev_pm_attach(struct device *dev);
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  461  int acpi_dev_pm_detach(struct device *dev);
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  462  #else
> e5cc8ef3 Rafael J. Wysocki 2012-11-02 @463  static inline int acpi_dev_pm_attach(struct device *dev) { return -ENODEV; }
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  464  static inline void acpi_dev_pm_detach(struct device *dev) {}
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  465  #endif
> e5cc8ef3 Rafael J. Wysocki 2012-11-02  466  
> 
> ---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / PM: Fix build problem when CONFIG_ACPI or CONFIG_PM is not set

Commit e5cc8ef (ACPI / PM: Provide ACPI PM callback routines for
subsystems) introduced a build problem occuring if CONFIG_ACPI is
unset or CONFIG_PM is unset and errno.h is not included before
acpi.h, because in that case ENODEV used in acpi.h is undefined.

Fix the issue by making acpi.h include errno.h.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of the current linux-pm.git/acpi-dev-pm.

---
 include/linux/acpi.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -25,6 +25,7 @@
 #ifndef _LINUX_ACPI_H
 #define _LINUX_ACPI_H
 
+#include <linux/errno.h>
 #include <linux/ioport.h>	/* for struct resource */
 
 #ifdef	CONFIG_ACPI



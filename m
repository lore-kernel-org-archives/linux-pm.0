From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/2] handle wakeup event in PCI
Date: Tue, 1 Sep 2009 10:35:02 +0800
Message-ID: <20090901023502.GA3695__1419.26955334402$1251772584$gmane$org@sli10-desk.sh.intel.com>
References: <1251101493.22288.53.camel@sli10-desk.sh.intel.com>
	<200908260216.24606.rjw@sisk.pl>
	<20090827064154.GA9769@sli10-desk.sh.intel.com>
	<200908292226.33921.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908292226.33921.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 30, 2009 at 04:26:33AM +0800, Rafael J. Wysocki wrote:
> On Thursday 27 August 2009, Shaohua Li wrote:
> Hi,
> 
> > Add an implementation how to detect wakeup event for PCI. PCI device can
> > invoke PME, platform or PCIe native approach can collect the event and
> > report to OS. OS should identify exactly which device invokes PME as
> > several devices can share PME pin.
> > 
> > In platform approach (ACPI in this case), some BIOS give exact device which
> > invokes PME but others doesn't. In either case, we always scan all devices
> > to check which one is the wakeup source. In the meantime, if the device isn't a
> > bridge, we trust the device is wakeup source even its PME status isn't set,
> > because BIOS can clear PME status before OS gets notification and we have no
> > reliable method to check if the device is the wakeup source.
> > 
> > In PCIe native approach, if PME source device is a pcie endpoint, the device
> > is the exact PME source. If the device is root port or pcie-to-pci bridge,
> > we need scan legacy devices in the hierarchy under the root port or bridge.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
> >  drivers/pci/pci-driver.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.h        |    3 +
> >  2 files changed, 109 insertions(+)
> > 
> > Index: linux/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux.orig/drivers/pci/pci-driver.c	2009-08-25 15:39:52.000000000 +0800
> > +++ linux/drivers/pci/pci-driver.c	2009-08-27 14:15:34.000000000 +0800
> > @@ -17,6 +17,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sched.h>
> >  #include <linux/cpu.h>
> > +#include <linux/pm_runtime.h>
> >  #include "pci.h"
> >  
> >  /*
> > @@ -570,6 +571,111 @@ static void pci_pm_complete(struct devic
> >  		drv->pm->complete(dev);
> >  }
> >  
> > +/*
> > + * pci_pm_check_wakeup_event - pdev is suspected to invoke a wakeup event
> > + * @pdev: the suspected pci device
> > + *
> > + * Clear PME status and disable PME, return if the pci device @pdev really
> > + * invokes PME
> > + **/
> > +static bool pci_pm_check_wakeup_event(struct pci_dev *pdev)
> > +{
> > +	int pme_pos = pdev->pm_cap;
> > +	u16 pmcsr;
> > +	bool ret = false;
> > +
> > +	if (!pme_pos)
> > +		return false;
> > +
> > +	/* clear PME status and disable PME to avoid interrupt flood */
> > +	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
> > +	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> > +		return false;
> > +
> > +	/* I see spurious PME here, just ignore it for now */
> > +	if (pmcsr & PCI_PM_CTRL_PME_ENABLE) {
> > +		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
> > +		ret = true;
> > +	}
> > +
> > +	pmcsr |= PCI_PM_CTRL_PME_STATUS;
> > +	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
> > +
> > +	return ret;
> > +}
> 
> The function above looks good.
> 
> I think it's better to move the one below into the PCIe PME code.
> 
> > +
> > +/*
> > + * pci_pm_handle_wakeup_event_native - handle PCIe native PME event
> > + * @target is suspected to invoke a wakeup event (PME)
> > + * Note @target should be a PCIe device
> > + */
> > +bool pci_pm_handle_wakeup_event_native(struct pci_dev *target)
> > +{
> > +	bool ret;
> > +	struct pci_dev *tmp = NULL;
> > +	int domain_nr, bus_start, bus_end;
> > +
> > +	BUG_ON(!target->is_pcie);
> > +
> > +	/* For PCIe PME, if the target isn't the source, do nothing */
> > +	ret = pci_pm_check_wakeup_event(target);
> > +
> > +	if (!target->subordinate || (target->pcie_type != PCI_EXP_TYPE_ROOT_PORT
> > +		&& target->pcie_type != PCI_EXP_TYPE_PCI_BRIDGE)) {
> > +		if (ret)
> > +			pm_runtime_resume(&target->dev);
> > +		return ret;
> > +	}
> > +
> > +	if (ret)
> > +		pm_request_resume(&target->dev);
> 
> Here, if you want to busy loop in pcie_pme_work_handle(), it's better not to
> use pm_runtime_resume() (sorry, I overlooked that before), because we should
> first clear all PME_Status flags set and _then_ try to resume the devices.
> 
> So, the code you had here before was better:
> 
> +	ret = pci_pm_check_wakeup_event(target);
> +	if (ret)
> +		pm_request_resume(&target->dev);
> +	if (is_regular_device(target))
> +		return ret;
> 
> > +
> > +	/* scan legacy PCI devices under the bridge or root port */
> > +	domain_nr = pci_domain_nr(target->bus);
> > +	bus_start = target->subordinate->secondary;
> > +	bus_end = target->subordinate->subordinate;
> > +	while ((tmp = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tmp)) != NULL) {
> > +		if (pci_domain_nr(tmp->bus) == domain_nr &&
> > +		   tmp->bus->number >= bus_start &&
> > +		   tmp->bus->number <= bus_end) {
> > +			if (!tmp->is_pcie && pci_pm_check_wakeup_event(tmp)) {
> > +				ret = true;
> > +				pm_request_resume(&tmp->dev);
> > +			}
> 
> Do we have to check ->is_pcie here?
> 
> Anyway, I'd do
> 
> +		if (pci_domain_nr(tmp->bus) != domain_nr
> +		    || tmp->bus->number < bus_start || tmp->bus->number > bus_end)
> +			continue;
> 
> and then the rest.
> 
> > +		}
> > +	}
> > +	return ret;
> > +}
> > +
> > +/*
> > + * pci_pm_handle_wakeup_event_platform - handle platform PCI wakeup event
> > + * @target is suspected to invoke a wakeup event
> > + */
> > +bool pci_pm_handle_wakeup_event_platform(struct pci_dev *target)
> > +{
> > +	bool ret = false;
> > +	struct pci_dev *tmp = NULL;
> > +
> > +	/*
> > +	 * In the platform approach (ACPI), target PME status might get cleared
> > +	 * by BIOS before OS receives a notification, so we haven't reliable
> > +	 * method to detect if target is the wakeup source, just trust it is
> > +	 */
> > +	pci_pm_check_wakeup_event(target);
> > +	pm_request_resume(&target->dev);
> > +	if (!target->subordinate)
> > +		ret = true;
> > +
> > +	/* scan all pci devices to find the wakeup source */
> > +	while ((tmp = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tmp)) != NULL) {
> 
> Doing
> 
> +		if (tmp == target)
> +			continue;
> 
> separately would be cleaner IMO.
> 
> > +		if (tmp != target && pci_pm_check_wakeup_event(tmp)) {
> > +			ret = true;
> > +			pm_request_resume(&tmp->dev);
> > +		}
> > +	}
> > +	return ret;
> > +}
> > +
> >  #ifdef CONFIG_SUSPEND
> >  
> >  static int pci_pm_suspend(struct device *dev)
> > Index: linux/drivers/pci/pci.h
> > ===================================================================
> > --- linux.orig/drivers/pci/pci.h	2009-08-25 15:38:50.000000000 +0800
> > +++ linux/drivers/pci/pci.h	2009-08-26 09:07:42.000000000 +0800
> > @@ -83,6 +83,9 @@ static inline void pci_vpd_release(struc
> >  		dev->vpd->ops->release(dev);
> >  }
> >  
> > +extern bool pci_pm_handle_wakeup_event_native(struct pci_dev *target);
> > +extern bool pci_pm_handle_wakeup_event_platform(struct pci_dev *target);
> > +
> >  /* PCI /proc functions */
> >  #ifdef CONFIG_PROC_FS
> >  extern int pci_proc_attach_device(struct pci_dev *dev);
Updated the patch.


Add an implementation how to detect wakeup event for PCI. PCI device can
invoke PME, platform or PCIe native approach can collect the event and
report to OS. OS should identify exactly which device invokes PME as
several devices can share PME pin.

In platform approach (ACPI in this case), some BIOS give exact device which
invokes PME but others doesn't. In either case, we always scan all devices
to check which one is the wakeup source. In the meantime, if the device isn't a
bridge, we trust the device is wakeup source even its PME status isn't set,
because BIOS can clear PME status before OS gets notification and we have no
reliable method to check if the device is the wakeup source.

In PCIe native approach, if PME source device is a pcie endpoint, the device
is the exact PME source. If the device is root port or pcie-to-pci bridge,
we need scan legacy devices in the hierarchy under the root port or bridge.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/pci/pci-driver.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h        |    3 ++
 2 files changed, 68 insertions(+)

Index: linux/drivers/pci/pci-driver.c
===================================================================
--- linux.orig/drivers/pci/pci-driver.c	2009-08-31 17:26:23.000000000 +0800
+++ linux/drivers/pci/pci-driver.c	2009-08-31 17:28:04.000000000 +0800
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/cpu.h>
+#include <linux/pm_runtime.h>
 #include "pci.h"
 
 /*
@@ -570,6 +571,70 @@ static void pci_pm_complete(struct devic
 		drv->pm->complete(dev);
 }
 
+/*
+ * pci_pm_check_wakeup_event - pdev is suspected to invoke a wakeup event
+ * @pdev: the suspected pci device
+ *
+ * Clear PME status and disable PME, return if the pci device @pdev really
+ * invokes PME
+ **/
+bool pci_pm_check_wakeup_event(struct pci_dev *pdev)
+{
+	int pme_pos = pdev->pm_cap;
+	u16 pmcsr;
+	bool ret = false;
+
+	if (!pme_pos)
+		return false;
+
+	/* clear PME status and disable PME to avoid interrupt flood */
+	pci_read_config_word(pdev, pme_pos + PCI_PM_CTRL, &pmcsr);
+	if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
+		return false;
+
+	/* I see spurious PME here, just ignore it for now */
+	if (pmcsr & PCI_PM_CTRL_PME_ENABLE) {
+		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
+		ret = true;
+	}
+
+	pmcsr |= PCI_PM_CTRL_PME_STATUS;
+	pci_write_config_word(pdev, pme_pos + PCI_PM_CTRL, pmcsr);
+
+	return ret;
+}
+
+/*
+ * pci_pm_handle_wakeup_event_platform - handle platform PCI wakeup event
+ * @target is suspected to invoke a wakeup event
+ */
+bool pci_pm_handle_wakeup_event_platform(struct pci_dev *target)
+{
+	bool ret = false;
+	struct pci_dev *tmp = NULL;
+
+	/*
+	 * In the platform approach (ACPI), target PME status might get cleared
+	 * by BIOS before OS receives a notification, so we haven't reliable
+	 * method to detect if target is the wakeup source, just trust it is
+	 */
+	pci_pm_check_wakeup_event(target);
+	pm_request_resume(&target->dev);
+	if (!target->subordinate)
+		ret = true;
+
+	/* scan all pci devices to find the wakeup source */
+	while ((tmp = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, tmp)) != NULL) {
+		if (tmp == target)
+			continue;
+		if (pci_pm_check_wakeup_event(tmp)) {
+			ret = true;
+			pm_request_resume(&tmp->dev);
+		}
+	}
+	return ret;
+}
+
 #ifdef CONFIG_SUSPEND
 
 static int pci_pm_suspend(struct device *dev)
Index: linux/drivers/pci/pci.h
===================================================================
--- linux.orig/drivers/pci/pci.h	2009-08-31 17:26:23.000000000 +0800
+++ linux/drivers/pci/pci.h	2009-08-31 17:28:04.000000000 +0800
@@ -83,6 +83,9 @@ static inline void pci_vpd_release(struc
 		dev->vpd->ops->release(dev);
 }
 
+extern bool pci_pm_check_wakeup_event(struct pci_dev *target);
+extern bool pci_pm_handle_wakeup_event_platform(struct pci_dev *target);
+
 /* PCI /proc functions */
 #ifdef CONFIG_PROC_FS
 extern int pci_proc_attach_device(struct pci_dev *dev);

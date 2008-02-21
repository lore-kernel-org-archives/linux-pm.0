From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [Suspend-devel] 2.6.25-rc2 System no longer powers
	off after suspend-to-disk. Screen becomes green.
Date: Thu, 21 Feb 2008 15:45:05 -0800
Message-ID: <200802211545.05794.jesse.barnes__36579.7083861709$1203638318$gmane$org@intel.com>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802211034.22056.jesse.barnes@intel.com>
	<200802212311.44319.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802212311.44319.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 21, 2008 2:11 pm Rafael J. Wysocki wrote:
> Below is a patch that should work around the issue.  Please try it and let
> me know if it helps.

I ended up applying the below patch instead, so it would build, and 
unfortunately it still hung at suspend time.

So at this point, the known workarounds to the hang at suspend time are to 
remove the device power down call or to boot with 'no_console_suspend'.  
The 'screen turns green' problem is fixed by the extra 'inb' added in the 
patch below (at least for me).

Jesse

diff --git a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
index 35758a6..35b5a60 100644
--- a/drivers/char/drm/i915_drv.c
+++ b/drivers/char/drm/i915_drv.c
@@ -27,6 +27,7 @@
  *
  */
 
+#include <linux/suspend.h>
 #include "drmP.h"
 #include "drm.h"
 #include "i915_drm.h"
@@ -222,6 +223,7 @@ static void i915_restore_vga(struct drm_device *dev)
 			   dev_priv->saveGR[0x18]);
 
 	/* Attribute controller registers */
+	inb(st01); /* switch back to index mode */
 	for (i = 0; i < 20; i++)
 		i915_write_ar(st01, i, dev_priv->saveAR[i], 0);
 	inb(st01); /* switch back to index mode */
@@ -249,6 +251,9 @@ static int i915_suspend(struct drm_device *dev)
 		return -ENODEV;
 	}
 
+	if (in_hibernation_power_off())
+		return 0;
+
 	pci_save_state(dev->pdev);
 	pci_read_config_byte(dev->pdev, LBB, &dev_priv->saveLBB);
 
@@ -364,7 +369,6 @@ static int i915_suspend(struct drm_device *dev)
 	i915_save_vga(dev);
 
 	/* Shut down the device */
-	pci_disable_device(dev->pdev);
 	pci_set_power_state(dev->pdev, PCI_D3hot);
 
 	return 0;
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 1d7d4c5..58d9f67 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -209,6 +209,7 @@ extern unsigned long get_safe_page(gfp_t gfp_mask);
 
 extern void hibernation_set_ops(struct platform_hibernation_ops *ops);
 extern int hibernate(void);
+extern bool in_hibernation_power_off(void);
 #else /* CONFIG_HIBERNATION */
 static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
 static inline void swsusp_set_page_free(struct page *p) {}
@@ -216,6 +217,7 @@ static inline void swsusp_unset_page_free(struct page *p) 
{}
 
 static inline void hibernation_set_ops(struct platform_hibernation_ops *ops) 
{}
 static inline int hibernate(void) { return -ENOSYS; }
+static inline bool in_hibernation_power_off(void) { return false; }
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
index 859a8e5..d842bf0 100644
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -24,7 +24,7 @@
 
 #include "power.h"
 
-
+static bool entering_sleep_state;
 static int noresume = 0;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
 dev_t swsusp_resume_device;
@@ -381,6 +381,7 @@ int hibernation_platform_enter(void)
 	if (!hibernation_ops)
 		return -ENOSYS;
 
+	entering_sleep_state = true;
 	/*
 	 * We have cancelled the power transition by running
 	 * hibernation_ops->finish() before saving the image, so we should let
@@ -412,6 +413,7 @@ int hibernation_platform_enter(void)
 	}
 	local_irq_enable();
 
+	entering_sleep_state = false;
 	/*
 	 * We don't need to reenable the nonboot CPUs or resume consoles, since
 	 * the system is going to be halted anyway.
@@ -427,6 +429,12 @@ int hibernation_platform_enter(void)
 	return error;
 }
 
+bool in_hibernation_power_off(void)
+{
+	return entering_sleep_state;
+}
+EXPORT_SYMBOL(in_hibernation_power_off);
+
 /**
  *	power_down - Shut the machine down for hibernation.
  *

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/5] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
Date: Fri, 13 Feb 2015 16:12:13 +0000
Message-ID: <20150213161212.GB8656@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
 <CAPDyKFoboE4iKyom86+EwHHTQAGpgKxGq969yrjQVpqizk-SLA@mail.gmail.com>
 <20150213132924.GA27774@n2100.arm.linux.org.uk>
 <20150213141151.GA8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39217 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbbBMQMY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Feb 2015 11:12:24 -0500
Content-Disposition: inline
In-Reply-To: <20150213141151.GA8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Fri, Feb 13, 2015 at 02:11:52PM +0000, Russell King - ARM Linux wrote:
> I think what's going on is that there's a difference in the expectations
> from the PM domain code vs the runtime PM code.  I refer to section 5
> of the runtime PM documentation:
> 
> | 5. Runtime PM Initialization, Device Probing and Removal
> | 
> | Initially, the runtime PM is disabled for all devices, which means that the
> | majority of the runtime PM helper functions described in Section 4 will return
> | -EAGAIN until pm_runtime_enable() is called for the device.
> | 
> | In addition to that, the initial runtime PM status of all devices is
> | 'suspended', but it need not reflect the actual physical state of the device.
> | Thus, if the device is initially active (i.e. it is able to process I/O), its
> | runtime PM status must be changed to 'active', with the help of
> | pm_runtime_set_active(), before pm_runtime_enable() is called for the device.
> 
> However, the PM domain code seems to always power up the PM domain when
> a device is attached to it:
> 
> int genpd_dev_pm_attach(struct device *dev)
> {
> ...
>         pm_genpd_poweron(pd);
> 
>         return 0;
> }
> EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
> 
> So, the PM domain code ends up disagreeing with the runtime PM code about
> the state of the device.
> 
> I think your commit (2ed127697eb1 "PM / Domains: Power on the PM domain
> right after attach completes") is fundamentally wrong.  The assertion
> you make in there is built upon the assumption that every driver will
> call pm_runtime_set_active(), which is not an assumption you can make.
> 
> Instead, you should be doing is to hook into __pm_runtime_set_status()
> and use that to trigger the PM domain power up so that the runtime PM
> and PM domain state is always in step with each other.
> 
> What I'm certain of is that the current situation is just totally crazy.

There are around 150 drivers in the kernel tree which do not call
pm_runtime_set_active() before calling pm_runtime_enable(), so the
assertion in the PM domains commit above is wrong.  Some of them are
only saved because they do a pm_runtime_get() immediately after
pm_runtime_enable(), but that's in no way guaranteed - others do
neither.  So, for this to work properly, we need to address this
issue _correctly_ rather than papering over the problem.

Here's a patch which solves the issue for me along the lines which I
described above.  I'm introducing a new callback - runtime_set_status()
which the PM domain code uses to be notified of the runtime PM status
updates while RPM is disabled.  This callback will only occur from
__pm_runtime_set_status(), which can only be used while runtime PM is
disabled.

I believe it's safe - if we think that a PM domain is powered down, and
the runtime PM status is then set active, it's clear that the PM domain
absolutely must transition to active mode as well.  If the runtime PM
status is set to suspended, then the PM domain code can transition to
off state.

I've left some of my debugging in place in the patch below as that's
exactly the code I've tested.

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 751a8859a4ab..1616faadf904 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -5,7 +5,7 @@
  *
  * This file is released under the GPLv2.
  */
-
+#define DEBUG
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -158,6 +158,8 @@ static int genpd_power_on(struct generic_pm_domain *genpd)
 	s64 elapsed_ns;
 	int ret;
 
+	pr_debug("%s: %s()\n", genpd->name, __func__);
+
 	if (!genpd->power_on)
 		return 0;
 
@@ -219,6 +221,10 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 	DEFINE_WAIT(wait);
 	int ret = 0;
 
+	pr_debug("%s: %s() status %u prepared %d spo %u\n",
+		genpd->name, __func__, genpd->status, genpd->prepared_count,
+		genpd->suspend_power_off);
+
 	/* If the domain's master is being waited for, we have to wait too. */
 	for (;;) {
 		prepare_to_wait(&genpd->status_wait_queue, &wait,
@@ -741,6 +747,20 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int pm_genpd_runtime_set_status(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	if (pm_runtime_suspended(dev))
+		ret = pm_genpd_runtime_suspend(dev);
+	else
+		ret = pm_genpd_runtime_resume(dev);
+
+	return ret;
+}
+
 static bool pd_ignore_unused;
 static int __init pd_ignore_unused_setup(char *__unused)
 {
@@ -1907,6 +1927,7 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->max_off_time_changed = true;
 	genpd->domain.ops.runtime_suspend = pm_genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = pm_genpd_runtime_resume;
+	genpd->domain.ops.runtime_set_status = pm_genpd_runtime_set_status;
 	genpd->domain.ops.prepare = pm_genpd_prepare;
 	genpd->domain.ops.suspend = pm_genpd_suspend;
 	genpd->domain.ops.suspend_late = pm_genpd_suspend_late;
@@ -2223,7 +2244,6 @@ int genpd_dev_pm_attach(struct device *dev)
 	}
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
-	pm_genpd_poweron(pd);
 
 	return 0;
 }
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 5070c4fe8542..a958cae67a37 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -981,6 +981,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 	struct device *parent = dev->parent;
 	unsigned long flags;
 	bool notify_parent = false;
+	pm_callback_t callback;
 	int error = 0;
 
 	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
@@ -1029,6 +1030,10 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
  out_set:
 	__update_runtime_status(dev, status);
 	dev->power.runtime_error = 0;
+	if (dev->power.no_callbacks)
+		goto out;
+	callback = RPM_GET_CALLBACK(dev, runtime_set_status);
+	rpm_callback(callback, dev);
  out:
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 8b5976364619..ee098585d577 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -316,6 +316,7 @@ struct dev_pm_ops {
 	int (*runtime_suspend)(struct device *dev);
 	int (*runtime_resume)(struct device *dev);
 	int (*runtime_idle)(struct device *dev);
+	int (*runtime_set_status)(struct device *dev);
 };
 
 #ifdef CONFIG_PM_SLEEP


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

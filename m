From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v3 2/2] PM / Runtime: Add pm_runtime_enable_recursive
Date: Wed, 8 Jul 2015 16:31:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1507081617200.2243-100000@iolanthe.rowland.org>
References: <9291571.JSDgNsKidJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56222 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755529AbbGHUbm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 16:31:42 -0400
In-Reply-To: <9291571.JSDgNsKidJ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 8 Jul 2015, Rafael J. Wysocki wrote:

> I seem to have lost the context here, sorry about that.
> 
> The idea seems to be to rely on the fact that the RPM status for all devices
> is initially RPM_SUSPENDED and that never changes if runtime PM is never
> enabled for the device, so in that particular case it would be OK to treat
> the "power.direct_complete set + RPM status == RPM_SUSPENDED" combination
> as valid even though runtime PM has never been enabled for the device in
> question (provided that power.direct_complete will never be set for "real"
> devices that don't support runtime PM).  Is that correct?

I would have expressed it slightly differently, but yes, that's correct.

> That seems to be fragile, but I have no strong opinion.

In itself it's not all that bad, I think.  In the presence of Tomeu's
new direct_complete_default flag, however, it does seem quite fragile.  

We may want to do the direct_complete_default thing in a different way.  
For example, the PM core could automatically set the direct_complete
flag if a device has _none_ of the system suspend callbacks (i.e., no
prepare, suspend, suspend_late, suspend_noirq, resume_noirq,
resume_early, resume, or complete).  Although it would be a little
awkward to check this, it would be safer than inheriting
direct_complete_default from the parent and it ought to solve Tomeu's
problem just as well.

> Let's do that change if it allows us to make forward progress here.  Please
> feel free to submit a documentation patch along the lines you've suggested.

Here's a proposed patch to illustrate what I have in mind.  Since it 
removes the only usage of pm_runtime_suspended_if_enabled(), it also 
removes the definition of that function.

Alan Stern



Index: usb-4.1/drivers/base/power/main.c
===================================================================
--- usb-4.1.orig/drivers/base/power/main.c
+++ usb-4.1/drivers/base/power/main.c
@@ -1374,7 +1374,7 @@ static int __device_suspend(struct devic
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
-			if (pm_runtime_suspended_if_enabled(dev))
+			if (pm_runtime_status_suspended(dev))
 				goto Complete;
 
 			pm_runtime_enable(dev);
Index: usb-4.1/Documentation/power/devices.txt
===================================================================
--- usb-4.1.orig/Documentation/power/devices.txt
+++ usb-4.1/Documentation/power/devices.txt
@@ -341,6 +341,13 @@ the phases are:
 	and is entirely responsible for bringing the device back to the
 	functional state as appropriate.
 
+	Note that this direct-complete procedure applies even if the device is
+	disabled for runtime PM; only the runtime-PM status matters.  It follows
+	that if a device has system-sleep callbacks but does not support runtime
+	PM, then its prepare callback must never return a positive value.  This
+	is because all devices are initially set to runtime-suspended with
+	runtime PM disabled.
+
     2.	The suspend methods should quiesce the device to stop it from performing
 	I/O.  They also may save the device registers and put it into the
 	appropriate low-power state, depending on the bus type the device is on,
Index: usb-4.1/Documentation/power/runtime_pm.txt
===================================================================
--- usb-4.1.orig/Documentation/power/runtime_pm.txt
+++ usb-4.1/Documentation/power/runtime_pm.txt
@@ -445,10 +445,6 @@ drivers/base/power/runtime.c and include
   bool pm_runtime_status_suspended(struct device *dev);
     - return true if the device's runtime PM status is 'suspended'
 
-  bool pm_runtime_suspended_if_enabled(struct device *dev);
-    - return true if the device's runtime PM status is 'suspended' and its
-      'power.disable_depth' field is equal to 1
-
   void pm_runtime_allow(struct device *dev);
     - set the power.runtime_auto flag for the device and decrease its usage
       counter (used by the /sys/devices/.../power/control interface to
Index: usb-4.1/include/linux/pm_runtime.h
===================================================================
--- usb-4.1.orig/include/linux/pm_runtime.h
+++ usb-4.1/include/linux/pm_runtime.h
@@ -98,11 +98,6 @@ static inline bool pm_runtime_status_sus
 	return dev->power.runtime_status == RPM_SUSPENDED;
 }
 
-static inline bool pm_runtime_suspended_if_enabled(struct device *dev)
-{
-	return pm_runtime_status_suspended(dev) && dev->power.disable_depth == 1;
-}
-
 static inline bool pm_runtime_enabled(struct device *dev)
 {
 	return !dev->power.disable_depth;
@@ -164,7 +159,6 @@ static inline void device_set_run_wake(s
 static inline bool pm_runtime_suspended(struct device *dev) { return false; }
 static inline bool pm_runtime_active(struct device *dev) { return true; }
 static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
-static inline bool pm_runtime_suspended_if_enabled(struct device *dev) { return false; }
 static inline bool pm_runtime_enabled(struct device *dev) { return false; }
 
 static inline void pm_runtime_no_callbacks(struct device *dev) {}


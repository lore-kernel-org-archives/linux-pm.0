From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 17 Sep 2015 18:48:29 +0300
Message-ID: <55FAE0CD.2030605@ti.com>
References: <Pine.LNX.4.44L0.1509161523230.1993-100000@iolanthe.rowland.org>
 <4548634.pC6GYZYGWm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48408 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbbIQPsl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 11:48:41 -0400
In-Reply-To: <4548634.pC6GYZYGWm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,
 
On 09/17/2015 03:07 AM, Rafael J. Wysocki wrote:
> On Wednesday, September 16, 2015 03:27:55 PM Alan Stern wrote:
>> On Wed, 16 Sep 2015, Grygorii Strashko wrote:
>>
>>> I think, It should prohibited to probe devices during suspend/hibernation.
>>> And solution introduced in this patch might help to fix it -
>>> in general, we could do :
>>> - add sync point on suspend enter: wait_for_device_probe() and
>>> - prohibit probing: move all devices which will request probing into
>>> deferred_probe list
>>> - one suspend exit: allow probing and do driver_deferred_probe_trigger
>>
>> That could work; it's a good idea.
>>
>>> I'd like to mention here that this patch will work only
>>> if dmp_list will be filled according device creation order ("parent<-child" dependencies)
>>> *AND* according device's probing order ("supplier<-consumer").
>>> So, if there is the case when Parent device can be probed AFTER its children
>>> - it will not work, because "parent<-child" dependencies will not be tracked
>>> any more :( Sry, I could not even imagine that such crazy case exist :'(
>>
>> If we avoid moving devices to the end of the dpm_list when they already
>> have children, then we should be okay, right?
>>
>>> Are there any other subsystems with the same behavior like PCI?
>>
>> I don't know.
>>
>>> If not - probably, it could be fixed in PCI subsystem using device_pm_move_after() or
>>> device_move() in PCIe ports probe.
>>> if yes - ... maybe we can scan/re-check and reorder dpm_list on suspend enter and
>>> restore ("parent<-child" dependencies).
>>
>>> Truth is that smth. need to be done 100%. Personally, I was hit by this issue also,
>>>   and it cost me 3 hours of debugging and I came up with the same patch as
>>> Bill Huang, then spent some time trying to understand what is wrong with PCI
>>> - finally, I've just changed the order of my devices in DT :)
>>>
>>> Also, I think, it will be good to have this patch in -next to collect more feedbacks.
>>
>> I like the idea of forcing all probes during a sleep transition to be
>> deferred.  We could carry them out just before unfreezing the user
>> threads.  That combined with the change mentioned above ought to be
>> worth testing.
> 
> Agreed.
> 

I've prepared code change which should prohibit devices probing during suspend/hibernation
(below). It also expected to fix wait_for_device_probe() to take into account the case
when the deferred probe workqueue could be still active. 

NOTE: It's only compile time tested!

I'm very sorry that I'm replying here instead of sending a proper patch -
I'm on business trip right now and I will be traveling next week also and will not
be able to work on it intensively.

If proposed approach is correct I can send RFC/RFT patch/es (or anyone else could 
pick up it if interested to move forward faster).

-- 
regards,
-grygorii

>From d29e554bf1d593c6c52d2902872ba8a6c48a80a8 Mon Sep 17 00:00:00 2001
From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Thu, 17 Sep 2015 18:33:54 +0300
Subject: [RFC/RFT PATCH] PM / sleep: prohibit devices probing during suspend/hibernation

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/dd.c      | 28 +++++++++++++++++++++++++++-
 include/linux/device.h |  1 +
 kernel/power/process.c |  8 ++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb46..dcadf30 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -55,6 +55,14 @@ static struct workqueue_struct *deferred_wq;
 static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
 
 /*
+ * In some cases, like suspend to RAM or hibernation, It might be reasonable
+ * to prohibit probing of devices as it could be unsafe.
+ * Once driver_force_probe_deferral is true all drivers probes will
+ * be forcibly deferred
+ */
+static bool driver_force_probe_deferral;
+
+/*
  * deferred_probe_work_func() - Retry probing devices in the active list.
  */
 static void deferred_probe_work_func(struct work_struct *work)
@@ -171,6 +179,14 @@ static void driver_deferred_probe_trigger(void)
 	queue_work(deferred_wq, &deferred_probe_work);
 }
 
+void device_force_probe_deferral(bool enable)
+{
+	driver_force_probe_deferral = enable;
+	if (!enable)
+		driver_deferred_probe_trigger();
+}
+EXPORT_SYMBOL_GPL(device_force_probe_deferral);
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
@@ -277,9 +293,15 @@ static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
 
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
-	int ret = 0;
+	int ret = -EPROBE_DEFER;
 	int local_trigger_count = atomic_read(&deferred_trigger_count);
 
+	if (driver_force_probe_deferral) {
+		dev_dbg(dev, "Driver %s force probe deferral\n", drv->name);
+		driver_deferred_probe_add(dev);
+		return ret;
+	}
+
 	atomic_inc(&probe_count);
 	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
@@ -391,6 +413,10 @@ int driver_probe_done(void)
  */
 void wait_for_device_probe(void)
 {
+	/* wait for the deferred probe workqueue to finish */
+	if (driver_deferred_probe_enable)
+		flush_workqueue(deferred_wq);
+
 	/* wait for the known devices to complete their probing */
 	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
 	async_synchronize_full();
diff --git a/include/linux/device.h b/include/linux/device.h
index 5d7bc63..c68b8e1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1034,6 +1034,7 @@ extern int  __must_check device_attach(struct device *dev);
 extern int __must_check driver_attach(struct device_driver *drv);
 extern void device_initial_probe(struct device *dev);
 extern int __must_check device_reprobe(struct device *dev);
+extern void device_force_probe_deferral(bool enable);
 
 /*
  * Easy functions for dynamically creating devices on the fly
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 564f786..c13e78d 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -148,6 +148,13 @@ int freeze_processes(void)
 	if (!error && !oom_killer_disable())
 		error = -EBUSY;
 
+	if (!error) {
+		/** wait for the known devices to complete their probing */
+		wait_for_device_probe();
+		device_force_probe_deferral(true);
+		wait_for_device_probe();
+	}
+
 	if (error)
 		thaw_processes();
 	return error;
@@ -190,6 +197,7 @@ void thaw_processes(void)
 		atomic_dec(&system_freezing_cnt);
 	pm_freezing = false;
 	pm_nosig_freezing = false;
+	device_force_probe_deferral(false);
 
 	oom_killer_enable();
 
-- 
2.5.1


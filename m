From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: fix unbalanced pm runtime disable in __device_suspend_late()
Date: Fri, 20 May 2016 14:18:10 +0200
Message-ID: <4160153.ggAvdOZIvP@vostro.rjw.lan>
References: <1463162628-16976-1-git-send-email-grygorii.strashko@ti.com> <CAJZ5v0ja-poNq0J+giAJJb+pPFyGg1a7rUcUfFyhcn9qPnaieQ@mail.gmail.com> <573DF3C6.7080503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55293 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755291AbcETMOg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 08:14:36 -0400
In-Reply-To: <573DF3C6.7080503@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, May 19, 2016 08:11:34 PM Grygorii Strashko wrote:
> On 05/19/2016 04:38 PM, Rafael J. Wysocki wrote:
> > On Fri, May 13, 2016 at 8:03 PM, Grygorii Strashko
> > <grygorii.strashko@ti.com> wrote:
> >> The PM runtime will be left disabled for the device if its .suspend_late()
> >> callback fails and async suspend is not allowed for this device. In
> >> this case device will not be added in dpm_late_early_list and
> >> dpm_resume_early() will ignore this device, as result PM runtime will
> >> be disabled for it forever (side effect: after 8 subsequent failures
> >> for the same device the PM runtime will be reenabled due to
> >> disable_depth overflow).
> >>
> >> Hence, re-enable PM runtime in __device_suspend_late() if
> >> .suspend_late() callback fails and async suspend is not allowed for
> >> this device.
> >>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> ---
> >>   drivers/base/power/main.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> >> index 6e7c3cc..9b266e5 100644
> >> --- a/drivers/base/power/main.c
> >> +++ b/drivers/base/power/main.c
> >> @@ -1207,10 +1207,13 @@ static int __device_suspend_late(struct device *dev, pm_message_t state, bool as
> >>          }
> >>
> >>          error = dpm_run_callback(callback, dev, state, info);
> >> -       if (!error)
> >> +       if (!error) {
> >>                  dev->power.is_late_suspended = true;
> >> -       else
> >> +       } else {
> 		Point [1]
> >>                  async_error = error;
> >> +               if (!is_async(dev))
> > 
> > Why is the is_async() check necessary here?
> 			
> A: deviceX is suspended *async* and reached point [1], in this case:
> - deviceX has been added in dpm_late_early_list already
> - dpm_suspend_late() will detect async_error and call dpm_resume_early()
> - dpm_resume_early() will call device_resume_early() for deviceX
> - device_resume_early() will re-enable PM runtime
> {
> ...
> 	if (!dev->power.is_late_suspended)
> 		goto Out;
> 
> 	...
>  Out:
> 	TRACE_RESUME(error);
> 
> 	pm_runtime_enable(dev);
> ^^^^^^^^^^^^
> 	complete_all(&dev->power.completion);
> 	return error;
> }	
> 	
> 
> B: deviceX is suspended *sync* and reached point [1], in this case:
> - deviceX has not been added in dpm_late_early_list yet
> - dpm_suspend_late() will detect sync_error and call dpm_resume_early()
> - dpm_resume_early() will ignore deviceX
> 
> if i'll not check for !is_async(dev) then pm_runtime_enable(dev)
> will be called twice for deviceX with this patch.

OK, thanks!

So to me, the problem is that we handle failures in that code inconsistently
depending on whether or not async suspend/resume is enabled for the device.

I'd rather make it consistent than add extra checks to it, so the patch below
is how I would fix this.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] PM / sleep: Handle failures in device_suspend_late() consistently

Grygorii Strashko reports:

 The PM runtime will be left disabled for the device if its
 .suspend_late() callback fails and async suspend is not allowed
 for this device. In this case device will not be added in
 dpm_late_early_list and dpm_resume_early() will ignore this
 device, as result PM runtime will be disabled for it forever
 (side effect: after 8 subsequent failures for the same device
 the PM runtime will be reenabled due to disable_depth overflow).

To fix this problem, add devices to dpm_late_early_list regardless
of whether or not device_suspend_late() returns errors for them.

That will ensure failures in there to be handled consistently for
all devices regardless of their async suspend/resume status.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1267,14 +1267,15 @@ int dpm_suspend_late(pm_message_t state)
 		error = device_suspend_late(dev);
 
 		mutex_lock(&dpm_list_mtx);
+		if (!list_empty(&dev->power.entry))
+			list_move(&dev->power.entry, &dpm_late_early_list);
+
 		if (error) {
 			pm_dev_err(dev, state, " late", error);
 			dpm_save_failed_dev(dev_name(dev));
 			put_device(dev);
 			break;
 		}
-		if (!list_empty(&dev->power.entry))
-			list_move(&dev->power.entry, &dpm_late_early_list);
 		put_device(dev);
 
 		if (async_error)


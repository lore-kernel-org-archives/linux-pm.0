From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] PM: fix async resume following suspend
	failure
Date: Sat, 18 Jun 2011 19:50:50 +0200
Message-ID: <201106181950.50392.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106171606430.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171606430.2143-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 17, 2011, Alan Stern wrote:
> The PM core doesn't handle suspend failures correctly when it comes to
> asynchronously suspended devices.  These devices are moved onto the
> dpm_suspended_list as soon as the corresponding async thread is
> started up, and they remain on the list even if they fail to suspend
> or the sleep transition is cancelled before they get suspended.  As a
> result, when the PM core unwinds the transition, it tries to resume
> the devices even though they were never suspended.
> 
> This patch (as1474) fixes the problem by adding a new "is_suspended"
> flag to dev_pm_info.  Devices are resumed only if the flag is set.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> ---
> 
> Rafael, you may want these two patches to go into the stable kernels.  
> I'll leave that decision to you.

I would, but please see below.

>  drivers/base/power/main.c |    8 +++++---
>  include/linux/pm.h        |    1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> Index: usb-3.0/include/linux/pm.h
> ===================================================================
> --- usb-3.0.orig/include/linux/pm.h
> +++ usb-3.0/include/linux/pm.h
> @@ -426,6 +426,7 @@ struct dev_pm_info {
>  	unsigned int		can_wakeup:1;
>  	unsigned int		async_suspend:1;
>  	bool			is_prepared:1;	/* Owned by the PM core */
> +	bool			is_suspended:1;	/* Ditto */
>  	spinlock_t		lock;
>  #ifdef CONFIG_PM_SLEEP
>  	struct list_head	entry;
> Index: usb-3.0/drivers/base/power/main.c
> ===================================================================
> --- usb-3.0.orig/drivers/base/power/main.c
> +++ usb-3.0/drivers/base/power/main.c
> @@ -57,7 +57,7 @@ static int async_error;
>   */
>  void device_pm_init(struct device *dev)
>  {
> -	dev->power.is_prepared = false;
> +	dev->power.is_prepared = dev->power.is_suspended = false;
>  	init_completion(&dev->power.completion);
>  	complete_all(&dev->power.completion);
>  	dev->power.wakeup = NULL;
> @@ -552,6 +552,7 @@ static int device_resume(struct device *
>  	}
>  
>   End:
> +	dev->power.is_suspended = false;
>  	device_unlock(dev);
>  	complete_all(&dev->power.completion);
>  
> @@ -596,7 +597,7 @@ void dpm_resume(pm_message_t state)
>  
>  	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
>  		INIT_COMPLETION(dev->power.completion);
> -		if (is_async(dev)) {
> +		if (is_async(dev) && dev->power.is_suspended) {

If we check dev->power.is_suspended here, we won't complete the
device's power.completion, which is necessary if the device is someone's
parent.  Moreover, I think we should clear the device's is_prepared
flage at this point.

>  			get_device(dev);
>  			async_schedule(async_resume, dev);
>  		}
> @@ -605,7 +606,7 @@ void dpm_resume(pm_message_t state)
>  	while (!list_empty(&dpm_suspended_list)) {
>  		dev = to_device(dpm_suspended_list.next);
>  		get_device(dev);
> -		if (!is_async(dev)) {
> +		if (!is_async(dev) && dev->power.is_suspended) {
>  			int error;

Same comments apply here, so I think it will be better to check
power.is_suspended in device_resume(), like in the appended patch.

>  
>  			mutex_unlock(&dpm_list_mtx);
> @@ -881,6 +882,7 @@ static int __device_suspend(struct devic
>  	}
>  
>   End:
> +	dev->power.is_suspended = !error;
>  	device_unlock(dev);
>  	complete_all(&dev->power.completion);

This change doesn't seem to be correct too, because error is 0 if
async_error is true, but the device won't be suspended in that case
too.

Thanks,
Rafael


---

 drivers/base/power/main.c |   15 ++++++++++++---
 include/linux/pm.h        |    1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -426,6 +426,7 @@ struct dev_pm_info {
 	unsigned int		can_wakeup:1;
 	unsigned int		async_suspend:1;
 	bool			is_prepared:1;	/* Owned by the PM core */
+	bool			is_suspended:1;	/* Ditto */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -57,7 +57,7 @@ static int async_error;
  */
 void device_pm_init(struct device *dev)
 {
-	dev->power.is_prepared = false;
+	dev->power.is_prepared = dev->power.is_suspended = false;
 	init_completion(&dev->power.completion);
 	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
@@ -517,6 +517,9 @@ static int device_resume(struct device *
 	 */
 	dev->power.is_prepared = false;
 
+	if (!dev->power.is_suspended)
+		goto Unlock;
+
 	if (dev->pm_domain) {
 		pm_dev_dbg(dev, state, "power domain ");
 		error = pm_op(dev, &dev->pm_domain->ops, state);
@@ -552,6 +555,9 @@ static int device_resume(struct device *
 	}
 
  End:
+	dev->power.is_suspended = false;
+
+ Unlock:
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 
@@ -839,11 +845,11 @@ static int __device_suspend(struct devic
 	device_lock(dev);
 
 	if (async_error)
-		goto End;
+		goto Unlock;
 
 	if (pm_wakeup_pending()) {
 		async_error = -EBUSY;
-		goto End;
+		goto Unlock;
 	}
 
 	if (dev->pm_domain) {
@@ -881,6 +887,9 @@ static int __device_suspend(struct devic
 	}
 
  End:
+	dev->power.is_suspended = !error;
+
+ Unlock:
 	device_unlock(dev);
 	complete_all(&dev->power.completion);
 

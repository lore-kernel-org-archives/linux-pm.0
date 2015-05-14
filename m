From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] PM / sleep: Let devices force direct_complete
Date: Thu, 14 May 2015 21:56:18 +0200
Message-ID: <2929090.OdVc2hRah5@vostro.rjw.lan>
References: <1431610673-16801-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65416 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964994AbbENTbG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 May 2015 15:31:06 -0400
In-Reply-To: <1431610673-16801-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org

On Thursday, May 14, 2015 03:37:52 PM Tomeu Vizoso wrote:
> Introduce a new per-device flag power.force_direct_complete that will
> instruct the PM core to let that device remain in runtime suspend when
> the system goes into a sleep power state, regardless of the PM state of
> any of its descendants.
> 
> This is needed because otherwise it would be needed to get dozens of
> drivers to implement the prepare() callback and be runtime PM active
> even if they don't have a 1-to-1 relationship with a piece of HW.
> 
> This only applies to devices that aren't wakeup-capable, as those would
> need to setup their IRQs as wakeup-capable in their prepare() callbacks.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Well, my idea of a "direct complete" flag was a bit different and I have
a concern with this particular implementation. ->

> 
> ---
> 
> v2:	* Fix wording as suggested by Kevin Hilman
> ---
>  Documentation/power/runtime_pm.txt | 10 ++++++++++
>  drivers/base/power/main.c          | 14 ++++++++++----
>  include/linux/pm.h                 |  1 +
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
> index 44fe1d2..e131aab 100644
> --- a/Documentation/power/runtime_pm.txt
> +++ b/Documentation/power/runtime_pm.txt
> @@ -665,6 +665,16 @@ as appropriate.  This only applies to system suspend transitions that are not
>  related to hibernation (see Documentation/power/devices.txt for more
>  information).
>  
> +For devices that know they can remain runtime suspended when the system
> +transitions to a sleep state regardless of the PM state of their descendants,
> +the flag power.force_direct_complete can be set on their device structures.
> +This can be useful when a real device has several virtual devices as
> +descendants and it would be very cumbersome to make sure that they return a
> +positive value in their .prepare() callback and have runtime PM enabled. Usage
> +of power.force_direct_complete is only allowed to devices that aren't
> +wakeup-capable, as they would need to set their IRQs as wakeups in their
> +.prepare() callbacks before the system transitions to a sleep state.
> +
>  The PM core does its best to reduce the probability of race conditions between
>  the runtime PM and system suspend/resume (and hibernation) callbacks by carrying
>  out the following operations:
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3d874ec..7b962f5 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1438,7 +1438,9 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>  		if (parent) {
>  			spin_lock_irq(&parent->power.lock);
>  
> -			dev->parent->power.direct_complete = false;
> +			if (!dev->parent->power.force_direct_complete)
> +				dev->parent->power.direct_complete = false;
> +
>  			if (dev->power.wakeup_path
>  			    && !dev->parent->power.ignore_children)
>  				dev->parent->power.wakeup_path = true;
> @@ -1605,9 +1607,13 @@ static int device_prepare(struct device *dev, pm_message_t state)
>  	 * will do the same thing with all of its descendants".  This only
>  	 * applies to suspend transitions, however.
>  	 */
> -	spin_lock_irq(&dev->power.lock);
> -	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
> -	spin_unlock_irq(&dev->power.lock);
> +	if (state.event == PM_EVENT_SUSPEND) {
> +		spin_lock_irq(&dev->power.lock);
> +		dev->power.direct_complete = ret > 0 ||
> +			(dev->power.force_direct_complete &&
> +			 !device_can_wakeup(dev));

-> What if the bus type (or PM domain) has a good reason to not return a positive
number from ->prepare even though the driver thinks it would be OK to do that?

The changes here would break that case I think, wouldn't they?

I thought about adding a flag that would work if the ->prepare callback was
not present.  So device_prepare() would check that flag for NULL 'callback'
only and then it would set 'ret' to 1 if the flag was set.

Something like in the (untested) patch below.

Wouldn't that be sufficient to cover the use cases you care about?

> +		spin_unlock_irq(&dev->power.lock);
> +	}
>  	return 0;
>  }
>  
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 2d29c64..2e41cfd 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -553,6 +553,7 @@ struct dev_pm_info {
>  	bool			ignore_children:1;
>  	bool			early_init:1;	/* Owned by the PM core */
>  	bool			direct_complete:1;	/* Owned by the PM core */
> +	bool			force_direct_complete:1;
>  	spinlock_t		lock;
>  #ifdef CONFIG_PM_SLEEP
>  	struct list_head	entry;
> 

---
 drivers/base/power/main.c |    2 ++
 include/linux/pm.h        |    1 +
 2 files changed, 3 insertions(+)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1589,6 +1589,8 @@ static int device_prepare(struct device
 		trace_device_pm_callback_start(dev, info, state.event);
 		ret = callback(dev);
 		trace_device_pm_callback_end(dev, ret);
+	} else if (dev->power.direct_complete_default) {
+		ret = 1;
 	}
 
 	device_unlock(dev);
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -553,6 +553,7 @@ struct dev_pm_info {
 	bool			ignore_children:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	bool			direct_complete_default:1;	/* Ditto */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;


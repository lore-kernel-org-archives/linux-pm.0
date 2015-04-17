From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 1/2] PM / sleep: Let devices force direct_complete
Date: Fri, 17 Apr 2015 18:35:05 +0300
Message-ID: <1471135.f2mh84nZFq@avalon>
References: <1429284290-25153-1-git-send-email-tomeu.vizoso@collabora.com> <1429284290-25153-2-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429284290-25153-2-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tomeu,

Thank you for the patch.

On Friday 17 April 2015 17:24:49 Tomeu Vizoso wrote:
> Introduce a new per-device flag power.force_direct_complete that will
> instruct the PM core to ignore the runtime PM status of its descendants
> when deciding whether to let this device remain in runtime suspend when
> the system goes into a sleep power state.
> 
> This is needed because otherwise it would be needed to get dozens of
> drivers to implement the prepare() callback and be runtime PM active
> even if they don't have a 1-to-1 relationship with a piece of HW.

I'll let PM experts comment on the approach, but I believe the new flag would 
benefit from being documented (likely in Documentation/power/devices.txt) :-)

> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/base/power/main.c | 13 +++++++++----
>  include/linux/pm.h        |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 3d874ec..728c2dc 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1438,7 +1438,9 @@ static int __device_suspend(struct device *dev,
> pm_message_t state, bool async) if (parent) {
>  			spin_lock_irq(&parent->power.lock);
> 
> -			dev->parent->power.direct_complete = false;
> +			if (!dev->parent->power.force_direct_complete)
> +				dev->parent->power.direct_complete = false;
> +
>  			if (dev->power.wakeup_path
>  			    && !dev->parent->power.ignore_children)
>  				dev->parent->power.wakeup_path = true;
> @@ -1605,9 +1607,12 @@ static int device_prepare(struct device *dev,
> pm_message_t state) * will do the same thing with all of its descendants". 
> This only * applies to suspend transitions, however.
>  	 */
> -	spin_lock_irq(&dev->power.lock);
> -	dev->power.direct_complete = ret > 0 && state.event == PM_EVENT_SUSPEND;
> -	spin_unlock_irq(&dev->power.lock);
> +	if (state.event == PM_EVENT_SUSPEND) {
> +		spin_lock_irq(&dev->power.lock);
> +		dev->power.direct_complete = ret > 0 ||
> +			dev->power.force_direct_complete;
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

-- 
Regards,

Laurent Pinchart

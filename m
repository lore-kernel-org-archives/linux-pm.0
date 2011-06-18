From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] PM: rename dev_pm_info.in_suspend to
	is_prepared
Date: Sat, 18 Jun 2011 19:34:50 +0200
Message-ID: <201106181934.50218.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1106171605290.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171605290.2143-100000@iolanthe.rowland.org>
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
> This patch (as1473) renames the "in_suspend" field in struct
> dev_pm_info to "is_prepared", in preparation for an upcoming change.
> The new name is more descriptive of what the field really means.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

OK, I'm going to push this for 3.0 + stable.

Thanks,
Rafael


> ---
> 
>  drivers/base/power/main.c |   14 +++++++++-----
>  drivers/usb/core/driver.c |    6 +++---
>  include/linux/device.h    |    4 ++--
>  include/linux/pm.h        |    2 +-
>  4 files changed, 15 insertions(+), 11 deletions(-)
> 
> Index: usb-3.0/include/linux/pm.h
> ===================================================================
> --- usb-3.0.orig/include/linux/pm.h
> +++ usb-3.0/include/linux/pm.h
> @@ -425,7 +425,7 @@ struct dev_pm_info {
>  	pm_message_t		power_state;
>  	unsigned int		can_wakeup:1;
>  	unsigned int		async_suspend:1;
> -	unsigned int		in_suspend:1;	/* Owned by the PM core */
> +	bool			is_prepared:1;	/* Owned by the PM core */
>  	spinlock_t		lock;
>  #ifdef CONFIG_PM_SLEEP
>  	struct list_head	entry;
> Index: usb-3.0/include/linux/device.h
> ===================================================================
> --- usb-3.0.orig/include/linux/device.h
> +++ usb-3.0/include/linux/device.h
> @@ -654,13 +654,13 @@ static inline int device_is_registered(s
>  
>  static inline void device_enable_async_suspend(struct device *dev)
>  {
> -	if (!dev->power.in_suspend)
> +	if (!dev->power.is_prepared)
>  		dev->power.async_suspend = true;
>  }
>  
>  static inline void device_disable_async_suspend(struct device *dev)
>  {
> -	if (!dev->power.in_suspend)
> +	if (!dev->power.is_prepared)
>  		dev->power.async_suspend = false;
>  }
>  
> Index: usb-3.0/drivers/base/power/main.c
> ===================================================================
> --- usb-3.0.orig/drivers/base/power/main.c
> +++ usb-3.0/drivers/base/power/main.c
> @@ -57,7 +57,7 @@ static int async_error;
>   */
>  void device_pm_init(struct device *dev)
>  {
> -	dev->power.in_suspend = false;
> +	dev->power.is_prepared = false;
>  	init_completion(&dev->power.completion);
>  	complete_all(&dev->power.completion);
>  	dev->power.wakeup = NULL;
> @@ -91,7 +91,7 @@ void device_pm_add(struct device *dev)
>  	pr_debug("PM: Adding info for %s:%s\n",
>  		 dev->bus ? dev->bus->name : "No Bus", dev_name(dev));
>  	mutex_lock(&dpm_list_mtx);
> -	if (dev->parent && dev->parent->power.in_suspend)
> +	if (dev->parent && dev->parent->power.is_prepared)
>  		dev_warn(dev, "parent %s should not be sleeping\n",
>  			dev_name(dev->parent));
>  	list_add_tail(&dev->power.entry, &dpm_list);
> @@ -511,7 +511,11 @@ static int device_resume(struct device *
>  	dpm_wait(dev->parent, async);
>  	device_lock(dev);
>  
> -	dev->power.in_suspend = false;
> +	/*
> +	 * This is a fib.  But we'll allow new children to be added below
> +	 * a resumed device, even if the device hasn't been completed yet.
> +	 */
> +	dev->power.is_prepared = false;
>  
>  	if (dev->pwr_domain) {
>  		pm_dev_dbg(dev, state, "power domain ");
> @@ -670,7 +674,7 @@ void dpm_complete(pm_message_t state)
>  		struct device *dev = to_device(dpm_prepared_list.prev);
>  
>  		get_device(dev);
> -		dev->power.in_suspend = false;
> +		dev->power.is_prepared = false;
>  		list_move(&dev->power.entry, &list);
>  		mutex_unlock(&dpm_list_mtx);
>  
> @@ -1042,7 +1046,7 @@ int dpm_prepare(pm_message_t state)
>  			put_device(dev);
>  			break;
>  		}
> -		dev->power.in_suspend = true;
> +		dev->power.is_prepared = true;
>  		if (!list_empty(&dev->power.entry))
>  			list_move_tail(&dev->power.entry, &dpm_prepared_list);
>  		put_device(dev);
> Index: usb-3.0/drivers/usb/core/driver.c
> ===================================================================
> --- usb-3.0.orig/drivers/usb/core/driver.c
> +++ usb-3.0/drivers/usb/core/driver.c
> @@ -375,7 +375,7 @@ static int usb_unbind_interface(struct d
>  		 * Just re-enable it without affecting the endpoint toggles.
>  		 */
>  		usb_enable_interface(udev, intf, false);
> -	} else if (!error && !intf->dev.power.in_suspend) {
> +	} else if (!error && !intf->dev.power.is_prepared) {
>  		r = usb_set_interface(udev, intf->altsetting[0].
>  				desc.bInterfaceNumber, 0);
>  		if (r < 0)
> @@ -960,7 +960,7 @@ void usb_rebind_intf(struct usb_interfac
>  	}
>  
>  	/* Try to rebind the interface */
> -	if (!intf->dev.power.in_suspend) {
> +	if (!intf->dev.power.is_prepared) {
>  		intf->needs_binding = 0;
>  		rc = device_attach(&intf->dev);
>  		if (rc < 0)
> @@ -1107,7 +1107,7 @@ static int usb_resume_interface(struct u
>  	if (intf->condition == USB_INTERFACE_UNBOUND) {
>  
>  		/* Carry out a deferred switch to altsetting 0 */
> -		if (intf->needs_altsetting0 && !intf->dev.power.in_suspend) {
> +		if (intf->needs_altsetting0 && !intf->dev.power.is_prepared) {
>  			usb_set_interface(udev, intf->altsetting[0].
>  					desc.bInterfaceNumber, 0);
>  			intf->needs_altsetting0 = 0;
> 
> 
> 

From: Michael Buesch <mb@bu3sch.de>
Subject: Re: b43_suspend problem
Date: Sun, 20 Jan 2008 13:33:09 +0100
Message-ID: <200801201333.10123.mb__33671.581981662$1200832535$gmane$org@bu3sch.de>
References: <Pine.LNX.4.44L0.0801131634380.28667-100000@netrider.rowland.org>
	<200801200220.29640.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801200220.29640.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, bcm43xx-dev@lists.berlios.de, Larry Finger <larry.finger@lwfinger.net>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 January 2008, Rafael J. Wysocki wrote:
> On Sunday, 13 of January 2008, Alan Stern wrote:
> > On Sun, 13 Jan 2008, Michael Buesch wrote:
> > 
> > > > Besides, if you're going to register the device right back again during 
> > > > the subsequent resume, then why go to the trouble of unregistering it 
> > > > during suspend?  Why not just leave it registered the whole time and 
> > > > avoid all the complication (and excess meaningless uevents)?
> > > 
> > > Well, because not doing it complicates code :)
> > > Currently suspend/resume calls the same code as init/exit.
> > > The b43 init/exit code is really complicated, compared to other
> > > drivers, due to dozens of hardware versions. So I just avoided
> > > having yet other codepaths for suspend/resume. But I will add
> > > a flag to the device structure that's used to avoid unregistering stuff.
> > 
> > Instead of adding an extra flag you should refactor the code.  Have a
> > common "enable" subroutine that can be called for both init and resume,
> > and a common "disable" subroutine that can be called for both exit and
> > suspend.  Then the method routines themselves will contain only the
> > portions unique to their particular functions, making them shorter and
> > simpler.
> 
> Well, it doesn't seem to be that easy.
> 
> I tried to fix the issue myself and finally obtained the appended, apparently
> working, patch (against 2.6.24-rc8-mm1).  Well, it should have been a series
> of patches against multiple subsystems, but I thought it would be instructive
> to put everything needed into one bigger patch for starters.
> 
> Greetings,
> Rafael
> 
> ---
>  drivers/base/power/main.c       |    1 
>  drivers/base/power/power.h      |    1 
>  drivers/char/hw_random/core.c   |   10 ++++-----
>  drivers/char/misc.c             |   13 ++++++++----
>  drivers/leds/led-class.c        |   13 ++++++++----
>  drivers/net/wireless/b43/leds.c |   17 +++++++++------
>  drivers/net/wireless/b43/leds.h |   14 +++++++++++--
>  drivers/net/wireless/b43/main.c |   43 +++++++++++++++++++++++++++++-----------
>  include/linux/device.h          |    6 +++++
>  include/linux/hw_random.h       |   10 ++++++++-
>  include/linux/leds.h            |   10 ++++++++-
>  include/linux/miscdevice.h      |   10 ++++++++-
>  12 files changed, 111 insertions(+), 37 deletions(-)
> 
> Index: linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/main.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/net/wireless/b43/main.c
> +++ linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/main.c
> @@ -2470,10 +2470,15 @@ static int b43_rng_read(struct hwrng *rn
>  	return (sizeof(u16));
>  }
>  
> -static void b43_rng_exit(struct b43_wl *wl)
> +static void __b43_rng_exit(struct b43_wl *wl, bool suspended)
>  {
>  	if (wl->rng_initialized)
> -		hwrng_unregister(&wl->rng);
> +		__hwrng_unregister(&wl->rng, suspended);
> +}
> +
> +static void b43_rng_exit(struct b43_wl *wl)
> +{
> +	__b43_rng_exit(wl, false);
>  }
>  
>  static int b43_rng_init(struct b43_wl *wl)
> @@ -3289,7 +3294,7 @@ static void b43_set_retry_limits(struct 
>  
>  /* Shutdown a wireless core */
>  /* Locking: wl->mutex */
> -static void b43_wireless_core_exit(struct b43_wldev *dev)
> +static void __b43_wireless_core_exit(struct b43_wldev *dev, bool no_suspend)
>  {
>  	struct b43_phy *phy = &dev->phy;
>  
> @@ -3298,8 +3303,10 @@ static void b43_wireless_core_exit(struc
>  		return;
>  	b43_set_status(dev, B43_STAT_UNINIT);
>  
> -	b43_leds_exit(dev);
> -	b43_rng_exit(dev->wl);
> +	if (no_suspend) {
> +		b43_leds_exit(dev);
> +		b43_rng_exit(dev->wl);
> +	}
>  	b43_pio_free(dev);
>  	b43_dma_free(dev);
>  	b43_chip_exit(dev);
> @@ -3313,8 +3320,13 @@ static void b43_wireless_core_exit(struc
>  	ssb_bus_may_powerdown(dev->dev->bus);
>  }
>  
> +static void b43_wireless_core_exit(struct b43_wldev *dev)
> +{
> +	__b43_wireless_core_exit(dev, true);
> +}

Nah, please don't obfuscate the code.
Better add a flag to struct b43_wldev and check that in the few places
that need different behaviour.

>  /* Initialize a wireless core */
> -static int b43_wireless_core_init(struct b43_wldev *dev)
> +static int __b43_wireless_core_init(struct b43_wldev *dev, bool no_suspend)
>  {
>  	struct b43_wl *wl = dev->wl;
>  	struct ssb_bus *bus = dev->dev->bus;
> @@ -3420,11 +3432,13 @@ static int b43_wireless_core_init(struct
>  	memset(wl->mac_addr, 0, ETH_ALEN);
>  	b43_upload_card_macaddress(dev);
>  	b43_security_init(dev);
> -	b43_rng_init(wl);
> +	if (no_suspend)
> +		b43_rng_init(wl);
>  
>  	b43_set_status(dev, B43_STAT_INITIALIZED);
>  
> -	b43_leds_init(dev);
> +	if (no_suspend)
> +		b43_leds_init(dev);
>  out:
>  	return err;
>  
> @@ -3442,6 +3456,11 @@ out:
>  	return err;
>  }
>  
> +static int b43_wireless_core_init(struct b43_wldev *dev)
> +{
> +	return __b43_wireless_core_init(dev, true);
> +}
> +
>  static int b43_op_add_interface(struct ieee80211_hw *hw,
>  				struct ieee80211_if_init_conf *conf)
>  {
> @@ -4028,7 +4047,7 @@ static int b43_suspend(struct ssb_device
>  	if (wldev->suspend_init_status >= B43_STAT_STARTED)
>  		b43_wireless_core_stop(wldev);
>  	if (wldev->suspend_init_status >= B43_STAT_INITIALIZED)
> -		b43_wireless_core_exit(wldev);
> +		__b43_wireless_core_exit(wldev, false);
>  	mutex_unlock(&wl->mutex);
>  
>  	b43dbg(wl, "Device suspended.\n");
> @@ -4046,7 +4065,7 @@ static int b43_resume(struct ssb_device 
>  
>  	mutex_lock(&wl->mutex);
>  	if (wldev->suspend_init_status >= B43_STAT_INITIALIZED) {
> -		err = b43_wireless_core_init(wldev);
> +		err = __b43_wireless_core_init(wldev, false);
>  		if (err) {
>  			b43err(wl, "Resume failed at core init\n");
>  			goto out;
> @@ -4055,7 +4074,9 @@ static int b43_resume(struct ssb_device 
>  	if (wldev->suspend_init_status >= B43_STAT_STARTED) {
>  		err = b43_wireless_core_start(wldev);
>  		if (err) {
> -			b43_wireless_core_exit(wldev);
> +			b43_leds_resume_exit(wldev);
> +			__b43_rng_exit(wldev->wl, true);
> +			__b43_wireless_core_exit(wldev, false);
>  			b43err(wl, "Resume failed at core start\n");
>  			goto out;
>  		}
> Index: linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/leds.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/net/wireless/b43/leds.h
> +++ linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/leds.h
> @@ -43,8 +43,15 @@ enum b43_led_behaviour {
>  };
>  
>  void b43_leds_init(struct b43_wldev *dev);
> -void b43_leds_exit(struct b43_wldev *dev);
> -
> +void __b43_leds_exit(struct b43_wldev *dev, bool suspended);
> +static inline void b43_leds_exit(struct b43_wldev *dev)
> +{
> +	__b43_leds_exit(dev, false);
> +}
> +static inline void b43_leds_resume_exit(struct b43_wldev *dev)
> +{
> +	__b43_leds_exit(dev, true);
> +}

No obfuscation please.

>  #else /* CONFIG_B43_LEDS */
>  /* LED support disabled */
> @@ -59,6 +66,9 @@ static inline void b43_leds_init(struct 
>  static inline void b43_leds_exit(struct b43_wldev *dev)
>  {
>  }
> +static inline void b43_leds_resume_exit(struct b43_wldev *dev)
> +{
> +}
>  #endif /* CONFIG_B43_LEDS */
>  
>  #endif /* B43_LEDS_H_ */
> Index: linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/leds.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/net/wireless/b43/leds.c
> +++ linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/leds.c
> @@ -112,11 +112,14 @@ static int b43_register_led(struct b43_w
>  	return 0;
>  }
>  
> -static void b43_unregister_led(struct b43_led *led)
> +static void b43_unregister_led(struct b43_led *led, bool suspended)
>  {
>  	if (!led->dev)
>  		return;
> -	led_classdev_unregister(&led->led_dev);
> +	if (suspended)
> +		led_classdev_unregister_suspended(&led->led_dev);
> +	else
> +		led_classdev_unregister(&led->led_dev);
>  	b43_led_turn_off(led->dev, led->index, led->activelow);
>  	led->dev = NULL;
>  }
> @@ -230,10 +233,10 @@ void b43_leds_init(struct b43_wldev *dev
>  	}
>  }
>  
> -void b43_leds_exit(struct b43_wldev *dev)
> +void __b43_leds_exit(struct b43_wldev *dev, bool suspended)
>  {
> -	b43_unregister_led(&dev->led_tx);
> -	b43_unregister_led(&dev->led_rx);
> -	b43_unregister_led(&dev->led_assoc);
> -	b43_unregister_led(&dev->led_radio);
> +	b43_unregister_led(&dev->led_tx, suspended);
> +	b43_unregister_led(&dev->led_rx, suspended);
> +	b43_unregister_led(&dev->led_assoc, suspended);
> +	b43_unregister_led(&dev->led_radio, suspended);
>  }
> Index: linux-2.6.24-rc8-mm1/drivers/leds/led-class.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/leds/led-class.c
> +++ linux-2.6.24-rc8-mm1/drivers/leds/led-class.c
> @@ -137,12 +137,14 @@ err_out:
>  EXPORT_SYMBOL_GPL(led_classdev_register);
>  
>  /**
> - * led_classdev_unregister - unregisters a object of led_properties class.
> + * __led_classdev_unregister - unregisters a object of led_properties class.
>   * @led_cdev: the led device to unregister
> + * @suspended: indicates whether system-wide suspend or resume is in progress
>   *
>   * Unregisters a previously registered via led_classdev_register object.
>   */
> -void led_classdev_unregister(struct led_classdev *led_cdev)
> +void __led_classdev_unregister(struct led_classdev *led_cdev,
> +				      bool suspended)
>  {
>  	device_remove_file(led_cdev->dev, &dev_attr_brightness);
>  #ifdef CONFIG_LEDS_TRIGGERS
> @@ -153,13 +155,16 @@ void led_classdev_unregister(struct led_
>  	up_write(&led_cdev->trigger_lock);
>  #endif
>  
> -	device_unregister(led_cdev->dev);
> +	if (suspended)
> +		device_pm_schedule_removal(led_cdev->dev);
> +	else
> +		device_unregister(led_cdev->dev);
>  
>  	down_write(&leds_list_lock);
>  	list_del(&led_cdev->node);
>  	up_write(&leds_list_lock);
>  }
> -EXPORT_SYMBOL_GPL(led_classdev_unregister);
> +EXPORT_SYMBOL_GPL(__led_classdev_unregister);
>  
>  static int __init leds_init(void)
>  {
> Index: linux-2.6.24-rc8-mm1/include/linux/leds.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/include/linux/leds.h
> +++ linux-2.6.24-rc8-mm1/include/linux/leds.h
> @@ -59,7 +59,15 @@ struct led_classdev {
>  
>  extern int led_classdev_register(struct device *parent,
>  				 struct led_classdev *led_cdev);
> -extern void led_classdev_unregister(struct led_classdev *led_cdev);
> +extern void __led_classdev_unregister(struct led_classdev *led_cdev, bool sus);
> +static inline void led_classdev_unregister(struct led_classdev *lcd)
> +{
> +	__led_classdev_unregister(lcd, false);
> +}
> +static inline void led_classdev_unregister_suspended(struct led_classdev *lcd)
> +{
> +	__led_classdev_unregister(lcd, true);
> +}
>  extern void led_classdev_suspend(struct led_classdev *led_cdev);
>  extern void led_classdev_resume(struct led_classdev *led_cdev);
>  
> Index: linux-2.6.24-rc8-mm1/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/base/power/main.c
> +++ linux-2.6.24-rc8-mm1/drivers/base/power/main.c
> @@ -129,6 +129,7 @@ void device_pm_schedule_removal(struct d
>  	list_move_tail(&dev->power.entry, &dpm_destroy);
>  	mutex_unlock(&dpm_list_mtx);
>  }
> +EXPORT_SYMBOL_GPL(device_pm_schedule_removal);
>  
>  /**
>   *	pm_sleep_lock - mutual exclusion for registration and suspend
> Index: linux-2.6.24-rc8-mm1/include/linux/device.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/include/linux/device.h
> +++ linux-2.6.24-rc8-mm1/include/linux/device.h
> @@ -532,11 +532,17 @@ extern struct device *device_create(stru
>  extern void device_destroy(struct class *cls, dev_t devt);
>  #ifdef CONFIG_PM_SLEEP
>  extern void destroy_suspended_device(struct class *cls, dev_t devt);
> +extern void device_pm_schedule_removal(struct device *);
>  #else /* !CONFIG_PM_SLEEP */
>  static inline void destroy_suspended_device(struct class *cls, dev_t devt)
>  {
>  	device_destroy(cls, devt);
>  }
> +
> +static inline void device_pm_schedule_removal(struct device *dev)
> +{
> +	device_unregister(dev);
> +}
>  #endif /* !CONFIG_PM_SLEEP */
>  
>  /*
> Index: linux-2.6.24-rc8-mm1/drivers/base/power/power.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/base/power/power.h
> +++ linux-2.6.24-rc8-mm1/drivers/base/power/power.h
> @@ -13,7 +13,6 @@ static inline struct device *to_device(s
>  
>  extern void device_pm_add(struct device *);
>  extern void device_pm_remove(struct device *);
> -extern void device_pm_schedule_removal(struct device *);
>  extern int pm_sleep_lock(void);
>  extern void pm_sleep_unlock(void);
>  
> Index: linux-2.6.24-rc8-mm1/drivers/char/misc.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/char/misc.c
> +++ linux-2.6.24-rc8-mm1/drivers/char/misc.c
> @@ -232,8 +232,9 @@ int misc_register(struct miscdevice * mi
>  }
>  
>  /**
> - *	misc_deregister - unregister a miscellaneous device
> + *	__misc_deregister - unregister a miscellaneous device
>   *	@misc: device to unregister
> + *	@suspended: to be set if the function is used during suspend/resume
>   *
>   *	Unregister a miscellaneous device that was previously
>   *	successfully registered with misc_register(). Success
> @@ -241,7 +242,7 @@ int misc_register(struct miscdevice * mi
>   *	indicates an error.
>   */
>  
> -int misc_deregister(struct miscdevice * misc)
> +int __misc_deregister(struct miscdevice *misc, bool suspended)
>  {
>  	int i = misc->minor;
>  
> @@ -250,7 +251,11 @@ int misc_deregister(struct miscdevice * 
>  
>  	mutex_lock(&misc_mtx);
>  	list_del(&misc->list);
> -	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
> +	if (suspended)
> +		destroy_suspended_device(misc_class,
> +					MKDEV(MISC_MAJOR, misc->minor));
> +	else
> +		device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
>  	if (i < DYNAMIC_MINORS && i>0) {
>  		misc_minors[i>>3] &= ~(1 << (misc->minor & 7));
>  	}
> @@ -259,7 +264,7 @@ int misc_deregister(struct miscdevice * 
>  }
>  
>  EXPORT_SYMBOL(misc_register);
> -EXPORT_SYMBOL(misc_deregister);
> +EXPORT_SYMBOL(__misc_deregister);
>  
>  static int __init misc_init(void)
>  {
> Index: linux-2.6.24-rc8-mm1/include/linux/miscdevice.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/include/linux/miscdevice.h
> +++ linux-2.6.24-rc8-mm1/include/linux/miscdevice.h
> @@ -43,7 +43,15 @@ struct miscdevice  {
>  };
>  
>  extern int misc_register(struct miscdevice * misc);
> -extern int misc_deregister(struct miscdevice * misc);
> +extern int __misc_deregister(struct miscdevice *misc, bool suspended);
> +static inline int misc_deregister(struct miscdevice *misc)
> +{
> +	return __misc_deregister(misc, false);
> +}
> +static inline int misc_deregister_suspended(struct miscdevice *misc)
> +{
> +	return __misc_deregister(misc, true);
> +}
>  
>  #define MODULE_ALIAS_MISCDEV(minor)				\
>  	MODULE_ALIAS("char-major-" __stringify(MISC_MAJOR)	\
> Index: linux-2.6.24-rc8-mm1/drivers/char/hw_random/core.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/char/hw_random/core.c
> +++ linux-2.6.24-rc8-mm1/drivers/char/hw_random/core.c
> @@ -234,11 +234,11 @@ static DEVICE_ATTR(rng_available, S_IRUG
>  		   NULL);
>  
>  
> -static void unregister_miscdev(void)
> +static void unregister_miscdev(bool suspended)
>  {
>  	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_available);
>  	device_remove_file(rng_miscdev.this_device, &dev_attr_rng_current);
> -	misc_deregister(&rng_miscdev);
> +	__misc_deregister(&rng_miscdev, suspended);
>  }
>  
>  static int register_miscdev(void)
> @@ -313,7 +313,7 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(hwrng_register);
>  
> -void hwrng_unregister(struct hwrng *rng)
> +void __hwrng_unregister(struct hwrng *rng, bool suspended)
>  {
>  	int err;
>  
> @@ -332,11 +332,11 @@ void hwrng_unregister(struct hwrng *rng)
>  		}
>  	}
>  	if (list_empty(&rng_list))
> -		unregister_miscdev();
> +		unregister_miscdev(suspended);
>  
>  	mutex_unlock(&rng_mutex);
>  }
> -EXPORT_SYMBOL_GPL(hwrng_unregister);
> +EXPORT_SYMBOL_GPL(__hwrng_unregister);
>  
>  
>  MODULE_DESCRIPTION("H/W Random Number Generator (RNG) driver");
> Index: linux-2.6.24-rc8-mm1/include/linux/hw_random.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/include/linux/hw_random.h
> +++ linux-2.6.24-rc8-mm1/include/linux/hw_random.h
> @@ -44,7 +44,15 @@ struct hwrng {
>  /** Register a new Hardware Random Number Generator driver. */
>  extern int hwrng_register(struct hwrng *rng);
>  /** Unregister a Hardware Random Number Generator driver. */
> -extern void hwrng_unregister(struct hwrng *rng);
> +extern void __hwrng_unregister(struct hwrng *rng, bool suspended);
> +static inline void hwrng_unregister(struct hwrng *rng)
> +{
> +	__hwrng_unregister(rng, false);
> +}
> +static inline void hwrng_unregister_suspended(struct hwrng *rng)
> +{
> +	__hwrng_unregister(rng, true);
> +}
>  
>  #endif /* __KERNEL__ */
>  #endif /* LINUX_HWRANDOM_H_ */
> 
> 

From: Michael Buesch <mb@bu3sch.de>
Subject: Re: b43_suspend problem
Date: Mon, 21 Jan 2008 16:05:10 +0100
Message-ID: <200801211605.10446.mb__26455.5892827504$1200928071$gmane$org@bu3sch.de>
References: <Pine.LNX.4.44L0.0801131634380.28667-100000@netrider.rowland.org>
	<200801202110.36556.mb@bu3sch.de> <200801210109.57359.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801210109.57359.rjw@sisk.pl>
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

On Monday 21 January 2008, Rafael J. Wysocki wrote:
> I modified the patch to implement something like this.  This still is one big
> patch against everything what's necessary.  [BTW, in the current version
> of the code, b43_resume() may leave wl->mutex locked in the error paths,
> which also is fixed by the patch.]

Whoopsy, thanks for catching this.

> Index: linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/main.c
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/net/wireless/b43/main.c
> +++ linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/main.c
> @@ -2470,10 +2470,10 @@ static int b43_rng_read(struct hwrng *rn
>  	return (sizeof(u16));
>  }
>  
> -static void b43_rng_exit(struct b43_wl *wl)
> +static void b43_rng_exit(struct b43_wl *wl, bool suspended)
>  {
>  	if (wl->rng_initialized)
> -		hwrng_unregister(&wl->rng);
> +		__hwrng_unregister(&wl->rng, suspended);
>  }
>  
>  static int b43_rng_init(struct b43_wl *wl)
> @@ -3298,8 +3298,10 @@ static void b43_wireless_core_exit(struc
>  		return;
>  	b43_set_status(dev, B43_STAT_UNINIT);
>  
> -	b43_leds_exit(dev);
> -	b43_rng_exit(dev->wl);
> +	if (!dev->suspend_in_progress) {
> +		b43_leds_exit(dev);
> +		b43_rng_exit(dev->wl, false);
> +	}
>  	b43_pio_free(dev);
>  	b43_dma_free(dev);
>  	b43_chip_exit(dev);
> @@ -3420,11 +3422,13 @@ static int b43_wireless_core_init(struct
>  	memset(wl->mac_addr, 0, ETH_ALEN);
>  	b43_upload_card_macaddress(dev);
>  	b43_security_init(dev);
> -	b43_rng_init(wl);
> +	if (!dev->suspend_in_progress)
> +		b43_rng_init(wl);
>  
>  	b43_set_status(dev, B43_STAT_INITIALIZED);
>  
> -	b43_leds_init(dev);
> +	if (!dev->suspend_in_progress)
> +		b43_leds_init(dev);
>  out:
>  	return err;
>  
> @@ -4024,6 +4028,7 @@ static int b43_suspend(struct ssb_device
>  	b43dbg(wl, "Suspending...\n");
>  
>  	mutex_lock(&wl->mutex);
> +	wldev->suspend_in_progress = true;
>  	wldev->suspend_init_status = b43_status(wldev);
>  	if (wldev->suspend_init_status >= B43_STAT_STARTED)
>  		b43_wireless_core_stop(wldev);
> @@ -4055,15 +4060,17 @@ static int b43_resume(struct ssb_device 
>  	if (wldev->suspend_init_status >= B43_STAT_STARTED) {
>  		err = b43_wireless_core_start(wldev);
>  		if (err) {
> +			b43_leds_resume_exit(wldev);
> +			b43_rng_exit(wldev->wl, true);
>  			b43_wireless_core_exit(wldev);
>  			b43err(wl, "Resume failed at core start\n");
>  			goto out;
>  		}
>  	}
> -	mutex_unlock(&wl->mutex);
> -
>  	b43dbg(wl, "Device resumed.\n");
> -      out:
> + out:
> +	wldev->suspend_in_progress = false;
> +	mutex_unlock(&wl->mutex);
>  	return err;
>  }
>

This part looks OK.

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

I still don't like this function wrapping.
I'm pretty sure the additional parameter to the function is not
needed. We can check dev->suspend_in_progress to find out
if we are in a up/down or in a suspend/resume cycle.

> -static void b43_unregister_led(struct b43_led *led)
> +static void b43_unregister_led(struct b43_led *led, bool suspended)
>  {
>  	if (!led->dev)
>  		return;
> -	led_classdev_unregister(&led->led_dev);
> +	if (suspended)

You can check led->dev->suspend_in_progress here.

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

Don't need this hunk. Check led->dev->suspend_in_progress in
b43_unregister_led.

>  #endif /* __KERNEL__ */
>  #endif /* LINUX_HWRANDOM_H_ */
> Index: linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/b43.h
> ===================================================================
> --- linux-2.6.24-rc8-mm1.orig/drivers/net/wireless/b43/b43.h
> +++ linux-2.6.24-rc8-mm1/drivers/net/wireless/b43/b43.h
> @@ -706,6 +706,7 @@ struct b43_wldev {
>  	bool short_preamble;	/* TRUE, if short preamble is enabled. */
>  	bool short_slot;	/* TRUE, if short slot timing is enabled. */
>  	bool radio_hw_enable;	/* saved state of radio hardware enabled state */
> +	bool suspend_in_progress;

Please add a comment like: /* TRUE, if we are in a suspend/resume cycle */

I like comments. Can never have enough of them. _Especially_ for data structures. :)

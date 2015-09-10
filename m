From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Thu, 10 Sep 2015 13:58:37 +0300
Message-ID: <55F1625D.9090209@ti.com>
References: <1441880343-30852-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49839 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbbIJK6o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 06:58:44 -0400
In-Reply-To: <1441880343-30852-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bilhuang@nvidia.com

On 09/10/2015 01:19 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Deferred probe can lead to strange situations where a device that is a
> dependency for others will be moved to the end of the dpm_list. At the
> same time the dependers may not be moved because at the time they will
> be probed the dependee may already have been successfully reprobed and
> they will not have to defer the probe themselves.
> 
> One example where this happens is the Jetson TK1 board (Tegra124). The
> gpio-keys driver exposes the power key of the board as an input device
> that can also be used as a wakeup source. Commit 17cdddf0fb68 ("ARM:
> tegra: Add gpio-ranges property") results in the gpio-tegra driver
> deferring probe because one of its dependencies, the pinctrl-tegra
> driver, has not successfully completed probing. Currently the deferred
> probe code will move the corresponding gpio-tegra device to the end of
> the dpm_list, but by the time the gpio-keys device, depending on the
> gpio-tegra device, is probed, gpio-tegra has already been reprobed, so
> the gpio-keys device is not moved to the end of dpm_list itself. As a
> result, the suspend ordering becomes pinctrl-tegra -> gpio-keys ->
> gpio-tegra. That's problematic because the gpio-keys driver requests
> the power key to be a wakeup source. However, the programming of the
> wakeup interrupt registers happens in the gpio-tegra driver's suspend
> callback, which is now called before that of the gpio-keys driver. The
> result is that the wrong values are programmed and leaves the system
> unable to be resumed using the power key.
> 
> To fix this situation, always move devices to the end of the dpm_list
> before probing them. Technically this should only be done for devices
> that have been successfully probed, but that won't work for recursive
> probing of devices (think an I2C master that instantiates children in
> its ->probe()). Effectively the dpm_list will end up ordered the same
> way that devices were probed, hence taking care of dependencies.

Second try :), first one was here:
"[RFC 1/1] driver core: re-order dpm_list after a succussful probe"
https://lkml.org/lkml/2014/12/12/324
and it was unsuccessful exactly because dpm_list was reordered after probe()
and not before, i think.

I'll try to test it.

> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Note that this commit is kind of the PM equivalent of 52cdbdd49853
> ("driver core: correct device's shutdown order) and that we have two
> lists that are essentially the same (dpm_list and devices_kset). I'm
> wondering if it would be worth looking into getting rid of one of
> them? I don't see any reason why the ordering for shutdown and
> suspend/resume should be different, and having a single list would
> help keep this in sync.

Yep. I've tried to remove one of those lists while working on shutdown issue.
I've tried to drop dmp_list, but my try was unsuccessful, because I was not
able to find simple way to handle device's  dynamic creation/removal during
suspend/resume :(.
Also note, dmp_list's presence depends on Kconfig options.

> 
>   drivers/base/dd.c | 33 +++++++++++++++++++++++----------
>   1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index be0eb4639128..56291b11049b 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -88,16 +88,6 @@ static void deferred_probe_work_func(struct work_struct *work)
>   		 */
>   		mutex_unlock(&deferred_probe_mutex);
>   
> -		/*
> -		 * Force the device to the end of the dpm_list since
> -		 * the PM code assumes that the order we add things to
> -		 * the list is a good order for suspend but deferred
> -		 * probe makes that very unsafe.
> -		 */
> -		device_pm_lock();
> -		device_pm_move_last(dev);
> -		device_pm_unlock();
> -
>   		dev_dbg(dev, "Retrying from deferred list\n");
>   		bus_probe_device(dev);
>   
> @@ -312,6 +302,29 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>   	 */
>   	devices_kset_move_last(dev);
>   
> +	/*
> +	 * Force the device to the end of the dpm_list since the PM code
> +	 * assumes that the order we add things to the list is a good order
> +	 * for suspend but deferred probe makes that very unsafe.
> +	 *
> +	 * Deferred probe can also cause situations in which a device that is
> +	 * a dependency for others gets moved further down the dpm_list as a
> +	 * result of probe deferral. In that case the dependee will end up
> +	 * getting suspended before any of its dependers.
> +	 *
> +	 * To ensure proper ordering of suspend/resume, move every device that
> +	 * is being probed to the end of the dpm_list. Note that technically
> +	 * only successfully probed devices need to be moved, but that breaks
> +	 * for recursively added devices because they would end up in the list
> +	 * in reverse of the desired order, so we simply do it unconditionally
> +	 * for all devices before they are being probed. In the worst case the
> +	 * list will be reordered a couple more times than necessary, which
> +	 * should be an insignificant amount of work.
> +	 */
> +	device_pm_lock();
> +	device_pm_move_last(dev);
> +	device_pm_unlock();
> +
>   	if (dev->bus->probe) {
>   		ret = dev->bus->probe(dev);
>   		if (ret)
> 


-- 
regards,
-grygorii

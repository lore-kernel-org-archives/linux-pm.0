From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 1/2] ACPI / PM: Allow attach/detach routines to change
 device power states
Date: Mon, 26 Nov 2012 08:43:10 +0800
Message-ID: <1353890590.28789.68.camel@yhuang-dev>
References: <1672179.qgDUs0YdYu@vostro.rjw.lan>
	 <2576372.XKUY0b7gBl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2576372.XKUY0b7gBl@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, "Svahn, Kai" <kai.svahn@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, Aaron Lu <aaron.lu@intel.com>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-pm@vger.kernel.org

On Sun, 2012-11-25 at 15:55 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make it possible to ask the routines used for adding/removing devices
> to/from the general ACPI PM domain, acpi_dev_pm_attach() and
> acpi_dev_pm_detach(), respectively, to change the power states of
> devices so that they are put into the full-power state automatically
> by acpi_dev_pm_attach() and into the lowest-power state available
> automatically by acpi_dev_pm_detach().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/device_pm.c |   28 ++++++++++++++++++++++++----
>  include/linux/acpi.h     |   11 +++++++----
>  2 files changed, 31 insertions(+), 8 deletions(-)
> 
> Index: linux/drivers/acpi/device_pm.c
> ===================================================================
> --- linux.orig/drivers/acpi/device_pm.c
> +++ linux/drivers/acpi/device_pm.c
> @@ -599,10 +599,12 @@ static struct dev_pm_domain acpi_general
>  /**
>   * acpi_dev_pm_attach - Prepare device for ACPI power management.
>   * @dev: Device to prepare.
> + * @power_on: Whether or not to power on the device.
>   *
>   * If @dev has a valid ACPI handle that has a valid struct acpi_device object
>   * attached to it, install a wakeup notification handler for the device and
> - * add it to the general ACPI PM domain.
> + * add it to the general ACPI PM domain.  If @power_on is set, the device will
> + * be put into the ACPI D0 state before the function returns.
>   *
>   * This assumes that the @dev's bus type uses generic power management callbacks
>   * (or doesn't use any power management callbacks at all).
> @@ -610,7 +612,7 @@ static struct dev_pm_domain acpi_general
>   * Callers must ensure proper synchronization of this function with power
>   * management callbacks.
>   */
> -int acpi_dev_pm_attach(struct device *dev)
> +int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>  	struct acpi_device *adev = acpi_dev_pm_get_node(dev);
>  
> @@ -622,6 +624,10 @@ int acpi_dev_pm_attach(struct device *de
>  
>  	acpi_add_pm_notifier(adev, acpi_wakeup_device, dev);
>  	dev->pm_domain = &acpi_general_pm_domain;
> +	if (power_on) {
> +		acpi_dev_pm_full_power(adev);
> +		__acpi_device_run_wake(adev, false);
> +	}
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> @@ -629,20 +635,34 @@ EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>  /**
>   * acpi_dev_pm_detach - Remove ACPI power management from the device.
>   * @dev: Device to take care of.
> + * @power_off: Whether or not to try to remove power from the device.
>   *
>   * Remove the device from the general ACPI PM domain and remove its wakeup
> - * notifier.
> + * notifier.  If @power_off is set, additionally remove power from the device if
> + * possible.
>   *
>   * Callers must ensure proper synchronization of this function with power
>   * management callbacks.
>   */
> -void acpi_dev_pm_detach(struct device *dev)
> +void acpi_dev_pm_detach(struct device *dev, bool power_off)
>  {
>  	struct acpi_device *adev = acpi_dev_pm_get_node(dev);
>  
>  	if (adev && dev->pm_domain == &acpi_general_pm_domain) {
>  		dev->pm_domain = NULL;
>  		acpi_remove_pm_notifier(adev, acpi_wakeup_device);
> +		if (power_off) {
> +			/*
> +			 * If the device's PM QoS resume latency limit or flags
> +			 * have been exposed to user space, they have to be
> +			 * hidden at this point, so that they don't affect the
> +			 * choice of the low-power state to put the device into.
> +			 */
> +			dev_pm_qos_hide_latency_limit(dev);
> +			dev_pm_qos_hide_flags(dev);

NO_POWER_OFF flag is ignored here.  Is it possible for some device (or
corresponding ACPI method) has broken D3cold implementation, so that the
user need a way to disable it?

Best Regards,
Huang Ying

> +			__acpi_device_run_wake(adev, false);
> +			acpi_dev_pm_low_power(dev, adev, ACPI_STATE_S0);
> +		}
>  	}
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_detach);
> Index: linux/include/linux/acpi.h
> ===================================================================
> --- linux.orig/include/linux/acpi.h
> +++ linux/include/linux/acpi.h
> @@ -510,11 +510,14 @@ static inline int acpi_subsys_resume_ear
>  #endif
>  
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM)
> -int acpi_dev_pm_attach(struct device *dev);
> -int acpi_dev_pm_detach(struct device *dev);
> +int acpi_dev_pm_attach(struct device *dev, bool power_on);
> +int acpi_dev_pm_detach(struct device *dev, bool power_off);
>  #else
> -static inline int acpi_dev_pm_attach(struct device *dev) { return -ENODEV; }
> -static inline void acpi_dev_pm_detach(struct device *dev) {}
> +static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
> +{
> +	return -ENODEV;
> +}
> +static inline void acpi_dev_pm_detach(struct device *dev, bool power_off) {}
>  #endif
>  
>  #ifdef CONFIG_ACPI
> 



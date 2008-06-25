From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC][PATCH 6/9] PCI ACPI: Introduce
	acpi_pm_device_sleep_wake	function
Date: Wed, 25 Jun 2008 16:11:07 +0800
Message-ID: <1214381467.3001.173.camel__33163.7813164436$1214381721$gmane$org@rzhang-dt.sh.intel.com>
References: <200806200145.33053.rjw@sisk.pl> <200806200151.26604.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806200151.26604.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

Hi, Rafael,

On Fri, 2008-06-20 at 01:51 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI ACPI: Introduce acpi_pm_device_sleep_wake function
> 
> Introduce function acpi_pm_device_sleep_wake() for enabling and
> disabling the system wake-up capability of devices that are power
> manageable by ACPI.
> 
> Introduce callback .sleep_wake() in struct pci_platform_pm_ops and
> for the ACPI PCI 'driver' make it use acpi_pm_device_sleep_wake().

acpi_pm_device_sleep_wake only enable/disable the power of wakeup
device, right?
If it doesn't set the acpi_device->wakeup.state.enabled, the wake up GPE
will not be enabled, which means the pci devices which have invoked
platform_pci_sleep_wake(dev, true) can not wake up the system as
excepted.
so this patch won't work. Is this what you want? or do I miss something?

But what is annoying me is that,
if acpi_device->wakeup.state.enabled is set in
acpi_pm_device_sleep_wake, this may bring some other trouble.
A lot of pci devices will call platform_pci_sleep_wake(dev, true) by
default, they won't wake up the system before because the wake up GPEs
are disabled, but they will do if this patch is applied.
So some of the users may got the "resume immediately after sleep"
problem, that's a regression, isn't it?

we have discussed this a couple of times on the list, but we have not
got a solution yet.
IMO, both Dave's and your patches are good, and we can be a little
aggressive to merge them, and fix the drivers once we get any
regressions ASAP.
i.e. either change pci_enable_wake(dev, 1) to pci_enable_wake(dev, 0) in
the drivers suspend method, or invoke  device_set_wakeup_enable(dev, 0)
to disable the wakeup ability after the call to device_init_wakeup(dev,
1).

any ideas?

thanks,
rui

> 
> Modify pci_enable_wake() to use the new callback and drop the generic
> .platform_enable_wakeup() callback that is not used any more.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/main.c  |   25 +++++++++++++++++
>  drivers/base/power/sysfs.c |    3 --
>  drivers/pci/pci-acpi.c     |   11 +++++++
>  drivers/pci/pci.c          |   64 ++++++++++++++++++++++++++++++---------------
>  drivers/pci/pci.h          |    3 ++
>  include/acpi/acpi_bus.h    |    1 
>  include/linux/pm_wakeup.h  |   16 -----------
>  7 files changed, 84 insertions(+), 39 deletions(-)
> 
> Index: linux-next/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-next.orig/drivers/acpi/sleep/main.c
> +++ linux-next/drivers/acpi/sleep/main.c
> @@ -468,6 +468,31 @@ int acpi_pm_device_sleep_state(struct de
>  		*d_min_p = d_min;
>  	return d_max;
>  }
> +
> +/**
> + *	acpi_pm_device_sleep_wake - enable or disable the system wake-up
> + *                                  capability of given device
> + *	@dev: device to handle
> + *	@enable: 'true' - enable, 'false' - disable the wake-up capability
> + */
> +int acpi_pm_device_sleep_wake(struct device *dev, bool enable)
> +{
> +	acpi_handle handle;
> +	struct acpi_device *adev;
> +
> +	if (!device_may_wakeup(dev))
> +		return -EINVAL;
> +
> +	handle = DEVICE_ACPI_HANDLE(dev);
> +	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &adev))) {
> +		printk(KERN_DEBUG "ACPI handle has no context!\n");
> +		return -ENODEV;
> +	}
> +
> +	return enable ?
> +		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
> +		acpi_disable_wakeup_device_power(adev);
> +}
>  #endif
>  
>  static void acpi_power_off_prepare(void)
> Index: linux-next/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-next.orig/drivers/pci/pci-acpi.c
> +++ linux-next/drivers/pci/pci-acpi.c
> @@ -299,10 +299,21 @@ static int acpi_pci_set_power_state(stru
>  	return error;
>  }
>  
> +static int acpi_pci_sleep_wake(struct pci_dev *dev, bool enable)
> +{
> +	int error = acpi_pm_device_sleep_wake(&dev->dev, enable);
> +
> +	if (!error)
> +		printk(KERN_INFO "PCI: Wake-up capability of %s %s by ACPI\n",
> +			pci_name(dev), enable ? "enabled" : "disabled");
> +	return error;
> +}
> +
>  static struct pci_platform_pm_ops acpi_pci_platform_pm = {
>  	.is_manageable = acpi_pci_power_manageable,
>  	.set_state = acpi_pci_set_power_state,
>  	.choose_state = acpi_pci_choose_state,
> +	.sleep_wake = acpi_pci_sleep_wake,
>  };
>  
>  /* ACPI bus type */
> Index: linux-next/drivers/pci/pci.h
> ===================================================================
> --- linux-next.orig/drivers/pci/pci.h
> +++ linux-next/drivers/pci/pci.h
> @@ -17,6 +17,8 @@ extern void pci_cleanup_rom(struct pci_d
>   *                 platform; to be used during system-wide transitions from a
>   *                 sleeping state to the working state and vice versa
>   *
> + * @sleep_wake - enables/disables the system wake up capability of given device
> + *
>   * If given platform is generally capable of power managing PCI devices, all of
>   * these callbacks are mandatory.
>   */
> @@ -24,6 +26,7 @@ struct pci_platform_pm_ops {
>  	bool (*is_manageable)(struct pci_dev *dev);
>  	int (*set_state)(struct pci_dev *dev, pci_power_t state);
>  	pci_power_t (*choose_state)(struct pci_dev *dev);
> +	int (*sleep_wake)(struct pci_dev *dev, bool enable);
>  };
>  
>  extern int pci_set_platform_pm(struct pci_platform_pm_ops *ops);
> Index: linux-next/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-next.orig/include/acpi/acpi_bus.h
> +++ linux-next/include/acpi/acpi_bus.h
> @@ -383,6 +383,7 @@ acpi_handle acpi_get_pci_rootbridge_hand
>  
>  #ifdef CONFIG_PM_SLEEP
>  int acpi_pm_device_sleep_state(struct device *, int *);
> +int acpi_pm_device_sleep_wake(struct device *, bool);
>  #else /* !CONFIG_PM_SLEEP */
>  static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
>  {
> Index: linux-next/drivers/pci/pci.c
> ===================================================================
> --- linux-next.orig/drivers/pci/pci.c
> +++ linux-next/drivers/pci/pci.c
> @@ -380,7 +380,8 @@ static struct pci_platform_pm_ops *pci_p
>  
>  int pci_set_platform_pm(struct pci_platform_pm_ops *ops)
>  {
> -	if (!ops->is_manageable || !ops->set_state || !ops->choose_state)
> +	if (!ops->is_manageable || !ops->set_state || !ops->choose_state
> +	    || !ops->sleep_wake)
>  		return -EINVAL;
>  	pci_platform_pm = ops;
>  	return 0;
> @@ -403,6 +404,12 @@ static inline pci_power_t platform_pci_c
>  			pci_platform_pm->choose_state(dev) : PCI_POWER_ERROR;
>  }
>  
> +static inline int platform_pci_sleep_wake(struct pci_dev *dev, bool enable)
> +{
> +	return pci_platform_pm ?
> +			pci_platform_pm->sleep_wake(dev, enable) : -ENODEV;
> +}
> +
>  /**
>   * pci_set_power_state - Set the power state of a PCI device
>   * @dev: PCI device to be suspended
> @@ -1018,24 +1025,27 @@ int pci_set_pcie_reset_state(struct pci_
>   * supporting the standard PCI PME# signal may require such platform hooks;
>   * they always update bits in config space to allow PME# generation.
>   *
> - * -EIO is returned if the device can't ever be a wakeup event source.
> + * -EIO is returned if the device can't be a wakeup event source.
>   * -EINVAL is returned if the device can't generate wakeup events from
>   * the specified PCI state.  Returns zero if the operation is successful.
>   */
>  int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable)
>  {
>  	int pm;
> -	int status;
> -	u16 value;
> +	u16 value = 0;
> +	bool platform_done = false;
>  
> -	/* Note that drivers should verify device_may_wakeup(&dev->dev)
> -	 * before calling this function.  Platform code should report
> -	 * errors when drivers try to enable wakeup on devices that
> -	 * can't issue wakeups, or on which wakeups were disabled by
> -	 * userspace updating the /sys/devices.../power/wakeup file.
> -	 */
> -
> -	status = call_platform_enable_wakeup(&dev->dev, enable);
> +	if (enable && platform_pci_power_manageable(dev)) {
> +		/* Allow the platform to handle the device */
> +		int err = platform_pci_sleep_wake(dev, true);
> +		if (!err)
> +			/*
> +			 * The platform claims to have enabled the device's
> +			 * system wake-up capability as requested, but we are
> +			 * going to enable PME# anyway.
> +			 */
> +			platform_done = true;
> +	}
>  
>  	/* find PCI PM capability in list */
>  	pm = pci_find_capability(dev, PCI_CAP_ID_PM);
> @@ -1044,23 +1054,27 @@ int pci_enable_wake(struct pci_dev *dev,
>  	 * disable wake events, it's a NOP.  Otherwise fail unless the
>  	 * platform hooks handled this legacy device already.
>  	 */
> -	if (!pm)
> -		return enable ? status : 0;
> +	if (!pm) {
> +		if (enable)
> +			return platform_done ? 0 : -EIO;
> +		else
> +			goto Platform_disable;
> +	}
>  
>  	/* Check device's ability to generate PME# */
> -	pci_read_config_word(dev,pm+PCI_PM_PMC,&value);
> +	pci_read_config_word(dev, pm + PCI_PM_PMC, &value);
>  
>  	value &= PCI_PM_CAP_PME_MASK;
>  	value >>= ffs(PCI_PM_CAP_PME_MASK) - 1;   /* First bit of mask */
>  
>  	/* Check if it can generate PME# from requested state. */
>  	if (!value || !(value & (1 << state))) {
> -		/* if it can't, revert what the platform hook changed,
> -		 * always reporting the base "EINVAL, can't PME#" error
> -		 */
> -		if (enable)
> -			call_platform_enable_wakeup(&dev->dev, 0);
> -		return enable ? -EINVAL : 0;
> +		if (enable) {
> +			return platform_done ? 0 : -EINVAL;
> +		} else {
> +			value = 0;
> +			goto Platform_disable;
> +		}
>  	}
>  
>  	pci_read_config_word(dev, pm + PCI_PM_CTRL, &value);
> @@ -1073,6 +1087,14 @@ int pci_enable_wake(struct pci_dev *dev,
>  
>  	pci_write_config_word(dev, pm + PCI_PM_CTRL, value);
>  
> + Platform_disable:
> +	if (!enable && platform_pci_power_manageable(dev)) {
> +		/* Allow the platform to finalize the operation */
> +		int err = platform_pci_sleep_wake(dev, false);
> +		if (err && !value)
> +			return -EIO;
> +	}
> +
>  	return 0;
>  }
>  
> Index: linux-next/include/linux/pm_wakeup.h
> ===================================================================
> --- linux-next.orig/include/linux/pm_wakeup.h
> +++ linux-next/include/linux/pm_wakeup.h
> @@ -47,21 +47,7 @@ static inline void device_set_wakeup_ena
>  
>  static inline int device_may_wakeup(struct device *dev)
>  {
> -	return dev->power.can_wakeup & dev->power.should_wakeup;
> -}
> -
> -/*
> - * Platform hook to activate device wakeup capability, if that's not already
> - * handled by enable_irq_wake() etc.
> - * Returns zero on success, else negative errno
> - */
> -extern int (*platform_enable_wakeup)(struct device *dev, int is_on);
> -
> -static inline int call_platform_enable_wakeup(struct device *dev, int is_on)
> -{
> -	if (platform_enable_wakeup)
> -		return (*platform_enable_wakeup)(dev, is_on);
> -	return 0;
> +	return dev->power.can_wakeup && dev->power.should_wakeup;
>  }
>  
>  #else /* !CONFIG_PM */
> Index: linux-next/drivers/base/power/sysfs.c
> ===================================================================
> --- linux-next.orig/drivers/base/power/sysfs.c
> +++ linux-next/drivers/base/power/sysfs.c
> @@ -6,9 +6,6 @@
>  #include <linux/string.h>
>  #include "power.h"
>  
> -int (*platform_enable_wakeup)(struct device *dev, int is_on);
> -
> -
>  /*
>   *	wakeup - Report/change current wakeup option for device
>   *
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

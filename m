From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 5/5] ACPI GPE based wakeup event detection
Date: Mon, 8 Sep 2008 22:57:34 +0200
Message-ID: <200809082257.35009.rjw__10737.1683734984$1220907327$gmane$org@sisk.pl>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.658492314@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080908092305.658492314@sli10-desk.sh.intel.com>
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
To: shaohua.li@intel.com
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Monday, 8 of September 2008, shaohua.li@intel.com wrote:
> In ACPI platform, if native PME isn't enabled, GPE is used to report wakeup event.
> ---
>  drivers/acpi/Kconfig        |    9 ++++++
>  drivers/acpi/bus.c          |   15 ++++++++++
>  drivers/acpi/sleep/wakeup.c |   66 ++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h     |    4 ++
>  4 files changed, 94 insertions(+)
> 
> Index: linux/drivers/acpi/Kconfig
> ===================================================================
> --- linux.orig/drivers/acpi/Kconfig	2008-09-08 14:28:50.000000000 +0800
> +++ linux/drivers/acpi/Kconfig	2008-09-08 14:29:08.000000000 +0800
> @@ -45,6 +45,15 @@ config ACPI_SLEEP
>  	depends on PM_SLEEP
>  	default y
>  
> +config ACPI_GPE_WAKEUP
> +	bool "ACPI wakeup event support"
> +	depends on PM_SLEEP && EXPERIMENTAL
> +	help
> +	  Enable ACPI to detect wakeup event. For example, PCI device can
> +	  invoke PME, and in ACPI platform, the PME will invoke a GPE. With
> +	  the option, we can detect which device invokes wakeup event.
> +
> +
>  config ACPI_PROCFS
>  	bool "Deprecated /proc/acpi files"
>  	depends on PROC_FS
> Index: linux/drivers/acpi/bus.c
> ===================================================================
> --- linux.orig/drivers/acpi/bus.c	2008-09-08 14:28:32.000000000 +0800
> +++ linux/drivers/acpi/bus.c	2008-09-08 14:29:03.000000000 +0800
> @@ -496,6 +496,19 @@ static int acpi_bus_check_scope(struct a
>  	return 0;
>  }
>  
> +static BLOCKING_NOTIFIER_HEAD(acpi_bus_notify_list);
> +int register_acpi_bus_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&acpi_bus_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_acpi_bus_notifier);
> +
> +void unregister_acpi_bus_notifier(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&acpi_bus_notify_list, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_acpi_bus_notifier);
> +
>  /**
>   * acpi_bus_notify
>   * ---------------
> @@ -506,6 +519,8 @@ static void acpi_bus_notify(acpi_handle 
>  	int result = 0;
>  	struct acpi_device *device = NULL;
>  
> +	blocking_notifier_call_chain(&acpi_bus_notify_list,
> +			type, (void *)handle);

Hm, perhaps I'm too tired and I'm missing something obvious, but can you
tell me please why that has to be a notifier chain?  It looks like you add only
one notifier to it, so seemingly it could be replaced by a direct call to a
function like acpi_gpe_pme_handler() (with modified list of arguments).

>  	if (acpi_bus_get_device(handle, &device))
>  		return;
> Index: linux/drivers/acpi/sleep/wakeup.c
> ===================================================================
> --- linux.orig/drivers/acpi/sleep/wakeup.c	2008-09-08 14:28:55.000000000 +0800
> +++ linux/drivers/acpi/sleep/wakeup.c	2008-09-08 15:04:23.000000000 +0800
> @@ -142,6 +142,70 @@ void acpi_disable_wakeup_device(u8 sleep
>  	spin_unlock(&acpi_device_lock);
>  }
>  
> +#ifdef CONFIG_ACPI_GPE_WAKEUP
> +static int acpi_gpe_pme_check(struct acpi_device *dev)
> +{
> +	struct device *ldev;
> +
> +	ldev = acpi_get_physical_device(dev->handle);
> +	if (!ldev)
> +		return -ENODEV;
> +	/*
> +	 * AML code might already clear the event, so ignore the return value.
> +	 * Actually we can't correctly detect which device invokes GPE if the
> +	 * event is cleared.
> +	 */
> +	if (ldev->bus->pm && ldev->bus->pm->base.wakeup_event)
> +		ldev->bus->pm->base.wakeup_event(ldev);
> +
> +	/*
> +	 * We always send the event. AML code usually identifies the exact
> +	 * device of the GPE, let's trust it
> +	 */
> +	device_receive_wakeup_event(ldev);
> +
> +	put_device(ldev);
> +	return 0;
> +}
> +
> +static int acpi_gpe_pme_handler(struct notifier_block *nb,
> +	unsigned long type, void *data)
> +{
> +	int ret;
> +	acpi_handle handle = data;
> +	struct acpi_device *dev;
> +
> +	if (type != ACPI_NOTIFY_DEVICE_WAKE)
> +		return NOTIFY_DONE;
> +
> +	if (acpi_bus_get_device(handle, &dev))
> +		return NOTIFY_DONE;
> +
> +	ret = acpi_gpe_pme_check(dev);
> +
> +	acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
> +		ACPI_NOT_ISR);
> +

At which point are dev->wakeup.gpe_device and dev->wakeup.gpe_number
determined, for example, for PCI devices, and how?

> +	/* FIXME: spurious interrupt, disables it? */
> +	if (ret)
> +		printk(KERN_ERR"Spurious GPE %d detected\n",
> +			dev->wakeup.gpe_number);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block acpi_gpe_pme_nb = {
> +	.notifier_call = acpi_gpe_pme_handler,
> +};
> +
> +static void acpi_init_gpe_pme(void)
> +{
> +	register_acpi_bus_notifier(&acpi_gpe_pme_nb);
> +}
> +#else
> +static inline void acpi_init_gpe_pme(void) {}
> +#endif
> +
>  static int __init acpi_wakeup_device_init(void)
>  {
>  	struct list_head *node, *next;
> @@ -167,6 +231,8 @@ static int __init acpi_wakeup_device_ini
>  		spin_lock(&acpi_device_lock);
>  	}
>  	spin_unlock(&acpi_device_lock);
> +
> +	acpi_init_gpe_pme();
>  	return 0;
>  }
>  
> Index: linux/include/acpi/acpi_bus.h
> ===================================================================
> --- linux.orig/include/acpi/acpi_bus.h	2008-09-08 14:28:42.000000000 +0800
> +++ linux/include/acpi/acpi_bus.h	2008-09-08 14:29:03.000000000 +0800
> @@ -327,6 +327,10 @@ int acpi_bus_get_private_data(acpi_handl
>  extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
>  extern int register_acpi_notifier(struct notifier_block *);
>  extern int unregister_acpi_notifier(struct notifier_block *);
> +
> +extern int register_acpi_bus_notifier(struct notifier_block *nb);
> +extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
> +
>  /*
>   * External Functions
>   */

Thanks,
Rafael

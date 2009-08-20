From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 5/5] acpi-based wakeup event detection
Date: Thu, 20 Aug 2009 22:03:22 +0200
Message-ID: <200908202203.22117.rjw__48614.788396708$1250798755$gmane$org@sisk.pl>
References: <1250666661.23178.120.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1250666661.23178.120.camel@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 August 2009, Shaohua Li wrote:
> 
> In ACPI platform, if native PME isn't enabled, GPE is used to report wakeup event.
> ---
>  drivers/acpi/Kconfig        |    9 ++++++
>  drivers/acpi/bus.c          |   15 +++++++++++
>  drivers/acpi/sleep/wakeup.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h     |    4 ++
>  4 files changed, 88 insertions(+)
> 
> Index: linux/drivers/acpi/Kconfig
> ===================================================================
> --- linux.orig/drivers/acpi/Kconfig	2009-08-05 11:00:06.000000000 +0800
> +++ linux/drivers/acpi/Kconfig	2009-08-19 10:07:05.000000000 +0800
> @@ -45,6 +45,15 @@ config ACPI_SLEEP
>  	depends on SUSPEND || HIBERNATION
>  	default y
>  
> +config ACPI_GPE_WAKEUP
> +	bool "ACPI wakeup event support"
> +	depends on PM_SLEEP && EXPERIMENTAL

It shouldn't depend on PM_SLEEP.

> +	help
> +	  Enable ACPI to detect wakeup event. For example, PCI device can
> +	  invoke PME, and in ACPI platform, the PME will invoke a GPE. With
> +	  the option, we can detect which device invokes wakeup event.
> +
> +

I don't think we need yet another CONFIG switch for this purpose.  It would
be better to make it depend on CONFIG_PM_RUNTIME or just on CONFIG_PM.

>  config ACPI_PROCFS
>  	bool "Deprecated /proc/acpi files"
>  	depends on PROC_FS
> Index: linux/drivers/acpi/wakeup.c
> ===================================================================
> --- linux.orig/drivers/acpi/wakeup.c	2009-07-24 11:31:05.000000000 +0800
> +++ linux/drivers/acpi/wakeup.c	2009-08-19 10:16:27.000000000 +0800
> @@ -124,6 +124,63 @@ void acpi_disable_wakeup_device(u8 sleep
>  	}
>  }
>  
> +#ifdef CONFIG_ACPI_GPE_WAKEUP
> +static int acpi_gpe_pme_check(struct acpi_device *dev)

acpi_gpe_wakeup_check() would be a better name IMO.  Everywhere below too.

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

I'm not sure what the comment is for.  Does it mean we should ignore the
result of the callback below?

> +	if (ldev->bus->pm && ldev->bus->pm->wakeup_event)

Is ldev->bus guaranteed not to be NULL?

> +		ldev->bus->pm->wakeup_event(ldev);

You're supposed to call pm_runtime_resume() in such cases (or
pm_request_resume() in case it can't sleep).

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
> +	acpi_disable_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number);

I agree with Matthew on this.

> +	/* FIXME: spurious interrupt, disables it? */

Why FIXME?

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

What exactly is the mechanism for invoking these notifiers?

You don't seem to set up the GPE like the Matthew's code does.  When and
where is the GPE actually set up?

> +#else
> +static inline void acpi_init_gpe_pme(void) {}
> +#endif
> +
>  int __init acpi_wakeup_device_init(void)
>  {
>  	struct list_head *node, *next;
> @@ -144,5 +201,7 @@ int __init acpi_wakeup_device_init(void)
>  		dev->wakeup.state.enabled = 1;
>  	}
>  	mutex_unlock(&acpi_device_lock);
> +
> +	acpi_init_gpe_pme();
>  	return 0;
>  }

Thanks,
Rafael

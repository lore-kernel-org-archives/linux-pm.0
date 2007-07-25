From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.21-rc5-git 2/3] ACPI driver model flags
	and platform_enable_wake()
Date: Wed, 25 Jul 2007 13:04:02 -0700
Message-ID: <200707251304.03191.david-b__23176.0989911438$1185394488$gmane$org@pacbell.net>
References: <200704051249.10407.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704051249.10407.david-b@pacbell.net>
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
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

I'm curious about the status of the appended patch ... without it,
the new acpi_pm_device_sleep_state() routine isn't really able to
do anything intelligent.  The patch still applies to 2.6.23-rc1-git;
my patches-that-still-haven't-merged queue has had this at the very
top for quite a few months now...

As I recall, Mattia Dongili <malattia@linux.it> reported an error
with a Vaio laptop; it would wake immediately after entering STR.
It didn't reproduce for anyone else.  But that was eventually tracked
down to a bug in iwl3945, which has since been fixed (yes?).

I'm thinking the right thing to do is to put this patch into the ACPI
merge queue ... and this time, be more aggressive at tracking down
any driver bugs it shakes loose.

- Dave


On Thursday 05 April 2007, David Brownell wrote:
> This upgrades the ACPI code to start cooperating with the two driver
> model wakeup flags and with pci_enable_wake(), based on the previous
> patch updating that PCI call:
> 
>  - The physical device's "device.power.can_wakeup" flag tracks the ACPI
>    flag "acpi_device.wakeup.flags.valid" ... the latter can't entirely
>    vanish, since it's initialized before the "real device" node exists.
> 
>  - Implements the new platform_enable_wakeup() hook.  This does the same
>    thing as manual writes to /proc/acpi/wakeup:  it sets a flag that is
>    tested later, to remember whether the GPE should be enabled before
>    entering a system sleep state.
> 
>  - The GPEs are not set if the physical device's "should_wakeup" flag
>    has been cleared.  That's purely a policy input, through sysfs, at the
>    level of "that hardware is flakey, ignore its wake events".
> 
> ACPI systems see behavioral changes as follows:
> 
>    * Wakeup-aware PCI drivers no longer need to have someone override the
>      initial system config by writing to /proc/acpi/wakeup; existing calls
>      to pci_enable_wake() suffice.  For wakeup-unaware drivers, it's still
>      not clearly safe to enable wakeup in /proc/acpi/wakeup.
> 
>    * Non-PCI frameworks (as for PS2 serial ports) could call the platform
>      hook like PCI does, supporting wakeup-aware drivers.
> 
>    * The /sys/devices/.../power/wakeup flags are a different kind of manual
>      override.  They _disable_ wakeup for broken hardware or drivers, rather
>      than _enabling_ it in the hope that unmodified drivers won't break when
>      their hardware triggers wakeup events.
> 
> Arguably, it's now time to modify /proc/acpi/wakeup to ignore writes; and
> have it display the relevant GPE not an internal flag.
> 
> Note a key omission:  only motherboard devices are listed in the ACPI
> tables, so add-on devices aren't covered.  The USB framework handles
> those devices; but nothing in this patch handles PCI add-in cards.
> 
> Another open issue is the ACPI framework's current inability to manage
> wakeup events for systems in the S0 state.  That kind of runtime PM is
> allowed by PCI and by common hardware (e.g. ICH6).
> 
> Includes a semi-related bugfix:  the input devices for the ACPI buttons
> weren't set up to link to the "physical" ACPI device node.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/acpi/button.c       |    5 +++++
>  drivers/acpi/glue.c         |    9 ++++++++-
>  drivers/acpi/power.c        |    4 ++++
>  drivers/acpi/sleep/wakeup.c |   40 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 1 deletion(-)
> 
> --- g26.orig/drivers/acpi/glue.c	2007-04-04 13:57:02.000000000 -0700
> +++ g26/drivers/acpi/glue.c	2007-04-04 13:57:03.000000000 -0700
> @@ -146,6 +146,7 @@ EXPORT_SYMBOL(acpi_get_physical_device);
>  
>  static int acpi_bind_one(struct device *dev, acpi_handle handle)
>  {
> +	struct acpi_device *device;
>  	acpi_status status;
>  
>  	if (dev->archdata.acpi_handle) {
> @@ -161,6 +162,11 @@ static int acpi_bind_one(struct device *
>  	}
>  	dev->archdata.acpi_handle = handle;
>  
> +	/* init driver model state */
> +	status = acpi_bus_get_device(handle, &device);
> +	if (!ACPI_FAILURE(status))
> +		device_init_wakeup(dev, device->wakeup.flags.valid);
> +
>  	return 0;
>  }
>  
> @@ -196,7 +202,8 @@ static int acpi_platform_notify(struct d
>  	}
>  	type = acpi_get_bus_type(dev->bus);
>  	if (!type) {
> -		DBG("No ACPI bus support for %s\n", dev->bus_id);
> +		DBG("No ACPI bus support for %s:%s\n",
> +				dev->bus->name, dev->bus_id);
>  		ret = -EINVAL;
>  		goto end;
>  	}
> --- g26.orig/drivers/acpi/button.c	2007-04-04 13:53:56.000000000 -0700
> +++ g26/drivers/acpi/button.c	2007-04-05 11:54:59.000000000 -0700
> @@ -366,6 +366,7 @@ static int acpi_button_add(struct acpi_d
>  		error = -ENOMEM;
>  		goto err_free_button;
>  	}
> +	input->cdev.dev = &device->dev;
>  
>  	/*
>  	 * Determine the button type (via hid), as fixed-feature buttons
> @@ -444,6 +445,10 @@ static int acpi_button_add(struct acpi_d
>  	if (error)
>  		goto err_remove_handlers;
>  
> +	/* for these devices the ACPI node *IS* the "physical" device */
> +	device_init_wakeup(&device->dev, device->wakeup.flags.valid);
> +	/* REVISIT prefer acpi_bind_one(&device->dev, device->handle); */
> +
>  	if (device->wakeup.flags.valid) {
>  		/* Button's GPE is run-wake GPE */
>  		acpi_set_gpe_type(device->wakeup.gpe_device,
> --- g26.orig/drivers/acpi/power.c	2007-04-04 13:53:56.000000000 -0700
> +++ g26/drivers/acpi/power.c	2007-04-04 13:57:03.000000000 -0700
> @@ -322,6 +322,7 @@ int acpi_enable_wakeup_device_power(stru
>  		ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
>  		if (ret) {
>  			printk(KERN_ERR PREFIX "Transition power state\n");
> +			device_init_wakeup(&dev->dev, 0);
>  			dev->wakeup.flags.valid = 0;
>  			return -1;
>  		}
> @@ -331,6 +332,7 @@ int acpi_enable_wakeup_device_power(stru
>  	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
>  	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
>  		printk(KERN_ERR PREFIX "Evaluate _PSW\n");
> +		device_init_wakeup(&dev->dev, 0);
>  		dev->wakeup.flags.valid = 0;
>  		ret = -1;
>  	}
> @@ -360,6 +362,7 @@ int acpi_disable_wakeup_device_power(str
>  	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
>  	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
>  		printk(KERN_ERR PREFIX "Evaluate _PSW\n");
> +		device_init_wakeup(&dev->dev, 0);
>  		dev->wakeup.flags.valid = 0;
>  		return -1;
>  	}
> @@ -369,6 +372,7 @@ int acpi_disable_wakeup_device_power(str
>  		ret = acpi_power_off_device(dev->wakeup.resources.handles[i], dev);
>  		if (ret) {
>  			printk(KERN_ERR PREFIX "Transition power state\n");
> +			device_init_wakeup(&dev->dev, 0);
>  			dev->wakeup.flags.valid = 0;
>  			return -1;
>  		}
> --- g26.orig/drivers/acpi/sleep/wakeup.c	2007-04-04 13:53:56.000000000 -0700
> +++ g26/drivers/acpi/sleep/wakeup.c	2007-04-04 13:57:03.000000000 -0700
> @@ -36,12 +36,22 @@ void acpi_enable_wakeup_device_prep(u8 s
>  		struct acpi_device *dev = container_of(node,
>  						       struct acpi_device,
>  						       wakeup_list);
> +		struct device *ldev;
>  
>  		if (!dev->wakeup.flags.valid ||
>  		    !dev->wakeup.state.enabled ||
>  		    (sleep_state > (u32) dev->wakeup.sleep_state))
>  			continue;
>  
> +		ldev = acpi_get_physical_device(dev->handle);
> +		if (ldev) {
> +			int flag = device_may_wakeup(ldev);
> +
> +			put_device(ldev);
> +			if (!flag)
> +				continue;
> +		}
> +
>  		spin_unlock(&acpi_device_lock);
>  		acpi_enable_wakeup_device_power(dev);
>  		spin_lock(&acpi_device_lock);
> @@ -68,6 +78,7 @@ void acpi_enable_wakeup_device(u8 sleep_
>  		struct acpi_device *dev = container_of(node,
>  						       struct acpi_device,
>  						       wakeup_list);
> +		struct device *ldev;
>  
>  		/* If users want to disable run-wake GPE,
>  		 * we only disable it for wake and leave it for runtime
> @@ -89,6 +100,15 @@ void acpi_enable_wakeup_device(u8 sleep_
>  		    (sleep_state > (u32) dev->wakeup.sleep_state))
>  			continue;
>  
> +		ldev = acpi_get_physical_device(dev->handle);
> +		if (ldev) {
> +			int flag = device_may_wakeup(ldev);
> +
> +			put_device(ldev);
> +			if (!flag)
> +				continue;
> +		}
> +
>  		spin_unlock(&acpi_device_lock);
>  		/* run-wake GPE has been enabled */
>  		if (!dev->wakeup.flags.run_wake)
> @@ -149,6 +169,24 @@ void acpi_disable_wakeup_device(u8 sleep
>  	spin_unlock(&acpi_device_lock);
>  }
>  
> +static int acpi_platform_enable_wakeup(struct device *dev, int is_on)
> +{
> +	struct acpi_device	*adev;
> +	int			status;
> +
> +	if (!device_can_wakeup(dev))
> +		return -EINVAL;
> +	if (is_on && !device_may_wakeup(dev))
> +		return -EINVAL;
> +
> +	status = acpi_bus_get_device(DEVICE_ACPI_HANDLE(dev), &adev);
> +	if (status < 0)
> +		return status;
> +
> +	adev->wakeup.state.enabled = !!is_on;
> +	return 0;
> +}
> +
>  static int __init acpi_wakeup_device_init(void)
>  {
>  	struct list_head *node, *next;
> @@ -156,6 +194,8 @@ static int __init acpi_wakeup_device_ini
>  	if (acpi_disabled)
>  		return 0;
>  
> +	platform_enable_wakeup = acpi_platform_enable_wakeup;
> +
>  	spin_lock(&acpi_device_lock);
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>  		struct acpi_device *dev = container_of(node,
> 

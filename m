From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup()
	policy	inputs
Date: Tue, 22 Apr 2008 21:30:17 +0800
Message-ID: <1208871017.14474.52.camel__10501.09570283$1208842838$gmane$org@yakui_zhao.sh.intel.com>
References: <200803201408.33466.david-b@pacbell.net>
	<200803201422.55014.david-b@pacbell.net>
	<200804182118.05228.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804182118.05228.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-04-18 at 21:18 -0700, David Brownell wrote:
> This imports the driver model device.power.may_wakeup flags to ACPI,
> using it to *REPLACE* the /proc/acpi/wakeup flags for some devices.
> It depends on the previous patch making device.power.can_wakeup behave.
> It does that by:
> 
>  - Implementing platform_enable_wakeup(), which is currently invoked only
>    by pci_enable_wake().  When that's called -- probably in the driver
>    suspend() call -- it updates acpi_device.wakeup.state.enabled flag in
>    the same way writing to /proc/acpi/wakeup updates it.
>    
>  - Updating the usage of the corresponding ACPI flags when turning on
>    wakeup power domains and GPEs.
> 
> THIS PATCH NEEDS MORE ATTENTION because of the way the ACPI method
> invocations have been changing, e.g. the 1.0 vs 2.0 sequencing.
> 
> Right now it's not clear to me whether the GPEs are always enabled at
> the right time, and for that matter whether the rules haven't changed
> so that drivers can no longer effectively control those settings from
> suspend() unless acpi_new_pts_ordering is in effect.
Agree with what Rui said. The patch doesn't change the time when GPEs
are enabled/disabled.

But after the patch is applied, some PCI device(the ACPI device with the
_PRW object) can wake the sleeping system by default. And it is totally
opposite to the current flowchart. 

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
> NOT YET SIGNED-OFF ... primarily because of the confusion about
> the order in which ACPI methods get called during entry to suspend
> states.  Presumably one of the "new style" PM methods calls will
> now always work for drivers wanting to enable wakeup methods...
> 
> ---
>  drivers/acpi/sleep/main.c   |    2 +-
>  drivers/acpi/sleep/wakeup.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> --- g26.orig/drivers/acpi/sleep/main.c	2008-02-24 02:07:57.000000000 -0800
> +++ g26/drivers/acpi/sleep/main.c	2008-02-24 02:08:04.000000000 -0800
> @@ -470,7 +470,7 @@ int acpi_pm_device_sleep_state(struct de
>  	 * can wake the system.  _S0W may be valid, too.
>  	 */
>  	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> -	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
> +	    (device_may_wakeup(dev) &&
>  	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
>  		acpi_status status;
>  
> --- g26.orig/drivers/acpi/sleep/wakeup.c	2008-02-24 02:03:27.000000000 -0800
> +++ g26/drivers/acpi/sleep/wakeup.c	2008-02-24 02:08:04.000000000 -0800
> @@ -35,12 +35,22 @@ void acpi_enable_wakeup_device_prep(u8 s
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
> @@ -57,8 +67,8 @@ void acpi_enable_wakeup_device(u8 sleep_
>  {
>  	struct list_head *node, *next;
>  
> -	/* 
> -	 * Caution: this routine must be invoked when interrupt is disabled 
> +	/*
> +	 * Caution: this routine must be invoked when interrupt is disabled
>  	 * Refer ACPI2.0: P212
>  	 */
>  	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
> @@ -107,6 +117,7 @@ void acpi_disable_wakeup_device(u8 sleep
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>  		struct acpi_device *dev =
>  			container_of(node, struct acpi_device, wakeup_list);
> +		struct device *ldev;
>  
>  		if (!dev->wakeup.flags.valid)
>  			continue;
> @@ -125,6 +136,15 @@ void acpi_disable_wakeup_device(u8 sleep
>  			continue;
>  		}
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
>  		acpi_disable_wakeup_device_power(dev);
>  		/* Never disable run-wake GPE */
> @@ -139,6 +159,24 @@ void acpi_disable_wakeup_device(u8 sleep
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
> @@ -146,6 +184,8 @@ static int __init acpi_wakeup_device_ini
>  	if (acpi_disabled)
>  		return 0;
>  
> +	platform_enable_wakeup = acpi_platform_enable_wakeup;
> +
>  	spin_lock(&acpi_device_lock);
>  	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
>  		struct acpi_device *dev = container_of(node,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

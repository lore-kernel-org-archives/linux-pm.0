From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RE-RESEND patch 2.6.25-git]
	acpi_pm_device_sleep_state() cleanup
Date: Tue, 29 Apr 2008 23:49:01 +0200
Message-ID: <200804292349.02906.rjw__30787.6533632681$1209505915$gmane$org@sisk.pl>
References: <200803201408.33466.david-b@pacbell.net>
	<200803201410.57801.david-b@pacbell.net>
	<200804291333.50054.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804291333.50054.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 29 of April 2008, David Brownell wrote:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Get rid of a superfluous acpi_pm_device_sleep_state() parameter.  The
> only legitimate value of that parameter must be derived from the first
> parameter, which is what all the callers already do.  (However, this
> does not address the fact that ACPI *still* doesn't set up those flags.)

I picked up the previous version of this patch and I'm going to push it for
2.6.27.  Is this version different from the previous one?

Rafael


> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
> It seems patches sent to the ACPI list are often ignored.  This patch
> was sent against 2.6.25-rc6 for 2.6.26-rc0 merge, then resent 18-apr
> against 2.6.25 ... maybe the third time can finally do the trick.
> 
>  drivers/acpi/sleep/main.c  |    8 ++++----
>  drivers/pci/pci-acpi.c     |    3 +--
>  drivers/pnp/pnpacpi/core.c |    4 +---
>  include/acpi/acpi_bus.h    |    4 ++--
>  4 files changed, 8 insertions(+), 11 deletions(-)
> 
> --- g26.orig/drivers/acpi/sleep/main.c	2008-04-18 19:26:19.000000000 -0700
> +++ g26/drivers/acpi/sleep/main.c	2008-04-18 20:08:23.000000000 -0700
> @@ -369,8 +369,8 @@ int acpi_suspend(u32 acpi_state)
>  /**
>   *	acpi_pm_device_sleep_state - return preferred power state of ACPI device
>   *		in the system sleep state given by %acpi_target_sleep_state
> - *	@dev: device to examine
> - *	@wake: if set, the device should be able to wake up the system
> + *	@dev: device to examine; its driver model wakeup flags control
> + *		whether it should be able to wake up the system
>   *	@d_min_p: used to store the upper limit of allowed states range
>   *	Return value: preferred power state of the device on success, -ENODEV on
>   *		failure (ie. if there's no 'struct acpi_device' for @dev)
> @@ -388,7 +388,7 @@ int acpi_suspend(u32 acpi_state)
>   *	via @wake.
>   */
>  
> -int acpi_pm_device_sleep_state(struct device *dev, int wake, int *d_min_p)
> +int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
>  {
>  	acpi_handle handle = DEVICE_ACPI_HANDLE(dev);
>  	struct acpi_device *adev;
> @@ -427,7 +427,7 @@ int acpi_pm_device_sleep_state(struct de
>  	 * can wake the system.  _S0W may be valid, too.
>  	 */
>  	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> -	    (wake && adev->wakeup.state.enabled &&
> +	    (device_may_wakeup(dev) && adev->wakeup.state.enabled &&
>  	     adev->wakeup.sleep_state <= acpi_target_sleep_state)) {
>  		acpi_status status;
>  
> --- g26.orig/drivers/pci/pci-acpi.c	2008-04-18 19:26:19.000000000 -0700
> +++ g26/drivers/pci/pci-acpi.c	2008-04-18 20:08:23.000000000 -0700
> @@ -249,8 +249,7 @@ static pci_power_t acpi_pci_choose_state
>  {
>  	int acpi_state;
>  
> -	acpi_state = acpi_pm_device_sleep_state(&pdev->dev,
> -		device_may_wakeup(&pdev->dev), NULL);
> +	acpi_state = acpi_pm_device_sleep_state(&pdev->dev, NULL);
>  	if (acpi_state < 0)
>  		return PCI_POWER_ERROR;
>  
> --- g26.orig/drivers/pnp/pnpacpi/core.c	2008-04-18 19:26:19.000000000 -0700
> +++ g26/drivers/pnp/pnpacpi/core.c	2008-04-18 20:08:23.000000000 -0700
> @@ -132,9 +132,7 @@ static int pnpacpi_suspend(struct pnp_de
>  {
>  	int power_state;
>  
> -	power_state = acpi_pm_device_sleep_state(&dev->dev,
> -						device_may_wakeup(&dev->dev),
> -						NULL);
> +	power_state = acpi_pm_device_sleep_state(&dev->dev, NULL);
>  	if (power_state < 0)
>  		power_state = (state.event == PM_EVENT_ON) ?
>  				ACPI_STATE_D0 : ACPI_STATE_D3;
> --- g26.orig/include/acpi/acpi_bus.h	2008-04-18 19:26:19.000000000 -0700
> +++ g26/include/acpi/acpi_bus.h	2008-04-18 20:08:23.000000000 -0700
> @@ -376,9 +376,9 @@ acpi_handle acpi_get_pci_rootbridge_hand
>  #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
>  
>  #ifdef CONFIG_PM_SLEEP
> -int acpi_pm_device_sleep_state(struct device *, int, int *);
> +int acpi_pm_device_sleep_state(struct device *, int *);
>  #else /* !CONFIG_PM_SLEEP */
> -static inline int acpi_pm_device_sleep_state(struct device *d, int w, int *p)
> +static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
>  {
>  	if (p)
>  		*p = ACPI_STATE_D0;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 



-- 
"Premature optimization is the root of all evil." - Donald Knuth

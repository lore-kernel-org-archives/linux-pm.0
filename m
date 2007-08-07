From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Tue, 7 Aug 2007 13:50:54 +0100
Message-ID: <20070807125054.GC2833@flint.arm.linux.org.uk>
References: <200708061111.03407.david-b@pacbell.net>
	<200708061338.08561.david-b@pacbell.net>
	<20070806214805.GE3360@flint.arm.linux.org.uk>
	<200708061646.41835.david-b@pacbell.net>
	<20070806222351.090dc035.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070806222351.090dc035.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

I do not think that the clk_must_disable() API is well enough thought out
for the following reasons:

1. the name sucks - it tells you nothing about it's purpose, which as
   the name currently stands can be interpreted in as many ways as there
   are species of animals on this planet.

   While the comments around the prototype help interpret its semantics,
   it is no subsitute for having a good name for the function.

2. it's unclear how this function obtains information about the "upcoming
   system state" and therefore decides whether the particular clock may
   be available.

3. due to the negative semantics, code such as the following is difficult
   to interpret and work out whether it's correct due to the double
   negative:

  +     if (device_may_wakeup(&pdev->dev)
  +                     && !clk_must_disable(atmel_port->clk))
                enable_irq_wake(port->irq);

4. the description of the function implies that this function may be
   called when we are not suspending:

  + * On platforms that support reduced functionality operating states, the
  + * constraint may also need to be tested during resume() and probe() calls.

   With SoCs with multiple power states affecting which clocks are
   available, and the need in point (2) for the architecture code to
   record which PM mode we're entering via the pm_ops set_target method,
   calling clk_must_disable() outside of the suspend methods results in
   this function essentially returning undefined values at driver probe
   time.  Note: there is no locking between driver probing and the
   set_target method.

   Moreover, if used in a driver probe() path, the return value could
   well depend on the _last_ system suspend state entered, and would be
   undefined for a system which hasn't been suspended from boot.

Changing the function name to "clk_available_in_suspend()" addresses at
least two of these points.  The other two points are addressed by
providing a way for the method to be passed the desired system suspend
state, which may be resolved by expanding pm_message_t to contain that
information.

Finally, concerning merging this during the -rc phase, I'd much rather
see the one liner simple build fix of adding the missing function
prototype going into the -rc kernels, and then a similar patch to this
going in during the next merge window.

On Mon, Aug 06, 2007 at 10:23:51PM -0700, Andrew Morton wrote:
> diff -puN arch/arm/mach-at91/clock.c~at91-implements-clk_must_disable arch/arm/mach-at91/clock.c
> --- a/arch/arm/mach-at91/clock.c~at91-implements-clk_must_disable
> +++ a/arch/arm/mach-at91/clock.c
> @@ -32,6 +32,7 @@
>  #include <asm/arch/cpu.h>
>  
>  #include "clock.h"
> +#include "generic.h"
>  
>  
>  /*
> @@ -254,6 +255,23 @@ EXPORT_SYMBOL(clk_get_rate);
>  
>  /*------------------------------------------------------------------------*/
>  
> +#ifdef CONFIG_PM
> +
> +int clk_must_disable(struct clk *clk)
> +{
> +	if (!at91_suspend_entering_slow_clock())
> +		return 0;
> +
> +	while (clk->parent)
> +		clk = clk->parent;
> +	return clk != &clk32k;
> +}
> +EXPORT_SYMBOL(clk_must_disable);
> +
> +#endif
> +
> +/*------------------------------------------------------------------------*/
> +
>  #ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
>  
>  /*
> diff -puN arch/arm/mach-at91/generic.h~at91-implements-clk_must_disable arch/arm/mach-at91/generic.h
> --- a/arch/arm/mach-at91/generic.h~at91-implements-clk_must_disable
> +++ a/arch/arm/mach-at91/generic.h
> @@ -36,6 +36,7 @@ extern void __init at91_clock_associate(
>   /* Power Management */
>  extern void at91_irq_suspend(void);
>  extern void at91_irq_resume(void);
> +extern int at91_suspend_entering_slow_clock(void);
>  
>   /* GPIO */
>  #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
> diff -puN arch/arm/mach-at91/pm.c~at91-implements-clk_must_disable arch/arm/mach-at91/pm.c
> --- a/arch/arm/mach-at91/pm.c~at91-implements-clk_must_disable
> +++ a/arch/arm/mach-at91/pm.c
> @@ -103,20 +103,15 @@ static int at91_pm_verify_clocks(void)
>  }
>  
>  /*
> - * Call this from platform driver suspend() to see how deeply to suspend.
> + * This is called from clk_must_disable(), to see how deeply to suspend.
>   * For example, some controllers (like OHCI) need one of the PLL clocks
>   * in order to act as a wakeup source, and those are not available when
>   * going into slow clock mode.
> - *
> - * REVISIT: generalize as clk_will_be_available(clk)?  Other platforms have
> - * the very same problem (but not using at91 main_clk), and it'd be better
> - * to add one generic API rather than lots of platform-specific ones.
>   */
>  int at91_suspend_entering_slow_clock(void)
>  {
>  	return (target_state == PM_SUSPEND_MEM);
>  }
> -EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
>  
>  
>  static void (*slow_clock)(void);
> diff -puN drivers/serial/atmel_serial.c~at91-implements-clk_must_disable drivers/serial/atmel_serial.c
> --- a/drivers/serial/atmel_serial.c~at91-implements-clk_must_disable
> +++ a/drivers/serial/atmel_serial.c
> @@ -921,7 +921,8 @@ static int atmel_serial_suspend(struct p
>  	struct uart_port *port = platform_get_drvdata(pdev);
>  	struct atmel_uart_port *atmel_port = (struct atmel_uart_port *) port;
>  
> -	if (device_may_wakeup(&pdev->dev) && !at91_suspend_entering_slow_clock())
> +	if (device_may_wakeup(&pdev->dev)
> +			&& !clk_must_disable(atmel_port->clk))
>  		enable_irq_wake(port->irq);
>  	else {
>  		uart_suspend_port(&atmel_uart, port);
> diff -puN drivers/usb/gadget/at91_udc.c~at91-implements-clk_must_disable drivers/usb/gadget/at91_udc.c
> --- a/drivers/usb/gadget/at91_udc.c~at91-implements-clk_must_disable
> +++ a/drivers/usb/gadget/at91_udc.c
> @@ -1782,7 +1782,7 @@ static int at91udc_suspend(struct platfo
>  	 */
>  	if ((!udc->suspended && udc->addr)
>  			|| !wake
> -			|| at91_suspend_entering_slow_clock()) {
> +			|| clk_must_disable(udc->fclk)) {
>  		pullup(udc, 0);
>  		wake = 0;
>  	} else
> diff -puN drivers/usb/host/ohci-at91.c~at91-implements-clk_must_disable drivers/usb/host/ohci-at91.c
> --- a/drivers/usb/host/ohci-at91.c~at91-implements-clk_must_disable
> +++ a/drivers/usb/host/ohci-at91.c
> @@ -299,7 +299,7 @@ ohci_hcd_at91_drv_suspend(struct platfor
>  	 *
>  	 * REVISIT: some boards will be able to turn VBUS off...
>  	 */
> -	if (at91_suspend_entering_slow_clock()) {
> +	if (clk_must_disable(fclk)) {
>  		ohci_usb_reset (ohci);
>  		at91_stop_clock();
>  	}
> _
> 

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:

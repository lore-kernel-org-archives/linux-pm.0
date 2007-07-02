From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC][PATCH -mm 2/9] ACPI: Add
	acpi_pm_device_sleep_state helper routine
Date: Sun, 1 Jul 2007 22:49:13 -0700
Message-ID: <200707012249.14143.david-b__14924.7626112357$1183356705$gmane$org@pacbell.net>
References: <200706302257.17556.rjw@sisk.pl> <200706302259.48700.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706302259.48700.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Shaohua Li <shaohua.li@intel.com>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Saturday 30 June 2007, Rafael J. Wysocki wrote:
> From: Shaohua Li <shaohua.li@intel.com>, Rafael J. Wysocki <rjw@sisk.pl>
> 
> Based on the David Brownell's patch at
> http://marc.info/?l=linux-acpi&m=117873972806360&w=2

I hope someone's going to refresh the PCI glue calling this, then...
making pci_choose_state() work was the goal of that patch!!

Also the updates to teach how the PCI root bridge wakeup capabilities
fit into the equation, for non-mainboard devices (all kinds of add-on
cards that talk PCI) ... that stuff was unclear to me, which is most
of why I left it out of that patch.

Correct me if I'm wrong here, but nothing else in this patch set
depends on this particular patch ... yes?


> Add a helper routine returning the lowest power (highest number) ACPI device
> power state that given device can be in while the system is in the sleep state
> indicated by acpi_target_sleep_state .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/sleep/main.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h   |    2 +
>  2 files changed, 53 insertions(+)
> 
> Index: linux-2.6.22-rc6-mm1/drivers/acpi/sleep/main.c
> ===================================================================
> --- linux-2.6.22-rc6-mm1.orig/drivers/acpi/sleep/main.c	2007-06-30 12:18:47.000000000 +0200
> +++ linux-2.6.22-rc6-mm1/drivers/acpi/sleep/main.c	2007-06-30 12:18:58.000000000 +0200
> @@ -255,6 +255,57 @@ static struct hibernation_ops acpi_hiber
>  };
>  #endif				/* CONFIG_SOFTWARE_SUSPEND */
>  
> +/**
> + *	acpi_pm_device_sleep_state - return the lowest power (highest number)
> + *				     ACPI device power state given device can be
> + *				     in while the system is in the sleep state
> + *				     indicated by %acpi_target_sleep_state
> + *	@handle: Represents the device the state is evaluated for
> + */
> +
> +int acpi_pm_device_sleep_state(acpi_handle handle)

Yeah, moving this from the PCI glue to the ACPI core is probably
better.  But I'd like to see the comment use standard kerneldoc ...
that is, the descriptive paragraph follows a set of (one line)
summaries of the function and its parameter(s).  The description
needs to cover the fault returns too.

Also, recall that this was originally PCI-specific.  A generalized
approach would return a range of states, not a single state that
embeds a particular policy that may not be universally appropriate...


> +{
> +	char acpi_method[] = "_SxD";
> +	unsigned long d_min, d_max;
> +	struct acpi_device *dev;
> +
> +	if (!handle || ACPI_FAILURE(acpi_bus_get_device(handle, &dev))) {
> +		printk(KERN_ERR "ACPI handle has no context!\n");

The description above should cover this fault return ... the caller
would normally need some default to apply in such cases, too.

(Example:  PCI could just look at the PCI PM resource and see what
states are supported there.  Choosing PCI_D2, where it's available,
could eliminate various driver re-initialization problems.  That
might make some video code work better, from what I'm told ...)


> +		return -ENODEV;
> +	}
> +	acpi_method[2] = '0' + acpi_target_sleep_state;
> +	/*
> +	 * If the sleep state is S0, we will return D3, but if the device has
> +	 * _S0W, we will use the value from _S0W

There was also the assumption that if it can wake, it can do
so from D3 *or* there will be an _SxD method... remembering
that lots of systems don't have ACPI 3.0 _SxW methods.

But returning D3 is not necessarily best, here...


> +	 */
> +	d_min = ACPI_STATE_D3;
> +	d_max = ACPI_STATE_D3;

Other than the lack of empty lines separating code paragraphs ...
I recall choosing "d_min = ACPI_STATE_D3" with specific reference
to PCI.  It's not clear to me that's appropriate for non-PCI
devices.

The logic was that PCI devices can all support PCI_D0 and PCI_D3.
For non-PCI devices we can't actually know that.  So "min" should
probably default to ACPI_STATE_D0.  If this returns a range, then
such issues can stay out of this code.


> +	/*
> +	 * If present, _SxD methods give the minimum D-state we may use
> +	 * for each S-state ... with lowest latency state switching.
> +	 *
> +	 * We rely on acpi_evaluate_integer() not clobbering the integer
> +	 * provided -- that's our fault recovery, we ignore retval.
> +	 */
> +	if (acpi_target_sleep_state > ACPI_STATE_S0)
> +		acpi_evaluate_integer(handle, acpi_method, NULL, &d_min);

... "lowest latency" implies avoiding ACPI D3.  Thing is, in my
testing with PCI, most devices didn't have _SxD methods, so the
only way to return anything other than PCI_D0 (i.e. some state
that saved power) was to force a different default.  D3 was the
only option that always worked.


> +
> +	/*
> +	 * If _PRW says we can wake from the upcoming system state, the _SxD
> +	 * value can wake ... and we'll assume a wakeup-aware driver.  If _SxW
> +	 * methods exist (ACPI 3.x), they give the lowest power D-state that
> +	 * can also wake the system.  _S0W can be valid.
> +	 */
> +	if (acpi_target_sleep_state == ACPI_STATE_S0 ||
> +	    (dev->wakeup.state.enabled &&

This used device_may_wakeup() before.  That ACPI flag is not a
direct analogue ... without looking again at the issues, I'd
say the right solution is to phase out the ACPI-only flags in
new code.  Maybe just expect the caller to pass the results
of device_may_wakeup() in ... or update the signature to accept
a "struct device", and fetch the handle from there.  (That'd
be a better match for most callers, I'd think...)


> +	     dev->wakeup.sleep_state <= acpi_target_sleep_state)) {
> +		d_max = d_min;

None of my systems happend to have _SxW methods to execute.
So with few _SxD methods, most of the time d_max never changed.
All the more reason to return both min and max...


> +		acpi_method[3] = 'W';
> +		acpi_evaluate_integer(handle, acpi_method, NULL, &d_max);
> +	}
> +	return d_max;

... so there's a range of from d_min to d_max that would be OK
with ACPI, but this particular routine is only showing one end
of the range.  For a general purpose routine, that doesn't seem
like it's obviously the best answer.

- Dave



> +}
> +
>  /*
>   * Toshiba fails to preserve interrupts over S1, reinitialization
>   * of 8259 is needed after S1 resume.
> Index: linux-2.6.22-rc6-mm1/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-2.6.22-rc6-mm1.orig/include/acpi/acpi_bus.h	2007-06-28 21:56:24.000000000 +0200
> +++ linux-2.6.22-rc6-mm1/include/acpi/acpi_bus.h	2007-06-30 12:18:58.000000000 +0200
> @@ -364,6 +364,8 @@ acpi_handle acpi_get_child(acpi_handle, 
>  acpi_handle acpi_get_pci_rootbridge_handle(unsigned int, unsigned int);
>  #define DEVICE_ACPI_HANDLE(dev) ((acpi_handle)((dev)->archdata.acpi_handle))
>  
> +int acpi_pm_device_sleep_state(acpi_handle handle);
> +
>  #endif				/* CONFIG_ACPI */
>  
>  #endif /*__ACPI_BUS_H__*/
> 

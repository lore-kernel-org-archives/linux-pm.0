From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Fri, 23 Jun 2017 06:30:35 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CED4669@SHSMSX101.ccr.corp.intel.com>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
 <3689795.xuIczRHZsl@aspire.rjw.lan> <2026371.DVJN39QYJi@aspire.rjw.lan>
 <2368998.dmCsnrcXZy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2368998.dmCsnrcXZy@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?iso-8859-1?Q?J=E9r=3Fme_de_Bretagne?= <jerome.debretagne@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi, Rafael

> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Subject: [PATCH] ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some recent Dell laptops, including the XPS13 model numbers 9360 and
> 9365, cannot be woken up from suspend-to-idle by pressing the power
> button which is unexpected and makes that feature less usable on
> those systems.  Moreover, on the 9365 ACPI S3 (suspend-to-RAM) is
> not expected to be used at all (the OS these systems ship with never
> exercises the ACPI S3 path in the firmware) and suspend-to-idle is
> the only viable system suspend mechanism there.
> 
> The reason why the power button wakeup from suspend-to-idle doesn't
> work on those systems is because their power button events are
> signaled by the EC (Embedded Controller), whose GPE (General Purpose
> Event) line is disabled during suspend-to-idle transitions in Linux.
> That is done on purpose, because in general the EC tends to be noisy
> for various reasons (battery and thermal updates and similar, for
> example) and all events signaled by it would kick the CPUs out of
> deep idle states while in suspend-to-idle, which effectively might
> defeat its purpose.
> 
> Of course, on the Dell systems in question the EC GPE must be enabled
> during suspend-to-idle transitions for the button press events to
> be signaled while suspended at all, but fortunately there is a way
> out of this puzzle.
> 
> First of all, those systems have the ACPI_FADT_LOW_POWER_S0 flag set
> in their ACPI tables, which means that the OS is expected to prefer
> the "low power S0 idle" system state over ACPI S3 on them.  That
> causes the most recent versions of other OSes to simply ignore ACPI
> S3 on those systems, so it is reasonable to expect that it should not
> be necessary to block GPEs during suspend-to-idle on them.
> 
> Second, in addition to that, the systems in question provide a special
> firmware interface that can be used to indicate to the platform that
> the OS is transitioning into a system-wide low-power state in which
> certain types of activity are not desirable or that it is leaving
> such a state and that (in principle) should allow the platform to
> adjust its operation mode accordingly.
> 
> That interface is a special _DSM object under a System Power
> Management Controller device (PNP0D80).  The expected way to use it
> is to invoke function 0 from it on system initialization, functions
> 3 and 5 during suspend transitions and functions 4 and 6 during
> resume transitions (to reverse the actions carried out by the
> former).  In particular, function 5 from the "Low-Power S0" device
> _DSM is expected to cause the platform to put itself into a low-power
> operation mode which should include making the EC less verbose (so to
> speak).  Next, on resume, function 6 switches the platform back to
> the "working-state" operation mode.
> 
> In accordance with the above, modify the ACPI suspend-to-idle code
> to look for the "Low-Power S0" _DSM interface on platforms with the
> ACPI_FADT_LOW_POWER_S0 flag set in the ACPI tables.  If it's there,
> use it during suspend-to-idle transitions as prescribed and avoid
> changing the GPE configuration in that case.  [That should reflect
> what the most recent versions of other OSes do.]
> 
> Also modify the ACPI EC driver to make it handle events during
> suspend-to-idle in the usual way if the "Low-Power S0" _DSM interface
> is going to be used to make the power button events work while
> suspended on the Dell machines mentioned above
> 
> Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a replacement for https://patchwork.kernel.org/patch/9797909/
> 
> The changelog describes what is going on (and now the "Low-Power S0" _DSM
> specification is public, so it can be used officially here) and it gets the job
> done on the XPS13 9360.  [The additional sort of "bonus" is that the machine
> looks "suspended" in s2idle now, as one of the effects of the _DSM appears
> to be turning off the lights in a quite literal sense.]
> 
> The patch is based on https://patchwork.kernel.org/patch/9797913/ and
> https://patchwork.kernel.org/patch/9797903/ on top of the current linux-next.
> 
> Thanks,
> Rafael
> 
> ---
>  drivers/acpi/ec.c       |    2
>  drivers/acpi/internal.h |    2
>  drivers/acpi/sleep.c    |  107 ++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 107 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/acpi/sleep.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -652,6 +652,84 @@ static const struct platform_suspend_ops
> 
>  static bool s2idle_wakeup;
> 
> +/*
> + * On platforms supporting the Low Power S0 Idle interface there is an ACPI
> + * device object with the PNP0D80 compatible device ID (System Power Management
> + * Controller) and a specific _DSM method under it.  That method, if present,
> + * can be used to indicate to the platform that the OS is transitioning into a
> + * low-power state in which certain types of activity are not desirable or that
> + * it is leaving such a state, which allows the platform to adjust its operation
> + * mode accordingly.
> + */
> +static const struct acpi_device_id lps0_device_ids[] = {
> +	{"PNP0D80", },
> +	{"", },
> +};
> +
> +#define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
> +
> +#define ACPI_LPS0_SCREEN_OFF	3
> +#define ACPI_LPS0_SCREEN_ON	4
> +#define ACPI_LPS0_ENTRY		5
> +#define ACPI_LPS0_EXIT		6
> +
> +#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXIT))
> +
> +static acpi_handle lps0_device_handle;
> +static guid_t lps0_dsm_guid;
> +static char lps0_dsm_func_mask;
> +
> +static void acpi_sleep_run_lps0_dsm(unsigned int func)
> +{
> +	union acpi_object *out_obj;
> +
> +	if (!(lps0_dsm_func_mask & (1 << func)))
> +		return;
> +
> +	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
> +	ACPI_FREE(out_obj);
> +
> +	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
> +			  func, out_obj ? "successful" : "failed");
> +}
> +
> +static int lps0_device_attach(struct acpi_device *adev,
> +			      const struct acpi_device_id *not_used)
> +{
> +	union acpi_object *out_obj;
> +
> +	if (lps0_device_handle)
> +		return 0;
> +
> +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +		return 0;
> +
> +	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
> +	/* Check if the _DSM is present and as expected. */
> +	out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
> +	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> +		char bitmask = *(char *)out_obj->buffer.pointer;
> +
> +		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) == ACPI_S2IDLE_FUNC_MASK) {
> +			lps0_dsm_func_mask = bitmask;
> +			lps0_device_handle = adev->handle;
> +		}
> +
> +		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
> +				  bitmask);
> +	} else {
> +		acpi_handle_debug(adev->handle,
> +				  "_DSM function 0 evaluation failed\n");
> +	}
> +	ACPI_FREE(out_obj);
> +	return 0;
> +}
> +
> +static struct acpi_scan_handler lps0_handler = {
> +	.ids = lps0_device_ids,
> +	.attach = lps0_device_attach,
> +};
> +
>  static int acpi_freeze_begin(void)
>  {
>  	acpi_scan_lock_acquire();
> @@ -660,8 +738,18 @@ static int acpi_freeze_begin(void)
> 
>  static int acpi_freeze_prepare(void)
>  {
> -	acpi_enable_all_wakeup_gpes();
> -	acpi_os_wait_events_complete();
> +	if (lps0_device_handle) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
> +	} else {
> +		/*
> +		 * The configuration of GPEs is changed here to avoid spurious
> +		 * wakeups, but that should not be necessary if this is a
> +		 * "low-power S0" platform and the low-power S0 _DSM is present.
> +		 */
> +		acpi_enable_all_wakeup_gpes();
> +		acpi_os_wait_events_complete();
> +	}
>  	if (acpi_sci_irq_valid())
>  		enable_irq_wake(acpi_sci_irq);
> 
> @@ -700,7 +788,12 @@ static void acpi_freeze_restore(void)
>  	if (acpi_sci_irq_valid())
>  		disable_irq_wake(acpi_sci_irq);
> 
> -	acpi_enable_all_runtime_gpes();
> +	if (lps0_device_handle) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
> +	} else {
> +		acpi_enable_all_runtime_gpes();
> +	}
>  }
> 
>  static void acpi_freeze_end(void)
> @@ -727,11 +820,14 @@ static void acpi_sleep_suspend_setup(voi
> 
>  	suspend_set_ops(old_suspend_ordering ?
>  		&acpi_suspend_ops_old : &acpi_suspend_ops);
> +
> +	acpi_scan_add_handler(&lps0_handler);
>  	freeze_set_ops(&acpi_freeze_ops);
>  }
> 
>  #else /* !CONFIG_SUSPEND */
>  #define s2idle_wakeup	(false)
> +#define lps0_device_handle	(NULL)
>  static inline void acpi_sleep_suspend_setup(void) {}
>  #endif /* !CONFIG_SUSPEND */
> 
> @@ -740,6 +836,11 @@ bool acpi_s2idle_wakeup(void)
>  	return s2idle_wakeup;
>  }
> 
> +bool acpi_sleep_no_ec_events(void)
> +{
> +	return pm_suspend_via_firmware() || !lps0_device_handle;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  static u32 saved_bm_rld;
> 
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1835,7 +1835,7 @@ static int acpi_ec_suspend(struct device
>  	struct acpi_ec *ec =
>  		acpi_driver_data(to_acpi_device(dev));
> 
> -	if (ec_freeze_events)
> +	if (acpi_sleep_no_ec_events() && ec_freeze_events)
>  		acpi_ec_disable_event(ec);
>  	return 0;
>  }

I just notice a slight pontential issue.
Should we add a similar change to acpi_ec_stop()?
acpi_ec_stop() will be invoked by acpi_block_transactions(). When
ec_freeze_events=Y, acpi_ec_suspend() takes care of disabling
event before noirq stage - I introduced this recently in order to
avoid implementing event polling mode in noirq stage while still
can fix event loss issue.
When ec_freeze_events=N, acpi_block_transactions() takes care of
disabling event after noirq stage - old EC driver logic, risking
event loss issues on some platforms.

Thanks and best regards
Lv

> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -199,9 +199,11 @@ void acpi_ec_remove_query_handler(struct
>    -------------------------------------------------------------------------- */
>  #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
>  extern bool acpi_s2idle_wakeup(void);
> +extern bool acpi_sleep_no_ec_events(void);
>  extern int acpi_sleep_init(void);
>  #else
>  static inline bool acpi_s2idle_wakeup(void) { return false; }
> +static inline bool acpi_sleep_no_ec_events(void) { return true; }
>  static inline int acpi_sleep_init(void) { return -ENXIO; }
>  #endif
> 


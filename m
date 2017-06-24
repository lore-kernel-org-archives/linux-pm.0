From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] ACPI / sleep: EC-based wakeup from suspend-to-idle on recent systems
Date: Sat, 24 Jun 2017 02:43:51 +0200
Message-ID: <2212934.gQev59vXe3@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan> <2279758.LZ0rCGQtcH@aspire.rjw.lan> <3f1cbd8cd7e54576b17c788f4eae2205@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3f1cbd8cd7e54576b17c788f4eae2205@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, mika.westerberg@linux.intel.com, tom@oneshoeco.com, jerome.debretagne@gmail.com, torvalds@linux-foundation.org, lv.zheng@intel.com
List-Id: linux-pm@vger.kernel.org

On Friday, June 23, 2017 03:37:36 PM Mario.Limonciello@dell.com wrote:
> > -----Original Message-----

[cut]

> > Index: linux-pm/drivers/acpi/sleep.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/sleep.c
> > +++ linux-pm/drivers/acpi/sleep.c
> > @@ -650,18 +650,108 @@ static const struct platform_suspend_ops
> >  	.recover = acpi_pm_finish,
> >  };
> > 
> > +static bool s2idle_in_progress;
> >  static bool s2idle_wakeup;
> > 
> > +/*
> > + * On platforms supporting the Low Power S0 Idle interface there is an ACPI
> > + * device object with the PNP0D80 compatible device ID (System Power
> > Management
> > + * Controller) and a specific _DSM method under it.  That method, if present,
> > + * can be used to indicate to the platform that the OS is transitioning into a
> > + * low-power state in which certain types of activity are not desirable or that
> > + * it is leaving such a state, which allows the platform to adjust its operation
> > + * mode accordingly.
> > + */
> > +static const struct acpi_device_id lps0_device_ids[] = {
> > +	{"PNP0D80", },
> > +	{"", },
> > +};
> > +
> > +#define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
> > +
> > +#define ACPI_LPS0_SCREEN_OFF	3
> > +#define ACPI_LPS0_SCREEN_ON	4
> > +#define ACPI_LPS0_ENTRY		5
> > +#define ACPI_LPS0_EXIT		6
> The spec you shared also defines device constraints (function 1). It would be very 
> useful if these constraints  could be parsed and compared against the actual power 
> states of devices on the system at least for debugging purposes.  I'm not sure if you 
> already had a plan for that in a future series.

As Srinivas said, there is a plan to use it for debug purposes going forward.

> 
> > +
> > +#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 <<
> > ACPI_LPS0_EXIT))
> > +
> > +static acpi_handle lps0_device_handle;
> > +static guid_t lps0_dsm_guid;
> > +static char lps0_dsm_func_mask;
> > +
> > +static void acpi_sleep_run_lps0_dsm(unsigned int func)
> > +{
> > +	union acpi_object *out_obj;
> > +
> > +	if (!(lps0_dsm_func_mask & (1 << func)))
> > +		return;
> > +
> > +	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1,
> > func, NULL);
> > +	ACPI_FREE(out_obj);
> > +
> > +	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation
> > %s\n",
> > +			  func, out_obj ? "successful" : "failed");
> > +}
> > +
> > +static int lps0_device_attach(struct acpi_device *adev,
> > +			      const struct acpi_device_id *not_used)
> > +{
> > +	union acpi_object *out_obj;
> > +
> > +	if (lps0_device_handle)
> > +		return 0;
> > +
> > +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> > +		return 0;
> Although the spec you shared refers to PNP0D80/INT33A1 in the context 
> of LPIT, the PNP0D80 device is not "only" used for low power S0.  It's 
> available on systems that don't support modern standby too.
> 
> I for example see it on a system running Windows that does not support 
> modern standby such as the Precision 5510.
> 
> All of the ASL executed in PNP0D80 is guarded with a check 
> whether or not that low power idle supported bit has been set and whether
> or not running on an OSPM that exported a group of features indicating it 
> should support it to ensure its run in the right context.
> 
> Since Linux responds as the latest group of Windows features but doesn't 
> look at ACPI_FADT_LOW_POWER_S0 yet to determine whether to default to 
> suspend to idle i'm a little worried about developing more unexercised code 
> paths specific to Linux.
> 
> For example:
> System has ACPI_FADT_LOW_POWER_S0 set, but also supports S3
> (such as XPS 9360)
> * On Windows PNP0D80 should be used, all ASL code specific to 
> modern standby will be run.
> * On Linux (with current patch) if a user invokes S3, PNP0D80 doesn't get used
> [Win7 should still be using this PNP0D80 codepath, not used by Linux]

Well, this is the situation already without this patch. :-)

> 
> * On Linux (if PNP0D80 was supported on all systems but) a user invoked
> S3, PNP0D80 functions would be run.
> [This should be an undefined behavior since the ASL would run the modern
> standby related code but then go into S3]
> 
> 
> And yes I realize have argued both for and against exporting PNP0D80 to more 
> systems above.  
> 
> I think the proper way to align to Windows behavior is recognize PNP0D80 on
> all systems and also look at ACPI_FADT_LOW_POWER_S0 at the same time to
> align using S2I instead of S3 by default.
> 
> Perhaps this is best placed in a follow up patch that can be easily reverted without 
> messing up the wonderful work you've done so far in case my idea ends up causing 
> other regressions that are not yet envisioned.

As you correctly pointed out above, the published documentation refers to the
PNP0D80 _DSM in the "low-power S0" context only and this is the context in
which we are expected to use it for the time being.

In principle, its coverage can be extended in the future as far as I'm concerned,
but it woud be good to be able to clearly demonstrate the benefit from doing
that (like fixing suspend issues or reducing the power draw while suspended on
some systems etc).

That clearly is not directly related to the issue targeted by this patch, however.

> > +
> > +	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
> > +	/* Check if the _DSM is present and as expected. */
> > +	out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
> > +	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> > +		char bitmask = *(char *)out_obj->buffer.pointer;
> > +
> > +		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) ==
> > ACPI_S2IDLE_FUNC_MASK) {
> > +			lps0_dsm_func_mask = bitmask;
> > +			lps0_device_handle = adev->handle;
> > +		}
> > +
> > +		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
> > +				  bitmask);
> > +	} else {
> > +		acpi_handle_debug(adev->handle,
> > +				  "_DSM function 0 evaluation failed\n");
> > +	}
> > +	ACPI_FREE(out_obj);
> > +	return 0;
> > +}
> > +
> > +static struct acpi_scan_handler lps0_handler = {
> > +	.ids = lps0_device_ids,
> > +	.attach = lps0_device_attach,
> > +};
> > +
> >  static int acpi_freeze_begin(void)
> >  {
> >  	acpi_scan_lock_acquire();
> > +	s2idle_in_progress = true;
> >  	return 0;
> >  }
> > 
> >  static int acpi_freeze_prepare(void)
> >  {
> > -	acpi_enable_all_wakeup_gpes();
> > -	acpi_os_wait_events_complete();
> > +	if (lps0_device_handle) {
> > +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
> 
> Since there is a separate event specifically for the screen being turned off
> I think it would make sense to also export this so that the graphics stack 
> could potentially also call this in the future.

Agreed.

It would require extra care to avoid invoking the same _DSM function twice in
a row, though.

> In the short term it makes sense to me to call it from the ACPI driver immediately
> before resiliency like now though.

OK

Thanks,
Rafael


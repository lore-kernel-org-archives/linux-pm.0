From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH v2] ACPI / sleep: EC-based wakeup from suspend-to-idle on
 recent systems
Date: Fri, 23 Jun 2017 15:37:36 +0000
Message-ID: <3f1cbd8cd7e54576b17c788f4eae2205@ausx13mpc120.AMER.DELL.COM>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
 <2026371.DVJN39QYJi@aspire.rjw.lan> <2368998.dmCsnrcXZy@aspire.rjw.lan>
 <2279758.LZ0rCGQtcH@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:27047 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751496AbdFWPhr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Jun 2017 11:37:47 -0400
In-Reply-To: <2279758.LZ0rCGQtcH@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, mika.westerberg@linux.intel.com, tom@oneshoeco.com, jerome.debretagne@gmail.com, torvalds@linux-foundation.org, lv.zheng@intel.com

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Friday, June 23, 2017 8:15 AM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Linux PM <linux-pm@vger.kernel.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Darren Hart <dvhart@infradead.org>; =
LKML
> <linux-kernel@vger.kernel.org>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; Tom Lanyon <tom@oneshoeco.com>; J=E9r=F4me =
de
> Bretagne <jerome.debretagne@gmail.com>; Linus Torvalds <torvalds@linux-
> foundation.org>; Zheng, Lv <lv.zheng@intel.com>
> Subject: [PATCH v2] ACPI / sleep: EC-based wakeup from suspend-to-idle on=
 recent
> systems
>=20
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Some recent Dell laptops, including the XPS13 model numbers 9360 and
> 9365, cannot be woken up from suspend-to-idle by pressing the power
> button which is unexpected and makes that feature less usable on
> those systems.  Moreover, on the 9365 ACPI S3 (suspend-to-RAM) is
> not expected to be used at all (the OS these systems ship with never
> exercises the ACPI S3 path in the firmware) and suspend-to-idle is
> the only viable system suspend mechanism there.
>=20
> The reason why the power button wakeup from suspend-to-idle doesn't
> work on those systems is because their power button events are
> signaled by the EC (Embedded Controller), whose GPE (General Purpose
> Event) line is disabled during suspend-to-idle transitions in Linux.
> That is done on purpose, because in general the EC tends to be noisy
> for various reasons (battery and thermal updates and similar, for
> example) and all events signaled by it would kick the CPUs out of
> deep idle states while in suspend-to-idle, which effectively might
> defeat its purpose.
>=20
> Of course, on the Dell systems in question the EC GPE must be enabled
> during suspend-to-idle transitions for the button press events to
> be signaled while suspended at all, but fortunately there is a way
> out of this puzzle.
>=20
> First of all, those systems have the ACPI_FADT_LOW_POWER_S0 flag set
> in their ACPI tables, which means that the OS is expected to prefer
> the "low power S0 idle" system state over ACPI S3 on them.  That
> causes the most recent versions of other OSes to simply ignore ACPI
> S3 on those systems, so it is reasonable to expect that it should not
> be necessary to block GPEs during suspend-to-idle on them.
>=20
> Second, in addition to that, the systems in question provide a special
> firmware interface that can be used to indicate to the platform that
> the OS is transitioning into a system-wide low-power state in which
> certain types of activity are not desirable or that it is leaving
> such a state and that (in principle) should allow the platform to
> adjust its operation mode accordingly.
>=20
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
>=20
> In accordance with the above, modify the ACPI suspend-to-idle code
> to look for the "Low-Power S0" _DSM interface on platforms with the
> ACPI_FADT_LOW_POWER_S0 flag set in the ACPI tables.  If it's there,
> use it during suspend-to-idle transitions as prescribed and avoid
> changing the GPE configuration in that case.  [That should reflect
> what the most recent versions of other OSes do.]
>=20
> Also modify the ACPI EC driver to make it handle events during
> suspend-to-idle in the usual way if the "Low-Power S0" _DSM interface
> is going to be used to make the power button events work while
> suspended on the Dell machines mentioned above
>=20
> Link:
> http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0=
_Idle.
> pdf
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> -> v2:
>  Add the s2idle_in_progress variable to distinguish between s2idle and ot=
her
>  transitions, as pm_suspend_via_firmware() is not entirely sufficient for=
 that,
>  and use it in acpi_sleep_no_ec_events().
>=20
> ---
>  drivers/acpi/ec.c       |    2
>  drivers/acpi/internal.h |    2
>  drivers/acpi/sleep.c    |  113
> ++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 112 insertions(+), 5 deletions(-)
>=20
> Index: linux-pm/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -650,18 +650,108 @@ static const struct platform_suspend_ops
>  	.recover =3D acpi_pm_finish,
>  };
>=20
> +static bool s2idle_in_progress;
>  static bool s2idle_wakeup;
>=20
> +/*
> + * On platforms supporting the Low Power S0 Idle interface there is an A=
CPI
> + * device object with the PNP0D80 compatible device ID (System Power
> Management
> + * Controller) and a specific _DSM method under it.  That method, if pre=
sent,
> + * can be used to indicate to the platform that the OS is transitioning =
into a
> + * low-power state in which certain types of activity are not desirable =
or that
> + * it is leaving such a state, which allows the platform to adjust its o=
peration
> + * mode accordingly.
> + */
> +static const struct acpi_device_id lps0_device_ids[] =3D {
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
The spec you shared also defines device constraints (function 1). It would =
be very=20
useful if these constraints  could be parsed and compared against the actua=
l power=20
states of devices on the system at least for debugging purposes.  I'm not s=
ure if you=20
already had a plan for that in a future series.

> +
> +#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 <<
> ACPI_LPS0_EXIT))
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
> +	out_obj =3D acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1,
> func, NULL);
> +	ACPI_FREE(out_obj);
> +
> +	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation
> %s\n",
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
Although the spec you shared refers to PNP0D80/INT33A1 in the context=20
of LPIT, the PNP0D80 device is not "only" used for low power S0.  It's=20
available on systems that don't support modern standby too.

I for example see it on a system running Windows that does not support=20
modern standby such as the Precision 5510.

All of the ASL executed in PNP0D80 is guarded with a check=20
whether or not that low power idle supported bit has been set and whether
or not running on an OSPM that exported a group of features indicating it=20
should support it to ensure its run in the right context.

Since Linux responds as the latest group of Windows features but doesn't=20
look at ACPI_FADT_LOW_POWER_S0 yet to determine whether to default to=20
suspend to idle i'm a little worried about developing more unexercised code=
=20
paths specific to Linux.

For example:
System has ACPI_FADT_LOW_POWER_S0 set, but also supports S3
(such as XPS 9360)
* On Windows PNP0D80 should be used, all ASL code specific to=20
modern standby will be run.
* On Linux (with current patch) if a user invokes S3, PNP0D80 doesn't get u=
sed
[Win7 should still be using this PNP0D80 codepath, not used by Linux]

* On Linux (if PNP0D80 was supported on all systems but) a user invoked
S3, PNP0D80 functions would be run.
[This should be an undefined behavior since the ASL would run the modern
standby related code but then go into S3]


And yes I realize have argued both for and against exporting PNP0D80 to mor=
e=20
systems above. =20

I think the proper way to align to Windows behavior is recognize PNP0D80 on
all systems and also look at ACPI_FADT_LOW_POWER_S0 at the same time to
align using S2I instead of S3 by default.

Perhaps this is best placed in a follow up patch that can be easily reverte=
d without=20
messing up the wonderful work you've done so far in case my idea ends up ca=
using=20
other regressions that are not yet envisioned.

> +
> +	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
> +	/* Check if the _DSM is present and as expected. */
> +	out_obj =3D acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL)=
;
> +	if (out_obj && out_obj->type =3D=3D ACPI_TYPE_BUFFER) {
> +		char bitmask =3D *(char *)out_obj->buffer.pointer;
> +
> +		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) =3D=3D
> ACPI_S2IDLE_FUNC_MASK) {
> +			lps0_dsm_func_mask =3D bitmask;
> +			lps0_device_handle =3D adev->handle;
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
> +static struct acpi_scan_handler lps0_handler =3D {
> +	.ids =3D lps0_device_ids,
> +	.attach =3D lps0_device_attach,
> +};
> +
>  static int acpi_freeze_begin(void)
>  {
>  	acpi_scan_lock_acquire();
> +	s2idle_in_progress =3D true;
>  	return 0;
>  }
>=20
>  static int acpi_freeze_prepare(void)
>  {
> -	acpi_enable_all_wakeup_gpes();
> -	acpi_os_wait_events_complete();
> +	if (lps0_device_handle) {
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);

Since there is a separate event specifically for the screen being turned of=
f
I think it would make sense to also export this so that the graphics stack=
=20
could potentially also call this in the future.

In the short term it makes sense to me to call it from the ACPI driver imme=
diately
before resiliency like now though.

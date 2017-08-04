From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH] ACPI / PM: Prefer suspend-to-idle over S3 on some systems
Date: Fri, 4 Aug 2017 17:02:56 +0000
Message-ID: <c80f0235c09740269fca34d0fd56bb84@ausx13mpc120.AMER.DELL.COM>
References: <3043895.8nuHiCWbDe@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3043895.8nuHiCWbDe@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com, linux-pm@vger.kernel.org, srinivas.pandruvada@linux.intel.com
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@rjwysocki.net]
> Sent: Monday, July 31, 2017 4:43 PM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: LKML <linux-kernel@vger.kernel.org>; Len Brown <len.brown@intel.com>;
> Linux PM <linux-pm@vger.kernel.org>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>
> Subject: [PATCH] ACPI / PM: Prefer suspend-to-idle over S3 on some system=
s
>=20
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Modify the ACPI system sleep support setup code to select
> suspend-to-idle as the default system sleep state if
> (1) the ACPI_FADT_LOW_POWER_S0 flag is set in the FADT and
> (2) the Low Power Idle S0 _DSM interface has been discovered and
> (3) the default sleep state was not selected from the kernel command
> line.
>=20
> The main motivation for this change is that systems where the (1) and
> (2) conditions are met typically ship with OSes that don't exercise
> the S3 path in the platform firmware which remains untested and turns
> out to be non-functional at least in some cases.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>=20
> This patch depends on the intel-hid change at
>=20
> https://patchwork.kernel.org/patch/9867703/
>=20
> ---
>  Documentation/power/states.txt |    4 +++-
>  drivers/acpi/sleep.c           |    6 ++++++
>  include/linux/suspend.h        |    3 +++
>  kernel/power/power.h           |    1 -
>  kernel/power/suspend.c         |    4 ++--
>  5 files changed, 14 insertions(+), 4 deletions(-)
>=20
> Index: linux-pm/Documentation/power/states.txt
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/Documentation/power/states.txt
> +++ linux-pm/Documentation/power/states.txt
> @@ -35,7 +35,9 @@ only one way to cause the system to go i
>  The default suspend mode (ie. the one to be used without writing anythin=
g into
>  /sys/power/mem_sleep) is either "deep" (if Suspend-To-RAM is supported) =
or
>  "s2idle", but it can be overridden by the value of the "mem_sleep_defaul=
t"
> -parameter in the kernel command line.
> +parameter in the kernel command line.  On some ACPI-based systems, depen=
ding
> on
> +the information in the FADT, the default may be "s2idle" even if Suspend=
-To-RAM
> +is supported.
>=20
>  The properties of all of the sleep states are described below.
>=20
> Index: linux-pm/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -714,6 +714,12 @@ static int lps0_device_attach(struct acp
>  		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) =3D=3D
> ACPI_S2IDLE_FUNC_MASK) {
>  			lps0_dsm_func_mask =3D bitmask;
>  			lps0_device_handle =3D adev->handle;
> +			/*
> +			 * Use suspend-to-idle by default if the default
> +			 * suspend mode was not set from the command line.
> +			 */
> +			if (mem_sleep_default > PM_SUSPEND_MEM)
> +				mem_sleep_current =3D PM_SUSPEND_FREEZE;
>  		}
>=20
>  		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
> Index: linux-pm/include/linux/suspend.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -196,6 +196,9 @@ struct platform_freeze_ops {
>  };
>=20
>  #ifdef CONFIG_SUSPEND
> +extern suspend_state_t mem_sleep_current;
> +extern suspend_state_t mem_sleep_default;
> +
>  /**
>   * suspend_set_ops - set platform dependent suspend operations
>   * @ops: The new suspend operations to set.
> Index: linux-pm/kernel/power/suspend.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -48,7 +48,7 @@ static const char * const mem_sleep_labe
>  const char *mem_sleep_states[PM_SUSPEND_MAX];
>=20
>  suspend_state_t mem_sleep_current =3D PM_SUSPEND_FREEZE;
> -static suspend_state_t mem_sleep_default =3D PM_SUSPEND_MEM;
> +suspend_state_t mem_sleep_default =3D PM_SUSPEND_MAX;
>  suspend_state_t pm_suspend_target_state;
>  EXPORT_SYMBOL_GPL(pm_suspend_target_state);
>=20
> @@ -216,7 +216,7 @@ void suspend_set_ops(const struct platfo
>  	}
>  	if (valid_state(PM_SUSPEND_MEM)) {
>  		mem_sleep_states[PM_SUSPEND_MEM] =3D
> mem_sleep_labels[PM_SUSPEND_MEM];
> -		if (mem_sleep_default =3D=3D PM_SUSPEND_MEM)
> +		if (mem_sleep_default >=3D PM_SUSPEND_MEM)
>  			mem_sleep_current =3D PM_SUSPEND_MEM;
>  	}
>=20
> Index: linux-pm/kernel/power/power.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/kernel/power/power.h
> +++ linux-pm/kernel/power/power.h
> @@ -192,7 +192,6 @@ extern void swsusp_show_speed(ktime_t, k
>  extern const char * const pm_labels[];
>  extern const char *pm_states[];
>  extern const char *mem_sleep_states[];
> -extern suspend_state_t mem_sleep_current;
>=20
>  extern int suspend_devices_and_enter(suspend_state_t state);
>  #else /* !CONFIG_SUSPEND */

Rafael,

This patch works for me on XPS 9365.

I ran into some problems with linux-pm.git/linux-next including
this patch though.  I spent a little time debugging and sent a follow=20
up patch to intel-vbtn.  It's not strictly caused by this patch, but I=20
just noticed it now with this default in place.

Tested-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks,

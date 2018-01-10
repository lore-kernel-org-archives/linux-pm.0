From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
Date: Wed, 10 Jan 2018 17:38:46 +0000
Message-ID: <8b088fbf3e8d47dc94cefdae6fe515d9@ausx13mpc120.AMER.DELL.COM>
References: <4046497.JI7UjL75gC@aspire.rjw.lan>
 <12541194.33112yYDjW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <12541194.33112yYDjW@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, valy@mrs.ro
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org [mailto:platform-driver-x=
86-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Wednesday, January 10, 2018 6:26 AM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Darren Hart
> <dvhart@infradead.org>; LKML <linux-kernel@vger.kernel.org>; Linux PM <li=
nux-
> pm@vger.kernel.org>; Platform Driver <platform-driver-x86@vger.kernel.org=
>;
> Valentin Manea <valy@mrs.ro>
> Subject: [PATCH 1/2] ACPI / PM: Use Low Power S0 Idle on more systems
>=20
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> Some systems don't support the ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT
> functions in their Low Power S0 Idle _DSM, but still expect EC
> events to be processed in the suspend-to-idle state for power button
> wakeup (among other things) to work.  Surface Pro3 turns out to be
> one of them.
>=20
> Fortunately, it still provides Low Power S0 Idle _DSM with the screen
> on/off functions supported, so modify the ACPI suspend-to-idle to use
> the Low Power S0 Idle code path for all systems supporting the
> ACPI_LPS0_ENTRY and ACPI_LPS0_EXIT or the ACPI_LPS0_SCREEN_OFF and
> ACPI_LPS0_SCREEN_ON functions in their Low Power S0 Idle _DSM.
>=20
> Potentially, that will cause more systems to use suspend-to-idle by
> default, so some future corrections may be necessary if it leads
> to issues, but let it remain more straightforward for now.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D198389
> Reported-by: Valentin Manea <valy@mrs.ro>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/sleep.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> Index: linux-pm/drivers/acpi/sleep.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/acpi/sleep.c
> +++ linux-pm/drivers/acpi/sleep.c
> @@ -707,7 +707,8 @@ static const struct acpi_device_id lps0_
>  #define ACPI_LPS0_ENTRY		5
>  #define ACPI_LPS0_EXIT		6
>=20
> -#define ACPI_S2IDLE_FUNC_MASK	((1 << ACPI_LPS0_ENTRY) | (1 <<
> ACPI_LPS0_EXIT))
> +#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) | (1 <<
> ACPI_LPS0_SCREEN_ON))
> +#define ACPI_LPS0_S2I_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXI=
T))
>=20
>  static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
> @@ -910,7 +911,8 @@ static int lps0_device_attach(struct acp
>  	if (out_obj && out_obj->type =3D=3D ACPI_TYPE_BUFFER) {
>  		char bitmask =3D *(char *)out_obj->buffer.pointer;
>=20
> -		if ((bitmask & ACPI_S2IDLE_FUNC_MASK) =3D=3D
> ACPI_S2IDLE_FUNC_MASK) {
> +		if ((bitmask & ACPI_LPS0_S2I_MASK) =3D=3D ACPI_LPS0_S2I_MASK ||
> +		    (bitmask & ACPI_LPS0_SCREEN_MASK) =3D=3D
> ACPI_LPS0_SCREEN_MASK) {
>  			lps0_dsm_func_mask =3D bitmask;
>  			lps0_device_handle =3D adev->handle;
>  			/*

In making this change I believe you'll need to cache the values that you fo=
und from the
function mask to test them later too.
Here:
https://github.com/torvalds/linux/blob/master/drivers/acpi/sleep.c#L943

This is because later on both ACPI_LPS0_SCREEN_OFF and ACPI_LPS0_ENTRY are =
called
whether or not they both exist.  Fortunately looking at the DSDT in the att=
ached bug nothing
happens if calling the undefined Arg2 =3D=3D 0x05/Arg2 =3D=3D 0x06 but that=
 might not always
be the case.

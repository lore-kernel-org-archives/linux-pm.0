From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Mon, 12 Dec 2016 09:56:20 +0100
Message-ID: <20161212085620.GA738@amd>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49070 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752812AbcLLI4X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 03:56:23 -0500
Content-Disposition: inline
In-Reply-To: <20161212072541.28435-1-nick.desaulniers@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> A quick cleanup that passes scripts/checkpatch.pl -f <file>.
>=20
> Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>

> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -1,7 +1,7 @@
>  /*
>   * Copyright (C) 2005 Intel Corporation
> - * 	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> - * 	- Added _PDC for SMP C-states on Intel CPUs
> + * Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> + * - Added _PDC for SMP C-states on Intel CPUs
>   */
> =20
>  #include <linux/kernel.h>

No.

> @@ -50,8 +49,8 @@ void acpi_processor_power_init_bm_check(struct acpi_pro=
cessor_flags *flags,
>  	 * P4, Core and beyond CPUs
>  	 */
>  	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL &&
> -	    (c->x86 > 0xf || (c->x86 =3D=3D 6 && c->x86_model >=3D 0x0f)))
> -			flags->bm_control =3D 0;
> +			(c->x86 > 0xf || (c->x86 =3D=3D 6 && c->x86_model >=3D 0x0f)))
> +		flags->bm_control =3D 0;
>  }
>  EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
>

No.

> @@ -159,13 +158,14 @@ void __cpuidle acpi_processor_ffh_cstate_enter(stru=
ct acpi_processor_cx *cx)
> =20
>  	percpu_entry =3D per_cpu_ptr(cpu_cstate_entry, cpu);
>  	mwait_idle_with_hints(percpu_entry->states[cx->index].eax,
> -	                      percpu_entry->states[cx->index].ecx);
> +		percpu_entry->states[cx->index].ecx);
>  }

No.

Rest is good.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhOZjQACgkQMOfwapXb+vJHKgCguNfl4tPapnON0dzvRMRh1khi
V78An0EjEJbpSHf11OWs3XBd0oRoYi6K
=qiQg
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--

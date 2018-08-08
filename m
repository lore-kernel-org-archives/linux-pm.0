From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD
 systems
Date: Wed, 8 Aug 2018 21:58:56 +0200
Message-ID: <20180808195856.GA20912@amd>
References: <20180808174735.3114-1-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808174735.3114-1-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-08-08 13:47:35, Prarit Bhargava wrote:
> commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
> systems") allows use of FFH for ACPI C1 but tools like cpupower and turbo=
stat
> display INTEL for the cstate description.
>=20
> Output "AMD" for AMD systems with FFH for ACPI C1.

Um, is it good idea?

First, you are changing kernel API.

> @@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void=
 *_cx)
>  			"Monitor-Mwait will be used to enter C-%d state\n",
>  			cx->type);
>  	}
> -	snprintf(cx->desc,
> -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> -			cx->address);
> +	if (c->x86_vendor =3D=3D X86_VENDOR_INTEL)
> +		snprintf(cx->desc,
> +			 ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> +			 cx->address);
> +	else
> +		snprintf(cx->desc,
> +			 ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
> +			 cx->address);

Second, I read it as "Intel MWAIT" instruction is used. Yes, AMD cpu can
use Intel MWAIT, too...

Third, there are more CPU vendors out there.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltrS4AACgkQMOfwapXb+vLDrwCeJYO1w+nU9m4bD6TP14FGFpoD
aLoAnRLbyQZlEHBLyv645/5dv7JJNqM/
=S8gu
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

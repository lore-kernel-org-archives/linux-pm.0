From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
 systems
Date: Tue, 23 May 2017 14:24:39 +0200
Message-ID: <20170523122439.GA7483@amd>
References: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52663 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763841AbdEWMYl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 08:24:41 -0400
Content-Disposition: inline
In-Reply-To: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-pm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2017-05-17 09:20:19, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
>=20
> AMD systems support the Monitor/Mwait instructions and these can be used
> for ACPI C1 in the same way as on Intel systems, with appropriate BIOS
> support.
>=20
> Allow ffh_cstate_init() to succeed on AMD systems and make the Cstate
> description vendor-agnostic.
>=20
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/acpi/cstate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
> index 8a908ae..4c5dd5d 100644
> --- a/arch/x86/kernel/acpi/cstate.c
> +++ b/arch/x86/kernel/acpi/cstate.c
> @@ -109,7 +109,7 @@ static long acpi_processor_ffh_cstate_probe_cpu(void =
*_cx)
>  			cx->type);
>  	}
>  	snprintf(cx->desc,
> -			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> +			ACPI_CX_DESC_LEN, "ACPI FFH X86 MWAIT 0x%x",
>  			cx->address);
>  out:
>  	return retval;

Are you sure no userspace depends on word "INTEL" there?

Does it make sense to include "X86" there?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkkKgYACgkQMOfwapXb+vIzUACfagQdVoS3+2ROCibAPakhgUsM
DZMAn1zX6mMR5R0NkuXj+VSswm3w8ko+
=iuFb
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

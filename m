From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/1] thermal: fix cpu_cooling max_level behavior
Date: Fri, 6 Dec 2013 09:52:23 -0400
Message-ID: <52A1D697.5030601@ti.com>
References: <1384366269-1655-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GPHds3scF6R6EBuAe9qETRthVkwCPqWGT"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384366269-1655-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--GPHds3scF6R6EBuAe9qETRthVkwCPqWGT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-11-2013 14:11, Eduardo Valentin wrote:
> As per Documentation/thermal/sysfs-api.txt, max_level
> is an index, not a counter. Thus, in case a CPU has
> 3 valid frequencies, max_level is expected to be 2, for instance.
>=20
> The current code makes max_level =3D=3D number of valid frequencies,
> which is bogus. This patch fix the cpu_cooling device by
> ranging max_level properly.
>=20
> Reported-by: Carlos Hernandez <ceh@ti.com>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Rui,

Can you please consider pushing this fix?

> ---
>  drivers/thermal/cpu_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coolin=
g.c
> index d179028..d0f8f8b5 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -173,6 +173,8 @@ static int get_property(unsigned int cpu, unsigned =
long input,
>  		freq =3D table[i].frequency;
>  		max_level++;
>  	}
> +	/* max_level is an index, not a counter */
> +	max_level--;
> =20
>  	/* get max level */
>  	if (property =3D=3D GET_MAXL) {
> @@ -181,7 +183,7 @@ static int get_property(unsigned int cpu, unsigned =
long input,
>  	}
> =20
>  	if (property =3D=3D GET_FREQ)
> -		level =3D descend ? input : (max_level - input - 1);
> +		level =3D descend ? input : (max_level - input);
> =20
>  	for (i =3D 0, j =3D 0; table[i].frequency !=3D CPUFREQ_TABLE_END; i++=
) {
>  		/* ignore invalid entry */
> @@ -197,7 +199,7 @@ static int get_property(unsigned int cpu, unsigned =
long input,
> =20
>  		if (property =3D=3D GET_LEVEL && (unsigned int)input =3D=3D freq) {
>  			/* get level by frequency */
> -			*output =3D descend ? j : (max_level - j - 1);
> +			*output =3D descend ? j : (max_level - j);
>  			return 0;
>  		}
>  		if (property =3D=3D GET_FREQ && level =3D=3D j) {
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--GPHds3scF6R6EBuAe9qETRthVkwCPqWGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKh1qgACgkQCXcVR3XQvP04PAD/U6ZYQlzZJQC+2bqschJj/cYg
+MeNOlQua0SYDT/K9VEA/iljsNLm2fh9RJfPFZzbbd3x4FoJUNRu3oCR8JiB3iwW
=0MfC
-----END PGP SIGNATURE-----

--GPHds3scF6R6EBuAe9qETRthVkwCPqWGT--

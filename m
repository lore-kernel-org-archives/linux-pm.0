From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 04/19] memory: tegra: add flush operation for Tegra114
 memory clients
Date: Fri, 17 Jul 2015 12:05:13 +0200
Message-ID: <20150717100512.GI3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NyChO5MpGs3JHJbz"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-5-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--NyChO5MpGs3JHJbz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:42PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> This patch adds the hot reset register table and flush related callback
> functions for Tegra114.
>=20
> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> [jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Removed tegra_mc_ops and added
>  metastable_flush_reads.]
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/memory/tegra/tegra114.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra=
114.c
> index 9f579589e800..ba33c402ed68 100644
> --- a/drivers/memory/tegra/tegra114.c
> +++ b/drivers/memory/tegra/tegra114.c
> @@ -914,6 +914,24 @@ static const struct tegra_smmu_swgroup tegra114_swgr=
oups[] =3D {
>  	{ .name =3D "tsec",      .swgroup =3D TEGRA_SWGROUP_TSEC,      .reg =3D=
 0x294 },
>  };
> =20
> +static struct tegra_mc_flush tegra114_mc_flush[] =3D {

const

> +	{TEGRA_SWGROUP_AVPC,       0x200, 0x204,  1},
> +	{TEGRA_SWGROUP_DC,         0x200, 0x204,  2},
> +	{TEGRA_SWGROUP_DCB,        0x200, 0x204,  3},
> +	{TEGRA_SWGROUP_EPP,        0x200, 0x204,  4},
> +	{TEGRA_SWGROUP_G2,         0x200, 0x204,  5},
> +	{TEGRA_SWGROUP_HC,         0x200, 0x204,  6},
> +	{TEGRA_SWGROUP_HDA,        0x200, 0x204,  7},
> +	{TEGRA_SWGROUP_ISP,        0x200, 0x204,  8},
> +	{TEGRA_SWGROUP_MPCORE,     0x200, 0x204,  9},
> +	{TEGRA_SWGROUP_MPCORELP,   0x200, 0x204, 10},
> +	{TEGRA_SWGROUP_MSENC,      0x200, 0x204, 11},
> +	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
> +	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
> +	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
> +	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},
> +};

And spaces after { and before }.

> +
>  static void tegra114_flush_dcache(struct page *page, unsigned long offse=
t,
>  				  size_t size)
>  {
> @@ -945,4 +963,7 @@ const struct tegra_mc_soc tegra114_mc_soc =3D {
>  	.num_address_bits =3D 32,
>  	.atom_size =3D 32,
>  	.smmu =3D &tegra114_smmu_soc,
> +	.flushes =3D tegra114_mc_flush,
> +	.num_flushes =3D ARRAY_SIZE(tegra114_mc_flush),
> +	.metastable_flush_reads =3D MC_FLUSH_METASTABLE_READS,

I don't think it's useful to have this define. Just use the literal
value here. Much of the purpose of having this per-SoC parameter is to
provide the context that otherwise the macro symbol would provide.

Thierry

--NyChO5MpGs3JHJbz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNNYAAoJEN0jrNd/PrOhgokQAIWBk9iTXzxdxCKxf+FSaGuy
UHcrOsuD9k5CtwD8HJL78uDKaWeAVeDucIDxwR5kc+ofuGUWgG7kWZvETcaIc7hw
1lLKqE1CKBBdu/RmfE3lXUT2zCfTo2AScrlGVwhcPjzL9vPMBYIggASDi5qCM970
vjpepxIvtb0EJ/gG+JLYLsO4fsAIqabVR6Piv0YjoxDkjQVQAXlFG8MnbNMqibzy
vaNPEBsMuRBiUkT74JXXC5NJaLg8xkqdogeC44UW1Mtg6ymxn1YJmPLrwEnPaJt+
tWEbmXIypIe8GIyrXWQVpL6NraYYSNT/csNPEaAgp4Zi8kPSqWTJNo3BcRo6TNGU
TI7u6swLu4yVvxrYI/qabkXgdhlo7vH8yeZkgytqVdp0jSxsn2Hh5KpK7N79PbvE
L+r9Z5j/GMMRDeGNUKmwFu2UmFMjjb5ygJgyHEljPioIYJjcwspCRf4lbnk6pcTL
lEGJyGiuYnKVNIlz4CaOTXbsZI6p48YYqLUEZgkaD/tCcQSUQ/a/HV1ljhPB0uCm
0yiIPaUV8nXtn2ggobS5tQcfcmbHHGjtYAxI3j0L2Le9gq8fEbhcrKMJpxaP11mg
Ey0Y1z+JMISs2dlksxMmmYi8WAiR9ZYtyulA3CQV9WbMXpzR6cgfzZa+VYufaZZf
JtSNg6VP0q5FVZayXS6q
=t6Fd
-----END PGP SIGNATURE-----

--NyChO5MpGs3JHJbz--

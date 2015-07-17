From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 03/19] memory: tegra: add flush operation for Tegra30
 memory clients
Date: Fri, 17 Jul 2015 12:03:38 +0200
Message-ID: <20150717100337.GH3057@ulmo>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-4-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D6IIOQQv2Iwyp54J"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436791197-32358-4-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?utf-8?Q?Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--D6IIOQQv2Iwyp54J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:39:41PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> This patch adds the hot reset register table and flush related callback
> functions for Tegra30.
>=20
> Signed-off-by: Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> [jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org: Removed tegra_mc_ops and added
>  metastable_flush_reads.]
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>=20
> ---
> v3: removal of tegra_mc_ops
> ---
>  drivers/memory/tegra/tegra30.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra3=
0.c
> index 1abcd8f6f3ba..3b4987f39b52 100644
> --- a/drivers/memory/tegra/tegra30.c
> +++ b/drivers/memory/tegra/tegra30.c
> @@ -6,6 +6,7 @@
>   * published by the Free Software Foundation.
>   */
> =20
> +#include <linux/device.h>

What do you need this for?

>  #include <linux/of.h>
>  #include <linux/mm.h>
> =20
> @@ -936,6 +937,26 @@ static const struct tegra_smmu_swgroup tegra30_swgro=
ups[] =3D {
>  	{ .name =3D "isp",  .swgroup =3D TEGRA_SWGROUP_ISP,  .reg =3D 0x258 },
>  };
> =20
> +static struct tegra_mc_flush tegra30_mc_flush[] =3D {

const

> +	{TEGRA_SWGROUP_AFI,        0x200, 0x204,  0},
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
> +	{TEGRA_SWGROUP_MPE,        0x200, 0x204, 11},
> +	{TEGRA_SWGROUP_NV,         0x200, 0x204, 12},
> +	{TEGRA_SWGROUP_NV2,        0x200, 0x204, 13},
> +	{TEGRA_SWGROUP_PPCS,       0x200, 0x204, 14},
> +	{TEGRA_SWGROUP_VDE,        0x200, 0x204, 16},
> +	{TEGRA_SWGROUP_VI,         0x200, 0x204, 17},

Spaces around { and }, please.

Thierry

--D6IIOQQv2Iwyp54J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVqNL5AAoJEN0jrNd/PrOhv8oP/3/JR7dINHAGNpviIMZuzwKi
WvyMi6/TXhHai1TzvAA3ZxdFchb8MUUBTdCDpUo5E5GCkWmPn2iKVlbELrdgUNjf
tC4yHo7X0OtoU9k2XoSZm4f/RsiGP/BbmzO+8LAIFvrtw7Bz86wGbaovTCjhN5dt
hq8PGkAfWVJY/bFF/S15oGfR3usq//GU9ZstqlRHDZAfgmpl0p3tOu/cZNgsriAw
EKkAEnPzEegU4JcLAvfn2A5Ee9T8jZCavkKdbFGvPMl0aX3RmBwpHKF9KxBePk/a
tCTm9cvDpe7VxyeX1ya/VNbfYWmXVmu99WQZzx6rCuieshBaZDjBFypvPCoaiGA5
GqMY3RvfqPlbyqMe+GNfVLvVGo0c02OPnwv0ZqlGPJnsHm2QnabgXsbPjEJ7/ogM
4vkMLbPUOUAJZuYjJspyZexu1cFpjzmWaI3e/L/7kmZNysMLeeUtFTj2PuG9NfRB
joJ9NwaGF/lDoWZRN7HOosM6k5QdOJID0XfI5eqCn2r0fQ7r+ZICgcRJ21PmsX6p
QM2rrO/BRprTEPu4R+4F1TdAO8nuQOA6pFK4Co4C3h6jMJQb45wtBpx8TbTNEsng
U9fXBLuseQHlThT5jmhYPjX7uUH2XxDi1crHXqR/yAobECTdC49KD57sDCX7qhIA
0zyqR3mSJ6n0trqSlZrq
=AfIF
-----END PGP SIGNATURE-----

--D6IIOQQv2Iwyp54J--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] power: reset: ocelot: switch the SI to boot mode
Date: Wed, 5 Dec 2018 22:46:42 +0100
Message-ID: <20181205214642.fyuody7yzv6ioiqd@earth.universe>
References: <20181109195700.28321-1-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnfa37dwpgvrd7rh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181109195700.28321-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: UNGLinuxDriver@microchip.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--vnfa37dwpgvrd7rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 09, 2018 at 08:57:00PM +0100, Alexandre Belloni wrote:
> Switch the SI to boot mode so on a warm reboot, the SI is able to access
> the flash.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/reset/ocelot-reset.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/power/reset/ocelot-reset.c b/drivers/power/reset/oce=
lot-reset.c
> index 5a13a5cc8188..419952c61fd0 100644
> --- a/drivers/power/reset/ocelot-reset.c
> +++ b/drivers/power/reset/ocelot-reset.c
> @@ -26,6 +26,13 @@ struct ocelot_reset_context {
> =20
>  #define SOFT_CHIP_RST BIT(0)
> =20
> +#define ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
> +#define IF_SI_OWNER_MASK			GENMASK(1, 0)
> +#define IF_SI_OWNER_SISL			0
> +#define IF_SI_OWNER_SIBM			1
> +#define IF_SI_OWNER_SIMC			2
> +#define IF_SI_OWNER_OFFSET			4
> +
>  static int ocelot_restart_handle(struct notifier_block *this,
>  				 unsigned long mode, void *cmd)
>  {
> @@ -37,6 +44,11 @@ static int ocelot_restart_handle(struct notifier_block=
 *this,
>  	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_RESET,
>  			   CORE_RST_PROTECT, 0);
> =20
> +	/* Make the SI back to boot mode */
> +	regmap_update_bits(ctx->cpu_ctrl, ICPU_CFG_CPU_SYSTEM_CTRL_GENERAL_CTRL,
> +			   IF_SI_OWNER_MASK << IF_SI_OWNER_OFFSET,
> +			   IF_SI_OWNER_SIBM << IF_SI_OWNER_OFFSET);
> +
>  	writel(SOFT_CHIP_RST, ctx->base);
> =20
>  	pr_emerg("Unable to restart system\n");
> --=20
> 2.19.1
>=20

--vnfa37dwpgvrd7rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwIR0IACgkQ2O7X88g7
+prIHg/+IRoghrCppQ1YBg7ywoPdGcZLMsP9GW6/mAy4rYWYG3sTPM+a8aLZ9o2z
irbGgJrD64kF5PFO36AfJPxB3c9DtKfduRzY292/mNzXqVp1Px/QQRNPF/MO/tj9
5NUlGB5EE5hlEY7w/duoH/Y3P4hKTlwwO1SDkv3P8E5mUQ5W/k2gqsUncE14tZ1h
h2utofCv3JK5rvcRfZnA+qNQwrcxJKpVB4DnJQkg1lria+ut3x5Zy9GCntGgMAFK
XPQbZ4OVsLRaUQX+vhLI3ZOCjxacemgiFfWmpnIjwbFfsWwrxjIalEmQ+mHMoEgi
R/24X06zKkBmtoJMHgOKsdRqKQVO9n4KkbnTuTXSsxxqnGntVOFFgPAhLys5P8+j
LEJgCWGs4YSiR/wOzI8RRyXBmj1EIYe9TGyd+n5x/1crBb8eZj4p3wA8avfyrL4a
gpY37Lk1Uop9fKPhu+CAtPvOw2uwRLlBrWBcdXU+jxyXjE6ybwp5BvxIDRxSa8H2
JgLOjAZXFPKw7mWiVPoQ2BVjp8+UUdbZSYfIO7lbZbx1KPoa7APTBGKMebCAo4E2
QkDUKbIfVwvkTjEpp8rX8AMpz/r61YUG0PPTafwhaonuWYN60IqFNKUnVkCekZao
R8hVVJwRbEBLD0MO3j3cc/UOLASP37AGm7alZc3eHlgvnF5G3Sg=
=0yxm
-----END PGP SIGNATURE-----

--vnfa37dwpgvrd7rh--

From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: reset: at91-poweroff: fix clobber list
Date: Wed, 7 Jun 2017 22:50:17 +0200
Message-ID: <20170607205017.a35lbn4q7eizq7rq@earth>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6w5eoyb2ubza35s5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--6w5eoyb2ubza35s5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2017 at 11:49:14AM +0200, Alexandre Belloni wrote:
> Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.
>=20
> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Thanks, queued.

-- Sebastian

> ---
>  drivers/power/reset/at91-poweroff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/at91-poweroff.c b/drivers/power/reset/at=
91-poweroff.c
> index c6c3beea72f9..c30c40193aaa 100644
> --- a/drivers/power/reset/at91-poweroff.c
> +++ b/drivers/power/reset/at91-poweroff.c
> @@ -97,7 +97,7 @@ static void at91_lpddr_poweroff(void)
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
>  		  "r" (at91_shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
> -		: "r0");
> +		: "r6");
>  }
> =20
>  static int at91_poweroff_get_wakeup_mode(struct device_node *np)
> --=20
> 2.11.0
>=20

--6w5eoyb2ubza35s5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4ZwgACgkQ2O7X88g7
+popsQ//R3eq0LPOO9BWEzB4zlDASVNyIbi5Lbyq9QpjowIgROiIX9+SMfNJTlnR
twvn3LBBqEn5NV91MlVzd8BWnYJucOvABY9sWczw2Kv0QySPyUl1gIcpobHVkVbx
3KDc2DGMcbLGwcZLmwEMsl1paf3FMuNYO9H8ocpdSjJBesg89bXRQsTMlSvoOWWV
h/DWwIHrgRoK1a2kQbwQ95aRuucHKCaoCSMTne+bktN09hz0JIJ2mWavYLFw8pEg
MeAjCGSOjHeeZB96zPNhq8ppWYVToNPvB6f7YjeH0+UMXVgs1wvmI0SYr4Ypwjck
C7XKoQuCPT+zYeEb7EA7OI8tVE67F3nL+XbBYHXBhN1B6a2loEFq4JoCC6/D/ZpA
GCx9vhomWdbD2ppFi3nfzEY6AhNMJcwVdgGGRIb/wIgdLpv1lyOkqxcl66eQiaT0
kqbo8E+VXJ2M8ctgb1+iO5HKh7c+EAwTO4uZWhIu93crOMhlb0VL8kRbFsKR7NPx
iJaXs8eiN2qCSOip8eCs+XAvL7wUQxMzB9wH5y84Rl3M9BSTalTS+ZhiWHJC9yN5
/OJTUvaVdDn/ZgvCK/uW2Ge6iHDv9M9apmcid66Au0TYRZpSQ6fuj2BDEj1UIhW3
f33GeWnmj4u2YAXUMDJlphEGh69pIUEqImlBl38i7+lBATztLaU=
=PJ6d
-----END PGP SIGNATURE-----

--6w5eoyb2ubza35s5--

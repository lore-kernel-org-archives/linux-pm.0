From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: ab8500_charger: fix spelling mistake:
 "faile" -> "failed"
Date: Tue, 1 May 2018 13:32:22 +0200
Message-ID: <20180501113222.ypvixxzxkfvwzyhv@earth.universe>
References: <20180430160450.29264-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjdsvpdyaqzdb4cz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180430160450.29264-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--kjdsvpdyaqzdb4cz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 30, 2018 at 05:04:50PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> trivial fix to spelling mistake in dev_error message.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index ba0e97284ae5..98b335042ba6 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3066,7 +3066,7 @@ static int ab8500_charger_init_hw_registers(struct =
ab8500_charger *di)
>  		AB8500_SYS_CTRL2_BLOCK,
>  		AB8500_MAIN_WDOG_CTRL_REG, MAIN_WDOG_ENA);
>  	if (ret) {
> -		dev_err(di->dev, "faile to enable main watchdog\n");
> +		dev_err(di->dev, "failed to enable main watchdog\n");
>  		goto out;
>  	}
> =20
> --=20
> 2.17.0
>=20

--kjdsvpdyaqzdb4cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlroUDoACgkQ2O7X88g7
+pr7Rw//YujoTpOj0i0REUCoiDK1zbDjRlQImL24dMpV0vNAXOyQmdKuqdxoR4N1
DtydHjjAzuoQz9Ud44ywecA/AtUBcYus/8sZ+0Q8/UHY6fMH1qwlyHxK/JqxFlDZ
/Js86liVfItqYFOfFufFb/3N7RsqcQUOnKq9uPiR9dkOsHWVKZ8YlL+cbZX18RSS
UyL7xaeBJRSdOQ2LECIQythFt9b8fr7sIQKRxYx7idbWU1HwIkjzwvpO4h4XrcS0
D742RuibWNgVc06X81fMYfbnRkmeNv5anDjpDCYEhqS+VPDb5fM6LoC2x1cpPlD6
7aaS8/N+QEoBeZeaCqCkF8ToN12HH2PRO+zAqH5wGFN6CjXtyviOFHZFjK+Q4YXJ
euIBPF4iDfA5kjBkmA/hlHl2n0kAt4g8d7AKxWPWBMPN5C072oH2EJ7xgaGk54Wy
lyb7hM4TU98rYt3ICOqcmZQOastKbUm+W0rtRZENMjBuVkEQSO/N6Gf1TKOONIk1
FW+2EiiClsPhCNQC0SDd6Gn+N1ANfZlRZgJTN+D6uiJH8GY1wQ/YFKQwG8x4Al2G
aYq8LQErFTtdQwUXxrZQSFjZcS6q7MP81CBQY2PDpXCYLjgshI1v6V79L0IaPZOQ
ApxN47NM0HLDEbNjNjqHBPXaCM1LN2ozMLgelLk79bDSUIMlnsk=
=xPX8
-----END PGP SIGNATURE-----

--kjdsvpdyaqzdb4cz--

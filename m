From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: reset: at91-sama5d2_shdwc: fix clobber list
Date: Wed, 7 Jun 2017 22:50:33 +0200
Message-ID: <20170607205033.2cmzcrnb5dnp23ej@earth>
References: <20170531094915.3469-1-alexandre.belloni@free-electrons.com>
 <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47c4rmhky23xhmrs"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbdFGUuh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jun 2017 16:50:37 -0400
Content-Disposition: inline
In-Reply-To: <20170531094915.3469-2-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--47c4rmhky23xhmrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 31, 2017 at 11:49:15AM +0200, Alexandre Belloni wrote:
> Assembly in at91_lpddr_poweroff has r0 in the clobber list but uses r6.

Thanks, queued.

-- Sebastian

> Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/res=
et/at91-sama5d2_shdwc.c
> index 90b0b5a70ce5..55fce8b75245 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -132,7 +132,7 @@ static void at91_lpddr_poweroff(void)
>  		  "r" cpu_to_le32(AT91_DDRSDRC_LPDDR2_PWOFF),
>  		  "r" (at91_shdwc->at91_shdwc_base),
>  		  "r" cpu_to_le32(AT91_SHDW_KEY | AT91_SHDW_SHDW)
> -		: "r0");
> +		: "r6");
>  }
> =20
>  static u32 at91_shdwc_debouncer_value(struct platform_device *pdev,
> --=20
> 2.11.0
>=20

--47c4rmhky23xhmrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4ZxkACgkQ2O7X88g7
+pq+Kg/+N0hZ4742rwSDRgHgbyRwPPfQoQFPR1fe1g6C6XeDf5t86LTdP/sojYJY
nLC5qNe8F8d9GszbSVylcO7Cq4YdL+FImwRNPNNq8NPOLNWDZJ0MhZqd7aX/pOaV
VSyALBJ/59cdumfLFGVjEt1LGLY7otKG+2p/5KNX2HrGNpYvZ8o2K1O2VRR5LzKg
nkkV7u1WMFp8fNGTqQZrDcMaP2xNWy6SKYplo4bNKWV0lknicpCw79TfQ/iyL5k6
lMwxOXdyRE4NJGY/RwrxoY93LzUFW3ON4M1khodnpljFmnAFO4gd28JtSWeRM5EQ
pfGPdYQN6r8a14iwCQrSZgDNym2iO8XsOc+JXuI01ETtgPsXgzzpvXcYeExGYtHf
4ONxliL1jY7GUcv2ZAQNyg/L0aWxR5mRL9QHjIDwLLKFH4r15tx4tjlHM0o0ll8p
ir1My/xxt8SmG3zXuOrj6x2STAl6rmzs+fVJgAnRwJ5SmSB7v+s7BrKqb9A5N47W
JvjWSfMSonwYDvkG4rvZE901PAHF6gkxGQrd8X4Owsk+nNuX72qc7Zg6d3ByvVe6
amCmpH3XRZQBaGGcN0F6T2XNZKEHyVWlta1nG7hfqA6BA/A6z5JwmDHClmIDVOHy
2LihIAl7JoAGFJoPQIiKGrGZGeqjHKGd/b/6JWr/nlib9kouoO8=
=Ners
-----END PGP SIGNATURE-----

--47c4rmhky23xhmrs--

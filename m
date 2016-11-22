From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/5] power: supply: tps65217: Remove IRQ data from driver
 data
Date: Tue, 22 Nov 2016 17:51:07 +0100
Message-ID: <20161122165107.nk2lm36nhz6wwlyp@earth>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
 <20161115131855.4175-3-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qvaan57stqve7owv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932878AbcKVQwt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 22 Nov 2016 11:52:49 -0500
Content-Disposition: inline
In-Reply-To: <20161115131855.4175-3-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--qvaan57stqve7owv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 15, 2016 at 10:18:52PM +0900, Milo Kim wrote:
> IRQ number is only used on requesting the interrupt, so no need to keep
> it inside the driver data.
> In case of polling, poll_task is valid only when polling thread is
> activated.
>=20
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  drivers/power/supply/tps65217_charger.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supp=
ly/tps65217_charger.c
> index 04f8322..55a4f34 100644
> --- a/drivers/power/supply/tps65217_charger.c
> +++ b/drivers/power/supply/tps65217_charger.c
> @@ -46,8 +46,6 @@ struct tps65217_charger {
>  	int	prev_ac_online;
> =20
>  	struct task_struct	*poll_task;
> -
> -	int	irq;

Removal of this (and related changes) look ok. The poll_task changes
are actually only needed due to Patch 1 (which should be dropped imho).

-- Sebastian

--qvaan57stqve7owv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlg0d3sACgkQ2O7X88g7
+pp5qg//ePtKh7TEnHy8pFlSe5DONdxhLawZFiqVaw9YIWgDRQ9wfDI4gPC+i/k/
1mNRVzjJTu9CEEgpOqXWr5Enq4L6nIcEbDOA6UqvR01QsuFzxWMGUauFCfRs/Wwt
wx/DTgPH53x6himItkB2bM0v7JAfZtjVSqYb8kgX73WH+NGnSak84VrFSAOb+zDN
aZH12vDPvEJsA1xijo9ba9yQ31FHkFYFTpoXfsK2h4oSeKWJ3gZqgOdwcGLU6MCV
any4Zzpt6lEkErdTfPci9lm3ravL7L2iQb50+HWzA+iO2fe9Smx+KVT6wbsmCH/p
bhgG/5APoBVVDeoM8sgZbiSOsX1P+3VlEnjWz91EKR+WZxjRsYyCQfQNm40jF3ti
I99e+AUlWS8KKLud0kyuMVIm4sSLWPscLRrixgj/B0F7FeQpoE3+/8Z1WwLOFyCQ
Njrh3gTDZlm7hb/zppFm3POUuS+yjRq4KW3jKtWBVoB1DWh9v2Yd/ZiZjLLvGrVY
zODlXIYPHwpmt2z0G+rVlU92AoaXtoWudcvilJMz6zHOvqzc1e/1X0s4lKmnyYxT
Kvzs2ESbfuUAk6ABgJej8wVhTGBu1yMIa4iGOHzQSqtrSPSOTUC5QsGR5fPyausj
6+wASaxPJMxoO8hvdOPx0EZDiccRgCWW75aY/TIZtmuqI27MKcA=
=btSj
-----END PGP SIGNATURE-----

--qvaan57stqve7owv--

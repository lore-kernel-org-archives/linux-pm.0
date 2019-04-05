From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/3] add support for SAM9X60's shutdown controller
Date: Fri, 5 Apr 2019 17:52:20 +0200
Message-ID: <20190405155220.rsxrvv2yopij73de@earth.universe>
References: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lcyamu3phuxokejg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--lcyamu3phuxokejg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 21, 2019 at 01:45:44PM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>=20
> Hi,
>=20
> This series adapt SAMA5D2's shutdown controller driver to work for
> SAM9X60's shutdown controller. The difference is that SAM9X60 have
> option for RTT timer wakeup.
>=20
> Thank you,
> Claudiu Beznea

Thanks, queued.

-- Sebastian

>=20
> Changes in v2:
> - collect Acked-by tags
> - in patch 3/3 use "optional microchip,sam9x60-shdwc properties"
>   string to specify that the introduced property is only for
>   microchip,sam9x60-shdwc as specified above in case of
>   atmel,<chip>-shdwc shutdown controllers
> - in patch 3/3 keep only the optional property introduced by
>   microchip,sam9x60-shwdwc (atmel,wakeup-rtt-timer)
>=20
> Claudiu Beznea (3):
>   power: reset: at91-poweroff: add RTT wakeup capability
>   power: reset: at91-poweroff: add support for SAM9X60
>   dt-bindings: arm: atmel: add binding for SAM9X60 shutdown controller
>=20
>  .../devicetree/bindings/arm/atmel-sysregs.txt      |  6 +++++-
>  drivers/power/reset/at91-sama5d2_shdwc.c           | 25 ++++++++++++++++=
++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.7.4
>=20

--lcyamu3phuxokejg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynebQACgkQ2O7X88g7
+pqpPxAAqI8P+IVyhLmkU+Aes/7au2rBLOAfw5K9NPNj10VzVsfa7dZnpimaWvhX
EqYXyPdPbcj5tAlRlWoVb77bgJvT4JaOQNS25fjR9gxx1IF0nTJm6ggcauFwECZM
3iZ1O0cvZkMAeSlEW9eto9mg18lgUHDI8SDl5RqiEAa7KDKSrKr9/tKEt/K/Kdvz
VA0QtNliTeTG9oYA8JhcPdjQqEpEcwWwoitB2MPWUHcoPw3HIxNRKBQRGjEdsgFQ
rtmk33qHqlobo8gKcv69SCd+wvLu4pht444G5KVrkUdBTwb2rKnvyVqz+BIyxbFv
fknCj9ZEi3AQMLwEkhQv+0LUvcT7aKGyvSnd2wTbI5//w6H/m3/aNCRD2wV/Qlfl
eEFyHSmG3sLw5xJOkqNP0RTqUIDWrKMuIqY4C2sruEgfmVACiKhRWemQwWAHLqXQ
yi1YwaTZbVkqZcgcYI5un8xJqlBUTy41vR6cI/IHrstWYrfX+FPv/oMT/muXurxa
D1Sz3uwRI+kaakIgfvELyV3t2gxM5qokZ3ndQikPDrScnl8h2a7GLjRIjO3vpljT
EqCl2utcFlj7sJIJUSMsbt/JYzwn60Rc9zCvGBs08Mpm4rHL4SRnMtXhYbiF7gtm
1hsmLNo5NdLxnRizxtCm3WRJKxb/+t0jf9bEBVCkqqndhLTvIGw=
=zRv5
-----END PGP SIGNATURE-----

--lcyamu3phuxokejg--

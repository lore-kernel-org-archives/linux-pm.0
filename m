From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 03/11] power: act8945a_charger: Remove
 "battery_temperature"
Date: Wed, 31 Aug 2016 16:45:13 +0200
Message-ID: <20160831144513.rrngdcjfsg5swmw6@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-4-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lt64xh3j5wqlwdv2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472109599-21915-4-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--lt64xh3j5wqlwdv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 03:19:51PM +0800, Wenyou Yang wrote:
> Remove "battery_temperature" member, it is redundant, it is the
> hardware's responsibility to handle TH pin properly.
> It is unnecessary to use the dt property to check if there is
> a battery temperature monitor or not.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Thanks, queued.

-- Sebastian

--lt64xh3j5wqlwdv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxu15AAoJENju1/PIO/qaifkP/R0YMHYBMhjpxKhobNHRp1z9
h1kmfcSZ/l8xJyX6bWiRSkuYOg3HqioMPOtEOwJ2fN+jjF8HGyIkFXEIGx/m9SCH
daRKAXaNUNHB21pyhw5hJZB7jfRw3NO43rs6YNxi73JDVNtjyAlxkWr42Je2/xMl
pTxZDjeFeZmjY24sTNDGrkYcXoe4EoSXVk7zcA6ajN6jndFpCyJfTviaVyF4/Yxj
OSE5nRQVNgRsyAVtmTUF5KcEKLHRn5kwFyFEFPN5vsDg2PxSvQtCib4mWf1PdybA
cZargzRFYAyWXek+V2VzpHZ5W8pc6PttkyYbmnIKHaeEJ9jGWFjwEWUXTKUCaii0
e53a2Qg8dFKMbixOUYt8wIFyZJxMxLYjapMY+BSqOibk5n7wQI3Q4aAWOSCISBDM
mUXcTxo44Mq8RHJSPP72WTbvSUesfbcOpNksHKhUvcNxfCesAXPpKJb1utGyLkUP
JGzKLgevnkS31E+63xs+ta+SAuJpwe3geMEBIyxuaNrc2IHEqlNZGDkOPdzJngR+
8ePqI3D/j8zR63NpMWwdCf/KxcjoIb5pVKNuxcw0ZaUl+CyG+bGmH4HFnKiql1VM
rO87Jcb/R90TyVJz+FJ3YUHHns/vEIuDJZ+R3wVHx7PGmCicoOkU5Rgns/1uvnHc
7vmIAzzgI0uaW7PqbPL2
=AWep
-----END PGP SIGNATURE-----

--lt64xh3j5wqlwdv2--

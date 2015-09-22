From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 5/5] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 22 Sep 2015 15:29:43 +0200
Message-ID: <20150922132943.GF23334@earth>
References: <cover.1440135007.git.baolin.wang@linaro.org>
 <6e7ee1181bf16ee3680cb25225089cfb4a2a72f7.1440135007.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e7ee1181bf16ee3680cb25225089cfb4a2a72f7.1440135007.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: balbi@ti.com, broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 21, 2015 at 01:34:52PM +0800, Baolin Wang wrote:
> Integrate with the newly added USB charger interface to limit the current
> we draw from the USB input based on the input device configuration
> identified by the USB stack, allowing us to charge more quickly from high
> current inputs without drawing more current than specified from others.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Acked-by: Peter Chen <peter.chen@freescale.com>

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAVfEAAoJENju1/PIO/qaG/MQAKEDtNrhlNOBxEm5adP9Xm3Y
HyRHMyRSrgjZt5YFtdzzCNS8a3mY+gubODgyOK14a/tQXqmbBnJHd1zRhhWBgHRz
7Necrzm23FtNJdRqxb0tMWZO9MkBXEJJOp4C32V2ya7EMic8b9/PifExyWzxIIxf
KOM84aYMGI9GRMGTm7b7671MLZ+tKu7Bg+1lIFFp/F7LaJ4Zsu57Yk9Fs9Lf2L8V
LBDxRbcomVIH1d2IN0KDfam7vHiGPe6QsGUV0Ibal6+GDKaX9y2DQO8RX+8X4Z1h
7HNNfnTulU/3wKeAH2WMSyUL9+9JmakVfG1dH/EiWCOmYLj/egL41hSxI7bZI3Ue
FXk1HBFp/7CSx7rayxen7+XOx5s8JMvKc3ZrAo/mtFlaJwanBhwfn8KmvbBsPwVZ
crM+BbeYV6c5rjEQO/+FKDVMX3bO6XU89GTTsx6mElj1CuiILT/GW3qUksFmyo9s
Qk0gZ9cy6tcExqf8LGADekkhg7D5oE8Ww2UnWEX/Z/RlNRpCpzZ2unZD1qytUFiE
vcth1i35jW0pfkfNrB/Eo41WAef1ultEvG8PxhzIEvIHyNXnmgSr7qmzI43dXLPf
SfWfBorAgJl+zqlAg5l2yxbKeR4bpYKNxtrB7mca+XbdF6qW43gD1MeIN2GW38AA
WRFN/Ee375Cs2Gzvm89d
=wane
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

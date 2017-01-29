From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 03/25] power: supply: axp20x_usb_power: use IIO
 channels when available
Date: Sun, 29 Jan 2017 17:21:54 +0100
Message-ID: <20170129162154.pyqi4m5eo6jpaint@earth>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-4-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6554616962571525031=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-4-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============6554616962571525031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="unb4xmhllg2lctj4"
Content-Disposition: inline


--unb4xmhllg2lctj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 27, 2017 at 09:54:36AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X PMIC exposes the current current and voltage
> measures via an internal ADC.
>=20
> This adds the possibility to read IIO channels directly for processed
> values rather than reading the registers and computing the value.
>=20
> For backward compatibility purpose, if the IIO driver is not compiled,
> this driver will fall back on previous behaviour which is direct
> register readings.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

I queued this into power-supply's for next branch.

-- Sebastian

--unb4xmhllg2lctj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOFqAACgkQ2O7X88g7
+pobWxAAm46VrSJV6LZAqux5L155hg+cZ5IGRagN3rgggnBksNyFb24aeFnLtP/o
fx7inQJuS9cf7WCwTfHXcOvfuvLWd0C5t9d6irK3sNiXqrCIeTvnkijYq6o1BwoN
uEy3v1o9nX0Tt0hfweOPok2cRIQdFq49sSoJffDEThA6tZQjBIXU6mijFchbvIOq
ZJURShwsz/liNgc9pBO/GThOy7zNwY453+6emA8/VRAcnTt5gqlDCX6PyE/nBMZd
3R1e0fJPZbsa41QjFcF6Y6FwjkF87kb8503hTt5lzObBzAcn7tWWKY9lcZj8iJlW
Y37UvLRjHvKZbQpZIl+cdvedRfJGRSpXS+6wAynH++CeKVtDdAUEVz/ICaW++EkX
GY3pau/u5/t5HTwQdi3FZ5wdo9yYPYd56wIIRFYTQ/z7xKvo+9BBKG592ILkjdXH
h8rjnMV7ZhTYIhNrBbsFiX+LNnKKZcQqlPJsgQ/m9BTW0U4qHwxF8DFjN9rtpn3H
o52RNipbTkXIkpIVRE1qDAIenOj6vv2WzdKOl8GFAzkM7h9fxwNdYReyeCs4Rbgd
oq7PZSITulQJRj0Z211dZZa8keBB2AJyuYps+dPXwSeO4WilB/YSYadbLqv+X+4b
Dt6wBJT2Zq93QQERsx0hr1AA5B0k3+uRmZxWPwsDx0ddpNegoFE=
=FvYD
-----END PGP SIGNATURE-----

--unb4xmhllg2lctj4--


--===============6554616962571525031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6554616962571525031==--

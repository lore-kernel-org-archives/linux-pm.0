From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/2] power_supply: Add no_thermal property to prevent
 recursive get_temp calls
Date: Mon, 27 Oct 2014 19:29:58 +0100
Message-ID: <20141027182957.GD10897@earth.universe>
References: <1412696857-14803-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412696857-14803-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Anton Vorontsov <anton@enomsg.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 07, 2014 at 05:47:36PM +0200, Krzysztof Kozlowski wrote:
> Add a 'no_thermal' property to the power supply class. If true then
> thermal zone won't be created for this power supply in
> power_supply_register().
>=20
> Power supply drivers may want to set it if they support
> POWER_SUPPLY_PROP_TEMP and they are forwarding this get property call to
> other thermal zone.
>=20
> If they won't set it lockdep may report false positive deadlock for
> thermal zone's mutex because of nested calls to thermal_zone_get_temp().
> First is the call to thermal_zone_get_temp() of the driver's thermal
> zone. Thermal core gets POWER_SUPPLY_PROP_TEMP property from this
> driver. The driver then calls other thermal zone thermal_zone_get_temp()
> and returns result.
>=20
> Example of such driver is charger manager.
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

pulled into next, I will include it in 3.18-rc pull request.

-- Sebastian

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUTo8lAAoJENju1/PIO/qaSKgP/0W568cgElfXRQQPBY1ftAlY
r/R0nI4tewbf4U/XeigGbo/4rST43FxlBG1YUkRmemdUTe0U/Ze+IKzMLoTwjQiw
9NRXB/4UdromCkJWDLzWE2RTuHGj3duxpjtXAMo0g+Di9U9FXibAXYaqUho6h+H+
sx4iIfB/gtSUXzyEXakEXyr4ktEiYsherxWl0rPo5EQkW7+IANY+l5bpCfOYlJJF
EgcfRjh13tGAn1BTPGxs5Ic+XAmQPvpFCzZNCD5Aut/c6ZSXETSlzYtFjw9+6d+0
5caP9rtuPsnv5/+YBmEY2ykI3+H0sAIW8bK7YCGljKqbsu2pR9pQAC7ABxnAocSn
BPBXNuXkHDBSYBkgGTL1azt8n/uL/5FmcSq9RI2zfdO1OUyG7aXJgyFtDrU7XM63
hR5Du1U77JqFZMwrBE7kjLjuO437aI27qfPRGHWGQngdT7QDw8DFZY02/3Iyh6Rx
IcQXgj3yvzj0vZtc6AIzn3tmLgOa8sGTQufp4UDzWxMElhnz9fu9S4fKJWIfDg+Y
X06q2mPn+VaGlkeHJwmxsiR7E2z6lO+NqmTwun4k5y1U7yjb7aHVElROXMXT+oYo
reyjiajhdsMsDA8pU9BW0XCDHl/EHGNCt5Hs41ukiQxQrmZTbRbfcQOvpzzj2mPy
MeKxFpdyAgf7J65hb0WR
=Kt52
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

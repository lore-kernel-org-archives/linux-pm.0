From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] power: supply: ltc2941-battery-gauge: Add vendor
 to compatibles in binding
Date: Tue, 11 Apr 2017 16:28:48 +0200
Message-ID: <20170411142848.zsbktcfyid4nwcty@earth>
References: <20170329160057.8298-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saq46srpwqi75ftn"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170329160057.8298-1-javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--saq46srpwqi75ftn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 29, 2017 at 12:00:56PM -0400, Javier Martinez Canillas wrote:
> The DT binding document for LTC2941 and LTC2943 battery gauges did not use
> a vendor prefix in the listed compatible strings. The driver says that the
> manufacturer is Linear Technology which is "lltc" in vendor-prefixes.txt.
>=20
> There isn't an upstream Device Tree source file that has nodes defined for
> these devices, so there's no need to keep the old compatible strings.
>=20
> Signed-off-by: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>

Thanks, queued.

-- Sebastian

--saq46srpwqi75ftn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs6CAACgkQ2O7X88g7
+poXeg//bI6udt2wSNm6GB+tBodnXzwiu2d8+HA9MEqbzoJr7vkvsHI94yH+tE2v
KWxMngczULRY0UrWptPZi3d+JLqbzMh9J1rU/RwxCJ/b9RR6zFsZgbzzyzDZOxoc
Hk65NLq/Xw+gZ4i2bTDIR5w33PQPFKTFw7QivXa2BIj9pwaA6+X1pmiMAZUvaIfE
7+e32JHg0UfgjLoMJw74nCyDv8tbqOSqgXNwdY8/I8kkH5u0xSh/xwhTyeOFrK3g
RLRxyzSPkngUPoUMagiz7rkdnnYcNNsapnJKOpyLqXKu1dxnWNJUatLTYcAKaK+m
KXC4zGkTdAeQ7JEn6G2KXYNyl9nXUJmck9ri6bQ31q31kDVDRfFWFTwNnk6edQDr
EZH3GicnsVoGOLHA5cS/WG/q9ci/YpSoLNFJkx2hTyLFQTkgFOCcoTUrqeRPbDNl
G2wiRm67n8hmkUDA0z0iDZ1QqVkrifAPeOsBf1eg69MGt5+/b6y25uLmRVMcPd/3
lxG8oXOTj+IWwxmsKbyiOqvOGj/JRenCnUS0arNWs6PC5RRjCo7adwKM/BZagijs
JEfeEsrdKMpzF9xScNpfOOLBlqoNPMmUUWp5E5fptGSeGd/QDez4dvhFskD6ZmCl
c6nxbPlqkFzFdfmcKtR+DZ2aMwEOsT8KoD6iRnVqxqeYlvrkqdI=
=TbEl
-----END PGP SIGNATURE-----

--saq46srpwqi75ftn--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

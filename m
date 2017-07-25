From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH v6 0/3] power: supply: ltc2941-battery-gauge: Support
 LTC2942 and LTC2944
Date: Tue, 25 Jul 2017 12:20:07 +0200
Message-ID: <20170725102007.o5rfdxndap6lilad@earth>
References: <20170716093202.vfea4yylbzfec72v@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nronmwcbzgcbblw4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170716093202.vfea4yylbzfec72v@lenoch>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Looijmans <mike.looijmans-Oq418RWZeHk@public.gmane.org>, Dragos Bogdan <dragos.bogdan-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--nronmwcbzgcbblw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 16, 2017 at 11:32:02AM +0200, Ladislav Michl wrote:
> This is the 6th version of patch.
> Changelog:
> - v2: reworked voltage computing to not overflow and keep precision
> - v3: update devicetree binding documentation
> - v4: add ltc2942 devicetree compatible
> - v5: reworked to incorporate Dragos' LTC2944 patch
> - v6: fix missing break in the switch statement, move LTC2942 and LTC2944
>       id definitions into respective patches
> =20
> LTC2942 is pin compatible with LTC2941 providing few more registers
> holding information about battery voltage and temperature. It can
> be runtime detected using bit A7 in the Status register.
>=20
> LTC2944 is compatible with LTC2943, but uses different
> voltage and current computing constants.
>=20
> Comments welcome,
> 	ladis

Thanks, queued the whole patchset to power-supply's for-next branch.

-- Sebastian

--nronmwcbzgcbblw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll3G1QACgkQ2O7X88g7
+prNCQ//QaE+oOAb60Hmy4kq72yT1j9sP1wRhJ9TGjNPaezpldTIzbzr67vGc/Ht
QEqEg6jGWnZNO6P6kyHb63PXHQF6qFgt3atqTK8OgFLEIGo3z1ZnB2u4ZBZT3dZ4
mh7Map604MLgTsr9183hOmwGmDR8YVL+1cNmcvdw9Gwu1bvIuDIaNt5L+tET8/Hj
2QWrP1Km7/uzMqYhjbPjOnSvG04CowYMUQZdkpP3d6sseGuNA+49jPLrfhNCAzPI
iQqTzQ3Hl3KkxPvTwQs46fKzte/lAys7Xble9GzjGq5H9SQxa0DpBLuLTzYfh1en
s0+G2WsjQvgvJ5kv9aljiD00pv36FWHpc4NGGtqeoHrc1SDA1+vNfT71CG9Ek/la
B934su7bGPT+DfN2n3Tsw61jZqsEJFMhnSeTh9DFhOBg02v2rGXZhgWnZoT9g3LS
ayUYr/CeM/t5uyuB+N1zd5JxWeZ3Alej8cjsiCHk0ZmPnLmFSctv8TJhcRTcj7uy
bqv0xgwcW2JBzHgtIT8Hfry/J1mRlBAwS1Gg6SJO16pBoIJiJNyg5kLT/UUEM9bd
gl1KKzDXicXbwjWZKgjWLV7miEOOhWmcmCYUIrCLaYdPUgcZgTrhJLG1yZkB3s/j
J6P/Ea/qQV8Xf4YPaii0hERfi3QMBLGNjF1i9TZEerU42Hd+wKg=
=hsG0
-----END PGP SIGNATURE-----

--nronmwcbzgcbblw4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

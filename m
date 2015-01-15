From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 00/13] ltc2952 modernization and new functionality
Date: Thu, 15 Jan 2015 01:52:49 +0100
Message-ID: <20150115005249.GA20141@earth.universe>
References: <1421223346-27410-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421223346-27410-1-git-send-email-frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frans Klaver <frans.klaver-MHHw4NDrbWwAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Ren=E9?= Moll <linux-93MfrKQ0iTlmR6Xm/wNWPw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 14, 2015 at 09:15:33AM +0100, Frans Klaver wrote:
> Here's a resend of an earlier cleanup and improvement series for
> the ltc2952 driver.
>=20
> This series implements devm_* usage, reduction of globals, some
> cleanup and finally makes the input trigger optional.
>=20
> From the changes to the previous submissions I did not include
> renaming kill to poweroff. The name poweroff is already used a
> lot. Besides that, the control is referred to as kill in the
> ltc2952 datasheet.

Thanks for the cleanup, applied:

http://git.infradead.org/battery-2.6.git/commit/d84ba07c27fafca3cc77b25a1e2=
04383a4b5af91

-- Sebastian

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUtw9eAAoJENju1/PIO/qatb8P/3bKXUeBEJ6n6pixVf8aTdGh
BpVzDkCa4ezxb2esvDxT0YKWcquVV68bXlpYwnU5C324emSmgxY+EN8RyzQTO4FH
M5mESt6eTnZBwx87RNUD59kEyaKiKaxH2F3p+BNdv1ikSLiHYmvNGXyw6NoabNxE
TGKawixtJwfA0Y9VRHUqSIvrZfPAAV7x2N3qX1PMTEVBRttAunAMLNlOQ8rQsWel
2qtDatDqvPwJ/FQQnDmdd1ExRXEokvYQyFYS9qLoqyayioFeroZpBlnMOr091bJP
+OTwPi7c/z8iZuJtbYcvMsu3y5TAUNjM1E1vAH3gO4H81tKQPuPZ2jK8NJ2mLvYl
W+WnbfbuL2rmZlOqErhXhOLCrRWwn1rkVrO/ITmXGlvdr5CMIYmzQNBeSsQnl6VJ
QUyLfupWFW2xK/exZKLPvy8+orFBlk9JhZyF3SVzis1Hr0Rw1CbyBd+9SmPTtP6U
KIrtzE7+CLtsp8OLiZW+yNz++d7CBXx77DebRHa+hGX80FFAL8VYIeJhlRSS53Fc
tRl8BiyEVpRjRS5blJAqOEUR2ZM2U8Xl/dUYqiE2oyCig/xcjQx0iIxjQXeCWUZQ
iwzw5nlGLMjiLYCm1PNiEyxAUwdRfObIGeCoNc0zoccgFqBXzW4rbV1jBw6E8Nxl
lwWRJ8d7S27+zTE+aSSg
=8HFH
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

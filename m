From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 04/11] power: act8945a_charger: Improve
Date: Wed, 31 Aug 2016 16:45:34 +0200
Message-ID: <20160831144534.g6ylkq6hb5jmwhqt@earth>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-5-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jewiji2ahoulowwa"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1472109599-21915-5-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--jewiji2ahoulowwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 25, 2016 at 03:19:52PM +0800, Wenyou Yang wrote:
> When get the property, first check the charger state machine,
> then check the status bit to decide what value is assigned to
> the corresponding property.
>=20
> Retain the SUSCHG bit of REG 0x71 when configure the timers to
> avoid losting the charger suspending info after boot.
>=20
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Thanks, queued.

-- Sebastian

--jewiji2ahoulowwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXxu2OAAoJENju1/PIO/qa/E0P/jt613ghFIYBJifTdd+XaMAs
Mt9ES6KmOWtso3j0Z8pNNwNxO9hkkv7ZFYIZmBDo4B5pUOh72Gx3uUrHZPammHGx
hByuQNt/245kVhn/LZ7p2NhTp/ptU9bT4t2ocFsiyYFrQluRJiPR3mdig4As2/w7
kIz56rbo59LYTLtk9oyhKMJt7wixyqeruQHhiD+K6SVR68NLECZdR7TaxwgrOyN6
agU5oCmCLALDDxyNy43RtuRZoiYDba5IL0GBnfeC/SlFadykM9YeXVNePbaSMA/C
bX3m6qsWmHsxnyRAyPh7RghWQ7ic2x0VxlxbHhE2RNHATjWFODV1y5d2tdjDUWdY
vrTOP0BYzq8HOWfaKbtkW18OL3vMnSBhiw6TYS/7jIJkGMeTrUEzpCJN3zTeV4LB
IVBReebSAGdfzo68bEowhFjzDZZ0Pdi8R2+8TbhBYXTrlTXAsRVBCjMNkcp4gtrZ
TlzIBAaUyYRuCT7KIGP8imfMoYLhphmkeT7c8yvZt1539NrOJNJTtbGpsmobdKP8
LCUE7Sg1Vd6SdG9fC1biLhowpNZBxomDIBHzAiP5zTsEnspxTk10jowh06TlTZTX
pLNbmwvcqPCBqGyGbsalpdJeyeD+rg76Gwz0Dd4AkG3KmFG1iekKBIyJ18O2jS7W
MPVzINt4CRkbkJkHtDxs
=YA13
-----END PGP SIGNATURE-----

--jewiji2ahoulowwa--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

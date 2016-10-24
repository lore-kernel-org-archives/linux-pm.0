From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
Date: Mon, 24 Oct 2016 12:17:00 +0200
Message-ID: <20161024101659.GA1440@katana>
References: <20161005155112.13774-1-hdegoede@redhat.com>
 <20161005155112.13774-2-hdegoede@redhat.com>
 <CAGb2v67iQikSHcwS15VmSC6fNMVG9Zya9fz6C6b5+wW43rPZfw@mail.gmail.com>
 <bbd16837-a260-b574-1b1a-1bede038e3de@redhat.com>
 <20161024100938.GI14477@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45770 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755321AbcJXKRU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 24 Oct 2016 06:17:20 -0400
Content-Disposition: inline
In-Reply-To: <20161024100938.GI14477@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>, Dennis Gilmore <dennis@ausil.us>, Maxime Ripard <maxime.ripard@free-electrons.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-i2c@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Even though axp20x-i2c seems to be the only "DT only" i2c client,
> > > would it make sense to add DT-based module autoloading to the i2c
> > > core?
> >=20
> > If it is not too invasive, then yes that would be a sensible addition I=
MHO.
>=20
> If I understand you correctly, I already have a patch-set on the ML
> that does this.

Incomplete, though. But we will see if Kieran finds time somewhen...


--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYDd+bAAoJEBQN5MwUoCm2F28P/3kvkKrIlPKUQDoSahZhYnqu
l8yxVI4m+FRoRt8tk7Is8cY6R6cjd92V11SEvD/NjG3YENQF5/tjQn/CsYkNKtLP
bZIiVaT9BST+citJhhbXqll7LpkcP6jrUDyu9FJtoOEMr0FMLjoyi48DyaEcnFa8
XXmFZ4X2oJPrQiBePZv/KA6L0qRHgV0PO5nWJKr9v+Me6yw8Cgq183rmxjqlRAqc
j0urny571j6LEqNmO9TyEYDdDPnxFakL6cnYzkyCktVh4/dbXSTzmppvWTzNx97L
Tds4KMgryXy1jE7RpH7Z+ALY2LxSc+w/TeoA2wXVpt96lkEmEn1oDzd0BLEskzoL
FMQDYAwdGRRHYf2uj+vPx/NMRlp4jtSKG1Fb7jVGl7qC7QQ0LwRGLGgccJrk8T7R
sA4d2aCR6Dkjrx+DKEDGLGgI3RfgiksSmSdqY9IYwMly3G/9l1z9eLa5Tf0XlDFj
uLrtfLaVtNnZXoiblqosveg4AKOLhyDzVclsDmrl8bc0/2phGk3ddCazhWPeeiL7
tMSmQQMopKZSmjDS4QsiZCLeCii1hlCs2ZGHzyyyxz/blIDf0M3hQI+CH0u/Zh3g
Bu48Pv1QHxJBBvtFgSHTKUV+qcdhWHJLD5i4wz9FkyWmJougscQAxpEVSvOxJTUV
J2AxrPcxWmtol3Of4m1C
=8DWs
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

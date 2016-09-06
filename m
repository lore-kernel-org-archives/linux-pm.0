From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: sbs-battery: simplify DT parsing
Date: Wed, 7 Sep 2016 01:55:23 +0200
Message-ID: <20160906235523.ff4opq56gg4ln6xv@earth>
References: <20160906131643.1930011-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a26xlr2lmrbvkolp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754944AbcIFXza (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 6 Sep 2016 19:55:30 -0400
Content-Disposition: inline
In-Reply-To: <20160906131643.1930011-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Phil Reid <preid@electromag.com.au>, YH Huang <yh.huang@mediatek.com>, Joshua Clayton <stillcompiling@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--a26xlr2lmrbvkolp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, Sep 06, 2016 at 03:16:33PM +0200, Arnd Bergmann wrote:
> After the change to use the gpio descriptor interface, we get a warning if
> -Wmaybe-uninitialized is added back to the build flags (it is currently
> disabled:
>=20
> drivers/power/supply/sbs-battery.c: In function 'sbs_probe':
> drivers/power/supply/sbs-battery.c:760:28: error: 'pdata' may be used uni=
nitialized in this function [-Werror=3Dmaybe-uninitialized]
>=20
> The problem is that if neither the DT properties nor a platform_data
> pointer are provided, the chip->pdata pointer gets set to an uninitialized
> value.
>=20
> Looking at the code some more, I found that the sbs_of_populate_pdata
> function is more complex than necessary and has confusing calling
> conventions of possibly returning a valid pointer, a NULL pointer
> or an ERR_PTR pointer (in addition to the uninitialized pointer).
>=20
> To fix all of that, this gets rid of the chip->pdata pointer and
> simply moves the two integers into the sbs_info structure. This
> makes it much clearer from reading sbs_probe() what the precedence
> of the three possible values are (pdata, DT, hardcoded defaults)
> and completely avoids the #ifdef CONFIG_OF guards as
> of_property_read_u32() gets replaced with a compile-time stub
> when that is disabled, and returns an error if passed a NULL of_node
> pointer.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 3b5dd3a49496 ("power: supply: sbs-battery: Use gpio_desc and sleep=
ing calls for battery detect")

Patch looks fine to me. Actually I already asked Phil to
implement your change [0]. I just queued it to power-supply's
for-next branch.

[0] https://marc.info/?l=3Dlinux-pm&m=3D147273382018953&w=3D2

-- Sebastian

--a26xlr2lmrbvkolp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXz1doAAoJENju1/PIO/qawo0P/Avcp+QkBTDizfqo99OJhaj4
od1WfFY+hCjRCof5EzzzBeKq0x+Azoh+fva1ny9/IyjBJG9oRAOjfcZdqIYBSKvi
ycQkZKodgs1nqE5QOSzRrfG79Uk8TLNktgxg45liDaN12Omt7ZHtEkzsVepP2kMu
sMI/DrDB9F8GAxreruTnDIEY1I2EABn95mmlzZpZ9hgjoiOBiuGvmCMPRUJl7o4x
sk+81bxGATlsUc70or60s5pHJH+5zoC4SqQT5QySjpqoKlMuRxAjyyP3FEgwT0e/
iW1Sw42SDPikrsprU9D5/blp7dud0wnvF6Q+s/acmbQf8hXitfn2/bdwUrjIS9wG
fFE8PjAx3Gm5ODoGbVgv0cOa1KPoSFcPIp11xuAbn6n6Gosx5bm9UOheaFANTVbc
pad/JoJjRBenzTXu3uPkEbtsDnQfw66WvQrJQp/M8tgHl/O/3967wazGtBPX7eIe
sWf9qtQ28CobejZnrzGPjzPLkrOjCAJNFaLe+vEe18JHdz5ZUVDbeRiQ3jsXtkz2
e30LFxIGt2Ee5R4M3vvt75tBALGlEfEPcZaK0oiX/v9FP0XyzIsVNPrMTIYbbecG
0amFlinNDDt2gck7Yx4vCoQua4jR+eD0QOwbmVEHFWBlO5m5jqtmI/L1xcjb9Byb
LWnpk4nxUnvZ7bpD8j7M
=wH4g
-----END PGP SIGNATURE-----

--a26xlr2lmrbvkolp--

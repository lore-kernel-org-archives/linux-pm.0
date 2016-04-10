From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [patch] power/max8925: freeing wrong variable
Date: Sun, 10 Apr 2016 18:27:29 +0200
Message-ID: <20160410162729.GB25923@earth>
References: <20160318054016.GD2111@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160318054016.GD2111@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 18, 2016 at 08:40:16AM +0300, Dan Carpenter wrote:
> We were freeing "info->battery" instead of "info->usb", which leads to
> an OOps and a resource leak.
>=20
> The labels were wonky, "out_battery" did release the battery but out_usb
> did not release usb.  I was introducing a call to free usb so it sort
> conflicted with existing misleading name.  I renamed them.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, queued.

-- Sebastian

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXCn7xAAoJENju1/PIO/qabqMP/A5t/AhmRkQyYpKS8jobps/+
OSZRnonZhLwBXvh4tqkfzDhRntcNN9sqGDH4w2Sd4mudT+9NWUiJCxLgO5dsVnZB
bh2dGvfiHvj60G2VIiyR1VLUY3qKRYNJBA3YzkS9z0dJ8ep8hKyAdZ9C0cIp9r5s
aZ/z+bl9RS/RtHxC6dJluhtInVrBrRX9pcKLJuId8P1aydaTWCDOwhtA9zvZyzsx
Ry2Xa3sfQOofUizaCdr1ZKT6y/dn4SCv9MeLBAyuQLIKF9YAoGEgmcghtTIvSZCT
MJ0CUGbxRHhWDyp+ogktIE3tTNXv3mg+9b2TLBDTbd/0uS8L4Ni12xx+IiZrZ28X
84Q8BtN7zqHqa7FSVP3fziKPSnw1ohGW5FI3Yv2bCtUTg/UULzWDePb/5TS8zsNx
1yTf1orChqwh7jSCjBRShXGgAOCJZO4fS0yUKoTjpPj+0Ree8yrfP/ihItThpp9e
s3TSmFr1HqMft2Q545xWd+UauSRA/rSEpnb5cOz29XLZfL3PGPxlO7N6PoqTzu5c
oF+02st6lHQhro71n7woQmx3/0z4HxMKrqIS9/A8F5/7A9uljaHDgaKsju4JhbV0
fCRa/eX66h44GOIhUNYPylXilLC3LhKpyu8jyq5pusmVGgY+D+5Ywb5QxGUxYz2b
zIXDQx/BiKGmkqoKAekS
=WSN4
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

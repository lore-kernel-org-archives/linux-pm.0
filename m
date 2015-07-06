From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 3/4] mfd: axp20x: Add a cell for the usb
 power_supply part of the axp20x PMICs
Date: Mon, 6 Jul 2015 12:30:14 +0200
Message-ID: <20150706103014.GH3269@lukather>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBXVT5GWAKGQEJSH7RCI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435316357-26606-3-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2015 at 12:59:16PM +0200, Hans de Goede wrote:
> Add a cell for the usb power_supply part of the axp20x PMICs.
>=20
> Note that this cell is only for the usb power_supply part and not the
> ac-power / battery-charger / rtc-backup-bat-charger bits.
>=20
> Depending on the board each of those must be enabled / disabled separatel=
y
> in devicetree as most boards do not use all 4. So in dt each one needs it=
s
> own child-node of the axp20x node. Another reason for using separate chil=
d
> nodes for each is so that other devicetree nodes can have a power-supply
> property with a phandle referencing a node representing a single
> power-supply.
>=20
> The decision to use a separate devicetree node for each is reflected on
> the kernel side by each getting its own mfd-cell / platform_device and
> platform-driver.
>=20
> Note this commit also makes some whitespace changes to the intialization
> of existing cells in axp20x_cells, these are pure whitespace changes,
> functionally nothing changes.
>=20
> Cc: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVmli2AAoJEBx+YmzsjxAgzV4P+QF8SJw9uX/RZklNTlEx165O
bnLZIwe7OZWnpNovLh/rhjr9iD1PrzJNxfOJdKNS0j7Dc54qnK5SWeg+ga3b4MNw
hWGu1wonsmPeS/pylVxSX9wtic5tPhFeQcT6E5Qz74jn1cEVtXe+eLkFt3wuJ5hS
A9nIVrablUpfZ8prElwZridXY4DS/34w2UB1vSERxqxWnhPRLZ25K4BhH8faIv6Z
yzdsy4GBUyDIjSHvf8rTZqQStAyCGlMyVvtLispdRWla/Z3FutrdcpRhK9w632ya
6jZwaz9a9sOfVKIw2bgy2lOgpO9O6GNAYjHZVHuAN3EG1pV/4m+U1CXSvpdtGVCn
mO2qh8pjtn1vn7/xjE9mjUpb17HL6JkyAwLBPx+/XtvFIK6lbTBYimJOEvSNgV67
JPdMKH3B9B7WP6eS9ZlL3MoxjS1Pyob8AbMnoDU0IY7tToPYIIFf8nKWotWFFXem
G8qhkklTAdp+11Vaahqb557Rqurya67TrB2+yNTt4zkLF5x2Iq+cr4aFzileEYp/
jcf6hRRmhaPlhlsxNje332IjHq8TIltMAcKBjADo0WE9/I19flmd9j6pn84ag9ux
hSRVRvubFGs9Jm1HZ0UA1nME+qaocZDnUrdBKdlyFdU9vXwxjAKQAnXTPVWT86ei
fSSCY25ei5L6tZk+Eq47
=75B+
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--

From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] power: supply: bq24735-charger: optionally poll the
 ac-detect gpio
Date: Sat, 17 Dec 2016 16:04:07 +0100
Message-ID: <20161217150406.6jkmrrphz2obwia6@earth>
References: <20161214151026.5q6goxlfscv53tol@earth>
 <1481794126-5670-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gaxeoruuk32fxboj"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1481794126-5670-1-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--gaxeoruuk32fxboj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 15, 2016 at 10:28:46AM +0100, Peter Rosin wrote:
> If the ac-detect gpio does not support interrupts, provide a fallback
> to poll the gpio at a configurable interval.
>=20
> Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--gaxeoruuk32fxboj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVU+YACgkQ2O7X88g7
+pqOkBAAjNUEQJ47pwj4ifN3YqDmCea/d/t12DlTfuzSzm/LwsB3b586fylV3Xs7
EvUa2n1CONeXciL2YJHqr5UAw4i1iArjzSGaNf8ppmx7ZbKwgsHQByf5spFQpsYr
JnPclcsY395EvbkbUMYauFbkTY6S2Tu4Yg7CTLq8+xb7XCI1wIiOVK9/dwa7uaY1
UHFoQwEH7xrjmqbcFRBnqpnwGyfy0w46haPaZiP7+AJFx6vjsBwrEL0v/F06wbjp
DQwGIO2vDQKS4OKyuftjAQohAwoKasqMa4hOCLmcvCVvgmSkQ9a7GciKBYb2TK39
bFs61WB7D8WWv7/U3K/uVD4VDrJEdFFf7xA7KVQHyfcw7MS2YDDWqkM/D8x4U41Z
iKVpcJGspc9mN3sA6XVdtJMdut0gFSsL5/aqpAKpksiqeug/uT93mgSep3wDOJMG
wy9SWSs0cxjGCerG+SIy8XDKQm/hwPCYPW9olCCyC8MYF8aOs+S62/QGHD0qEJgc
74at3u8oomNbg3gpNnO0QH+xD860nCo+RUyapB+TJ09cUSLNljCVUVK4FSMWtYXL
Dil/6U/Oyffe/rPi3UWIWDqli+zGG+LsY/QlxoVtCX6+ncpVsU23G+JSe0kQiFtT
oo+ijt7bqMIGzwEboT+HqpsXsVts6EUusrs+1sNRpTee1kTXp38=
=P6Uu
-----END PGP SIGNATURE-----

--gaxeoruuk32fxboj--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: s3c2410: remove superfluous runtime PM calls
Date: Sun, 10 Jan 2016 09:27:58 +0100
Message-ID: <20160110082758.GC1526@katana>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
 <1450891169-13708-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hYooF8G/hrfVAmum"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450891169-13708-3-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org


--hYooF8G/hrfVAmum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 06:19:29PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> RuntimePM of the adapter device is now taken care of by the core. So, we
> can remove these calls.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--hYooF8G/hrfVAmum
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkhYOAAoJEBQN5MwUoCm2nx8P/0CH2tPviHgMPK3GDgrvR/eB
LXm66DzZaTqf4AW9cPxjqb5WMwl6Jy6OeM/1nz7K6m7dCNvhkGR1JlQTWbJbtiga
wpkQgLZzAoFYsWtlCpl9EYuomKahYY1RUyZkVyo2eMAPm6wQiMq8PsdEHhZrNKKP
QHoj26Y41nyQj+3Vm6oTDc11U3MDRWsMi0EgIjivQL+LIouhrclY8E3QQv05sERs
hvNpP1/96efBbt7KhWnt0Wj/pXViORe45Gpwk/mbZ+dF0TN0Qse51fjaKOU7+dMO
NGcbdUZxIviRdskxt+aArcxoOU+knZYHgNBPYHU3wW2X1ClyTnM0fGHCk7ZX6HyK
tg1zI3m9Ov18MhktH/u8UaCkRrNgNvTZgXnfRsxYTcEolX5rbxEjCZvAbjtNF0C7
Elw6y8M7Cf/wViXICCvMofFzMT81Pt25areOqS0kw+kimflfyqmjHbK/cOx55AU/
1GipXCt/m+e8AjXe24DdJQpoZRNcUHO+oo+oJTzpDcxyj6GP9QDSB2zQCOUZMELh
4sUMTpf3P4RrHx/jQnB82FkC7FQm9c7Y5D1fm7TPrZbsmrjnH3nTRy35A/ZiytGp
uhnsVwyVbyhjry3bF8EmlmRL708j2EVyD/5yxa+EXlYw01R9X6W3AlAsalhIYODP
SpN8H0a7XMjhb3KZvoqd
=wcRd
-----END PGP SIGNATURE-----

--hYooF8G/hrfVAmum--

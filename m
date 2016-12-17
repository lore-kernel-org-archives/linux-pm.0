From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/4] power: supply: axp288_fuel_gauge: Fix
 fuel_gauge_reg_readb return on error
Date: Sat, 17 Dec 2016 15:57:22 +0100
Message-ID: <20161217145721.6d6htvdt6edrhsxj@earth>
References: <20161214163853.454-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rc4hm2y4tusyxfgx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756275AbcLQO51 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Dec 2016 09:57:27 -0500
Content-Disposition: inline
In-Reply-To: <20161214163853.454-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org


--rc4hm2y4tusyxfgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 05:38:50PM +0100, Hans de Goede wrote:
> If reading the register fails, return the actual error code, instead
> of the uninitialized val variable;
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--rc4hm2y4tusyxfgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVUlEACgkQ2O7X88g7
+pr0FQ//WRumypN8SVhlsIDjzY0p8+bUK+d7txcCx17E7+Kg6tzCzjuku8ELi/CZ
kZ0CuizegP6dufne0zvvQnRH/BhSnKPzwT4im1xF8uvigdvEqnGERZvCqX3VxeX5
9gw7dBlbIL1Le9dxNtbgPgFu6N8QvBCR+moEjU6dFs5r/U4Dk3D+CzHYjHE+wW/h
mx5aURID7F5BQ9fVPz22YN9QQ+iLL6tFI6zdGMnKXoaI1qWG727gaiikz+tLuieh
gTeT7b5itN9pCV0Z+IxIbXQuAKlvGgNhndAkibt2EZTK6jEUjib9Shr+p6nIeLW0
6x5Pna/oaUJN2GAhEvcrdZtD39vlttQ+FRUpmwtrDt2YVxPGMaf1edXb/GOZ/L0s
uvGfy7QKVRjO7a6yui+uMzloc7ge+a3iqqGTVLclYzo0T7tjJBPTfdaM4UdjLliJ
h4O5aXQu47/xSZtsAkSJkwReMlvvoeAGLdiqqSD+gpG76u+i0/ulmNPB1d1p3kEh
krziRFqS9dvTkvMs1MFQml7vdpbinPI3ZNdyqxnLSxwffXAcGOYQD4rW4kEmnN6C
NJPyaefGfg7BrOw5hYvwXfbDnntqY+NG2c6gtE8qJX4Gl9kmKXYjsb87FSZehJww
VoWvahuIeO07UjB0vsharwXP8CidyWXuLDhgYN9RlsjqdfCEPI4=
=pZ+j
-----END PGP SIGNATURE-----

--rc4hm2y4tusyxfgx--

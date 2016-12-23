From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 00/12] power: supply: axp288_charger: Various fixes
Date: Fri, 23 Dec 2016 02:37:30 +0100
Message-ID: <20161223013730.s6iix2yz3wloq4ti@earth>
References: <20161221143657.322-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rrblydo4qivnvccv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756699AbcLWBhg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 22 Dec 2016 20:37:36 -0500
Content-Disposition: inline
In-Reply-To: <20161221143657.322-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-kernel@vger.kernel.org


--rrblydo4qivnvccv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 21, 2016 at 03:36:45PM +0100, Hans de Goede wrote:
> Here is v2 of my axp288_charger series, which fixup the axp288_charger
> code to actually work.
>=20
> This implements the suggestion by Chanwoo Choi on how we can use the
> existing extcon_get_extcon_dev instead of introducing a new
> extcon_get_extcon_dev_by_id. So this series no longer depends on any
> extcon sub-sys changes.
>=20
> I've also rebased it on top of linux-power-supply/for-next-next to avoid
> some conflicts with patches already there which Chanwoo pointed out,
> so assuming review goes well merging these to for-next-next should go
> smoothly :)

Thanks, queued.

-- Sebastian

--rrblydo4qivnvccv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhcf9cACgkQ2O7X88g7
+pqkfw//ZcrRTn+gl5Nrc/NlgpGxm9lnsbUrtyAMtTc9fKSGYcBpmpS2SXukJg0a
NYXGQVGjDqKf977CnxCi67sNQouOFDRru1X6cANCjUZr/y1Ev7J0oFGKH2xXKEqs
xYkiEme0J/VYPv28AxiGhb5z89YwKOmy9tYaaa5eZdeRESaZW32UglQU8R7N67ob
7yts7RCJlROIipBnjlfkDXe0nCGyR06tcQSAwx2VYylW3d/yltjm5g9I/14FcUAr
vGd0LS1VAj25cbg3jKglX0iQvC0KS13qk7n4AytYiTmYCIN+B2kEgVoXnZZMxrCI
mZdQnVxcDFM8nZSgjnyxtqXTapTKlAczLooL7Igkjrjpegu6PVu+dZd0hApTPjkQ
4+fjBvebqqpYXcuCqWD224oE/TgEXmXSofrH1vmdcw7jMbhtSOI/GnZgrvEGrfop
K+HVGrZcjupnTtWOIw2br2+IxqNCcHUoV2RSG/UPWVjVmunBZqm5Np9a86kXONEH
Kn4kH8Owz2eHHfxXCRbgI7Aqp1zRHLHMagfop+Oj5y+8N5QoPmT4yy4CSXeQGr7y
jFKj1B6CI+eFZEdFf255c85pJpfdEX7BWkAEfTovR+94zOLCemj2xdTRfHqbOklA
mAvfTDEgHV9OND+VPvzkGrfmL9x7TBpyzYcXDWrC2VoJ70Mo4eY=
=DzrU
-----END PGP SIGNATURE-----

--rrblydo4qivnvccv--

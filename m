From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: bq27xxx_battery: allow kernel poll_interval
 parameter runtime update
Date: Wed, 21 Sep 2016 02:11:14 +0200
Message-ID: <20160921001113.mbciuuse4lafxwq6@earth>
References: <1474342982-7242-1-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s36adj5az3zfwn5i"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbcIUALX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Sep 2016 20:11:23 -0400
Content-Disposition: inline
In-Reply-To: <1474342982-7242-1-git-send-email-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>


--s36adj5az3zfwn5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 19, 2016 at 08:43:02PM -0700, Matt Ranostay wrote:
> Fix issue with poll_interval being not updated till the previous
> interval expired.
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Liam Breck <liam@networkimprov.net>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>

Thanks, queued.

-- Sebastian

--s36adj5az3zfwn5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX4dAhAAoJENju1/PIO/qafCYP/0eqFkyRP8+mr4r5/GmyLSXL
Bgl2/L2SvdAl6g9KYY0BW3F9l0Okv6eVYR5AFTs8n0BwnSyktR3tjeqNtuaEnpU/
1nQV1F6S27ZUscICjk9S579b37X2+DxiBH5OR15myyJ/WI4FRtRRTgTj8Qow/CbX
Qv94yJvOHyZ834B2M1UkLqIZ7fe8hT1oNHfm78vvFJIRx9VhWuT4YdY8ofxHrImG
Cb+PNl3MsDNp+D8kXdUyRHKJqw/JWOrgJWLVkGedN7T1GjB1yF1lLFigiqioj71i
DKZGAAEYM8d8r4x8ytnJdWJ3noiAB8EEj+F2KT5Zbqvoo5Rn+Q7sx2Y8UrwOPdbh
V7W2A8BVacqSFxVpxDwgdBxYAxVnKdOLJ8eqw3Tqm3hh9d6EXIjQNfcqLhbxu2Ad
dm9kQj18WIY032oVHtCpOsAzrpjsxjMOVxUiWaUx3R8414qbyiVPNonEoIfTtq8y
hwjj3le3TlljfpxatDDB3NFeaRsSnKhOrIDIVjlkb5y9pw3Ih1kfW2WAy5R1veh5
it5tx0jE+DsZbdbOKiUJLBoKbifvZWCKegmIMu4i1gMGZvQzWeIii05k7k+6LbnZ
jVhf4dlSYca0XDuih16hrao+r5DosM5kZwUdm8nhjniK3NsbTfBR9PGH/3iomYy5
IvBOM7impKk2yWz3pnu9
=fLmT
-----END PGP SIGNATURE-----

--s36adj5az3zfwn5i--

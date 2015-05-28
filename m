From: Sebastian Reichel <sre@kernel.org>
Subject: Re: randconfig build error with next-20150528, in
 drivers/power/twl4030_charger.c
Date: Thu, 28 May 2015 19:57:00 +0200
Message-ID: <20150528175700.GB31619@earth>
References: <CA+r1ZhjGZqh0ZOdkne3Pf1Ht2Vyf3+HzFPzrqVPDMRfiT6prxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47715 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754014AbbE1R5Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 13:57:25 -0400
Content-Disposition: inline
In-Reply-To: <CA+r1ZhjGZqh0ZOdkne3Pf1Ht2Vyf3+HzFPzrqVPDMRfiT6prxA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jim Davis <jim.epost@gmail.com>, NeilBrown <neilb@suse.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Felipe Balbi <balbi@ti.com>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

[+CC NeilBrown]
[+CC Felipe Balbi]

On Thu, May 28, 2015 at 10:05:55AM -0700, Jim Davis wrote:
> drivers/power/twl4030_charger.c: In function =E2=80=98twl4030_bci_probe=
=E2=80=99:
> drivers/power/twl4030_charger.c:648:23: error: implicit declaration of fu=
nction
> =E2=80=98devm_usb_get_phy_by_node=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
>     bci->transceiver =3D devm_usb_get_phy_by_node(
>                        ^
> drivers/power/twl4030_charger.c:648:21: warning: assignment makes pointer=
 from i
> nteger without a cast [-Wint-conversion]
>     bci->transceiver =3D devm_usb_get_phy_by_node(
>                      ^

This has been introduced by the following commit from Neil Brown:

power: twl4030_charger: find associated phy by more reliable means.

-- Sebastian

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ1bpAAoJENju1/PIO/qa3wcQAIRY6DOfWTSIWlHTmvsTo8mF
pE4iKR+eoCDvhgex8O1hMn/Sm9mBjo0SDYg4AI0wIqGWuVNCVksMhptTxLD4Kwym
J2cm0cs/p+UstN8NWUK18PE1QgsgFiWbOpoHUvQSD8l8gbXh9K8/wT1ogytF5/Id
bk8lEv4LANKX8+IMwqmQC0QICgDaf2VbKkuEMkDQrU2JRrwycQGXnkSA0dIqEHAX
G90SA1SHydjBu9Kghh/K5/r7hitD9mh47VTHHtJv/JZHjwchRktpOeEpU+ENlfBM
V05R5K76o5o1b5G0QPeRWKyX+bK6oMurchThs3brFvg1vrsGCRsh5zCWcVezjbzN
trVoSJ1GG7pVStIbXbZXq8LA1faG0/f4iWosbM4Z1rG5SLrlc7QUCIrv9VYyci5w
Hpi8R3KvQGxAM6OX5tBSrpow/GyLeabcy/a3fDPLMIZQGu1DK6J3vwSk0DcuLZ6m
MYElNmoYfR6QXheaV+1US+FuzNv9x0mwbhHep+FNwn4Tkb30/MjcdBHXYNjqwD3o
3lEicLaW0ckHDYlXDudytWKnqfmV6guA9C8mmPsJPBSNg3F+AbtLW3e/04/4DOaV
jrZGd/ieac2LTY7BbCfqo+BBZ17Ca89qVLsUsBMh8B1lGFJEpF3qi0M3tdBNFGl0
p7fkCCfepbIfMMIalikD
=jE9L
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--

From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] power: reset: Fix module autoload for some platform
 drivers
Date: Wed, 19 Oct 2016 05:33:46 +0200
Message-ID: <20161019033346.gnoqbrwryyctpvgl@earth>
References: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgsoclcynkf2djbx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754579AbcJSDdv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 23:33:51 -0400
Content-Disposition: inline
In-Reply-To: <1476729375-17526-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--hgsoclcynkf2djbx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Mon, Oct 17, 2016 at 03:36:11PM -0300, Javier Martinez Canillas wrote:
> I noticed that module autoload won't be working in a some of the reset
> platform drivers This patch series contains the fixes for these.
>=20
> Best regards,
> Javier
>=20
>=20
> Javier Martinez Canillas (4):
>   power: reset: at91-reset: Fix module autoload
>   power: reset: at91-poweroff: Fix module autoload
>   power: reset: syscon-reboot-mode: Fix module autoload
>   power: reset: zx-reboot: Fix module autoload
>=20
>  drivers/power/reset/at91-poweroff.c      | 1 +
>  drivers/power/reset/at91-reset.c         | 2 ++
>  drivers/power/reset/syscon-reboot-mode.c | 1 +
>  drivers/power/reset/zx-reboot.c          | 1 +
>  4 files changed, 5 insertions(+)

Thanks, queued.

-- Sebastian

--hgsoclcynkf2djbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBumXAAoJENju1/PIO/qapc0QAJbvEkNNyqOslWkHCPBjhVoQ
Wd3ILr9OW/SN6y+dVZtzIuaLAIGWjbzpAz2rj7pDsJDHfjKbghWrzkj29LumMaBC
tM1SGyT6TlVZsIUaxGpeFTdimhkC8lz74Q7iPUHwGjvmQv75XJjzAD74e/HNtv8E
PhXJnsvAjHaLXJMVhy1mITY5M9hyGnPEX4nnaxa/map5Ubji64X4zYv6xgBjJhEJ
FAGkKObQDYhWXt+m9MHdvK4OXG8Gr+h/AwgniaGMQQKGNf7c5gmhYs6ayRGAXTle
/fZQEhsbg8sDuqyeR2qCA0IS6l0H6yvq1DU3U06ZWxPrJgj4SWBBnMf2Y8spLdvY
cNX66EpuiCJHqta3GwE5+wcydPsiJBbT2OsndHzgRhrBDHQZvMImAYlzud/8Wc+H
LDE37rVvfHMG1bqhgEjrQGB3s9yzIOXcyCFpmiFQncyyCJUAaI0jPksEprQMYnTO
C4GqR3DSQ3ckCP4j+tF38Fw5LQuLt2Wc7zBTzMRYJulJGT/ib+NLvpLc74WhHcdI
qUgSR4tirIy9SbO0Yuxwik94O/VLoyeimX87BtdiMdv71vlNsxKRMfWlIVRhEmaP
g2JTF8Oh9TQFvHvLZGoWgNAXtTaUa3a0S556A6Cjezu/P96sJfdWyoX39D9zW+am
VaNm8zQpYtiuFbghtMnP
=g1WA
-----END PGP SIGNATURE-----

--hgsoclcynkf2djbx--

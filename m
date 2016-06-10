From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 1/2] power: axp288_charger: Replace deprecatd API of
 extcon
Date: Fri, 10 Jun 2016 03:46:43 +0200
Message-ID: <20160610014643.GC5848@earth>
References: <1464687280-8155-1-git-send-email-cw00.choi@samsung.com>
 <1464687280-8155-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45310 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbcFJBqt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 9 Jun 2016 21:46:49 -0400
Content-Disposition: inline
In-Reply-To: <1464687280-8155-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, wens@csie.org, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 31, 2016 at 06:34:39PM +0900, Chanwoo Choi wrote:
> This patch removes the deprecated notifier API of extcon framework and th=
en use
> the new extcon API[2] with the unique id[1] to indicate the each external
> connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
> - extcon_get_cable_state() -> extcon_get_cable_state_()
>=20
> And, extcon alters the name of USB charger connector in patch[3] as follo=
wing:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>=20
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of string)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with enum =
extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/power/axp288_charger.c | 77 +++++++++++++++++++++++++++++-------=
------
>  1 file changed, 53 insertions(+), 24 deletions(-)

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXWhwDAAoJENju1/PIO/qa1vgP/jYfFt7+bSnpcV/4CORiFnMa
D3uVd6uTKYnMX2DynRXkFtEWcGGz8roBZYOMQN128nkhk+ReYb+gfVxRM3fueR30
0JKb3LHKTMRCHK2zutKxQUBFUhGNlKqLSAl/IgNW5kSzK8jdIsI2bkRjy36wyLFY
Bf12kDy9vvZL2Jg+UZy/jH881ZX9cj4ItSqozEC364FTDcHXtYbkXsxO+nzI9ESY
tke37pb6IR7hI6vSdQ6ASqVah+Azsk+pUBubo8uPhyp5SnENxEH8n8X9aBJfGzVn
nVCYiuAAin48RAMoQ2YsHGGCX7DAinG7csYoU3ZS9IFVLvRjUPlLlinbhVLBaDW0
bfXX/gxKIrtyzyzE7hAyRQfnp668sR6B3yY8GfJMplmp1+Tq9qI/4wZl9QOk3m8u
GXXx/Nr2vyfhtL5mn7DnbNMvmeSmjSJWWQ9uaS+NGhXN2tPjJfnl2tdSaZDczVeQ
Y4+OC7vpuX239/oU9jVbaavkOszFbFHoDxvtpPnIgqtuh2/muSPWZZQ1joEyXRqJ
3WF6/93KTyqsqeaq1+aNc/v2hAMyTstaWykz2IN4s3gjBB0E9VtRhzE8jHn18dOB
V8Q0dtHlIyJ/9O4VUTdBY0RXtEUdMirUdLZNMHKRc8VmgFVDHCvbcRsRmWVpvlIp
gkVjcQpecjAkm8C+GAaX
=rvnN
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--

From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH resend] power: Use subdir-ccflags-* to inherit debug flag
Date: Wed, 25 Feb 2015 21:40:02 +0100
Message-ID: <20150225204001.GF13695@earth>
References: <1424707728-27716-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41372 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbbBYUkP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 15:40:15 -0500
Content-Disposition: inline
In-Reply-To: <1424707728-27716-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Feb 23, 2015 at 05:08:48PM +0100, Geert Uytterhoeven wrote:
> Use subdir-ccflags-* instead of ccflags-* to inherit the debug
> settings from Kconfig when traversing subdirectories.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, pulled into battery-2.6.git.

-- Sebastian

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jMhAAoJENju1/PIO/qaoyUP/0aVP8iY0rbjgpRDIoEusUv3
OyPpq+I2et4McSO4k8wFzL45dz9H8xhvdCiz9C2D6Dmd3bcmxkdzyMJxdDp5makJ
FUFVMu/GJu9mKJWEGVjp1rUr9hn0T5sx4W10Au2FPVuZl6MAj2DHSa9QWlagcXVw
RhXuy4e8Ou3HfCFoYYgyZyCqwOIZp6RcD0l5ZV7ExAJqvT1sq/5CCsFoq/CtW2IK
ylMB3jOaON8IxNo0wBJRUgrbiFS6NxHG4KYcLzn13doGJp81QEYslHK3lcsAak8L
tn6ScaIxdqwL1M8SJTuyQPSIKG6ZHp/uQyXYQOfOdcvjqj6ytgtYq0NeZusmiQhA
Q2Xt0G6bC/kqFvwOSMOwey7Jc9K1JpD46c/Q+rXbWDF0MIU8R8kKRVlgofZVj3Cz
FUQJa0zXmW4IwWVgafbxBLfcRWh4INWnvoZBLAZepGMyFsZ7CyS80PnJlNwmFfPu
uQ0cXWq0ofBnPwBk2o3j/7TpdyMECdjinet+ymL8xt02O8HoxCJTxKkGETg4C5GT
xnvnizsZM7rdsMLADQxiu95g/teaYyt2kh3E9vgbMCDnTgsFWsttdEe82qXEjT/g
OTNOU2wAMVNHJlMnWzIaBatnGYkrsqHZ+TLw4Mb6EoZlubnX4WYgZzAuCDuwIYbM
Ag7X1kt2AYgsyIkBcHmA
=Iyjf
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--

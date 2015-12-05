From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ds2782_battery: constify ds278x_battery_ops structure
Date: Sat, 5 Dec 2015 01:41:52 +0100
Message-ID: <20151205004152.GC22936@earth>
References: <1447440094-10105-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34402 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbbLEAl5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:41:57 -0500
Content-Disposition: inline
In-Reply-To: <1447440094-10105-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 13, 2015 at 07:41:34PM +0100, Julia Lawall wrote:
> The ds278x_battery_ops structure is never modified, so declare it as cons=
t.
>=20
> Done with the help of Coccinelle.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, queued.

-- Sebastian

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjLQAAoJENju1/PIO/qaRzMP/1pR2ms5h8ha+IpX1Pw/hqk+
gQRVoQRIlJNPEN+Nx+GqX9rzm47cdWe65Ao7ZkaEvW29s00yeF0OKU7FFdRPZnxx
YD+PsKEghGrxdL4hO6jB3qk5aG6EZhbXH9+jM4LLwCSaJ6s9yJY5vEOTPgEZrlgf
RXkTqB5N9nLG7OwiMveW8shIgH3SBUpR4X1/YBm7jRJ3JAg4USDhcC4GXU9NdVbr
COmiU9lofljzJOKpPrkrXNT/YSVb7QLYy0HArnIMywWMQik4qvPv9T6L4T5EvjXg
HP0jSqbOxGhL9hlT7L+1w0OPDomdA4E1Am3oSQSD10+ZBqj8x/HhhH7hBLRJ8ik7
mXSRgFtcOCBxicrdtoTLz10D58uWvLWAXuz2ZroUYMUs6y7+7A8T/ZjdswKeDPue
Z0RqNGjX/DajC2Hg1UribaNLZDw0Dxkv5+7MDmIZoPZfL4lVod8zMHkbYGCwrOTB
O/+rFXcrCv6MpYNSa7rWBqr90bw87mvn7AA5uMPSxcFNWazN8ufiH3Jjio8ckcF0
lxGaN3ghC6mmOwR1K8tW3GHBBdjH1moyop45xFBE+OOLecXWKj6puufszHixM5ws
YpbEpPqDzmGWwtzioD4r/vqoeIFCbNUwMnZVk8xpKOXDtwhVzuegfNENQDEMoTpR
VO82irChw1qCgD+uKK41
=A56Y
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--

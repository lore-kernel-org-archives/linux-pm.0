From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RESEND PATCH] power: supply: sysfs: parse string as enum when
 writing property
Date: Wed, 7 Jun 2017 20:30:10 +0200
Message-ID: <20170607183010.nsz6pd7gl32dl2md@earth>
References: <1494883275-9867-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nttzdjs46463hohq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbdFGSaO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jun 2017 14:30:14 -0400
Content-Disposition: inline
In-Reply-To: <1494883275-9867-1-git-send-email-david@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--nttzdjs46463hohq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 15, 2017 at 04:21:15PM -0500, David Lechner wrote:
> This fixes the TODO to parse strings and convert them to enum values
> when writing to a power_supply class property sysfs attribute.
>=20
> There is at least one driver that has a writable enum property that
> previously could only be written as an integer, so a fallback to writing
> enums as integers instead of strings is provided so we don't break existi=
ng
> userspace programs.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks, queued.

-- Sebastian

--nttzdjs46463hohq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk4Ri8ACgkQ2O7X88g7
+prP2Q//bNbq9PuG3X1ka16hpQqW30bAPVDK6eyU7R7XX0pQ4xV3kuDc7If4KswR
71dc69HNOGkGGdE0H61Wmnev/n22RdoOIQhf1Cl7u7ag6kJMNQfLr/DTpmo7Rhbl
wWFCGISMceQMjD8skAhRyDGOsw+jQ8TDNta49xQ7ttVjFXgNvQSlhdT2L39rACg1
8CiRjEeCOnI7zDDwPAsZXBTcYErCQUZFWcicAazO9cEUMQPWoD7Ud8wwTZRroJqa
UsToT4z+6iD3FRYmdPjGAHB0yjR/PWavvxNQs+uDt1fy+FkFJFFWH2FDcajaMAKM
09OkYWxXOiUIB1NmyR8kaH+Vx1bpKRrSXuAwgHc5zKi1OAfCbBtzZMuxcDDPI/Sl
61tCDfUon/0VxGbR3jwih6n0S9lVFAtvg8qD3qsupE44oTPkg7v0i34uyV5TFPbI
g0Dw6kK+rVhh2ji2cY5xtoiHUaVbRjWimcaUBV6xnxlbPNdizCzPct7RY8AXHKqy
Cpx8vICMtl8UujXik5YqH+J0n8d699mUQ1xHpeLUaaHmJ+3ff8WjDL/P3qAb3hxV
LtxMVo7csuAfWjePIwX0rGZwKv8h91MUgZHTUJofr43bBFZtgj4g4oAkDeJYkfuj
VO025/OKbtvL3R49QIW8TJe/H2CltUYEPfsD+Bf7GnT8K9FNc7c=
=t9VC
-----END PGP SIGNATURE-----

--nttzdjs46463hohq--

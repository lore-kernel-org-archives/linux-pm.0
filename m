From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: gpio-restart: increase priority slightly
Date: Tue, 2 Jun 2015 21:28:51 +0200
Message-ID: <20150602192850.GC13930@earth>
References: <4893951.aWdOo6F7tl@diego>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54161 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbbFBT3T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Jun 2015 15:29:19 -0400
Content-Disposition: inline
In-Reply-To: <4893951.aWdOo6F7tl@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Tue, Jun 02, 2015 at 04:48:50PM +0200, Heiko St=FCbner wrote:
> gpio-restart uses a priority of 128 and currently most soc-level restart
> mechanisms use the same - with some exceptions even using 192.
> But while the soc-level restarts are provided by the soc itself,
> gpio-restarts will most of the time be board-specfic and be used
> when some special board condition makes the soc-level restart
> only a second choice.
>=20
> The problem at hand manifested itself on the rk3288-veyron devices.
> While the soc-level restart can sucessfully restart all other rockchip
> boards I have, the veyron devices use an external restart mechanism that
> seems to not only reset the soc but also some external needed components.
>=20
> With both restart handlers having priority 128 in my tests the soc-specif=
ic
> variant took precedent in all cases. While it could restart the soc
> sucessfully in all cases, firmware then got an issue when talking to an
> external component, resulting in the device being put into recovery mode.
>=20
> So, give the board-specific restart handler a slight push and move it
> to priority 129 to make it more important than the generic soc-specific
> restart-handler.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Thanks, queued for 4.2.

-- Sebastian

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVbgPyAAoJENju1/PIO/qaxEAQAJl2UaQd5XltMJjWQNQZiiR8
sNFywdVUj8kHQnqB9uMAQQm5Sh51Z8T6PJqNXl75XpkhKccJnnSfHd2sdgD+uJF7
US8YsdJ71wGBCtRF9mydunWm+WFKyB69l73KJwNFfSbbrDv0HoLc30Mit98Dz+F/
uV4RNFFzX69dJhXHhUnJxuZoQuWEqq/FSh/sYVh++zLcaG7Lfm1EsljLIxpqf/uF
xCy9sDNKjsLmtaJfMODqpoNAngp35rZocFsIz1kCoxVBOzDnx7pXDuc6Ex+M8XjR
lCli7NO5lIKuUKAPiTqse93eaH9z3tDxTtKbcFG9GlolHrNZfNTYRME+4Hqg+m8h
sYWzSXCopZkummC7IeHG3SPoz3xqVnicXXpBUFQF1w3XW3YU/Vg8X1VIJzCdFaUs
o0gzTQhMTW3u0QGSGhyWEzqJoiTlHwPTplFHoSJZAbcRj6WJyhBY9GDob853Tlqn
GPoQmwoVLYDIXfbd3hIk/xuFVTPbpZlYnAvThv2JiVSlRGi15aQYuPAqWSvAlAYk
srNB0pG2Dr5yaTL2oBdM1u7uEIallogbGoFslsHuX2mhRYGQ0IAMIWOyw0E3iBhf
sovAMAjSP5r7ItxpYbcxzTrk4ekVXLuYgEEMOSRBiSxESdD9rozmQG7W84ODwfZM
77x6XSLa6eC3ZzGk8BTK
=rS5w
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

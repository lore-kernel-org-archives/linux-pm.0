From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 4/4] power/reset: at91-reset: add missing of_node_put
Date: Sat, 5 Dec 2015 01:42:36 +0100
Message-ID: <20151205004235.GD22936@earth>
References: <1447884254-26336-1-git-send-email-Julia.Lawall@lip6.fr>
 <1447884254-26336-5-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34461 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477AbbLEAmk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:42:40 -0500
Content-Disposition: inline
In-Reply-To: <1447884254-26336-5-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>, Jason Cooper <jason@lakedaemon.net>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 18, 2015 at 11:04:14PM +0100, Julia Lawall wrote:
> for_each_matching_node performs an of_node_get on each iteration, so
> a break out of the loop requires an of_node_put.
>=20
> A simplified version of the semantic patch that fixes this problem is as
> follows (http://coccinelle.lip6.fr):
>=20
> // <smpl>
> @@
> expression e,e1;
> local idexpression np;
> @@
>=20
>  for_each_matching_node(np, e1) {
>    ... when !=3D of_node_put(np)
>        when !=3D e =3D np
> (
>    return np;
> |
> +  of_node_put(np);
> ?  return ...;
> )
>    ...
>  }
> // </smpl>
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Thanks, queued.

-- Sebastian

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjL7AAoJENju1/PIO/qa++sQAKGAm9AKyxpeq6va9JQfbQfi
CQ+dUcMao/zMkxpmPEE41SWaiEb3bXqXuTEEnez8k4Y9t/aKINweZQGByhIzEV+8
XGPL7lR8+Cink6bUUF6konAm+tE1pJ7JqQoepTPMzvpjH0pL0pskcpP9L+da4d1y
L6ty7vjT6TXtbj9zdbsIbBs9ms7kNNmurEGFD4ExvLvkEeEM0ieR1qDy2EamF6a1
XwQcxsT8ci6F+UBSNKLxIsSN2TRr3/+hYgkkylzwfQPBrg304HX8pW52GTT0dX7L
ggUaLBVbLQhBVwHuZIfPRr4fBkA9drLYh2QepKN7xUrWbt9qTAt9+TtVBMZIzvj7
+0M+YpXKJFEJuDu0IuBqcRzDwvo03I79e4cUjZV5NMNiT9wPet3kUxWd7UZQLFjU
4RipWrRcmbXc/WBDhpeX71d7gGBoybYoR4LkPc2GxLjuEMW5TAjYYh023RFjhE0k
sXvpcvk/9auzXPaZO192/tGToyF2wbonE0gxQiE262TWFgqLEX+smO0Dt7pZVLPg
GPV14ZsAwx9UNPBwY0txWgcmTVTAR6Bu33zBjIhmTvtNjz65Kd/qorp2yHlW7CC3
K1vnWapQsa4uq7y8BbH7n8mcL49x8HzKoWsFy9XzpUHOVPW8PrVOy8V2ixtianpH
t7K2yHI134eYDgWmGOox
=pr/g
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--

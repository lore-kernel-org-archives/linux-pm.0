From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 2/3] drivers:power:twl4030-charger: add
 INPUT_CURRENT_LIMIT property and make it writeable
Date: Mon, 1 May 2017 13:15:46 +0200
Message-ID: <20170501111546.hmc7evtz2juyg5ur@earth>
References: <cover.1492194356.git.hns@goldelico.com>
 <ed229ae8e6a4a9bd040e389d101b5257296d54ff.1492194356.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="syq3w3bwqbrrfhwn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753930AbdEALPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:15:50 -0400
Content-Disposition: inline
In-Reply-To: <ed229ae8e6a4a9bd040e389d101b5257296d54ff.1492194356.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org


--syq3w3bwqbrrfhwn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:25:56PM +0200, H. Nikolaus Schaller wrote:
> Currently, the twl4030 charger defines its own max_current by directly
> creating sysfs nodes. It should use the input_current_limit property
> which is e.g. used by the bq24257 driver.
>=20
> This patch adds the input_current_property with the same semantics as
> the max_current property. The code to manage the max_current property
> is removed by a separate patch.
>=20
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Thanks, queued.

-- Sebastian

--syq3w3bwqbrrfhwn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHGOIACgkQ2O7X88g7
+pofoRAAoLRTxI4e4ad4XQPR+FbF782NhrLI97EJVtbs7GwXrd95bp9XYRkkPXMg
zVp0cu1QvbsyMZewCvUwXs8eWamISd2rYCvzlF43AFjqyi4b2mos0OGyCBfa6Wd7
ELUKgH26vS4jMPl0teNH9QTrZSmyd+MDm865pm6uC5A9HDWMqXlkzjnI8XvHpWIg
tdrkZjh3iUjAKd8QhkGnPp8pROj+O8sadzcxuowHAke1w0ck379IqEaLYSVxFL3w
5MrFGb+LUNjn1D5RgGv6GZXcuNpYhYQM757YR33UzuOhmhkXxuoiXlY1uCl7ZvOj
p6r+31Z7UtG+Yo3tq1irReLfJ7fQl0F6WiWARTUkmb4IDK2Baum7dQJ6lbMT2QHm
7WFcdQ8vgHuf5HaWomIp941Ywa0sQgJzie6eIhbacS03PP+T4i18euErDBtUdI7U
UKGbiz5MHTVNyThQOQQcuehWJxEskEvtJM9KUO0WJWKlNoqpHC+DzS8X9qjO9FKF
sIxNj7L4MXcwignIbutDK9juUZGLp0jrGIZsCNGKIi6pEOw9n74CQuEz8aYTR32c
LRf9R7grsuL91+Tr5bccr5jTdW6Oz4Grhy6FwCcrHkI/Ffdr13oQZztv4QoFArsg
AcQUu4pnQoQKx6/yeCymSv2iTiIA9hi3tB2AUux/24hahtnPv0M=
=eOdN
-----END PGP SIGNATURE-----

--syq3w3bwqbrrfhwn--

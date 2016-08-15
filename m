From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 4/4] power: sbs-battery: Use gpio_desc and sleeping
 calls for battery detect
Date: Mon, 15 Aug 2016 23:08:51 +0200
Message-ID: <20160815210850.hd7p6blg7rbuzd7d@earth>
References: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
 <1469414580-14121-5-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lj52qkd3lb4ivgey"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49008 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932115AbcHOVJB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Aug 2016 17:09:01 -0400
Content-Disposition: inline
In-Reply-To: <1469414580-14121-5-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org


--lj52qkd3lb4ivgey
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Phil,

On Mon, Jul 25, 2016 at 10:43:00AM +0800, Phil Reid wrote:
> Switch to using new gpio_desc interface and devm gpio get calls to
> automatically manage gpio resource. Use gpiod_get_value which handles
> active high / low calls.
>=20
> If gpio_detect is set then force loading of the driver as it is
> reasonable to assume that the battery may not be present.
>=20
> Update the is_present flag immediately in the IRQ.

I queued PATCH 1-3. Please send a new revision for PATCH 4 (this
one) with the following changes:=20

 * add the correct gpiod include: <include/linux/gpio/consumer.h>
 * rebase on power-supply's next branch
 * remove battery_detect and battery_detect_present from the
   struct sbs_platform_data and always use the gpiod API. It's
   data can also come from platform data, see
   Documentation/gpio/board.txt and Documentation/gpio/consumer.txt

-- Sebastian

--lj52qkd3lb4ivgey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXsi9gAAoJENju1/PIO/qa7OYP/ix3K6YO6ua3uFfZNv4cQ7qo
xtrFvHa6f5mT8YPZ0bDoEawK7pVS+nDBR5n/G3vExKILUFgH6pgdAAjZ4YW5fjyP
unQJCjZfTMPZp8yZWzHtcy/DOFvvFjQRR4TpDQsYNbsXpvz8Ll/7JkYAQ/d2uv/3
B7ECE3mhnzXdh9qQdZtXurhWNd+ePJHljD1yVcIuAEnYPORBoPAx0Lxw8IzMHbWH
kyzshWdZk28qF3phKhGVSBhtciZMjHL/0eKTfa4It+j44+/H9StdXgvk5VVwjBCl
TjptOuvQEuOphHBEVjDwi1otY12XjsMJBwv66VYUrjwBMzG9od8D1UREuI09DUXX
txPyLCiH/QYSMX8ni530tqrPdBaEUiYoth+wMkYNWX55Q2E6UwTNatjFXizuJeL3
7lBk1O5AQXTXa50xtwlSNkODRBorleohOIl4j4J8MQenjuImlG83u+ufmqUD9aX/
eRvXcm8+RQI53EvjAkf9W6/Vhq6Lsw/e5McRtdVVi+TcMCajIP7/mJWrMzCIaQ5B
NSN9yixJdbCJfmXp0JchAS3W3lx9Ivo2HxGkl9pydAWcXlwkJpKE4u+tMks07x1Q
s3QoNumw42B0GyOluqgRfa3qIoL0Z6wsuUey7PNM08NOWWRUSIoY8oeb+T3DjUwr
S4XvkPy01z0PpO/gtIRv
=TuXC
-----END PGP SIGNATURE-----

--lj52qkd3lb4ivgey--

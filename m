From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27xxx_battery: Reorganize I2C into a module
Date: Sat, 5 Dec 2015 02:14:47 +0100
Message-ID: <20151205011447.GH22936@earth>
References: <1448297631-8916-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35913 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752806AbbLEBOw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 20:14:52 -0500
Content-Disposition: inline
In-Reply-To: <1448297631-8916-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Andreas Dannenberg <dannenberg@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrew,

On Mon, Nov 23, 2015 at 10:53:51AM -0600, Andrew F. Davis wrote:
> Separate out I2C functionality into a module. This fixes several small
> issues and simplifies the driver initialization.

Thanks, queued.

-- Sebastian

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjqHAAoJENju1/PIO/qacoYP/AjaNDN459WecPrGBdqNECKv
TVrw+EpdTkkDLU+TbqexclQojWt5m1SjwmOPz3Pw9Csr4Vo6eKmqJqesEFQ8V/CJ
PVzag0e8aFPJtqOtSa7XWKg6WQ4/K5IIdvaC5rUWLxvTSABMNj8jqhkZeecqvGDu
SLL0nJFYMKpQesdQfKCV8QXjomvvtDo1Y9w+IsC4i22dcl/Jfle6OQehZrckTpmu
duFvnhG8oCczm4SbZaYNkylEgkkfqEZVvHCI5qRLZFZyeE4CajR7lMAbH+R5rnPt
rjQ0x7M3bF+0qYR6l7PrewIKXNjT91juzrV2LpjwMmg14VV52tiYot68yPdAZMuP
+smzO+O+9DGi18AeV5PhNuhuNsoSkmkhw0cCnVp3p9twLuOs8bkE04Qkbx2cgUVz
/pkougf5mu51zPrbx5VS5afux3sUgp3ZP/7oOJMwtqKgJ7raTxOgNItIZAIR+L7k
HBpOnl6UnorOdz467DSaS6Wp4F5O6ZmUKEaI4m3gZBgxUJsrBo+4IfEhp3FV2Smm
MWOaiptDQHFYG4WVtSSSU4IMvSpRmdX872KXCPjnJdB6Vvyz3xX4K0BRdfkZaXi/
VVfkMGcZRFHPl49JMXsrArjjljT39YvO6X9cn5i1905pA+Tq5x3R2Hi/wqg4Tzzw
zBa686E+qZC30IvpfIvn
=3XW9
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--

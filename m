From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: charger manager: refactor return
 statements
Date: Tue, 11 Apr 2017 16:28:29 +0200
Message-ID: <20170411142829.ymplbmjbqswqxin5@earth>
References: <20170329151357.1841-1-andi@etezian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktahkoelamnsavcv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753304AbdDKO2e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 10:28:34 -0400
Content-Disposition: inline
In-Reply-To: <20170329151357.1841-1-andi@etezian.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andi Shyti <andi.shyti@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Jiri Kosina <trivial@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>


--ktahkoelamnsavcv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 30, 2017 at 12:13:57AM +0900, Andi Shyti wrote:
> Some trivial improvements on the returning value of the
> functions:
>=20
>  - remove unnecessary goto labels that just return, return
>    immediately, instead.
>=20
>  - do not initialize when not needed.
>=20
>  - return the value from the calling function that fails instead
>    of politically choosing -EINVAL.
>=20
> Signed-off-by: Andi Shyti <andi@etezian.org>

Thanks, queued.

-- Sebastian

--ktahkoelamnsavcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs6A0ACgkQ2O7X88g7
+pqFbA//XsGV+GlMJpIutCpQfYfLpmKuKqFnKcboRTMmtbzdScnCDIh40gf5mx38
JomomwibjsCrn3HYr5bZexZmqpOsAmaiMwnydkCzgYFOO0ZBiLimGl0O1oQrbB8Z
G/sY6b5K+rhF6d6kaf2PhPwfmpa+loqPxRmjKd0AIvvQ8FO/8nurA3dtq/8ensRT
+0qHZUuc1hPYS88+Khm998uR3ua14FpgjkBya+KkwqMDLScEp2EG5S9Twi9h8XOp
uIFfq8ZqC4RCLONp8x3lNCJqwfg+2UnsiVz6/skP27c5jbbxKVn2f9PFlcW4XCXv
op/f3Q0z/g7Il+cXBP6g+d6W53Cz3GtBQeB7Y14WDxvZsscoLtnjL+8kV+IP48t5
2fJIgvT09Ne78Y1ZivsAQBDPa5aymxEHLkb29Yb2GTxIptd2YTQL64iDGcJT88mI
xDE9/hV+i8RVo47/dNAxYjzFnl6pXL1+3cbN6ZtUY0FZT8sarTjCsP67yiEzepgi
bjwFVF34kRWDwVqSYtC4MjD04RhGNsrasnngT2iKr01kugFwpeocZCDG/2l+wc04
DdFTNqLbJt/E9ZgFfYMSE+w7h5jMTP4Psrhc13n9rmO2smqEdCFB6A7qZ2Ql+f/r
WtPUwDhLtTa8L3Ums5HK3x/dqDTZn6KmROFc9nLsnzqvt7xmwsk=
=cXIZ
-----END PGP SIGNATURE-----

--ktahkoelamnsavcv--

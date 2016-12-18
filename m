From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/7] power: supply: tps65217: Support USB charger
 feature
Date: Sun, 18 Dec 2016 13:28:29 +0100
Message-ID: <20161218122828.tecf7sdwyvqerw53@earth>
References: <20161218025432.20780-1-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="um6qvvvccb75yccj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753418AbcLRM2e (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Dec 2016 07:28:34 -0500
Content-Disposition: inline
In-Reply-To: <20161218025432.20780-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--um6qvvvccb75yccj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Dec 18, 2016 at 11:54:25AM +0900, Milo Kim wrote:
> TPS65217 device supports two charger inputs - AC and USB.
> Currently, only AC charger is supported. This patch-set
> adds USB charger feature. Tested on Beaglebone black.

Thanks for your patchset. We are currently in the merge
window and your patchset will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next-next

-- Sebastian

--um6qvvvccb75yccj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhWgN8ACgkQ2O7X88g7
+prQxQ//Q8vTVDlU+k4udyW87jrQhVLioKxE0D18odKXg1teujfZsqe1xWlQGt+N
P3eY2Ut4XigPekWpDABnZAa9pWu4gNMFeteNe9xmdzu3Eg5nghhn5PYeEfrCuQC/
hit/ivpiP6dpZJ5o5DOOuFJyUz51OFsMEpThNTCs+sSXSIUuYO7ppA7Nb/7XYpVe
FT3MH1apmsdcJj0b92nEU+bAhnRqdV9p0hSwOXNPneJpQzoI3BIvQngNJmH5cpLS
23N0r+tL7ajMFwMdvs+SzWFGybWJ53UlOcd7E9vaIQiZAKAwZAg8De4qm6/Bgomg
EQSJdUZVLcKjV454/0boUnjJIOT3k4cHq7VZCI6OejtfJouf7zynq4vYzmdGrteW
Arg2c3cBmr399mkO98CHy7bsWjZpc8EhwFZPRpI5et8TpNywBQy2xdUQEO7JWLEe
u2SuTYwNlDRnk4s701TH7uHH/J0LximLIIwhsjD9veD4qPJ9IB5scteGEnhkH/rh
sl4q6o6uBHpD0xa3FuExPztz1VqguX6rNrgdTavrgxxQ1lp+/VmTOPPlrvB8aph2
cYMCpQeZPPRBxPwLYq7cGxmNlTKdMlYTNvktaOliH46vH0/vAKIX3ufmxqijJ6vD
NbiznMpgJ0UoiCUjGBawx7tIvGdaUOL1GzpuIXnMM9eySvrYazQ=
=J045
-----END PGP SIGNATURE-----

--um6qvvvccb75yccj--

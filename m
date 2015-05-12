From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 12 May 2015 11:19:45 -0500
Message-ID: <20150512161945.GE8699@saruman.tx.rr.com>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HnQK338I3UIa/qiP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34111 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753776AbbELQWS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 12:22:18 -0400
Content-Disposition: inline
In-Reply-To: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, mike.turquette@linaro.org, sboyd@codeaurora.org, thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, kesavan.abhilash@gmail.com, linaro-kernel@lists.linaro.org, ta.omasab@gmail.com, linux-pm@vger.kernel.org, viswanath.puttagunta@linaro.org, santosh.shilimkar@oracle.com, olof@lixom.net, khilman@linaro.org, Sudeep.Holla@arm.com, grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de

--HnQK338I3UIa/qiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:
> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
>=20
> The shortcomings we are trying to solve here:
>=20
> - Getting clock sharing information between CPUs. Single shared clock vs
>   independent clock per core vs shared clock per cluster.
>=20
> - Support for specifying current levels along with voltages.
>=20
> - Support for multiple regulators.
>=20
> - Support for turbo modes.
>=20
> - Other per OPP settings: transition latencies, disabled status, etc.?
>=20
> - Expandability of OPPs in future.
>=20
> This patch introduces new bindings "operating-points-v2" to get these pro=
blems

operating-points-v2 is kinda awkward, how about
operating-points-extended, much like interrupts-extended ?

Other than this, I very much like the new approach.

Regards

--=20
balbi

--HnQK338I3UIa/qiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUighAAoJEIaOsuA1yqRE1/YP/A3nLJGjm1qsghOFoEkVMolt
EVD1eYqOREbQOoHNgJloy/D9gCyz8kLJEjHj4ITslxfrpHhQQvQkWhjUEJsX2YDT
bd3KomL5oHinmgpK5qMQBKsKYFXK90pYfRFWoUY+Va4MAOCLkSrlob9GmxwfLbiA
XTJs2JYyncYzMqSNliAUzP//eJCL7VfnMZXoZSDlJrqfNR8exu+R+4MVLQdG3iLB
zl9ZxAfIRlDPJeOB9ow6veL9KwxI8cE9QyeTh0cYt0T9SvupvJXCDvDN7Y8VJmiQ
osEFLJFsa0JF1IkEgRUtDqv4h9CJAubYUOo1nU/8IcavWGOARVdCBNk/CfNeGGob
BT88NM77JA1iiuaYKn2BFd518yK+EOYyz7JKZy+qvc3tvGyiTKV2iFVX9dRnzRrz
lrBEQufXPzzZ3O2060DnxI/U+bTG2E/q2xL209C105UhW2KclS4BDAP0rXO1TUJ7
vdUxd+vUuWlOKmekMHv2D+RPRTXTV5jizqIqxhRsixak4uzqkKu+qKSBFBO0O7lX
OPcUECWumgkA/7z5hM4kuUAsKSjh2UuejiUZlzmdm8EVB3M8ReTqvhaAJYv7I4no
Y+rBj3zvhsHkxRBme+wwf2QTsaAv5emiXvAxZZgy32/i3rjL84vzdpjIoh2s/A2Y
YLN+9UZdryV9Y9zgGRCi
=8m7v
-----END PGP SIGNATURE-----

--HnQK338I3UIa/qiP--

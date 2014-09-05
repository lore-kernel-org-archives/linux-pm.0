From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 5/8] drivers: cpuidle: implement DT based idle states
 infrastructure
Date: Fri, 5 Sep 2014 22:36:00 +0100
Message-ID: <20140905213600.GJ29327@sirena.org.uk>
References: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1409938498-17984-6-git-send-email-lorenzo.pieralisi@arm.com>
 <7hlhpxygzv.fsf@paris.lan>
 <20140905212908.GA28626@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RAJzu4PW+u81FKHr"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52220 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaIEVg1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 17:36:27 -0400
Content-Disposition: inline
In-Reply-To: <20140905212908.GA28626@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kevin Hilman <khilman@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Sebastian Capella <sebcape@>


--RAJzu4PW+u81FKHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 05, 2014 at 10:29:08PM +0100, Lorenzo Pieralisi wrote:
> On Fri, Sep 05, 2014 at 09:00:52PM +0100, Kevin Hilman wrote:

> (3) Add an optional property to the DT bindings to describe the state

> (3) I am not extremely keen at this stage to re-patch the DT bindings,
> it has been an awful lot of work to make everyone agree so I would avoid
> any changes, I hope you understand (and I am not even sure DT maintainers
> would accept that, so even less keen on changing the DT bindings at this
> stage).

Just do it as an incremental patch if you're worried - we've got
precendents for this like regulator-name which exists solely to make
diagnostics more descriptive.

--RAJzu4PW+u81FKHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCiy8AAoJELSic+t+oim93X4P/06zj2WIuJP4At6ip2gePBiD
0Lv1krt7CuH7uaUGBMT4wJ82+NYHj8UTdi9oMj8Qk+tY/VQyNrOnWKwW0Ch4+Ktb
uXfEXI215fhZBMareTucbBe8N+RUElcw8ZOqbWmqXvlULI+Y7lL5ep99cdoDFr22
s2SaNQxlHWNLe1PFm8FEFw9kCZoCdvMmz8P6e1YR6me8jUkQbb7vXUJn1zF3spxD
bRw3rArPOCriU89tJxbhNHndASX/zuqryI2ZDn9a/xci5k0io4R17dZqEVcXsh2M
HVeM/zqctpcWqImNbtDQkpi0dz4ti3wTs25XW+0Og336s20ZtsB/1fNp4u8ruH8F
Sq1pxk2CBxoTwKo7TRc9/lycFoD5sLtqmBWBfOM9tBVlZk4x+Bo+gsaDwSm4lpqJ
LhxYZLC0GCYiPC3VZZGIoBaLAYUV+JLEX02Aa6P1WIwDxzN16zCpFIN4M1fJq6Zs
RXFe97t0YTcf6NaxKoe86XBwtlLpCV6ZALLXm5bFOLfto5BZN4fFm/mmK5f2LfrQ
6O5Masbdm4HRUe8k13lEuEWg4Pps3+f5KanKo/Zc4k/+6uT8lFy+59mwzOKhJr5H
nbjdAL41U8T7dP5v5DKHdYlkhxMLuVin6uYvqbIrMgjpEB98caxQewJCjWcXAUvP
rcTFPfNJ82pfG9FKXsAI
=vXYK
-----END PGP SIGNATURE-----

--RAJzu4PW+u81FKHr--

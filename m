From: Mark Brown <broonie@kernel.org>
Subject: Re: Extending OPP bindings
Date: Tue, 4 Feb 2014 18:22:20 +0000
Message-ID: <20140204182220.GQ22609@sirena.org.uk>
References: <52EA570A.8040501@arm.com>
 <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
 <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
 <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
 <52F12AE7.904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cqF3yV8I+FsmjbWd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35402 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbaBDSW0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2014 13:22:26 -0500
Content-Disposition: inline
In-Reply-To: <52F12AE7.904@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robherring2@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>


--cqF3yV8I+FsmjbWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 12:01:11PM -0600, Nishanth Menon wrote:

> As long as the key to the data sets are all the same (frequency),
> information in data set #0 is maintained. It would be in our common
> long term interest to maintain the split.

You're assuming that the frequency is a unique key here.  That may not
be the case, for example two OPPs might have the same CPU clock
(assuming that's the frequency you're referring to) but different bus
clocking and of course the CPUs or CPU clusters might be individually
scalable (this is common in big.LITTLE designs I think).

--cqF3yV8I+FsmjbWd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8S/YAAoJELSic+t+oim99BQP/j1FT+qQgadmqP3F7w5/IehD
dHKamFSXu3NEMECqSE8RdQhNj/8vOXkzaCuZD4oeGtRJLffqFPfPcbT+ubkI/aT8
5m/5xxxoFv+wB6KdTNrY2JSkEzqoBTSMvO2FxttH7AbGTePgTO9IrmZK8+uulYUx
H3J1h2TsmPwPGpvFzIyLAuq3jjFxcgxiLAA78iPL/tEPC2ZuYuQg2nyv8LEDU89z
nfFideyM1XS1ZViR/kOb+cwsQepCOrDIZoDVuk6JAILaIONiQrkyp59IcXYxs+2L
aaJaMzawSu4c0zPQuWhWpM/wPK/hNQZZ4HvFvE8FpcleAd8Aldcwwc85czbS4d70
CvOcY+8XiFZgnvrKAPta2LYJtQzjVY7X3xKb3C6f8Roxan0FkziVGUVdnoHv0JnM
RzlUeCWHSQVnzaZ2z5E7MHoQeWdn9m+EP9m8DLZak9f3X6EoG59VZDV7A/D5fzV9
sEKQcLVMHKfr4ItsD3qw0CL8ggulqcA+7xB+IlT0HYa29ofourgcm3cGPSNNGgcr
UQBRJZ2kJyWmbCU4cFltw5a+gGrrkqIBzRVJdbkocU1umucx8oMbGqmzyHLgpzQE
yxmu/JjT57rEcUX/SdDn2+MzxuAPKRt5qBLqIZ/cwwNltuyOSCADwYSUjmMZSFBj
Ut9VEFJuJbcdX+vjKm9S
=iHpU
-----END PGP SIGNATURE-----

--cqF3yV8I+FsmjbWd--

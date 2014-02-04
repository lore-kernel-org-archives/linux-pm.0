From: Mark Brown <broonie@kernel.org>
Subject: Re: Extending OPP bindings
Date: Tue, 4 Feb 2014 20:11:22 +0000
Message-ID: <20140204201122.GB22609@sirena.org.uk>
References: <52EA570A.8040501@arm.com>
 <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
 <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
 <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
 <52F12AE7.904@ti.com>
 <20140204182220.GQ22609@sirena.org.uk>
 <52F13F54.5060000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ssSfcPohcXNs3135"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35503 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaBDUL3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Feb 2014 15:11:29 -0500
Content-Disposition: inline
In-Reply-To: <52F13F54.5060000@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robherring2@gmail.com>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>


--ssSfcPohcXNs3135
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 01:28:20PM -0600, Nishanth Menon wrote:
> On 02/04/2014 12:22 PM, Mark Brown wrote:

> > You're assuming that the frequency is a unique key here.  That may not
> > be the case, for example two OPPs might have the same CPU clock
> > (assuming that's the frequency you're referring to) but different bus
> > clocking and of course the CPUs or CPU clusters might be individually
> > scalable (this is common in big.LITTLE designs I think).

> Which is why OPPs are maintained per device, bus OPPs belong to bus
> device (in TI terminology, we'd be talking of cross domain dependency
> here for maintaining asynchronous bridge timing closure constraints -
> but ofcourse, other SoCs may or maynot have such constraints). For
> scaling bus frequency, we already have infrastructure in place - clock
> notifiers - discussion of using that is much deeper topic of it's own.

> for each processor that is uniquely transitioning, we'd have it's own
> sets of OPPs - the correct representation of the device node is the
> key there.

I've seen some SoCs characterised over the whole device rather than with
individual parts of the SoC done separately.

--ssSfcPohcXNs3135
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8UlnAAoJELSic+t+oim9DGAQAIuvf/XnadjcwtUcK/abWxs4
Lbe1AKgJc1t/JRIR3N1VmrNGcad6+kvKqzW/oo7jWZCEARZBaF2RjUCNBCjcQCEm
pMou6Iufydvn7NWiALGZ1nSOIi+E0Hq4hO7mXbSLhNlAXHI7SGLefdcPQ6s8UlJo
/DrfZz+cj+lvVFoC0diFHVWuPk2Wr0BMKie5NEnQ/S7uPGLnqlbwM5jFdubQSaEn
I1RwlZfCjhubRIBZAQFFnx2pFBRkoYqSPGBIP4I0W1uEaGRz1+37u1IxXsNtg/cz
vo9NGCw56wmrlbZ5319Cpq1SRhN5+H1YI5/LZQ5w4/mSmWnl0WdEdtnEWf9QDw5w
OdW6WC/9CYqbtjR9c4Coa8e7iV9nN6HnPnhE3TK+VIeF2i6PcWazPre27RlKKnCr
8Wpzdm2aZu3wUQsQ1nmtNaId/OKnTVZZMUjARovH+OInpL1W2/wjBvidbVbdmvJm
isx8MCiN4XYclBF9dfQtfa42euhBQLul1tlRI5XONHi7o7hWYNaUBtTxyTTpAxWE
cEMrOGt7HYXoZbouTXD1vIfXBc78vCukdacc0Ag7x+2EHW8TenN6oSoRSjQFMnGN
t9h+imEoaM4NOsNPajBrXxORvrK/xk4LJewRb+LAeN2zImdB6yjY3ixrpHpsUKn4
6W9NoWdv5aEJs/3ke9qI
=XiT+
-----END PGP SIGNATURE-----

--ssSfcPohcXNs3135--

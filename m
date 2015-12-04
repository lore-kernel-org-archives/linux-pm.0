From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: Add brcm,bcm63xx-regulator device tree
 binding
Date: Fri, 4 Dec 2015 11:00:18 +0000
Message-ID: <20151204110018.GU26072@sirena.org.uk>
References: <20151201221615.GY1929@sirena.org.uk>
 <b7ecdc8ebcdf9582620c22b0e8a4a96d24ba67c1@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <20151202125325.GI1929@sirena.org.uk>
 <565F53FC.5080309@simon.arlott.org.uk>
 <20151203000631.GM1929@sirena.org.uk>
 <565FF9E9.1090503@simon.arlott.org.uk>
 <20151203150528.GG5727@sirena.org.uk>
 <5660D274.7000402@simon.arlott.org.uk>
 <20151203234548.GJ5727@sirena.org.uk>
 <5660D574.7030803@simon.arlott.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ivd6Nf4GAZ12BQqh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60335 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbbLDLAw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 06:00:52 -0500
Content-Disposition: inline
In-Reply-To: <5660D574.7030803@simon.arlott.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Arlott <simon@fire.lp0.eu>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jogo@openwrt.org>


--Ivd6Nf4GAZ12BQqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2015 at 11:51:16PM +0000, Simon Arlott wrote:
> On 03/12/15 23:45, Mark Brown wrote:

> > Are you *sure* these are regulators and not power domains?  These names
> > look a lot like they could be power domains.

> No, I'm not sure. Some of them are may actually be regulators (the "PHY"
> ones) while others are almost definitely power domains (like the "FAP"
> Forwarding Assist Processor).

OK, so the power domains should be being represented and managed as such
rather than using regulators - it's a better fit (doing things like
support atomic context) and it also sidesteps this.  For the things that
you say are clearly regulators should we have more information about
those?

--Ivd6Nf4GAZ12BQqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYXJBAAoJECTWi3JdVIfQ890H/2AUI6DDRwo9IliDDxIXJ5mi
1msdtUuUuBpEP9dKqViHmcOeQrXUmUd5Y/EgtAnPX9kwNXECZGMFPyGKzwYQXbbw
a+OeKYc46Jy8TXwzGctxpECMYrkVqp42htbBmMxOsIaygJPPl+1E9BhEKpcf/UdD
ik7gFiEeCOnbvRCPk8yUrLR9qi9z6KKPKu62OoOpnlMk/S4h9Cw3NNVMHSaJihb4
RQY1V8jFsByBPXWKCFILplafufAVIDqunuWsPVb++VEUownx6sbBohvtv+IUAm7v
vHzbWnvJN+XUz3CXxkZYVvX8id1DeBun0d9nt4kHjJhy5gAnkMZI8gVqvu2M7FQ=
=zZVW
-----END PGP SIGNATURE-----

--Ivd6Nf4GAZ12BQqh--

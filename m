From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Thu, 29 Jan 2015 11:07:44 +0000
Message-ID: <20150129110744.GU21293@sirena.org.uk>
References: <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EUFYPFpHgv7thsbJ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38797 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbbA2LIM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jan 2015 06:08:12 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Sudeep Holla <Sudeep.Holla@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, santosh shilimkar <santosh.shilimkar@oracle.com>, Mike Turquette <mike.turquette@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Thomas Abraham <ta.omasab@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lucas Stach <l.stach@pengutronix.de>


--EUFYPFpHgv7thsbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 29, 2015 at 07:09:23AM +0530, Viresh Kumar wrote:
> On 29 January 2015 at 01:36, Mark Brown <broonie@kernel.org> wrote:

> >> +  Required properties:
> >> +  - compatible: allow OPPs to express their compatibility.
> >> +  - opp-list: phandle to opp-list defined above.

> > I don't understand what that compatible property is intended to mean and
> > I expect other readers might be similarly confused - is it a standard
> > compatbile property meaning this noe corresponds to some sort of device?

> The goal is to choose the driver which we want to probe for a platform. There
> can be multiple DT enabled cpufreq drivers present in a build and the platform
> needs some way to choose one of them.

So you need to document this as a platform device then if that's what
you're doing here; there's more than just specifying a compatible string
involved.

--EUFYPFpHgv7thsbJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyhR/AAoJECTWi3JdVIfQuHsH/2ncbje++IRo/Su+cMRTBnih
/HKH2EcrscYaOxO0OV7SaX/cdyILurAwus3xcPjspXxMsg4TQmgFheRLJlMGPrS2
cWop6v6sm4H/elABk42et2jzkdKhwRHnLBTwJhI2tEe8lEvQCDapCuI5ntBX9bqV
eJWbVsvmmtkWY8WmW2vN9GeBjiM9C90SouQaw1qXSJ2nSooBk62iPyqcCc1S9klm
Q5Ck4kVWM5l+GLZzi63oO+MY8bdpuT1gH1lucDwXYkvBaO9PwdFkLKDKvQvTNYa3
Fctve8NraiHyqZOFJvjwGbfyD/0mTGxl1e/NtWEelDVmV5hTI/CAJfR0Hz8+B1I=
=tyjU
-----END PGP SIGNATURE-----

--EUFYPFpHgv7thsbJ--

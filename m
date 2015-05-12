From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Tue, 12 May 2015 20:41:34 +0100
Message-ID: <20150512194134.GC3066@sirena.org.uk>
References: <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com>
 <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum>
 <5552510B.9010306@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ytgo/kJyDF3J5kSH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35150 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933978AbbELTlz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 15:41:55 -0400
Content-Disposition: inline
In-Reply-To: <5552510B.9010306@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Michael Turquette <mike.turquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "olof@lixom.net" <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Thomas Abraham <ta.omasab@gmail.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kevin Hilman <khilman@linaro.org>


--Ytgo/kJyDF3J5kSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 02:14:19PM -0500, Nishanth Menon wrote:

> While TWLxx series was kind of nascent in it's ability of choosing
> PWM/PFM or auto mode depending on the current targets, newer PMICs
> have their own unique techniques -> but, that said, this is a
> description of power consumption for a given OPP for the "device", How
> would stephen's case work with a PMIC and 2 devices which have
> different leakage characteristics (based on which end of the process
> spectrum they come from), Lets take an example:
> device X consumes 800mA for OPPx
> device Y consumes 900mA for OPPy

The system integrator would need to be somewhat conservative when
specifying the currents involved.  For plausible applications these are
likely to be ballpark figures rather than anything too accurate - if
nothing else the instantaneous current draw normally varies very
substantially so realistically you're talking about a maximum here.  If
the corners vary that dramatically then I'd expect you'd see different
OPP tables being used anyway.

> It is a lot more impactful than using relative numbers for other
> purposes - for example energy aware scheduling as an example -> here
> the actuals might have better optimization, but hints of relative
> power numbers by itself is pretty powerful information to help
> scheduling. The usage, in this case, unlike the usage for a PMIC
> efficiency selection, is not based on absolutes and is meant more of a
> hint (closer to usage such as clock transition latency numbers).

You're not comparing two similar types of object here, you're trying to
provide information on an actual physical value to get fed into other
actual physical values.

--Ytgo/kJyDF3J5kSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUldtAAoJECTWi3JdVIfQMrUH/isKSgOuFnEEw/Rmw/Rv6icC
uT4t+UKWG3xjNTkaqZgMokh4i1HzXrb6a8mLrqGUtYrk6Vl3mjSjmlLl+cSCBSnK
AVRVo4U1zo2BokGfzoCEufXi1D8PgqP269bZZGB/K3mVFo32IQMYUGOvoXCtcVaY
0+ybbWez7itWtOgp/tpb/I5opke+gJ3HDkJJK3zhhOB1gpHn0HvGYiCC42JlPokx
EbGezneMHjBK1ZCoKGYAjyqn5swCLdxlc34wiaKE1SqfYsA+/wTFI5lB4EBRdUDa
sgVS5HvUbG0U0ejK8b5oGOBaYOOEoLeUp28xbjmDP+Ma47we+W9YCuwz1BenPH4=
=0+Cj
-----END PGP SIGNATURE-----

--Ytgo/kJyDF3J5kSH--

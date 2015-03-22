From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
Date: Sun, 22 Mar 2015 18:56:27 +0000
Message-ID: <20150322185627.GI6643@sirena.org.uk>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <20150212005220.GG11190@codeaurora.org>
 <CAKohponaLt51hiHd=uTocK_fPPwRDgkse5wc_PGG5tFQNnvfAQ@mail.gmail.com>
 <20150212082004.GJ11190@codeaurora.org>
 <CAKohpo=uJJw0=T+yfV=aAUQq+Z2-kZFJWFqxnN6B8QtSb2XHqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yKpjvgUFh4AHjl21"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52332 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbbCWFBE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2015 01:01:04 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpo=uJJw0=T+yfV=aAUQq+Z2-kZFJWFqxnN6B8QtSb2XHqg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.or>


--yKpjvgUFh4AHjl21
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 17, 2015 at 01:16:25PM +0530, Viresh Kumar wrote:
> On 12 February 2015 at 16:20, Stephen Boyd <sboyd@codeaurora.org> wrote:

> > voltages. I suppose something like opp-microvolt-names would work
> > though but I don't know how software would correlate that to the
> > regulator it uses because that information is elsewhere in the

> I hope the CPU node will have an array of supplies to support multiple
> regulators, right? If yes, then we can just keep the array of <t/min/max>
> in the same order. And software should be able to correlate then?

It's probably not *too* bad for small numbers of supplies but bindings
that require that indexes into two different arrays match up
(particularly with different step sizes as here) do have legibility
issues - it's easy to miscount when reading things.

> > device's node. Why not put the information about which clock and
> > regulator is used into the opp node?

> Don't know. I have been asked specifically to keem them out of the OPPs,
> as they belong to the CPU or device instead.

The DT should describe the hardware and how it's connected.  No power
supplies or clocks are connected to an OPP, an OPP is a property of
something else.

--yKpjvgUFh4AHjl21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDxBaAAoJECTWi3JdVIfQjqkIAIGE71HONJ2arX93F/fC2cZQ
fipjQEMHjoPTjRItZjAadNjk2H7xyEEncHt2f1JzOcTcg81mvJNZtoQroAiSqKeQ
alM2tAL7COxWP4RfCA97evDHuT2I/K+R0mQoEP3/tl3EgijwcLd8pgweEWRucglZ
YEJdRWdzPoUXKTBm3CnKRA9berpj6ozrYmwrTRnVzAzYBM+fBZSxT7zvUOTyRC09
LGFDF2kGJd9P3YriU6nLJlbaEo7AAldajH3BKhhWIi0X2HAsVYmyvLbjQLKqgygk
kZN5Loo5pG+p+qfWA2P0q/DCcTd2+FsYfqMmiUKWiufRz9OvKTuNx62TyxyHqbI=
=5mSd
-----END PGP SIGNATURE-----

--yKpjvgUFh4AHjl21--

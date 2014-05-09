From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] arm64: Enable OPP
Date: Fri, 9 May 2014 19:18:55 +0100
Message-ID: <20140509181855.GW12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
 <20140509171120.GS12304@sirena.org.uk>
 <CAGo_u6oL06G7jk8_X-SH73oWCAHX5vTj7ViC1AyaDhDLJEvWmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jvmEclD7J9d0bV7E"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39547 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757150AbaEISTN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 14:19:13 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6oL06G7jk8_X-SH73oWCAHX5vTj7ViC1AyaDhDLJEvWmw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "menon.nishanth@gmail.com" <menon.nishanth@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel <linaro-kernel@lists.linaro.org>


--jvmEclD7J9d0bV7E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 12:17:23PM -0500, menon.nishanth@gmail.com wrote:
> On Fri, May 9, 2014 at 12:11 PM, Mark Brown <broonie@kernel.org> wrote:

> > That's for the user visible symbol but OPP is also enableable via select
> > - the fix here may be to remove both the visibility check and the
> > dependency.

> That is reasonable.

OK, I've sent a patch - now I look at what the OPP stuff is doing that
definitely seems like a better approach.

--jvmEclD7J9d0bV7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbRwMAAoJELSic+t+oim9oNEQAJfSpl1pyUpHQFq/U/dJlv1H
h6niB+pxLgleb75OI0QJGlNLoCq9NJMglrPUtDAJnj5/+lmzb+Rz8814/mS4B9gy
DdKU/qD8F0wlgxtL/+wL37/ONQN1bfRGnOYbVT5vqdqbAmNxyZjvqN9OM+bfxuwL
5Mz6MgL+LQ8dkzDYIigqkH2B3mCHq5GFok1crlP5RczFtjCJmyzaEDPYmVBCAl6x
ot1VauUHYAvdJ28NiD+LjraKZW/EcW16zgBmT7VFcunOS/QEEUcsmqarQuuEF3P3
0MhypqRQGAhqeSv2RMD4FThNEH+z+gxdfkG+m7DGH/G8qbQiCs7dPh3uJsvei9B2
5TxsY4p0PyjSbUkpA5kyHBABWbgemEmGpoZdu5UcNj2PcQdmcCvxecDEqOgi6x/0
TiNQ/8ioiE4gSQD+6eeJwOFYllmHky1MyO0ggGHS9rpLa/pZc8V68WKtZh247GWU
ui4+qhfJ+dsq8UGL3hnS40Bi3bwj3+QlTmj/UYTc53mBD7MzOyUQ8VOGsa57+ih9
3voHYEX57cmqTjr7BLSsJOY8qPd+cmREJFlA93wB7MlOljQKK9ABPd0rGHXf2oO2
x7ipOgqL5A255LD2sTkq23r46yCJEWSFWnFOJpN32qMkqxKi7FrFjnRQlV8JYLx1
eQPFEX69T5Myyor4QSK6
=zHFY
-----END PGP SIGNATURE-----

--jvmEclD7J9d0bV7E--

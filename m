From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Wed, 28 Oct 2015 17:17:42 +0900
Message-ID: <20151028081742.GC28319@sirena.org.uk>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <20151016002243.GA23912@codeaurora.org>
 <20151016060227.GS19018@linux>
 <20151016191658.GA16437@codeaurora.org>
 <20151017041055.GZ19018@linux>
 <20151022163942.GX8232@sirena.org.uk>
 <20151027081917.GD5505@ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S96ff6o5osL9bGCL"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:38604 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbbJ1ISI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 04:18:08 -0400
Content-Disposition: inline
In-Reply-To: <20151027081917.GD5505@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, rob.herring@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>


--S96ff6o5osL9bGCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2015 at 01:49:17PM +0530, Viresh Kumar wrote:
> On 23-10-15, 01:39, Mark Brown wrote:

> > I'm not sure that's
> > a place we want to end up just yet, I think it's safer to just have a
> > little bit of code in the kernel that glues things together in the cases
> > where this is needed. =20

> So you are effectively saying that we shouldn't go ahead with multi
> regulator support in OPP library, right?

Well, I think things like libraries for getting the data tables out of
DT are fine but I'm not convinced that trying to avoid having any device
specific code at all is sufficiently clear yet - as far as I know we're
mostly looking at a fairly small subset of devices still and with things
like sequencing in the mix it's a bit worrying to me to be putting it
all into an ABI intended to be used with no knowledge of the platform.

--S96ff6o5osL9bGCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMISiAAoJECTWi3JdVIfQYcgH/24LlU6dseeEMz1AU74SyTd0
QH5nNaaFyOv6MnH7NErBywc30bX4GhrfeG1H9QdDpKzm39f/wzOS+lsQmGLI0eYp
R3RMeyg8ejtuMbz9KWAv0hZnXJWYm+dytYxyCobBXeQUeNFg/DeCXsIiW1jXzt2n
0iQzL6XDzWFEnHk33ITwuQDCcDDYMprrI/RF5lV8ay0Cp9pXu1wQNr1xYvOKs68i
ZlZEn3cAvMAIO2O19wf80HyUpjWAi6BhkQjKwKfhb+RejytPIMZZavvHKdq8ipb3
f10eBRlo+AOc+mh6OtrGo6kypQ1WNPVlxrF7sDbXjJO2ygcW2l8ypeqnRnGQ9b4=
=/J5O
-----END PGP SIGNATURE-----

--S96ff6o5osL9bGCL--

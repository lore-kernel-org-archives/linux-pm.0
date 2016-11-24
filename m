From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Thu, 24 Nov 2016 10:19:36 +0000
Message-ID: <20161124101936.do2zccr23ldgjvpz@sirena.org.uk>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161118030636.GA3110@vireshk-i7>
 <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
 <20161122034922.GC3070@vireshk-i7>
 <20161122184103.djm3jn67gshdtun4@sirena.org.uk>
 <20161123034657.GB22335@vireshk-i7>
 <20161123122959.r262pkvhx4zj6c7p@sirena.org.uk>
 <20161124050724.GD9376@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tnrt6wxbkaim6b3w"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161124050724.GD9376@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com
List-Id: linux-pm@vger.kernel.org


--tnrt6wxbkaim6b3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2016 at 10:37:24AM +0530, Viresh Kumar wrote:
> On 23-11-16, 12:29, Mark Brown wrote:

> > No, of course not.  That would be completely incoherent, there would be
> > no way for anything to use the data if the values can just be in any
> > random order.

> With the current implementation in this patchset, the order in which entries are
> present in the OPP node is _assumed_ to be known to the platform specific code,
> which will pass it on to the OPP core with some callbacks. So the order will not
> be completely random.

What we're reviewing here is the DT binding and the DT binding
explicitly said the order doesn't matter.  The DT binding is OS neutral
so it needs to make sense without the code.

> > The "platform driver bindings" bit of this is very important here.  This
> > is a generic binding that is going to be used by platform specific
> > drivers (as I understand it).

> There is no platform specific binding here.

It seems like we're going to need one for this to be a comprehensible
binding.

> We can either get this information from DT (somehow) or hardcode it in platform
> specific code. This patch provided infrastructure for the later one.

> If we indeed want to get this information from the DT then there are two
> options:

Why would we want to get it from DT when we can't get half the other
information we need to make the data useful from DT?

--tnrt6wxbkaim6b3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNr63AAoJECTWi3JdVIfQY20H/0jRbRubtz15L8Z37wD36Srh
duM2229g3TCswhmm/+epTW7CYg/iyJ7iGlPuNtMzli+xz3SbFdL7MLiUPJ+Q3rom
NTK/Kn4VykiT7VOhdH2IP8l2ut8DDvkME8HQbpDpb4Gx8DxzIYuwqzaRqewCXEd/
vR3vPLXw5IOuJyLfc40RS/neXGTynjVubfclIXtYj5dS8Vk0DkULHK/5Y+2onFdH
U9xv7sBa4pov50C9Br/DXTi+LkrnmZgAsxU36uiW0iQViwm+Nbfk/qeSmgV1LwjC
PKoQYyki5a7Um2grljO+/LbUe7EShBSiTSVcxXyDbfgkn2Jc0q0QsifjXru8ZEo=
=i8ch
-----END PGP SIGNATURE-----

--tnrt6wxbkaim6b3w--

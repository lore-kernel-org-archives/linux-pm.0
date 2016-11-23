From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Wed, 23 Nov 2016 12:29:59 +0000
Message-ID: <20161123122959.r262pkvhx4zj6c7p@sirena.org.uk>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161118030636.GA3110@vireshk-i7>
 <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
 <20161122034922.GC3070@vireshk-i7>
 <20161122184103.djm3jn67gshdtun4@sirena.org.uk>
 <20161123034657.GB22335@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4upa3zplvborgiot"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123034657.GB22335@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com
List-Id: linux-pm@vger.kernel.org


--4upa3zplvborgiot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 23, 2016 at 09:16:57AM +0530, Viresh Kumar wrote:
> On 22-11-16, 18:41, Mark Brown wrote:

> > I'm really not at all clear why this has to be in DT.  My understanding
> > was that this is basically a helper library for more specific bindings
> > which already have to hard code things like sequencing so surely they'd
> > be specifying the ordering to be used when supplying data?

> I am a bit confused and perhaps I am misreading your feedback.

> Are you saying that:

> "we don't need to identify which microVolts value in the OPP table corresponds
> to which supply from the DT itself and we can do that with some hard coded
> stuff" ?

No, of course not.  That would be completely incoherent, there would be
no way for anything to use the data if the values can just be in any
random order.

> If yes, then below is from an earlier email from you, which I feel is opposite
> of what you are suggesting now.

> > That *really* should be in the binding.  Honestly if the binding is this
> > vague I'm not even clear that it's worth documenting these properties at
> > this level, might be better to just put the documentation in the
> > platform driver bindings.

The "platform driver bindings" bit of this is very important here.  This
is a generic binding that is going to be used by platform specific
drivers (as I understand it).  I would therefore expect that these
things can be described in the platform specific bindings.

Please, take a step back and think about what what the binding means and
how it's going to be used.  Not only is this a DT binding and therefore
an ABI it's also a generic binding that's going to affect a lot of
systems probably for a long time.  This means it is really important to
think things through and make sure we understand what they're doing.
When working on kernel internal code it's relatively easy to fix things
if we realize later that they don't work well so it's easier to just
work quickly but when we're making ABIs that's not possible.

--4upa3zplvborgiot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNYvCAAoJECTWi3JdVIfQyEgH/3JuUpMzD50bbsbhHYk7htYv
KBKrZXeKcPFtjHFXSgRmbvYmN/48a7iDWvgPxoIUK7zYw4s68/WkO9Sj8D1WHQM8
158igEq6zgYSoSL1ey/x7Hd6OJyFb1v3JkbBiTCGKwC2cK58NfRY2UxPURR6DKdx
zz9vPlObtIhz3QPa3azpXvMowMeA0GTk3aYr1Tj67GhalTVEWboS1KvARqx2HRFB
uOJmpYtGs09NdmQu5A2EBkfq2t1Hk/yTlRQIJ5TlPGc2mfgVQiFhC/n3ZVAkOSg8
ZLheZaFfioAaL8H+at85lkD3xivgop8SKcDPz2X9Ka3ION5X2RAiNcMPW5TGquk=
=qaqf
-----END PGP SIGNATURE-----

--4upa3zplvborgiot--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 1/9] PM / OPP: Allow OPP table to be used for
 power-domains
Date: Sun, 14 May 2017 18:55:33 +0900
Message-ID: <20170514095533.vawfbikwwgvjjf44@sirena.org.uk>
References: <0a7146f9-72f1-317c-3aab-770a72462968@arm.com>
 <20170413053736.GM5910@vireshk-i7>
 <3adbef6a-7b43-528f-e88f-c2121d30a5d3@arm.com>
 <20170417052758.GF28191@vireshk-i7>
 <95aa4b97-4e1a-13bb-f4d8-982b778012ba@arm.com>
 <9cd9287c-392b-d3ca-db7d-75c49287448e@codeaurora.org>
 <20170426135532.ryrh276znet5yvks@sirena.org.uk>
 <c66322f5-e2eb-5556-a5a5-14998a2f195d@arm.com>
 <20170430124917.4m3d237pik7q47f3@sirena.org.uk>
 <8aacc296-2549-f0b8-ac25-2f4000c084c1@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="66rvdfl7i43utfee"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8aacc296-2549-f0b8-ac25-2f4000c084c1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: robh+dt@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, lina.iyer@linaro.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--66rvdfl7i43utfee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 03, 2017 at 12:21:54PM +0100, Sudeep Holla wrote:
> On 30/04/17 13:49, Mark Brown wrote:

> > DT doesn't much care about that though.

> No sure about that, may be doesn't care about the internals, but we need
> to care about interface, no ?

Well, we need to at least describe what's there - my point is that it's
no different to describing a piece of hardware, the fact that it happens
to be implemented as firmware doesn't really change the abstraction
level DT is operating at.

--66rvdfl7i43utfee
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkYKZUACgkQJNaLcl1U
h9By8gf/Sh80BxUSkeV9abxJi/jMn56arwXGytCk8/8FjaILT6At0opWYbYDjry5
zH4rKqHQyBLsUqMuL8J+YTIw9EPWfCUI/pj7/+4TPb7OpthPbbT8877SdvzceXlv
VP1a/lYHx6JL+zFXy3Nh8+q26bUaHBQ6okZgUV1pyQjG2rIgd3HBb3CAQJ6dvBg8
wrAz6kW6mOpIyj3l5ZErZ5Y/06i9cG4SG+u5jBTviGfmuY/hL1uC5Ng7MFF/kWGe
V5HMSGO2W2Eu+m5I9GmnVerIjSre4i8RL4IN1E+f/c2RuQJ5gQ+/KJ1G3O87+eoX
ha2tp9QQ7Mcng8rtrFWeA9ZxkmIiwg==
=JDXn
-----END PGP SIGNATURE-----

--66rvdfl7i43utfee--

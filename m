From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Tue, 15 Dec 2015 13:39:51 +0000
Message-ID: <20151215133951.GY5727@sirena.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
 <20151214165928.GV5727@sirena.org.uk>
 <20151215122238.GG16007@e106622-lin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5FSjmmofnIBL+CP8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48888 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbbLONkW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 08:40:22 -0500
Content-Disposition: inline
In-Reply-To: <20151215122238.GG16007@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


--5FSjmmofnIBL+CP8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 12:22:38PM +0000, Juri Lelli wrote:

> I'm proposing to add a new value because I couldn't find any proxies in
> the current bindings that bring us any close to what we need. If I
> failed in looking for them, and they actually exists, I'll personally be
> more then happy to just rely on them instead of adding more stuff :-).

Well, the first pass is going to be the core types (possibly with some
other properties if there's interesting parameters people can tweak in
integration).

> Interestingly, to me it sounds like we could actually use your first
> paragraph above almost as it is to describe how to come up with capacity
> values. In the documentation I put the following:

> "One simple way to estimate CPU capacities is to iteratively run a
> well-known CPU user space benchmark (e.g, sysbench, dhrystone, etc.) on
> each CPU at maximum frequency and then normalize values w.r.t.  the best
> performing CPU."

> I don't see why this should change if we decide that the scheduler has
> to change in the future.

You'd at least need to pick a particular benchmark there...

> Also, looking again at section 2 of idle-states bindings docs, we have a
> nice and accurate description of what min-residency is, but not much
> info about how we can actually measure that. Maybe, expanding the docs
> section regarding CPU capacity could help?

I'm dubious about this to be honest, if only on the basis of people
reading the docs in the first place.  It also seems that if we're really
just talking about some CPU microbenchmark then forcing every
implementor to do the benchmark and scaling is at best going to burn
people's time and be error prone since it doesn't seem so likely to have
dramatic system integration variation.

> > So then why isn't it adequate to just have things like the core types in
> > there and work from there?  Are we really expecting the tuning to be so
> > much better than it's possible to come up with something that's so much
> > better on the scale that we're expecting this to be accurate that it's
> > worth just jumping straight to magic numbers?

> I take your point here that having fine grained values might not really
> give us appreciable differences (that is also why I proposed the
> capacity-scale in the first instance), but I'm not sure I'm getting what
> you are proposing here.

Something like the existing solution for arm32.

>  static const struct cpu_efficiency table_efficiency[] = {
>  	{"arm,cortex-a15", 3891},
>  	{"arm,cortex-a7",  2048},
>  	{NULL, },
>  };

> When clock-frequency property is defined in DT, we try to find a match
> for the compatibility string in the table above and then use the
> associate number to compute the capacity. Are you proposing to have
> something like this for arm64 as well?

> BTW, the only info I could find about those numbers is from this thread

It was discussed in some other thread when I was sending the equivalent
stuff for arm64 (I never got round to finishing it off due to issues
with Catalin and Will being concerned about the specific numbers).
Vincent confirmed that the numbers came from the (IIRC) DMIPS/MHz
numbers that ARM publish for the cores.  I'd independently done the same
thing for arm64.  It would probably help to put comments in there with
the base numbers before scaling, or just redo the table in terms of the
raw numbers.

This is, of course, an example of my concerns about magic number
configuration.

> If I understand how that table was created, how do we think we will
> extend it in the future to allow newer core types (say we replicate this
> solution for arm64)?  It seems that we have to change it, rescaling
> values, each time we have a new core on the market. How can we come up
> with relative numbers, in the future, comparing newer cores to old ones
> (that might be already out of the market by that time)?

It doesn't seem particularly challenging to add new numbers to the table
(and add additional properties to select on) TBH.  We can either rescale
by hand in the table when adding entries, script it as part of the
kernel build or do it at runtime (as the arm32 code already does to an
extent based on the particular set of cores we find).  What difficulties
do you see with this?

This is something that seems like an advantage to me - we can just
replace everything at any point, we're not tied to trusting the golden
benchmark someone did (or tweaked) if we come up with a better
methodology later on.

> Eh, sad but true. I guess we can, as we usually do, put more effort in
> documenting how things are supposed to be used. Then, if people think
> that they can make their system perform better without looking at
> documentation or asking around, I'm not sure there is much we could do
> to prevent them to do things wrong. There are already lot of things
> people shouldn't touch if they don't know what they are doing. :-/

The trouble with making people specify this in DT is that it becomes a
parameter that someone *has* to tweak at some point.

> > There's a tension here between what you're saying about people not being
> > supposed to care much about the numbers for tuning and the very fact
> > that there's a need for the DT to carry explicit numbers.

> My point is that people with tuning needs shouldn't even look at DTs,
> but put all their efforts in describing (using appropriate APIs) their
> needs and how they apply to the workload they care about. Our job is to
> put together information coming from users and knowledge of system
> configuration to provide people the desired outcomes.

You can't do a system integration for a smartphone or embedded board
without configuring things in DT, people integrating for those systems
are already looking at DT and they are the main current targets for
heterogeneous systems I'm aware of.  The people who don't need to look
at DT are mainly the enterprise type people but a lot of them won't be
able to use this as-is anyway since they'll be using ACPI.

--5FSjmmofnIBL+CP8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWcBgmAAoJECTWi3JdVIfQgNMH/1OGVrNPkLRSj2yOh38VDqTe
RwVey+j48wHx38B0jCBwIgcOjr+jIuiP7UbpUsgiTlX7JAtAO2XSZPtC2d/PQbv1
evXimzLK7zc6JApepqpwQKskIbB91+9dnHNXZK+fzRDU9A/obcHpuaqcChcxf1ph
DEL+xywOwYu9h4K8ExpT/li4uJd51TguFQHrmNA075o7EeyGgNPnJWvpAvX8O67d
egMVmb/TUmgifv6LMXnlfVBMr36NVj1mLqeAXm9Olj6V/eZPFyHiAKlDmxh6R2zM
VapNY3NjU+e6IWd9Ul/hXYQz38pZESj9fXzNnrj6iPU0DcwDaoF2LKP9BAG4oxE=
=I0VJ
-----END PGP SIGNATURE-----

--5FSjmmofnIBL+CP8--

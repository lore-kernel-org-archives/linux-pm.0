From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Mon, 14 Dec 2015 16:59:28 +0000
Message-ID: <20151214165928.GV5727@sirena.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop>
 <20151210153004.GA26758@sirena.org.uk>
 <20151210175820.GE14571@e106622-lin>
 <20151211174940.GQ5727@sirena.org.uk>
 <20151214123616.GC3308@e106622-lin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DS29MnVNPmky9ZU5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47536 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbbLNQ7s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 11:59:48 -0500
Content-Disposition: inline
In-Reply-To: <20151214123616.GC3308@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


--DS29MnVNPmky9ZU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 14, 2015 at 12:36:16PM +0000, Juri Lelli wrote:
> On 11/12/15 17:49, Mark Brown wrote:

> > The purpose of the capacity values is to influence the scheduler
> > behaviour and hence performance.  Without a concrete definition they're
> > just magic numbers which have meaining only in terms of their effect on
> > the performance of the system.  That is a sufficiently complex outcome
> > to ensure that there will be an element of taste in what the desired
> > outcomes are.  Sounds like tuneables to me.

> Capacity values are meant to describe asymmetry (if any) of the system
> CPUs to the scheduler. The scheduler can then use this additional bit of
> information to try to do better scheduling decisions. Yes, having these
> values available will end up giving you better performance, but I guess
> this apply to any information we provide to the kernel (and scheduler);
> the less dumb a subsystem is, the better we can make it work.

This information is a magic number, there's never going to be a right
answer.  If it needs changing it's not like the kernel is modeling a
concrete thing like the relative performance of the A53 and A57 poorly
or whatever, it's just that the relative values of number A and number B
are not what the system integrator desires.

> > If you are saying people should use other, more sensible, ways of
> > specifying the final values that actually get used in production then
> > why take the defaults from direct numbers DT in the first place?  If you
> > are saying that people should tune and then put the values in here then
> > that's problematic for the reasons I outlined.

> IMHO, people should come up with default values that describe
> heterogeneity in their system. Then use other ways to tune the system at
> run time (depending on the workload maybe).

My argument is that they should be describing the hetrogeneity of their
system by describing concrete properties of their system rather than by
providing magic numbers.

> As said, I understand your concerns; but, what I don't still get is
> where CPU capacity values are so different from, say, idle states
> min-residency-us. AFAIK there is a per-SoC benchmarking phase required
> to come up with that values as well; you have to pick some benchmark
> that stresses worst case entry/exit while measuring energy, then make
> calculations that tells you when it is wise to enter a particular idle
> state. Ideally we should derive min residency from specs, but I'm not
> sure is how it works in practice.

Those at least have a concrete physical value that it is possible to
measure in a describable way that is unlikely to change based on the
internals of the kernel.  It would be kind of nice to have the broken
down numbers for entry time, exit time and power burn in suspend but
it's not clear it's worth the bother.  It's also one of these things
where we don't have any real proxies that get us anywhere in the
ballpark of where we want to be.

> > It also seems a bit strange to expect people to do some tuning in one
> > place initially and then additional tuning somewhere else later, from
> > a user point of view I'd expect to always do my tuning in the same
> > place.

> I think that runtime tuning needs are much more complex and have finer
> grained needs than what you can achieve by playing with CPU capacities.
> And I agree with you, users should only play with these other methods
> I'm referring to; they should not mess around with platform description
> bits. They should provide information about runtime needs, then the
> scheduler (in this case) will do its best to give them acceptable
> performance using improved knowledge about the platform.

So then why isn't it adequate to just have things like the core types in
there and work from there?  Are we really expecting the tuning to be so
much better than it's possible to come up with something that's so much
better on the scale that we're expecting this to be accurate that it's
worth just jumping straight to magic numbers?

> > Doing that and then switching to some other interface for real tuning
> > seems especially odd and I'm not sure that's something that users are
> > going to expect or understand.

> As I'm saying above, users should not care about this first step of
> platform description; not more than how much they care about other bits
> in DTs that describe their platform.

That may be your intention but I don't see how it is realistic to expect
that this is what people will actually understand.  It's a number, it
has an effect and it's hard to see that people won't tune it, it's not
like people don't have to edit DTs during system integration.  People
won't reliably read documentation or look in mailing list threads and
other that that it has all the properties of a tuning interface.

There's a tension here between what you're saying about people not being
supposed to care much about the numbers for tuning and the very fact
that there's a need for the DT to carry explicit numbers.

--DS29MnVNPmky9ZU5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbvVvAAoJECTWi3JdVIfQgsEH/RTnwEEBYTHWu9ZbTzmM/lyq
XEjRGy7CKA1o/uo63H0wgDwSXbbiV8NvUzhzUbKSV7bi7MxQoEdSrH8ZbcoveBtT
sObdDXfcOSl6MIUsDhpckWzASDRAPaZXw6aTEP6Z7+XbFkP1Me0U0T8PJR9SCVbY
lE+2HD/MGxapi1UDHWwONkFLiOpeWh7qok+6apWkPf5hZMTpX65IMRGzGgFJmZs4
qbqVN+bOjgI/cmF2i+jMODxuscISOZ+x26oy9+1uAGGekbxzuOwYtxl7h/yspqDh
2NKfDf+h8cxRU04TmGj83oMGVo33LeRNCYHsxwIQ7Ms1VlDN/3tXCTupqRWkA84=
=FLmE
-----END PGP SIGNATURE-----

--DS29MnVNPmky9ZU5--

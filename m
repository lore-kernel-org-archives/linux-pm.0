From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Fri, 9 May 2014 20:29:21 +0100
Message-ID: <20140509192921.GY12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <536D0AF4.1040705@arm.com>
 <20140509175005.GT12304@sirena.org.uk>
 <536D2533.6050100@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="malCDXNrpGyWztRt"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39589 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063AbaEIT3p (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 15:29:45 -0400
Content-Disposition: inline
In-Reply-To: <536D2533.6050100@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--malCDXNrpGyWztRt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 07:57:55PM +0100, Sudeep Holla wrote:
> On 09/05/14 18:50, Mark Brown wrote:

> >Given that the code isn't invasive I think the expediency tradeoff is OK
> >for mainline, it's easy enough to get rid of when we come up with
> >something better but in the meaintine it helps actual systems work
> >better in mainline - if we didn't have the ARM implementation already I
> >think it'd be different but we do.

> I disagree, I don't see a real urgency for this on ARM64. Even on ARM32, no
> single platform other than TC2 is using this(at least as I see in the mainline).

> If some real platform that needs this support urgently, then we can think of
> similar short-term solution as part of adding support for cpufreq on that
> platform. Do you know any platform that needs this right now ?

There's the big.LITTLE Exynos devices, at least the 5410 has shipped in
product using IKS I believe and so should've been using the big.LITTLE
cpufreq driver to do the cluster switching; I think some 5420 systems
were doing the same.  Or reimplementing it which would just be sad.
There's some other non-public devices I am aware of - the whole reason I
wrote this series was for those.

> >Perfect can be the enemy of good (or at least adequate), one of the
> >problems I'm seeing right now with convincing people to work with
> >mainline is that people are missing lots of important functionality when
> >they look at mainline.

> Ok fair enough. But we can take some time and see if we can workout better
> solution rather than jumping to add interim solutions when is unlikely to be
> used on any real platform.

There are real users who want to use this fairly urgently.  I can't be
specific, sorry.

> >Personally the solution I'd rather see is cpufreq-cpu0 extended to
> >handle shared clocks which would remove the need to use the big.LITTLE

> Ideally yes. IIUC it has dependencies on CPU0 and I have not looked that
> driver and all of its users to judge how feasible is that. At-least we can
> have cpufreq-cpu0 for all single cluster systems w/o support for per-CPU DVFS
> and another which can handle multi-cluster systems(with or w/o per-CPU DVFS).

> Just a thought...

It's not clear to me that having multiple clusters should require a
different driver, the single cluster case is just a specialisation of
the multicluster one as far as I can see.  It's possible I'm missing
something though.

I have to confess I didn't look in detail at cpufreq-cpu0 to make sure
it's the best place to start from but it looks clean and does have the
regulator stuff, though it's probably better to say that the goal is to
merge that and the big.LITTLE driver.

> >directly connected to their clustering.  Clustering is important to the
> >scheduler and an understanding of the power and clock sharing
> >constraints that come along with clusters is going to be required there
> >as part of energy aware scheduling but I'm not seeing any obvious reason
> >for the frequency scaling driver to know about this, even with cpufreq
> >governors it's mostly the clock sharing.

> Both CPUFreq and Energy aware scheduling need understanding of clock
> sharing. Both have similar goals(save power with little or no performance
> degradation), but EA scheduler will be more efficient(both in terms of power
> and performance).

> Governors need this knowledge of sharing as it affects the load calculation.
> (IIRC maximum load of all the cpu sharing clocks is taken)

Yes, definitely with respect to the clocks - my point was more about the
clustering bit (which is related to but not 100% tied to clocks).

--malCDXNrpGyWztRt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbSyNAAoJELSic+t+oim9jD8P/j8kvdP2JyA09EsDNG/CY4NG
ZFIJhENOENQ0OyggPEx03E3VYorlFh1nGWjQXRYt1hXC+5FMTW0XgY1Zko2bNoI+
4dGf9/DKhmWlodOjLOdGv1aYMyWOHKbtH2wXrHdmL6hRLKwW5ZXl+RWDA49M5ieZ
BGlVRUJaMbY3T1PATnhY5AP3KMCcJsxY+rd+Ags674I5u0nhv42+VoLFFwMyxh0o
H2EPqt+YUcon1BVG2FLkx8UYoiE5LvRwPxYtgRsawjdGFPxWK6cxmXukjLGejkFo
pwLX8wpxLanUbwFU8JcpPkmHUGyNDkiNuy9h1+OMht/0FY2egwoATjiknquf+41j
XIqUWPMWKfjTPA3aWII9VVNec2Jk61C2ILoE73PU+thkic6ac5IqsgOG7ia0JKJi
DUV4HVdSOpcrxX7u86Coxp7Ws/IlSVdZFJ4qT9lKLKxGcR9bL3FtOcRSPK3iUosE
GlQQUmgJZ2eOKUOvTmEqgmRh0uOBe12TX2+mt2KWftABYKVyiLj0UFUYQl1cxXAm
fIn2SqCC6PCcy8+AzSd9EjPKPj51Py7N9GKc5llYMJjmonRoM5dZZbLwhHp80Nk/
FxPwPvqXyk5bY17atpnpnuY/QI6WLh8o2MSvTQtx1DGF+4F7IslpoXubQwhs7k+J
G0tNjCTCtJEni24Z7YP6
=+b7H
-----END PGP SIGNATURE-----

--malCDXNrpGyWztRt--

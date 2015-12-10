From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 8/8] arm64: add sysfs cpu_capacity attribute
Date: Thu, 10 Dec 2015 15:59:40 +0000
Message-ID: <20151210155940.GN5727@sirena.org.uk>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-9-git-send-email-juri.lelli@arm.com>
 <566988E8.3010308@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L9+4a/fGFceRH8Zi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41343 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbbLJP7u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 10:59:50 -0500
Content-Disposition: inline
In-Reply-To: <566988E8.3010308@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com


--L9+4a/fGFceRH8Zi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2015 at 02:15:04PM +0000, Dietmar Eggemann wrote:
> On 23/11/15 14:28, Juri Lelli wrote:

> > The new attribute shows up as:

> >  /sys/devices/system/cpu/cpu*/cpu_capacity

> This sysfs interface is not really needed for arm or arm64. People can
> build the dt blob if they want to change the values. Less code to carry
> ... Let's focus on the core functionality, which is parsing cpu capacity
> from dt file to task scheduler for heterogeneous systems.

That does make the tuning process much more cumbersome - users have to
rebuild and reboot to tweak the numbers rather than just tweaking the
numbers and rerunning the benchmark (which seems like something people
would want to automate).

--L9+4a/fGFceRH8Zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaaFrAAoJECTWi3JdVIfQK5MH/iqYULaurRnAV257I8eatNYA
NQfOpgs2vo3VnZ9DmloohrhNauolPsL6j3hNQyPi02tT2EFESsE74+nOfvmkBhFt
mxYFP0mojFhf3ZtVaFWNkfJ01I8KO3XmVsVgYgLMuo4ZuacT6A+wyZ8nxoOuv04L
ofIUTf3MJkHnanwwZPYTqnWapMtLXkV1IYUKydH1CghQkWMstSiQW/Iqqke0Y+3b
ws358JSP8Pb+/AYkY960MaSSbFUoM6Ct61LFq8whKvT0Egt7pRcerPke+04upB26
GFfwlFP0+WD8M6RVZjvnkh0Q5hNIA9D6NWUn5JpK8iGUrwkpLb3V7wXk9S9wgwU=
=JV60
-----END PGP SIGNATURE-----

--L9+4a/fGFceRH8Zi--

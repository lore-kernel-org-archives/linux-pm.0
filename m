From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] arm64: Add big.LITTLE switcher stub
Date: Fri, 9 May 2014 18:50:05 +0100
Message-ID: <20140509175005.GT12304@sirena.org.uk>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <1399653631-4938-2-git-send-email-broonie@kernel.org>
 <536D0AF4.1040705@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X8AKxdEWtXlIIbPN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39505 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756360AbaEIRuy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 May 2014 13:50:54 -0400
Content-Disposition: inline
In-Reply-To: <536D0AF4.1040705@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--X8AKxdEWtXlIIbPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 09, 2014 at 06:05:56PM +0100, Sudeep Holla wrote:
> On 09/05/14 17:40, Mark Brown wrote:

> >From: Mark Brown <broonie@linaro.org>

> >The big.LITTLE cpufreq driver is useful on arm64 big.LITTLE systems even
> >without IKS support since it implements support for clusters with shared
> >clocks (a common big.LITTLE configuration). In order to allow it to be
> >built provide the non-IKS stubs for arm64, enabling cpufreq with all the
> >cores available.

> I am in process of using this driver for ARM64 and hit the same issue.
> I don't like this approach at all. I too did similar changes/hacks which are
> good for quick testing but not for upstream.

I'm not a big fan of this either, but then as I indicated on the cpufreq
bit of the series I'm not a massive fan of the way this is handled in
the first place on either ARM or ARMv8.  This at least gives us parity
between the two architectures (modulo IKS implementation) which is
progress especially given the fact that much of the work done on this
stuff is being done on 32 bit due to hardware availability.

Given that the code isn't invasive I think the expediency tradeoff is OK
for mainline, it's easy enough to get rid of when we come up with
something better but in the meaintine it helps actual systems work
better in mainline - if we didn't have the ARM implementation already I
think it'd be different but we do.

Perfect can be the enemy of good (or at least adequate), one of the
problems I'm seeing right now with convincing people to work with
mainline is that people are missing lots of important functionality when
they look at mainline.

> I would like to move all the switcher code out of the driver as extension.
> Also the core driver should be made to work with any multi-clsuter platform not
> just big-little(bL). bL is one of them and bL switcher support should an
> extension of it.

> The main reason for this is I see some non-bL multi-cluster platform support
> getting added, this driver should ideally support that.

It is not entirely clear to me what you mean by "this driver" or "the
core driver" in all the above, sorry.

Personally the solution I'd rather see is cpufreq-cpu0 extended to
handle shared clocks which would remove the need to use the big.LITTLE
driver on systems not doing IKS.  It isn't at all clear to me that
cpufreq should understand clusters (or much of anything other than
clocks) in the non-IKS case, the sharing of clocks between cores is not
directly connected to their clustering.  Clustering is important to the
scheduler and an understanding of the power and clock sharing
constraints that come along with clusters is going to be required there
as part of energy aware scheduling but I'm not seeing any obvious reason
for the frequency scaling driver to know about this, even with cpufreq
governors it's mostly the clock sharing.

For IKS where we're pairing the CPUs up and telling the kernel that
switching between the physical clusters is part of scaling the
"frequency" of the virtual cluster presented to the rest of the system
things are of course different and cpufreq does need to understand the
physical clusters.

Having multiple generic frequency scaling drivers feels wrong; there's
going to be code duplication between them and it doesn't seem like there
should be anything going on that we can't automatically figure out at
runtime.

--X8AKxdEWtXlIIbPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTbRVJAAoJELSic+t+oim93yUP/1Y3/+g6y7nC45H7fP0Nfc1i
iEoyfAPjeIvjD2dx7AH2/ToKlG/FWP/qJ64nyOzD5ZWjjOfRXMdv/3eHGgoWv8bL
jAgSlDQqvArUmpLvdwO1BiDUi8oqjb0qkNxmqrYgUYnzDQvf9E/UNPr79FV6kEll
xkN1UrGudygdZHfo4yr/ZJ3T+vRiHcRdhgLww5zE4wGsYOFpECafpYYhslA+wVya
st66HG7QY21BxzWX9EYTj3aU54UFLjg6RTkA8Ba0LOXqZeq3rHsGvQsEXNwQ7yO7
3x1/X0FRwXdQJYpoW4VqoeI2s2DCBWWFXu6ysMAL9Gws1rMVpW74t4/dNu2ulUKp
Vp6IJuh6gn4NFym/d7bixvyCsK0zLBz49k+mI3g4p8SwHFVRJb55Sl9qibKpBBxj
dtKHjfSLpLZrHikAF9qdG4MWCl6l2g6jS+PRiDYTydizQiUehpAYu5RfbKycTxn6
IyE6KWC2qq5sBR/3qvABAVRqhnRUMswwLr4i3CJPtnMFmwfYGGo6e+ToAU5SFUYC
d9VzuNzJZg4HyCL9W/oYoTTDEVFv0r3fy7+OkI4ePQEU1tJUSOMW3bpwdOcKKQW4
iIMQv77252bKezsBi3K9KjxHO5mNhlXYU/NZG7wPDrS55pFy8eVrpT32o4s72zVK
9X/kJC5RygxrWY47dZ4w
=WU6G
-----END PGP SIGNATURE-----

--X8AKxdEWtXlIIbPN--

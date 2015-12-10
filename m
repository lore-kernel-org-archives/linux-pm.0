From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Thu, 10 Dec 2015 11:35:41 +0000
Message-ID: <20151210113541.GL5727@sirena.org.uk>
References: <2194927.eV2s2QmZs0@wuerfel>
 <5668188F.2080202@nvidia.com>
 <20151209144734.GB5727@sirena.org.uk>
 <566865ED.3020106@nvidia.com>
 <20151209201007.GG5727@sirena.org.uk>
 <56694EFA.7010901@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3VH1SAMC12vKu3aE"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56694EFA.7010901-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--3VH1SAMC12vKu3aE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 10, 2015 at 10:07:54AM +0000, Jon Hunter wrote:
> On 09/12/15 20:10, Mark Brown wrote:
> > On Wed, Dec 09, 2015 at 05:33:33PM +0000, Jon Hunter wrote:

> >> Yes, setting the frequency and voltage as defined by a given operating
> >> mode would make sense. However, I am not sure we have those defined in
> >> the kernel for this PLL and would have to be added.

> > I think given how you're describing the hardware that this will be
> > required in order to provide something robust (and also to get the best
> > power savings from the hardware).

> Yes I agree it would be more robust. However, if you care about power
> savings then you should be using the DFLL/cpufreq anyway.

Without knowing anything about the hardware this is all a bit confusing
I'm afraid.  What is "DFLL/cpufreq" as opposed to "the PLL"?

> From testing the t124 jetson and nyan-big, both of these boards have a
> different configuration for the PLL at boot time, so although we could
> pick a safe operating point for all t124 boards, I was thinking of just
> restoring their initial configuration.

This seems more complex, and also makes the idea of relying on the
initial configuration seem slightly concerning - other software seems to
be already changing the configuration before we get to the kernel so if
we don't fully understand the configuration we're doing we seem likely
to find some configuration where we miss things.

--3VH1SAMC12vKu3aE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaWOMAAoJECTWi3JdVIfQMJkH/i6uPUSyCZIzPffFPthJw2Vb
KpVwq2s8OdpX82UNG/m4Yd7lH7GrVvixdAVnBtI6tR9HO3wBI/2eCCcBSXX0H7WT
JmxqXK5Yk6Vqi6JmKppecQk1PtYhli7alaIOobvI4GjCplEnQIH9Ky+4O27wIQS2
Pg0JZp53Q0QqqVUYc+S6hmCId1SYqmNC14WO3kCK7y/NFwc+hanpVE1iAM5U6w4e
jMwl2ZYXGMYSwBOf7SwfGQMk/ioHnfo5u9lQCFYqLJNz0srdVFjf7nOCFg4/NW4r
klWrVgJ7Bb3Vo8FFTITap8FApD7OPnVO8DS4T4WqQKMVRlbzlPFqBXhgLvI/Xso=
=Eiwj
-----END PGP SIGNATURE-----

--3VH1SAMC12vKu3aE--

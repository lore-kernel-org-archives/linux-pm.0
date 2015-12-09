From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] cpufreq: tegra: add regulator dependency for T124
Date: Wed, 9 Dec 2015 14:47:34 +0000
Message-ID: <20151209144734.GB5727@sirena.org.uk>
References: <2194927.eV2s2QmZs0@wuerfel>
 <5668188F.2080202@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="leQ0ainWKcxhm+Q3"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5668188F.2080202-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--leQ0ainWKcxhm+Q3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2015 at 12:03:27PM +0000, Jon Hunter wrote:
> On 08/12/15 21:52, Arnd Bergmann wrote:

> > My first attempt was to implement a helper for this function
> > for regulator_sync_voltage, but Mark Brown explained:

> >    We don't do this for *all* regulator API functions - there's some wh=
ere
> >    using them strongly suggests that there is actually a dependency on
> >    the regulator API.  This does seem like it might be falling into the
> >    specialist category [...]
> >    Looking at the code I'm pretty unclear on what the authors think the
> >    use of _sync_voltage() is doing in the first place so it may be even
> >    better to just remove the call.  It seems to have been included in t=
he
> >    first commit so there's not changelog explaining things and there's
> >    no comment either.  I'd *expect* it to be a noop as far as I can see.

> In this sequence we are switching from the DFLL clock source (which
> directly controls the voltage) back to a PLL (which does not control the
> voltage directly). What we want to do is to restore the voltage back to
> the voltage it was operating at before we switched to the DFLL clock
> (which could have changed it).

If changes implemented by the clock driver are trashing the regulator
settings I would expect the clock driver to be responsible for fixing
things up rather than another driver that happens to use the clock.  I'd
also expect some kind of internal documentation explaining what's going
on, and possibly=20

> I am not familiar with regulator_sync_voltage() but from the comment it
> does say that it will re-apply the last voltage that was configured for
> the regulator. So I can see what they were doing. The question I have
> is, if the consumer has not explicitly called regulator_set_voltage()
> then what does regulator_sync_voltage() do? I am wondering if we should
> have been doing a regulator_get_voltage() during the probe and a
> regulator_set_voltage() when switching back?

This *is* the sort of thing _sync() is intended for, though it's mainly
expected to be used in cases like suspend where things have been powered
off.  As you can see from the code it's based on the settings that
software made, but then if nothing in software has any need to configure
anything then why do we even care that the hardware changed anything?

Setting the voltage you've read back sounds broken, if the hardware
might randomly change things how do you know the settings we read were
sane?  Shouldn't we know what voltage range the device requires in a
given mode and set that - that's much more normal?

--leQ0ainWKcxhm+Q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWaD8FAAoJECTWi3JdVIfQTykH/39vqFHeNi+inGYjrMQ1c8I2
6SFhKeWNSZ+5lweeQyVoBrAzgA+w4gAz8McXhH4zyp6scztbS+QW8FxmOSpZELQF
8AizTencTwC0IeofS+d4sRa123MevWpRzFw5rZRoT3W7WiW5CcJJiEQyt6MkgmkT
ON5oJdcvPUxVf/3rycuv2X1NLn8bIRgW0r/81q2SzV+iMMa3pTw4Cbc1Ufi6tSp5
T8OxJTggNCAUflTPOKbkurF/it3zBYgHqX3nJwdV78mkToLv2Aq95BVqd5m0bht5
JIm7JBzHDg5Ahwj8Yq8IQtnHv+JN/k2HIVHwZWKYx7qlOwsoiv/6NFcI/KqFgKo=
=Ax/h
-----END PGP SIGNATURE-----

--leQ0ainWKcxhm+Q3--

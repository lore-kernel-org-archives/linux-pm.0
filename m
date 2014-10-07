From: Mark Brown <broonie@kernel.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 18:08:00 +0100
Message-ID: <20141007170800.GL4609@sirena.org.uk>
References: <20141007114844.GT4609@sirena.org.uk>
 <20141007164643.GA3748@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYOwxzDtEZWltKxP"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141007164643.GA3748@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mYOwxzDtEZWltKxP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 09:46:43AM -0700, Greg Kroah-Hartman wrote:
> On Tue, Oct 07, 2014 at 12:48:44PM +0100, Mark Brown wrote:

> > The power management team at Linaro has had a look at the cpufreq
> > updates since the v3.10 LTS and identified a few patches that look
> > like they should be in there.  The most recent of these is from v3.12 so
> > they won't apply to any of the more recent stable kernels.

> >  - 59a6342203a7a cpufreq: Fix governor start/stop race condition

> >    This looks like a straight race condition fix.

> That is not a commit id in Linus's tree :(

Interesting, I was able to cherry-pick it...  looks like the upstream
version is 95731eb.  In any case at roughly the same time you sent your
mail it's been drawn to my attention off-list that this was subsequently
reverted so please ignore this one.  The others should be fine though.

--mYOwxzDtEZWltKxP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNB3wAAoJECTWi3JdVIfQpeEH/2CC5NumQx2L8q9kWE8hFDDS
BwTK1aRGMeRB2bym8CifQ3kkynb3Sirj3ZaXd6dHduOAdlpK7NubeSFZlixXcNOs
Z/80bFiQJlWG9N8HbsYqD+mPzm9QY2zVr48wluQtql4oK3/qtW7qWTwTeOAUlHbL
P5TeFV9U0mMun+kTf7D67QUOjKOW9Ph5axLg9EFLjIKo1yQGMi85+cKG9Q2YOnrI
GaBEL4lJaQaATyCSgc0GVRgJ/n3g1Z4WpwdfUJqIiW1vU5LGfJEkfF2BbB7FO1v+
u1q/pwKDZf4e59O9RS8JARGh6mwrCouIugl2nsheZm/w+GF1BHCVzTuPrUTGObQ=
=0o9k
-----END PGP SIGNATURE-----

--mYOwxzDtEZWltKxP--

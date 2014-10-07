From: Mark Brown <broonie@kernel.org>
Subject: Re: Potential cpufreq backports for v3.10 LTS
Date: Wed, 8 Oct 2014 00:07:19 +0100
Message-ID: <20141007230719.GP4609@sirena.org.uk>
References: <20141007114844.GT4609@sirena.org.uk>
 <20141007164643.GA3748@kroah.com>
 <20141007170800.GL4609@sirena.org.uk>
 <20141007200458.GA12028@kroah.com>
 <54345CFB.7070101@semaphore.gr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NsYpzUZ4z5mp8BBz"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54345CFB.7070101@semaphore.gr>
Sender: cpufreq-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiaoguang Chen <chenxg@marvell.com>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Amit Kucheria <amit.kucheria@linaro.org>, stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--NsYpzUZ4z5mp8BBz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 12:36:59AM +0300, Stratos Karafotis wrote:

> For your information, commits:

> - 61c63e5ed3b9 cpufreq: Remove unused APERF/MPERF support
> - cffe4e0e7413 cpufreq: Remove unused function __cpufreq_driver_getavg()

> remove unused code (no other functional changes) as a result of
> commit dfa5bb622555. They all were part of the same patch set.

> I'm not familiar with the procedure of patch inclusion in stable trees,
> so please forgive me if this mail is just noise.

If they're just cleanups and not producing a functional change then the
standard thing would be to leave them out of stable.

--NsYpzUZ4z5mp8BBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNHInAAoJECTWi3JdVIfQOB8IAIJGtQeG5wj0/eMMWXyDeQir
c4rpD8yGRsRXYYXWBYqAcabkQbsyrRLSBZ86EBgMmnl98N1QtswWjO8ivFUHeR25
OxqE/AOCov6EMSAaOfguxdi2ufFuNY64B+65qlDl1/ADMjDyTFpQJP0ln7+eA0cU
1yqdKrv5lanAOMq08vbwAnq/Za0DbLB9sPqWknWBbBwYQIQlqDXiJFTP1ZZ7TUiO
Vi37Y6TI7qrYSd224yVKSugcOFVjLF0HxUrc1aRHPqz7gfG3ounHCeUdKgYg7IzU
sqEdX3sSJB3u8xoTnwtYYIOsKydW0Zc6Af/cCYH0PnCQq4uRCnmnINS8xGAIl1U=
=USVq
-----END PGP SIGNATURE-----

--NsYpzUZ4z5mp8BBz--

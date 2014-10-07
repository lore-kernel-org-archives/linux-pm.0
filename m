From: Mark Brown <broonie@kernel.org>
Subject: Potential cpufreq backports for v3.10 LTS
Date: Tue, 7 Oct 2014 12:48:44 +0100
Message-ID: <20141007114844.GT4609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5tINJiUS2/Dn5Rhr"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
Sender: cpufreq-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Xiaoguang Chen <chenxg@marvell.com>, Stratos Karafotis <stratosk@semaphore.gr>, Andreas Schwab <schwab@linux-m68k.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, linux-stable@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5tINJiUS2/Dn5Rhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The power management team at Linaro has had a look at the cpufreq
updates since the v3.10 LTS and identified a few patches that look
like they should be in there.  The most recent of these is from v3.12 so
they won't apply to any of the more recent stable kernels.

 - 59a6342203a7a cpufreq: Fix governor start/stop race condition

   This looks like a straight race condition fix.

 - 19c763031acb8 cpufreq: serialize calls to __cpufreq_governor()

   The commit message here outlines a scenario where this change fixes a
   crash which seems like stable material to me.  There is a context
   change that needs a fixup but it's fairly trivial:

diff --cc drivers/cpufreq/cpufreq.c
index c34d4423f298,7e6baa58a7f2..000000000000
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@@ -1586,8 -1692,10 +1586,9 @@@ static int __cpufreq_governor(struct cp
  						policy->cpu, event);
 =20
  	mutex_lock(&cpufreq_governor_lock);
- 	if ((!policy->governor_enabled && (event =3D=3D CPUFREQ_GOV_STOP)) ||
 -	if (policy->governor_busy
 -	    || (policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
 -	    || (!policy->governor_enabled
 -	    && (event =3D=3D CPUFREQ_GOV_LIMITS || event =3D=3D CPUFREQ_GOV_STOP=
))) {
++	if (policy->governor_busy ||
++	    (!policy->governor_enabled && (event =3D=3D CPUFREQ_GOV_STOP)) ||
 +	    (policy->governor_enabled && (event =3D=3D CPUFREQ_GOV_START))) {
  		mutex_unlock(&cpufreq_governor_lock);
  		return -EBUSY;
  	}

 - a857c0b9e24e3 cpufreq: Fix wrong time unit conversion

   As noted in the changelog this is a bugfix for non-tick based
   systems like full dynticks ones.

There's also this:

 - dfa5bb622555d cpufreq: ondemand: Change the calculation of target freque=
ncy

   This is a small patch which delivers a useful performance improvement
   but it's not a bug fix and it does touch the cpufreq core so it
   doesn't seem to really fit.  On the other hand I've got user reports
   that it fixes problems with some multicluster systems that can scale
   cluster frequencies independently (the additional stability in the
   frequencies selected avoids poor interaction with scheduler as cpufreq
   ramps the frequency while the scheduler moves load away from the
   cluster), it's simple and it's quite well isolated so I wanted to
   mention it.

Thanks,
Mark

--5tINJiUS2/Dn5Rhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUM9MbAAoJECTWi3JdVIfQ3OUH/1bgPj9xGngGPAb6Fm2C1T8X
7dzZEDjiNSc9YSmp2Q20xA1bA/o8a7s8AioRbLOwFlvIp1nQzpH8MKMJBcvxEZJv
BUliN9d5fmQ9pM+3TejTlIGGGMBaWo9I8DvqhL7WfopYEcmgveNVbN12+dK4TSff
NnhVZgHaIOaCOWarf8pnLhabyXv4CdbhD2r8i1Km0KwbpAnNyLKA8Tb1jI2B82Cl
ad5Ys4C4SGUUtS1Sc3gITnpv88TVZsI2gftlHgUVCWKfbHMCxP7x1BsrisPrlJyN
02OrCVeOJXpFcWoQccsuWxxpsPbOGtGDMwGR8I0Ccrx8Yz7N8P8onGZYdT1LrvI=
=gFVX
-----END PGP SIGNATURE-----

--5tINJiUS2/Dn5Rhr--

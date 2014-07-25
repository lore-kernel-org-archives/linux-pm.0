From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/16] regmap: Add regmap_get_device
Date: Fri, 25 Jul 2014 18:43:11 +0100
Message-ID: <20140725174311.GA17528@sirena.org.uk>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>
 <1405957142-19416-2-git-send-email-ttynkkynen@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kNWh/WJk9f5Nf1i0"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405957142-19416-2-git-send-email-ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--kNWh/WJk9f5Nf1i0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2014 at 06:38:47PM +0300, Tuomas Tynkkynen wrote:
> Add a new function regmap_get_device to obtain the underlying struct
> device from a regmap.

I've also created a signed tag for use in other trees:

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/getdev

for you to fetch changes up to fa2fbe4a981a70866d20cee62af0d89eb6b6027e:

  regmap: Allow regmap_get_device() to be used by modules (2014-07-25 18:30:31 +0100)

----------------------------------------------------------------
regmap: Support for retrieving the struct device for a regmap

Some hardware has support for regmap style operations, this is
especially common with embedded controllers that interact with PMICs.
Allow drivers handling such devices to get the device from a regmap to
aid in supporting such functionality.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

----------------------------------------------------------------
Mark Brown (1):
      regmap: Allow regmap_get_device() to be used by modules

Tuomas Tynkkynen (1):
      regmap: Add regmap_get_device

 drivers/base/regmap/regmap.c | 13 +++++++++++++
 include/linux/regmap.h       |  7 +++++++
 2 files changed, 20 insertions(+)

--kNWh/WJk9f5Nf1i0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT0pcsAAoJELSic+t+oim9q3sP/jcyPDZiWu75iid8XwQUp29X
jG+786R1KH0v6FnVQIYO3t9NNrhQR82AXv7Iubvvvvs2yFyZOO+oMTvuWVe+OPIM
seEklyt7Bw+ClFkTRzJ5vnTOgai40+IksojvchsnPhEQqHGOytg3JpkeIekU7nKi
5Sacwz5kQY6zgWKCiCON2WK8XTpSUPcOVgGzRwz7cnmQxZHl3FP1wofXGMXub2Yz
8MR5Iom9rvgP6q9lW9CCivc8XQnAXH4SVV76Ox2+NPrSwVRKRjQYjw56i4lYn3c9
UrP0PreCRq3T8OWOq2dhZy1Ysb837pR4djR0vWKuRWrdWQOUHtUroG7j6dwCu9Tf
2Bq9PqdOEnjDnByQiOQgPgNV7a+Rak06rjMks6/HMy8EqXn1I3EyChzCJHbBKxbQ
jaTuBoDzSOWfclSwRce75jlUA9V03vtchFvAQKMjxyV64GAAVV5+o+9BtrlDWqgc
qYyJkRE9+HbGC4zuJKLTCJUPT4VDz7VeG8Sh6CDXyWX1ANfcaFIhm6fPoqd4vOYF
jYkni1RJ5gfKC9/dl1yb5bCORt2PBtyP2+XQs/+xI3LfbHBs2hlLKSVuJCYTzOnR
PRQ5CLnZPV9mCieXaQZd+k3PpjoMn2BZFKcw5gGCO553AlVLJd7VwYexUUdzViYK
K05mICwMg6r296Q7BrOe
=4fGo
-----END PGP SIGNATURE-----

--kNWh/WJk9f5Nf1i0--

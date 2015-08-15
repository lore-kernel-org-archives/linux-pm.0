From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2] thermal: cpu_cooling: fix lockdep problems in
 cpu_cooling
Date: Fri, 14 Aug 2015 18:10:16 -0700
Message-ID: <20150815011015.GA4125@localhost.localdomain>
References: <16e7d7d811fa2b0f8dcf6cade345a5f2f3e3c36a.1439372926.git.viresh.kumar@linaro.org>
 <20150814055556.GZ20238@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36218 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbHOBKU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Aug 2015 21:10:20 -0400
Content-Disposition: inline
In-Reply-To: <20150814055556.GZ20238@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>, open list <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 11:25:56AM +0530, Viresh Kumar wrote:
> On 12-08-15, 15:22, Viresh Kumar wrote:
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > Fixes: 2dcd851fe4b4 ("thermal: cpu_cooling: Update always cpufreq polic=
y with
> > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >=20
> > Hi Eduardo/Zhang,
> >=20
> > This is 4.2-rc material, please apply soon.
>=20
> Hey,
>=20
> Please apply this one and drop
>=20
> 8ad61f934e9e ("thermal: cpu_cooling: fix lockdep problems in
> cpu_cooling")

OK, I am having a looking at this.

>=20
> --=20
> viresh

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVzpFxAAoJEMLUO4d9pOJWu+4H/19isqllWGhRlldhs8zsz4iG
ZzOI+4quF1XP47GXd7xlk3hYC7xpjWaSmzHF2+Uw7QV46iuXXPMtuwI9Yr1rujBQ
23J06wTcuJjP2i2+dB/JAbta76+30heG1A1EDHT5eQ8bIsBkLujznXkJsmbazwIH
wf44o/hHAMIHUjRHE7XPV1f7qGW42xlep1dYRrxjutWfAZt4a3UKgezBmr0pTis+
nPo2dqmtNhVM6ZSLKTxSBTw4gS8n1mpiXCzpvE7GpA1uVaSI2U0yoNm8ZuWHo5VK
hfeS0JQ+gheHgl5vBFTaBqiqnYPVRdYHzUGUj9Y/1wAEfiN+eclhJeXr6VTVCKI=
=AVrP
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

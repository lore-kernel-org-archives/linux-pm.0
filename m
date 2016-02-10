From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20160210 build: 2 failures 4 warnings (next-20160210)
Date: Wed, 10 Feb 2016 09:52:52 +0000
Message-ID: <20160210095252.GS13270@sirena.org.uk>
References: <E1aTQoy-0005cH-Tr@optimist>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wnBGVoaGQwxWUIo6"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1aTQoy-0005cH-Tr@optimist>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--wnBGVoaGQwxWUIo6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 10, 2016 at 09:12:25AM +0000, Build bot for Mark Brown wrote:

Today's -next fails to build on non-SMP configurations due to:

> 	arm-multi_v5_defconfig
> ../drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]

caused by 0144fa03ef4606ae (cpufreq: governor: Replace timers with
utilization update callbacks).  IS_ENABLED() in an if statement doesn't
do a good job of making things conditional here since the code still has
to compile cleanly in both cases and there is no definition at all of
irq_work_queue_on() for !SMP.

--wnBGVoaGQwxWUIo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuwhyAAoJECTWi3JdVIfQ+sAH/1dAzTF2pTuG9wKtSo6K3aGP
avVB8jZQA1dbCXLXa+cRH6XBltE1VZzLMr5fGIVo5OHMwSYOaFqk0Us4SVC0K3dJ
+PIlfiYMBwQzoUjCf16DoMFH+xSY4nUOZmGo4TzaD4cfg9Ni+J3Mawo6p5zTXxby
nE+vGEal6HNk24Z1EepVJUVi3VgUDLobDYzPB+D4W0KQU50lQKcY3D1yT5hjwALA
ktnVFZfTuiiWyKZy4EqTCsQpCM9UBbyE9UxV/Bp3GA0aZZrITSXgk8bjIJ3a7Dr0
PCutSJaPf6rJ7M/hZMO+TknEyMqheZ5KT6zOjH9lWZWWE5oLMEe1P1QsF4ZFolY=
=1RUA
-----END PGP SIGNATURE-----

--wnBGVoaGQwxWUIo6--

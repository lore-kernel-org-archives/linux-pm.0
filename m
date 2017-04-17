From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Mon, 17 Apr 2017 10:34:34 -0700
Message-ID: <20170417173431.GA10447@localhost.localdomain>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33774 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752807AbdDQRej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 13:34:39 -0400
Content-Disposition: inline
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Apr 17, 2017 at 11:31:45AM +0530, Viresh Kumar wrote:
> Hi Guys,
>=20
> The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> high thermal states for a platform. But it wasn't glued really well with
> cpufreq core.
>=20
> This series tries to improve interactions between cpufreq core and
> cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> driver.


Can you please be more specific of what exactly is not gluing
properly/really well? I like refactoring, as long as well justified.

Do you see anything broken currently?

Or is it more of a optimization in terms of data structures and how
things are computed?


>=20
> I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
> pushed them for 0-day build bot and kernel CI testing as well. We should
> know if something is broken with these.

Nice. What governors did you try? Have you checked "power_allocator" by
any chance?

>=20
> @Javi: It would be good if you can give them a test, specially because
> of your work on the "power" specific bits in the driver.
>=20


@Javi, are you still around? This needs to be validated in terms of how
the cdev states and power models are computed. Just to make sure we are
in one piece. Copying the ARM folks too, Punit?.

I will see if I have some time later this week to check if IPA is in one
piece after this series.

> Pushed here as well:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cool=
ing
>=20
> V1->V2:
> - Name cpufreq cooling dev as cpufreq_cdev everywhere (Eduardo).

That was just very minor stuff. Overall, I do not see major issues, but
I want to spend some more time on this before acking on my side.=20

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9PyiAAoJEA6VkvSQfF5TJpMQAKYdkxMAVn6zzz0N/AX+fP+z
96W4aDBWJ77u506xqEZ9/Bna61KkAaRIMVAQSRcFfusexjN7qoI/voYvlBRvv1Gw
8s0moLqMdRb6JKYM8Cj00jubuAjADiX08AYGJi3DrSqrL4dLvmmP3dSrq17HPuzy
VEyVz1iCB3Ec6uak6VDahNmO/BJ7S4Q7VeOkKMN9YAilutE49jpP4FYuitSTXtZD
P4IUDea4qqXqvOid5HVUHWyPaq7M3LCAE3RFCV4TQGHY1puCUvpE4dBPUvd9Ns2z
fVSA8Gq1oXN3AQ76tqYlXqu+WRP4unYQq7bGU9uN5BIpj77tMiV2CFIInOiwg9mn
UJTBSY1aX7yhvc/e+81CFh9NlUYCm/6HYurr9T5B2XgAJwzu59nuSxpEf8JZ5p/c
smFlS+doPY1EXQSQQwrrrwnoVtvf6P6ernALJehX5M9hGPfAqJ7ZJtBFkDkItY28
layc5qeiUUYl6zgbkVruWdOm2O1qkNo/3ktfXuui6CQ8bWXXfCgMZ7N4iBE1jQbV
zssTxK9RPvcva1ykSySjqurUdP5bUrzb3c+2qat12CDpqfqFE67fLSUpm13pVf4Z
eYDOyhg2ID6UAUu2148qCH2MGm+u3FI/EyRiRi7nWf0judC/+KhJGpYGRBc9xA14
iOmnZLTdXyqOvCEpfPkc
=z9g9
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

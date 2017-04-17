From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Mon, 17 Apr 2017 10:51:52 -0700
Message-ID: <20170417175150.GB10447@localhost.localdomain>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
 <20170417173431.GA10447@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35074 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755119AbdDQRv5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 13:51:57 -0400
Content-Disposition: inline
In-Reply-To: <20170417173431.GA10447@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, Punit Agrawal <punit.agrawal@arm.com>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Mon, Apr 17, 2017 at 10:34:34AM -0700, Eduardo Valentin wrote:
> Hey,
>=20
> On Mon, Apr 17, 2017 at 11:31:45AM +0530, Viresh Kumar wrote:
> > Hi Guys,
> >=20
> > The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> > high thermal states for a platform. But it wasn't glued really well with
> > cpufreq core.
> >=20
> > This series tries to improve interactions between cpufreq core and
> > cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> > driver.
>=20
>=20
> Can you please be more specific of what exactly is not gluing
> properly/really well? I like refactoring, as long as well justified.
>=20
> Do you see anything broken currently?
>=20
> Or is it more of a optimization in terms of data structures and how
> things are computed?
>=20
>=20
> >=20
> > I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards and have
> > pushed them for 0-day build bot and kernel CI testing as well. We should
> > know if something is broken with these.
>=20
> Nice. What governors did you try? Have you checked "power_allocator" by
> any chance?
>=20
> >=20
> > @Javi: It would be good if you can give them a test, specially because
> > of your work on the "power" specific bits in the driver.
> >=20
>=20
>=20
> @Javi, are you still around? This needs to be validated in terms of how
> the cdev states and power models are computed. Just to make sure we are
> in one piece. Copying the ARM folks too, Punit?.
>=20
> I will see if I have some time later this week to check if IPA is in one
> piece after this series.

Now adding the ARM folks for real.

Lukasz, can you please give it a shot on this series to check if IPA is
in one piece?

>=20
> > Pushed here as well:
> >=20
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/co=
oling
> >=20
> > V1->V2:
> > - Name cpufreq cooling dev as cpufreq_cdev everywhere (Eduardo).
>=20
> That was just very minor stuff. Overall, I do not see major issues, but
> I want to spend some more time on this before acking on my side.=20


BR,

Eduardo

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9QCvAAoJEA6VkvSQfF5T0dcQAKmwJgY8mm90a/F4X3wGA9XY
M3z54/sS5D+NmtSqaboReTdkvQAN2OTNrOA+4Ceu8a0gsz34eTPNCmlu3CRoRXxi
UP4kozIRNNYxojqHLmutC/ZrPZVcJrzR0ISx/pQHARPpyp/1OrtEg6slu8odZ7CI
FWLE2NgAAoS0hyn2MApAMkFyRVD5wIgKhAWw5op5fAVxZQ5sJ8MYuqbxS0OXyxBf
kfdidV9uae1LGKGy9oSC+F09dWrXwQBsYL5oI7X3z+6wFWzkplVYJrt5QiNT+4Fl
Kf6NHZNGekf8Gi491VQAtVoYbXS7Hthd8NrQmCYVfJeF6AvxVtj/xuAIrcvwcUkc
XWZHgGw3tycAWtz+h187/oEu/O/CIISFV/TPtBGpIzKOVfDEwZJqko6JRlDvnkGi
6ZAbmDB0rxX0yJrO8fXc4EUfn0TaIxuIRojOVo03Y2I4hMoC446uxT80zfQriGcz
KDNqT+Uq1IXEh6UiUx9XRXy5IZZVsy48Jh9feIDvL3jcCQ4eQZxiKshq/SGGkfYE
R8uec1UhheN8weID6zVGWaoQXKRQkjQ89HRbX7Pxs/n5yTc2daf8nwWybHCyW9lq
jH8ZCcht6x6d1VyUL+93gtOGYaaLt73zv2XWtnKOmoVRvE9uPvRGpTXNyRcLNa5D
5lTkgw3eA9HKSHoRkq4F
=5h4k
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

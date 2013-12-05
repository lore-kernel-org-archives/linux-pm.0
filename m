From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: enable ARM drivers on arm64
Date: Thu, 5 Dec 2013 20:35:19 +0000
Message-ID: <20131205203519.GA29268@sirena.org.uk>
References: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
 <1386202994-30784-2-git-send-email-robherring2@gmail.com>
 <20131205181606.GY29268@sirena.org.uk>
 <52A0DC28.1040001@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8MNCZdTuKvcKRZar"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <52A0DC28.1040001@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org


--8MNCZdTuKvcKRZar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2013 at 02:03:52PM -0600, Rob Herring wrote:

> Will do, but I'm surprised we're at the point on arm64 of needing LSK.

ARMv8 isn't just for servers, and of course there's the desire to have
the software as ready as early as it can be!

> There's a couple of subsystems that need enabling. I've posted EDAC
> patches (need to send v3). cpuidle is another. Probably some more I
> haven't looked at.

Right, cpuidle is in progress - Lorenzo has been posting patches for
that: =20

   http://lwn.net/Articles/574950/

There's some active work in the trace and debug area too.

--8MNCZdTuKvcKRZar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSoOOEAAoJELSic+t+oim98xoP/0TLsIEw/QlwHgf4/RvQ3X9L
3LG1saF/8gxwabEiYdnKCqDPYVCTlcVOHnUUUOIGmC87wCcrP0saIfMVSQcAUOVZ
030yjm/XlRXgECGqnOVG1Bw4lQElnDEM25rA7mdjQcs95llSabNcGY4LKf04s6Me
x6qN/qfc4bBBLjmPplG/QU/2HLVe1QSDAS0DgC76jWNkgx4+iciE3hebrqjlDytM
jKcx9iCMMIYdqnFC7BCCg1M/52nITeIGM7+09IwAVOgJl9y7Pc8Wi9YBbr/Fw3Ti
9NXKsCQDISSauLe8GuYhUN9neUCHOMX6YKZnhQV2KbXAlHpp7oPej1qQaN4UbEfm
A6np9/PWtwFU1d4Q7Q81usfLLoWGuAPBcu8UrVM3lPbOfLDSWXatBE5kY0HaJ3oY
xZ4S/7/WpBjoWv7BtNYPK+v7A2Vq09qnrexii12LVXffU9pVEk1EY2mS66qZfaes
C0kcPodwxjYi0VOlILAV/l7qGIjfkY9ujzM9mVA1ECAwke3x+Mg79JIo9FrPpMws
slX+uM7cJRaajVMwH83M6cF5jMwkx3vk0gmYAwsFRoRCBwKNdQ/E7XgztO6Xdm4v
79s41efqAAF1YYGHFkHp6v1W3g51NZldFD0ZRZHbp/kIV/DQl3KwMHY9RgH/aBW/
jrufQPkMWOx83/uOnE0W
=qoqq
-----END PGP SIGNATURE-----

--8MNCZdTuKvcKRZar--

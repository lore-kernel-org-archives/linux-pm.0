From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [patch 33/39] power: reset: ltc2952: Remove bogus
 hrtimer_start() return value checks
Date: Thu, 30 Apr 2015 17:49:30 +0200
Message-ID: <20150430154930.GE6133@earth>
References: <20150414203303.702062272@linutronix.de>
 <20150414203503.322172417@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60080 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbbD3Pth (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Apr 2015 11:49:37 -0400
Content-Disposition: inline
In-Reply-To: <20150414203503.322172417@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Marcelo Tosatti <mtosatt@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Frans Klaver <frans.klaver@xsens.com>, =?iso-8859-1?B?UmVuw6k=?= Moll <Rene.Moll@xsens.com>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 14, 2015 at 09:09:20PM -0000, Thomas Gleixner wrote:
> The return value of hrtimer_start() tells whether the timer was
> inactive or active already when hrtimer_start() was called.
>=20
> The code emits a bogus warning if the timer was active already
> claiming that the timer could not be started.
>=20
> Remove it.

Thanks, queued for 4.1-rc with Acked-By from Frans Klaver:

http://git.infradead.org/battery-2.6.git/commit/d8818257d3befce6ce7da4c0911=
2654914c3fd58

-- Sebastian

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQk8KAAoJENju1/PIO/qaq4oP/1muC47BRn2EBjaRZZRJlZz5
rwBdlRyvMZpN9ZTzTM43kp3LhR6DwbmTwGLiPzAe0zbGPkCCmF3clL47JdiZEBdK
nsF75Pq3y2bTjZdhWGpKRFHLzBQhuXR2RPlPRF/k9DPBju32dUVuZqQVnPQjeP8O
sszSq3hhQ+zqjWbF2GspYu4ZxP+pYyRRXMKqaioWEk9Pjbt1cz4L/UYKcTaLqJ8p
L4VV6JWVsCyCQgHIMx9bfcpHvOYRQtMceApjnSPMlREop4+HQxK8jhfrObpV+f2K
wBGYXfF8JT1UqaT7e9qIiA8aOM4LyH2XCC0MQY9neFmwFuMyA/93tm1jCuVvsvzW
6oqLqTnlPUt7dE5BKOXrkN/H3Rg8yQ8BbdrAiG9XlNP98iH7Xfc8B7pcywecBoCR
x90bhuMp+j70sGBQkT35rljJVEuxO3Ir2+vGzDl13VAy4S+vJw/sS57JwhTJ59S2
HB3DENiXcDOtpfj0AgZ1GJkG7u0nR3llAc3L+fNhxseiv0/dunrvi1XJ+Xp+6Es0
geno/vOG2yensyAqlHxSUH070dtcJ0sNkvDhAPtCKR1VVyWDpgqjLoJZsYWF19NG
mh+Rdm/p3QsO3ezyYXflaxJG1c28AK4T9jGqQbUHJcWayAGCvkPa145JTcNzau4W
rKyG5rA9SOBVwWIfK4w2
=SpT3
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Wed, 2 Mar 2016 20:24:10 +0900
Message-ID: <20160302112410.GN18327@sirena.org.uk>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <CAKohpo=fcab=eisbwMw=wvbmuXVY5iw_CSe3QK1Ax_i-56JAzA@mail.gmail.com>
 <20160302025016.GS18327@sirena.org.uk>
 <20160302102831.GE2891@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qfhGh+n0qZvgfnwu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:52392 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbcCBLYW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 06:24:22 -0500
Content-Disposition: inline
In-Reply-To: <20160302102831.GE2891@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Dave Gerlach <d-gerlach@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <rob.herring@linaro.org>


--qfhGh+n0qZvgfnwu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2016 at 03:58:31PM +0530, Viresh Kumar wrote:
> On 02-03-16, 11:50, Mark Brown wrote:

> > I'm really not sure what I can say here that I've not already said
> > repeatedly, what's new here?

> Yeah, you have raised some genuine concerns earlier, like the sequence
> in which the voltages of multiple supplies should be changed, and if
> we should rely on some DT sequence for that.

> I started it again, because we have a real case now (not like the
> virtual case earlier) where a platform has multiple supplies for a
> device (CPU). I just wanted to hear from all of you on how should we
> go ahead and solve it.

> TI guys had some crazy ideas, like using OPP-notifiers to update the
> second regulator, etc and I really hated it :)

My main thought with this stuff is that if it's really complicated to
write generic code that might be a sign that it's sensible to write a
custom driver.  We can always writee something later if we figure out
some general patterns.

--qfhGh+n0qZvgfnwu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1s1ZAAoJECTWi3JdVIfQQOAH+gOgFqL4T34QDaYhpJVh1Jd4
4VYBZWqkpvpUQiUQjJDIRFxa50Wlcxj56jF4Adat1qZA/E0HHTzqYdjYgiwsdsIq
sD3tBZmjxHLaVL6PuwlLSq9j1PXvYG8W7N8Ju2ODOjkPrd9mY9rY/ZPf2ZA29gnR
PiIJB9dDmWPn0do/zwtVlYMrCMnbodL/F43aFojA+z+1C1hEaj0AKl2aqLRmmBjP
RH2UJ+NGQPYrYC1wXf9FlKmJqqN25VYJ7KNPpIidZPkHrh+9F3B/3DscdgTRwONn
pO+8PwzUUwjbZKj+01UT8m4kl2jflggw2F6CsqkdPIHG1pAt/SJqa3463a40FvU=
=mNp9
-----END PGP SIGNATURE-----

--qfhGh+n0qZvgfnwu--

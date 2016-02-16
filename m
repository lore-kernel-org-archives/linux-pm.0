From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 13:11:08 +0000
Message-ID: <20160216131108.GK18327@sirena.org.uk>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <20160216010059.GH6334@vireshk-i7>
 <20160216015616.GH18327@sirena.org.uk>
 <2628515.OmmYzoeulx@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3MHXEHrrXKLGx71o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53935 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086AbcBPNLg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 08:11:36 -0500
Content-Disposition: inline
In-Reply-To: <2628515.OmmYzoeulx@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>


--3MHXEHrrXKLGx71o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 16, 2016 at 10:10:44AM +0100, Arnd Bergmann wrote:
> On Tuesday 16 February 2016 01:56:16 Mark Brown wrote:

> > No, NULL is explicitly not something you can substitute in,
> > essentially all the users are just not bothering to implement error
> > checking and we don't want to encourage that.  The set of use cases
> > where we legitimately have optional supplies is very small, much smaller
> > than clocks, because it makes the electrical engineering a lot harder.

> I must have misinterpreted the idea behind that API as well then.

> From this function definition:

> static inline struct regulator *__must_check regulator_get(struct device =
*dev,
>         const char *id)
> {      =20
>         /* Nothing except the stubbed out regulator API should be
>          * looking at the value except to check if it is an error
>          * value. Drivers are free to handle NULL specifically by
>          * skipping all regulator API calls, but they don't have to.
>          * Drivers which don't, should make sure they properly handle
>          * corner cases of the API, such as regulator_get_voltage()
>          * returning 0.
>          */            =20
>         return NULL;
> }

This is the stubbed regulator API which is only ever used with the stub
regulator API, it uses NULL to give a non-error pointer it can return to
well written callers so they don't know they are running with the stubs.
We are explicitly using NULL because callers should treat it as a valid
regulator.

> my reading was that the expected behavior in any driver was:

> * call regulator_get()
> * if IS_ERR(), fail device probe function, never use invalid
>   pointer other than PTR_ERR()
> * if NULL, and regulator is required, fail probe so we never
>   use the regulator

No, drivers should never look at the value of the pointer other than to
check it for error.  If there is a problem of any kind an error will be
returned.

> * if NULL, and regulators are optional, continue with the NULL
>   value.

No, we always return an error pointer if we fail to get a regulator.
The difference with optional regulators is in how we handle the
situation where we have full constraints and a regulator is not mapped
in, normally we assume there must be one with no software control but we
need to work around buggy bindings as the device would be non-functional
without power.

> * drivers never look into the regulator pointer, and only
>   pass it into regulator APIs which can cope with the NULL
>   value when CONFIG_REGULATOR is disabled.

> That would be similar to what we have for clocks. Which part of
> my interpretation is wrong?

See above.

--3MHXEHrrXKLGx71o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwx/oAAoJECTWi3JdVIfQxKUH/j+x6HkVB1FS6W4t70WFEzm+
UKnw6XyguPvWQf9FkcaklL6Exc7vOmqnmvevGBKGlV+kDIn1SIM9Uf68zBkwjAbV
0XHlTlEaCEJoSxBbUPFZAiO0dXdtgDi3XvKqcxN2aF+ZNtkza6jSE5ERZPMd+fvM
CNN0PZtwbtM9K8phRP0XKcGaKip7uyg1Mnury8rTs6cdZwqkXHIWxWuda5div7eJ
8wFGK3i57bClF/qzRSakPvMEOH1IwH8XxUMo7vpkkb1ogSOY97tFLOQ69T6Jxjz4
zEoKDEiNlqwDEPBppQa+QXvWf6u9oy0OAiT9P4GOaDc7/9SDoPKcqp5xqRbe3nY=
=b7Wt
-----END PGP SIGNATURE-----

--3MHXEHrrXKLGx71o--

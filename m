From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
Date: Fri, 7 Apr 2017 12:22:12 +0100
Message-ID: <20170407112212.gzv3p7ldkh62657m@sirena.org.uk>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
 <1490704781.3546.57.camel@nxp.com>
 <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
 <1490730595.15830.1.camel@nxp.com>
 <20170406185202.uixxcv3dgucrddgc@sirena.org.uk>
 <1491562312.9365.41.camel@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zx65g25cvfcfr47"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41598 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752971AbdDGLWj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2017 07:22:39 -0400
Content-Disposition: inline
In-Reply-To: <1491562312.9365.41.camel@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawnguo@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--4zx65g25cvfcfr47
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 07, 2017 at 01:51:52PM +0300, Leonard Crestez wrote:

> It currently seems to work how I expect but from your statement it's
> not clear if it's entirely intentional.

The current behaviour of bypassed regulators is intentional.

> > > Or should a bypassed regulator ignore all other requests? One of the
> > > behaviors that this patch series relies on is that calling set_voltage
> > > on a bypassed regulator propagates this request to the supply and picks
> > > the minimum voltage there. An alternative implementation would be to

> > Yes, the expectation is that if anything is being changed it won't have
> > any effect until regulation is reenabled but we're not particularly
> > expecting much activity on bypassed regulators.

> OK, so it is up to consumers to ensure the supply voltage is acceptable
> before allowing bypass. If they want to do something clever they should
> register as a consumer to the supply as well.

No, that's not expected either - one or the other is fine but both isn't
expected.  What you're looking for here is something logically different
to bypass even if the hardware implementation ends up the same.

--4zx65g25cvfcfr47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljndmMACgkQJNaLcl1U
h9BcIgf/ZsOPVfPsZiVz2U9+lvqbOjpW//v/n4HprjRifIPA5hoqQ8UTzXy91fGh
mKZTUsgEEjG+SY+nT1BzUnDqh753Ty1aJ/Y6F+VILbSy9ttsHKW1LDwhFkH2weiR
iM3ZLK2bsor4L0QcEpxVH9Y0wd3vmjQmqr4f5IaxtRxu4lsW3mDmnZq1w52SeIPk
tlirL2iriyKhUbEL0XQssBUnO9n9BW5dk1LKOkvy+lRNwTTzgOgbdvluHaHq8dJg
stVUjuqMCjU7HAsv/su99PlUr3sLuM4t+P6GS0H2hPDtqjhtdwb1/zJa+c6UHQyy
8QKyWNYEA0PkWnjmyKsfcmcnCcn2aA==
=LXtA
-----END PGP SIGNATURE-----

--4zx65g25cvfcfr47--

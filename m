From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Sun, 16 Jul 2017 20:22:35 +0200
Message-ID: <20170716182235.GB14461@amd>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1529148.KHlxNOSRLV@aspire.rjw.lan>
 <20170706031750.GA12954@xo-6d-61-c0.localdomain>
 <5290346.YItt1Jp12B@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44180 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdGPSWi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 16 Jul 2017 14:22:38 -0400
Content-Disposition: inline
In-Reply-To: <5290346.YItt1Jp12B@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > So why exactly isn't it reasonable?
> > >=20
> > > Please use technical arguments.  Saying that something is wrong witho=
ut
> > > explaining the problem you see with it isn't particulatly useful in t=
echnical
> > > discussions.
> >=20
> > Deep in your heart, you should know that having enum listing all the pl=
atforms linux
> > runs on is a very bad idea.
>=20
> Even so, if I'm unable to explain to people why this is a bad idea in tec=
hnical
> terms, that doesn't mean too much.

I could say something O(#drivers * #platforms) vs. O(#drivers +
#platforms) lines of code -- but I thought it was obvious...?

> > Anyway, there are better solutions, regulator framework already knows i=
f given rail
> > will be powered off or not, and their driver already knows if they are =
going
> > suspend/standby. They just need to use existing interfaces.
>=20
> So they need to know what has been passed to suspend_devices_and_enter()
> anyway and currently there's no interface for that.  That actually is the=
 source
> of the whole issue.

Yep, I don't like that, but I guess we should give drivers enough
information to ask regulator framework.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllrrusACgkQMOfwapXb+vK+cACfRv7QCMYPJg/FZmIhJ4ZUL7FK
B5gAnAmiKg4TAFeShZVa9jeQyAd/V8Be
=ePfh
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--

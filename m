From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V2 1/6] PM / QOS: Add default case to the switch
Date: Fri, 10 Feb 2017 22:24:32 +0100
Message-ID: <20170210212432.GA7711@amd>
References: <cover.1486611268.git.viresh.kumar@linaro.org>
 <338b16e4c882634e30e4f4c011a9e9c52d134cbc.1486611268.git.viresh.kumar@linaro.org>
 <20170209142425.GC23373@xo-6d-61-c0.localdomain>
 <20170210060030.GA8498@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43551 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdBJVYf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 16:24:35 -0500
Content-Disposition: inline
In-Reply-To: <20170210060030.GA8498@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, khilman@baylibre.com, ulf.hansson@linaro.org, Len Brown <len.brown@intel.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, sboyd@codeaurora.org, nm@ti.com, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-02-10 11:30:30, Viresh Kumar wrote:
> On 09-02-17, 15:24, Pavel Machek wrote:
> > On Thu 2017-02-09 09:11:47, Viresh Kumar wrote:
> > > The switch block handles all the QOS request types present today, but
> > > starts giving compilation warnings as soon as a new type is added and
> > > not handled in this.
> > >=20
> > > To prevent against that, add the default case as well and do a WARN f=
rom
> > > it.
> >=20
> > I'd say compilation-time warning is better than hmm.... stacktrace and =
memory leak
> > at runtime?
>=20
> Of course we aren't going to allow a compilation warning for each and eve=
ry
> platform that compiles this file. How do you wish to fix the issue then ?

Surely compilation warnings are better than getting bug reports from
users?

Of course, it is better to fix the switch when adding new QoS type...
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlieL5AACgkQMOfwapXb+vKqBQCgkTt4SGfRtkrAzsuEbn9/6q1X
xbQAnRAquIFFBBGK0ls8Xi2iCLZ9Qv0E
=kmWR
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--

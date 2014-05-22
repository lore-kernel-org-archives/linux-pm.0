From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Thu, 22 May 2014 18:58:46 +0100
Message-ID: <20140522175846.GO12304@sirena.org.uk>
References: <1400598429.4853.29.camel@weser.hi.pengutronix.de>
 <CAGo_u6ru5OgwCbJRrMNXUzeNLFMUvW=j8su6AAC4vmy3GOSM2g@mail.gmail.com>
 <CAGo_u6omOyuXvpDcirm36AnreGfa4nxisQ8BqZ8p2AVmWjfwbA@mail.gmail.com>
 <1400600908.4853.41.camel@weser.hi.pengutronix.de>
 <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com>
 <1400604324.4853.51.camel@weser.hi.pengutronix.de>
 <CAGo_u6ofuas-HBkAaKAUmKoOxjfWOpa7gmenS6Lspk9gWNt5cw@mail.gmail.com>
 <1400665634.5926.18.camel@weser.hi.pengutronix.de>
 <20140521233302.GA12304@sirena.org.uk>
 <1400754298.4913.15.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Onq+08jdeJR+lscb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39315 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbaEVR7H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 22 May 2014 13:59:07 -0400
Content-Disposition: inline
In-Reply-To: <1400754298.4913.15.camel@weser.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--Onq+08jdeJR+lscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 22, 2014 at 12:24:58PM +0200, Lucas Stach wrote:

> This shifts things from a change to the OPP framework to a change to the
> regulator framework, as I would like to add this property to the device
> supply definition. Patches upcoming.

In the regulator framework this seems completely redundant - we already
have the maximum voltage specifiable, it's hard to see a case where
you'd want a maximum that wasn't the maximum for the board.  I'd expect
the cpufreq code to just read the existing property.

This disadvantage of doing this without any explicit configuration on
the cpufreq side is that it means we start ignoring the OPP constraints
of CPUs that aren't specified to allow that.  Perhaps we don't care
though.

> I would really like to have a clear absolute maximum per device, as this
> would allow me to infer the voltage tolerance of the device from the
> difference between the highest OPP and maximum voltage.

I don't think this is a good way of specifying this information.  I
think if we want to start paying attention to the tolerances in that way
(which we really ought to do) we should be actually teaching the
framework about them - for example have the regulator driver able to
specify the regulation accuracy so set_voltage() can guarantee that the
constraint is met and probably also have a way of specifying tolerances
on the ranged set_voltage() too.

Trying to infer this information from absolute numbers seems likely to
get us into trouble at some point, both in terms of being harder for
people to use to get the result they want and in terms of not being able
to convey the information needed at all.

--Onq+08jdeJR+lscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfjrTAAoJELSic+t+oim9IjYP/1gSzcmYee2RBTAzKakNRKPN
WlOvzT3ebUpoWIFciUy83KYPajTp+O7XCbfUiWOBsG/16dnmMBteQYQEJoqMjT9b
KP9P0Ycw/MVkRlykr8SSd4BxVbsQJQjindxAdnewK0lXimNkuwnqp+FvtYOvzePu
jIRxVrMGKEnillzNTemNi7V0tKAuk1K1jzwLWABGzhctv0wkBEa9SA3begcLKzfX
/dScDM6NFnCJ79kr2/dOfeVEv4wIubf0aR/YwWURDzVdTk4RjSDO/aIERoHe+81U
g5aCrTCBaf2dJfFEmVEQ7LSgXf+VW45J+TwAS22VHfh8dz5QPo3xpNgxKz1GZCAO
Wz/+isGyEYV8If3bqB445jDf6JT4YxewDnqlhFx3pW9NftVxlKjwzVv9SVzV7bV/
jg3A2hTzqGK/br0IIPor1tsikyayjJ9QljydAIkHgpObroxVhsh9rllSFPy10QnC
nFcAdM/oKoKwIgSZvDLSUv6RHmpqLQmy1om6Keobv6GinXIyi90PLYM81ppkLNUx
AP7uiJkd7EgeoYBvoR3yy1nWsnp/zYOtqxVvGqVqEWxvYvAaRydxVm2tjliosjp6
plB8XX/LWL4OWuRBXn4dafVwnimTA17kFAm9z3WcrMEDrVTjA9PPbB1do6jtSyYA
uv9Au3Zpt+osJjpMzSYN
=/DOJ
-----END PGP SIGNATURE-----

--Onq+08jdeJR+lscb--

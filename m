From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 2/2] PM / OPP: extend DT parsing to allow voltage ranges
Date: Thu, 22 May 2014 00:33:02 +0100
Message-ID: <20140521233302.GA12304@sirena.org.uk>
References: <1400596877.4853.16.camel@weser.hi.pengutronix.de>
 <CAGo_u6qTFzVMhcWrk0L5Z4zykfLTMrkph0b4AJNEX7SS7pvWxQ@mail.gmail.com>
 <1400598429.4853.29.camel@weser.hi.pengutronix.de>
 <CAGo_u6ru5OgwCbJRrMNXUzeNLFMUvW=j8su6AAC4vmy3GOSM2g@mail.gmail.com>
 <CAGo_u6omOyuXvpDcirm36AnreGfa4nxisQ8BqZ8p2AVmWjfwbA@mail.gmail.com>
 <1400600908.4853.41.camel@weser.hi.pengutronix.de>
 <CAGo_u6pyU1O0uv-3CJc6OPoJ+bkcpNJ9_26JL3DxugX7dJhZfA@mail.gmail.com>
 <1400604324.4853.51.camel@weser.hi.pengutronix.de>
 <CAGo_u6ofuas-HBkAaKAUmKoOxjfWOpa7gmenS6Lspk9gWNt5cw@mail.gmail.com>
 <1400665634.5926.18.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wjJgzx32Vec0wotc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35757 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbaEUXdZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 19:33:25 -0400
Content-Disposition: inline
In-Reply-To: <1400665634.5926.18.camel@weser.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Nishanth Menon <nm@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>


--wjJgzx32Vec0wotc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 21, 2014 at 11:47:14AM +0200, Lucas Stach wrote:

> To summarize things: I'm working on a new cpufreq driver and I think the
> current practice of using a "voltage-tolerance" is bogus as most devices
> don't actually have a fixed tolerance but rather an absolute maximum
> rating which should not be exceeded.

We actually need both options here but yes, I agree.

> The voltage tolerance is used as the regulator needs to be given a
> sensible range for set_voltage(). The minimum voltage is defined by the
> current OPP, maximum not so much. Now most cpufreq drivers just add a
> tolerance to the minimum to get the max value and call it a day, but
> actually I think it would be more sensible to stick the absolute maximum
> rating in there. The problem is a device driver currently doesn't know
> about the maximum rating of it's device.

This depends very much on how the chip is specified - as far as I can
tell some manufacturers specify things really tightly and only guarantee
that the chip will operate at specific operating points while others do
the more expected thing and specify a minimum voltage for the OPP and a
maximum rated voltage with any voltage in the range being in spec.  I
expect this is due to the need to guarantee performance so they're only
quoting what's been fully simulated, verified and characterised in the
datasheet.

Realistically it's probably unlikely that there would be any practical
problems other than excessive power consumption going over voltage so
long as it is within the maximum rated operational voltage but equally
well if the datasheet specifies something more restrictive it seems
sensible to follow what the datasheet said just in case there's some
good reason for it (and to make it easier to get support from the
hardware people!).

The people who did that code originally had the first case but we should
as you say be able to handle the second case and allow each OPP (or
possibly just the device as a whole) to have a ceiling put in place.

> On the other hand Nishanth argues that regulator constraints should be
> set correctly to limit the voltage to the absolute maximum rating and I
> can see his point here. But only using regulator constraints would make
> the max voltage parameter in set_voltage() superfluous and we could just
> set it to INT_MAX, which feels really wrong.

That would work as well of course but like you say eew.  :)

> So with the realization that the maximum rating isn't really dependent
> on the current OPP it seems we could just have a generic
> "*-supply-max-voltage" property to describe a reasonable upper bound
> instead of this wobbly voltage-tolerance. Does this sound sensible to
> you?

Yes, I definitely think that option should exist.  I don't know if it's
worth doing it per OPP rather than for the chip as a whole in case
that's a thing people want to use but I'd be surprised if anyone
noticed.  We could also infer the maximum voltage from the highest
voltage specified for an OPP if some boolean property was set which
might be a bit less redundant.

--wjJgzx32Vec0wotc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfTeqAAoJELSic+t+oim9kC4P/3Vvt8HRsjKk6F+c01Wg64oA
uOflLFaFkzfKW60wHIBCsAHrwe0r70YDzY+fJxY992kQm+TxUk4nsWrDBJ561+du
YE1swVyTyP/d1Syp+UCJ70LIWsD8OGolhe7rWnbYnf+uN6ZmrriAnuwU3PTYJ6ls
ssBLpqnXsotPW8d6Cb+Ou7p2riBo7cvzTYiEFA4pI0RsuSeqjA0Fpm5o4Uzq3SP9
6zJv1C7KcxcKd3teI0IXdYvYjVRgt24txjBU+molqZ7kyPvU73x+zX/xbWxFgDyz
ytrV1uUqAh+04wc7BTIILQNeVxS0yTfVmyQdhYljuJ6mCBsln2+f5ckFVDi0pucr
WXai26jQKSJ8rGkmpaj1NjHXFnio8s5VI1EmWFtlOleg7+cYY9GLNxhGMuqX9M4L
vmkTIwFeRwSJNjcgpHUXfymFGf1tpR5SI+vFSEyXiikG0wAnTAUa1KEXuZZGkQE/
z2+tO4toGyJ3RrGW1iY6O+mlldxMtDf8W8Uk+dw2efzJ2TZsKQuh4zopMLVyRngW
FOnyZGPHwEwxCStWkwN1apsfgTJpCEpGFjNt3ZdJNkzGeYusY9oCJ6f+bbM223lc
uIVMbbppbMOatZeIeYQXvZ4MImcsyzJTIwb5g9jvpiYiYj03oxlMzS17bcNGeg69
RTE+sVCSR6f8sP+Wlp2Q
=zuiA
-----END PGP SIGNATURE-----

--wjJgzx32Vec0wotc--

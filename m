From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 17/32] greybus: power supply driver
Date: Fri, 7 Oct 2016 20:15:19 +0200
Message-ID: <20161007181519.GA23457@amd>
References: <20160914100949.GA6179@kroah.com>
 <20160916064058.GA17821@kroah.com>
 <20160916141058.GE1252@kroah.com>
 <20161007134902.GC19976@amd>
 <20161007141258.GA25284@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55916 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755044AbcJGSPX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 14:15:23 -0400
Content-Disposition: inline
In-Reply-To: <20161007141258.GA25284@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Johan Hovold <johan@hovoldconsulting.com>, Rui Miguel Silva <rmfrfs@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sandeep Patil <sspatil@google.com>, Matt Porter <mporter@kernel.crashing.org>, John Stultz <john.stultz@linaro.org>, Rob Herring <robh@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Alex Elder <elder@linaro.org>, David Lin <dtwlin@google.com>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, Mark Greer <mgreer@animalcreek.com>


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-10-07 16:12:58, Greg KH wrote:
> On Fri, Oct 07, 2016 at 03:49:02PM +0200, Pavel Machek wrote:
> > On Fri 2016-09-16 16:10:58, Greg KH wrote:
> > >=20
> > > This driver implements the Greybus power supply class protocol.
> >=20
> > Probably
> >=20
> > POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
> > M:      Sebastian Reichel <sre@kernel.org>
> > M:      Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > M:      David Woodhouse <dwmw2@infradead.org>
> > L:      linux-pm@vger.kernel.org
> >=20
> > should be cc-ed?
>=20
> You didn't read the 00 email, or anything else in this thread, did you?

You mean this one?
									Pavel

Subject: [patch 00/32] Greybus driver subsystem
User-Agent: Mutt/1.7.0 (2016-08-17)

This is a simple set of patches, adding the greybus core and drivers
to
the kernel tree.

It breaks the larger git tree submission up into individual files to
make it easier for reviewing.

Any questions or comments, please let us know.

					=09

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf35jcACgkQMOfwapXb+vKm7QCgr82csxunhyM+EbD8lTelTk+4
ih8AoKztBtc3VXmvkzvIa1eWUtUmCrRr
=qqZo
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux fails to start secondary cores when system resumes from
 Suspend-to-RAM
Date: Fri, 30 Dec 2016 21:10:59 +0100
Message-ID: <20161230201059.GB22935@amd>
References: <d4db03ce-80fc-2968-c5c2-84f79272ce8d@free.fr>
 <CADjb_WQ8ZTtcXYQ_3iobLCW7+rnG8FqyFQ1E47AZVGxP0JyB0w@mail.gmail.com>
 <8c3c6592-1e9a-10d3-2a89-c22a2a23cf4b@free.fr>
 <9134f2dd-73f6-73d5-30a0-3129d5440d0a@free.fr>
 <4dc90086-180d-df9a-297f-6f4680de7bdd@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="NDin8bjvE/0mNLFQ"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:47907 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcL3ULC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 15:11:02 -0500
Content-Disposition: inline
In-Reply-To: <4dc90086-180d-df9a-297f-6f4680de7bdd@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>, Yu Chen <yu.chen.surf@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Mark Rutland <mark.rutland@arm.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sebastian Frias <sf84@laposte.net>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Thomas Gambier <thomas_gambier@sigmadesigns.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Kevin Hilman <khilman@kernel.org>, Mark Brown <broonie@kernel.org>


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu 2016-12-29 15:27:12, Mason wrote:
> On Thu, Dec 15, 2016 at 11:18 PM, Mason wrote:
>=20
> > However, while Linux successfully starts the secondary cores when
> > the system first boots, it fails when the system resumes from "S3".
>=20
> Oh boy...
>=20
> Turns out the firmware was, in fact, (upon resume) stomping over parts
> of the Linux memory image in RAM, triggering all kinds of "interesting"
> nasal demons when Linux ran (or, more accurately, limped).

Well... firmware is always fun :-). Good that it got solved...

									Pavel
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--NDin8bjvE/0mNLFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlhmv1IACgkQMOfwapXb+vLnggCbBrjAdvKNoCB1EeR/i/bYN/uw
4sQAnjsJmZhT2h5tDcEB8EQcnVTPl160
=7zuA
-----END PGP SIGNATURE-----

--NDin8bjvE/0mNLFQ--

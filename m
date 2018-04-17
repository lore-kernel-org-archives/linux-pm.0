From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Tue, 17 Apr 2018 23:00:50 +0200
Message-ID: <20180417210050.GA16170@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <1521474008.20208.2.camel@redhat.com>
 <20180319173356.GA28462@amd>
 <1521481549.20208.8.camel@redhat.com>
 <20180320080334.GA31772@amd>
 <1521551568.16848.5.camel@redhat.com>
 <20180325061927.GA2148@amd>
 <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>, daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: Woody Suwalski <terraluna977@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Mon 2018-03-26 10:33:55, Dan Williams wrote:
> On Sun, 2018-03-25 at 08:19 +0200, Pavel Machek wrote:
> > > > > Ok, what does 'nmcli dev' and 'nmcli radio' show?
> > > >=20
> > > > Broken state.
> > > >=20
> > > > pavel@amd:~$ nmcli dev
> > > > DEVICE  TYPE      STATE        CONNECTION
> > > > eth1    ethernet  unavailable  --
> > > > lo      loopback  unmanaged    --
> > > > wlan0   wifi      unmanaged    --
> > >=20
> > > If the state is "unmanaged" on resume, that would indicate a
> > > problem
> > > with sleep/wake and likely not a kernel network device issue.
> > >=20
> > > We should probably move this discussion to the NM lists to debug
> > > further.  Before you suspend, run "nmcli gen log level trace" to
> > > turn
> > > on full debug logging, then reproduce the issue, and send a pointer
> > > to
> > > those logs (scrubbed for anything you consider sensitive) to the NM
> > > mailing list.
> >=20
> > Hmm :-)
> >=20
> > root@amd:/data/pavel# nmcli gen log level trace
> > Error: Unknown log level 'trace'
>=20
> What NM version?  'trace' is pretty old (since 1.0 from December 2014)
> so unless you're using a really, really old version of Debian I'd
> expect you'd have it.  Anyway, debug would do.

=2E..

Hmm. I also noticed now screen saver kicks in _right after I resume
the machine_. That did not use to be the case (and is a bit annoying
on its own).

Do we have any changes with time across suspend/resume in v4.17?

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrWYIIACgkQMOfwapXb+vKk9wCcC11R+CHylBGrEcwXKRYbkoqY
N+IAni0sVwTlQqcBIFtmH4Jg2/EULNkt
=56Du
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

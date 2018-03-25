From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Sun, 25 Mar 2018 08:19:27 +0200
Message-ID: <20180325061927.GA2148@amd>
References: <20180318104023.GA10392@amd>
 <70721f83-344a-0f23-223b-9c81f6e9e32a@gmail.com>
 <20180319092106.GA5683@amd>
 <1521474008.20208.2.camel@redhat.com>
 <20180319173356.GA28462@amd>
 <1521481549.20208.8.camel@redhat.com>
 <20180320080334.GA31772@amd>
 <1521551568.16848.5.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1521551568.16848.5.camel@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Woody Suwalski <terraluna977@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > Ok, what does 'nmcli dev' and 'nmcli radio' show?

> >=20
> > Broken state.
> >=20
> > pavel@amd:~$ nmcli dev
> > DEVICE  TYPE      STATE        CONNECTION
> > eth1    ethernet  unavailable  --
> > lo      loopback  unmanaged    --
> > wlan0   wifi      unmanaged    --
>=20
> If the state is "unmanaged" on resume, that would indicate a problem
> with sleep/wake and likely not a kernel network device issue.
>=20
> We should probably move this discussion to the NM lists to debug
> further.  Before you suspend, run "nmcli gen log level trace" to turn
> on full debug logging, then reproduce the issue, and send a pointer to
> those logs (scrubbed for anything you consider sensitive) to the NM
> mailing list.

Hmm :-)

root@amd:/data/pavel# nmcli gen log level trace
Error: Unknown log level 'trace'
root@amd:/data/pavel# nmcli gen log level help
Error: Unknown log level 'help'
root@amd:/data/pavel# nmcli gen log level
Error: value for 'level' argument is required.
root@amd:/data/pavel# nmcli gen log level debug
root@amd:/data/pavel# cat /var/log/sys/log

Where do I get the logs? I don't see much in the syslog...

And.. It seems that it is "every other suspend". One resume results in
broken network, one in working one, one in broken one...

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq3P28ACgkQMOfwapXb+vLCsQCeMf6Vl1miUZH5hRw9DG172euS
lcIAnR8RW46Rh3FQuFEjjGkPvKfKKwHT
=iXHh
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next on x60: network manager often complains "network is
 disabled" after resume
Date: Sun, 15 Apr 2018 18:16:04 +0200
Message-ID: <20180415161604.GG10802@amd>
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
        protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <95efbba35c3389015d4919a59f8d01bc2d375a19.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dcbw@redhat.com>
Cc: Woody Suwalski <terraluna977@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Netdev list <netdev@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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

Hmm.

pavel@duo:~$ /usr/sbin/NetworkManager --version
You must be root to run NetworkManager!
pavel@duo:~$ sudo /usr/sbin/NetworkManager --version
0.9.10.0

So I set the log level, but I still don't see much in the log:

Apr 14 18:14:29 duo dbus[3009]: [system] Successfully activated
service 'org.freedesktop.nm_dispatcher'
Apr 14 18:14:29 duo nm-dispatcher: Dispatching action 'down' for wlan1
Apr 14 18:14:29 duo systemd[1]: Started Network Manager Script
Dispatcher Service.
Apr 14 18:14:29 duo systemd-sleep[6853]: Suspending system...
Apr 14 21:27:53 duo systemd[1]: systemd-journald.service watchdog
timeout (limit 1min)!
pavel@duo:~$ date
Sun Apr 15 12:26:32 CEST 2018
pavel@duo:~$

Is it possible that time handling accross suspend changed in v4.17?

I get some weird effects. With display backlight...

> > Where do I get the logs? I don't see much in the syslog...
>=20
> > And.. It seems that it is "every other suspend". One resume results
> > in
> > broken network, one in working one, one in broken one...
>=20
> Does your distro use pm-utils, upower, or systemd for suspend/resume
> handling?

upower, I guess:

pavel@duo:/data/l/linux$ ps aux | grep upower
root      3820  0.0  0.1  42848  7984 ?        Ssl  Apr14   0:01
/usr/lib/upower/upowerd

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrTesQACgkQMOfwapXb+vL3YwCgo2AzEXnEA690v5Wlr6KhA9di
D3AAnjlf/WM+vy451e+G/T+UzRGyWLgL
=E257
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--

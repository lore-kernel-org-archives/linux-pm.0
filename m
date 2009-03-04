From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 4 Mar 2009 15:00:01 +0100
Message-ID: <200903041500.06016.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200903021453.19482.u.luckas@road.de>
	<20090303140215.GD5060@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6281865919047997785=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090303140215.GD5060@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

--===============6281865919047997785==
Content-Type: multipart/signed;
  boundary="nextPart1352987.ggJxHgnj3N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1352987.ggJxHgnj3N
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday, 3. March 2009, Pavel Machek wrote:
> Hi!
>
> > > > > And introduce nasty interface, and probably slower too since open=
()
> > > > > is time-critical and ioctl() is not? Or do you have benchmarks?
> > > >
> > > > No, just specualting as open() needs to do a directory lookup. It
> > > > also needs to do book keeping. I'd be surprised if open was faster
> > > > then ioctl.
> > >
> > > Unless you measure how much slower it is...
> >
> > OK. Opening /dev/null 100000 times readonly takes 365 ms on my machine.
> > Opening it once and then, 100000 times writing 1 byte takes 32 ms.
> > Why exactly did you think I had to provide numbers???
>
> Arve said:
> > >> I just checked my phone, and over a 24 hour awake time (370 hours
> > >> uptime) period, it acquired about 5 million wakelocks (mostly for
> > >> input events). If these were cache hits, and took as long as my
> > >> benchmark did, that accounts for 20 seconds of overhead (0.023%
> > >> of
> > >> awake, 0.1% of not-idle (5.5h).
>
> Ok. 20seconds vs. 200 seconds seems interesting.
>
> OTOH... Android seems to do IPC for wakelock manipulation, and that's
> way higher overhead than open() syscall, so perhaps it is not that
> critical?
>
Is IPC (writing a byte through a pipe/socket) really more expensive than=20
open/close?
Even if it is, this brings us back to another thread of this topic. The rea=
son=20
for getting away with IPC might be that on the android platform the major=20
part of wake locking is still done by timeouts. One thing that comes to min=
d=20
here is network packets. You just don't want to open/close a fd for every=20
network packet that you process. Neither for serial data, bluetooth=20
packets, ...

Uli

=2D-=20

=2D------ ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien

--nextPart1352987.ggJxHgnj3N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmuiWIACgkQG/Gdq+fBSQvpPQCgmmWf6ukdHpS4WQ7475Brl/xu
QVwAn1PajOUqXvH4eeJSFNc7gjVcmVuf
=/nsi
-----END PGP SIGNATURE-----

--nextPart1352987.ggJxHgnj3N--

--===============6281865919047997785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6281865919047997785==--

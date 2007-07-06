From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 6 Jul 2007 17:07:20 +1000
Message-ID: <200707061707.23316.nigel@nigel.suspend2.net>
References: <200707041658.59588.rjw@sisk.pl> <20070705220046.GC3881@elf.ucw.cz>
	<200707060902.55090.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0775900966560065873=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707060902.55090.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

--===============0775900966560065873==
Content-Type: multipart/signed; boundary="nextPart3909026.cUa00Odpy5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3909026.cUa00Odpy5
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 06 July 2007 17:02:53 Rafael J. Wysocki wrote:
> On Friday, 6 July 2007 00:00, Pavel Machek wrote:
> > Hi!
> >=20
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >=20
> > > The syncing of filesystems from within the freezer is generally not=20
needed.
> > > Change freeze_processes() so that it doesn't execute sys_sync() and m=
ake=20
the
> > > suspend and hibernation code path sync filesystems independently of t=
he=20
freezer.
> >=20
> > Yes, we can do that, but ... why?
>=20
> I think that sync and the freezer are different things and shouldn't be=20
mixed in
> such a way as they are now.
>=20
> > Does it actually fix FUSE?
>=20
> It should prevent the freezer from deadlocking.

That's not the same thing. It's like saying "My footbrake grabs so I'll use=
=20
the handbrake all the time. Take the stone out of the brake pad! :)

> > Miklos claims sync is nop on FUSE...?=20
>=20
> In that case there shouldn't be any deadlock, but a freezer failure. :-)

Isn't this scary? I'm agreeing with Pavel and the two of us seem to be=20
disagreeing with everyone else!

To get more serious and practical though, I think the solution is to fuzz t=
he=20
userspace/kernelspace distinction. What we really want to do is freeze thin=
gs=20
that submit I/O, then sync, then freeze anything that processes I/O and nee=
ds=20
to be frozen. In effect, redefine fuse processes as freezeable kernel=20
threads.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart3909026.cUa00Odpy5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjeorN0y+n1M3mo0RAiefAKDvj0tKkFt9pMB58ZsOGRtSBYanswCgx4TJ
Dppfj0MqT6eS0tZ/TKtRUGw=
=/bZU
-----END PGP SIGNATURE-----

--nextPart3909026.cUa00Odpy5--

--===============0775900966560065873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0775900966560065873==--

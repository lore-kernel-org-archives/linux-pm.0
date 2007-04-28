From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during	snapshot/shutdown
Date: Sun, 29 Apr 2007 08:52:32 +1000
Message-ID: <1177800752.7652.0.camel@nigel.suspend2.net>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<1177715134.4737.194.camel@nigel.suspend2.net>
	<46330550.8020005@cs.helsinki.fi>  <200704281249.06774.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1640977822836242843=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704281249.06774.rjw@sisk.pl>
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
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============1640977822836242843==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xVoxMEvG91UbMq6Bxyli"


--=-xVoxMEvG91UbMq6Bxyli
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Sat, 2007-04-28 at 12:49 +0200, Rafael J. Wysocki wrote:
> On Saturday, 28 April 2007 10:26, Pekka Enberg wrote:
> > Nigel Cunningham wrote:
> > > I therefore have to ask: Please. Go away. Hand the maintainership of
> > > hibernation over to Rafael. Work on things you do care about and wher=
e
> > > you do want to see a fully functional implementation. But stop being =
a
> > > hindrance to us making Linux hibernation support everything that it
> > > ought to be.
> >=20
> > [snip]
> >=20
> > Please. The load average is a problem and no the fix is not to make=20
> > kernel/timer.c worse for everybody but to snapshot the load averages=20
> > _before_ I/O and restore them after resume.
>=20
> I'm having an impression that this problem is suspend2-specific.  With sw=
susp
> we can have it only if the writing of snapshot fails.
>=20
> Namely, with swsusp we have the pre-snapshot value of the load average in=
 the
> image and it should be, so to speak, "normal".  Then, once we've restored=
 the
> image, this "normal" value gets recovered and everything is fine.  If the=
 writing
> of image fails, we can have a "wrong" (i.e. too high) value of the load a=
verage
> afterwards, but then this is an error condition anyway.  At least, as a u=
ser, I
> can expect some glitches to happen after a failing hibernation.
>=20
> With suspend2, in turn, the contents of LRU pages are saved before we cre=
ate
> the snapshot.  They can be compressed etc. in the process, so the load av=
erage
> can grow quite substantially and this "unusual" load average is then
> snapshotted.  Hence, the problem appears after the restore.  I think the
> solution could be to save the post-tasks-freezing load average and restor=
e it
> right before snapshotting, but that's only needed for suspend2.

Yes, you and Pekka are both right. That would work too.

Regards,

Nigel

--=-xVoxMEvG91UbMq6Bxyli
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGM9AwN0y+n1M3mo0RAo90AJ4r8+f/bZBuyHJtbwYBozT7BL2/kgCg1fMV
oXGPYepfcA6VSiPrddB4UVU=
=fKV9
-----END PGP SIGNATURE-----

--=-xVoxMEvG91UbMq6Bxyli--


--===============1640977822836242843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1640977822836242843==--

From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 22:38:25 +1000
Message-ID: <200707052238.27889.nigel__17199.848048813$1183639187$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<20070704234523.GC2719@elf.ucw.cz> <200707051425.07904.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6013784599716928049=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051425.07904.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============6013784599716928049==
Content-Type: multipart/signed; boundary="nextPart1201636.iSAgefnjtu";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1201636.iSAgefnjtu
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 05 July 2007 22:25:06 Rafael J. Wysocki wrote:
> On Thursday, 5 July 2007 01:45, Pavel Machek wrote:
> > On Tue 2007-07-03 21:32:20, Oliver Neukum wrote:
> > > Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > > > And a further question. The freezer is not atomic. What do you do
> > > > > if a task not yet frozen calls sys_sync(), but fuse is already=20
frozen?
> > > >=20
> > > > What do you do if a task not yet frozen writes to a pipe, on the ot=
her
> > > > end of which is a task already frozen?
> >=20
> > There's some difference between uninterruptible and interruptible
> > sleep I'd say.
> >=20
> > > > It doesn't matter.  The only thing that should matter during suspend
> > > > (not hibernate) is saving the state of devices to ram, and putting =
the
> > > > devices to sleep.
> > >=20
> > > Well, but you did remove sys_sync() from the freezer, which is
> > > and must be called in the hibernate path.
> >=20
> > Not "must". In fact, hibernation should be safe without sys_sync(). It
> > is just user un-friendly.
>=20
> In fact, I'd like to remove the sys_sync() from the freezer entirely,=20
because
> it just doesn't belong in there.
>=20
> The only advantege of having sys_sync() in freeze_processes() is that we
> have a chance to write out everything when applications cannot produce mo=
re
> data to write, but there are filesystems which don't do that anyway (eg.=
=20
XFS),
> so generally there's no reason to bother.

Shouldn't XFS - and fuse - be considered to be broken? Sync should sync dat=
a=20
and if XFS isn't doing that, it's wrong.

In the case of fuse, we should have a mechanism by which fuse processes can=
 be=20
made to sync if they do have any pending I/O, and by which they can be froz=
en=20
later than other userspace processes.

I'd like to see the sync stay, because it improves reliability and data=20
integrity in the fail-to-resume case. Calling scripts would probably invoke=
=20
sync themselves if they don't already, but that's racy. As it is at the=20
moment, we know userspace is stopped, so syncing isn't racy.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1201636.iSAgefnjtu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjOZDN0y+n1M3mo0RAk9mAKCSSal8CrEcxMwbaaxn4f4gftpzJgCg0gp9
ZszH0kVXyMj2Uy+XMSuy0Q8=
=Mksm
-----END PGP SIGNATURE-----

--nextPart1201636.iSAgefnjtu--

--===============6013784599716928049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6013784599716928049==--

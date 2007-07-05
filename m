From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 23:36:26 +1000
Message-ID: <200707052336.27585.nigel__21915.2605314322$1183643269$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707052238.27889.nigel@nigel.suspend2.net>
	<200707051535.46196.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4783155600466337322=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051535.46196.rjw@sisk.pl>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, nigel@suspend2.net, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============4783155600466337322==
Content-Type: multipart/signed; boundary="nextPart2644466.OEt0fIUkEO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2644466.OEt0fIUkEO
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 05 July 2007 23:35:45 Rafael J. Wysocki wrote:
> On Thursday, 5 July 2007 14:38, Nigel Cunningham wrote:
> > On Thursday 05 July 2007 22:25:06 Rafael J. Wysocki wrote:
> > > On Thursday, 5 July 2007 01:45, Pavel Machek wrote:
> > > > On Tue 2007-07-03 21:32:20, Oliver Neukum wrote:
> > > > > Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > > > > > And a further question. The freezer is not atomic. What do yo=
u=20
do
> > > > > > > if a task not yet frozen calls sys_sync(), but fuse is alread=
y=20
> > frozen?
> > > > > >=20
> > > > > > What do you do if a task not yet frozen writes to a pipe, on th=
e=20
other
> > > > > > end of which is a task already frozen?
> > > >=20
> > > > There's some difference between uninterruptible and interruptible
> > > > sleep I'd say.
> > > >=20
> > > > > > It doesn't matter.  The only thing that should matter during=20
suspend
> > > > > > (not hibernate) is saving the state of devices to ram, and putt=
ing=20
the
> > > > > > devices to sleep.
> > > > >=20
> > > > > Well, but you did remove sys_sync() from the freezer, which is
> > > > > and must be called in the hibernate path.
> > > >=20
> > > > Not "must". In fact, hibernation should be safe without sys_sync().=
 It
> > > > is just user un-friendly.
> > >=20
> > > In fact, I'd like to remove the sys_sync() from the freezer entirely,=
=20
> > because
> > > it just doesn't belong in there.
> > >=20
> > > The only advantege of having sys_sync() in freeze_processes() is that=
 we
> > > have a chance to write out everything when applications cannot produc=
e=20
more
> > > data to write, but there are filesystems which don't do that anyway (=
eg.=20
> > XFS),
> > > so generally there's no reason to bother.
> >=20
> > Shouldn't XFS - and fuse - be considered to be broken? Sync should sync=
=20
data=20
> > and if XFS isn't doing that, it's wrong.
> >=20
> > In the case of fuse, we should have a mechanism by which fuse processes=
=20
can be=20
> > made to sync if they do have any pending I/O, and by which they can be=
=20
frozen=20
> > later than other userspace processes.
> >=20
> > I'd like to see the sync stay, because it improves reliability and data=
=20
> > integrity in the fail-to-resume case. Calling scripts would probably=20
invoke=20
> > sync themselves if they don't already, but that's racy. As it is at the=
=20
> > moment, we know userspace is stopped, so syncing isn't racy.
>=20
> I'd like to move the sync out of the freezer, but to call it from the
> suspend/hibernation code, so that we do
>=20
> sys_sync();
> error =3D freeze_processes();

Yeah, I understand that. The problem then is that you're racing against=20
userspace. That's not usually a problem, but that doesn't mean it's never a=
=20
problem. Try running the stress suite while testing hibernating and you'll=
=20
see what I mean. If something is submitting lots of I/O when you try to=20
suspend, your sync call will race against that process if it's not yet=20
frozen, and its continued activity will make your sync pointless (there'll =
be=20
more unsynced data when you sys_sync call finishes). Stopping userspace=20
before syncing removes that race.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2644466.OEt0fIUkEO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjPPbN0y+n1M3mo0RApTTAJ0Yf9+q36OL3z5Dt8aRi7gtaVUqrQCfUyzd
i50Zeiy88gFIXoTYgVP1H0Y=
=ggoO
-----END PGP SIGNATURE-----

--nextPart2644466.OEt0fIUkEO--

--===============4783155600466337322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4783155600466337322==--

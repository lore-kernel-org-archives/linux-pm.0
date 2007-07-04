From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync from within the
	freezer during suspend to RAM
Date: Thu, 5 Jul 2007 08:52:14 +1000
Message-ID: <200707050852.15392.nigel__13234.9840867848$1183589615$gmane$org@nigel.suspend2.net>
References: <200707041658.59588.rjw@sisk.pl>
	<200707050848.16163.nigel@nigel.suspend2.net>
	<20070704224942.GD2491@elf.ucw.cz>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0387247532891632242=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704224942.GD2491@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

--===============0387247532891632242==
Content-Type: multipart/signed; boundary="nextPart8401367.yHBPVo1QgU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8401367.yHBPVo1QgU
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 05 July 2007 08:49:42 Pavel Machek wrote:
> On Thu 2007-07-05 08:48:15, Nigel Cunningham wrote:
> > Hi.
> >=20
> > On Thursday 05 July 2007 00:58:58 Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > >=20
> > > The syncing of filesystems from within the freezer in not needed for=
=20
suspend=20
> > to
> > > RAM.  Change freeze_processes() so that it doesn't execute sys_sync()=
=20
and
> > > introduce the "syncing" version of it to be called from the hibernati=
on=20
code
> > > paths.
> > >=20
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > >  include/linux/freezer.h |   14 ++++++++++++--
> > >  kernel/power/disk.c     |    2 +-
> > >  kernel/power/main.c     |    6 ++++++
> > >  kernel/power/process.c  |    8 +++++---
> > >  kernel/power/user.c     |    2 +-
> > >  5 files changed, 25 insertions(+), 7 deletions(-)
> >=20
> > Looks ok, except that I wonder if you want the following fragment. It=20
looks to=20
> > me (looking at rc6) like with this code, you'll currently call sys_sync=
=20
twice=20
> > when suspending to ram. Maybe I'm misreading it. Also, shouldn't it be=
=20
done=20
> > after taking the mutex?
>=20
> sys_sync() should be okay to call, mutex or not.

Yeah. That wasn't my point, sorry. Calling sys_sync is pointless if you're=
=20
going to fail to take the mutex. It makes more sense to know you've got it=
=20
before you start doing things related to actually suspending.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart8401367.yHBPVo1QgU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjCSfN0y+n1M3mo0RAkL4AJsFfDtxPAaNVAFYfQ6WUQb7Sv8HVgCffKJC
yNP81MEmfN8F3licpy00nPo=
=M5Q2
-----END PGP SIGNATURE-----

--nextPart8401367.yHBPVo1QgU--

--===============0387247532891632242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0387247532891632242==--

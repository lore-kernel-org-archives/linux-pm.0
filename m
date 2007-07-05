From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync from within the
	freezer during suspend to RAM
Date: Thu, 5 Jul 2007 21:37:57 +1000
Message-ID: <200707052137.58164.nigel__1563.65860389105$1183635619$gmane$org@nigel.suspend2.net>
References: <200707041658.59588.rjw@sisk.pl>
	<200707050852.15392.nigel@nigel.suspend2.net>
	<200707051328.50845.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9126040666392855085=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051328.50845.rjw@sisk.pl>
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

--===============9126040666392855085==
Content-Type: multipart/signed; boundary="nextPart2170237.7EuUvR8Xdo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2170237.7EuUvR8Xdo
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 05 July 2007 21:28:49 Rafael J. Wysocki wrote:
> On Thursday, 5 July 2007 00:52, Nigel Cunningham wrote:
> > On Thursday 05 July 2007 08:49:42 Pavel Machek wrote:
> > > On Thu 2007-07-05 08:48:15, Nigel Cunningham wrote:
> > > > On Thursday 05 July 2007 00:58:58 Rafael J. Wysocki wrote:
> > > > > The syncing of filesystems from within the freezer in not needed =
for=20
> > suspend=20
> > > > to
> > > > > RAM.  Change freeze_processes() so that it doesn't execute=20
sys_sync()=20
> > and
> > > > > introduce the "syncing" version of it to be called from the=20
hibernation=20
> > code
> > > > > paths.
> > > > >=20
> > > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > > ---
> > > > >  include/linux/freezer.h |   14 ++++++++++++--
> > > > >  kernel/power/disk.c     |    2 +-
> > > > >  kernel/power/main.c     |    6 ++++++
> > > > >  kernel/power/process.c  |    8 +++++---
> > > > >  kernel/power/user.c     |    2 +-
> > > > >  5 files changed, 25 insertions(+), 7 deletions(-)
> > > >=20
> > > > Looks ok, except that I wonder if you want the following fragment. =
It=20
> > looks to=20
> > > > me (looking at rc6) like with this code, you'll currently call=20
sys_sync=20
> > twice=20
> > > > when suspending to ram. Maybe I'm misreading it. Also, shouldn't it=
 be=20
> > done=20
> > > > after taking the mutex?
> > >=20
> > > sys_sync() should be okay to call, mutex or not.
> >=20
> > Yeah. That wasn't my point, sorry. Calling sys_sync is pointless if you=
're=20
> > going to fail to take the mutex. It makes more sense to know you've got=
 it=20
> > before you start doing things related to actually suspending.
>=20
> Well, that's a valid point, I'll move it under the mutex.

Okee doke.
=20
> And why do you think it will be called twice?

Hmm. Looking again now, I can't see why I thought that. Maybe I just hadn't=
=20
had enough caffeine today at that stage :)

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2170237.7EuUvR8Xdo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjNgWN0y+n1M3mo0RAqisAJ4hzqS9GnL1xQXN/P4K6OltNmpvegCfdmsO
IH4L8GvZC1SXQ8eeM85mIgg=
=BFJ9
-----END PGP SIGNATURE-----

--nextPart2170237.7EuUvR8Xdo--

--===============9126040666392855085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9126040666392855085==--

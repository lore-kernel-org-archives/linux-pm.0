From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] Freezer: Handle uninterruptible
	tasks
Date: Sat, 7 Jul 2007 19:13:42 +1000
Message-ID: <200707071913.43482.nigel__890.786891295825$1183799679$gmane$org@nigel.suspend2.net>
References: <200707061012.48998.rjw@sisk.pl> <20070707075018.GB2638@elf.ucw.cz>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5310920894562774070=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070707075018.GB2638@elf.ucw.cz>
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

--===============5310920894562774070==
Content-Type: multipart/signed; boundary="nextPart1224078.IenSHiJm17";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1224078.IenSHiJm17
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 07 July 2007 17:50:18 Pavel Machek wrote:
> Hi!
>=20
> > The main limitation of the freezer is that it cannot handle=20
uninterruptible
> > tasks.  Namely, if there are uninterruptible tasks in the system, the=20
freezer
> > returns an error, which makes it impossible to suspend the system.
> ...
> > Unfortunately, this mechanism also leads to severe limitations, such as=
=20
that it
> > makes the freezer unable to handle systems using FUSE in a reliable way.
> >=20
> > This patch makes the freezer skip uninterruptible user space tasks (ie.=
=20
such
> > that have an mm of their own) when counting the tasks to be frozen.  As=
 a
> > result, these tasks have the TIF_FREEZE and TIF_SIGPENDING flags set, b=
ut=20
the
> > freezer doesn't wait for them to enter the refrigerator.  Nevertheless,=
=20
they
> > will enter the refrigerator as soon as they change their state.
>=20
> I don't think we can do that. I suspect rename looks like:
>=20
> 	write directory entry in source
> A)	(uninterruptible wait for write)
> 	write directory entry in destination
> 	(uninterruptible wait for write)
> 	write something else
>=20
> If we freeze some task in place "A)", we'll write to the disk when the
> directory write is finished :-(.

Renaming is a single syscall, so won't the process get frozen when the sysc=
all=20
finishes? The sys_sync will also help here - it will ensure the rename gets=
=20
flushed before we start on freezing kernel threads.

Perhaps you've just found more logic for keeping the sys_sync there?

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart1224078.IenSHiJm17
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGj1lHN0y+n1M3mo0RAgKlAJ9YI4zJzlL9bwAknrVnrkOiZU5O+gCgnXmS
Cm4oeo7+qQhhj4HjJpPzG4U=
=jLOo
-----END PGP SIGNATURE-----

--nextPart1224078.IenSHiJm17--

--===============5310920894562774070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5310920894562774070==--

From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 15:21:33 +1000
Message-ID: <200707211521.34619.nigel__25440.5909836807$1184995363$gmane$org@nigel.suspend2.net>
References: <Pine.LNX.4.44L0.0707201830470.5241-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0707201540260.5166@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0439918044716760445=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707201540260.5166@asgard.lang.hm>
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
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Milton Miller <miltonm@bga.com>, Ying Huang <ying.huang@intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

--===============0439918044716760445==
Content-Type: multipart/signed; boundary="nextPart2838332.GM7CrxbZlW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2838332.GM7CrxbZlW
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Saturday 21 July 2007 08:43:20 david@lang.hm wrote:
> On Fri, 20 Jul 2007, Alan Stern wrote:
>=20
> > On Fri, 20 Jul 2007, Jeremy Maitin-Shepard wrote:
> >
> >>>> when doing a suspend-to-ram you get to a point where you just don't =
use
> >>>> any userspace.
> >>
> >>> What do you mean?  How can you prevent user tasks from running?  That=
's
> >>> basically what the freezer does, and the whole point of this approach
> >>> is to eliminate the freezer.  Right?
> >>
> >> Presumably no tasks at all would be scheduled.
> >
> > How would you prevent tasks from being scheduled?  How would you
> > prevent drivers from deadlocking because in order to put their device
> > in a low-power state they need to acquire a lock which is held by a
> > user task?
>=20
> you give up on the suspend becouse you have no way of getting the user=20
> task to give up the lock.
>=20
> however, kernel locks should not be held by user tasks, user tasks are no=
t=20
> expected to behave in rational ways, allowing them to compete with kernel=
=20
> tasks for locks is a sure way to get a deadlock or indefinate stall.
>=20
> what locks are accessed this way?

Any userspace process can do a syscall. In the process of the syscall, it c=
an=20
take kernel locks, and it can schedule (eg, while seeking to take a second=
=20
lock).

Regards,

Nigel

--nextPart2838332.GM7CrxbZlW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGoZfeN0y+n1M3mo0RAj6/AJ9et0G6U5Y14K100BwjpBe6GjZCzwCfe18X
ohg4CBTRkSJLm+//08uJJAI=
=jkir
-----END PGP SIGNATURE-----

--nextPart2838332.GM7CrxbZlW--

--===============0439918044716760445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0439918044716760445==--

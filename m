From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 09:13:03 +1000
Message-ID: <200707060913.05644.nigel__31814.7544203841$1183677241$gmane$org@nigel.suspend2.net>
References: <20070703042916.GA17240@srcf.ucam.org>
	<20070705093013.GA3228@elf.ucw.cz>
	<1183675615.3388.81.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3154217028917147253=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183675615.3388.81.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

--===============3154217028917147253==
Content-Type: multipart/signed; boundary="nextPart2029251.hzeAYCJfLr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2029251.hzeAYCJfLr
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 06 July 2007 08:46:54 Benjamin Herrenschmidt wrote:
> On Thu, 2007-07-05 at 11:30 +0200, Pavel Machek wrote:
> >=20
> > ...but the moment you start blocking tasks that done driver request,
> > you _do_ have mini-freezer of your own, with pretty much the same
> > problems.
>=20
> No, not at all the same problems. Those tasks will block, but that will
> be harmless because we won't have some "freezer" things waiting for all
> tasks to reach a "stable" point (calling try_to_freeze()). We just let
> them block wherever we want, as long as it doesn't prevent a -driver-
> from suspending, which should be allright, we have no problem.

Will you be able to guarantee that every place where a task can/will block=
=20
will be harmless place? If so, how will you guarantee that? How will you=20
debug issues where a task occasionally doesn't block in the right place,=20
particularly instances where it is some less than obvious interaction with=
=20
other tasks?

This is the whole point to having the freezer. It makes things more=20
predictable and testable. It shows us, clearly, when process X is the one=20
that is causing problems.

> > In another message I shown that removing freezer will not help with
> > FUSE in general case.
>=20
> I disagree.

Why?
=20
> > It probably does not help with firmware, too; as soon as udev attempts
> > to do something with your wireless card, it is blocked, and if the
> > wireless card needs the firmware from udev, you are deadlocked.
>=20
> Firmware load has been a problem since day 1, I've talked about it
> multiple times, it's broken with or without the freezer, and so far, the
> reaction of pretty much everybody has been to dig their head deeper in
> the mud and ignore the problem.
>=20
> There are other issues (again, with or without freezer) that should be
> dealt with. For example, drivers that haven't yet got their suspend()
> callback or already have got their resume() may rely on services of the
> kernel that are still blocked, that's where things may go hairy.
> request_firmware() within resume() is a typical example of that.
>=20
> There are a few things we should do in that area. For example, once we
> start to call driver suspend's, we should probably set a system wide
> flag that will do things such as:
>=20
>  - block usermode helpers (either make call_usermodehelper return
> something like -EBUSY or have it queue up the calls and issue them later
> when thing are resuming, we need to look closely at what semantic we
> want here).
>=20
>  - Silently add GFP_NOIO to all allocations, to avoid having things
> blocking in kmalloc() with a mutex held that will deadlock with
> suspend() in a driver for example. Or set some way to have all GFP
> waiters wakeup and fail rather than wait for IOs. It's hard/bizarre but
> necessary, again, with or without a freezer.

GFP_ATOMIC? (In driver suspend, they shouldn't be sleeping either, right?)
=20
>  - Deal with the firmware problem. The best way is probably to have an
> async request_firmware interface(). Another thing is, drivers may want
> to cache their firmware in main memory, that sort of thing...
>=20
> And that's just a small list off the top of my mind, of known problems
> that will cause deadlocks or misbehaviours today, with or without the
> freezer, and that need to be addressed.

Userspace device drivers too?

Regards,

Nigel

--nextPart2029251.hzeAYCJfLr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjXsBN0y+n1M3mo0RAq67AJ9WBj/7JMxxW/xqq+3FdMeI2ww9EwCbBi44
r/0g87+DJbE+B8Ee39XmEj0=
=7fCw
-----END PGP SIGNATURE-----

--nextPart2029251.hzeAYCJfLr--

--===============3154217028917147253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3154217028917147253==--

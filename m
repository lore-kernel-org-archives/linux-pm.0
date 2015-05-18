From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 18 May 2015 11:57:27 +1000
Message-ID: <20150518115727.72439610@notabene.brown>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150514092251.6d0625af@notabene.brown>
	<20150514235426.GF4316@dastard>
	<3798672.EXej90jOp1@vostro.rjw.lan>
	<CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
	<CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
	<20150515113557.54ef930b@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/APfp6l34c+mE6_XEbGJway8"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150515113557.54ef930b@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

--Sig_/APfp6l34c+mE6_XEbGJway8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2015 11:35:57 +0100 One Thousand Gnomes
<gnomes@lxorguk.ukuu.org.uk> wrote:

> > > Data loss may be caused for hotplug storage(like USB), or all storage
> > > when power is exhausted during suspend.
> >=20
> > Which also may very well happen at run time, right?
>=20
> Intuitively users treat "suspended" as a bit like off and do remove
> devices they've "finished with".
>=20
> Technically yes the instant off/on on a phone is the same as the suspend
> to RAM on a laptop but it doesn't mean the model in people's heads is the
> same... not yet anyway.
>=20
> > > Is there obvious advantage to remove sys_sync() in the case?
> >=20
> > Yes, there is.  It is not necessary to sync() every time you suspend
> > if you do that very often.
>=20
> But if you do it very often you won't have any dirty pages to flush so it
> will be very fast.

Several people have said things like this, and yet Len clearly saw a problem
so sometimes it isn't as fast as you think it should be.  I guess we need
some data.

In fact there seem to be a number of open questions:

1/ Len has seen enough delays to bother sending a patch.  Twice.  Lots of
   other people claim there shouldn't be much delay.

   Len: can you provide numbers?  How long does the sys_sync take
   (min/max/mean....).  I think an interesting number would be in a quick
   "resume, do something, suspend" cycle, what percent of the time is spent
   in sys_sync.
   Maybe also report what filesystems are in use, and whether you expect
   there to be any dirty data.

   If I run "time sync; time sync; time sync" it reports about 50msec for
   each sync.  If I run "time sleep 0; time sleep 0; time sleep 0" it repor=
ts
   about 2 msec.  So sys_sync is taking at least 50msec.
   Almost all of that is in sync_inodes_sb() and much of that is in
   _raw_spin_lock.... though I might be misinterpreting perf.  It seems to
   wait for a BDI flusher thread to go off and do nothing.

   Len: is 50msec enough to bother you?


2/ Is a 'sys_sync' really necessary.  People claim that "users might lose
   data".  I claim that some user data could be still in the application
   buffers so they would lose that anyway, and applications call fsync after
   writing everything out, so sys_sync isn't necessary.
   Does anyone have an example of an application which writes important
   user data, but doesn't call "fsync" shortly after all data has been writ=
ten
   out of the application's internal buffers?

3/ Is a 'sys_sync' sufficient.  Len claims that in some cases, when running
     sync; sync
   the second sync takes longer, suggesting that the first sync didn't do
   everything that was expected.   Prior to Linux 1.3.20, sys_sync didn't
   wait for everything.  Since then it seems to be designed to, but maybe
   something isn't right there.
   In that case, having sys_sync may not be helping anyway.

   Len: can you reliably reproduce this?  Can you provide a recipe?

4/ Which part of 'sync' is really important?
   sys_sync does two things.  It initiates writeout on dirty data and it
   wait for writeout to complete.  Even if the former isn't necessary, the
   latter probably is.  Do we need to reliably wait for all output queues
   to flush?  Where is the best place to do that?

Thanks,
NeilBrown



>=20
> > And it is done in such a place that everything needs to wait for it to =
complete.
>=20
> Only because the code deciding to trigger any automated suspend doesn't
> do a sync a few seconds before. In the case the user goes to the menus
> and does power->suspend then yes it's a delay. In the case where the OS
> at some level has decided that it's 10 seconds from automatically
> suspending to something the user space can issue a pre-emptive sync to
> get the queue size down.
>=20
> Alan


--Sig_/APfp6l34c+mE6_XEbGJway8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVVlHCDnsnt1WYoG5AQLeQQ/+JixDVgfzspaRY0RT3j/pBu5Es/5HQTt9
CoaktfYfo6chp2V+Xjg9kjUYhXL9FajKfc64iUKkTw/39IielPf7uO1H1DU45MvC
KSQ3pqj2UVEVcdIxUtAY0Bdey1WVmHgCjLEk4OMtp++uNQAB5ATTiCojxfBuBbWC
g05MFneCnnMEj9uhXzLJaWiw9NWuGTA+XMZPntgwnFElCpKLMrLI4HmSN7429G+d
0/Y7U4Zvy4Did9hiLoba2Lyv5SuzdQ9O9bjHKeubruzznLBys0q9dA9m1sgOjUW1
GoO66/bqKCv6zBAuKjyE9r4ZzuwVL00ht9E3kVuSIpILNH1Q80ou0cc9yK+XXvM1
cpHi6jia+e6HKwQ3p/tZsTpvrsKqn5CZtPoC5ozFi56y258NgzjcTu7gkS3Iawcm
yX/CaVVeR1i5pPoeuha4Lw4jM2SHznFgTKfDQOApvl7uSL5V1aS2K7Q5RkIVvz2p
6M50QF3gIt1+/Ptj4gZLpYWNVITCGuOGLs9YC+3dwjM31MoOsxsTHqv4gwJdvT9t
hcYsEGUtkW0lEXsKqIYf7hv0bqpBqIIQk46CVP6gbKQaCge5ROQ22eCLQafBU/WH
kv5PG0DgGD+kaDNkPs1gtHjVBn2VME1wAqNUUx+UIvUdXUGZokTP5apWGpUNpl2r
bZZn4qlKBLg=
=xhld
-----END PGP SIGNATURE-----

--Sig_/APfp6l34c+mE6_XEbGJway8--

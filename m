From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH] cpuidle: use high confidence factors only when
 considering polling
Date: Fri, 18 Mar 2016 21:53:31 -0400
Message-ID: <1458352411.14723.55.camel@redhat.com>
References: <CAJvTdK=d-LngrEXavQKX9C2p=9qrZ-DhnBG_mRnP9RDVHjKhpA@mail.gmail.com>
	 <CAJZ5v0iK=vO1HPKfbpMwNx_Tk-kjGEUKrCmehaK7nN+-Up7BoA@mail.gmail.com>
	 <20160316121400.680a6a46@annuminas.surriel.com>
	 <10828426.sI6CaBvZhk@vostro.rjw.lan> <000701d180df$e8a14340$b9e3c9c0$@net>
	 <CAJZ5v0gLXE=sRxv35hKuX88L4tphSBtPb9Y2oLERuEhjsbTGJQ@mail.gmail.com>
	 <003301d18144$87bb8df0$9732a9d0$@net>
	 <20160318173551.675ff6e5@annuminas.surriel.com>
	 <CAJZ5v0hLAiVoEn0PbVo++UDrXvizYC0EeAoqj8drS3GR5mQTig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-6kScpRkTFKI1ifXCF2ly"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54365 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbcCSBxg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 18 Mar 2016 21:53:36 -0400
In-Reply-To: <CAJZ5v0hLAiVoEn0PbVo++UDrXvizYC0EeAoqj8drS3GR5mQTig@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Chen, Yu C" <yu.c.chen@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arto Jantunen <viiru@iki.fi>, Len Brown <lenb@kernel.org>


--=-6kScpRkTFKI1ifXCF2ly
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2016-03-18 at 23:56 +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 18, 2016 at 10:35 PM, Rik van Riel <riel@redhat.com>
> wrote:
> >=20
> > On Fri, 18 Mar 2016 11:32:28 -0700
> > "Doug Smythies" <dsmythies@telus.net> wrote:
> >=20
> > >=20
> > > Energy:
> > > Kernel 4.5-rc7-rjw10-rvr6: 55864 Joules
> > >=20
> > > Trace data (very crude summary):
> > > Kernel 4.5-rc7-rjw10-rvr5: ~3049 long durations at high CPU load
> > > (idle state 0)
> > > Kernel 4.5-rc7-rjw10-rvr5: ~183 long durations at high, but less,
> > > CPU load (not all idle state 0)
> > This is a bit of a big hammer, but since the polling loop already
> > uses
> > full CPU power anyway, this could be harmless, and solve your
> > problem.
> >=20
> > ---8<---
> >=20
> > Subject: cpuidle: break out of idle polling loop after HLT
> > threshold
> >=20
> > Staying in the poll loop can be beneficial for workloads that
> > wake back up very, very quickly, but staying in the poll loop
> > for too long can waste a lot of power.
> >=20
> > Break out of the idle polling loop if the system has spent more
> > time in the loop than the threshold for entering the next power
> > saving mode.
> >=20
> > The poll loop uses full CPU power already, so this will not
> > increase the power use of the poll loop.
> >=20
> > Signed-off-by: Rik van Riel <riel@redhat.com>
> > ---
> > =C2=A0drivers/cpuidle/driver.c | 21 ++++++++++++++++++++-
> > =C2=A01 file changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> > index 389ade4572be..a5dfeafd243f 100644
> > --- a/drivers/cpuidle/driver.c
> > +++ b/drivers/cpuidle/driver.c
> > @@ -181,10 +181,29 @@ static void __cpuidle_driver_init(struct
> > cpuidle_driver *drv)
> > =C2=A0static int poll_idle(struct cpuidle_device *dev,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0struct cpuidle_driver *drv, int index)
> > =C2=A0{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* Polling is state 0; =
break out of the polling loop after
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* threshold for the ne=
xt power state has passed. Doing
> > this several
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* times in a row shoul=
d cause the menu governor to
> > immediately
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0* select a deeper powe=
r state.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 limit =3D drv->states[1]=
.target_residency *
> > NSEC_PER_USEC;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ktime_t start =3D ktime_get(=
);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int i =3D 0;
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0local_irq_enable();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!current_set_pollin=
g_and_test()) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0while (!need_resched())
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0while (!need_resched()) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ktime_=
t now;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
cpu_relax();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Occ=
asionally check for a timeout. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(=
i % 1000)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0now =3D ktime_get();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ktime_to_ns(ktime_sub(now,
> > start)) > limit)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0current_clr_polling();
> I'm not sure how this is going to help, but maybe I'm missing
> something.
>=20
> Say we hit the timeout and break out of the loop.=C2=A0=C2=A0We get back =
to
> cpuidle_enter_state() and from there (via a couple of irrelevant
> steps) to cpuidle_idle_call() and to cpu_idle_loop().=C2=A0=C2=A0Then, si=
nce we
> are still idle, the while (1) loop continues and we land in
> menu_select() again.=C2=A0=C2=A0That will choose polling again (because n=
ow
> there's less time to the next timer than it was last time, so if it
> didn't choose C1 then, it won't do that now either) and we land in
> idle_poll() again.
>=20
> So is there anything I'm overlooking?

After about three microseconds of the above, get_typical_interval()
will return an interval larger than the C1 target residency, or
fail to find a typical interval, because 3 of the 8 intervals will
exceed the C1 target residency at that point.

Only repeated very fast wakeups will lead to polling, and just
a few periods of polling timing out will lead to the system
reverting to HLT.

In other words, the system will only use polling while it appears
to be beneficial, and should snap out of that mode very quickly.

The kernel test robot also showed over 6% improvement in (IIRC)
the wikibench test, with polling being done a little more often.

Other parts of the kernel do pretty much anything for 2% extra
performance, so if we can find a way to preserve that 6%, without
hurting power usage significantly, I suspect it may be worthwhile.

--=20
All Rights Reversed.


--=-6kScpRkTFKI1ifXCF2ly
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7LEbAAoJEM553pKExN6DGtMH/RNBtD4+32SASUHk99uFUC/S
WVrdLU0wsU4z+M2lrN582qlTpGD1CATQ2uv11JlXUxL8gCXOrIxeGvjEYbapouQN
LS3veqY+QDJHWbX5oDVzP+Z1hBk+s23dePeEmyAH2/rhZLsbQEroBYMeUL/H+/AF
HpVkAS8yNMMxnB/+aVt0giObcDuOb8291bc3Cjx+JsGxmUbh+7mI6TM5F0ga8y4c
X8nu1ArNJYp8pKblb0feYND3AQRt03k2YLn3ea8i55K+rQvDxOKOLyZM3JTZby4X
NqT8Pmylqk9U6X7Qy1tewtEZVlNCbzDdTHkvUbybVpmF3GTceLsDipsR8aKv/qQ=
=rarn
-----END PGP SIGNATURE-----

--=-6kScpRkTFKI1ifXCF2ly--


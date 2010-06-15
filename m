From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Tue, 15 Jun 2010 17:50:29 +0300
Message-ID: <20100615145029.GB3967__29737.5837377787$1276613290$gmane$org@swordfish.minsk.epam.com>
References: <1276461183.2659.4.camel@maxim-laptop>
	<201006140136.18652.rjw@sisk.pl>
	<20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4906821869188820149=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615072435.5a47d850@infradead.org>
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
To: Arjan van de Ven <arjan@infradead.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============4906821869188820149==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (06/15/10 07:24), Arjan van de Ven wrote:
> On Tue, 15 Jun 2010 09:19:27 +0300
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 1d7b9bc..101e8aa 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -159,10 +159,12 @@ update_ts_time_stats(struct tick_sched *ts,
> > ktime_t now, u64 *last_update_time) ktime_t delta;
> > =20
> >  	if (ts->idle_active) {
> > +		int cpu =3D get_cpu();
> >  		delta =3D ktime_sub(now, ts->idle_entrytime);
> >  		ts->idle_sleeptime =3D ktime_add(ts->idle_sleeptime,
> > delta);
> > -		if (nr_iowait_cpu() > 0)
> > +		if (nr_iowait_cpu(cpu) > 0)
> >  			ts->iowait_sleeptime =3D
> > ktime_add(ts->iowait_sleeptime, delta);
> > +		put_cpu();
> >  		ts->idle_entrytime =3D now;
> >  	}
>=20
>=20
> hmm this part is wrong
> you pick the current cpu, rather than the one denoted by ts.....
>=20

Hmm. Thanks, good catch.=20
Well, there is something I'm missing. How can I match given *ts and cpu=20
in update_ts_time_stats (except for introducing update_ts_time_stats(..., i=
nt cpu)) ?

> they will normally be the same, except for the case where you get your
> warning...
> (and this is also why you can't move the get_cpu() inside
> nr_iowait_cpu() ... )
>=20


	Sergey
--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkwXkzUACgkQfKHnntdSXjTVXgQAp7RIxXQyxMYXjTf3FvDBCNkH
UuviNKWJxG5syb/+eXcTi5xE+jpvDcPpaH+Xea3YoammpSAV7OQXa/3cJRr3nzE8
+8APeBfIx5myqQeXXXVdNQ7pWwtT7c0PDJ+5Bx9AO9VT1/vktFhPjbGN9NjWtL8Y
SzZITuAL1RLg4UfHh/g=
=d5Vx
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--

--===============4906821869188820149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4906821869188820149==--

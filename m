From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] cpuidle: avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu) v4
Date: Thu, 1 Jul 2010 09:17:09 +0300
Message-ID: <20100701061709.GA7380__46903.8341347643$1277964844$gmane$org@swordfish>
References: <20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
	<20100617062950.GA3979@swordfish>
	<1277476773.32034.639.camel@twins>
	<20100630125853.245e6b99.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5689062595046794580=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100630125853.245e6b99.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============5689062595046794580==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (06/30/10 12:58), Andrew Morton wrote:
> Subject: Re: [PATCH] cpuidle: avoid using smp_processor_id() in
>  preemptible
>  code (nr_iowait_cpu) v4
> X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
>=20
> On Fri, 25 Jun 2010 16:39:33 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Thu, 2010-06-17 at 09:29 +0300, Sergey Senozhatsky wrote:
> > > Fix
> > >   =20
> > >  BUG: using smp_processor_id() in preemptible [00000000] code: s2disk=
/3392
> >=20
> > > The initial fix was to use get_cpu/put_cpu in nr_iowait_cpu.  However,
> > > Arjan stated that "the bug is that it needs to be nr_iowait_cpu(int c=
pu)".
> > >=20
> > > This patch introduces nr_iowait_cpu(int cpu) and changes to its calle=
rs.
> > >=20
> > > Arjan also pointed out that we can't use get_cpu/put_cpu in update_ts=
_time_stats
> > > since we "pick the current cpu, rather than the one denoted by ts" in=
 that case.
> > > To match given *ts and cpu denoted by *ts we use new field in the str=
uct tick_sched: int cpu.
> >=20
> >=20
> > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > index b232ccc..db14691 100644
> > > --- a/include/linux/tick.h
> > > +++ b/include/linux/tick.h
> > > @@ -51,6 +51,7 @@ struct tick_sched {
> > >  	unsigned long			check_clocks;
> > >  	enum tick_nohz_mode		nohz_mode;
> > >  	ktime_t				idle_tick;
> > > +	int				cpu;
> > >  	int				inidle;
> > >  	int				tick_stopped;
> > >  	unsigned long			idle_jiffies;
> >=20
> > > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > > index 1d7b9bc..1907037 100644
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -38,6 +38,9 @@ static ktime_t last_jiffies_update;
> > > =20
> > >  struct tick_sched *tick_get_tick_sched(int cpu)
> > >  {
> > > +	/*FIXME: Arjan van de Ven:
> > > +	 can we do this bit once, when the ts structure gets initialized?*/
> > > +	per_cpu(tick_cpu_sched, cpu).cpu =3D cpu;
> > >  	return &per_cpu(tick_cpu_sched, cpu);
> > >  }
> >=20
> > > @@ -161,7 +164,7 @@ update_ts_time_stats(struct tick_sched *ts, ktime=
_t now, u64 *last_update_time)
> > >  	if (ts->idle_active) {
> > >  		delta =3D ktime_sub(now, ts->idle_entrytime);
> > >  		ts->idle_sleeptime =3D ktime_add(ts->idle_sleeptime, delta);
> > > -		if (nr_iowait_cpu() > 0)
> > > +		if (nr_iowait_cpu(ts->cpu) > 0)
> > >  			ts->iowait_sleeptime =3D ktime_add(ts->iowait_sleeptime, delta);
> > >  		ts->idle_entrytime =3D now;
> > >  	}
> >=20
> >=20
> > This all seems extremely silly, why not something like:
>=20
> Does it work?
>=20
> c'mon guys, it's taking us weeks and weeks to fix one simple bug.  It's
> a regression!  We should be in panic mode.
>=20

Hello,

Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:                   =
                                                                           =
                                   =20
>> Well, there is something I'm missing. How can I match given *ts and
>> cpu in update_ts_time_stats (except for introducing
>> update_ts_time_stats(..., int cpu)) ?

Arjan van de Ven <arjan@linux.intel.com> wrote:
>that'd be option one
>option two is to add a "cpu" member to struct tick_sched.....

So, it's been discussed. I chose option #2 however and made a mistake.
Personally I prefer Peter's patch. I need some time to test it.


	Sergey

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkwsMuUACgkQfKHnntdSXjThmgP/QoX4HFosXpzrHHfQWe6/4XTf
lrpvWv6WnOWRAQz6d3jC5/b/mitwSnBKSEKKg0r0n5OrAZmNMPUl+CEdPg/u73mH
6dk/umngbSy6PjhdWlbvThO3z/KlMX6MOGjkZ0gC2j1pEQ50QpdzgoN4ZDvY/xVu
E8/DZjCfWha4svG5dQM=
=u7FW
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--===============5689062595046794580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5689062595046794580==--

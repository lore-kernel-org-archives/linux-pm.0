From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Tue, 15 Jun 2010 18:23:15 +0300
Message-ID: <20100615152315.GC3967__19543.91152035$1276615657$gmane$org@swordfish.minsk.epam.com>
References: <20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3479101675843363305=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615080808.6286448b@infradead.org>
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


--===============3479101675843363305==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (06/15/10 08:08), Arjan van de Ven wrote:
> On Tue, 15 Jun 2010 17:50:29 +0300
> Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > >=20
> > > hmm this part is wrong
> > > you pick the current cpu, rather than the one denoted by ts.....
> > >=20
> >=20
> > Hmm. Thanks, good catch.=20
> > Well, there is something I'm missing. How can I match given *ts and
> > cpu in update_ts_time_stats (except for introducing
> > update_ts_time_stats(..., int cpu)) ?
>=20
>=20
> that'd be option one

We'll have problem in tick_nohz_start_idle(struct tick_sched *ts)
{
	ktime_t now;
	now =3D ktime_get();
	update_ts_time_stats(ts, now, NULL);

=2E..
So, we also will have to expand it to tick_nohz_start_idle(struct tick_sche=
d *ts, int cpu)

That's why I prefer option #2.

> option two is to add a "cpu" member to struct tick_sched.....
>=20
Thought about that. Seems ok to me.


> if you go for option one, I'd replace the ts argument with the cpu
> argument.....
>=20
>=20

Hmm, I missed this one (replacing *ts to int cpu). And I like it.=20
Something like:

-update_ts_time_stats(struct tick_sched *ts, ktime_t now, u64 *last_update_=
time)
+update_ts_time_stats(int cpu, ktime_t now, u64 *last_update_time)
{
	ktime_t delta;
+	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);

	if (ts->idle_active) {
		int cpu =3D get_cpu();
		delta =3D ktime_sub(now, ts->idle_entrytime);
		ts->idle_sleeptime =3D ktime_add(ts->idle_sleeptime, delta);
		if (nr_iowait_cpu(cpu) > 0)
			ts->iowait_sleeptime =3D ktime_add(ts->iowait_sleeptime, delta);
		put_cpu();
		ts->idle_entrytime =3D now;
+		ts->idle_active =3D 0;
	}

	if (last_update_time)
		*last_update_time =3D ktime_to_us(now);

}


static void tick_nohz_stop_idle(int cpu, ktime_t now)
{
-	struct tick_sched *ts =3D &per_cpu(tick_cpu_sched, cpu);

	update_ts_time_stats(cpu, now, NULL);
-	ts->idle_active =3D 0;

	sched_clock_idle_wakeup_event(0);
}

and so on.


	Sergey

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkwXmuMACgkQfKHnntdSXjRoqAP+LF/PUWkI6TtptWLhLNSz1PdC
YXAVd0zpz/IbOOf/OGHeRLeqMnEOfAyk3Y1KtIU4nI9YLBUzMrEyH1qtcYata5dx
EP9Tm4ozmOSkTVjcTMfI7VgRXAIHTN+ZKAto/Y70A6ySSxs5kJMZLjyD4VORGr5U
kl89Yk9TfAG0c6rp+X4=
=2w6o
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

--===============3479101675843363305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3479101675843363305==--

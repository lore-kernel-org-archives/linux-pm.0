From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] cpuidle: avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu) v4
Date: Thu, 17 Jun 2010 10:34:09 +0300
Message-ID: <20100617073409.GA3947__35624.8858305209$1276759891$gmane$org@swordfish>
References: <20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
	<20100617062950.GA3979@swordfish>
	<20100616235907.eb11dfcc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3769819113013917411=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100616235907.eb11dfcc.akpm@linux-foundation.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, linux-pm@lists.linux-foundation.org, Jiri Slaby <jslaby@suse.cz>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============3769819113013917411==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (06/16/10 23:59), Andrew Morton wrote:
> [..] if someone runs
> update_ts_time_stats() before the initcalls then conceivably the
> `swapper' process's accounting will go a little bit wrong, but I doubt
> it.
>=20

That was the sing that scared me - update_ts_time_stats call before init.=
=20
Having ".cpu =3D cpu" in tick_get_tick_sched guarantees correct .cpu and...=
=20
and it sucks.

> Still, it'd be better to do it earlier, I guess.  tick_init() is called
> super-early and that would be a good place.  tick_init() is presently a
> no-op if !CONFIG_GENERIC_CLOCKEVENTS, but all this code depends on
> CONFIG_GENERIC_CLOCKEVENTS anwyay.
>=20
> So how does this look?  If "OK" then would you be able to test it please?
>=20
>
I'll test it in 2 hours. Thanks.

=20
> [ Sigh.  The field tick_sched.cpu shouldn't even exist on
>   uniprocessor builds.  Ifdeffing it away is trivial and a bit messy,
>   but it's still only a partial solution.  Passing the `cpu' argument
>   to nr_iowait_cpu() will generate additional code, and it's unneeded
>   on uniprocessor builds.]
>=20
>=20
You're right.


	Sergey

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkwZz/EACgkQfKHnntdSXjR7WAP9GowE9kwn3FxH3pv1ZtoNiQOd
ZDd35HjkqBq17kqLjVAev0Ui8D44ASHQVDBO5QBPnr7YwkZ+81zT8+MxqVQzN/b7
d1Qnmra2/68LOILU8SNKTGwFG2TZxOJ5KeLYUGnN/BD3jsGLXT/+/dixwPJU05lM
/i6QwU/5wv6JcMAUTFQ=
=Mvzn
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--===============3769819113013917411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3769819113013917411==--

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Wed, 16 Jun 2010 12:34:42 +0300
Message-ID: <20100616093442.GA4230__5394.44862301952$1276680940$gmane$org@swordfish.minsk.epam.com>
References: <20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
	<20100615161303.GA4102@swordfish.minsk.epam.com>
	<20100615230541.5db5078e@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0277711527407747875=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615230541.5db5078e@infradead.org>
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


--===============0277711527407747875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (06/15/10 23:05), Arjan van de Ven wrote:
> can we do this bit once, when the ts structure gets initialized?
> it's not like the cpu value will ever change...
>=20
>=20
Hello Arjan,

Sure we can. The question is where is the "proper place"?
for_each_possible_cpu in __init?

or something like=20

static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched);
int cpu =3D get_cpu();
&per_cpu(tick_cpu_sched, cpu)->cpu =3D cpu;
put_cpu();


	Sergey

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkwYmrIACgkQfKHnntdSXjTicQP+O7zv/3k+yZTVeijM1CkXnD0s
aZEPwo8rydiZVEp/5aNT/6n8c+4PDkgZ8KgoGKbUu/u6t7hV08uz2rvD3skKM+UR
3QnsiwcVq+kKVHlf80ztYTqVDLB5J0SjjPElWkixt70o2DzjKY4gDxGgB2JceJDs
xvkPcrVuhm8obfW78x8=
=ERuC
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============0277711527407747875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0277711527407747875==--

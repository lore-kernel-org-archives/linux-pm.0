From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: BUG: using smp_processor_id() in preemptible code:
	s2disk
Date: Mon, 14 Jun 2010 17:54:40 +0300
Message-ID: <20100614145439.GA3448__49886.3797555261$1276527820$gmane$org@swordfish.minsk.epam.com>
References: <20100613203352.GA3577@swordfish>
	<1276461183.2659.4.camel@maxim-laptop>
	<201006140136.18652.rjw@sisk.pl>
	<20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3986423236162417071=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100614073853.6fa2f91f@infradead.org>
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


--===============3986423236162417071==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On (06/14/10 07:38), Arjan van de Ven wrote:
> > Hello,
> > Not sure if this simple solution is the correct one.
>=20
> it's not; the caller needs to pass in the cpu number I suspect for this
> to be really correct....
>=20
> I just returned from family emergency travel and will take a look today
>=20

I thought about patching

=2E/drivers/cpuidle/governors/menu.c:	if (nr_iowait_cpu())
=2E/drivers/cpuidle/governors/menu.c:	mult +=3D 10 * nr_iowait_cpu();
=2E/kernel/time/tick-sched.c:		if (nr_iowait_cpu() > 0)


decided to patch nr_iowait_cpu instead.


	Sergey

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAkwWQq8ACgkQfKHnntdSXjR/awP+O5HdRDq12VkRDxQV6l971hZP
PD2Cc9wZJAcGYi3TZ0KsbwmwPB9KCJwci8NnYAPcXRJ8+NCAGko8EA4JJnliTSRg
xBdVfNfpSyG+nE7G+qSRkTNw3jLTiuCh9ds1wKdH0xKIdU/KU/ZDgdwwdx9sGUl9
Gfk3Ei8162pIvm38Ofo=
=/SOs
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

--===============3986423236162417071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3986423236162417071==--

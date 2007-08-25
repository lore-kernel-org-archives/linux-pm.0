From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot
	kernel support on x86_64
Date: Sat, 25 Aug 2007 21:13:45 +0200
Message-ID: <1188069225.9529.23.camel@johannes.berg>
References: <200708241206.57178.rjw@sisk.pl> <200708241211.55319.rjw@sisk.pl>
	<20070824162346.ec57f508.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4162741694589800010=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070824162346.ec57f508.akpm@linux-foundation.org>
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
Cc: LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel@smtp2.linux-foundation.org, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org


--===============4162741694589800010==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-wJSHVUyaVAuIrbmy6XH6"


--=-wJSHVUyaVAuIrbmy6XH6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-08-24 at 16:23 -0700, Andrew Morton wrote:

> The preferred way of doing this is via Kconfig, please.  ie: add a
> CONFIG_HIBERNATION_HEADER to arch/x86_64/Kconfig.

> It would be better to do something like this in (say) suspend.h:
>=20
> #ifdef CONFIG_HIBERNATION_HEADER
> extern int arch_hibernation_header_save(void *addr, unsigned int max_size=
);
> extern int arch_hibernation_header_restore(void *addr);
> #else
> static inline int arch_hibernation_header_save(void *addr,

In fact, I guess we don't need to bother with this at all. The generic
code for doing this (via the utsname based header) is tiny, so as far as
I can tell it could just be made weak symbols (by this I mean
init_header_complete() and check_image_kernel()), and then all the
#ifdefs can just go.

johannes

--=-wJSHVUyaVAuIrbmy6XH6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG0H9p/ETPhpq3jKURAtukAJ4+6B+DDFXEDbvWoSCyXK9NnvhNSwCdH5xh
XdKnvLouZSJox6fwcdu22Bo=
=FZHb
-----END PGP SIGNATURE-----

--=-wJSHVUyaVAuIrbmy6XH6--


--===============4162741694589800010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4162741694589800010==--

From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 13:36:28 +0200
Message-ID: <20190327113628.GS22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
 <20190327101133.GQ22899@mtr-leonro.mtl.com>
 <20190327101815.GB32571@zn.tnic>
 <20190327105024.GR22899@mtr-leonro.mtl.com>
 <20190327111452.GC32571@zn.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327111452.GC32571@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Joe Perches <joe@perches.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 12:14:52PM +0100, Borislav Petkov wrote:
> On Wed, Mar 27, 2019 at 12:50:24PM +0200, Leon Romanovsky wrote:
> > It is how we are internally running verification and development,
> > with KERN_DEBUG level, we need it to catch bugs.
>
> And what is the big deal with seeing those messages? Why are *exactly*
> those two such a big problem and the gazillion other debug messages are
> fine?

At the end, it is reduced to our usage, we are running QEMU inside
docker to test kernel changes with limitation on number of CPUs to use.
The systems are optimized to boot kernel as soon as possible in order
to run tests and on my machine (64 CPUs) reduce is visible: from ~2.6
sec to ~2.3 sec from execution to kernel boot.

>
> > This "some config option" is dynamic debug prints and most probably it
> > is enabled in your or any kernel developer in the world.
>
> I personally don't use it because it only gets in the way.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm2A8AAoJEORje4g2clin8xQQAKUj1Y1NNUgVPqfZqgwLkOge
aGDBOAr9gkfbwVpuKlWkTtlsgyJDYF3Pl6VU5j2q6ZnaCbpUhZG1wd0ni8O/Y2Dj
7O+awJg88azYsn0AVXZB5HKP6AHn2hhfAdfUl1H7kn13iCKI3IZ8TnsBaeFZ3twv
V1Ufpv2iQ2LCaZeGsqdQszHNBGeSfbLGlEKWuA3JvTXNzyrLB4etG2TV2qlBMFAk
M8tpRhXPqfFhdArc2pGTkQiUvm3BnVQadQ0lf0ykj7tYrg3aHO+U1TKOP3DKY8nR
nu3rWO+01MORxI7n5OTkm36IREqbcLnGh7UhdZYjnjclsV4CCzQRvIlDkrdsXRQ+
wCvSTbsNOp3XlxUhY2/Um7SflcWn+veXY7aO0ryJZjCD6MGbmtdhh/fOTuJbPkLk
hTokZfZZkmAGhg7aLeX8gNK7xTLHoJ1SheYVSU3gXMlOXzIKXSKfwfUU2opc4oCP
MUzHABsupCNMxElMCXvnCuA8UMh2e9Rrww53LQlxD6HEZ3fF2JCqYeTz7ddhyKAw
yDQPBTStT5d7sIfsNPZyhZS0iuh7axvRbLLhE3QBfMxnLXWWoICeEwe3KwsvlSiJ
pUqxMZJvcfOerfJj6WSBK0F2VQRyX+YmeL2GVfHWT8EaUZH7uf6ONB4WUjq/HNff
JrfyaGf9guzubQf1Dfbf
=V9+c
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--

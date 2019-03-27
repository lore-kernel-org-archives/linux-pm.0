From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Date: Wed, 27 Mar 2019 13:58:39 +0200
Message-ID: <20190327115839.GW22899@mtr-leonro.mtl.com>
References: <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
 <20190327101133.GQ22899@mtr-leonro.mtl.com>
 <20190327101815.GB32571@zn.tnic>
 <20190327105024.GR22899@mtr-leonro.mtl.com>
 <20190327111452.GC32571@zn.tnic>
 <20190327113628.GS22899@mtr-leonro.mtl.com>
 <20190327114917.GD32571@zn.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327114917.GD32571@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Joe Perches <joe@perches.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-pm <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 12:49:17PM +0100, Borislav Petkov wrote:
> On Wed, Mar 27, 2019 at 01:36:28PM +0200, Leon Romanovsky wrote:
> > At the end, it is reduced to our usage, we are running QEMU inside
> > docker to test kernel changes with limitation on number of CPUs to use.
> > The systems are optimized to boot kernel as soon as possible in order
> > to run tests and on my machine (64 CPUs) reduce is visible: from ~2.6
> > sec to ~2.3 sec from execution to kernel boot.
>
> You're kidding, right?
>
> 0.3 sec boot time "improvement" for a kernel on which you run tests
> which take orders of magnitude longer (I assume). And you want to hide
> this message in the upstream kernel because you want to minimally speed
> up *your* *specific* usage ?
>
> And we still are wasting time talking about this?!

I understand your point, we will keep it internally.
Sorry for wasting your time.

Thanks

>
> Oh boy.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm2VvAAoJEORje4g2clinxEkP/R/f75qk5WO6sIAsvSO001nX
vKa2ISJHa3JHWOGE/1j49Tz1jGC3AffFipHaKCraK9DfJXD0peNz/g6GF/Kyjwlc
UPDyoET0pNS9af27DKOYdNWdFcFLKoEfm081qFtrol3SnwtLu31bZK6Or0NjX+SH
VTV1vvkXgnmkb+mhlqIgMoaga4n5fiC+A1KUdg+CZlHR0YMp+Dfom55Ftdc1H/Rf
aSRgiFCjep/vConrPe7WOQR2bhwdAZMxCQi/0hj0MlQbxk8ZqGV0WeblpyMXARoa
Hdett9TOGkGSFD1SKU6vn7uKSlAmDAra6GK45JKTbWX9HQG/zrM1tFaF5efJBa2z
mhgH9NkXWD2v8geh4pexxjSPRffQUBkm88IpMRohHwl6NQPpkCAxqFQtoWd+V4jv
XjwBsluNA0JOCo7t10H3bHM//XdiKnawinosa76OsKoHL591Jjd5fBe0JEiWH9gM
EP4nGtZ4NAzPiZat9fxp0hi6UPVhI1cX1m71TT9bMqiitPFzX3CWU5uf/ae1CgPY
MHpNUv1cTPtgaIoSZ1WXVCghGuif/WEidZofVp3Beuc7lmRiU/Qxkrh2ZA6bvnb2
WHmDfMbbnllrIFgofftTOzClF7H6sioZ8cyK8GLQz4p6CPHCehCUG09Tvmk/LVkE
F+BzQIXCQBYwNDD9hnfX
=2dI1
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--

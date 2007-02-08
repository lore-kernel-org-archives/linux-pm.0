From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 10/12] powerpc: remove unneeded exports in mem.c
Date: Thu, 08 Feb 2007 14:10:53 +0100
Message-ID: <1170940253.4385.44.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124614.830282000@sipsolutions.net>
	<17866.42529.436809.257415@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1576868106=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <17866.42529.436809.257415@cargo.ozlabs.ibm.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============1576868106==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ct+vjF7HD9KnPiLCeam9"


--=-ct+vjF7HD9KnPiLCeam9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-02-08 at 15:25 +1100, Paul Mackerras wrote:
> Johannes Berg writes:
>=20
> > arch/powerpc/mm/mem.c exports page_is_ram and phys_mem_access_prot whic=
h
> > both are not used anywhere that could be modular.
>=20
> phys_mem_access_prot is used in drivers/video/fbmem.c, and the fb
> stuff can be a module.

Ouch, sorry, the Makefile there with fb-y confused me. Seems all these
patches have one problem or another :(

I'll repost just the removal of page_is_ram then.

johannes

--=-ct+vjF7HD9KnPiLCeam9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFyyFd/ETPhpq3jKURAnG3AJ0RuqjhNObIKx8t3+94mlVfKcm9SgCgghpy
6OD5XGwPDkS3wxJgNPrkKZo=
=oxPE
-----END PGP SIGNATURE-----

--=-ct+vjF7HD9KnPiLCeam9--


--===============1576868106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1576868106==--

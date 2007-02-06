From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
Date: Tue, 06 Feb 2007 02:26:02 +0100
Message-ID: <1170725162.30959.26.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
	<20070206011949.GA15434@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1190730229=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070206011949.GA15434@lixom.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============1190730229==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pJdcLs1UbcJP2xyLypxd"


--=-pJdcLs1UbcJP2xyLypxd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:19 -0600, Olof Johansson wrote:
> On Mon, Feb 05, 2007 at 07:30:35PM +0100, Johannes Berg wrote:
> > This implements suspend and resume code for the dart iommu.
>=20
> It's a good start, but it would be even nicer to have more generic iommu
> suspend/resume hooks instead, and do the alloc/copy there. Add the hooks
> to ppc_md together with the rest of the iommu/tce ops.

Ok, I'll take a look. I think we should leave the alloc up to the code
and just have generic calls for what now is iommu_dart_{save,restore}, I
see no point in adding a callback for iommu_init_late_dart since any
other iommu can do it as a late_initcall as well.

> > +	/* this 16MB area is left unmapped because of caching
> > +	 * considerations. that happens early so we can't mark
> > +	 * it there, do it now instead */
> > +	for (i =3D 0; i < (1<<24); i+=3D PAGE_SIZE)
> > +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i=
)));
>=20
> Please do a local void * instead, makes for much less casting in the loop=
. :)

:)

johannes

--=-pJdcLs1UbcJP2xyLypxd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFx9kq/ETPhpq3jKURAsJHAKCvlD8M+JKwKRAO5OYT8/Ze/oY8LQCeJEuJ
vx2tNurpdNnn6CqN/DyCJcY=
=MzUB
-----END PGP SIGNATURE-----

--=-pJdcLs1UbcJP2xyLypxd--


--===============1190730229==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1190730229==--

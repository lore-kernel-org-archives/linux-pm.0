From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
Date: Wed, 07 Feb 2007 12:42:58 +0100
Message-ID: <1170848578.6798.11.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
	<20070206124047.GC8662@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1334837298=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070206124047.GC8662@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============1334837298==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-G0BPY5vklzayzNmYQWIv"


--=-G0BPY5vklzayzNmYQWIv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-06 at 13:40 +0100, Pavel Machek wrote:

> > +		SetPageNosave(virt_to_page((void*)((unsigned long)dart_tablebase + i=
)));
> > +
>=20
> 80 columns rule?

Good point. Changed according to Olof's comment anyway so it should be
shorter now.

> > --- mb-wireless.orig/include/asm-powerpc/iommu.h	2007-02-05 14:24:05.01=
4526864 +0100
> > +++ mb-wireless/include/asm-powerpc/iommu.h	2007-02-05 14:24:40.6845268=
64 +0100
> > @@ -108,6 +108,10 @@ static inline void pci_iommu_init(void)=20
> >  #endif
> > =20
> >  extern void alloc_dart_table(void);
> > +#if defined(CONFIG_SOFTWARE_SUSPEND) && defined(CONFIG_U3_DART)
> > +extern void iommu_dart_save(void);
> > +extern void iommu_dart_restore(void);
> > +#endif
>=20
> You can go without the ifdef; extra prototype does not do any harm.

Changed as well anyway to introduce powerpc iommu suspend ops, though I
introduced two static inlines that are still ifdefed.

johannes

--=-G0BPY5vklzayzNmYQWIv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFybtC/ETPhpq3jKURAuvVAJ93bZBNMC/e4EgE9xqzAAsg2YbbowCffAEZ
EPJ14cKK0g8sove8UtyeLR8=
=g6+u
-----END PGP SIGNATURE-----

--=-G0BPY5vklzayzNmYQWIv--


--===============1334837298==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1334837298==--

From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 05 Jul 2007 14:50:25 +0200
Message-ID: <1183639825.3818.38.camel__17089.5164869309$1183639811$gmane$org@johannes.berg>
References: <E1I63Nv-0006Z9-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.44L0.0707041139100.25704-100000@netrider.rowland.org>
	<18060.15630.812698.367707@cargo.ozlabs.ibm.com>
	<200707051451.38497.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4159459121572796858=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707051451.38497.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mjg59@srcf.ucam.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org


--===============4159459121572796858==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5wbtt3bjFieiS1P7Vk4K"


--=-5wbtt3bjFieiS1P7Vk4K
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-07-05 at 14:51 +0200, Rafael J. Wysocki wrote:

> > > Remember what I wrote a few minutes ago about khubd and ksuspend_usbd
> > > wanting to resume devices during a system suspend transition?  This i=
s
> > > exactly what happens when those threads aren't frozen.
> >=20
> > So, I wonder why I don't see that error on my powerbook?
>=20
> Because you have only one CPU running while your suspend code is being
> executed?

If that's really all the problem then what's wrong with just unplugging
the other CPUs earlier? Sure, that makes suspend no longer perfectly
transparent since userspace might notice the CPUs being unplugged, but
it has to cope with that anyway since a user can do it manually...

johannes

--=-5wbtt3bjFieiS1P7Vk4K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGjOkQ/ETPhpq3jKURAuS+AKCkOs0M4b62O+mlZjMKGlO7InyTyQCfU+/Z
ZOzbFpjyaZyeiBmCweuEM90=
=Bh3G
-----END PGP SIGNATURE-----

--=-5wbtt3bjFieiS1P7Vk4K--


--===============4159459121572796858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4159459121572796858==--

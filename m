From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 04/10] x86, olpc: Use a correct version when making up a
 battery node
Date: Fri, 5 Apr 2019 15:59:48 +0200
Message-ID: <20190405135948.wnwv2qq3wz7bzsog@earth.universe>
References: <20190310162419.11861-1-lkundrak@v3.sk>
 <20190310162419.11861-5-lkundrak@v3.sk>
 <alpine.DEB.2.21.1903230020270.2157@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cicfdoeib2e7lfta"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903230020270.2157@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lubomir Rintel <lkundrak@v3.sk>, Darren Hart <dvhart@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--cicfdoeib2e7lfta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 23, 2019 at 12:25:58AM +0100, Thomas Gleixner wrote:
> On Sun, 10 Mar 2019, Lubomir Rintel wrote:
>=20
> Subject prefix ...
>=20
> > The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> > ambient temperature. We need to use a different compatible string for t=
he
> > XO-1.5 battery.
> >=20
> > Previously olpc_dt_fixup() used the presence od the battery node's
>=20
> s/od/of/
>=20
> > =20
> > +int olpc_dt_compatible_match(phandle node, const char *compat)
> > +{
> > +	char buf[64];
> > +	int plen;
> > +	char *p;
> > +	int len;
>=20
> Please coalesce variables of the same type. No point in wasting space.
>=20
> 	char buf[64], *p;
> 	int plen, len;
>=20
> Hmm?
>=20
> > +
> > +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
> > +			/* If we have a olpc,xo1-battery compatible, then we're
> > +			 * running a new enough firmware that already has
> > +			 * the dcon node.
> > +			 */
>=20
> Comment style:
>=20
>        		 	 /*
> 			  * This is a proper multi line comment even
> 			  * if networking people use that horrible style
> 			  * above.
> 			  */
>=20
> With those nitpicks fixed:
>=20
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Looks like this is the last required change before this can be
merged. Assuming Lubomir sends a fixed series soon, how should
it be merged?

a) I get a pull-request with a immutable branch for patch 2-4
b) Complete patchset goes in via x86
c) Complete patchset goes in via power-supply

I'm fine with all variants.

-- Sebastian

--cicfdoeib2e7lfta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynX1QACgkQ2O7X88g7
+ppT6hAAnwa8NzJM9yXdDEp4T6Ci3Aiq3Nus2/3mrQwSI66pYQkangJzm0S1wy8u
p9Y/SUD1PXtAKPtcnfh6uKp78gsqig+SmKaVC6CU415NuewyjzXDh0jnDAYGjR71
QfofvUZc/l2X5Dl0AzpiUHp3uGb90pkAGqbo3hLdLGRfM6ZQUMs56uC2qyhYBj/U
P2hi6sDnpCFGzk+5JkL2oR/XSuq4EUeJXoRfUsvMyFfmwKewbZCi9yONn6HVy9tF
DfI6ATIbicDQ8RqaLFAcSFukIL/z0B1KTrc8W49b3XPMLbsmF5jm4iEYJem99k2p
MD8pp0JSJudbDwD/rw2GseyAI1JS7qcAysdMQ8AvXqk8zjG3h+qtcopeCM9IZJmJ
sK1UPEwY9uIuzrAylGw0HyqRPrPvDU3GUNC49+N7M2GA2Se0GSatkwc+FmAnhaUV
6BvGQSkVPU2sANVYdy9bRgPGXscJcCZ5Bodmd/70tYlFfKQgUY5Cs6R1YWSs4CSd
nInDgYrUnG8zggqWbFnVt+XIg+6Gzrf6w4d3AABBxin7x+beno98pLx/nUeVa1Wh
jvYzTn1cfq52ZmayrkwLTHnnljCqoYhuAXK8JLsijO5PNJyfPbRH2ptADTBtbW+W
UlfEol9hp7SGMwBFJKZ06ksvpl+JqQJuDrhHeOfBlQdfOeKG0II=
=Fcpl
-----END PGP SIGNATURE-----

--cicfdoeib2e7lfta--

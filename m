From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 0/9] PM / OPP: Multiple regulator support
Date: Tue, 22 Nov 2016 18:41:03 +0000
Message-ID: <20161122184103.djm3jn67gshdtun4@sirena.org.uk>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <20161118030636.GA3110@vireshk-i7>
 <20161118104329.27xpm7cshfpxykqd@sirena.org.uk>
 <20161122034922.GC3070@vireshk-i7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m2mkehqu6k3y2gp3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44688 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934277AbcKVSls (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 13:41:48 -0500
Content-Disposition: inline
In-Reply-To: <20161122034922.GC3070@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh@kernel.org, d-gerlach@ti.com


--m2mkehqu6k3y2gp3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 22, 2016 at 09:19:22AM +0530, Viresh Kumar wrote:

> So the LAST remaining question is:

> "How do we know (from the DT) the order in which entries for multiple reg=
ulators
> are present in the OPP table?"
>=20
> And I am not sure if we can do that without having a property like:
>=20
> +               supply-names =3D "vcc0", "vcc1", "vcc2";
>=20
> in the OPP table or the consumer device. And surely it isn't a clean enou=
gh
> solution and that's why this series relied on the code to get such detail=
s.
>=20
> Does someone have an alternative? If NO, can we go ahead with this series=
 as is?

I'm really not at all clear why this has to be in DT.  My understanding
was that this is basically a helper library for more specific bindings
which already have to hard code things like sequencing so surely they'd
be specifying the ordering to be used when supplying data?

--m2mkehqu6k3y2gp3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYNJE+AAoJECTWi3JdVIfQiuwH/irrh/Cv+2VWaiz2m68xrN2f
mjMwFHBrUGPgqhFq0faGZL1LNPvFioptHZMteJq+H0svonERCm64GGq27uxkmUi9
vpAe39eKP/MFVjPDa2OVtrSGEF0ssXH4jNFeEhkKhZgjID2dx9vvYCr4ajwQSYS5
RUbUh/jphvixlxn55S1T7zUeVSekHHXRJeuz1pZ6Eh9TOccjcA/28TDiQD67o+tW
7XlO+YKje5M2vc06AAq4IgIBL+cebgTATD0cuhm/vGT2++ptnLxao4hSzUKDiclR
D9+10L6/YdoTDC/joN1/6E68b8BrfVp2JAw+eeKzypf/bEXii7RV/Y0LPdho7TQ=
=tFmx
-----END PGP SIGNATURE-----

--m2mkehqu6k3y2gp3--

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V2] OPP: Redefine bindings to overcome shortcomings
Date: Fri, 23 Jan 2015 11:52:06 +0000
Message-ID: <20150123115206.GT21293@sirena.org.uk>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <1422013154.29475.11.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GGxZz/e2pmGePzrA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422013154.29475.11.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--GGxZz/e2pmGePzrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2015 at 12:39:14PM +0100, Lucas Stach wrote:

> > +  Required properties:
> > +  - opp-khz: Frequency in kHz
> > +  - opp-microvolt: voltage in micro Volts

> Each OPP voltage should be defined by the triplet of minimum,
> nominal/typical, maximum. This lets you specify exact tolerances in each
> direction and should cover most use-cases.

> IMHO it would make sense to just define opp-microvolt as an array of
> those 3 values, so the DT doesn't get bloated with a lot more
> properties.

> A typical value for a CPU could then look like this:
> opp-microvolt = <800000 850000 1100000>

I tend to agree that this is clearer.  It might be nice to have variants
for specifying directly as a percentage but I don't think it's really
worth the complexity.

> For devices without any tolerance you can just specify the same value
> three times and be done with it:
> opp-microvolt = <900000 900000 900000>

If we change the binding to be typ/min/max rather than min/typ/max then
we could also do this by allowing either one or three values to be
specified.  That might be more worth the complexity especially given...

> > +  Optional properties:
> > +  - turbo-mode: Marks the volt-freq pair as turbo pair.
> > +  - status: Marks the node enabled/disabled.
> > +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

> Please let's drop this.

DT bindings are supposed to be stable, this means the code should accept
old bindings and they should be documented as deprecated.

--GGxZz/e2pmGePzrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUwjXlAAoJECTWi3JdVIfQzVUH/39T4b5ZKuAE1Z45bJIZjXCz
8cbvKWEmF903edzvxMGsy+5ygUKM5ACfvt7CJ6ZQ3t5qlwy3KNqUgKUgGGWaVDmw
n4gFaS/1QBu3328Qbd3+jZTtQuIaAZJEhF6ocZ/cfAZbg9VXEPxFVF0gh4hDstN2
cyoI6hbdjU7yZCCkM9ML5EFOohplymN0dFF3quOQ3MtVPP0B2b88qtp6SdYDC9HL
l2eM2e/GTCOR/xK/32HTCasyhgmSlXyDJ/rk0eqRoVceNsZ0aZwSO6SK1ZxABU8Z
Qi0XtfHkWVt17NMxVc2XlUEUTcl3PkO+wKBrNA4awBkDzERnJCTm/dqVWB6YpnU=
=NY1Q
-----END PGP SIGNATURE-----

--GGxZz/e2pmGePzrA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

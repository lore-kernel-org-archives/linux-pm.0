From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/3] OPP: Add new bindings to address shortcomings of
 existing bindings
Date: Tue, 2 Jun 2015 20:14:38 +0100
Message-ID: <20150602191438.GF14071@sirena.org.uk>
References: <cover.1432797343.git.viresh.kumar@linaro.org>
 <96d49e7e6747c1a65c5f285d70600795126641cc.1432797343.git.viresh.kumar@linaro.org>
 <20150602183120.GB24349@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IGPMjTREWkoKVnU2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150602183120.GB24349-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--IGPMjTREWkoKVnU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 11:31:20AM -0700, Stephen Boyd wrote:
> On 05/28, Viresh Kumar wrote:

> > +			opp-supply = <&cpu_supply0>;

> opp-supply isn't mentioned anywhere. Is that intentional? Is it
> supposed to be cpu-supply still? It isn't clear to me from the

I'm also a bit worried about the naming here - regulator supplies should
always reflect the name of the supply in the hardware and it seems
unlikely that this is one.

--IGPMjTREWkoKVnU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbgCdAAoJECTWi3JdVIfQYJ8H/1O60vlVuymtEpehVlws6rRh
0usGd7GYm6ErzC+B69YNBoilsaIOS9ehAig+nKD1PEjXdPHRBuUc0995CbY2KyAl
d6UBb0yBWkjVDN8n+rlcwe9sIo2IPpFc+IGOeUbA30Ka3F10DrJtvUJrnm+lXBt0
98TYAoNJfSvp5N1Xz+AG3ZkTkwsfUDFmKpttsJi1yrgAK448oB83EG1FTqyvcW7n
zXDXAjJvO9v2W7NVv4WqmV3IxCyBHbHJl/7yaN4XnKzUVUOIQzHcsIT0pOHL8dsj
nWK8dTU4OQJrOfR7x/r8IP0pj5cjCh+Sg3Y1v4YOidOtcXUGvg2ysSFBp/F/NJs=
=gWzw
-----END PGP SIGNATURE-----

--IGPMjTREWkoKVnU2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

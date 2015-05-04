From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Mon, 4 May 2015 13:12:09 +0100
Message-ID: <20150504121209.GM15510@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m+utxuhC6KVTvgNz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, mike.turquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Sudeep.Holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viswanath.puttagunta-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ta.omasab-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kesavan.abhilash-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, santosh.shilimkar-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--m+utxuhC6KVTvgNz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 05:37:59PM +0530, Viresh Kumar wrote:

> +- opp-microamp: current in micro Amperes. It can contain entries for multiple
> +  regulators.
> +
> +  A single regulator's current is specified with an array of size one or three.
> +  Single entry is for target current and three entries are for <target min max>
> +  currents.

What is this for - are you trying to define OPPs for current regulators?
If you are that's worrying, I can't think of a sensible use case.  If
that's not what's happening then the binding needs to be more specific
about what this is supposed to mean.

--m+utxuhC6KVTvgNz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2IYAAoJECTWi3JdVIfQSvsH/08AXn11XXi9P0d58UCqLswK
vIS5x28xRtE8qkOQI72Gt6eXu+QVdNHlzY7oocNoJcy607nwfOwFzv8Ghmz6cFQr
A0qqt4d36tTxqZkxZGP+vVxdhTAzLOcH4UvW+wit5Ui75L6Yv2Aon0u9Ei4ZQ1+N
U/hp+1wk2WYN98QRdeT3z3f0xTDVG6Dfxpm4zfjrnivze8m+ETZ7X48erKF6RMAg
eM3THXkRpW7fcVoKqalc7EiihGjI/RDc61sQqWRBNC059dmRMfaGPRAMqjmMsQ7k
wNFzUamXVS8tzn5VhRyrgj0E+Spk+yWGuyuhYGkdch8mxmXksldr4U31Vt8J32Y=
=0VO9
-----END PGP SIGNATURE-----

--m+utxuhC6KVTvgNz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

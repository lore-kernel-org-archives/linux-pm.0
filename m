From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/6] arm64: Enable dynamic CPU capacity initialization
Date: Mon, 8 Feb 2016 13:13:20 +0000
Message-ID: <20160208131320.GA7265@sirena.org.uk>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-5-git-send-email-juri.lelli@arm.com>
 <56B889F7.306@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56B889F7.306-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>
Cc: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 08, 2016 at 12:28:39PM +0000, Dietmar Eggemann wrote:
> On 03/02/16 11:59, Juri Lelli wrote:

> > +bool arch_wants_init_cpu_capacity(void)
> > +{
> > +	return true;

> Isn't this a little bit too simple? Not every ARM/ARM64 platform is a
> heterogeneous one.

Does it matter?  Is there any problem with doing the callibration and
having it say that all the CPUs performs very similarly?  My
understanding was that this was simply saying it was worth checking to
see if there was some asymmetry.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWuJRtAAoJECTWi3JdVIfQUD8H/iZc9YYBDMzZWkZsDW2IrWBo
mDB9Z9DscDFYhmPG71m4uDBk9HFx3FtdJWU5TZ6UBXLrsVcPCys7CS9PG3BGHv/s
OgIGl3tXNIjh23IejucCofWy/6ER9v+vYlfCnJ39sE0jcD9OT55w5T3wjhbC9/EC
2hW2q80MvlBRLK8NtYby9PvRlvIGD631R/VoBRFCANTxLVvHvxY/kvxOKXCsYnaj
j17sETQbOh0MkS+gAXunXg3jVbUasVCN//gCBjsa1NyGRcZVven2L4bHDrmaT4jN
ZZcJPTtmw6HXatCNf4j6tPOYtxNfumLsahV4/wX7VLbtaAmAgjq0H18YDUCJHa0=
=aRfM
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

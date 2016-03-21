From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Mon, 21 Mar 2016 12:12:10 +0000
Message-ID: <20160321121210.GQ2566@sirena.org.uk>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
 <56EC3F9E.4050209@nvidia.com>
 <20160321105330.GB12319@e106622-lin>
 <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
 <20160321114956.GD12319@e106622-lin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W+SeThb1UGlzpiPr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160321114956.GD12319@e106622-lin>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Cc: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sai Gurrappadi <sgurrappadi-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Olof
List-Id: linux-pm@vger.kernel.org


--W+SeThb1UGlzpiPr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2016 at 11:49:56AM +0000, Juri Lelli wrote:

> But we'll still need to normalize this w.r.t the highest score we get on
> a specific platform, right? And while we are at normalizing it, it is
> probably simpler if we keep the frequency component as part of the
> number, IMHO. But, maybe keeping the frequency component separate is
> more acceptable from a DT binding perspective?

One possible issue with that: if we keep the frequency number as part of
the core number then that might cause issues for devices with variants
or system deployment decisions that remove some OPPs from a table.  If
the top OPP gets removed that would throw off the numbers.

--W+SeThb1UGlzpiPr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW7+UYAAoJECTWi3JdVIfQwhwH+wSHJuuvTb53sqB4q3Mml/1v
rbErBmWKupzkHUVzynyLaTWCF6ZOkXI7AHPguMO3W7TeF17zRKZsDVUvIP62F2WT
VSpcuT0mr2QY6/sA6nO2pKOymaWYm+6yXoWIJZuTCIeKmtl/vhqhruT9ngOeQwbl
qM4vkSFgBBS7/motSHhWPAkPtceOKpU8QaqH1vhrtOGDkHh+RS2fSIELrTb1gQWa
4kFpMoM04nH5V1g1tEMGpl6ZsGUJzrG/dXxq7oBdusFhUFeSZ+nZppdsMzWFgFqz
1MNQaSFMycpybtsmmrH2jrPOM/SsAVKL29Ms87sze45TZA8PREl0/Ax4X2Z6D70=
=tX7c
-----END PGP SIGNATURE-----

--W+SeThb1UGlzpiPr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

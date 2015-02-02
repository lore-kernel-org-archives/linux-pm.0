From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCHv2 1/1] cpufreq: exynos: allow modular build
Date: Mon, 2 Feb 2015 14:22:15 -0400
Message-ID: <20150202182213.GF17425@developer.hsd1.ca.comcast.net>
References: <1422730782-13055-1-git-send-email-edubezval@gmail.com>
 <CAKohpondsvLm2S_V+aBSoCg252nHONJ6TbyTuHoVYuwxBDEuDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpondsvLm2S_V+aBSoCg252nHONJ6TbyTuHoVYuwxBDEuDA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 09:33:09AM +0530, Viresh Kumar wrote:
> On 1 February 2015 at 00:29, Eduardo Valentin <edubezval@gmail.com> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >

<big cut>

>=20
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

>=20
> Now as these are all compilable as modules, should we look into the drive=
rs as
> well to see what they are doing on module unload ?

hmm.. it seams to be the case, yes. From a quick look, there are unreleased=
 resources
that needs to be freed. However, they are not really on module unload,
but on device removal. Which should be a reproducible but even today, in
case one manually unbinds the device.

Let me have a look here and will be sending something soon.


Thanks,

Eduardo Valentin


--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUz8BJAAoJEMLUO4d9pOJWgswIAJ2CgMsC9kNE4xzkPbkbsPta
iC/rpcCI3bMuGto14/owwXnvExyRG+jS4K9RV4k2VekNGVbSfqBHFxfE3lqUZ+tO
Ws/VZx7VPHN1TZHLt5m4o89hhCF3aUnqt7P1d5Ua3rStvKYfq+cn7vJivK+rUcei
CHfvvdFY1vJil60D2u+vYxa1EIlyoroBfzyxT5vn8wt4+mxre6BI3MDkEgxia5Pd
lRL5LLFv9V5c0Xgm4h/Wz2SBBIcuoMrmykolBhNHib137LERDOTpXp0mcfnXSshv
I2wEpuX0WvWZg06GATwyBUPISIzQ58LjhPK4G1HfXFE9WX7YBhKewyfzm55W9V8=
=Ksmw
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--

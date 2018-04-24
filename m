From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] regmap: include <linux/ktime.h> from
 include/linux/regmap.h
Date: Tue, 24 Apr 2018 18:31:06 +0100
Message-ID: <20180424173106.GE22073@sirena.org.uk>
References: <ccea364eeb830b2092987d271c8308b97fe59d8f.1524465345.git.sean.wang@mediatek.com>
 <20180423100318.GA19834@sirena.org.uk>
 <d3e10dc5-55d3-40b8-a8de-d48aaaecf019@gmail.com>
 <20180423115043.GD19834@sirena.org.uk>
 <f4025431-be9a-32f9-06e1-9c6ac185c96a@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2666023413235501595=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <f4025431-be9a-32f9-06e1-9c6ac185c96a-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--===============2666023413235501595==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 04:07:10PM +0200, Matthias Brugger wrote:
> On 04/23/2018 01:50 PM, Mark Brown wrote:

> > So it looks like there is a dependency here...?

> Yes, regmap_read_poll_timeout macro uses for example ktime_compare which =
is
> defined in linux/ktime.h

> That's my understanding.

OK, it's important to make sure that people getting a patch series know
about stuff like this as it will affect how things are reviewed and
applied. =20

The following changes since commit e241e3f2bf975788a1b70dff2eb5180ca395b28e:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ms=
t/vhost (2018-04-11 18:58:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/r=
egmap-ktime-fix

for you to fetch changes up to f15cd6d99198e9c15229aefec639a34a6e8174c6:

  regmap: include <linux/ktime.h> from include/linux/regmap.h (2018-04-24 1=
8:11:50 +0100)

----------------------------------------------------------------
regmap: Fix missing include of ktime.h

Required for some dependencies.

----------------------------------------------------------------
Sean Wang (1):
      regmap: include <linux/ktime.h> from include/linux/regmap.h

 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfadkACgkQJNaLcl1U
h9AlHQf/bC6mn12CND4+25wXDK/guAEy3YpckmZXliCZ67oYASB1lLcKxu1OqQjN
U/QLwp1Xbo0HhKmvT3OQBZAEtPPUOJOEHWCevu/jVi+9j3W793P5hW3+vzAhYvVc
MlD1/9xSqskL8pSVIfiQMRa133zKUPN7Yb1VmP/Y2I+kksgB0llJakMegX1ljpka
uHKCweP0yli6KmZL6um29miFw6NZ0GOhVBrYucPPe8ovmJmrfQFT5B/zPRAqlJmu
eWi1+hXjk0o7KHXx3J3wHgDk9hXGO2eJlyKghOX0efIWWw9Jznir1BZg4V+dpVdh
OMaPVaup5ztQWdB+vNK33I1jZxd3Ig==
=aChS
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--


--===============2666023413235501595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============2666023413235501595==--

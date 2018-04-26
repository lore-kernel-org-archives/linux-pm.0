From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] spi: Respect all error codes from
 dev_pm_domain_attach()
Date: Thu, 26 Apr 2018 12:39:34 +0100
Message-ID: <20180426113934.GB21755@sirena.org.uk>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524732790-2234-12-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 26, 2018 at 10:53:10AM +0200, Ulf Hansson wrote:
> The limitation of being able to check only for -EPROBE_DEFER from
> dev_pm_domain_attach() has been removed. Hence let's respect all error
> codes and bail out accordingly.

Acked-by: Mark Brown <broonie@kernel.org>

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhunUACgkQJNaLcl1U
h9CMmQf+KRWcQQKCEHfr+D2f1485UVJqBCyZrLuN8vRgon7ZNa3S1sq72ZQvrN8x
4vFBqF9p9kKoHo/MzgyBQXITYk0mpk3gLtgIQSGBnIog9DtKA6MDY2D/OtvGjMob
g4+Lml0u5ZmcysNOpa7vzipvBeuoOC5KkMuL5vrCGxp1UFZnFxCg76sDUccVeqVr
zSpkopLF2ZW68v9x+XJmhpKl5hNdu4xFUoVU4oaVHSUwIjMYt6goVSo4WZjf5cGa
zhx0HETAwL1iNX5Nurw51g6e3WaiLeHHSmtv6dgFlg1pac/kEeL3Cj23T8Q9d1oq
d466W6BB/El+rPkU5UN8ci96SVWPOA==
=b7nj
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

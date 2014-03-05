From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] ARM: s3c64xx: pm: Add always_on field to
 s3c64xx_pm_domain struct
Date: Wed, 5 Mar 2014 12:28:35 +0800
Message-ID: <20140305042835.GG13126@sirena.org.uk>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
 <1393862536-9842-6-git-send-email-tomasz.figa@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xGZLEhdrcEmdnWHc"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393862536-9842-6-git-send-email-tomasz.figa@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Tomasz Figa <t.figa@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org


--xGZLEhdrcEmdnWHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 05:02:10PM +0100, Tomasz Figa wrote:
> This patch adds always_on field to s3c64xx_pm_domain struct to allow
> handling registration of all domains in the same way, without the need
> to have separate arrays for normal and always on domains.

Reviwed-by: Mark Brown <broonie@linaro.org>

--xGZLEhdrcEmdnWHc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFqfvAAoJELSic+t+oim9cmwP/0PRalfpxflk5hcup/0RWFXc
Xz0n4NnK//EQiZjO/1jGMYkpwtwl/j3B+zeHNmWch38CgK7z6vngi8gi8+rNetfe
ZxcLXPTTgeeL5wsiwgxQGl7zuS8VE4dRX9Fmyyuy0ph0BrZze28b4C/iDb4H6exR
Efd1Zs6E4zwVh4thECWb45we2FjpnhZeG+2MxVGg7aikJcM2EBenOc1Jr3joFu7k
jp2Zv/0KNoblmqqiBVyZjkx4BhtmuLdARAYrZl6ZUlCVrL50EEFydn+yDA19Vknz
3M5SOZl5TVYcbLKMhktB/Q6JgCt7fn9a2RXsA2hDPCdcOSwQoyquGs+WITdqPguC
p3A4fNf4vc47kyN+BF1sZcYMQPC6uDNIOqPAmSGoa1EIt2Ygfx04gfY23sr95K5N
9HrJolJ+8eAOtMTPytHkceAajmLPE3UVzcEvCncuKRzC1fIlkYSuFyOwZIDop/9m
JC/zX5xFf2zmp5VQEE2z22Jf9BQ0a+8y+tic1pGI1yfyzYIxMy4hJ4lI30sLx3vn
TQqeJoFVoLXV5Q0d/ZCrJUP7uFwh/DJLEXOAUOlKRkgcBTzT4gfca4jWLC9aXy28
E/aBtGQdhSpnX8njGvrKDO2tDfvIKf5CMdxeMiDQ/DmhCoDo9wn5a+CSDz0r0Je7
TIQjvtMuVQqUl/zEqhKS
=Xxt9
-----END PGP SIGNATURE-----

--xGZLEhdrcEmdnWHc--

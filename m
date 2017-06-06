From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] regmap: Add 1-Wire bus support
Date: Tue, 6 Jun 2017 19:50:09 +0100
Message-ID: <20170606185009.vuosw4amnqnl5bf6@sirena.org.uk>
References: <20170602070629.8210-1-minimumlaw@rambler.ru>
 <20170602070629.8210-2-minimumlaw@rambler.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eqt3zajegioz6uiy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170602070629.8210-2-minimumlaw@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--eqt3zajegioz6uiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 02, 2017 at 10:06:27AM +0300, Alex A. Mihaylov wrote:
> Add basic support regmap (register map access) API for 1-Wire bus

Applied, thanks.  I created a signed tag for the other two patches to
use:

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git regmap-1wire-support

for you to fetch changes up to cc5d0db390b0ff0f5da95b643a2b070da15a9c3e:

  regmap: Add 1-Wire bus support (2017-06-06 19:47:28 +0100)

----------------------------------------------------------------
regmap: Add support for 1wire bus

This tag contains a patch adding support for the 1wire bus to regmap.

----------------------------------------------------------------
Alex A. Mihaylov (1):
      regmap: Add 1-Wire bus support

 drivers/base/regmap/Kconfig     |   6 +-
 drivers/base/regmap/Makefile    |   1 +
 drivers/base/regmap/regmap-w1.c | 245 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h          |  34 ++++++
 4 files changed, 285 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-w1.c

--eqt3zajegioz6uiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk2+WEACgkQJNaLcl1U
h9BrGQf+LZHHHowIez6HMk8tW/NujtMB8lFOZMSTSz0rVtGkobNep4vNfkc4R0T6
YEB1PJyzDzjE4uuNpVmk512b7j4Kb/mN9C3rOCvXD5OhLIo+ZpEgOx1mCKwe9d+4
4EusXZDjM6i+gWVFzzXMR1nkjtHR7JBdlLhZ5cp6oREdn9Q0qYwcCf21IONLYjUn
cUh1t4az8zgE6fmvrpr27eW1O0SFVnvh8P8mVfCpyzVuFoH8EwDbacdVdDayfWoI
yUeLb2ofL5+gjEMtIS1sngdA5zKv8EAI95ktCchl3qLkbiGHmUq2YSBtrZe//biq
Vgf+0pIzrWaEFw0JHJmuqrXSy/5DWQ==
=IOAQ
-----END PGP SIGNATURE-----

--eqt3zajegioz6uiy--

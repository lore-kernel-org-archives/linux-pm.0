From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / Domains: export pm_genpd_add_device symbol
Date: Mon, 16 Nov 2015 17:23:15 +0000
Message-ID: <20151116172315.GE31303@sirena.org.uk>
References: <1447664848-11372-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
 <CAPDyKFrd-kdgJNioPc7KcUpF+VV+-MDOG7BobMJ+V9aq1Lo=fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrd-kdgJNioPc7KcUpF+VV+-MDOG7BobMJ+V9aq1Lo=fw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 16, 2015 at 12:08:17PM +0100, Ulf Hansson wrote:
> On 16 November 2015 at 10:07, Maruthi Srinivas Bayyavarapu

> > Drivers which can be built as loadable module needs
> > symbol - pm_genpd_add_device to be exported. Those drivers
> > create platform devices which comes under a powerdomain.

> Currently this API is used by a few SoCs that haven't yet been
> converted to device tree.

> Can you tell me more about what driver/SoC you intend to use it for?

He's got a graphics card with audio subfunctions that looks a lot like a
general purpose SoC with power domains and resulting code that looked
like it was trying to redo the power domain code, I asked him to
refactor to use that instead of open coding a version in the driver.

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWShEDAAoJECTWi3JdVIfQqM8H/0rSu/FNyJmFKywdwwrpdQxR
4rRJ9XzvIf3tt3q7Jdl97dcOFpB0nZ3dqSNDIehFR0txlU0vI4Fxp7b6wEL002Nc
bgyZ5Wonls0Rpd4NZmiIpCLVVyVBUfsa4UTS2AeVzkIprVdUqdKai5ecmkLSqauq
1yCBIVmUzqR+2ycaA4b9ZguoNSNmaozGvWpmhnRPdPzFbjTlTbzFfYMERpTpW3Ph
5zGd6q82pHrbfbqJihdU/mhCHWClsaAL5U2rxVGk0GXuc39SOaIyPacRlIHTJ+2i
noXXAVxZ5X1lftITnjf48Jstmr2/9g9Qk7jk74itQexisUuGFkDsioEbXqk5h18=
=dTNq
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--

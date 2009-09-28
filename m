From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] PM / PCMCIA: Drop second argument
	of	pcmcia_socket_dev_suspend()
Date: Mon, 28 Sep 2009 13:31:12 +0200
Message-ID: <20090928113112.GA5602__20630.2980114289$1254149499$gmane$org@pengutronix.de>
References: <200909260122.59030.rjw@sisk.pl> <200909260125.11149.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3655822930074771626=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909260125.11149.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, linux-pcmcia@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Florian <fs-kernelbugzilla@spline.de>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============3655822930074771626==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2009 at 01:25:11AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> pcmcia_socket_dev_suspend() doesn't use its second argument, so it
> may be dropped safely.
>=20
> This change is necessary for the subsequent yenta suspend/resume fix.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pcmcia/at91_cf.c        |    2 +-
>  drivers/pcmcia/au1000_generic.c |    2 +-
>  drivers/pcmcia/bfin_cf_pcmcia.c |    2 +-
>  drivers/pcmcia/cs.c             |    2 +-
>  drivers/pcmcia/i82092.c         |    2 +-
>  drivers/pcmcia/i82365.c         |    2 +-
>  drivers/pcmcia/m32r_cfc.c       |    2 +-
>  drivers/pcmcia/m32r_pcc.c       |    2 +-
>  drivers/pcmcia/m8xx_pcmcia.c    |    2 +-
>  drivers/pcmcia/omap_cf.c        |    2 +-
>  drivers/pcmcia/pd6729.c         |    2 +-
>  drivers/pcmcia/pxa2xx_base.c    |    2 +-
>  drivers/pcmcia/sa1100_generic.c |    2 +-
>  drivers/pcmcia/sa1111_generic.c |    2 +-
>  drivers/pcmcia/tcic.c           |    2 +-
>  drivers/pcmcia/vrc4171_card.c   |    2 +-
>  include/pcmcia/ss.h             |    2 +-

Hmm, you are not converting yenta_socket here. Won't that break building the
kernel (git bisect)?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrAnoAACgkQD27XaX1/VRtxegCgmbKC0z7ceG7isafnG6XN5F2q
moYAn2GulkLz/d2S2rD8Z67rVqjUMYPj
=A7hI
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--===============3655822930074771626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3655822930074771626==--

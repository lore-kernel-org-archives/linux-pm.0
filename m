From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Thu, 5 Mar 2015 01:30:45 +0100
Message-ID: <20150305003013.GA1033@earth>
References: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34673 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916AbbCEAa5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 Mar 2015 19:30:57 -0500
Content-Disposition: inline
In-Reply-To: <cover.1423082056.git.todd.e.brandt@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lee.jones@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@linux.intel.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 04, 2015 at 04:24:35PM -0800, Todd Brandt wrote:
> New power_supply driver at driver/power which interfaces with the
> axp20x mfd driver as a cell. Provides battery info, monitors for
> changes, and generates alerts on temperature and capacity issues
>=20
> Sebestian, please review the patch set and consider it for 3.20 rc1.
> I've applied it over git.infradead.org/battery-2.6.git/master and
> verified that it works. Thanks.

Lee, are you ok with patches 1+2 going through power supply
subsystem?

-- Sebastian

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU96ORAAoJENju1/PIO/qaBVAP/2dB4xPgWrpfo5evfDBwll5E
k2yCx7jk89y0/Zyjw5/90nOGAoHdt6L4epvLgw1olhTkzXgZA3pGKnDCdbXfKlvS
xNvj7VHf8xtBeVK1LZCFTGEODmllXBFPLyjVWVVHjyMXEpM4H7d7wtYlr/MRaAYR
IobBzuGH7gpIEXUdnysDN2g8PQRtq8XGUMVyQrjdw3+HcPkSfmrmD4N2FsE7dHh1
1b7niUR18M1X5YkN8buIiaFI6GrDmTmOm3tWc8Px7MjNxa9RzHjXTlPDoxaB+ckJ
M8VcIqYFOEcETRjp1KSFffSozN27cS3HF4TRILvBq2bRJ/MAT2vVYXlIrUio8ZLW
GqStH/U9s3av7WnyXmv8heSfUmQ15dMmMw26cj60vxfFCURedyrEfUnJebpgOOi8
TzGzzf0m5CSOgjZ2EV50MoKLyyA5hwIBiu3AqgcJCkGRkGgdY49o1gcJrVkQ+P7a
cIFuQCQ6TfFFRPiCrflI4ic8X/6I4SBEwrUs9Yrv4b/d4/JWZfS6ZH/oCilFvlrX
LlRJ2orbJWlF5EPGQQdNRz5e5Rs6i5wH24wmr4EALvM0DZ7Nz5q2otQXD2pVvgyC
nLqUGz4E7uKrfUlwOl3NoGdZ76x+eaIyD4JFM8LJnDAjn4yo7T1+12VVfQnMPar4
5Hmx0OT8AdRooYGWLils
=1LoI
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

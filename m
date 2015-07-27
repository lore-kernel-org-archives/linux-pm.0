From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/3] power: clean up bin attribute read/write functions
Date: Mon, 27 Jul 2015 16:43:54 +0200
Message-ID: <20150727144353.GE12993@earth>
References: <1437946009-6743-1-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50028 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbbG0On7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jul 2015 10:43:59 -0400
Content-Disposition: inline
In-Reply-To: <1437946009-6743-1-git-send-email-vz@mleia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 27, 2015 at 12:26:46AM +0300, Vladimir Zapolskiy wrote:
> This change removes a number of redundant checks on bin attribute
> client's side, the same checks are done by sysfs_kf_bin_read() or
> sysfs_kf_bin_write() caller from fs/sysfs/file.c.
>=20
> No functional change, hopefully.

Thanks, queued.

-- Sebastian

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVtkOmAAoJENju1/PIO/qaMTkP/A+H1okdQx+28cWpPCIc2mz7
RW18GrQXIxk1Iu3jen/ISwQxwp1YLWAhmcf5Oed+PabefrIzTvuqRj4R1cvxgTZD
wjJ+o/XJGdQpQnyCqu1NkTquwKv+CeUw8zsHQSYjYDZwwcApwsrk+1j6wl+tUXKG
BqbgyBuR39mFC7I0x8uf4si8TQJp1HIGXwnDYlJWoBLg1umaFzxfNrMCBM6yr+j3
JMFhqHwGiCF6nJyZ84jZLp2UMD0IfsUpb+7MCync+c5ddoiadX3yoTkRyIWoSay7
+11kI6Hrio9TJ4jrrSJMS5RGeI1815VoIiuD0QipXJTxaaJgqGaHz3/tgtUERmzN
537V5AyPLc4XGSWwwKFvsvY71EiDvvuBIgEtcQSYPSzZ9k58IrWSPHiqp4I9ajCt
NIVHq8RLvwkrhwwoN8X3dAZeqa6yM0bIdKjR3GollfNE6UtoguDMA9KAWd1VO51E
jBeNvpQFo9sjyi3o0gxdXiEaU+aauNPWuM/9v+nNUczL4Uo45glJU3SmOODldHPm
4eNhXh79ixKdDTyTwuPXCqFNBD5nylGLqgBzQ8V/HRxSyDDHBzUdkuI/u2UeRAwz
40Cs1WeatwdNqy3Chuyq2MWW08LhnwFkfa9YSn3gk8E0pNID1u25fGQWDCj37avl
OCz4zCJSlJKcVKzhumVE
=n1E0
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--

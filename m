From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 06/35 linux-next] power: constify of_device_id array
Date: Fri, 20 Mar 2015 13:32:32 +0100
Message-ID: <20150320123231.GB7734@earth>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-7-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42719 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbbCTMcy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Mar 2015 08:32:54 -0400
Content-Disposition: inline
In-Reply-To: <1426533469-25458-7-git-send-email-fabf@skynet.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Santosh Shilimkar <ssantosh@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fabian,

On Mon, Mar 16, 2015 at 08:17:12PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>=20
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Thanks, applied:

http://git.infradead.org/battery-2.6.git/commit/8fb0885504cc029bd48877fa89b=
a91c33c0110b5

-- Sebastian

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVDBNfAAoJENju1/PIO/qa/CMP/2XWf2irpbxYrWQ2RBQUizNf
ESf4kzu7e42fUa+2oB8b5ctkRtel939zK59eQ2dSLPZUZXT2lafX6eELij0sRFCG
hy9RClOmZPZ6izFzhmsubNmmPh3CJ9rqhi20lzdZHu3tOxCtMp/1UWL43vKnP+2y
7DfKHK1lcWTzooegpEfxnYv17WRq0AMdsff5cx0k6uNGKs/vTeI6ZYUUaDJLIqqQ
6YrfQruh/HK0bHtMeH5UVlspROOsIZ27JXgdVabOpR2+qamsa1CKnpkFt96XeXsI
te52LFnmDhbLTCdV558Ev4sk7D0Ko6M582sJrzcj7MuiBoGktPHKBLqejZ+dkF2N
KjGXTfibWIF8tI6zWj1lJ83n87BXul86iqEHxEoIg93bnx96IObhpINb0ZmtJI5Y
B7O2mwhfJizjX0iihZHskkGYUhJAygFBJ9geVm1M69t3a42CKUZKCf8KKrzFMed1
8diwxSpfgDlbnyi41dRGMDU8y24Fw1CsrT31RXFDFAGsnIBH32TDqW7v/CuQ8cvV
NjPZI1i7/GZ8uBnCXG5ky/ktCMqHUGnzz1I98hhHjBilwxxDeQ8GNDhoIzLEWXZX
kutSLBEwmcd9pa+SudmfOceLwIng/7KTgkWhlTpG+2g5C4azrB2Nn4ZbRPweCr65
TjvPKVY8dE7CnSdCF9YN
=2FPJ
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--

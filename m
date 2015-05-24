From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v1] power: axp288_charger: axp288 charger driver
Date: Sun, 24 May 2015 21:43:26 +0200
Message-ID: <20150524194325.GE11066@earth>
References: <1430757967-4844-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UnaWdueM1EBWVRzC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54362 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbEXTns (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:43:48 -0400
Content-Disposition: inline
In-Reply-To: <1430757967-4844-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Woodhouse David <david.woodhouse@intel.com>


--UnaWdueM1EBWVRzC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 04, 2015 at 10:16:07PM +0530, Ramakrishna Pallala wrote:
> This patch adds new power supply charger driver support
> for X-Power AXP288 PMIC integrated charger.
>=20
> This driver interfaces with the axp20x mfd driver as a cell
> and listens to extcon cable events for setting up charging.
>=20
> Signed-off-by: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks, queued.

-- Sebastian

--UnaWdueM1EBWVRzC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYindAAoJENju1/PIO/qaLVYQAIS86GLpdwU7jHethZhCFJth
6h0Ax8cowRjsh4AHelyL+ZdEeD1/Ngxo0Kh2mNERI+GF2eGHSjPnkGDn7d7gxKpZ
wKt6Cj2OrAl0fVMObtUGuBEhqmNLkUGpD8AGk/DZOBltvZHHp9Fe2GRxw6GRZGN2
HUuOvz3qLJb8LabCNbycfx8P3HlUgQrpupoGZhEFqPabCzS1QuKBhkeEFa4JayeM
A25bIgNjpM46F/J8MlWuqn1ps7QG9gDGgzcznIyjlObvoG2L8QzooIQ1/UXKzem0
bH4RsUbSOpNGbczPUWe7jQjCC5KMJZUeBmvUygx97ywqsxVmbtmf5n9UxB5bzOnJ
r27EgpKF03PhzslcJBT7PJg1bpWwOenpuHaJSiCsvnJS7F4hv9GD8oeJ1hgaEp9h
kTMBW1w0T0fIv+H9OXu7doZkb8cWoPh0x6IR8QmWJmWXeK9OWUP10aHIhSK2IRKX
vHKamqe2pqxNdppz0mo5iENxYiGN/72E2F6jRxgVP1ihMMuUOn2HK/bTa31nbvT5
Lk6lwOKhX5l7Km/up7kaSh9YM+y9GUNzLm42zTcD916pblAndYagZS+FxtwLFCVD
zBWce2MNzMCQ6Z+huLR1XxZtLDwLobqKPWdlJs13t1SjAwcEQbVTLvMLJELodL0N
9UXNZW+Z4B8qkI8svbRe
=eDIg
-----END PGP SIGNATURE-----

--UnaWdueM1EBWVRzC--

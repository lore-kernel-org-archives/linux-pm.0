From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: Remove unnecessary MODULE_ALIAS() for I2C
 drivers
Date: Tue, 22 Sep 2015 15:15:23 +0200
Message-ID: <20150922131522.GD23334@earth>
References: <1441011120-10203-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33964 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757874AbbIVNP1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 09:15:27 -0400
Content-Disposition: inline
In-Reply-To: <1441011120-10203-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, pali.rohar@gmail.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 31, 2015 at 10:52:00AM +0200, Javier Martinez Canillas wrote:
> These drivers already have an I2C device id table that is used to create
> module aliases and the used MODULE_ALIAS() was either already in the I2C
> table so it was redundant or wasn't a valid I2C id so it was never used.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks, queued for 4.4.

-- Sebastian

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAVRqAAoJENju1/PIO/qaB7AP/3X2nK8AeJezR/5Rd/4NFk5Z
vVRtrZQ38Gmc5hDv6bAtFv+PHn3qqrRLY0da+C12dIklDY9jgiKJcF1hyotju4vG
aHI0UeI0yRFqrzoyqiNqA7lB2PLlGDF6hZNgI/gq1QqMVMG39BWhkpNqheRMCjBx
TG7+bnz3gpHS0ZtT65ZaFHarYIIuIMZ9PED4U1n1okVOsGdwtdrvqGj8mqhSe4M1
TBDOY+8if90SjIvAXSYMMvF8wg+12pKGnGJ+E4kZGrytAcZsLiG8rWVt4K6aasFz
LH+uyu/9HNeh8VDLrAdY9HO8MWJiTGFA/lpL3j5wrYtNodG4Gm5dsWmohIy5a5K6
QVFBzbLNIF1yK0EqWBBRcRQqoUJTNAyd5ltP1RMqlw4bd88eesGU9CPy8K8wDHMa
ax0dxjOXZvg0N3OFPqZfvEtkYiWORiee8hZsXztXP83gM9c75UkCBe/kWJdDS54F
JoOqRc6x9N63n1n3+5s3igVz//OspDBC4TKdn900LyLWaBIINRcgyMG/tMV4plwX
ZkmnLbXelSh++NMNxWhCc/cvLlAByW3Rr+dTPd+w+Wk9qhxuHGYsMI0MH2NtB9ig
KagWB9OVrEbYv8/LYTpwEvmVLPFP+rXpQl14Lx7VZbpS4tLc/DZrNPsxQE8AprC+
/xYdfzh5/SmeTM4FPjLK
=yXPQ
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--

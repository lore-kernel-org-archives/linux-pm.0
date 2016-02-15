From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/3] power: bq24735-charger: chromebook fixes
Date: Mon, 15 Feb 2016 06:58:04 +0100
Message-ID: <20160215055803.GF28626@earth>
References: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44356 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbcBOF6I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Feb 2016 00:58:08 -0500
Content-Disposition: inline
In-Reply-To: <1454479426-6437-1-git-send-email-sctincman@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonathan Tinkham <sctincman@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 02, 2016 at 11:03:43PM -0700, Jonathan Tinkham wrote:
> On Acer Chromebook 13 (CB5-311) this module fails to load if the charger
> is not inserted, and will error when it is removed.
>=20
> These fixes are adapted from Acer's downstream kernel.

Thanks, queued for 4.6.

-- Sebastian

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWwWjrAAoJENju1/PIO/qanXcQAKYaqEnfe7kCttdz4mF1ugTC
1FFkyudrUyHo5tjSVF6s3YA8nQn41adZj7hME1InCKMXgvG8Ada1tqHdtk9L4KVQ
ltH/3AD64Kgro9xqb/N7zChp1L13DRFtmSxnTQjM4wtlgoG0v5zT+qfZ2g8Rrgvl
t6TsBwX9gFa7iKMK8JTJqP8uqP7bMm8yuxEcg5t01yZXv86L1YLXudKVyA8PubbV
uf+S1CM4Tq/MompngtzfTgwm8tEmC1es0mohPeqWYTpC8KzMs0ZN20+10DZpObDT
ngj9LI/2gP3zhst/ztrYbQcjCVMTc5K9/bRSNMi+V8Q63HDJmnmBv4EnxHXu3JST
pJo2EF/SOrXQOuGhbBzi56iTGOYi5wfwe21ZuDfk8PkqjzjxjUBgHIB8/Tkxje1l
n/0miPc6VpfueT4LVe8bnDtp/4v7T5kXHTqwVQ4tn0Cr/albMphHwtOrIeehEOw9
9Zsr/uqY68Ic4dsb+d4CzkmmAYa7eZPANTigHSyub1UXuq7McG+EqgJOiCIAKyaj
IlS7saC6XpRwmdqO533TSe5hJAumHBQDDFElkSXUrExgWHo68EwCuF8VPF+HcGYB
Ey4vkjt3EP6trffWGqIyOGa4z9Mv5wxle6wLVeV63YmgcsCgJiur52+CD1YRzwOY
Whey4hipawZbq2f+v0Vs
=uD/y
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

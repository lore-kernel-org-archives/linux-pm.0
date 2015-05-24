From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Sun, 24 May 2015 21:49:24 +0200
Message-ID: <20150524194923.GK11066@earth>
References: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54898 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbbEXTtq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 24 May 2015 15:49:46 -0400
Content-Disposition: inline
In-Reply-To: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, MyungJoo Ham <myungjoo.ham@samsung.com>


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 24, 2015 at 09:11:58AM +0530, Ramakrishna Pallala wrote:
> This patch adds the support for following battery properties
> to max17042 fuel gauge driver.
>=20
> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
> POWER_SUPPLY_PROP_TEMP_MIN
> POWER_SUPPLY_PROP_TEMP_MAX
> POWER_SUPPLY_PROP_HEALTH

Thanks, queued.

-- Sebastian

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYitDAAoJENju1/PIO/qaMlIP/joFhO3/9r5p+1wCgvblLhOW
mRnUGGyEp//5uLHN9FdbEgU8pQjzxHr8xGpnxa63ItwPx/ho/Opwb63O0CkxadXW
Pl62DGkAAy/OMB+/wsLBf8SKGEyQrqtE6qfWwCbQNRCDvlis0a08DbwdYvHLZ4g9
nsnNcaPIAmkp3RTC4dWH9SFv2Q3EQBkqqhmrNii/gZmlFCZaR6WhrTKnPC2xfgzg
dNSpwmj+QVYkGZeA2SCJOFUWn7qvcUSP/NFlgeMTPQq8ds6Sj6AtRW3EttzX8jG9
sP8TrMa8FrB+w9iOS8lrfYqLQtEyHJL8hyS4U8+8gmEo8w4vUk4UGNDekY+tBrXR
j71sTOWZtc1NMuvPKEdKE2AnM+Cu+Pj6xHgP1IJBZO3tpgenBvs/l4id6Ij5nYGb
UdwD+bYPBCHT0io2rws5atcmKzLVjsZC+I9m/muntin81Nn/B/pOumj6D5slgK1e
rJa5wrFgFrbEq+wpd9qLq8K+CO/ng14zIwAE2VoSiA/QkJQyso40bgA3wB2LO/nP
isRCPSmGkg4DAxUfIQk/1WPFLen3eO4U/UCqishFVdDG35Ww9AHgKnkg32YVTYRl
eDBspencscdo6LBFlRK3hbCUapsxRv4r6eyMfCg0duuuPULVjwef8QqhStXiIyO9
+Sf7wjrX3jX8XHmHk/iA
=knT6
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--

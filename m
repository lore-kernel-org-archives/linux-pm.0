From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 0/7] max8903: Add device tree support and misc fixes
Date: Tue, 28 Jun 2016 20:16:37 +0200
Message-ID: <20160628181636.GA2391@earth>
References: <1464849897-21527-3-git-send-email-chris@lapa.com.au>
 <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50016 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbcF1SQn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 14:16:43 -0400
Content-Disposition: inline
In-Reply-To: <1466735172-13372-1-git-send-email-chris@cpdesign.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Lapa <chris@lapa.com.au>
Cc: k.kozlowski@samsung.com, dwmw2@infradead.org, dbaryshkov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, Jun 24, 2016 at 12:26:05PM +1000, Chris Lapa wrote:
> This patch set adds device tree support for the MAX8903 battery charger.
> It also cleans up logic with dc_valid, dok and dcm pins as well as
> fixing up validity checking of gpios.
>=20
> I verified these patches work on a board I have here, which uses the
> DC power side (not the USB portition) of the MAX8903.

I queued this into my for-next branch, except for the dtsi file,
which I dropped from your first patch. Please submit it separately
to the correct maintainers.

[...]

>  arch/arm/boot/dts/dairytest-servo.dtsi             |  36 ++++

[...]

-- Sebastian

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXcr8AAAoJENju1/PIO/qaOQUP/RMzfEVdrAt5DmDYhz9BxmD6
ZThtqLFqODoeNoH+jccrqHvmJC1Tam6PMe7s1loLkIaKRqVS6KL5rscomgaSYO+c
eVIPw6DjaOF7FUh/BQ07mp9rttY3EYCqNVKkkKhr8BmPJWkFWpA01fUGvf6qH25D
4OIadufKXAJKvVKsMABm1kEcS85SQgyttT47I+dwS2MMNkgh3paa6gzcd2iyc13u
rUApnu9CdTCXsK8EIjI7HBG8lIy/dwZogFTgGy9XbeKGVG2fp6qvPtuO9d3AXa4v
nH2hvUFPgeAOT4uuZOFuqBnZVFY32p1jazCdawtWy86rdwUv+pD5nBd09PsMIfp1
ImluCBAmiIQgKnHF48ABLKlZAZ508XZ9B9BCiiid5Ch/DY1KCYjKJbRUJe9fc6rz
QRSgP4HmwWtkPI5VCS2+VrdIxgoKKgimTV8ZN8pTb27Mt9GqKqcnN4z4J0YH/j2n
6vCy/veyBWUt27WGbeu/j9STrUGV+Jt4abFLgAG3kJ1S4UJRyBhT5aE3tEnGc+ay
WxkSV2viOMCMMZ7U9cN0Zmn9wCMULmvm+9kZsKzS5PA2XsKMLahJ2aW/nx+B+BmO
E14T2RW/X5xE5Y2FOdT7zYStfQVOAlxaflVrcXGypNvXgNnCLU8g37WtajAOefZk
B8+MdTsJAJk1RL0kINOr
=0SUI
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--

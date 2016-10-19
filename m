From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] power: supply: Fix module autoload for some platform
 drivers
Date: Wed, 19 Oct 2016 05:34:05 +0200
Message-ID: <20161019033405.hwhafz437hlphokn@earth>
References: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2zpqg22z2niet42p"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964808AbcJSDeK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Oct 2016 23:34:10 -0400
Content-Disposition: inline
In-Reply-To: <1476731616-23995-1-git-send-email-javier@osg.samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org


--2zpqg22z2niet42p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Mon, Oct 17, 2016 at 04:13:34PM -0300, Javier Martinez Canillas wrote:
> Hello Sebastian,
>=20
> I noticed that module autoload won't be working for some of the power
> supply platform drivers. This patch series contains fixes for these.
>=20
> Best regards,
> Javier
>=20
>=20
> Javier Martinez Canillas (2):
>   power: supply: max8997_charger: Fix module autoload
>   power: supply: axp288_fuel_gauge: Fix module autoload
>=20
>  drivers/power/supply/axp288_fuel_gauge.c | 1 +
>  drivers/power/supply/max8997_charger.c   | 1 +
>  2 files changed, 2 insertions(+)

Thanks, queued.

-- Sebastian

--2zpqg22z2niet42p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBumtAAoJENju1/PIO/qaMhYP+wTOkttlzaYdHYPM4T+499l+
Rp2Z3H8sB95v3uEgi7jPhRd2GeHcctkDPZHaepOk0POwpb90DX4gJKl1+tknI1Kr
VUfmSR3W+WPlPdzrJgjl0YwMIpt6NWizI3XsipJppw9436d9lfgELjQrBhvr3gGY
+6NCXAsPJ9CegeBsyGrE1B0ltnOzRgBzWOV9AzJA3s7CtiNaCgXJSCY0ddNbHBUq
ESOHOglvsCk1V6koaHuW8ClfdRxOAGhlyVk1m9nN/PIuiKpqFXgl4+dzxoJUmjme
h8MW9aiHKyUT8dGr+SvPOVOlZp/i3hASTqVRquFAX6UnvBsVFlRNxQh9jYOdZm/6
mSbXwXC8kvJp23gSGGg9o15PBfq2oY2lhq475xqGEBPofK09v+pnp8sB1+SqHBey
Jp/pTc5FBWxWxNJz0C0sAshDDss1s+5wcEUjx8gTxXQKgSAf2dmZR38xQq0bzDbb
GMywO5d9VJbaa1ozQ4VFSkQtPURS8zD09EMUzTZbh2Pa0EwZk7xWJl078LLfGvtS
nNRmXyu5D1BpbUk6nywZMt4QByJE1ZMHE7rFjXFeEl+ei7cfGpHAiIhlpk2bP05g
PMv+gRPGE2EYred1ao5kDUcwnN8eazOgRMsTt1UJbLVGjrmD5TuYXcXX6nrVpBi5
21WJFmxMVmqMnQGTi5CK
=lhdU
-----END PGP SIGNATURE-----

--2zpqg22z2niet42p--

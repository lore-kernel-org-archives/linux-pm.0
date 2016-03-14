From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 08/12] of: add notes of critical trips for soctherm
Date: Mon, 14 Mar 2016 14:00:28 -0700
Message-ID: <20160314210027.GA4740@localhost.localdomain>
References: <1457665860-30003-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34679 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933307AbcCNVAc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 17:00:32 -0400
Content-Disposition: inline
In-Reply-To: <1457665860-30003-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2016 at 11:11:00AM +0800, Wei Ni wrote:
> The "critical" type trip in thermal zone can be
> set to SOC_THERM hardware, it can trigger shut down
> or reset event from hardware.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/thermal/tegra-soctherm.txt | 12 ++++++=
++++++
>  1 file changed, 12 insertions(+)

I did not see in your patch set an update on the compatible string for
the new chip. Did I miss something?

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5yZoAAoJEMLUO4d9pOJWai0H/R6Y0JRk27MxYqskA3vDAEK+
1NTFtho0UwBw7gvsfxV9tL3Swg6BIjwkRzhKYQfLZyebSTP6JUUQfo8FSXShaqYj
lmg/rEf4PoQ5RLiI4ftDoituwpiAYiUdEM4IHFCMDuaR9gmUqVhZxZhVlhXR/yfW
7eghbGlsE9kyVnPoNrKEci3g5ZIlmw7if02TK7m+6gRqI7FBS3KFZIJ2JACfPmjL
uex/XM2ZlZaPBPOLVEvTYadMH7m78+EHaKnNx563Z0iLG1Ix2rfi6GMj01WQgRic
lKqnysk56g8Z+gthcBi13+Zr7+F75J2ykL08r/cFWeWleYzk+koEecfBNLm5yj0=
=okNX
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

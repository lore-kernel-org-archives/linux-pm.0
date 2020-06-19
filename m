Return-Path: <SRS0=28Z2=AA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C4C433E0
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jun 2020 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A9207E8
	for <linux-pm@archiver.kernel.org>; Fri, 19 Jun 2020 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592585445;
	bh=BfKddbrXxUWPan5CD6khEfR4aoXC3Z+AH6odX3gV2yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WoWAzLy3l6Jw16eGr7x701Ict+zmmjiKj5Hpqwve0REkkBxMygiJJ2Rm29SOKunnh
	 cIK2P3/nx9imWHvKlcGPSQidF5O2Ml+jeKgEVsavjQWndkUadJnNW9wMKNm6G0os+Z
	 u7gMo1dfT9AaMnVcf9mF3gVaCKND9IaIgwV3dMmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405833AbgFSQuf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387450AbgFSOih (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 10:38:37 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82E74208B8;
        Fri, 19 Jun 2020 14:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577517;
        bh=BfKddbrXxUWPan5CD6khEfR4aoXC3Z+AH6odX3gV2yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dENCaHB2ir0r1qUT2gfmdStMdCGpVBzh0+V6hmTvu6hIDzPhfGxyVY7gh10CfWCob
         TT04HPLPl8gY6XAtWE2K6WgxofvEsOHwpH4FErCb4lJJwtn+x6ZtmadPUPWiqW/ULL
         he6J7FOqbt52zRTb2Nm2pEqXgxs/hGQPqEn17UUo=
Received: by earth.universe (Postfix, from userid 1000)
        id DE1073C08CD; Fri, 19 Jun 2020 16:38:35 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:38:35 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: bq25890: Indent example
 with tabs
Message-ID: <20200619143835.unnla3s6zywxcnfj@earth.universe>
References: <20200617102305.14241-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gwlix4ac63ohaldv"
Content-Disposition: inline
In-Reply-To: <20200617102305.14241-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gwlix4ac63ohaldv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 17, 2020 at 12:23:04PM +0200, Krzysztof Kozlowski wrote:
> Fix example indentation to tabs to follow generic Linux coding style.
> This avoids copying the space indentation to DTS when re-using the
> example.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Thanks, queued.

-- Sebastian

>  .../bindings/power/supply/bq25890.txt         | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.txt b=
/Documentation/devicetree/bindings/power/supply/bq25890.txt
> index dc9c8f76e06c..51ecc756521f 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq25890.txt
> +++ b/Documentation/devicetree/bindings/power/supply/bq25890.txt
> @@ -36,17 +36,17 @@ Optional properties:
>  Example:
> =20
>  bq25890 {
> -        compatible =3D "ti,bq25890";
> -        reg =3D <0x6a>;
> +	compatible =3D "ti,bq25890";
> +	reg =3D <0x6a>;
> =20
> -        ti,battery-regulation-voltage =3D <4200000>;
> -        ti,charge-current =3D <1000000>;
> -        ti,termination-current =3D <50000>;
> -        ti,precharge-current =3D <128000>;
> -        ti,minimum-sys-voltage =3D <3600000>;
> -        ti,boost-voltage =3D <5000000>;
> -        ti,boost-max-current =3D <1000000>;
> +	ti,battery-regulation-voltage =3D <4200000>;
> +	ti,charge-current =3D <1000000>;
> +	ti,termination-current =3D <50000>;
> +	ti,precharge-current =3D <128000>;
> +	ti,minimum-sys-voltage =3D <3600000>;
> +	ti,boost-voltage =3D <5000000>;
> +	ti,boost-max-current =3D <1000000>;
> =20
> -        ti,use-ilim-pin;
> -        ti,thermal-regulation-threshold =3D <120>;
> +	ti,use-ilim-pin;
> +	ti,thermal-regulation-threshold =3D <120>;
>  };
> --=20
> 2.17.1
>=20

--gwlix4ac63ohaldv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7szd0ACgkQ2O7X88g7
+prY8A/+NKGwIlBdgJoLJVwpEpRL4Fm1ZhekGETuQf7w5rSZsxwpmabU4ZJBVrOy
AoqQwFOsnSkw0TbXBC4s4NEHXp8fb3T6H6XWC7eoLrKCd1NpxBNj9/ieqZepENow
xOxguyiSiTTpMlYmsdh5fatB6npUzH0U+74nkvtjhYPdceqksKWN2M/6kXChpAXv
SSOvEOgi+uK+w19pZSj4K8vPs0Sb/AelXBWMvnuo8pIx47P/O6B8m1ArNffi6NuL
1T1HOVj7s5vNu9EYFDmy6RlHN+5YcD27fFBVXPlMP4OLmudobty53Ln3laGw/8E4
+ZkWlqwUvTGGLsdM6qr1MlRTW7SQxBSu6HfTgn2QjcApMeJqFy8ZExeZ+QP8rnGe
MhuX+MRjJ4u74Ir0cIzGeYLvyPlpGUqeXxFEhPXNwS2V/5OXltdnU4AUOsb0RvYZ
xQ0tiG+BpDI3meY+oFyMOXepZjQteLEs8LTtJPSK0G0KhxVGjAlj6keQS7FR5wMR
zY9oa4oSlQu5ZEsq4Kce/A+RAEqy0IqhvlNLnemy57Gpsjw+qjOSgav0zyozxnDB
iknGGpw8Ih2gNg7dC8rMaXFf4l20l6MSRw2CLJ1VAi7/yyAHiWAuNTEvax8XafJp
1lIRaEUONMk8uFzvgigI3ifz/RwHM12x1usDvehKrUdkplrsC0c=
=IEDH
-----END PGP SIGNATURE-----

--gwlix4ac63ohaldv--

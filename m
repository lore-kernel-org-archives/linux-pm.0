Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8C26B0A9;
	Thu,  2 Apr 2026 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169583; cv=pass; b=SM92sbz78J6bfXu9UZmn9Ctho5PixHo91+DX2E8oRdkAmsV8NgvRezbAaZA1hQB5BI8G8/Fr0a2P2GGGv0OTtD8mlE40Gco4NmKOVJxoDQTf8az16N6iCOBU2xGBVeL70IjsGx/Bb2rRyW74Hz1c54m1KIX5f3SO65RLCiiJJqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169583; c=relaxed/simple;
	bh=yONASHAOTnbb89sOw1TuOIOenSw1J+BS6vP/6ufNVbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ks82P27BC/SDnH3w8a5y6uzDuj0RDX7e920RY2bgwgNCZ/OjktvIlshGsvMTgPFnz30O0HR8+EoaVxfVcTLNVvNgXjafW9YAiKe6l43oPxQQmQf1+bwOkB8H/TKXnF/ERdo7vHo3qi/Fv9r04zrTnLbOptf9B9kasTGrAL3A4Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=YhfKQMng; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="YhfKQMng"
ARC-Seal: i=1; a=rsa-sha256; t=1775169575; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BLEDn+AVQfO/vqjwLVuJqDZpj3ccy/yhw6QNiPVB4y3v39KSGLgNR+yqnf7cAiqa493omCgAm0u5PAUS2G+ogrZnCz4t+Vy2EBvXtzI0k2LTasEk8OCzbUAWLHcVMIMgtIpsdzq8rTx7h8MHOxFsbEKJ7gSooWaU9KHazcqM3rw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775169575; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hL+3iFjqySM5oirXjBIEaUfC4Ux6xIVYi4bqsf+1Wy0=; 
	b=he3K2uWDLAZzv/rnVy2jb4X8mJkq4rjkET1bVMk3vWBICdC8er5/M8IuVAaKLRlxfqz3UEyuvBMslW8J3MPnh9f5gLMabrcsbOG4LOXhTIVRdlH3NIBc7nJyJ3USk2k+ONTiIe3u8QNZ+dV0N/6v1zyV+BCNOwmzkFfvCIkJ+0g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775169575;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=hL+3iFjqySM5oirXjBIEaUfC4Ux6xIVYi4bqsf+1Wy0=;
	b=YhfKQMng6ktSGfHXjzsbiHgdHLXFJOPey1aCTqTHmiZAQGjfCszuvu0BVNN7SQRt
	1J0NbFrtYTjUSv1PYLCvFUIAdapgL9aoKS1MG3NG8l3Yz1FOJSDB3N/wYLi8hliLaIv
	PwlSEXu4hBSJChsfzJwpnIwkxZ9/Dkc/78fxcnU8=
Received: by mx.zohomail.com with SMTPS id 1775169572758231.28330485668607;
	Thu, 2 Apr 2026 15:39:32 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 071EB1812B4; Fri, 03 Apr 2026 00:39:29 +0200 (CEST)
Date: Fri, 3 Apr 2026 00:39:28 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Amit Sunil Dhamne <amitsd@google.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/3] power: supply: Add PD SPR AVS support to USB type
 enum
Message-ID: <ac7vx4G65sAGzCVX@venus>
References: <20260316150301.3892223-1-badhri@google.com>
 <20260316150301.3892223-3-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z43cmcs6nzlttmzh"
Content-Disposition: inline
In-Reply-To: <20260316150301.3892223-3-badhri@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/275.160.75
X-ZohoMailClient: External


--z43cmcs6nzlttmzh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] power: supply: Add PD SPR AVS support to USB type
 enum
MIME-Version: 1.0

Hi,

On Mon, Mar 16, 2026 at 03:03:00PM +0000, Badhri Jagan Sridharan wrote:
> Add two new members to the power_supply_usb_type to represent the
> USB Power Delivery (PD) Standard Power Range (SPR) Adjustable Voltage
> Supply (AVS) charging types:
>=20
> POWER_SUPPLY_USB_TYPE_PD_SPR_AVS: For devices supporting only the
> PD SPR AVS type.
>=20
> POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS: For devices that support both
> PD Programmable Power Supply (PPS) and PD SPR AVS.
>=20
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---

I'm not too fond of these types, but I guess we already fell into
the rabbit hole when PD_PPS was added. So:

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I guess the patches will be handled via the USB tree.

Greetings,

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 3 ++-
>  drivers/power/supply/power_supply_sysfs.c   | 2 ++
>  include/linux/power_supply.h                | 3 +++
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 4b21d5d23251..32697b926cc8 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -675,7 +675,8 @@ Description:
> =20
>  		Valid values:
>  			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
> -			      "PD_DRP", "PD_PPS", "BrickID"
> +			      "PD_DRP", "PD_PPS", "BrickID", "PD_SPR_AVS",
> +			      "PD_PPS_SPR_AVS"
> =20
>  **Device Specific Properties**
> =20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index dd3a48d72d2b..f30a7b9ccd5e 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -70,6 +70,8 @@ static const char * const POWER_SUPPLY_USB_TYPE_TEXT[] =
=3D {
>  	[POWER_SUPPLY_USB_TYPE_PD]		=3D "PD",
>  	[POWER_SUPPLY_USB_TYPE_PD_DRP]		=3D "PD_DRP",
>  	[POWER_SUPPLY_USB_TYPE_PD_PPS]		=3D "PD_PPS",
> +	[POWER_SUPPLY_USB_TYPE_PD_SPR_AVS]	=3D "PD_SPR_AVS",
> +	[POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS]	=3D "PD_PPS_SPR_AVS",
>  	[POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID]	=3D "BrickID",
>  };
> =20
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 360ffdf272da..7a5e4c3242a0 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -210,6 +210,9 @@ enum power_supply_usb_type {
>  	POWER_SUPPLY_USB_TYPE_PD,		/* Power Delivery Port */
>  	POWER_SUPPLY_USB_TYPE_PD_DRP,		/* PD Dual Role Port */
>  	POWER_SUPPLY_USB_TYPE_PD_PPS,		/* PD Programmable Power Supply */
> +	/* PD Standard Power Range Adjustable Voltage Supply */
> +	POWER_SUPPLY_USB_TYPE_PD_SPR_AVS,
> +	POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS,	/* Supports both PD PPS + SPR AVS=
 */
>  	POWER_SUPPLY_USB_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
> --=20
> 2.53.0.851.ga537e3e6e9-goog
>=20

--z43cmcs6nzlttmzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmnO8BwACgkQ2O7X88g7
+pqZ2Q//YyHHHjDHeT4KYMNqWXNcjlqeCHLXsZvFN72tgwCnb6zOW333MkFIGC1S
fkE1a1BJdYUnijQpMWxwJC3Up3aXmoJIeXEEY2TAZUitjxn/0IiSQMvgFIXBq3lk
UZbuYjgN1MtJPd2i4lFlZiZLXbnVk+ywvcnwDVO5pi/YPb0KdcaomvNm5+ctl6Xj
LJrlhD1+GADKewOttCDDnBJUvGwdjl430twM9HqeD8DoDHXMaQ9nJhiB7Ez48+sx
/ZWFYWeyIHgBja/r6XDqImg+T6aBRr3kbcstZJwTlWI7yi06xafqswjnCit+5ofj
AsC44B8AqO1ss/jO25p9OUHDIMKnhf+SL6iPn9fN6LawG0MCMbvNvoDmfxc2VpoE
lDAhg/ddim0hHGKmlXaphyL/S+9ONfXvhX+wyGMsoj19MdlUlx/N4SNvcP6kCQwO
0XNQb3z6JeguHfnTLJtXiAIRjKf9n3iHSipbDKW/Vh1inKU4w1DsT93wQvLJ8yYg
qSzLPaMvnbHJa0ZR690kla/ZPUJHqwJmd1DMTjZ3WqGmiPLyrm+JDzR0KoOlPDu1
MDbjf5byaIWtfbCGqgB1L6BM9rBjBE/wFdrs8dJg5PVdlINiGgsa3jR80zhp30oE
yLkUBzohdmw7FT70L/ZY2P9PIVEk3DO/PDEArq0efq3Kf+enfGk=
=wWjN
-----END PGP SIGNATURE-----

--z43cmcs6nzlttmzh--

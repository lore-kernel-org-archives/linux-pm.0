Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D224749DA;
	Sun,  4 Oct 2026 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136254; cv=pass; b=MUH7O8IAWaGnfUtFMiiY1BAp1e/OZKzuUyLOR6vdIZlmlva3uNS/mdngpdiR6A4FvB/jpqAl+113LoARMUui/hfT2BphVQKclJGLQENsR+4F/hSoi/fEFOmxKJHXQUXhKAbHrgSbFlQVVXSRRMGO1z2aq+CghmfoUSDvD45v7OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136254; c=relaxed/simple;
	bh=KE6O+ic6eQ3gGXAznmy34UvAcD2loTOqhjV5tcfcjLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvtKCUCzdY6Zpk8ux9ZxqGxLyOtILfn7gLHn4cNjfF31OLl9jnAybr2qoiV6ZAL2RPq3LW18riFvB+G6U1NWAfnD93BBqmSu4s/07YX70etnn5o0lfRLCcL05EJt+1eWf93qdunDD/EBrc+ozh9ujeJWEfDeB/JPVD+D02v3ruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=PZVGUumq; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="PZVGUumq"
ARC-Seal: i=1; a=rsa-sha256; t=1791136246; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YgIAXfjrb/enojAX/VTnIA3m/J7MH36DQS/X8l1SIDnch8GPvdAqG+b9JjCgSn+Bnl2emy5O6QuoBiE9hZ/ck13qjBouN1g8AnshgUj3diLxxcefYE+fWRgQ3xYvuAfo3sHf/fimPdhI30J2hnG03fnmTD99qo5iqRjP9y0q2zI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791136246; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iDVonFSpj1dP80g+XOnh0LxCDjeikvL0J8bFJ78/Tc4=; 
	b=YIMfoWrRV/cgaf+HXExHpwjC2YpCY3i0Q4YDQPeU/xjSCdIIco0BlBvePgCZLipERCIRhGzOlDeM7ll8gadua5+FNI1x4/qGkeHL+hx5RS0X8lLJWv3afl1sQWoCcwyuqXKRymZaCL2CCsIGRKYcOP0XNcMc64OfnY+Dley7r+0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791136246;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=iDVonFSpj1dP80g+XOnh0LxCDjeikvL0J8bFJ78/Tc4=;
	b=PZVGUumqEzWBEeXdOunT94vTLbj2noUC8E6ZcG+I9kkbS1jcT0LszL9moFLL0mFy
	C5bw0KOPc4IsjP4hZh02uaPcXDuhq7vdvuWJ5c11rXRmJ20RyFG7YXvLT8p+7bN4IIS
	XvYCJ2j5ezEWxnJpwz8OMBZfpEFlmSlkBBu8jsl8=
Received: by smtp.zohomail.com with SMTPS id 1791136245115194.43775553913508;
	Sun, 4 Oct 2026 10:50:45 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id CFF77180A51; Sun, 04 Oct 2026 19:50:40 +0200 (CEST)
Date: Sun, 4 Oct 2026 19:50:40 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: =?utf-8?B?SXbDoW4=?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 4/5] docs: ABI: complete power_supply type valid values
Message-ID: <asKRNfzLdbpP_uYY@venus>
References: <20260831155339.181487-1-ivanrwcm25@gmail.com>
 <20260831155339.181487-5-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q235cgcbujrqaark"
Content-Disposition: inline
In-Reply-To: <20260831155339.181487-5-ivanrwcm25@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.133.86
X-ZohoMailClient: External


--q235cgcbujrqaark
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/5] docs: ABI: complete power_supply type valid values
MIME-Version: 1.0

Hi,

On Mon, Aug 31, 2026 at 12:53:38PM -0300, Iv=E1n Ezequiel Rodriguez wrote:
> sysfs type already exposes USB_DCP/CDP/ACA, USB_C, USB_PD,
> USB_PD_DRP, BrickID and Unknown via POWER_SUPPLY_TYPE_TEXT[]. Update
> the ABI document so Valid values match the implementation.
>=20
> Signed-off-by: Iv=E1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-class-power | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/=
ABI/testing/sysfs-class-power
> index 5641f1fd5fd6..08afb75973d2 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -34,7 +34,9 @@ Description:
>  		Describes the main type of the supply.
> =20
>  		Access: Read
> -		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
> +		Valid values: "Unknown", "Battery", "UPS", "Mains", "USB",
> +		"USB_DCP", "USB_CDP", "USB_ACA", "USB_C", "USB_PD",
> +		"USB_PD_DRP", "BrickID", "Wireless"

The USB sub-types should have a marking, that they are deprecated in
favour of using just "USB" and additionally exposing USB_TYPE. There
is only a small amount of legacy drivers still using the subtypes
directly.

Greetings,

-- Sebastian

--q235cgcbujrqaark
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrCkewACgkQ2O7X88g7
+ppGWhAAhpj84EYzKgOaaTSLjS8H4Ka9zipsJqULMw/Y25/HuY/4a5vUO/uciB6Y
A76feGtWcrDl1ZZGhRCqAINhByY0Lzw3ebe1BfUImysLSDZMD+yIhbSeNVrmC7H7
fteuwRJcI1j5L7TCgCHmPnXMPPxMvYANAE0GMIBgSDxPnwCS02nL9UvovKllNAcT
gpGeuZ0HIE+KL+Nqtk9hC/ngtA0/k6xXIhW+rUhGJkVLV/9aSSkAy4r7arJam2NW
iCPVKOdVn+er+/Vj1kUV+eRbctsfH/NOcn5dO2x96Yj5fQLfRcJSIQF2EnmZ3HA5
a8bksvH/2flDaBDguhmS3R/pcxHFw16aXlwwJPtAx9+jVUizWZpvYkaa1RTQ6fz3
sViYHLSPeK27iN1jiHoqY/rOYUGCyUiC29J7Xp9N0gGKVacXoPfbX1pb67O+KYqy
uWJcFAbWjD3tM3SgyMyk90kUGqoOd4gsQwKcykcMyvS/DfmkaPPHQ8NC2uuTwxDR
sr7RsyCcrbFdyUl+aworcjtBell5goW0aIxuQjzlSFKCnGqwca6C1CjbbtibNaPb
zTascJIFl0UQVpNimikVmrlNVNc17/7ez9xIT3ZjJ/ItJAmjrdeRc0zgCHGnjvis
NNeq92ObRTvnBYq534gzFpM2HkcVMCtmjt2cu/YDyK+lc+UL30w=
=zwdO
-----END PGP SIGNATURE-----

--q235cgcbujrqaark--

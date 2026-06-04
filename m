Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699F3C9896;
	Thu,  4 Jun 2026 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594626; cv=pass; b=QWR2ER03h/UoYKeShUW1wCcbe3Fbs4Zc85Ho0iSszcTLTRVfMxGOiOtM8S80tB3AUt/DE295paKi7jL9zOdJYB4rno/ozWwy0i+zCyOzGyfqWAD41XYC5c1ywoPNC4F06pl6Bmqenvcv00PsCkWj5fLRFH7FkkQDuN+Cdy73PZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594626; c=relaxed/simple;
	bh=YtimujmjF5DOPj1+e+6hWv0Y61K1O0J+znVkXe5pno8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdguq7JQA1E2wIchDvzsFbFDH2P3r3zsM3iWf3mDE8EgbMTmxws7ObLNqd3a6unQutVxZVz0PIVG1lDTAcizhJd0zicQLmGpnfyvi3xq+7P2vwBFNV/JNXyoPCmHiCg5JIqwqlGSw/wHtfyKGhuaLYZndoAk5e0njFLd7OATE9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=HgrrrxoU; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="HgrrrxoU"
ARC-Seal: i=1; a=rsa-sha256; t=1780594607; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dzjbXh15qG/M2FqsKgqy8OwNFM255RwMMmXHmVV0xS3KW9+zDM1fdmh6YANbv47QD9G9Tfz9uhh0CX1SS5Sy6uEGhdlzGXgY525+6rbPnt5pdOvACVKA1Ug8RIeNNJ5s1xhxogizx4ufrBWl44Pw+t2juess1HnpwG66cnFTkaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780594607; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m4ya3KC5zO30MFYkbOaNMeGYSDnkSBv5P5+wbhq6hIQ=; 
	b=bYlqSRDszIPKM350/FkFxiiY5rKoxv2V5JAKLUuH+Kjy/rUWNM0OVqOTAG0IuOUg58aL0s+ZxbrYIkOQSOj0iu5d/olFUm4RGx+q1JiN3+7netkj8S6jw3bE+xTa+T65mQbQeoGEarbsnEyo0WqK8XBG6JC3st2kjd0zEhGDqLs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780594607;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=m4ya3KC5zO30MFYkbOaNMeGYSDnkSBv5P5+wbhq6hIQ=;
	b=HgrrrxoUKIzWFU+WFy8RBsIWB1Qy5CwIhGXNqIWQ/eV+r4LxPgXBpH9O3cbpbu3v
	en4bNwCoG17LHbzteNcgw+M+iIYLiuXZ08/VcwLpteDnkF0NXih4PLRM/KKVNZMp8gq
	oJZooE1ChZnrdRlBV02F30mEgG1jwfa+f+7+D4bU=
Received: by mx.zohomail.com with SMTPS id 1780594606000782.1812336506821;
	Thu, 4 Jun 2026 10:36:46 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id ADCBF181D80; Thu, 04 Jun 2026 19:36:41 +0200 (CEST)
Date: Thu, 4 Jun 2026 19:36:41 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: amitsd@google.com
Cc: Badhri Jagan Sridharan <badhri@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, 
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 0/2] Add support for Battery Status AMS
Message-ID: <aiG1aJY7VURSJOZ2@venus>
References: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="trq3tzyl3ngijhjc"
Content-Disposition: inline
In-Reply-To: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.581.16
X-ZohoMailClient: External


--trq3tzyl3ngijhjc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 0/2] Add support for Battery Status AMS
MIME-Version: 1.0

Hi,

On Tue, Jun 02, 2026 at 10:47:05PM +0000, Amit Sunil Dhamne via B4 Relay wr=
ote:
> PD 3.1 v1.8 Spec necessitates a response to Get_Battery_Status request
> from the port partner (see "6.13.2 Applicability of Data Message").
> This patchset adds support to get all the battery type power supplies
> and query them to report the telemetry required to build a Battery
> Status Message. Right now, this submission assumes all the battery type
> power supplies that exist in the system are fixed (meaning cannot be hot
> swapped).
>=20
> Previously, I had sent a patch series [1]. However there were some
> concerns. Broadly:
>   * No client drivers
>   * Duplicating dt properties
> To address the above issues, we now have Fuel Gauge and Charger drivers.
> Also, I have rectified my approach to fetch information about batteries
> from the power supply core.
>=20
> While, the original patch series [1] added support for Battery Caps as
> well, this patch series only adds support for Battery Status. Therefore,
> I am sending it as a new series while incorporating relevant feedback.
>=20
> [1] https://lore.kernel.org/all/20250507-batt_ops-v2-0-8d06130bffe6@googl=
e.com/
>=20
> Patches in series:
> [A] "power: supply: Add helpers to get and put arrays of power supply han=
dles"
> [B] "usb: typec: tcpm: Add support for Battery Status response message"
>=20
> Technical dependency of patches:
> [B] depends on [A] due to usage of `power_supply_get_battery_all` &
> `power_supply_put_battery_all` APIs.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---

I think you want to filter on batteries that are
POWER_SUPPLY_SCOPE_SYSTEM? Otherwise this would also give you
battery devices for something like a cordless mouse.

You mention that this is assuming batteries to be always present,
but handle POWER_SUPPLY_PROP_PRESENT. So basically a battery, which
has POWER_SUPPLY_PROP_PRESENT=3D0 would violate the PD spec as Fixed
Batteries are not supposed to have this unset?

Not sure if this is fixable, but you implicitly rely on the battery
driver to be probed before TCPM reaches this.

Greetings,

-- Sebastian

--trq3tzyl3ngijhjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmoht6EACgkQ2O7X88g7
+prLiA/+KtDenZG++fF9L4HbEcOEoDClv2JeZicRohAUVd1sYH+lil590L1VMyDo
MzP0Ar4CIN0X47gUq3Fx5YJaLDz7LH8IvuKdCccW9KbmkTFeACHFlEg7MSjZlrhv
imPW5+9TjOVnu+NcpBENobaCx5k8ZcrqVcpz0S7dYjYvGItGCzradMrhTvpHnfyu
AXnfODB4exxL2/aWDELoHnvwLQpXyTVhsXijZHDlDNTomoZPBWmgTy4uBBfRTcZS
81BNJbK9H6USDs9LI/I15nKsXkbDbBpK7shmVvcfPluGiXXXHbULFQsN5QPIkvm2
8O6elDerFQOawjFBUO0e+eA3Rmz/uQ9C1KeasfbX3j4yNxRKdaANk/Xu2LXMtH+T
8djTAhcusyRGMOAzMnsOoxC5WuYNjE7h9v7CyOdwVFcYIadpvnIeLZt7Hf5LySnu
wx7s47seEHpomKhX/Ftuy0GuTjzrpjTZU8ydIpj7sfW42Ty0dLHMAuCAF9RWgFai
GVVBcpq4PDFN6JRpOix/6901jjd/xDyUgvGP49BuV2GmCjRq4M4sFvdXnQeMQjrR
A/R5S5MlzMYgC+hYvvGtOYzK0IrFSIKOFfOBTmIUFprJboa75QuqAh/XuNNhQnxn
9xHY5EaS8jMV0nS0aTg3RkSWT+we8a3pLCFEpzziW3nMffgann0=
=chtd
-----END PGP SIGNATURE-----

--trq3tzyl3ngijhjc--

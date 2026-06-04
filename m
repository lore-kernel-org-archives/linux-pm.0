Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0931547C0;
	Thu,  4 Jun 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780591183; cv=pass; b=HZd1RA0IExoMKkvsevEUmwaIfDjN0PtFi3vWOVB7gFQHQucdeQSzkLr0VRW8NPAZHzILmUsz6jXvGogMKp65rIBbUtdTK9hpGu1Ato1son4Orub5+NJ54oSdw6OVtPLAttdNNcAHO8E5jldhsi4NXDi9AsBGmd48GUEiFUCFvOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780591183; c=relaxed/simple;
	bh=IRmE3eY2MEBFJg7IBdlFlsnQfEgCgR5UqZTf25QOwx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5c0EgWXCu+dToa15Y0NCUmcrT+/t/7wpNlrZS2gtcChC7QjTKGj9+GUQuqWpBEG1d2kwBMjdtMhrrxgfWL9MPQVOobwhIk6lrdO6hfz7wp9F3hWBiJIgUKqBbNOtmsR/eXRKXwgt2geZlsA7ecHHfvjVJ+kOOt1XAVButGemBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=bxC/8isG; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bxC/8isG"
ARC-Seal: i=1; a=rsa-sha256; t=1780591164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FcUJlJ/DTfBp4hkQwmuFWZAyrtDC4EA13iYjhpOdSvWzXvr25k86ZsrWeUx/uDBAJKzD599YfSjhQ9yu8xPz0VrmilIyZGrqwWN4gDQixBoTqhxS2jvJAComldRLvolVjMYnEexMzHnlo1f86s64BgHuekH18NzK4cdoysOY2DM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780591164; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5ckcWefkVhHi1iXL41Jhysnfy8JhjMusBGeBhoPhgHA=; 
	b=HI9u5yUNREmwqHznEQ5bKbWr+80x6KH3F6vRHUNtD1sGjSYb4wPoXt0wqJcabjYidbZly76T4lzEZrpPadbHGrNALWaOpZFr+D4dReS+faCbmc/0OpdQzxu7Hc4I+iAXlI49lndRLBPy1vkdFkzU/4x8vQ+rBDNIuYH97wOjYUc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780591163;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5ckcWefkVhHi1iXL41Jhysnfy8JhjMusBGeBhoPhgHA=;
	b=bxC/8isGMHLiHQViSLdy7iHwsc2AfrIpZ6S9tUkMczAopPEC9KQ45vF3ZF9Qu17B
	tlKqfhJ6Ebi+JEBW20kdbex4TrZC2SrhLr92RGH4eCsOxSZ//BbTyZCSDhkRDFIVBxM
	QPi4bBeeJ2F9K9YEVdtszrBG9XX/A83nN7A5jMzk=
Received: by mx.zohomail.com with SMTPS id 1780591161253801.0874003515125;
	Thu, 4 Jun 2026 09:39:21 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 65BD3181D80; Thu, 04 Jun 2026 18:39:18 +0200 (CEST)
Date: Thu, 4 Jun 2026 18:39:18 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Vincent Cloutier <vincent.cloutier@icloud.com>
Cc: Hans de Goede <hansg@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vincent Cloutier <vincent@cloutier.co>
Subject: Re: [PATCH v1 0/9] power: supply: max17042_battery: improve MAX17055
 support
Message-ID: <aiGp30oIyDo04qtq@venus>
References: <20260406205759.493288-1-vincent.cloutier@icloud.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="orhcyzfxle47u4o2"
Content-Disposition: inline
In-Reply-To: <20260406205759.493288-1-vincent.cloutier@icloud.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.581.16
X-ZohoMailClient: External


--orhcyzfxle47u4o2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/9] power: supply: max17042_battery: improve MAX17055
 support
MIME-Version: 1.0

Hi,

On Mon, Apr 06, 2026 at 04:57:48PM -0400, Vincent Cloutier wrote:
> From: Vincent Cloutier <vincent@cloutier.co>
>=20
> This series refreshes the Librem 5 MAX17055 fuel-gauge work for upstream
> on top of current `mainline/master`.
>=20
> Original series:
> https://lore.kernel.org/lkml/20220318001048.20922-1-sebastian.krzyszkowia=
k@puri.sm/
>=20
> Compared to the earlier posted version, the main follow-up changes are:
>=20
> - keep the original arithmetic form of the fractional `MAX17042_*_LSB`
>   expressions while still moving the unit conversions into shared defines
> - remove the unused board-file style platform-data wrapper from the driver
> - factor the `monitored-battery` parser behind a generic
>   `devm_power_supply_get_battery_info()` helper so MAX17042 can read DT
>   battery data before registration
> - keep `voltage-max-design-microvolt` as an explicit MAX17055
>   `ModelCfg.VChg` setting so batteries at or below 4.25 V clear the
>   default bit
>=20
> The attribution split is intentional:
>=20
> - patches 1, 2, and 7 preserve the original signed Purism downstream work
>   from Sebastian Krzyszkowiak
> - the remaining patches are cleanups and follow-ups on top of current
>   mainline code
>=20
> Tested on Librem 5.
>=20
> Sebastian Krzyszkowiak (3):
>   power: supply: max17042_battery: Put LSB units into defines
>   power: supply: max17042_battery: Use Current register in get_status
>   power: supply: max17042_battery: use ModelCfg refresh on max17055
>=20
> Vincent Cloutier (6):
>   power: supply: max17042_battery: Use dev_err_probe for power supply
>     registration
>   power: supply: max17042_battery: Route MAX17055 SOC alerts through
>     dSOCi
>   power: supply: max17042_battery: Keep only critical alerts during
>     suspend
>   power: supply: max17042_battery: Remove unused platform-data plumbing
>   power: supply: Read MAX17042 battery info before registration
>   power: supply: max17042_battery: Treat MAX17055 VChg as explicit DT
>     setting
>=20
>  drivers/power/supply/max17042_battery.c  | 428 ++++++++++++++---------
>  drivers/power/supply/power_supply_core.c | 188 ++++++----
>  include/linux/power/max17042_battery.h   |  33 +-
>  include/linux/power_supply.h             |  10 +
>  4 files changed, 393 insertions(+), 266 deletions(-)

I merged patches 1-7.

Greetings,

-- Sebastian

--orhcyzfxle47u4o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmohqjYACgkQ2O7X88g7
+pr0qxAAoHmLQi3rHnkV7JQgcsBOQkQkPfnCJF9T+D6TRvqoWANasjrOYdCgvJP6
x2ERJydzyNHK/CGewlgGAE45zbctUCGv3V/mWWBNUZQ6xMKP6grDVpPjiiA1kik1
v7aWOEYjpvPlbnIC3cTIzj6IWGGDTthmMQtOYlemXaOlHk6ymzzS7fGKb7S64blO
FwKRKir3l2dEvkz7uCcyWVe4/jeXXpAglfYINMUhf3+5OXB8waU0Ll65JQDOhafp
0UQ9dj5hdXoRtheuSE/azTKnD+t36vnFOfLQdEoLNDIphbej1NF+TQS7ZmgNwrin
Yi6Gne/2vbb9icPo+9PunmFQyLA9It4+wusNpue0a2i9Cg1zWD8ZNT5NwHRQE7Fc
DCniGugFQiplclb6mL6MmipFftLTzN6YRY3Bsk+5Vh+MtACXkvG1Y3m9MRGJGzLH
AgOksGSbAb0Xket+MgC0XfC8W7MBDLRrjZTTG/AMrwECTmnyjkFeEW3XuV0HdtYE
XD4j8CZdT0tUujVotR26GIEzoPcfm9Nrdz5u6dbBkl/ZS+ELeEbVauzjzV7fVkFN
I4CLLRC3wQ2KpKklAr0EKh7Jw46MdwmDNjPiBzkXhSyZtpAo8Mf2zkgVDmC+8VLC
/trUY2PW3IlymsF6PiWzbtDuJKWyKSqvHbAOCTIZnZBs5JM+PCY=
=2O0K
-----END PGP SIGNATURE-----

--orhcyzfxle47u4o2--

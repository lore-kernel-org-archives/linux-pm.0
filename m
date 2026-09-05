Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8CF36A35C;
	Sat,  5 Sep 2026 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788630373; cv=pass; b=ODd0V3N0m1gGp2grFEqRkLUvHZeyzu+/Q+vDWsqezSzXYXGLlTZCvGZF/Be2PB6VS+l4hxARdqS1YOaLSUV9opFiNUgX8ty9OH2P7lM2c9ItkcwGnEy8Qq0FWzpmwOog+BnWMBCTqJynpWvLsZWUINZZ1bNhGLu+lF5lhSlzjp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788630373; c=relaxed/simple;
	bh=5uhz3zPKmg7MeOTZph5AS8lS+MnWzydKmQm8fqk+qSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOrMb3AdOi9CztAYg9Xg6Se6GgS22FMToLCRcDZias0VLEzLotMgKfdiUpCAtTqDzYv3ye9BJURAj54G+hgC0D/i6fJuX+dkyrfXWa+Hani8js5xsqk+7mC0QOQRgBtwK81qHufXVMP1XvChzPduYJVbSc/Hn4ahybHDaLuQtmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Hi6nG0S9; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Hi6nG0S9"
ARC-Seal: i=1; a=rsa-sha256; t=1788630367; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GrOk6ZfbYtAj7/EB6W+Y75LBRByVBwxzY8RgWZ753Amu9RA0jdMEleofY9feLBPjDMatWLwszPvvFUy+waheNdwhThE00G7RyT5PkKEKAUHfKtbtZKi0sj8z/4ERIiKyMgpZp2yIva/zxp2DWh8f5kAnzkJJBeqCY5mZPgqaV8o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788630367; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QE5R5fAoLrk8JJJFLNeZLS3DgtOBX690cH1EOVQ1MMU=; 
	b=XIvBt20He3faBzh8TpNlH0MDB19H/fq+n2rU2sg+jOAGCRKIuGu3R0cu43/drh0E5ZQO+0E+HeL6AWd1pfCQ7MNIXsO2OWqe7HVv7km48OUWGFyqni8kKPUX8T9WLzcO35hYf+4+DIgcmQVCFx+z+UMM80fn40QqBjPS71sRfzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788630367;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=QE5R5fAoLrk8JJJFLNeZLS3DgtOBX690cH1EOVQ1MMU=;
	b=Hi6nG0S9X91BVYe/auAvwBAKnB6XWOJ80yeYuFrFxidBvuo7OORNLAgq0o9MQSzd
	TXv+Bhd3pGZoGAf3coO54ilrFT9Wxj3ppY2X4UTwOQkfayqt+5SE2Pxx70vZ9M8jgbe
	tZ9spmiaDcsvnMxEpMqvrSCUw4SR3iqxg9+5ABbI=
Received: by mx.zohomail.com with SMTPS id 17886303659001018.1388607569507;
	Sat, 5 Sep 2026 10:46:05 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 768E3180921; Sat, 05 Sep 2026 19:46:01 +0200 (CEST)
Date: Sat, 5 Sep 2026 19:46:01 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Itay Shem-tov <itayst@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: SBS: report relative state of charge as CAPACITY
Message-ID: <apxVEvGoao0iVGlh@venus>
References: <20260903104244.25556-1-itayst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrvelqnztqiomtnt"
Content-Disposition: inline
In-Reply-To: <20260903104244.25556-1-itayst@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/288.604.18
X-ZohoMailClient: External


--lrvelqnztqiomtnt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] ACPI: SBS: report relative state of charge as CAPACITY
MIME-Version: 1.0

Hi,

On Thu, Sep 03, 2026 at 01:42:44PM +0300, Itay Shem-tov wrote:
> acpi_sbs reads SBS command 0x0e (AbsoluteStateOfCharge) into
> battery->state_of_charge, which is exported unmodified as
> POWER_SUPPLY_PROP_CAPACITY.
>=20
> Per the Smart Battery Data Specification 1.1, 0x0e is expressed as a
> percentage of DesignCapacity and is explicitly permitted to exceed 100%.
> Documentation/ABI/testing/sysfs-class-power specifies the capacity
> attribute as "Valid values: 0 - 100 (percent)", so any pack whose
> FullChargeCapacity exceeds its DesignCapacity - the normal state of a
> new or recently replaced battery - makes the driver report out of range.
>=20
> The correct source is 0x0d (RelativeStateOfCharge), a percentage of
> FullChargeCapacity, which the specification bounds to 0..100.
>=20
> This is the same defect that was fixed in the i2c SBS driver by commit
> b1f092f6480e ("sbs-battery.c: Capacity attr =3D remaining relative
> capacity"), whose reasoning applies verbatim here; drivers/acpi/sbs.c was
> not updated at the time. drivers/power/supply/sbs-battery.c has used 0x0d
> since, so the two SBS drivers currently disagree about what CAPACITY
> means.
>=20
> Observed on a MacBookPro11,1 with an SMP/bq20z451 pack
> (FullChargeCapacity 6775 mAh, DesignCapacity 6400 mAh). Both registers
> read back-to-back from the pack at a full charge:
>=20
>   0x0d RelativeStateOfCharge =3D 100 %
>   0x0e AbsoluteStateOfCharge =3D 106 %
>=20
> /sys/class/power_supply/BAT0/capacity reported 106 while upower, which
> computes charge_now/charge_full itself rather than trusting the driver,
> reported 100.
>=20
> battery->state_of_charge has no other consumer, so no other property
> changes behaviour.
>=20
> Signed-off-by: Itay Shem-tov <itayst@gmail.com>
> ---

That also matches the sbs-battery driver (drivers/power/supply/sbs-battery.=
c):

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/acpi/sbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
> index 86b7c79..862cb94 100644
> --- a/drivers/acpi/sbs.c
> +++ b/drivers/acpi/sbs.c
> @@ -318,7 +318,7 @@ static struct acpi_battery_reader state_readers[] =3D=
 {
>  	{0x0a, SMBUS_READ_WORD, offsetof(struct acpi_battery, rate_now)},
>  	{0x0b, SMBUS_READ_WORD, offsetof(struct acpi_battery, rate_avg)},
>  	{0x0f, SMBUS_READ_WORD, offsetof(struct acpi_battery, capacity_now)},
> -	{0x0e, SMBUS_READ_WORD, offsetof(struct acpi_battery, state_of_charge)},
> +	{0x0d, SMBUS_READ_WORD, offsetof(struct acpi_battery, state_of_charge)},
>  	{0x16, SMBUS_READ_WORD, offsetof(struct acpi_battery, state)},
>  };
>=20
> --
> 2.51.0

--lrvelqnztqiomtnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmqcVVYACgkQ2O7X88g7
+po7RhAAoruDVvUNPtdJ8J6J7bWwFbFbrg4zuKPkMAvO/XjqaoQmP6pvdMA9dq4p
Bfdj2b+sjjAlr+Htezih6bIJ9+M4BTk20ZXoKeslqoFgmwAMqPJbSRsbV+mHE/Tg
E4HSeLlsgTmaA5d4rZ6+3B94c6As78+vpuR2a3VC2ZO9cVjknV/20DX+ebqZgEpe
QDI1acFzap6OIt0TIMs7T2VbAcdja307jZWYqZV4gkpnnVnFV1qDqHkAJsqdoeXr
+pVwhLFJlTGIZvE5YycsLDyrdilN9dvwlkensP5hp5i/zMvnMM+tbpVMyYndi6Ge
krCh5jZQLm0H4dUGDBMk5f399N8zQgLMqvgjineH+CYWELrzpJYRTf5HYx3JySEg
b7xp4iX4lXETbWQyru4yrXA2+9pl6BCLXtT5aqr1KyW632B5YFVnph5sEvzlJ00a
KhpoRtLNqR8Nsu4yAfe+n2c0/XNkBcxlzJbQ+agdh8FAgsemhGDRcNoY1jog9zAb
W2Lfh6pTFjVBK797DPgC9qVWu8yWXDkqfV8XJoD1qFSKV/p0/ya2Via8LG/IK5c+
7SUagftME2jOY7ZAxiqiRpWHYb9nxNrxRFKuCtjHOqV8ZWAcA/6TodGYBjjphmvm
3KGqMP/fbHBx318n9vudHN0H4hnAixPHe8Tpuw9EeHCDf4EzYO0=
=amjn
-----END PGP SIGNATURE-----

--lrvelqnztqiomtnt--

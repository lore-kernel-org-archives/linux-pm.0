Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794182903;
	b=5CCBRv1T+dIDDt2j5jqLUNJntDXdtA4UsTSZabIq8uCpM5V3ljLYurnzMX2Jx4CAG8RO
	 g9FQGCeECNj5uszmWwBSVJbg3gRS4KwIspc7B1e0M9Wg8ZT2mrKOswusowGbK4mRINawm
	 +NRs8GWh7WCqWUKIcaiIa5OSbvKZ/Jdf/1GT93yd8AeOTWIXXY5v48jitEzQ4XW1T4n9U
	 0Ibz9OotkjNBYX61PbnDav6rBZLGZH0YkhoUHwgV691DMJZIlsYsah8/P01SPO/Un7wgW
	 6KBcO9TQh8Ew/H79yaVgqnH9kssZz1aTxi+IC0sIpcwMYpN2iP3lp6vl4bg6KqEtMlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182903;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=9rVwbOecFjn75cDjqDTfDsnAfqPeatJDytpCsuFTOOw=;
	b=Y2sHLa1SfF2moKvf9DC2uHw0HPwoKwuVgtKxfXZ8RiE+AYnbZtSPpMgZ9gDjCqaEFrzx
	 L5T2+SydLRSdhHEVCA1QFM5JYOLuAXrp5gWZJevWkv6zRoH7wx9P/Uuj0ZUFNi9vFUOB9
	 fWuaHdfgRVQdOmrgdidDcRA9JHNDbiBvNRUb8v7DVTUgQPYvtPjwtVmZoAFJjwYCcrVvN
	 UEVTocaiH3mvsjxQ8lxgSE7zKrfRwp5czy5gB+i2M9WBmbcbV3I0xNRlz1qeht35xMWYz
	 zrkR4qehB+7fZuVI7oqbhchBCYHdkVnTV30cSLJfVjxIGtHCJ4O1zzrEG6sVFkP2cEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Y1nXV3+1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10386606A31C;
	Mon,  9 Nov 2026 00:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10386606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Y1nXV3+1
ARC-Seal: i=1; a=rsa-sha256; t=1794182894; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GZdOfVGwfy+fHzzFImBVN3ZRwh5yJ0rExwch9ff/A1WPXOMJeyl9H7pbyKSpwZ0ktG1SVIPMnSMyMli3qdqr3+XDdVW5OnEOkQXS42SkaGP945U4hUUeCcHLX85jkcVoCu2bBFZovtwLk0yA628do5498cmiDoKBVFs8LCyuJ0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794182894; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9rVwbOecFjn75cDjqDTfDsnAfqPeatJDytpCsuFTOOw=; 
	b=UtOWFT0AU74Ns2xz8nEyYXPyUTIZvRDLn5deaduTCtAY+R5cOJe/OUUHbTWjzKtIuOZjj/jyPoN1lGcDxRbC0gplFaDlxy3semyGTjZ3eIiqZ9WjO/GWSWMnMTYCEQSK9YOfdDOJE7nMRO+eI2BGf0JIo30/shvBmXFtKuCcumY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Y1nXV3+1hdC3fCNRppldqk7KeJc6XHRAYG+BuJhiILJ7IJEgsKa++uiJJtrep62MhdIQ/yCq54z96CpR830gM9Ew/R82WR+b5kIZj178NXz7YBn+ruCfGsaJNkiwok0NvDP4wySMLECnoNcqn8+PKt+ArVOs8ku13uZ5KTEJvJQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=9rVwbOecFjn75cDjqDTfDsnAfqPeatJDytpCsuFTOOw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794182894285249.11400116708091;
	Sun, 8 Nov 2026 16:08:14 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 62D591808E6; Mon, 09 Nov 2026 01:08:13 +0100 (CET)
Date: Mon, 9 Nov 2026 01:08:13 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: admin@tsv-stahl-riesa.de
Cc: Aaron Kling <webgeek1234@gmail.com>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq24190: Fix NTC status decoding for
 BQ24193
Message-ID: <avEObsi3nkr_-kaf@venus>
References: <20261026-upstream-bq24190-ntc-v1-1-fdc12d795a99@tsv-stahl-riesa.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxjeawftv4clqcwp"
Content-Disposition: inline
In-Reply-To: <20261026-upstream-bq24190-ntc-v1-1-fdc12d795a99@tsv-stahl-riesa.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.158.93
X-ZohoMailClient: External


--wxjeawftv4clqcwp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: bq24190: Fix NTC status decoding for
 BQ24193
MIME-Version: 1.0

Hi,

On Mon, Oct 26, 2026 at 07:25:05AM +0100, Patrick Fischer via B4 Relay wrot=
e:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> The BQ24193 has a single thermistor input and applies the JEITA
> temperature profile. Its NTC_FAULT field in REG09 is encoded
> differently from the BQ24190, which has two TS inputs:
>=20
>   NTC_FAULT  BQ24190    BQ24193
>   000        Normal     Normal
>   010        TS1 Hot    Warm
>   011        TS2 Cold   Cool
>   101        Both Cold  Cold
>   110        Both Hot   Hot
>=20
> (BQ24190/2/2I datasheet SLUSAW5B, table 17; BQ24193 datasheet
> SLUSBG7A, table 16.)
>=20
> Warm (45-60 C at the TS pin) and Cool (0-10 C) are not faults. The
> charger keeps charging at a reduced charge voltage or charge current.
> The BQ24193 uses bq24190_charger_get_ntc_status() though, so a warm
> battery is reported as POWER_SUPPLY_HEALTH_OVERHEAT and a cool one as
> POWER_SUPPLY_HEALTH_COLD.
>=20
> Add a BQ24193 decoder that reports POWER_SUPPLY_HEALTH_WARM and
> POWER_SUPPLY_HEALTH_COOL for these states. Cold and Hot are unchanged.
>=20
> On an NVIDIA Tegra Note 7 (P1640) REG09 reads 0x02 after a few minutes
> on USB power. The battery keeps charging, but the charger reports
> health "Overheat". With this patch it reports "Warm" in that state and
> "Good" while REG09 reads 0x00.
>=20
> Fixes: afe5301bfbaa ("power: bq24190: Add BQ24193 support")
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
> I kept this a pure decoding fix. Two things stay as they are and could
> be follow-ups if you want them:
>=20
> - The interrupt handler still logs a change to Warm or Cool as
>   "Fault: ... ntc 1", as it does for every change of REG09.
> - bq24190_charger_get_health() checks the NTC bits first, so while the
>   battery is warm or cool the charger health hides a charge fault or
>   battery over-voltage.
>=20
> Tool use (see Documentation/process/generated-content.rst): this patch,
> its changelog and this note were prepared with an LLM coding assistant
> (Claude Code). It compared the driver with both datasheets and wrote the
> code change and the texts from my register dumps and instructions. I
> reviewed the change and ran the test on the device.
> ---

Looks like bq24190_charger_get_ntc_status can just be updated to
handle a single temperature sensor as warm/cool and dual-sensor as
overheat/cold?

Greetings,

-- Sebastian

>  drivers/power/supply/bq24190_charger.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 4bea6fd83c36..350cf79a0744 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -999,6 +999,30 @@ static int bq24190_charger_get_ntc_status(u8 value)
>  	return health;
>  }
> =20
> +static int bq24193_charger_get_ntc_status(u8 value)
> +{
> +	int health;
> +
> +	switch (value >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
> +	case 0x2: /* Warm */
> +		health =3D POWER_SUPPLY_HEALTH_WARM;
> +		break;
> +	case 0x3: /* Cool */
> +		health =3D POWER_SUPPLY_HEALTH_COOL;
> +		break;
> +	case 0x5: /* Cold */
> +		health =3D POWER_SUPPLY_HEALTH_COLD;
> +		break;
> +	case 0x6: /* Hot */
> +		health =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		break;
> +	default:
> +		health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +	}
> +
> +	return health;
> +}
> +
>  static int bq24296_charger_get_ntc_status(u8 value)
>  {
>  	int health;
> @@ -2013,7 +2037,7 @@ static const struct bq24190_chip_info bq24190_chip_=
info_tbl[] =3D {
>  		.check_chip =3D bq24190_check_chip,
>  		.set_chg_config =3D bq24190_battery_set_chg_config,
>  		.ntc_fault_mask =3D BQ24190_REG_F_NTC_FAULT_MASK,
> -		.get_ntc_status =3D bq24190_charger_get_ntc_status,
> +		.get_ntc_status =3D bq24193_charger_get_ntc_status,
>  		.set_otg_vbus =3D bq24190_set_otg_vbus,
>  	},
>  	[BQ24196] =3D {
>=20
> ---
> base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
> change-id: 20261023-upstream-bq24190-ntc-f35ec3323449
>=20
> Best regards,
> -- =20
> Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
>=20

--wxjeawftv4clqcwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrxDukACgkQ2O7X88g7
+prEng//VL80jG3ac+N44hjvZX28Pga/56OOG1omtl/BuuUqk3wMbIIUa6lpXAM/
OWb9gQ3aM9tnX69d9pDega9vMfzSCH4nV1gmSbM4DYr6bDu8kaX1veCDRVNIzj0i
Q0O8WSd4sbh8J40UZnftYTlSMxJrugR9e8SAOWnUav1gzp7+5QCn6mq6Z9T/Uf+t
imkdA1ASPe3P4AzAkHgMP8AgsXk2DIWYjo3bc0JWetSksCA8HXZsx5FsjftiwYLP
CftuocddSIeYb2hWJeadLOG91Q2Izol1yZz0F9TtbBQoicN1+3gHzhOMnS2XVmU6
2wKBr0p17Ghr6M5MslkVX8ALTI5lhji9Tr9kMWdlPUk/xPm6JI+QsZhd/5dl1Zwb
c3nI2QhYl1JH0+QYYmq5qBLLMlPCRjE5CYVpCTx1y7Kd0Xxzdl6VAF9Q3ZScje06
/NCCgDUqJW543bLVakDP3YTd1vnxM0B5jDOx/C5OMeNfclqXot22n3poZVKKQgtv
5AIgHZAAouCBSMNt+i/Bfi43Bb1tcwS9uuIGrSkdCgK4XJOtt7PLERjlcI768Oyn
ux+EcGMmoekx2Oh99TxsELi5siThPh4z4EejReZcVJBcNbSPp9pN8oJk7IHEC1cL
o841MSvhY0ieDr6PaA86m3cKmn6EquQuSPJ8dgpcrLlttUADErQ=
=CoiC
-----END PGP SIGNATURE-----

--wxjeawftv4clqcwp--

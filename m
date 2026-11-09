Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794185670;
	b=2hJvOJRudwx9UtAlY3U8q4AXgIHD5/KfsaoFwzTxYJVm1iUsonMaHvisiPzL86MpS7Zv
	 hOECaKm/czrjkzRv9HHjDUKYeQV0ziFBGWjFhzOtPwpaeI7+YVV2pS3uK5JL6sYza+e/N
	 Ca3PcCSUapyN3HwFylZQpxth5nubj1M9YjFhNzmIMrj6T+Gr3LLqeIUr2vZwkKD3Zkbvr
	 V8aqCsYKwCakNQrMvE290zoCIImbK6mW+bRgdcatmtsPsD2bo+Ar5I8WX1ZFwhmimwgVa
	 S0uxK+uev/5dADsmth94ddXzbtBaliTC9EEARaLpgtYHRgUiu1N6Eywv42JkpiCiydw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185670;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:
	 X-ZohoMailClient;
	bh=3dZwmpYqRDolaH+9+KlR5smyN4t767VKR23GyFVod3M=;
	b=o6g818M0roveGHxVrzAw7oUUpy/TA48yOvWRKvh3pE9ZhkzTmOfLvJ3xTXMuyK4by+p3
	 pJK8lrYFhXH/v4cAPciZWaI7zJXyjlaEA90MgqYFY+TD3l3aFRnIAzGHCoQt/hUJnijMe
	 5Gg1XLPhkA7Uk4kzjWxYNViYPd807tVMS2K6KBuIDl9EYIlxo+FdH9J30N+bRDcSppLTW
	 /EhMdt5uJh9PI8hZaRQidrKLIcD+xmnhSW0qyG5RP7NVffH+6HcYvnyWYlsoWM0IVz4bI
	 mpqnNU1g+XNgfOFLz8WcgSTgdJBv5KCrZkQQQCbN2MhD5qB0iS4FJO04o8HVG0nVG2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ehQfQKga;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.11
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9372606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9372606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ehQfQKga
ARC-Seal: i=1; a=rsa-sha256; t=1794185656; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UXAqwZuIx4IdANb0Smdgc/E2DV2a0M7o0WAvJqUCfgSRhnFtrxsv6059yCzhSifYllSK0/Q4aYbIbLj59ARvnnzqoHDfffjQpbOCVW5ITX/bPRPP6b7ZtgQud6beMpzqE88MwyjKsek9oFfu/iQAmSm2LsQTX/PJx9ROg4+UP/s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794185656; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3dZwmpYqRDolaH+9+KlR5smyN4t767VKR23GyFVod3M=; 
	b=ZxuneDOPbPHh0Ik7eSAcM0CY6HwXavF7DlZTm3rG6A4HaL7aayCzm/f6GBLPW/u6pGJON49XwIkFehVE/7LeS7VfzQrlYPonK+zwlSMZez1bQ6TpbgMdg3wnSHLJSi8+g7ECfi34hRicSb70G/ggHqGDBP4eCGuE/BXy3R4daro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: a=rsa-sha256; b=ehQfQKgaLgBcXs8SZyO7VucozQtd405NhLM6acoaXKGpQioEEYcB5yUG6xfEPQNLe92qjmZAVC+ppCTydZ2RLxIrd5Zb8NEDsolg0VAh6K/YIYoUoB60TRd4lwyfKo22Qv3T95gqy6nln15eijLFL/gGNIR9FvH7AD/iFG/STgA=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=3dZwmpYqRDolaH+9+KlR5smyN4t767VKR23GyFVod3M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794185654652199.25556237609146;
	Sun, 8 Nov 2026 16:54:14 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 478591808E6; Mon, 09 Nov 2026 01:54:13 +0100 (CET)
Date: Mon, 9 Nov 2026 01:54:13 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	maccraft123mc@gmail.com, heiko@sntech.de, lee@kernel.org, 
	Chris Morgan <macromorgan@hotmail.com>, Jacob Cook <jacobmcook1984@gmail.com>
Subject: Re: [PATCH V2 2/4] power: supply: rk817-charger: Resolve boot state
 of charge from the coulomb counter
Message-ID: <avEZBrZSAzJmqON_@venus>
References: <20261102143942.305293-1-macroalpha82@gmail.com>
 <20261102143942.305293-3-macroalpha82@gmail.com>
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
	protocol="application/pgp-signature"; boundary="7qp4dc52vysprfju"
Content-Disposition: inline
In-Reply-To: <20261102143942.305293-3-macroalpha82@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/294.158.93
X-ZohoMailClient: External


--7qp4dc52vysprfju
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2 2/4] power: supply: rk817-charger: Resolve boot state
 of charge from the coulomb counter
MIME-Version: 1.0

Hi,

On Mon, Nov 02, 2026 at 08:39:40AM -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> The boot state of charge comes from PWRON_VOL when OFF_CNT reads three
> or more and from the coulomb counter otherwise, and both fail in the
> field.
>=20
> PWRON_VOL is sampled at the power-on instant. A power-on caused by
> plugging in a charger samples under charge current: on an RG353M it
> read above the pack's maximum design voltage while the pack was at
> 74%. An RG DS was seen holding 2.63V in the register while running.
> Either becomes a wrong percentage on every boot that reaches it.
>=20
> A negative counter was clamped to zero and reported as 0%.
>=20
> The counter itself keeps counting while the system is off: the same
> RG353M, saved at 74% and charged for 1.5 hours powered off, booted
> with the counter at full. The BSP driver relies on this: it reads
> OFF_CNT into a flag it never uses, consults PWRON_VOL only when
> BAT_CON marks a new battery, and adopts the counter when it diverges
> from the saved capacity ("system halt last time").
>=20
> Keep the PWRON_VOL lookup for the first boot, but "guess" the SoC on
> boot based on available signals such as the stored NVRAM value, the
> state of charge from the battery voltage (which would be high if
> charging, or low if discharging, but based on testing within about
> 10% of the actual value), and the value reported by the gauge. Then,
> periodically read the OCV value reported when it is available and
> use that to adjust the gauge if it differs too much from what the
> OCV says the state of charge should be. This combined with calibrating
> to full when the battery stops charging while plugged in should give
> us a better way to report an accurate value of the battery's SOC.
>=20
> Expose PWRON_VOL as POWER_SUPPLY_PROP_VOLTAGE_BOOT and the current
> rested pair as POWER_SUPPLY_PROP_VOLTAGE_OCV, -ENODATA while the
> battery is not resting.
>=20
> Log the counter, saved soc and battery voltage at boot, as the BSP logs
> its saved and present capacity, so a counter that diverged from the
> saved soc is visible. Report it when debugging is enabled so as to not
> spam the dmesg log otherwise.
>=20
> Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK81=
7")
> Co-developed-by: Jacob Cook <jacobmcook1984@gmail.com>
> Signed-off-by: Jacob Cook <jacobmcook1984@gmail.com>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> --

please split this to make it easier to review. I had a quick look
and e.g. introducing rk817_initialize_coulumb_counter() to remove
code duplocation can be its own change. Adding support for
POWER_SUPPLY_PROP_VOLTAGE_BOOT and POWER_SUPPLY_PROP_VOLTAGE_OCV is
not a fix and could be its own patch too.

Greetings,

-- Sebastian

>  drivers/power/supply/rk817_charger.c | 295 ++++++++++++++++++++-------
>  include/linux/mfd/rk808.h            |   2 +
>  2 files changed, 223 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> index 86da0462fb59..0c7287ad27c6 100644
> --- a/drivers/power/supply/rk817_charger.c
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -95,6 +95,15 @@ struct rk817_charger {
>  	int bat_voltage_min_design_uv;
>  	int bat_voltage_max_design_uv;
> =20
> +	/* Battery voltage the PMIC sampled when the system powered on. */
> +	int boot_voltage_uv;
> +
> +	/* Rested voltage the gauge latched, 0 if it took no usable pair. */
> +	int relax_voltage_uv;
> +
> +	/* Retained for the ocv-capacity table the recalibration needs. */
> +	struct power_supply_battery_info *bat_info;
> +
>  	/* Values updated periodically by driver for display. */
>  	int charge_now_uah;
>  	int volt_avg_uv;
> @@ -167,6 +176,20 @@ static int rk817_chg_cur_from_reg(u8 reg)
>  	}
>  }
> =20
> +static int rk817_initialize_coulumb_counter(struct rk817_charger *charge=
r,
> +					    u32 charge_ua)
> +{
> +	int tmp =3D CHARGE_TO_ADC(charge_ua, charger->res_div);
> +	u8 bulk_reg[4];
> +	int ret;
> +
> +	put_unaligned_be32(tmp, bulk_reg);
> +	ret =3D regmap_bulk_write(charger->rk808->regmap, RK817_GAS_GAUGE_Q_INI=
T_H3,
> +				bulk_reg, 4);
> +
> +	return ret;
> +}
> +
>  static void rk817_bat_calib_vol(struct rk817_charger *charger)
>  {
>  	uint32_t vcalib0 =3D 0;
> @@ -242,6 +265,7 @@ static int rk817_bat_calib_cap(struct rk817_charger *=
charger)
>  	struct rk808 *rk808 =3D charger->rk808;
>  	int charge_now, charge_now_adc;
>  	u8 bulk_reg[4];
> +	int ret;
> =20
>  	/* Don't do anything if there's no battery. */
>  	if (!charger->battery_present)
> @@ -281,11 +305,9 @@ static int rk817_bat_calib_cap(struct rk817_charger =
*charger)
>  		 */
> =20
>  		charger->soc =3D 100000;
> -		charge_now_adc =3D CHARGE_TO_ADC(charger->fcc_mah,
> -					       charger->res_div);
> -		put_unaligned_be32(charge_now_adc, bulk_reg);
> -		regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
> -				  bulk_reg, 4);
> +		ret =3D rk817_initialize_coulumb_counter(charger, charger->fcc_mah);
> +		if (ret)
> +			return ret;
> =20
>  		charger->soc_cal =3D 1;
>  		dev_dbg(charger->dev,
> @@ -313,17 +335,9 @@ static int rk817_bat_calib_cap(struct rk817_charger =
*charger)
>  			dev_dbg(charger->dev,
>  				"Recalibrating columb counter to %d uah\n",
>  				charge_now);
> -			/*
> -			 * Order of operations matters here to ensure we keep
> -			 * enough precision until the last step to keep from
> -			 * making needless updates to columb counter.
> -			 */
> -			charge_now_adc =3D CHARGE_TO_ADC(charger->fcc_mah,
> -					 charger->res_div);
> -			put_unaligned_be32(charge_now_adc, bulk_reg);
> -			regmap_bulk_write(rk808->regmap,
> -					  RK817_GAS_GAUGE_Q_INIT_H3,
> -					  bulk_reg, 4);
> +			ret =3D rk817_initialize_coulumb_counter(charger, charger->fcc_mah);
> +			if (ret)
> +				return ret;
>  		}
>  	}
> =20
> @@ -332,6 +346,42 @@ static int rk817_bat_calib_cap(struct rk817_charger =
*charger)
>  	return 0;
>  }
> =20
> +/* Calibrated microvolts from one of the gas gauge's 16 bit voltage regi=
sters. */
> +static int rk817_bat_voltage_uv(struct rk817_charger *charger, unsigned =
int reg)
> +{
> +	u8 bulk_reg[2];
> +
> +	regmap_bulk_read(charger->rk808->regmap, reg, bulk_reg, 2);
> +
> +	return (charger->voltage_k * get_unaligned_be16(bulk_reg)) +
> +		1000 * charger->voltage_b;
> +}
> +
> +/*
> + * Voltage the gauge latched while the battery was resting. Relax mode o=
nly
> + * samples below RELAX_THRE_CUR, so this is a true open circuit voltage =
with
> + * no resistance term. Returns 0 unless the battery is resting now and t=
he
> + * latched pair is inside the pack's design range.
> + */
> +static int rk817_bat_relax_voltage_uv(struct rk817_charger *charger)
> +{
> +	unsigned int need =3D RK817_RELAX_STS | RK817_RELAX_VOL_UPD;
> +	int ret, sts, vol;
> +
> +	ret =3D regmap_read(charger->rk808->regmap, RK817_GAS_GAUGE_GG_STS, &st=
s);
> +	if (ret < 0 || (sts & need) !=3D need)
> +		return 0;
> +
> +	vol =3D max(rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_RELAX_VOL1_H),
> +		  rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_RELAX_VOL2_H));
> +
> +	if (vol < charger->bat_voltage_min_design_uv ||
> +	    vol > charger->bat_voltage_max_design_uv)
> +		return 0;
> +
> +	return vol;
> +}
> +
>  static void rk817_read_props(struct rk817_charger *charger)
>  {
>  	int tmp, reg;
> @@ -367,11 +417,8 @@ static void rk817_read_props(struct rk817_charger *c=
harger)
>  	charger->soc =3D charger->charge_now_uah * 100 / charger->fcc_mah;
> =20
>  	/* Update reported voltage. */
> -	regmap_bulk_read(charger->rk808->regmap, RK817_GAS_GAUGE_BAT_VOL_H,
> -			 bulk_reg, 2);
> -	tmp =3D get_unaligned_be16(bulk_reg);
> -	charger->volt_avg_uv =3D (charger->voltage_k * tmp) + 1000 *
> -				charger->voltage_b;
> +	charger->volt_avg_uv =3D rk817_bat_voltage_uv(charger,
> +						    RK817_GAS_GAUGE_BAT_VOL_H);
> =20
>  	/*
>  	 * Update reported current. Note value from registers is a signed 16
> @@ -430,6 +477,8 @@ static void rk817_read_props(struct rk817_charger *ch=
arger)
>  		charger->charger_input_volt_avg_uv =3D 0;
>  	}
> =20
> +	charger->relax_voltage_uv =3D rk817_bat_relax_voltage_uv(charger);
> +
>  	/* Calibrate battery capacity and soc. */
>  	rk817_bat_calib_cap(charger);
>  }
> @@ -516,6 +565,14 @@ static int rk817_bat_get_prop(struct power_supply *p=
s,
>  	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
>  		val->intval =3D charger->volt_avg_uv;
>  		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
> +		val->intval =3D charger->boot_voltage_uv;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		if (!charger->relax_voltage_uv)
> +			return -ENODATA;
> +		val->intval =3D charger->relax_voltage_uv;
> +		break;
>  	case POWER_SUPPLY_PROP_CURRENT_AVG:
>  		val->intval =3D charger->cur_avg_ua;
>  		break;
> @@ -654,6 +711,8 @@ static enum power_supply_property rk817_bat_props[] =
=3D {
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
>  	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>  	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_CURRENT_AVG,
>  	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> @@ -746,15 +805,88 @@ static int rk817_read_battery_nvram_values(struct r=
k817_charger *charger)
>  	return 0;
>  }
> =20
> +/*
> + * The relax pair is a true rested voltage: where it disagrees with the
> + * tracked soc by more than 5% (chosen arbitrarily), re-init the counter
> + * from it.
> + */
> +static void rk817_bat_ocv_recalibrate(struct rk817_charger *charger)
> +{
> +	int ocv_soc;
> +
> +	if (!charger->battery_present)
> +		return;
> +
> +	if (!charger->relax_voltage_uv)
> +		return;
> +
> +	ocv_soc =3D power_supply_batinfo_ocv2cap(charger->bat_info,
> +					       charger->relax_voltage_uv,
> +					       20) * 1000;
> +	if (ocv_soc < 0 || abs(ocv_soc - charger->soc) <=3D 5000)
> +		return;
> +
> +	dev_dbg(charger->dev,
> +		"OCV %duV disagrees with soc, recalibrating (%d -> %d)\n",
> +		charger->relax_voltage_uv, charger->soc, ocv_soc);
> +	charger->soc =3D ocv_soc;
> +	rk817_initialize_coulumb_counter(charger,
> +					 (ocv_soc * charger->fcc_mah) / 100000);
> +	rk817_record_battery_nvram_values(charger);
> +}
> +
> +/*
> + * Since we cannot perfectly control the bootloader, we cannot trust the
> + * POWERON_VOL value. Instead, we have to guess with what we have availa=
ble;
> + * the state of charge saved to NVRAM, the SoC reported by the gauge, and
> + * a lookup of the battery voltage against the OCV table. None of these =
will
> + * give us a true value of the state of charge, but it should ensure wha=
t we
> + * report to userspace is "slightly correct" until we can get an OCV val=
ue or
> + * we hit the charge_term_current_ua where we can stop guessing. If we h=
ave
> + * only the NVRAM value and the SoC from the gauge, use the NVRAM value =
if
> + * it's within 10% of the gauge SoC, otherwise use the gauge SoC. If we =
have
> + * all 3 values, sort them and keep the middle value. Then, drop the fir=
st
> + * or 3rd value (whichever is further away) and average the remaining 2 =
values.
> + */
> +static int rk817_select_boot_soc(struct rk817_charger *charger, int gaug=
e_soc,
> +				 int table_soc, int nvram_soc)
> +{
> +	int soc[3];
> +
> +	if (table_soc <=3D 0) {
> +		if (abs(gauge_soc - nvram_soc) >=3D 10000)
> +			return gauge_soc;
> +		return nvram_soc;
> +	}
> +
> +	/* Sort the values so we can drop the outlier */
> +	soc[0] =3D gauge_soc;
> +	soc[1] =3D table_soc;
> +	soc[2] =3D nvram_soc;
> +
> +	if (soc[0] > soc[1])
> +		swap(soc[0], soc[1]);
> +	if (soc[1] > soc[2])
> +		swap(soc[1], soc[2]);
> +	if (soc[0] > soc[1])
> +		swap(soc[0], soc[1]);
> +
> +	/* Drop whichever end is further from the middle and average the rest. =
*/
> +	if (soc[1] - soc[0] > soc[2] - soc[1])
> +		return (soc[1] + soc[2]) / 2;
> +
> +	return (soc[0] + soc[1]) / 2;
> +}
> +
>  static int
>  rk817_read_or_set_full_charge_on_boot(struct rk817_charger *charger,
>  				struct power_supply_battery_info *bat_info)
>  {
> +	int ret, reg, tmp, off_cnt, bat_uv, boot_soc, table_soc;
>  	struct rk808 *rk808 =3D charger->rk808;
> -	u8 bulk_reg[4];
> -	u32 boot_voltage, boot_charge_mah;
> -	int ret, reg, off_time, tmp;
> +	u32 boot_charge_mah;
>  	bool first_boot;
> +	u8 bulk_reg[4];
> =20
>  	/*
>  	 * Check if the battery is uninitalized. If it is, the columb counter
> @@ -764,25 +896,22 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_=
charger *charger,
>  	if (ret < 0)
>  		return ret;
>  	first_boot =3D reg & RK817_BAT_CON;
> -	/*
> -	 * If the battery is uninitialized, use the poweron voltage and an ocv
> -	 * lookup to guess our charge. The number won't be very accurate until
> -	 * we hit either our minimum voltage (0%) or full charge (100%).
> -	 */
> +
> +	/* PWRON_VOL only refreshes on a real power-on; bound it to the pack. */
> +	charger->boot_voltage_uv =3D
> +		clamp(rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_PWRON_VOL_H),
> +		      bat_info->voltage_min_design_uv,
> +		      bat_info->voltage_max_design_uv);
> +
>  	if (first_boot) {
> -		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_PWRON_VOL_H,
> -				 bulk_reg, 2);
> -		tmp =3D get_unaligned_be16(bulk_reg);
> -		boot_voltage =3D (charger->voltage_k * tmp) +
> -				1000 * charger->voltage_b;
>  		/*
> -		 * Since only implementation has no working thermistor, assume
> -		 * 20C for OCV lookup. If lookup fails, report error with OCV
> -		 * table.
> +		 * Nothing has been saved yet, so estimate from the boot
> +		 * voltage with an ocv lookup. Since only implementation has
> +		 * no working thermistor, assume 20C for that lookup.
>  		 */
>  		charger->soc =3D power_supply_batinfo_ocv2cap(bat_info,
> -							    boot_voltage,
> -							    20) * 1000;
> +						charger->boot_voltage_uv,
> +						20) * 1000;
>  		if (charger->soc < 0)
>  			charger->soc =3D 0;
> =20
> @@ -803,39 +932,45 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_=
charger *charger,
>  		if (ret < 0)
>  			return ret;
> =20
> +		/*
> +		 * The coulomb counter keeps counting while the system is off,
> +		 * so take it, capped at full, unless it reads invalid; the
> +		 * saved soc is then at most one update interval old. A counter
> +		 * that is merely wrong is corrected by the next rested relax
> +		 * pair.
> +		 */
>  		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
>  				 bulk_reg, 4);
>  		tmp =3D get_unaligned_be32(bulk_reg);
> -		if (tmp < 0)
> -			tmp =3D 0;
> -		boot_charge_mah =3D ADC_TO_CHARGE_UAH(tmp,
> -						    charger->res_div) / 1000;
> -		/*
> -		 * Check if the columb counter has been off for more than 30
> -		 * minutes as it tends to drift downward. If so, re-init soc
> -		 * with the boot voltage instead. Note the unit values for the
> -		 * OFF_CNT register appear to be in decaminutes and stops
> -		 * counting at 2550 (0xFF) minutes. BSP kernel used OCV, but
> -		 * for me occasionally that would show invalid values. Boot
> -		 * voltage is only accurate for me on first poweron (not
> -		 * reboots), but we shouldn't ever encounter an OFF_CNT more
> -		 * than 0 on a reboot anyway.
> -		 */
> -		regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_time);
> -		if (off_time >=3D 3) {
> -			regmap_bulk_read(rk808->regmap,
> -					 RK817_GAS_GAUGE_PWRON_VOL_H,
> -					 bulk_reg, 2);
> -			tmp =3D get_unaligned_be16(bulk_reg);
> -			boot_voltage =3D (charger->voltage_k * tmp) +
> -					1000 * charger->voltage_b;
> -			charger->soc =3D
> -				power_supply_batinfo_ocv2cap(bat_info,
> -							     boot_voltage,
> -							     20) * 1000;
> +		regmap_read(rk808->regmap, RK817_GAS_GAUGE_OFF_CNT, &off_cnt);
> +		bat_uv =3D rk817_bat_voltage_uv(charger, RK817_GAS_GAUGE_BAT_VOL_H);
> +		dev_dbg(charger->dev,
> +			"boot: counter %d uAh, saved soc %d, fcc %d mAh, battery %d uV, off_c=
nt %d\n",
> +			tmp > 0 ? ADC_TO_CHARGE_UAH(tmp, charger->res_div) : 0,
> +			charger->soc, charger->fcc_mah, bat_uv, off_cnt);
> +		if (tmp > 0) {
> +			boot_charge_mah =3D ADC_TO_CHARGE_UAH(tmp,
> +							    charger->res_div) / 1000;
> +			if (boot_charge_mah > charger->fcc_mah)
> +				boot_charge_mah =3D charger->fcc_mah;
> +			boot_soc =3D boot_charge_mah * 100000 / charger->fcc_mah;
> +
> +			/*
> +			 * The gauge re-derives this count from its own ocv
> +			 * model while the pack rests, so bound it with the ocv
> +			 * table: under load the terminal voltage sits below the
> +			 * open circuit voltage, making the table a floor, and
> +			 * under charge above it, making it a ceiling on any
> +			 * saved soc that would displace the counter.
> +			 */
> +			table_soc =3D power_supply_batinfo_ocv2cap(bat_info, bat_uv,
> +								 20) * 1000;
> +
> +			charger->soc =3D rk817_select_boot_soc(charger, boot_soc,
> +							     table_soc, charger->soc);
>  		} else {
> -			charger->soc =3D (boot_charge_mah * 1000 * 100 /
> -					charger->fcc_mah);
> +			dev_dbg(charger->dev,
> +				"coulomb counter invalid, keeping saved soc\n");
>  		}
>  	}
> =20
> @@ -846,11 +981,8 @@ rk817_read_or_set_full_charge_on_boot(struct rk817_c=
harger *charger,
>  	boot_charge_mah =3D charger->soc * charger->fcc_mah / 100 / 1000;
>  	if (boot_charge_mah > charger->fcc_mah)
>  		boot_charge_mah =3D charger->fcc_mah;
> -	tmp =3D CHARGE_TO_ADC(boot_charge_mah, charger->res_div);
> -	put_unaligned_be32(tmp, bulk_reg);
> -	ret =3D regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
> -			  bulk_reg, 4);
> -	if (ret < 0)
> +	ret =3D rk817_initialize_coulumb_counter(charger, boot_charge_mah);
> +	if (ret)
>  		return ret;
> =20
>  	/* Set QMAX value to max design capacity. */
> @@ -1044,6 +1176,7 @@ static void rk817_charging_monitor(struct work_stru=
ct *work)
>  	charger =3D container_of(work, struct rk817_charger, work.work);
> =20
>  	rk817_read_props(charger);
> +	rk817_bat_ocv_recalibrate(charger);
> =20
>  	/* Run every 8 seconds like the BSP driver did. */
>  	queue_delayed_work(system_percpu_wq, &charger->work, msecs_to_jiffies(8=
000));
> @@ -1056,6 +1189,13 @@ static void rk817_cleanup_node(void *data)
>  	of_node_put(node);
>  }
> =20
> +static void rk817_put_battery_info(void *data)
> +{
> +	struct rk817_charger *charger =3D data;
> +
> +	power_supply_put_battery_info(charger->bat_ps, charger->bat_info);
> +}
> +
>  static int rk817_charger_probe(struct platform_device *pdev)
>  {
>  	struct rk808 *rk808 =3D dev_get_drvdata(pdev->dev.parent);
> @@ -1172,7 +1312,14 @@ static int rk817_charger_probe(struct platform_dev=
ice *pdev)
>  	if (ret)
>  		return ret;
> =20
> -	power_supply_put_battery_info(charger->bat_ps, bat_info);
> +	/*
> +	 * Keep the battery info: the periodic recalibration needs its
> +	 * ocv-capacity table for as long as the driver is bound.
> +	 */
> +	charger->bat_info =3D bat_info;
> +	ret =3D devm_add_action_or_reset(dev, rk817_put_battery_info, charger);
> +	if (ret)
> +		return ret;
> =20
>  	plugin_irq =3D platform_get_irq(pdev, 0);
>  	if (plugin_irq < 0)
> diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
> index 7ffc904c864c..72419d311626 100644
> --- a/include/linux/mfd/rk808.h
> +++ b/include/linux/mfd/rk808.h
> @@ -1211,6 +1211,8 @@ enum rk809_reg_id {
> =20
>  #define RK817_GAS_GAUGE_RELAX_THRE_H	0x58
>  #define RK817_GAS_GAUGE_RELAX_THRE_L	0x59
> +#define RK817_GAS_GAUGE_RELAX_VOL1_H	0x5a
> +#define RK817_GAS_GAUGE_RELAX_VOL2_H	0x5c
>  #define RK817_GAS_GAUGE_OCV_THRE_VOL	0x62
>  #define RK817_GAS_GAUGE_OCV_VOL_H	0x63
>  #define RK817_GAS_GAUGE_OCV_VOL_L	0x64
> --=20
> 2.53.0
>=20
>=20

--7qp4dc52vysprfju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrxGbEACgkQ2O7X88g7
+pq9Dg//V2cySOQ5fxjfCoQAhQ5rRBkGJRsflCuxyCDRj8C0DvtrA6CZ9xCXjLMb
orXEUpg+rndRrcnfNAZtKZ5BVjD9sU4pBlfCcYs5S2m8CWziD2IbwH6lj6z2Vb9/
QVjQwJUWC+IxgjbwMeObvOFIkFdSTIuShY0jsh4mR3FKZmZez3q0SILXBeTr1v7l
BbLx7XAeDnhmOlexId+AYN7OV/uldyBPAwIyDhZftmrD1tgrMR6klwWBNnCW2Q0n
aC4YNQe/3qMinC/ndxUA7ynG6+fXJ7r5PDg05j8rkNc98o7KXMdwUYuPs9bq/5mA
QIt7fxo3XgZ1hajEh9UQyRCtFwPzT2xkfdRfdaQCY1uWgupDSTxEPwFPFcehyWkZ
gANnNcQMGbUXyZn+HD5OP8qKMU74YuPIpsZ9O5TrbXQhgs7hrZS14F4WZ6iLOrFW
x5wkYQaPN/jwtfFWLwrTxiIjgVgtPR87gGVqrDDeGiGQWvYW7P6doh+gYvGExJc4
N2D/0MxUe6RMSlgQ63zxi2LmpehiD0gQ24zAmT1OFjyLNSlA9AAStbrYpdISHU7c
FeA9OmWne1u1T5+cpZdqFI3Jvgiyd5rkS815YwJ8IiBR1wckV/w5/bhNdek6Vgpv
AzlmMDTzq/aqgUxTwHRzWUTi2XdAVlRY84MqBKqrOrMTLRDmF6s=
=jgIu
-----END PGP SIGNATURE-----

--7qp4dc52vysprfju--

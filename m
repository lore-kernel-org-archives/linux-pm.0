Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425445;
	b=xUnppsQsMVRvU+cqN1rIFy1344eTfccFc/S2JSoh2ErPfskAL/eg1JrT8F8hJ1M1kEUK
	 YDMwYbte2R6WBhqkBA0L+YZWM4DzbWTFGuqPhPya/bZMqhlnHg71ndCpysdRZ+mLu96/Z
	 qbl8WGDNBDHCSMWpVT0DRJVQqo6/D9hPMYnNHPcRKPFHbKxcq5l1tAov8hrp7jzEp5Csd
	 oB6a+CQzkU5+7fxLrI3YBJe6iXY+LQ1s/texFS5tKSZW3Fl4eL1ajOjk1faiAD5DCUMpH
	 PSVCAUF7WSnH4Xefj2/Sxpj8N1QM5LSN4GzJV3sOs1ebZSAhuaNIdE5GMcgrtp/IdVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=bfZwdrHDy1GNoA44s3G+1XzXoMHIKEYDGfkc9JfB56s=;
	b=ArELDxhC9mt5kFEoGF7ZlFkTEsbO8p7nuW9xSuxL5fkNJdXOKP5H0C0kKybtYDisYIVq
	 T5MBux11w6Vr8xxwS3gn2plzkk5jqT+dPslMafRsnZ2ip5/vZoxKtQ+Qev6oxNnR5Dc02
	 HxQH1WPbh41Xh7ANur02bf2L08Scks1sZj4EHxQ05XDi2Tqh0DOgIjrfMncxW3TXBo+xu
	 H0Hq6TZO1NbOuQjuvQX1NjoEzxfvdDRt7X05waaJk9JdnfTZdyJDEiLTlUn8Q8Ece0Cqo
	 BaUhJDeBNffwigRj8C2olG+WmL303zxjkLfyKUS4Ldet3xG6HvbLLZvAMBmMTyfNxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=mRpGJUoU;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3863606A321
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 09:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3863606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=mRpGJUoU
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d581da0aaso392249266b.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1795425442; x=1796030242; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bfZwdrHDy1GNoA44s3G+1XzXoMHIKEYDGfkc9JfB56s=;
        b=mRpGJUoU5NoqyhwJ0w8OwZQIUnCDN/5fpynpyGn9jzsx1jYEwfaQR/bW/LIbuTv4FP
         HtCOvcQfOBTtQbUygTRXF6/17BZUC/CCtQwrLOvg9292Pv6dsoD7zDbaCvIJT/zRcRxO
         MbIKHbJ1QOBg8Wys2xzfQCj1lY6QfqsTffezatDUGaY2lnhxi2IxR+XFTONEr778NfoU
         UyNZzn7nVB5bVPZcpv2HM9L62dtivuQJ2UJ2jenxhlPTqevL0prFen/4YMwDGWNGpHSx
         IowKIORJ7A0BzCLXZe3ybGG6jO1ZdM8muAingKU/H0QnXL7koAD1dNCNemRlfty9Q4Df
         o5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425442; x=1796030242;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfZwdrHDy1GNoA44s3G+1XzXoMHIKEYDGfkc9JfB56s=;
        b=KArQSpTSrYHbLlqlO08/FD7pLnZCFlMJTax2gM1DgbHraUUqAy39pc2YKbgWBkNhOu
         MiWwht+aVfmOwbqBRIpAlpgfXyVLlGcnYhxLJwLDlbT1MHIuu9IK7YZ/SiY9D01edOX/
         DPEJVXQn74Z7TrT2Hv49v9dqPWzCTx+OWoGELQSeeXbHgCseGRGKc1LchkulKOsZfWve
         uITB2D4jkMbPa37jwtupqCZh6UafeovT75SY3xDOasoEWiruhZz4R58giPD5xRTYKYHf
         27cSAGRblBFx7m7excAboz+iCqWGi/qgFST+wdiFYCAhdkGoem21LqB/FiGmHgBj4+b5
         UsKw==
X-Forwarded-Encrypted: i=1; AL+hErEuwi0SfrVb4+n3V/iNwQXveQBI8Rmji5xccIxVlrlc9C+5YLHb4oW5Yq6Lg4CwdzxfXdCfzWzXAA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8PgITHVarpI/Vsegn6bER7Cs8uxMRQboEwWUZyOQie4OAjwDGg
	mCXxrcSrkNlLf2dJLNOFX6Oyj1P4My9xbHIDjMS6y2DsEDCj0pyOLxmRrSBD/d9IQ2g=
X-Gm-Gg: AZFdTZeiWLwniHYgXySVLin+/LU9MdIz2Y5uYquGBnKiEMOSpkT9smi2aF3jj8Y/SJF
	geo2wsaa9uYYalPkR/iiz2OB7VHcqKvgrxuXyJiZeYsK5Xz11fghmeLmsujlv8Kadzvu13MpeHu
	z48bhcGgYdhBhiKJBWtaaePm+PgRbGuX9WbkvvePiFPEHXf9TsaMtDAgq6NkQi5rTDgSbT2VoYk
	DFB3gndbiLSt8qJt/yjsuwm9g/gLttMiC5VkviI9lBpEHCMN5beXoTSKwdEOLrjuwTjUgWzGqC9
	E75MimIidhibh0xpDgOLoIbw3lQ7iPR5Lgxr1AXuCf4V9z+VeVKNjY3CwfEOhTK9ME/od6gpYHX
	sVujEqSIdeWPTax4VpUITgb0CluFB0MDETGy96lypf6Aka/rLzooCYJK2mBIUziK4eyFiaODQA3
	T1UbzXU6pU0/jUxor82wKyYfCGcwebmjPLRfPD4Zf67CLAdKISTt7nlxjztXBL2leVrwtbdAGhE
	RTzU3Lj+Z1n/MgKT986kxgwvX58MdmHjtAh4jEWtLcAbSi9r66QlB4fjuccva1TKMeMtJcPz7M3
	84xxs+426Rcg64iYQhFsLZXIiU6RQFlH9Xva81/g0wOHihRf6nbl7LUBI9u671IBpd6Hdf114A=
	=
X-Received: by 2002:a17:907:3cc7:b0:c2e:2d8c:4585 with SMTP id a640c23a62f3a-c513ab4cd0dmr859651666b.36.1795425442222;
        Mon, 23 Nov 2026 01:17:22 -0800 (PST)
Received: from localhost (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afca58asm371207466b.65.2026.11.23.01.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 01:17:21 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 10:17:21 +0100
Message-Id: <DN2H797ASILD.3P89IOZH1IU1H@fairphone.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de
 Goede" <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Val Packett" <val@packett.cool>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
 <20261117-bat-temp-adc-v4-1-14d5d309ebfa@fairphone.com>
 <20261122031305.0fdc69cd@jic23-hlaptop>
In-Reply-To: <20261122031305.0fdc69cd@jic23-hlaptop>

Hi Jonathan,

On Sun Nov 22, 2026 at 4:13 AM CET, Jonathan Cameron wrote:
> On Tue, 17 Nov 2026 09:23:11 +0100
> Luca Weiss <luca.weiss@fairphone.com> wrote:
>
>> Add the BAT_THERM channels with millivolt as output, which can then be
>> used along with information regarding the NTC in the battery, to get the
>> actual battery temperature.
>>=20
>> A static lookup table in the ADC driver won't work since different
>> devices have different Ohm and Beta values in their battery NTCs, for
>> example a NTC can be 10kOhm & B=3D3435K.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Given this is independent of the following elements other than
> the dtsi changes, do you want me to pick it up now?
>
> You may need to use numeric values in dtsi until the header
> catches up then chase with a patch flipping to the defines next cycle.
> That's how we normally avoid that dependency slowing things down.

Sounds good from my side. Thank you!

I think realistically, there's no other option than what's implemented
in this patch, even if PATCH 2/5 (dt-bindings change for generic-adc) is
not reviewed yet. But I hope the dt maintainers will be okay with that
as well.

Regards
Luca

>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/adc/qcom-spmi-adc5.c         |  6 ++++++
>>  drivers/iio/adc/qcom-vadc-common.c       | 16 ++++++++++++++++
>>  include/linux/iio/adc/qcom-vadc-common.h |  3 +++
>>  3 files changed, 25 insertions(+)
>>=20
>> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spm=
i-adc5.c
>> index d57ba8526e0c..24ac84580570 100644
>> --- a/drivers/iio/adc/qcom-spmi-adc5.c
>> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
>> @@ -542,6 +542,12 @@ static const struct adc5_channels adc5_chans_pmic[A=
DC5_MAX_CHANNEL] =3D {
>>  					SCALE_HW_CALIB_DEFAULT)
>>  	[ADC5_XO_THERM_100K_PU]	=3D ADC5_CHAN_TEMP("xo_therm", 0,
>>  					SCALE_HW_CALIB_XOTHERM)
>> +	[ADC5_BAT_THERM_30K_PU]	=3D ADC5_CHAN_VOLT("bat_therm_30k_pu", 0,
>> +					SCALE_HW_CALIB_THERM_VOLT)
>> +	[ADC5_BAT_THERM_100K_PU] =3D ADC5_CHAN_VOLT("bat_therm_100k_pu", 0,
>> +					SCALE_HW_CALIB_THERM_VOLT)
>> +	[ADC5_BAT_THERM_400K_PU] =3D ADC5_CHAN_VOLT("bat_therm_400k_pu", 0,
>> +					SCALE_HW_CALIB_THERM_VOLT)
>>  	[ADC5_BAT_ID_100K_PU]	=3D ADC5_CHAN_TEMP("bat_id", 0,
>>  					SCALE_HW_CALIB_DEFAULT)
>>  	[ADC5_AMUX_THM1_100K_PU] =3D ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
>> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-v=
adc-common.c
>> index b03cf584b165..101b3c724f8d 100644
>> --- a/drivers/iio/adc/qcom-vadc-common.c
>> +++ b/drivers/iio/adc/qcom-vadc-common.c
>> @@ -309,6 +309,10 @@ static int qcom_vadc_scale_hw_calib_therm(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>>  				u16 adc_code, int *result_mdec);
>> +static int qcom_vadc_scale_hw_calib_therm_volt(
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_mV);
>>  static int qcom_vadc7_scale_hw_calib_therm(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>> @@ -333,6 +337,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
>>  static const struct qcom_adc5_scale_type scale_adc5_fn[] =3D {
>>  	[SCALE_HW_CALIB_DEFAULT] =3D {qcom_vadc_scale_hw_calib_volt},
>>  	[SCALE_HW_CALIB_THERM_100K_PULLUP] =3D {qcom_vadc_scale_hw_calib_therm=
},
>> +	[SCALE_HW_CALIB_THERM_VOLT] =3D {qcom_vadc_scale_hw_calib_therm_volt},
>>  	[SCALE_HW_CALIB_XOTHERM] =3D {qcom_vadc_scale_hw_calib_therm},
>>  	[SCALE_HW_CALIB_THERM_100K_PU_PM7] =3D {
>>  					qcom_vadc7_scale_hw_calib_therm},
>> @@ -583,6 +588,17 @@ static int qcom_vadc_scale_hw_calib_therm(
>>  				 voltage, result_mdec);
>>  }
>> =20
>> +static int qcom_vadc_scale_hw_calib_therm_volt(
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_mV)
>> +{
>> +	*result_mV =3D qcom_vadc_scale_code_voltage_factor(adc_code,
>> +				prescale, data, MICRO / MILLI);
>> +
>> +	return 0;
>> +}
>> +
>>  static int qcom_vadc_scale_hw_calib_die_temp(
>>  				const struct u32_fract *prescale,
>>  				const struct adc5_data *data,
>> diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/ii=
o/adc/qcom-vadc-common.h
>> index 3bf4c49726a7..7586016ff14d 100644
>> --- a/include/linux/iio/adc/qcom-vadc-common.h
>> +++ b/include/linux/iio/adc/qcom-vadc-common.h
>> @@ -93,6 +93,8 @@ struct vadc_linear_graph {
>>   *	voltage (uV) with hardware applied offset/slope values to adc code.
>>   * @SCALE_HW_CALIB_THERM_100K_PULLUP: Returns temperature in millidegC =
using
>>   *	lookup table. The hardware applies offset/slope to adc code.
>> + * @SCALE_HW_CALIB_THERM_VOLT: Returns voltage in mV of a temperature c=
hannel.
>> + *	The hardware applies offset/slope to adc code.
>>   * @SCALE_HW_CALIB_XOTHERM: Returns XO thermistor voltage in millidegC =
using
>>   *	100k pullup. The hardware applies offset/slope to adc code.
>>   * @SCALE_HW_CALIB_THERM_100K_PU_PM7: Returns temperature in millidegC =
using
>> @@ -114,6 +116,7 @@ enum vadc_scale_fn_type {
>>  	SCALE_PMI_CHG_TEMP,
>>  	SCALE_HW_CALIB_DEFAULT,
>>  	SCALE_HW_CALIB_THERM_100K_PULLUP,
>> +	SCALE_HW_CALIB_THERM_VOLT,
>>  	SCALE_HW_CALIB_XOTHERM,
>>  	SCALE_HW_CALIB_THERM_100K_PU_PM7,
>>  	SCALE_HW_CALIB_PMIC_THERM,
>>=20



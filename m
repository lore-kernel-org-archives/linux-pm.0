Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843833;
	b=LfhijuRcByc+lcNKzhhMidLwmr3MSuoYWaIM8v1CpfLXziJ5VMjzKJHDAbKXQuyAQgur
	 E6qndhMeTMIxHu6gsA6d3qqOvEN2zg8F2wOjyX6s9UMLl31P20qFQCGbEbD0myqufwtJY
	 PcXaOMDou6N9gJ64LlQTth7a4ig8/aYf14P07e+PZaN1brruaYA+bo5x0muBDD3JHyP7o
	 hFHxLKryXYxDMLQ0JgUMl2OPKxlnzEhND0yg8OW6r0WZB0OuyBV7Gtg+/8uHdpCMVFOkR
	 bY1vjWeax0/BdHQkml1mdk2vM/eIJTFaeg4zXdKKt7UmAQ5vT8chw8gc2YM+vdSUsLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=1bL8r5cuvqq5fGscdKSHB0SmDxdHtxTFoTFxEiXAMqo=;
	b=N0GcHVUajl3fqoFkGpnkbVQivvw0bfDtQLnN47Dhp39Z4pIM8NfwqwJvKBYnwwJHsVJy
	 bPuvk5zR3HKqFn07zgsdBUuOjXwKcLbF8lG7Io7d3a1plD79HJVetM7NWQsxSe7ATjGDS
	 Qoa6+8VKK3fqisNJUzpVLXezQzX0RzQ6k5EzJI5LWHdC6DXgrG8hufy2BeqqyvUC55H+L
	 2yCw+NKDNeknGDBGtPkuuyu7KjOoN9FHqrKsBmFKa3TTHiHqUzoMWoKw3k3jvAtD4/YIu
	 WaKAIJXXawLnoIQZQcv1y90BjLFNIqYphdRqyg8NpjtPNihQjfpLi/q6n64U9qobXwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=l5yFnpD8;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A01606A32A
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 15:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68A01606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=l5yFnpD8
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d30639709so508538266b.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 07:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794843831; x=1795448631; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1bL8r5cuvqq5fGscdKSHB0SmDxdHtxTFoTFxEiXAMqo=;
        b=l5yFnpD8es3PZ8hErhgAyB6jNHgRJQL2UrqaB+35VDA03JWtWhtFRjub4w8iKrO77e
         FcXuh9bolv6SYa88Apk3Cj+9S5ZwpsJlBdiFSEej53nktGjQ0LAsYndjgYq4DB2bD0yl
         Nyiy5scYIfhVrAS4QNSBaNJydK3icLZBN4M0F1B1L6Waj2/CbMjaV0UG6L7lgr8aVaGD
         pXTH8mr0Uek6+QgkGZxJY+7f0zkWMqOFQHSdN9vHIUiEuWSmJok/yRbEEZJRUESbTGNj
         3zjw9jYFXIMQVSV2tbewdyiO4fsAHVQXDakxoF3J1EzoW4EzlIXY/FZ/rBxt0ZFpDLkw
         9Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794843831; x=1795448631;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1bL8r5cuvqq5fGscdKSHB0SmDxdHtxTFoTFxEiXAMqo=;
        b=uscdOjY6Lq7zWzh8h/8XdvbeS6jVPxBmpNwJ4PCRP8JEGqnQOZ4hyzwbAAD0iv3et3
         +wd2IZhCBO3aoIBpkUQidl+LfCrrVedEYP3jI9Cb8FVJKfmUezet2WOnk5659q/yeYb/
         SSMpp2miPgDA1T7Dl0lCb8shnpZ7OADJrvbF9s4XrDeCc0lUtHzC2jjkEc7Ku+jsvPjj
         37+e0tXiOEI7yN4bZa/PFJ2WUe2PvJReXaLMmjKAcWyXBxa8184IFtQm7vvrwZQFeHpN
         jyITNItt/2yHpdrBegyghUZrfzl4Lp6bSGH3Ymr41RLR19F2YC5+ZGkBc14+Bx2iQ+ah
         iFTQ==
X-Forwarded-Encrypted: i=1; AL+hErHcZ32kyTLNzqKZDDB63BgkWdeCQOCL1IzWE3Pd+3Nq1jESI//gEpgoBBL7b/VTr9x/HtymsosEpQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z99MzZ707bCS9CE5/tRWHU1v/2e/JXfm+SmqkzD/ONcu5W6UNvM
	V1vOIvBkJY1actGGu/h5u3rMof7XrZdrRyq0lmFs72/7hhCLcPL9cFu6+mD8rMIWo80=
X-Gm-Gg: AYBFou0BuJ2/cHNmIp6wDRIofTt+6+OXrunErK7esq9y8e+KQCY3x4h8rNCCq6IH0r2
	4K0GkGwZ5U6Rk2zDgsqYHplhj0kZaPgDQtiYcC0HLGkwOL3QvEcdtsjXiIbvECz6E2HhVyEg99m
	gnt1ExaG2jKCjI81IOD0jCjGKkwsVGgXJf0frKraoT01M1UyuG2wW4SYWHoBGzR54b8z9udlm6t
	nJuu7dgYb4+vjYNHJFlai3sQXj28G0rVrmeylFlwn2XcWfJS/v0qNoSX2Xltb/GQyG+S0j4lbc0
	3W7P9kF+ZQWsQEcT9esBNmu8HPG0p05hcecpHjtjE+YDYWV6ZXgQBAi0hzrIAqbsD8eCufAxH8I
	95/OwbdTfZCqAeJqsYAhYHNCpQ04GNjkwYSjDXigO34npmZ+6pmO9VCKHpdiffCEnW8MOGugYud
	D6WIDa6IdF917f7sq7K6yNRAX1SIVXUsJdbYAB9486r9AI5E7a4ojDx7UwK1KdiRaOUxNZWKtLd
	Xnvtlvudkm7WApJOakhkXSuYVT6R7/ywgBRuhR5k4jCx0zR3/3W0QWhS5qE/HMjtYroUd4r6Vr5
	Bz3d6RWBxqHSNyrUeQXiXaYuewT4yksuhk+AbGaZYNYK1zkMPuUSwnYSg8DdpZVz6AfyWI/Jmg=
	=
X-Received: by 2002:a17:907:9305:b0:c2e:4e08:19ab with SMTP id a640c23a62f3a-c50963d50e5mr844840566b.16.1794843830845;
        Mon, 16 Nov 2026 07:43:50 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b40918sm439294866b.39.2026.11.16.07.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 07:43:50 -0800 (PST)
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
Date: Mon, 16 Nov 2026 16:43:49 +0100
Message-Id: <DMWR1CJJRHMF.33YRRRDXPMBDW@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba"
 <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
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
Subject: Re: [PATCH v3 1/5] iio: adc: qcom-spmi-adc5: Add battery thermal
 channels
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3-dirty
References: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
 <20261113-bat-temp-adc-v3-1-743979a8fd90@fairphone.com>
 <avc5rnvIAEmZbyE1@ashevche-desk.local>
In-Reply-To: <avc5rnvIAEmZbyE1@ashevche-desk.local>

Hi Andy,

On Fri Nov 13, 2026 at 5:24 PM CET, Andy Shevchenko wrote:
> On Fri, Nov 13, 2026 at 04:56:42PM +0100, Luca Weiss wrote:
>> Add the BAT_THERM channels with millivolt as output, which can then be
>> used along with information regarding the NTC in the battery, to get the
>> actual battery temperature.
>>=20
>> A static lookup table in the ADC driver won't work since different
>> devices have different Ohm and Beta values in their battery NTCs, for
>> example a NTC can be 10kOhm & B=3D3435K.
>
> ...
>
>> +static int qcom_vadc_scale_hw_calib_therm_volt(
>
> This is broken indentation. Was `clang-format` being used to achieve that=
?

This is how the rest of the file is formatted, I didn't deviate from
that.

>
>> +				const struct u32_fract *prescale,
>> +				const struct adc5_data *data,
>> +				u16 adc_code, int *result_uv)
>
> result_uV

As Sashiko pointed out, this is labelled wrong, the result is millivolt.

The rest of the driver consistently uses "mv" for that, should I deviate
and use result_mV?

>
>> +{
>> +	*result_uv =3D qcom_vadc_scale_code_voltage_factor(adc_code,
>> +				prescale, data, 1000);
>
> 1000 is odd, can you use something from units.h or combination of those
> to show what this multiplier is for?

This is converting microvolt to millivolt.

Shall I use "(MICRO / MILLI)" as used in plenty other drivers? Two
drivers in the tree also have "#define MILLI_TO_MICRO 1000"

Regards
Luca

>
>> +	return 0;
>> +}



Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC3D366560
	for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771920902; cv=none; b=drcULLqoxk1l2pSCfV/OP5W+w/ipTnDfPi/vQ/cl4vDulBL+OCGjlt8fKDm3moDBfY1KATr8G+7X4+M8M63qddGIQ8ZVzRkYtK7epYOw+ikqqeZtpGfL+B3SlfUzLRez50oECa7AmNQlLaDr1IAhVCkE0TLglJPWR9IgFfWQhi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771920902; c=relaxed/simple;
	bh=9BNqf2MxT2KB9V3RmWVoDEyDdtAfYIbH0M7+sdJqyF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=QDAUNQr0+aoeIw0zI9olsrAq2TOz9VLHNNm0KjX7wRwHuBqLfmSx/BbwMVtZku9aBndMsPUMYROM0Onp00wzM/9kYp5MaiTduP8335UsdQBuQXc8Cv84U5a878wLh+0sgNayV2FqlR+HWW/pk+0A21z+Vte/dInf3lX39iW9HMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=e/PLKYYK; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="e/PLKYYK"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-65c20dc9577so9712914a12.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Feb 2026 00:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1771920899; x=1772525699; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKXXJGWnu9K3xWMW9HyaDVo1/D1y/DKuzi9/eiBk4qI=;
        b=e/PLKYYKTVwvOJC59T6f+2vp9KK35XkixfJUCi8jTKZP0yiHMyS6pfcomFjzHxfpbQ
         knxi8XFrWlEjfuXlgFAvgTkKZBq4gWLEfJMZD4+jfhKoN2q4G/bj9slSFvButfSgrN9Y
         YsNAVtK/Dq7GCFsgV7LuF1IlOrVmsv97R4MrP6FPstwdbxKns0TovrENx8qlxgrGl0fu
         UzJdPC0FT9ESwfqQ4Cog01EcdUEfyXd7qaWKbRYmgvymrA3s1U1XmEO6/OGrzUZxdfBo
         W3pqi3H33scQHyOm6TBC0uE/8w1ehNpixQ5vjnb4NXm8cRabSWM7CaxS+RUe3/3aVBCx
         xUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771920899; x=1772525699;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKXXJGWnu9K3xWMW9HyaDVo1/D1y/DKuzi9/eiBk4qI=;
        b=gSIr6BDiMmf4uOjD3MfiCNXSSRMndSTJyAiYibJkMC5yrXTXQYlivqr361IFKTAsf8
         RUUCXsDryBr5gFwUcxq5wUeQx0yvdIqZIG5ymmEbJelC4F+fqtm+Sjx3sPc0A38s12HJ
         m5lhm/wNxaw347UE6nqzr8/d6qTsvoaXfq/NjLOG4X9OY+XoRvOFgYL3SMFdcmsVvisE
         mnl0KQdpN2u/cEct/8uxz5IOesobcCx0pmlY3TMRN57O2KNiM5tXBnD++LkUnAJ3WtuZ
         yvVzg0lQOa3SUYQs5YkCBIyarFzYIuuL3RbEnQjnPBkJVA9KXJcbIuapWrCwq6g2fMEc
         Zp+g==
X-Forwarded-Encrypted: i=1; AJvYcCUZesPH6/3WDVNtzi0l4RDtTBlHW1vVuR9yZp5A0t6LZ7K2wkl//TGNK/4UVZ8M9EBvkwGGrumJcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpUwAgbBouYkR7OE1cUxUwe6Eis6AXO0gHvOt/kSfoZZNBPkB3
	9mUK2pNYKoe5poPLewshEfsBBYZN8M4DLn8COAFLCfPzvCW0Etdo4kvkQyOyLGpBPz0=
X-Gm-Gg: AZuq6aK7h/akexJB0F6edp5zmkQnY19ZsowFm6jV8i80Uh331SgudeXZKpriGKxCpYq
	205qZ446BCLiLva5OtvGQBaWTx7HVedKueUMJYqarovNK4vE7Dt2xgnvqZbIlvK3QHzzD6BL5C7
	hjb9H8azMku07oOJHUUzdkcVtvjaM0ylvb8BDIQfJsPMD8PruRHd87UFUbrR41EkBTbcIwgMAJY
	c2cTpjGCAMTVjIdYkJX6Ryyn/JKDTfnDd3gRN4cZYsNA0yOnpoCdx7G9jwalYMEZnul3eQWjGbh
	V3MX7Kq4p0RA8CjMvCUOqBCWRMIKzteknMVUYEteTfwZspb1lVOaLOaVJTUSVSJSj2CzhwQP4Zp
	sgL7PuZuuTi0taoLxovglMEPZhP6kgVQMt6L3QhsPPMmxRhuA1FO5YkgoMXLJwO3wOtOXfB4bSw
	U5TIjj4jEIGKUTKfxOXJoGkScc+iDOaeclvxiz+/FFnLcB3txp/ACaexT1tp9azY+KvUc6LgAr/
	XaY4pI=
X-Received: by 2002:a17:907:e0d8:b0:b88:5957:2d65 with SMTP id a640c23a62f3a-b9081b40c12mr380726366b.37.1771920899412;
        Tue, 24 Feb 2026 00:14:59 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084e4bfe6sm399567166b.44.2026.02.24.00.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 00:14:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Feb 2026 09:14:58 +0100
Message-Id: <DGN1JB8J9YG5.JZDBJ9WBLDXC@fairphone.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: thermal: generic-adc: Document
 #io-channel-cells
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Rob Herring" <robh@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Laxman Dewangan" <ldewangan@nvidia.com>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Hans de
 Goede" <hansg@kernel.org>, "Jens Reidel" <adrian@mainlining.org>, "Casey
 Connolly" <casey.connolly@linaro.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com>
 <20260220-bat-temp-adc-v2-2-fe34ed4ea851@fairphone.com>
 <20260223184815.GA144001-robh@kernel.org>
In-Reply-To: <20260223184815.GA144001-robh@kernel.org>

On Mon Feb 23, 2026 at 7:48 PM CET, Rob Herring wrote:
> On Fri, Feb 20, 2026 at 10:19:06AM +0100, Luca Weiss wrote:
>> Document the property to allow using this sensor with io-channels.
>
> Why? On the surface, it looks like you are adding a provider property to=
=20
> a consumer. Maybe that's right?=20

Correct, commit 3762f5851ac5a65dcccadf73dbe853b1b346f561
("thermal/drivers/thermal-generic-adc: Add temperature sensor channel")
added support for this in the driver, this documents the dt parts of it.

Regards
Luca

>
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml | 4 =
++++
>>  1 file changed, 4 insertions(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/thermal/generic-adc-therm=
al.yaml b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yam=
l
>> index 12e6418dc24d..317fc39ed46a 100644
>> --- a/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>> +++ b/Documentation/devicetree/bindings/thermal/generic-adc-thermal.yaml
>> @@ -24,6 +24,9 @@ properties:
>>    '#thermal-sensor-cells':
>>      const: 0
>> =20
>> +  "#io-channel-cells":
>> +    const: 0
>> +
>>    io-channels:
>>      maxItems: 1
>> =20
>> @@ -58,6 +61,7 @@ examples:
>>      thermal-sensor {
>>          compatible =3D "generic-adc-thermal";
>>          #thermal-sensor-cells =3D <0>;
>> +        #io-channel-cells =3D <0>;
>>          io-channels =3D <&ads1015 1>;
>>          io-channel-names =3D "sensor-channel";
>>          temperature-lookup-table =3D <
>>=20
>> --=20
>> 2.53.0
>>=20


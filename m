Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.72.192.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794656377;
	b=Zgb2yAC+fICBT1LwIqcbj8r0aU4SX2jL9zRDqCfeNKGtV9MmOap2asWFIb5JefGtZjO+
	 8X2LvleokRRkrSyywUVcOj8wft7zFapjkGrKNLaDDmlrS9e9BUNjzWsExZuccrJKXDBn8
	 XzbgUlx7JGww//BQ2bGYr67DgCKuS9p8+VMlxftIF0bZYHz/PML+tK+e4eLdu22RLh3FF
	 K0ypIN+kaI4DfUGXU60n1B7VOOHhRm098vCTuFJZq2A5kwsO/dtXm0EXQh+M1ULQ8ovzj
	 vizfOpR1a2IPLkTZm7H1huLY2qb40UTpLEPLQxlDaITSC1k5d4VFN6KAA4I7k5Dy0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794656377;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:To:
	 Cc:References:Subject:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=1rGoSOFouhQSZNi4fjMl797dAvkOec2L+glDBb0X6/0=;
	b=aTSdt7yk6xJLlVrrAnqnmQXAFva6zhKNj2ixPF/8R6vtuBxEzqS0h2CuQMkUvYd8N1QT
	 XQG2LvoFfZVVJD41QRAuC8sRbBtrreAVcMGXq5zIzYy/qxFt9C6605HoOjmIC+AtaKGvj
	 RXC5wjJ3/vNhSwMqsBvvSi4JHL16TjxOec5owe3y2vC9ExqDjMCA3Oea16PxPbwADoaRE
	 AUlxhH/DB3BOuw5bVtGacBKZGKpJ6wkx6xQHWviUv8NVjL1ETqk1C8s5BlDG0ARSJ7VWz
	 y2G+COExmFiCJ4xg0ggTvU44t26tVAP1KkedDQVIxvxIMnAxC/gBU1euF7m0vWQaJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ehWud5zv;
	arc=none smtp.remote-ip=217.72.192.78
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DC606A33E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C5DC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ehWud5zv
DKIM2-Signature:  i=1; m=1; t=1794656373;
 mf=PE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4=;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=web.de;
 s=s29768273:rsa-sha256:fOs4M4Xou0HAhya0sngNAnPfpU4r
   3hJcOWRRSxQcRpeHWRNmpsHVsemc//FTNZJ18Y0ezWB0eLoYQWh+ds0bsVIhJCY8BCE/ZTVE5Y0
   75jV4Q/sUcPYRIH+bj07b9gdMvRXOQDuOItOGiuaDIeOAmPToDPaAmSdFIllx+NOJ0YSJ1Dg9JJ
   +gIKwsNPiajd32gCYTYd+JNPpFvWRgswmZ1ieMXkuEga+gqn3MVqhfQxjX9oC2ok/gqat1+ez9K
   ymh1SlxBANZQ/TMIT20LG29ADxgWrNd2x7R8YPG26ge2mxinm3YVB5kgULd5atYwVQWfUAdNCzH
   6T48w86ZrMoGjw==;
Message-Instance:  m=1;
 h=sha256:
   zdHAUM5FRJIeSR5sWhjGOntbco54acETBERhA7AiYqU=:
   cuyZn7ZahTNzUMhIuL3lGQQijBL76zQXFuKU4QQQtas=,
  sha512:
   uPh2vEx0rLQVsZKw4TP0aZffX8w0ZZAvf5AaFqNYd0AWI7AcCCh/7EForHh4NbDMScJKGUp1Mb3P5T0gzGmNFA==:
   BaCxS+DpnDZwaIi48tdjHQarvZGVUFM3O8eSZO/HO/2ARD3dKEiY85IPrQLeWE49iTqBe1NMT/PuoMRd42YNAA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794656356; x=1795261156; i=markus.elfring@web.de;
	bh=1rGoSOFouhQSZNi4fjMl797dAvkOec2L+glDBb0X6/0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ehWud5zvAQe3MlIk/DI3vvMAs2HDu/Ruulpn9ngB1zB6Kflq6fub5HFbCxWdcvmm
	 jKTHWuStBZ+GGHtHrRjzhcmAvDTcVkXoOwLFCktarWk3BnXV7idHUAXYSkqdK90pl
	 Kd77JoDQBOUCAy1UF/yoc7SSVI2nxjq8N++iHzchN6NWHg6FewhXcP41S80oHUrFb
	 uLzkXpItnoM+3sw694UFzZg0tiln3N0jwZucNPes4+oRHy/zdyukV33IlqVF4MwCk
	 cNvzkVAVw2hKFaaiYzuKAL25qsDwG6saH7DTL8w728udHu+YcuNiK5PrVX8lBfZY1
	 IhySl31rCjHWef0W2Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWor-1wpa231Ah9-00lMe5; Sat, 14
 Nov 2026 12:39:16 +0100
Message-ID: <0f715d51-1d85-4126-8cb4-7f60e5f84975@web.de>
Date: Sat, 14 Nov 2026 12:39:01 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Adrian Nguyen <thenguyen1024@gmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Casey Connolly <casey.connolly@linaro.org>
References: <20261114112155.85068-3-thenguyen1024@gmail.com>
Subject: Re: [PATCH v3 2/2] power: supply: Add Qualcomm SMB1351 charger driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20261114112155.85068-3-thenguyen1024@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9zYkuzsMpY5pPIYTs1FsCfMZikB8p/w331GWnPvUAzbNOAtmUEL
 5yzXpsWyzydu4ibspe6AyAgq6rv7lG7ffv/TfS7jrXRkCz1SigLj34j1ITUoxzzcBb/sxB3
 k0fdkbYxED9JalyG3887N1jVuo8/4cd07POaKp5ugyqux0PlAgstCLwSb1/NNBEHzBmEbx6
 QNTiAIcfvfrHPmgzF/irA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nA5A5sNZ6B8=;V31XhEegMAsSA+cFi9yrMbAIIPG
 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
 YXecLxHk0GNcpmcAZqetGjFUAjnepX2z0I

=E2=80=A6
> +++ b/drivers/power/supply/qcom_smb1351.c
> @@ -0,0 +1,439 @@
=E2=80=A6
> +static void smb1351_external_power_changed(struct power_supply *psy)
> +{
=E2=80=A6
> +	spin_lock(&chip->lock);
> +	WRITE_ONCE(chip->retry_until,
> +		   jiffies + msecs_to_jiffies(SMB1351_SETTLE_MS +
> +					      SMB1351_RETRY_TIMEOUT_MS));
> +	mod_delayed_work(system_freezable_wq, &chip->work,
> +			 msecs_to_jiffies(SMB1351_SETTLE_MS));
> +	spin_unlock(&chip->lock);
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock)(&chip->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v7.3.1/source/include/linux/spinlock.h#L6=
10-L612

Regards,
Markus

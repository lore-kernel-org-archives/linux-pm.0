Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531768;
	b=y16pTUm+k9mrZ8fI1YBr8BfQw0rjQbNizDe5S8SznR9IdStfK/Z0j0FxsfryfkhvbfOX
	 hd8OTCb3KZGzsWl5Pleej9r8ilRQSBI2aaVDBFPwggNvk8FTiAZnunOdx1T15uMHksqfZ
	 F6aycYf8WwpmKYbZgQIsirc1cvlwN/SSMKUILZ2kk1hdZ7SJW63hCNNOC842Mo90cXphu
	 0SPIKR7bGoRfd0NzRB9uKvF/Lqv+I+CIlcnQtbaCKUVK0xHcyUbtkVxb7YLTXOLkzj0zM
	 Lftmp8kzSLo8Fy1aDzHMB33iwcv0paUkOVN5f/DVZBmfuReWknQ4qaDuWY85r8OURqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531768;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XtdvEuKeodVtDzB/4eB7y3ob7xjJavFKFolqpUylUuw=;
	b=NoCFMZANJWqMMMBZdWdld/uszKsYCkf7egGf5n8no73KVzUgk73TnZ5gBWZ0cZL+vdPk
	 O2NpgglZTygl3FzY3DcdaFt4JVPTsFiVOJU21QCzr7Do8rDZpjju7rhm1D4asyUFpCKPG
	 bOk94m0Nxe1JxFrUBV/UDF6kodsSnVA5yZO0lv4GCb2B/9qTvV6k2NEp4lawloeJ8i2Kw
	 ljx0YdaDK5EfC1oDIvH7T7uAEQ1IywxFaWuzrnaMsdBwwWeEQwG1xVAi4/GCBjASnll95
	 jLylEZRFmxJUkK7MXJfuWobcN99Pt6QTUEk6xfsdz22J4t9vRbPoB9jLC1A+wofaYRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDzEvUBg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11677606A321;
	Fri, 13 Nov 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GDzEvUBg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571401F000C4;
	Fri, 13 Nov 2026 01:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531767;
	bh=XtdvEuKeodVtDzB/4eB7y3ob7xjJavFKFolqpUylUuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GDzEvUBgEaXspkMbc8RJurxMEtNcNXNP3ZhLD8NspGvjCK170O6+6/OE906oznxfp
	 /e1QXDWJWqiNoNDswojpBvF5ZneDETXry7uFiwQjkWBj/tqkQEMx6ePPqqtMQgZQnn
	 8Bm4cBFQbNSHPwyu7DPqTKj3iAm9LMojB7uDkVah03unCyC7fADNS52ZrnBa8egoQD
	 HpAoKP7YL3UYgg9d7PK2do2rcYXOgOTlvcXQjRsp5HorisJ8oCVumcnNHOz1dL2Hms
	 JLU91DZv/ZA/q7higagnsST7WfFrv+SNpGZRqGTtVsmfaeQdgG8in+bzqtY2mZgmtl
	 abBa6blFIeLVQ==
Date: Fri, 13 Nov 2026 01:02:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Val Packett <val@packett.cool>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Marc Lainez
 <marc.lainez@gmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: adc: qcom-spmi-adc5: Add
 ADC5_BAT_THERM_100K_PU
Message-ID: <20261113010238.17b371c8@jic23-hlaptop>
In-Reply-To: <20261112170841.2189322-4-val@packett.cool>
References: <20261112170841.2189322-1-val@packett.cool>
	<20261112170841.2189322-4-val@packett.cool>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 14:07:29 -0300
Val Packett <val@packett.cool> wrote:

> Even though it existed in bindings for the longest time,
> ADC5_BAT_THERM_100K_PU was never assigned in the driver. Do so.
> 
> Signed-off-by: Val Packett <val@packett.cool>
> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index d57ba8526e0c..c27ff89429f5 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -542,6 +542,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
>  					SCALE_HW_CALIB_XOTHERM)
> +	[ADC5_BAT_THERM_100K_PU]	= ADC5_CHAN_TEMP("bat_therm", 0,
> +					SCALE_HW_CALIB_THERM_100K_PULLUP)
Whilst alignment isn't exactly consistent, this should probably match
the one two down that has same number of chars in the _PU] bit.
So use a space rather than a tab.

Otherwise seems fine to me.

>  	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795295338;
	b=nnhHUadNRxlsox+jwho7wHZjPLGgWdEo+v9sUVpXnh2x6IULe8fCc0+rujpTSD3567Ax
	 Zeguz9i4CTpgX+x1ymMfV2wbK0VbnLjneMAT/THfROC2RmmfFJaHXAWsLi8KDf/vkLhrj
	 W51hSfb6HQ3I2n3FZES2OJhiZnDrGH64Z15ht8MEChx5v77tFo9vzgpcWn6Q5WaECFcDf
	 fSHo/ZO+lTDLcEbYFXg70rdXjTBHYN9lLL0BYKYZrpeWX5XtTvrF2y9qHOksv+G6HmlOV
	 ECoaxlXdEcHZy310PCNbt6U3HH/XzqQjg11wGfyX3Y/T0TYgb/8m1mvMLFZyxDA8HUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795295338;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J8c2sc9pHyGkMH12X1dKW2Db+m7WpKDYGFFOvD1bnfM=;
	b=gw+c2BY8Juxu46iHmDJ6csxF9XEEaYQbLur9ZD/ddbeH1vRUcLXTnje50Yp8vIO+rTb3
	 0mqRCdBrW30HhOFwF2Mr46a3eojGkw9lg7AjvkqtBk/2CnJcTuuGXaefLRhhVq1ng9Yjx
	 uYbfbd4F+a7h2apWwLD31uS1ZFW0bTfxI7URphqZoIczERIri21+ESv0EnJQyt+k3aWvD
	 DsgirQXTstDxuxRgFxauAeeqtfAKVHTFb3vb4b1+HRjYNrbcnAD3AgUHFyG6S26vXpGIG
	 ULZOUWBB09Nq0Me+jpPyMgytF/BiZE6soIOubozw87lND+bzIdp9FsthdcSq4YQVUdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1c50uxe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9B2606A320;
	Sat, 21 Nov 2026 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1c50uxe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187481F000C0;
	Sat, 21 Nov 2026 21:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795295338;
	bh=J8c2sc9pHyGkMH12X1dKW2Db+m7WpKDYGFFOvD1bnfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A1c50uxe9q2n/EXWdWf11CJGRgpdzw6KkLEYdFyJvl8P9Bl/rnZQSPLVGlmYH1h2O
	 /IeHdNcptRndL0+A7ne7l9L17nS8eqBkCENUICZJk4QwVS8WPEb0T0o2wCNvERuA92
	 dmFyZQq1QKdjIuWR9HEDBfwTR+TNcIPGH66qIp87I6DQ1a/DGx+qpCQgwO10/RaAte
	 zX6El0vnu4fRBp92kwVqwlAHfDQ4EAE7Pj7Q/Fgj6TyugpbdQtCKNzut4QNN9JZQu1
	 HpTZupP59iPwR7lJqcCs+fykHI+So8uFfdJWXGV+2uU1k2NoCNxGDT0JHCFLwvIVHp
	 wNzcYaF4N97rA==
Date: Sat, 21 Nov 2026 21:08:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Manaf Meethalavalappu Pallikunhi
 <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain
 <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH v2 5/7] iio: adc: qcom-spmi-adc5-gen3: Remove Gen3
 virtual channel macros
Message-ID: <20261121210852.67e2d4ed@jic23-hlaptop>
In-Reply-To: <20261120-pmic5_gen4_adc-v2-5-94d0e1fd6847@oss.qualcomm.com>
References: <20261120-pmic5_gen4_adc-v2-0-94d0e1fd6847@oss.qualcomm.com>
	<20261120-pmic5_gen4_adc-v2-5-94d0e1fd6847@oss.qualcomm.com>
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

On Fri, 20 Nov 2026 14:49:45 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> Now that the Gen3 virtual channel macros have been replaced with Gen4
> macros in both main IIO ADC driver and auxiliary ADC_TM driver, remove
> the Gen3 macros as they are no longer used.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Ah. Ok.  I missed this was coming.

Perhaps modifying these to align in earlier patches is to much
pain given you are going to delete them.

Ignore those comments.

Thanks,

Jonathan

> ---
>  include/linux/iio/adc/qcom-adc5-gen3-common.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> index fa7e08d67f26..105b0766a01f 100644
> --- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
> +++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
> @@ -40,7 +40,6 @@
>  #define ADC5_GEN3_CONV_ERR_CLR_REQ		BIT(0)
>  
>  #define ADC5_GEN3_SID				0x4f
> -#define ADC5_GEN3_SID_MASK			GENMASK(3, 0)
>  #define ADC5_GEN4_SID_MASK			GENMASK(4, 0)
>  #define ADC5_GEN4_BUS_INDEX_MASK		GENMASK(6, 5)
>  
> @@ -78,10 +77,6 @@
>  #define ADC5_GEN3_CONV_REQ			0xe5
>  #define ADC5_GEN3_CONV_REQ_REQ			BIT(0)
>  
> -#define ADC5_GEN3_VIRTUAL_SID_MASK		GENMASK(15, 8)
> -#define ADC5_GEN3_CHANNEL_MASK			GENMASK(7, 0)
> -#define ADC5_GEN3_V_CHAN(x)		\
> -	(FIELD_PREP(ADC5_GEN3_VIRTUAL_SID_MASK, (x).sid) | (x).channel)
>  #define ADC5_GEN4_V_CHAN_BUS_INDEX_MASK		GENMASK(14, 13)
>  #define ADC5_GEN4_V_CHAN_SID_MASK		GENMASK(12, 8)
>  #define ADC5_GEN4_V_CHAN_CHANNEL_MASK		GENMASK(7, 0)
> 


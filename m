Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958213F660F;
	Wed, 27 May 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779881404; cv=none; b=pWVovkVC9bs1B/ova+jwqZdHaEOEWHcpxwtrj2ADoZV3A/ixkmh3CMTVQYCMumw1pZ+r3AbgTCS4HuS05ETjVUfnEQq/RfddeBRbziCFnmY1zRTqgdvs1Q1EquLP8WR12VdcW/b5iw6bvbue1KQht/jsPOWO+ZtG8w1WqgSjRyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779881404; c=relaxed/simple;
	bh=D2CjoMYN/O2WbIBZeAWJTXIKVOlzIG/teNYq7DyyJLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eey3Qc0TafG11BXO69SrDZlOQEeHyR1whOj5z1vU4QUOElokRF/H99bppjSDvvDL/tY20ZPx4McEDVWOrKf1hFXJgiyW0Hb6V49EhhzlUAH2D9ltVqkBiNCn6eeoqe/w5Z/Xnzzmjr2RgToy2gizlDS4U3uDspcmwldio7A4GXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJk2I2PG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJk2I2PG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01671F000E9;
	Wed, 27 May 2026 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779881396;
	bh=DQAtjETM07/dIQJIcWrm1yE3zDyM8hO9BdhStRUIMss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fJk2I2PGPRZLrU2kEBnBjxW+Zh/4xEjzV2VBdZwWgY5EwXt8ov8zErMN/JG3RZw/s
	 C1hxQrBuWqnXWVU28siimKU/sFLpgv00FNjjhLm3sD6WNYkRB2rAQrzTQTXjgyNz3C
	 6Srhg8voTwoS3VdF8lEWCQH2mjjpzBljr2dfgxeqmQg3gyUDwNwKbY/qCYzu8gOFm6
	 /byWyVOdDY53atsW9JF9/rYaQVRghxDovTAkz0mcudTCmSWl9EaA0CZcW1ywmEboGH
	 Q7DH/wKAgeVssM0ESnc09OvjCKQc8biYaJBP9aFRaHah0MBg+Zl3Dna6q5RXXO1e7B
	 uD1ZVispQt5Ig==
Date: Wed, 27 May 2026 12:29:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Amit Kucheria
 <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, David Collins
 <david.collins@oss.qualcomm.com>, Anjelique Melendez
 <anjelique.melendez@oss.qualcomm.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH v2 1/2] iio: adc: qcom-spmi-adc5-gen3: Share SDAM0 IRQ
 with ADC_TM auxiliary driver
Message-ID: <20260527122945.2bd99d3d@jic23-huawei>
In-Reply-To: <20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
References: <20260526-gen3_adc_tm-v2-0-702fbac919ac@oss.qualcomm.com>
	<20260526-gen3_adc_tm-v2-1-702fbac919ac@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 16:26:09 +0530
Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:

> The SDAM0 IRQ can be triggered for both EOC (end of conversion) events for
> immediate ADC reads done in this driver and for threshold violation events,
> based on ADC_TM thresholds configured from the auxiliary ADC_TM driver on
> TM channels on the first SDAM.
> 
> At present, this interrupt is handled only in the ISR in the main ADC driver.
> When the ISR is triggered for an ADC_TM event, this driver notifies the ADC_TM
> driver by calling a notifier callback exposed from it for this purpose.
> 
> To simplify the interrupt handling in both drivers, share the interrupt between
> the drivers. With this, ADC_TM interrupts on SDAM0 will be handled directly in
> the ADC_TM driver, so remove the notifier callback and all TM interrupt
> handling in the main ADC ISR.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
One trivial thing inline if you are respinning. Not worth the bother
for just this.

Reviewed-by: Jonathan Cameron <jic23@kernel.org>


>  static int adc5_gen3_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -817,10 +781,18 @@ static int adc5_gen3_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  	}
>  
> -	ret = devm_request_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
> -			       adc5_gen3_isr, 0,
> -			       adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
> -			       adc);
> +	/*
> +	 * This interrupt is shared with the ADC_TM auxiliary driver, which
> +	 * is threaded and uses IRQF_ONESHOT. Since shared interrupts need
> +	 * to agree on IRQF_ONESHOT configuration and there is a kernel
> +	 * warning for using IRQF_ONESHOT with non-threaded interrupts,
> +	 * make this also a threaded IRQ.
> +	 */
> +

If spinning again, drop this blank line.  That will make it even more obvious
the comment is talking about the line that immediately follows.

> +	ret = devm_request_threaded_irq(dev, adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq,
> +					NULL, adc5_gen3_isr, IRQF_ONESHOT | IRQF_SHARED,
> +					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
> +					adc);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to request SDAM%d irq\n",


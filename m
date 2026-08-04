Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A03546C2;
	Tue,  4 Aug 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785831631; cv=none; b=Q69n1e/pHDP1yF4+wKFlGrMn8EXcSFAiBqFYg6lX0u7mBgM6z+x0XVaiyZw5MyA1QFTfvrUjpgI3SdFcx3Z9QvX9KNMsOJhg+jrygkMkgpWGQOI7L2HL+MrZ5e3KQ9mmTjbWvJP5qgJtcVG9U1/xHH3rkXSN6ovjer5O/lGmBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785831631; c=relaxed/simple;
	bh=uMyvUdU4ThXE8jcdAR6oaEHWSbN0mhwoasyqRIwVz7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRipGkXPUJobOySipRbKlAZrLPJaVx6zxsW2hMp6O8B4YzpcFhQfpY7jb/NgSz9yYdmMnnLh7U7d8oUoT+Oz+d9r5h3G/RUslmcZ9RVXWgcLxVmyeF+mFKBNguLDivmK/vxpCcraC5zigjRnGiG98lkEewyy1Zaeh2BPbd7b+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeMfAHdB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeMfAHdB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF211F000E9;
	Tue,  4 Aug 2026 08:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785831628;
	bh=ErN/rXvd8AZnHQ1jQfyz1IaQg+OYv8k/6ZjCX+2Q/q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AeMfAHdBM8vG705UAGj+BI2fvN+YxIaEBL4QjctWMGWJFWCK+9nPWAY3/0DZ38Qb5
	 KIgoQe7GFu19XofItavn71lrraMuz/soT7F5qDeIrXfLUOAm9MJ62VkKXO1+vvdj1E
	 CQF0NvWU4nMtREV7pck595RHKwI2NNo/w5koXw1gO6F/NSWBWXBjv2VjrmtStLufv7
	 frzZGwMeh9zTBKJ68Er77iHhE+zVfyE9yvtsF5Q9ZSO0izLlRsWv6+a9uHrRqlkbu6
	 V9m51jNqxo+YvK5kJEQ+LDAsBAz9hoT428HmrH7FQzIOmS/NMbdvmSQ5C32zEKl5j3
	 hp6vp0rjLKtbw==
Date: Tue, 4 Aug 2026 10:20:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>, Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>, 
	Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>, Priyansh Jain <priyansh.jain@oss.qualcomm.com>
Subject: Re: [PATCH 1/7] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen4 ADC
Message-ID: <20260804-marvellous-crayfish-of-recreation-d06401@quoll>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731-pmic5_gen4_adc-v1-1-9c49b2eea6f9@oss.qualcomm.com>

On Fri, Jul 31, 2026 at 11:36:14PM +0530, Jishnu Prakash wrote:
> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made for
> improved performance, mostly at the hardware level. The main differences are
> increased ratiometric conversion resolution (from 14 bits to 16 bits) and
> increased bit field width for PMIC SID (to allow communication with an
> increased number of PMICs, supported on latest SoCs).
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> ---
>  .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml      | 47 +++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> index 149f4af8f4b8..e79ddc2acca0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
> @@ -21,9 +21,14 @@ description: |
>    All boards using a particular (SOC + master PMIC) combination will have the
>    same number of ADC SDAMs supported on that PMIC.
>  
> +  PMIC5 Gen4 ADC is similar to Gen3 ADC, with some differences such as
> +  improved ratiometric conversion resolution.
> +
>  properties:
>    compatible:
> -    const: qcom,spmi-adc5-gen3
> +    enum:
> +      - qcom,spmi-adc5-gen3
> +      - qcom,spmi-adc5-gen4
>  
>    reg:
>      items:
> @@ -83,6 +88,46 @@ patternProperties:
>            This property indicates ADC_TM monitoring is done on this channel.
>          type: boolean
>  
> +      qcom,adc5-gen4:
> +        description:
> +          Indicates channel is of type ADC5 Gen4. This may be needed in cases where the
> +          master PMIC has an ADC peripheral of type Gen3, but some of the other PMICs it
> +          communicates with have ADC peripherals of type Gen4, so channels of those PMICs
> +          need to be marked as Gen4 to ensure their conversions are handled correctly.
> +        type: boolean

It is implied by the compatibles, in this case the peripheral
compatible.

Best regards,
Krzysztof


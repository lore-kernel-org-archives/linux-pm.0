Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E73C3F54;
	Fri, 11 Sep 2026 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114910; cv=none; b=HiRwlyrSDXct6AKcfkJk9ucKxpwksuFBT/xMiKXMe++zjTlLV4ZYTQIMZl0DTIn8HV5UvrVYMWI1t6qOaSHOtKxeXxEKcXqg45fmIFOX5lh1JU9lwTK30bv2nqGaefLXFUaT6adDEYVR+z2ltKJ0ZndQ0yE3etchXr9hiFnjThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114910; c=relaxed/simple;
	bh=I7Wtm7R5ZGEuoDWBz+Xq9tjT9BOjSIEeGqIKgLrRXDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg7SYVgefBjcQ8x+ozwboBFXlfLVlZ19V1uwE6nRfp4NWSDEG3wzXdHLQGiOqMFFP3FYGOMxwIZhNRBKyWDrKE9vDTNRdfOIQnG+kForEXtln33/6Ap7xQssn1+6/OUNshCtw458CvlC7FrWFacDKPXF6n8qggB8aZNzfVc+il8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXnTtUhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXnTtUhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A991F000FF;
	Fri, 11 Sep 2026 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114908;
	bh=GwallcFnJu4VLydxLqAyF7G8wPgumOS0kpA5YnMvJwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OXnTtUhjKDCePykh8oY7m1CxTBVnclPCSRg6kz4wLV16c8IE+HdBtXBWqpMyM3r3V
	 kDkHu+Hv5BlFdQNuFxidiCnXnVBLhEv4t/7Q6WyR34IodImJvSBIRlDgyiOiDBjl4B
	 0jHVZQxxfF78YkQS0MN79q86hz0kAtsTictw8Yu4lDFzTUYuptWcYaNVB/Fd8cPgoL
	 DH8PtJN522saM6q2M59a9XfJyOuHCsRNL0KhS+Shh/wwjHvocYsX4vZnYBnhnUufum
	 AazUx22DiOvhsGKi2pMYff5o/ebHmFurppXuQtkDt65FRI8aZ85qX2pTkzIvVQpw4h
	 XNQAQHkhrr+nw==
Date: Fri, 11 Sep 2026 10:21:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	David Heidelberg <david@ixit.cz>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, "Andrew F . Davis" <afd@ti.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm845-oneplus: use generic
 fuel gauge compatible
Message-ID: <20260911-relaxed-dexterous-hummingbird-72dfbe@quoll>
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-4-rinat.muhamedgaliev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909234744.1177153-4-rinat.muhamedgaliev@gmail.com>

On Thu, Sep 10, 2026 at 02:47:44AM +0300, Rinat Muhamedgaliev wrote:
> OnePlus 6 and OnePlus 6T battery packs may contain either a TI
> bq27411 or bq27541 fuel gauge. Use the generic ti,bq27xxx compatible
> so the driver can select the register map from DeviceType at probe
> time.
> 
> Tested on OnePlus 6T (fajita) with a bq27541 (DeviceType 0x0541):
> after booting the new kernel, the battery reported 4.360 V, 100% state
> of charge, 27.8 C, and Full status.
> 
> Fixes: 12dfb002ca01 ("arm64: dts: qcom: sdm845-oneplus-*: add fuel gauge")

What is the bug here? Your commit msg should be specific about it.

> 
> Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi   | 4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts | 2 +-
>  arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dts    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> index 948a0dd..8c5cd94 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
> @@ -790,8 +790,8 @@ &i2c10 {
>  	status = "okay";
>  	clock-frequency = <100000>;
>  
> -	bq27441_fg: bq27441-battery@55 {
> -		compatible = "ti,bq27411";
> +	bq27xxx_fg: fuel-gauge@55 {
> +		compatible = "ti,bq27xxx";

And this is just breaking all users without any explanation.



>  		status = "okay";
>  		reg = <0x55>;
>  	};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> index 5f01115..cf40842 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dts
> @@ -44,7 +44,7 @@ main_cam_ois: main-cam-ois-regulator {
>  	};
>  };
>  
> -&bq27441_fg {
> +&bq27xxx_fg {

No, irrelevant to the supposed bug here.

Best regards,
Krzysztof


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7083A5989;
	Wed, 10 Jun 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082282; cv=none; b=D5PDZg7OYnShU6ppsGNGcbUf+kGESupl9JSUytNIXU+3dF4P7QWdUXS9ixtp8RaUh6eEZpfAwHBaSMhb5x+RpFYBchkd5itT960MPhAz5ggxNQ9kBDMhmU3CvmlkHWspgn9ZQJ3sCn5WvQWyo+vWe8fUzbwW20AW4lxJ5bTstGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082282; c=relaxed/simple;
	bh=cZpLybn4x4f1p8M7Je1eNrs+9z6NVu2xigKvChxzG3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thzX9N6AHSZSbBoTIfz5mv19hb0zTwX8/CI1mrAIsVoOeOA0/ZzHk/KvKfnxYeK0k5q8BuUXvltib9BPUtlX+hcNk07+GakQCIwdwI9D9q81go2/vtlEb9huTgfN/lpj2IqZCFdrIy/ks8XrH9MiPd1+KkpvDSrDW5Ww7dfFuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqhxLFDj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqhxLFDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADB1F00898;
	Wed, 10 Jun 2026 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781082281;
	bh=rX6O3bKY03wuV/N+jcdbUzTrtTw5gMO+dKrOQtLnSfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AqhxLFDjqlJ5DjcMHkebMyL5qBFeuhZMmitIDJwJ49uFS13iWvQeC/7TCt/D+QcIP
	 Fr9uIXXN5V/t71/siF7hwDAKxP0FRtKoDzNmr5GEZU4jZtxieIiUvxSrYvYF1zF3xI
	 fcN3skscwg+N3V6Fs1zp+Ylkcx9iaWehgzeAlnFX1uPMNJIqP9ilR2sbMRHLPYkC4b
	 lPcfv6G6mbiLbe8uH/OYZUpjV0aHgau55WyRi5FydGKpeKkvG/CNZY58Jk12OM+deX
	 8rCdFe6gPfQKXfkBj1vJ290SqN5OZQHml6uG/7TQUNscGJH5AmMLnGKsP7xsFOXfr+
	 d763QXfIygTlA==
Date: Wed, 10 Jun 2026 11:04:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: DhruvinRajpura <dhruvin.rajpura@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com, 
	jishnu.prakash@oss.qualcomm.com, Dhruvin Rajpura <drajpura@qti.qualcomm.com>
Subject: Re: [PATCH 1/2] bindings: power: supply: qcom,pmic-glink: Document
 thermal-mitigation
Message-ID: <20260610-gracious-badger-of-debate-6ad0ec@quoll>
References: <20260609-cooling_device_reg-v1-0-e15bddcb0086@qti.qualcomm.com>
 <20260609-cooling_device_reg-v1-1-e15bddcb0086@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609-cooling_device_reg-v1-1-e15bddcb0086@qti.qualcomm.com>

On Tue, Jun 09, 2026 at 02:46:42PM +0530, DhruvinRajpura wrote:
> From: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> 
> The qcom,thermal-mitigation property allows platforms to define
> discrete fast charge current limits used by the thermal framework
> to throttle battery charging in response to thermal events.
> 
> Document the qcom,thermal-mitigation property to describe the array
> of fast charge current limits in microamps that map to thermal
> cooling states.
> 
> Signed-off-by: Dhruvin Rajpura <drajpura@qti.qualcomm.com>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> index ff01d2f3ee5b..fcb69ebaa7cb 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
> @@ -58,6 +58,16 @@ properties:
>        The array should contain a gpio entry for each PMIC Glink connector, in reg order.
>        It is defined that GPIO active level means "CC2" or Reversed/Flipped orientation.
>  
> +  qcom,thermal-mitigation:

Use proper suffixes, see writing bindings.

Also, name looks too much as policy. Describe the hardware.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Array of fast charge current limit values for different system thermal
> +      mitigation levels. This should be a flat array that denotes the maximum
> +      charging current (in uA) for each thermal level. Elements should be listed
> +      in monotonically decreasing (non-increasing) order.

What is a thermal level? How do you define it? How does it map to
thermal bindings?


Best regards,
Krzysztof


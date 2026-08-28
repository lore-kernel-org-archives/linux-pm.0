Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342F181334;
	Fri, 28 Aug 2026 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912627; cv=none; b=YnWF/oM13A9RlJn5iqbiVS1wiOuVueF/Z/v74Y4g1FDeZLuxe+br+PcZLj3tNlQs+8q11KVm1uGaOwPm23L1tms/Hv8iUMfByqF62UsWg+lt3ST5dg7asN+9oFstSLfNp0B2qgkG/cVyq/NSrnzOCxk6g5EWG3OVn2OlQYvmle4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912627; c=relaxed/simple;
	bh=uA1l9O9koP8wEJ/fsOQ2dpA0aUhx63n60RCARt0WVKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5yQaz4DwyBKTwiim2E9L2QBJYJG+xckOKZilAUD6fruwttVeujANrR2EwCPr/6pqMTp3/VmV4M2qYay7I2//Fikc5a5WEp4u6V2sfCAyfEnjMFe/Hg55tasDAOVDMKzQBXr+RnJ17HIWBhwAkzByEQeRAFi9irfR36FW3GByzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0j8ZVgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0j8ZVgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E351F000E9;
	Fri, 28 Aug 2026 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787912626;
	bh=fpBvgF9PFlv3lP/TBkOhSeU1M7o4LDCYU9THSFw3/5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n0j8ZVgAeDgNyiYG6nvd6B6TFxf0UH/K4+3sZFsQxNJluHBaIJA0N1sZPjB+gtJL3
	 WjLLV+WWPi1Xd+fO5//Mo3s0AlMZVRPMjhXiMSEJ9KO4iH4Uo3gCryrvAFnzdhjeMZ
	 JaFyvq71ZqzEU6yBlVGLwakyIEIKbHPensi9P3Ug6kT/H285lZ8RMTchAR5r7nTMGd
	 SGIBwEGBOMJV9se9oLA8fZSqfyV8C/Yhsw43rPI/0aaVDMpS0P5vJd+rZIWniCj6tr
	 bw/KiBHALH3kfirUrZ73bSO2iO7lL0fDN0rJiCCmsj/vPb8j13bYqfo0SDcm7ANx7T
	 dhChHgF1/9ajg==
Date: Fri, 28 Aug 2026 12:23:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: remoteproc: qcom,nord-pas: Switch CDSPs
 to NMXC rail
Message-ID: <20260828-comical-cautious-inchworm-d7d255@quoll>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-4-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826102746.633076-4-shengchao.guo@oss.qualcomm.com>

On Wed, Aug 26, 2026 at 06:27:45PM +0800, Shawn Guo wrote:
>    power-domain-names:
>      minItems: 2
> -    items:
> -      - const: cx
> -      - const: mx
> -      - const: nsp
> +    maxItems: 3
>  
>    reg:
>      maxItems: 1
> @@ -104,15 +98,25 @@ allOf:
>      then:
>        properties:
>          power-domains:
> -          maxItems: 2
> +          items:
> +            - description: CX power domain
> +            - description: MX power domain
>          power-domain-names:
> -          maxItems: 2
> +          items:
> +            - const: cx
> +            - const: mx
>      else:
>        properties:
>          power-domains:
> -          minItems: 3
> +          items:
> +            - description: CX power domain
> +            - description: NMXC power domain
> +            - description: NSP power domain
>          power-domain-names:
> -          minItems: 3
> +          items:
> +            - const: cx
> +            - const: nmxc

That's the same domain from this device point of view, no? The names are
not representing provider but consumer.

Best regards,
Krzysztof


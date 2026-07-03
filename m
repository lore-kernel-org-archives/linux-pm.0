Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05A533CE80;
	Fri,  3 Jul 2026 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059706; cv=none; b=BdA+Crtm46dy08fttwEn+apcs5oX7oC1Y2xSOXx0LwbPlsWH+Mi7IjjCAtuAbFABNpJqtHmMVGuZXl2tyhmPhlMFBZwOboz2+ufGv6f7eAzV4CPzd3aYCtulNIZkyEGAbQ48qzOHvnWrR393h4lRBGdDBPeC6ntkXEzWbVBy1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059706; c=relaxed/simple;
	bh=lzzJVjjvVZjpLMVVdCED199e6uwLBfBDY/p+X3b2Hhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TMn3rmqZXdH7ITw7jo4RohNH740SPVtTILleXNZqsMTfflQ21zXW4+llVGSqyBTVN9Hb+8PeJQTe+KOuxwFBlODZSfAvpGcIzCzO67DyqJu18fUupUc495bGaNOuzmKWWhF9lZJs+DTSnDO/IiPBXqEzqthXI8A/N9lq7f3U5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1SvAygo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1SvAygo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D737F1F000E9;
	Fri,  3 Jul 2026 06:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783059705;
	bh=7MnTyVBXFYp8Vg2HkN9K0Uqvv/ITH5vIesO323A19Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l1SvAygoZlQi4uJF1C/PgeT3ztkI0zOK3VsCg5W40I4/4qwR8F2fqN5SqTIfDwfaM
	 kliunmN4aKQGkXYwlJFF9PGIxCY1cLPdTkd9Tqtd2fXFODKM5nhnKA8cYqfceGxe35
	 tyIQLNfsjCvAnFhdTU5LUi2RwptdVqvYO1UeVXvvbSDpI2ngOBl15yyTmmk66BRco4
	 OL5BshL8b19pQbQlGsOd7o1WMYJIj4RW6kTpA/uk6+ceq40IF2fe9hjfScII8/1pBU
	 GZHMskefZ+hsP2rUtX0MB0Ee3buaDKXDta4YtUASIAU8iCyHc/ZKrOuCpBR5XLOpWR
	 flR+9gWnTTS1A==
Date: Fri, 3 Jul 2026 08:21:41 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: power: limits: Describe Qualcomm
 SPEL hardware
Message-ID: <20260703-pastel-sensible-scorpion-6cea30@quoll>
References: <20260702-qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com>
 <20260702-qcom_spel_driver_upstream-v3-2-434d50f0c5b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-qcom_spel_driver_upstream-v3-2-434d50f0c5b0@oss.qualcomm.com>

On Thu, Jul 02, 2026 at 10:52:55PM +0530, Manaf Meethalavalappu Pallikunhi wrote:
> +  SPEL enforces power consumption limits to prevent thermal overload, maintain
> +  system stability, and comply with platform power budgets. It provides
> +    - Hardware-enforced power capping with configurable power limits
> +    - Time window controls for power averaging
> +    - Energy counter monitoring for each power domain
> +    - Automatic throttling when power limits are exceeded
> +
> +  The hardware supports multiple power domains including system (SYS), SoC,
> +  CPU clusters, GPU, memory, and peripheral subsystems. Each domain can have
> +  independent power limits and monitoring.
> +
> +allOf:
> +  - $ref: power-limit-controller.yaml#

Which properties are shared with above schema?

> +
> +properties:
> +  compatible:
> +    const: qcom,glymur-spel
> +
> +  reg:
> +    maxItems: 3

Best regards,
Krzysztof


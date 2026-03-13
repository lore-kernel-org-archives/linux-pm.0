Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2D26CE2C;
	Fri, 13 Mar 2026 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388765; cv=none; b=izPYbDUD6uuq2wytp+r11jULcrlhAJdHROvb1gAEogMkVeixCG5TwAaGj7tWpPGtfVOrZxJ7Vi/LLMjXrOySyr9XPHnoUr7rvxI5v46aBJysfLeqjLHtvV+zSFQaqoIRNM9fXh8L0Rs5uOQ+yIIFXFAFoyj8KLlsuuJNtvmD6PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388765; c=relaxed/simple;
	bh=YRFj0Qg6GXnjSTQbSQprHdA2e2ZkjPJgl3OB0Q3zy+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhRyQjRaboKw/5dre8CWkr4fFfWxHmq71CGlStQKp/V94f10irEy8NOI/uNsGCZyXzSy/lPZoBuHv6OQUXyFdSrF9c5Ccji/4FWvH9cCrzWkUuZJvCEd3oVG1ir3521KaeQAKEOoY31I8TOO/nnzQeIWtiwcwF3TuunC76EFEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O57Owo75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O57Owo75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA80C2BC9E;
	Fri, 13 Mar 2026 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773388764;
	bh=YRFj0Qg6GXnjSTQbSQprHdA2e2ZkjPJgl3OB0Q3zy+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O57Owo75+I8rBwZzqsFK4gS0WGH1RZ5GJuWwxip2fBodjtO75gTRzXcukiWMLV/22
	 WrZ2wsiEOAp8TKnIutg/PYYRmysQWUDWxVO2JMkcNT/rK2b5YjEo2w1qNBUe1KewRJ
	 FDHx25344/P1t3NGGrriovnBWI7oDK19+x4wduN93bGMsvbncyHsXm6DlAj0UQlup2
	 fpT6gcqLzzUqyG6yBGAwQXJ8DCYplap9nFc+29c+uMKQKAkcVeUHBRtye/VsG4RWqv
	 1l26AKJy4Mu3EmaNERdHypBwITJrQn0K4heHqMWYON3oUJQCN+KhPPgPwTzoeft1pY
	 Ns+mQjmJpxNCg==
Date: Fri, 13 Mar 2026 08:59:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: interconnect: qcom,qcs615-rpmh: add
 clocks property to enable QoS
Message-ID: <20260313-wooden-ultra-moth-e05a3e@quoll>
References: <20260311103548.1823044-1-odelu.kukatla@oss.qualcomm.com>
 <20260311103548.1823044-2-odelu.kukatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311103548.1823044-2-odelu.kukatla@oss.qualcomm.com>

On Wed, Mar 11, 2026 at 04:05:46PM +0530, Odelu Kukatla wrote:
> +    then:
> +      properties:
> +        clocks: false
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -69,3 +92,14 @@ examples:
>          #interconnect-cells = <2>;
>          qcom,bcm-voters = <&apps_bcm_voter>;
>      };
> +
> +    aggre1_noc: interconnect@1700000 {
> +        compatible = "qcom,qcs615-aggre1-noc";

Difference in one property does not warrant new example since you
already have two examples there.

Drop

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


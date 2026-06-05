Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280E01494A8;
	Fri,  5 Jun 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661476; cv=none; b=j9xTCuPCjimU+q1qYRrGy/k/0uSJU4+VrPGH0BlEvbkhGYv7FVs0uq14fD1rIJnc6CK9tqSsuWDZf45dLibwUgLLCBnYv4PDKxsKmMIz3IQOKWBj7XxBIR0VNXMuu7Tl9aaYQ4pybmjo1zPm2Vc8PKOsfqs4TzQsq+KHU8Do7vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661476; c=relaxed/simple;
	bh=lr49BCrAL6mGNNml3dFriG7dLUagRUWSs6G/d7dGDSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtGveH4KpborRDHKf08ENXquWltu0cR8ztTMF295LzwMi1psxKEqcpsbDt5VyoHsj1y9z5frorqjqh/25c+8Vhdv7LqpQS4qxJzT0eYVSlitZsnTwXTCHCYkJI5pwA4t0RW/+yVytbj3l6CfZPS+2pSpAEyiwdNcOK7RLjvtEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1Zp6MNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1Zp6MNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AECB1F00893;
	Fri,  5 Jun 2026 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661474;
	bh=8V2dG/CeseCVW3AY+1aCZPvY9gjP0BjGELQ1FhcrNyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H1Zp6MNw8qqaMVvPwzGR06/Hybumfl9jblGyQ15jHh8zn8AgYmBUZUWGnlw37TSYV
	 ORptnBJmpS1YfEhj1qQvkM9dS9qdAJHUrRofTAK5i7amthqQZUeCAdD7xieF7rYxRh
	 iijTI2wotf2zjPTWki+rjuP6vDDspBudyC3G/wlTo0ZGUL+2/jAt1+Mv7ptiApYz8a
	 sfbXToP1gN4Zn0UFTdX5wQMp+ish8ESZUyK0+x/1eVbG1poAA4g8m+0ks4eWrgzX23
	 sANb50jKUwZfOewBptCNmnjP7xBjZPCZNevu1u03kwrD9L3PR0ufX16PTPZ6yselp7
	 Yldd10jo92khg==
Date: Fri, 5 Jun 2026 14:11:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Xueyao An <xueyao.an@oss.qualcomm.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA
 engine for Shikra SoC
Message-ID: <20260605-inscrutable-notorious-weasel-9deddf@quoll>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-1-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-1-0fe3f8d9ec48@oss.qualcomm.com>

On Mon, Jun 01, 2026 at 06:25:03PM +0530, Komal Bajaj wrote:
> From: Xueyao An <xueyao.an@oss.qualcomm.com>
> 
> Document the GPI DMA engine on Shikra platform.

Compatible with?

> 
> Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
>  1 file changed, 1 insertion(+)

With extended commit msg:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


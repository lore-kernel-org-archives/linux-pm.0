Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB914D991E;
	Fri,  5 Jun 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661548; cv=none; b=gexQHye3YwCXHn+NC2VuA485BgthiAqwgmVxqRenjNfjg1K9MLsOw/N7Xv0tgG7kMiBbcOvScsWggn9NQ4syo0faofEgNeuwmS/lalrmgSsIghUrEhNnrvPCX1fSZwA7anE5Owq/9/l3IZZdD9MqakoDk18vKCHCmqXuBi9ua/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661548; c=relaxed/simple;
	bh=lvEiGHFlvnfFf9KYwv4F6JF7CsFDWVXM1MGvXVoCr3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2mBHBFerywMRVJ8PYwukOgf0likAP/03ltspAhjHbD4JfDbmTWI2q1WJ0CKQMtJcLMHCedDZrsCLfGZX5U3x6qp5r/eQ4BjIA8ozz6n6ku+5bIcWs+Lzv1pajg/B8+6LXkuOVvlAbTkEeuaDoMEg1RE5KMX2AVk6gappEmZ/CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2NvZ20y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2NvZ20y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD27C1F00893;
	Fri,  5 Jun 2026 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661547;
	bh=/sG6pzLE8w1x4qXhiHLMgQSv+iJsUPRzPXXNPzYBgk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e2NvZ20y+jjtmnYeI5bYSvrFwTtpKzWmAwQgH+bEywLJ1H5QxLCUqTLuHoVJslJ7F
	 vyMrMtIbrHYoPUR84WWGqSK5enqf07S3qJtBiuAGvHaa27/iJRH7TNmLqS7T0tKtey
	 5FqIGBJl0LPLxAPiLTBXCHLM6YxTP6KDe0XTV+8lnSb5vaveWBPDJdBz5mbqPLrbkh
	 x3FgQVq70kQQ7RhcJMZXIQQdoI2UiiWFXOOIdthWO3skONy+q1utILKEcHM7Pcfuio
	 LoQJ9Kb1OgMUmYfTIQELkhBxDo/jAmsXWuBhKKc8kOcErin2TdpM/6dNzFVifTHU39
	 Lw5CBMbqGIupw==
Date: Fri, 5 Jun 2026 14:12:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Subject: Re: [PATCH v3 02/10] dt-bindings: interconnect: qcom-bwmon: Add
 Shikra cpu-bwmon compatible
Message-ID: <20260605-bizarre-gorilla-of-awe-92fae5@quoll>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-2-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601-shikra-dt-m1-v3-2-0fe3f8d9ec48@oss.qualcomm.com>

On Mon, Jun 01, 2026 at 06:25:04PM +0530, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
> bandwidth monitor. Shikra has a BWMONv5 for CPU.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


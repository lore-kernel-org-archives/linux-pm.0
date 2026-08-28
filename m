Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFC39656C;
	Fri, 28 Aug 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911086; cv=none; b=f6AL+bUv/gixLhAg2xK88nsdy8J2btA0r2PFyim8HPrn9as7SFxwlLwdu0LTtBQGfDEbZB0nL2z9+R1R/Cox7KPKSjWonXhitLrxQm1obPHL9gqiOrUUbswf4AvgE+4utRMrC0odVbiArRqp5Fg0EsYy7VyOZ0cfe620HKJpnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911086; c=relaxed/simple;
	bh=ajBBpSyFc1NQEcbGv7IivGzW4tajOcuk94h3NG45FLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUt7rWRD4YZg8Qovdxww8seh6Qq8wivligB132CgxLrknyseQ1WB2UaG7d1VqyCmXaGOrK/zwXmMJvwV+tIryMtSwHUVDCG4ZpmgmGrVj2cLQQIPhh2mqw+/eCojQ3DUrOweJddNKFqRwY8pFT84f4UemMrsIfR1WN3BrG5DAjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfclMt02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfclMt02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91FA1F000E9;
	Fri, 28 Aug 2026 09:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911084;
	bh=5E2VjrsSvIx6ytStbLCN369AVtGigqSvkeJzYHEwtzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kfclMt02qS3Mgw4l5Lox+txcmeux82R/CbBV9vVdFWji6ZmGZikJFQZRzW6ipYvq2
	 n2rupsNbfHQlraJaIwPAvfVjbARX9W8OBGHKIt1t82Fzi1UYlBFfdwYc/2ohWaSr5G
	 pn58tZPDvDV0HPJjFWANNeYkfg1qK7V2MgRa/AhJDQOU9chLqLlvqtFgHQt/0WXAxF
	 OjXvvwY08Jvs+zexPkE1nO4o8Inss7EC1rca8fkb1klHcXFxCYP5mV61jMsw2Oe2Ys
	 /IqzZsHxWTp0Sn6vw6VoXdMaCRkx0Pd4ZM2adj1J+pPM1SqnBiLuXza9Cq3NlGQJns
	 OXpBe/m16F+Bw==
Date: Fri, 28 Aug 2026 11:58:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, 
	bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com, 
	lpieralisi@kernel.org, taniya.das@oss.qualcomm.com, danila@mainlining.org, 
	davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 11/13] dt-bindings: interrupt-controller: qcom,pdc:
 Document SM7250 PDC
Message-ID: <20260828-beautiful-objective-owl-4ea11b@quoll>
References: <20260824150156.1310-1-sreeshankar0910@gmail.com>
 <20260824150156.1310-12-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260824150156.1310-12-sreeshankar0910@gmail.com>

On Mon, Aug 24, 2026 at 03:01:54PM +0000, Sreeshankar K wrote:
> Document the PDC block on the SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


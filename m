Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C81F49C4C7;
	Thu, 15 Oct 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072371; cv=none; b=LY3xzrleBuaU6YSwmw42hUAvZGbWjwl7Tdc2tPGJ3kpLyfNJ0eXOeIlc2VT3Zs94TkLjloch0QH6WJ/XJWA+r/1Q2+hcbcDDD/8iqk5HIE185MIL3aW2yzJR+4ZGqgCuSGn3V3abA+wqGxgLyAx60wateWkWOFbTc6gYZ/Oh0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072371; c=relaxed/simple;
	bh=GaU+UWqpjsQHcnowrv4mMw1pUWGNFo0g7guCdhjkHCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eIj5WddpkGKvQh0t2JXJkTkSqCN2QyUi5IFlxnrTFJWHx8gwqZwJvaE4sFlxAK6BPaD4wT6WfgF1gXLPf9mFZMUrCNHE7NHAFztop5Gdu/gIiRLUfh4TeywrPU3p6V+yKVlyJ5lNooGC8Go5DezmoL16Bn29QP8EccQpIoGVGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMhS2Xz9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMhS2Xz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F79C1F000C4;
	Thu, 15 Oct 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072369;
	bh=UvH0jUBywe5FV+9aAutEDgMDy7BwEppp3+JFD3RxAoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nMhS2Xz9Gcm8LDFBIP47WyBfTc9cl4z/Tq1jBr6JiOdIDA5O6JITrWQWBWinxe8Aa
	 3SBVNuDHorGYuj/s1XMd9ZNK7zLFRQ1ML0LXHeXPA633Xof/CSmeoglNU0FPjoWpPO
	 gidts4mg/qQbOtX/NR9HgWL+Bn2WjgSJfiPrhvoyeYe45bLBJwyExkk80rZ5Jj8XWV
	 zY5CaYlGQQHVxG/j8NIm2P41vHBh0eJS9PkHbQr5xV8tfU7UeoLkp7aaLgZ0HwzUW2
	 t98ZCHNByF0+Hagc2JjMq7Dlm/5g07H9FWYZtRQHeH5LZktcTBBwiacf5lD5/1VjaQ
	 tstxWiX0ONeCQ==
Date: Thu, 15 Oct 2026 08:52:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: conor+dt@kernel.org, davidwronek@gmail.com, devicetree@vger.kernel.org,
	krzk+dt@kernel.org, viresh.kumar@linaro.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	danila@mainlining.org, jbrunet+clk@baylibre.com,
	linux-clk@vger.kernel.org, sboyd@kernel.org, konradybcio@kernel.org,
	andersson@kernel.org, radu@rendec.net, robimarko@gmail.com,
	bmasney+clk@redhat.com, rafael@kernel.org, tglx@kernel.org,
	mani@kernel.org, linux@gurudas.dev, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 4/6] dt-bindings: interrupt-controller: qcom,pdc:
 Document SM7250 PDC
Message-ID: <179207236622.28934.8455006218721757519.robh@kernel.org>
References: <20261015051926.13752-1-sreeshankar0910@gmail.com>
 <20261015051926.13752-5-sreeshankar0910@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015051926.13752-5-sreeshankar0910@gmail.com>


On Thu, 15 Oct 2026 05:19:24 +0000, Sreeshankar K wrote:
> Document the PDC block on the SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


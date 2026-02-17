Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE502DBF78;
	Tue, 17 Feb 2026 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315597; cv=none; b=kWRKiiyesg7Wd6w9iBAOoVMkSNdFhzo1xBrccSXpjLThYxF2zybA8d2TveCHrYLo+xT4nm0uXluWuXQssTyjTMazGSLp92esq4tzj8tL2eY6F0LF9XXfkzPGHkqyx6innbuemlCVba0NHKVxWIKZZjy/J+EksVFdgvkwZfABYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315597; c=relaxed/simple;
	bh=NzRLeCifJLd/Hbhqr9TxW47f7GxEqWDa8AbZIqBhoIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9y2kR7JiayRaMWOVWwsF4iMb4tOXODezxslM0NAsxo7gPbZTXRTx4+GjIQSdL01oGBZi2ox2+H+mJxrGSzsG52Cj21+diJOvN5ZP87YFakFWKmRZObQUwa+D7bMLwgPkEXi0aShDWCHJnGQHpBI+NwTmRuliPjP7IUA8xtVCeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFsV5l8a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFsV5l8a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D202BC2BC86;
	Tue, 17 Feb 2026 08:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771315597;
	bh=NzRLeCifJLd/Hbhqr9TxW47f7GxEqWDa8AbZIqBhoIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFsV5l8amHxWDYKsSNJtgl60eYAOCQAUdUGtaMAHl8RCRPB1G7P+dweotX9uOhFVG
	 ggcG8WD05GuPfr6Hbg1lffiecaLSSI6huCBPic1CpOsZDyJuT/NdVJddlV+bG6ma8+
	 oUenEgqG523oeGFKc/uiX7Ddkj/zY8RIUeo0rDfM/vDfjjzuihrSnYEfmFwUlmWP/6
	 enmnaoiC7cdR7ZjuDOu5HDkbIcbrP99c4mBpTlRQtcYmycoHAYyqcwjlC+UxRxAWnN
	 CIdmaxZhdQlATNIyX5pTM5CjO2jmeNcWGU8cebgOdg4n69S0EVrwztpnyX9+Iv//71
	 iAJCDmw1Am1zw==
Date: Tue, 17 Feb 2026 09:06:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the Eliza
 RPMh Power Domains
Message-ID: <20260217-chubby-origami-pony-61363e@quoll>
References: <20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com>
 <20260216-eliza-pmdomain-v1-1-c51260a47d6d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260216-eliza-pmdomain-v1-1-c51260a47d6d@oss.qualcomm.com>

On Mon, Feb 16, 2026 at 04:23:18PM +0200, Abel Vesa wrote:
> Document the RPMh Power Domains on the Eliza Platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


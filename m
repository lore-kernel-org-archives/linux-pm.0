Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A3359A6F;
	Fri, 28 Aug 2026 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912399; cv=none; b=e6e1Udve50uwAGUjg2SGo7c1jTicl6PTdW31L13JipOGWinA+IpxxPV90hxC4p4jcyyi1R6oSGveHrjF5kvQ6jOBtPFHlkzV7QPM92zhIDcpSYhht6uvrzCirt8cNyTnfDXVEL7EsYYH05DwUSWl5jv82s39OLjtWjOnBPM+iJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912399; c=relaxed/simple;
	bh=futw2XCGMDSHhn54S5oyl06SQBKtFTxkqn6eWMqTvwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/OHnq5KhWYYJd6QmblTAiH4SkUX5oyq9WeyhIMxOFJWaPh6GFsHCDIED3jwMEeOzqrmTI8KRJZW/AvsEglcDqiyqNPCx40MojBwVYiK8CIY7Dv7NQ80v3bc3VMXWnfWE3KdDMCmfpzrlzcEJvOz+C7M+G2t6H5ZeDVwzK/Kl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYrFOERr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYrFOERr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57131F000E9;
	Fri, 28 Aug 2026 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787912398;
	bh=pRy3lgN/Xwo8qBRzB5MhwKwC7cwSFWthQleG5prfkCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mYrFOERrQWMi7EdJudyROCstHFurvf43wJNxTFcIxow2BfuKTr5Yhcw9uyv79Ayyi
	 EdtMp6cQTXnxBmQdFQFmVl+3DBhPVHKZzP9PgRw3EF5ILVAtz14bVIY/ZQ8xXlMamC
	 FbaaKovJ397C1UMe4hpED91oPN3ZYSuBXdlpV2A42dbwRSzy0aNQ9njydXhoEWCmGc
	 UchYwRfj7p58xmvF69hB0eBhbxvnhASoFCXpU/wLMvvmjDIWrhu3csSM/WDY9epWhG
	 9FEm/feyNEySsuS9GSPTFFgNBWpnOs53eU24pLgR7XqsXmJSror9Tua6Y1fxf1MVuR
	 URV+E77FCF8bQ==
Date: Fri, 28 Aug 2026 12:19:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: power: qcom,rpmhpd: Add NMXC power
 domain index
Message-ID: <20260828-colossal-festive-kestrel-f2c77a@quoll>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-2-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260826102746.633076-2-shengchao.guo@oss.qualcomm.com>

On Wed, Aug 26, 2026 at 06:27:43PM +0800, Shawn Guo wrote:
> From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> 
> Nord routes the NSP (compute DSP) memory rail through a dedicated NMXC
> resource instead of the shared MX rail. Add the index so device trees can
> reference it.
> 
> Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  include/dt-bindings/power/qcom,rpmhpd.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


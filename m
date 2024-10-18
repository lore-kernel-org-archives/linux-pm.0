Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C14518872A;
	Fri, 18 Oct 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235675; cv=none; b=WW2mcw4lx1XLHwPLYnqti2KNnBWS/ZjWziXJOgPKTkx5WCp2DYCdom/6zh5on2X77qepI0bkGTxpqL8VkHZt2tuZgvHW+nLs1HoFjrCTQbrPZTPlIqal/moA5LgLENAp1J54MjYDMHoO0EkOLWdTuNi5hgwxxpMGHRUPS5/7k9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235675; c=relaxed/simple;
	bh=tIT7rEu1WUSXn/vMtdEM5J6qhBScDWugakq0kVEQxgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgSHQuLTbATPt/ByCls/eK0Ehcb1pPNsCQ7YlE8l9SmH0brcfNX1K5LLV/mrarM6GdlLepSi9wdi1tY6449WP99yOCSFyOVXI9DRn8R2h1TWW4auCfYnjcFq5Mg4CnPieFuXMFOS7GeywJALfGP/12RCcPIprmxQRjqaF4DTmmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dh++pZeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dh++pZeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F146AC4CEC3;
	Fri, 18 Oct 2024 07:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729235674;
	bh=tIT7rEu1WUSXn/vMtdEM5J6qhBScDWugakq0kVEQxgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dh++pZeKI/AxRJDueBk3hSGe5ZSYdnx2I+a6VwciCbvyd5JcEdLCeXcNlFxekUc3P
	 6E0XKCulIYqNMFu1kHXWqmOQnT8O1FMtM6CvZyjvk8T8/Gj/3FjBIIF1CU9KLLdaP3
	 RLcabQTV2m8g3pzR5YXFgf4+YnN7WFt6JeMm7bz6LaKWfbXsyxItoWjFWhZB4JiNa7
	 Vv+9rkdnHCiUnTLes8OHLiImzSF45pHKUyh56/TofC36ONVjLpgyGKCqgL7kR50vXe
	 BXk36hZyks+2NdwTyMGyQgVezU4aEsHZDnCa9KKk+9Euz0P3Vf8l5WVJ+ADvgeSouc
	 zPlt4jrjOeP6Q==
Date: Fri, 18 Oct 2024 09:14:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: rpmpd: Add SAR2130P compatible
Message-ID: <kjtql3s3mjkt5ydvwstgpchlsbgnqbvp664mduie7j7yqkyxf6@xreksp55b3co>
References: <20241017-sar2130p-rpmhpd-v1-0-f4bf7f6fd12e@linaro.org>
 <20241017-sar2130p-rpmhpd-v1-1-f4bf7f6fd12e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-rpmhpd-v1-1-f4bf7f6fd12e@linaro.org>

On Thu, Oct 17, 2024 at 08:52:35PM +0300, Dmitry Baryshkov wrote:
> Document compatible for RPMh power domain controller on SAR2130P platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


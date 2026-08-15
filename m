Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9A230BE9;
	Sat, 15 Aug 2026 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786826828; cv=none; b=QAP5HKW4x4HlYs/RMUtWa8RaIyne8NdU5uAj7kGx/uojAhKlPDyhsN38KofufMW7DaSCXuESaCKTmK75af6rsteeb9a56TxT6u72unbkgSWGZ64CCrPTdiBg9+viibG2vAGyf8CtXKcUoEWShw0DE281J7jlSPdkHao+iU1Ke84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786826828; c=relaxed/simple;
	bh=EGMqk8YyWE0MT4Vvvcwh1JTXrwsd39uYIGnhi7a+Ep8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHhV5rM5xpOvE4M9Kv6WzF4qmaYc437/ZUWYXSspAMwVoHl72Xh5Z2Lk9IFDdFLVJBhpHLVhegU08cGTJfXcBgS93JebhmoxbYIlTX6HHU5zMpsXQNZzO+FW2DC/QdGvJl6qFo2dOAEaChML2tuPouCkHqPLeiivkEAlGfO0XHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMBMn+dG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMBMn+dG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AF71F000E9;
	Sat, 15 Aug 2026 20:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786826826;
	bh=d306Y2pLMoH+tssTgx0Bs6ZYvO5VsVEYshmJWtDJLzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PMBMn+dGIJ1OyQDRPWNpyJQWGwD8YECe0/g4Z757cxhTtttBeIHaRXRveYMFD4ALh
	 fFn2OmyKZLHKQWxCUMbrNewHwIl4HAt88lTDqsC9JVkMwi7slztP75iqYoVshw0Ywq
	 bN7DsG97hcGmt6UT879xEtQQisnhZNQ+eYWWoLvPes8OGAzjZMvingde9fjiq+f6Of
	 9asH/TSx6UxKipRpHC/n+I36O9hRGjRiVBIhh7SBzfc0cYxHMZeYEHRSM32xRiy9tp
	 Abb2GopHQ5tArSeVZRFsag9waHe943d5JP3SiTopdq/Io9QBqYezoqRmG9+mpNCEdY
	 07svd3nhiQ1yg==
Date: Sat, 15 Aug 2026 15:47:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yijie Yang <yijie.yang@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH RESEND v2] dt-bindings: interconnect: qcom-bwmon: Add
 Maili cpu-bwmon compatible
Message-ID: <178682681257.2186154.3664708840148254329.robh@kernel.org>
References: <20260811-bwmon-v2-1-80f7f150ab9e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-bwmon-v2-1-80f7f150ab9e@oss.qualcomm.com>


On Tue, 11 Aug 2026 16:46:47 +0800, Yijie Yang wrote:
> Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
> monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
> consistent with the existing pattern used by other recent SoCs such as
> sm8750 and kaanapali.
> 
> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Drop Assisted-by tag; no functional change.
> - Link to v1: https://patch.msgid.link/20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


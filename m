Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A02FE575;
	Tue,  4 Aug 2026 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826621; cv=none; b=qlvN8Zxjkt3Z9ddIy0nDn65DRVY7beTDSscew3c5Ld4XYyJ20fhaOXO+6ZVmzYgJ2pUiiNX2aA+ljVAdLwb/Kmb6FZ6EiBdtDRXlO2ufWabblwTMF7SpSOXabB27bTr6HGIdyWOwy9nOMpG993NGWghzt2m2YyZlW2d+5sT+53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826621; c=relaxed/simple;
	bh=xkU38Fa6Zg0Jv9Ka7xtQAeg87xuQlFYxdYz3QsA22o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBIXt9Sjr3rGNIN+5rDi/lOpPFUGAjPl0QC9enQGBpzLy5IT70uN0wPf/wyABt4h3/XcgYL5KcxAToaVP8cGhDP4JjA/8U+ZgUweUOMsJXfe3U4qe5DC5a7SKeaoWX2zftcStHTAPQUJ0Xhuz4nIbFPs9DJmFr7yfMnm62nyLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDRykVaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDRykVaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286791F000E9;
	Tue,  4 Aug 2026 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785826620;
	bh=YXRBgy61Gz7Y0jEB5kiCGWyQ9pvZxkLcLsXnGeA/dkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lDRykVaRmrMftBL3nyCyDKx9ZWbhTrn7EHPxpmvsKREYKqfqePHCtmXlZWDu9V0wH
	 vOmSdItrwt6J3l/6Ny3CdOHcQue6uKBhvaGqcRYxPTdAPm98hzRouJK4uYD8LgRYIV
	 Iaawfbl66lceKU6rKF58wCwr1KSsGlm3iFjSFqmcXIAUoU1zGIRtGczYVXwDdIKvDM
	 9o2neAc/WbY8byLseKJYvRr9rFzyQNI0OVpk9nGfwCLF8C3UDRkViaQTDCqBniFbGZ
	 YtAnczBqj6/QD1i1ZlG0J714QSlkEgqGpGOSs51DvER6yZt5t50aHAO8maF1kvOfu3
	 tT09jeW7czw4Q==
Date: Tue, 4 Aug 2026 08:56:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, 
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	mfd@lists.linux.dev
Subject: Re: [PATCH v3 3/5] dt-bindings: mfd: syscon: Allow syscon compatible
 for Loongson-2K0300 chip id
Message-ID: <20260804-intelligent-kickass-squid-e4c4c0@quoll>
References: <cover.1785480242.git.zhoubinbin@loongson.cn>
 <0fbb8d766b6ed33bf4ae9b066eac174f55ae5b56.1785480242.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fbb8d766b6ed33bf4ae9b066eac174f55ae5b56.1785480242.git.zhoubinbin@loongson.cn>

On Fri, Jul 31, 2026 at 05:42:19PM +0800, Binbin Zhou wrote:
> The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
> interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon`
> to the allowed list of syscon bindings so that it can be referenced from
> the thermal node via a phandle.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index e22867088063..18eb9defec8c 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -76,6 +76,7 @@ select:

There is no such select in the code.

Best regards,
Krzysztof


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CF32E6BC;
	Wed,  5 Aug 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913184; cv=none; b=bttfPJRA2b8GkR2hVHKEgiW/H1o39fVv105v5cnp7hEROCkISoo/3FYaUJqLhJ12Ums3zfy0iXnU6Ad2xY2sbGinmw+Blao/VgRgpk/WqBfnogTj+xyPIIWKdDIQ3xLsiEZXJjM1EDpA5VpPVDPBjKmlIKz8+bZ8IeTRRV6hOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913184; c=relaxed/simple;
	bh=XheI9qFxkPUnp2vJWEwlu2ZpktclvWGZkevSgYttlio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/eH3BHjk+5Kbb4DJ5KgDm8+/B9LWtwt6LrqgGCurlK5YPidpc4Um+J3tOzYM7q09YVb75s1mJPgRtPXAZsO2bQvy5oLg/fhMhm+EmIK+O5/ora1SNGzp+2xc4c3Jng392YfkE8fJ6T2F1kpfV3HOz7A57sSnspViBw30lesBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkE5sGrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkE5sGrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F08C1F000E9;
	Wed,  5 Aug 2026 06:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785913183;
	bh=Z8sM8kd8wp8wM2TXmAEgMiM2uoAlfrIXNhmzZPd/OSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VkE5sGrLeOq+TSDlM1ml2idoeiIzXFhcFyKlUsbxx1ppeZjFb/dTnBzmp4hJXcpk/
	 ic3kPS4vDRq6QE9aoyMntY+xwy6ctbzy25Y0x+M/4Z9E5JLRv3qyzpRhFvMxhCO2Lq
	 fzZAbV1egdyj79uWWXjb5qJTr1xMfAIwxrJ49beRgyQfxn/vLE1a7LsvFu5h/H6a3+
	 UhzQTeB4phoqJpc83jcC657P6WPFojyVeMsp6TTnCQKH5ArVYUyq/eU5MdeQP5RtLD
	 6VqezEIcwlIuaaP85L1TG/dlKXWITtaptPKt07doR+aBUJ2dej5UZgGsK6lN/yxVxK
	 sl5VopINypVCw==
Date: Wed, 5 Aug 2026 08:59:39 +0200
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
Subject: Re: [PATCH v4 3/5] dt-bindings: mfd: syscon: Allow syscon compatible
 for Loongson-2K0300 chip id
Message-ID: <20260805-modest-brass-owl-ca1ab7@quoll>
References: <cover.1785829933.git.zhoubinbin@loongson.cn>
 <b76405a88b0cded91ba370139d7223fe2d6953df.1785829933.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b76405a88b0cded91ba370139d7223fe2d6953df.1785829933.git.zhoubinbin@loongson.cn>

On Tue, Aug 04, 2026 at 08:43:56PM +0800, Binbin Zhou wrote:
> The Loongson-2K0300 SoC exposes its chip ID registers through a syscon
> interface. Add the specific compatible `loongson,ls2k0300-chipid-syscon`
> to the allowed list of syscon bindings so that it can be referenced from
> the thermal node via a phandle.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


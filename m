Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124583BF69E;
	Mon, 17 Aug 2026 08:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953723; cv=none; b=YeTkMo+cpSksyJvJ/s8SaZ3Q2Okd8snbY0zMLrCDBg1zN25ExwiLgfAq0Y2QqfiUyh4HtQc7GtfB0MD5q6IdPGf9FYgAOIcFG0msE4HQ4XqtRGCDdriB93XZsiC6XRKr5/HzZe63Xx+d9IgefeQQzBaKpG2qL/f9Wa594m3DeTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953723; c=relaxed/simple;
	bh=FWhTeq2mUIjNQCroTizJ5dCq/z02tow76m89cCRsndY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdfY2fJx2gSc6M8v5OOxYjImto/t6pd8Q7RVAnjPgANXy+eL5829lAqNPZJsMo+oQiWwXBqdSYDu+5k9nBg+p5i1FYlxFmcP2EOobNmC570vl5S9n760O6phF3ap8L0zWXPE53dZbKoS+8izzDwTLpwTn0lbA92WgMyBBMH/oEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKgDdVFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKgDdVFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE4A1F000E9;
	Mon, 17 Aug 2026 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786953721;
	bh=EwAW9B2mhsw0GmrLcVDWd6QtEJUcsnkkCAOqXIZhdKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lKgDdVFT62cmhqbjV0yiepr4j4lQnsLF8YWdVNIUcIGsqC76XzhYfbL75g9AMFnh6
	 M0adFJIyA8QjBGys0JXBXHdg064rBWCS9Jh7tSoDhNReFzx1AwfiFQ8oyL3Mzjj2rJ
	 nQbCSqCuj4kwT6kNasw4qxaGmXyLpsGLwD6wcsB7Ca7O8ZMaDI+kPlVHIU+O53LUJx
	 uXtgmpm/WuoOhS61lsCOKNJRs//RIbAZS23ozROzU3TjRT0Eq6ZYA7Ob3mNqoch9tt
	 KtlkjUpvU+xHB1pq9lzXwChJsCsew3pCsGxXbyVwsmQb7VQyrYZ+cXAsIJQnmp2OmM
	 WSCXXAgrkTprA==
Date: Mon, 17 Aug 2026 10:01:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: devfreq: samsung,exynos-ppmu: Use standard
 regex syntax
Message-ID: <20260817-piquant-colorful-tiger-6afda0@quoll>
References: <20260813174037.2263884-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260813174037.2263884-1-robh@kernel.org>

On Thu, Aug 13, 2026 at 12:39:58PM -0500, Rob Herring (Arm) wrote:
> The "{,N}" regex syntax is non-standard, but happens to be supported by
> python re module. It is equivalent to "{0,N}" which is more commonly
> supported. This fixes using a rust implementation of the DT schema
> tools.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/devfreq/event/samsung,exynos-ppmu.yaml  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


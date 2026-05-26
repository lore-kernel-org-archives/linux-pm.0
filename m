Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CAA3D8101;
	Tue, 26 May 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788558; cv=none; b=OpcxWce+uDoz7Cs5cYKMJDp6jg6t8rGEJu0XUDxTPr1aKpftzNT1fPLCfY/rankn+D1q4zO505K8IgieMABjzLYu3ML/MBxytcoQu558Jaax7TOfRfByczVE4dfqC6kCQbiiRZAd43PNP3yebWF8PFmdxLJh4la2Zg9B983xBgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788558; c=relaxed/simple;
	bh=rKNgA79MMeQk+bwc28f395YxJbYOZxdMNnULJfDhld4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK6aegtlMXOVfF2+oSKsUqXfrZKR9m5udFELQ8vlIvBbPD9kp1U4CksGmf337TY/v1HBrnt6VhzSN67L2Gkao2MuFarw0eDGivI4WliM0XIPx9uQl1CJGa1CVDaM7j1AYiAoID0CxB2aYl/OD8O2lgMZTtXwgUPW0CI6fnF+R5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6yin3Kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6yin3Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A75D1F000E9;
	Tue, 26 May 2026 09:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779788557;
	bh=69ANfIB+mPawv6oMTVRw25TJh4t4UGQi6U/dIsBgm28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f6yin3KxVaJ1jBemQnvmFo5AGKVub33e0kYifkfPT5EaW9nitTxB49akxonXsG8xR
	 PNe1OnsbXuGzS81XpSTVuYv0RK6twW7ryXfLJ+yAQ6stTyUfGrzXMPt5rq+PRY/QTX
	 0G3Af0VrE//lZh5p6pK20KeUN4qA3EaDNJCEHy2N9jfALuc7dB+uExNnL5KN8DfT1f
	 yhAtRTsh3W9THd1vqjwo6XYR58cbStkIAwXWO6SkfUMejByHUpM+jvAcXtKnbK5uFE
	 qvxyXLCfbmdgbE6hGJNuJnzQJJU8h1YLd6cr8eNo+/OB5F843RFOsV4H3CJDQ7eS3h
	 dG0gXfnRmzHyQ==
Date: Tue, 26 May 2026 11:42:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, jyescas@google.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Message-ID: <20260526-laughing-hissing-starling-7e088e@quoll>
References: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
 <20260525-acpm-tmu-v5-5-85fde739752e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260525-acpm-tmu-v5-5-85fde739752e@linaro.org>

On Mon, May 25, 2026 at 12:50:25PM +0000, Tudor Ambarus wrote:
> Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
> to allow temperature monitoring and thermal management on Samsung
> Exynos SoCs 

"on Samsung Exynos foobar SoCs" or "on Samsung Exynos SoCs (like
Google GS101)", used on "faz baz boards".


Best regards,
Krzysztof


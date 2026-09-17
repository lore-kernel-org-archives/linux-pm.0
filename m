Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C84E50AB;
	Thu, 17 Sep 2026 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632701; cv=none; b=noKBYaJK0U0zyMYlU4vGPBGXnDp3cXBvqjNACmfaRLeV2oa+c0Hz1Bd0GSS4zr2cfd2wsyCdRPd/45dce2O6R2Go+T3P+nBqFs3IFcG62BjVtVXx6JZTJ/txjfkcFUPkoY24Ik1eHoDbOWgooPSQpv+YldNlX5TRR8BFFcXhytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632701; c=relaxed/simple;
	bh=iWtD4KtSIinvyAz/cSGAyfF+qqhETmFIb9XFQ8CJULU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT6MSEFD/fh3IrjdSNgdkHi5jLjkm/7IsSbz23nVqj1UKCNhf4rP2vyeJcha3AZpXdzDp+CqLe//D/XE2qS0RDdZANDXVa1IEy3iCkIJ3hyhhYYwOkA7JiAHRLcd9pgcO8mTsb0XUDZyC7BslzmW2Z1EwHHVOaats3SGQIsmJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOpm035e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOpm035e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EDF1F000FF;
	Thu, 17 Sep 2026 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789632699;
	bh=xKFlmy94vGms3q+8yoOryQB2R7lIFvrQJ2IENZn4QY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZOpm035eWyG8a9NKUBPJ7ynlFx1LEbAVQ2UIy9fUjwMrqEDUp6500b4FdfC7TaL8K
	 AQZeLdcJ3NT0bFXb7Ko7GnzF4jiVKJfx9RD2tf6los9vAP2HsQd3keqfdrNnS/DiQt
	 ZWrtC56j84I6lc4YmrEbbQwCgH41ELqc/xuazy96bJ49UMuPh6Mjb28gHx3wTAg39e
	 Gy9xOsOgECq9onHZxHzlIyh9E1H0xtCKSvYhV8nIqeCeEnXpxWCRWEYmVebfw/NPc+
	 CnD7gDXwHTZPW+ZY3kfJo7JBm8DU38Rd0PvsdGlbEiNGYTvjL97rUmH1/ExtsDdqUF
	 fe9Yevo7ibzKg==
Date: Thu, 17 Sep 2026 10:11:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 03/20] dt-bindings: arm: Add the actual power domains
 on U8500
Message-ID: <20260917-humorous-galago-of-tornado-e4ade5@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-3-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-3-9d0c17e1f816@kernel.org>

On Mon, Sep 14, 2026 at 01:54:31PM +0200, Linus Walleij wrote:
> This file has been left in an unfinished state just defining
> the root power domain for the U8500 SoC. Fix it up by adding
> the actual existing power domains in this SoC.
> 
> The PRCMU code and old regulator driver is mentioning some
> *_RET domains, this means "retention" and is a state in the
> domain and not a domain of its own.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  include/dt-bindings/arm/ux500_pm_domains.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


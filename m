Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45B4DE70B;
	Fri, 18 Sep 2026 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731490; cv=none; b=Ma7RfYMGLw3fdI2hvlBJjR5IkHniL6YXFLVUz5i1BiDwdoXToLKUMo3WFpC/PhRfK9+khGBLP0wQScy7R24qSwENPIQv2+pAGkq8ov+YeYzLhlMwxuZKk6cEY7XD5v/gtm0ih1T5X5Jn2+d2E/0T4F7JdNTdD1DKFHqFmArfn3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731490; c=relaxed/simple;
	bh=NhcpE0x86WaY3L19vDcMfmEYtxxZPDkTvFPvMJ1x3ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff5yjAjQBd+XHFZon5hf6v+mvCU02yKj6KWy8madCAZB3UYEaRxN6cxvk/0qIPD5W/yTgpFP+FC9TlOdMwWqGdvSyJpdYT8XHsoUGqziG3O+SeNILzckHx+UpzSNvL85omv22ScfpymWoFXLiCLxNzo2hU3+Q+T12mMRR0/Kn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFvekzFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFvekzFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C05A1F00898;
	Fri, 18 Sep 2026 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789731489;
	bh=NhcpE0x86WaY3L19vDcMfmEYtxxZPDkTvFPvMJ1x3ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YFvekzFV/BhGm83OLudte0Mksm9JDZLcIOjq9OxmVjcT5wRz9Gr7dEpgfBQxFXHHu
	 NJpg7mWtiAOAaTsyL1N9IMfz7leMvwd00DogqrXlXIxIJhQxEkAXVcZeI8u2It+uPd
	 bIfSdZA/Q87xj1eB0Zrd19PJlzE80Ilj4w579X3lfnsz+4lGix2AUm548CqsQp+/0K
	 sunL6xZCuKn65mLdFWStJQnyRpIVjsJSvtlzonPrtlWt1Xsm/kQSseldoQ/FDxCFsp
	 yrRi2991ROKw7vDljvclqiWfYtZ08G/UEwkLtUXdudUxs16r6LeF63B47pseb2AXJo
	 2sD7FFeiT5r4w==
Date: Fri, 18 Sep 2026 13:38:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Elder <paul.elder+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGD4_VIO_DP_{TX,OTHER}
Message-ID: <20260918-masked-tidy-sheep-b326d4@quoll>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
 <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-1-4c72d4e086dd@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-1-4c72d4e086dd@ideasonboard.com>

On Thu, Sep 17, 2026 at 09:04:40PM +0900, Paul Elder wrote:
> Add preliminary clocks for testing:

What is a preliminary clock?

Best regards,
Krzysztof


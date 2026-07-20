Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101893CAE70;
	Mon, 20 Jul 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579758; cv=none; b=MUyOvZ07lirWtEImiwU3QN3ufrfnLGGaYybVQEJwx7/PMY78CSpr0gJxdJKqyZ7Z5e8fIDCTGbepxPJYjj+eHQLd+UcZpHHXgw+EQ6P/g2cQF6UM+I2rqJUB0/bduX2a6gjLGPxCORhsiRuyzaPiRD3Om4sMr8PfWAhS1ZDbJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579758; c=relaxed/simple;
	bh=pp6BuKwi5mIezs3aAwvS1dq6Kg3L/K8Jae9WXJgUUUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSKaAul2WolR16zqajW3ZZsq3k9+FO3iP046LVitdZghQnZ0JfYalooLX3FU88T6Qij9XSrgr3I1gBAepNBvfUJ5cs4AJqD51B/bI9HV1fc2htFokEeyJnxnKcrzl/L0wmq3Z4kpNkZFiGbxDQWH3owwmXNtCqoPJT/jG+gMR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYFIrDhq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYFIrDhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6AD1F000E9;
	Mon, 20 Jul 2026 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784579756;
	bh=Y6k47DHDLrgdeP2ZF/O9P1LWoHXAMcA5gUJWHGzyw9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eYFIrDhqeRI6eUAv/k0V3JTsGxyT5UWNMgEDbINO1AmAIDstDpG4etffhAd4Ml8jD
	 bS6wcF0gNuId78L2bm0f5T9//fTBWTcEJTIe4A1KYB1LypKYLnyJ/sy7FlHWD1LJpA
	 t0KcFZcCCLmeZpnlOKYtTWYGsq4eEnrCj2oTs6VHg0RAVJP+82Fa/0GoYiwTCQHOIv
	 WBWU6v3MSJneLHfD1ZOsUzjvrfJ+T63GOPL9/yqPHh77hi+9WM+Idj7ntgBEvbUnUX
	 ThYrBdnqiL0UmuiCDgWSZ+i52I8mNJ2HUNasPxiiooF+bZOSiRuJQRFcSC9WVN5MM/
	 jR1Yx4x0/5UHA==
Date: Mon, 20 Jul 2026 15:35:56 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Purism Kernel Team <kernel@puri.sm>,
	Hans de Goede <hansg@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: maxim,max17042: Fix temp types to
 signed
Message-ID: <178457975481.4022231.7625231689277846005.robh@kernel.org>
References: <20260612215315.1889039-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612215315.1889039-1-robh@kernel.org>


On Fri, 12 Jun 2026 16:53:15 -0500, Rob Herring (Arm) wrote:
> The max17042 binding described "maxim,cold-temp" and
> "maxim,over-heat-temp" as unsigned values, but in-tree DTS examples
> use negative temperatures such as a cold threshold below zero degrees.
> 
> Document the temperature properties as signed int32 values so the
> schema matches existing DTS data and the driver can use signed helpers.
> 
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/supply/maxim,max17042.yaml      | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


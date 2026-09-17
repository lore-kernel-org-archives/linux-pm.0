Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9F3DBD41;
	Thu, 17 Sep 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632729; cv=none; b=O+AIDfyAtaCGOpgc3PZuZPGMh8XcAyQYvI0bikxr5FILLuCAY12+blHD5DGOqXPtCjALzxVIv0cDEbTTOn1+XZyUBa8dZFFKEnj4uog3HDm594LBpiva8Bp1x5PpBBuWdQt865amWD/P5rDNIGZoYpgve+7R8W/KF51f+Oys45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632729; c=relaxed/simple;
	bh=he/mLpJPeG5WY0aOST3w7t6rYKioUJa6Vmb538U+47g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqMhtqgK41MWKGJ4iq5JJACgCOSqaHAH5MPzjNoeungUUrdtpRynQUAjjkJTGPAXfbD5HqOm4XdkBK/+FuUMaso/fD9bgoDF/VEY/DFPya7HWAvpfgdOoe7/o+tvOeDmZcvYDGe/82mYPwFjPiSwXuVSqfqnI4rpvXobGlQmJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDrCaYvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDrCaYvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1651F000FF;
	Thu, 17 Sep 2026 08:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789632728;
	bh=NSTRHR/rrHtZcDQWeuQqQHPMcDnerGUSIEKdxd7ZRjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lDrCaYvk+RDoeQwFfRiuikgEhkgxPBbY+9EtZvD2oQ1JxgoXZDeev9hK8+c8fzpbF
	 hSSTPag8TnonwJuAgoZAEkn4mhoYRjZw4BfHE8iIWh4BslX+uTHhxGvbMWcJlIzhIY
	 2VX0RAapm6yQBibVy3MjYiohmC1hUOc4ZUl+u8h0ps47g0zIevr0FeQY8YkV9H6foF
	 D/O7SHpkiaabAlfCwBxvffuXdGUKEQZ9YYgk9WgmxMi+OnmId3Bhl10TIBYeJzXMeq
	 2qJ7wDcSugQFkQvY8iqsRmZ7UOImmv3g4q55pOg1iFhQEMcZhqE3HQ/JLCeXZr/TTC
	 I/VuuVmvyadpg==
Date: Thu, 17 Sep 2026 10:12:03 +0200
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
Subject: Re: [PATCH v2 04/20] dt-bindings: mfd: db8500-prcmu: Relax EPOD
 regulators
Message-ID: <20260917-archetypal-hospitable-auk-39afc6@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-4-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-4-9d0c17e1f816@kernel.org>

On Mon, Sep 14, 2026 at 01:54:32PM +0200, Linus Walleij wrote:
> Allow the VAPE and VSMPS2 compatibility regulators to carry power-domains.
> 
> Stop requiring the EPOD regulator child nodes that are being replaced
> by generic power domains.
> 
> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../bindings/mfd/stericsson,db8500-prcmu.yaml      | 24 ++++++----------------
>  1 file changed, 6 insertions(+), 18 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C03EB7F8;
	Thu, 17 Sep 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632572; cv=none; b=CbeFRdTDEFuYVpLoxJ6Zxo1yc7sC6fVeVfBUFCymiohVzkfajhm1brwruewqmqJQiyNlAuWkGz4m7r0NUzNPXsOmHapGSIZueHk91O0SrJeREHcd2hOw6v4febREJ20IPabL4dDF+xWHhaVt9NyLqjeMzTGkOw6MYyD7vIJdtM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632572; c=relaxed/simple;
	bh=hnzo5OuwdGzMqY+suA7RQ6qymDPictDenfcvZJQb3FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNyMHgpsDFtCKhh+GcBgLFWD0ag6qDO8PpsLBBLoQu0ii2EdZSPkQPVYvbAX4sYZ4ZPJ/UGBOMBClB25ldQsTipy0O+a/2vknXzKbuovS9Ru/FfVIikrTVqjLkQEQK0o+DmNM8CTwxRil14axFsomSM1wIiT8kuBkUuuK27yA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTSdDuI9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTSdDuI9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F383A1F000FF;
	Thu, 17 Sep 2026 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789632571;
	bh=sbes0882iMbhpDutz94uKHFUZV6ExaVjEgbOPnw20JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lTSdDuI9KbA/YNynTcioXRA66l6F0PDbH0/e9a+5mYdfdy85aJM0vAdPrZwQI1B+N
	 No+jizLoau/ThooMkRqmLDZm/Jk4/5GY4z6sDi6PcuI1jOTk0jocBvaUE/A9+8V5j8
	 RzLKzTnjN3z9g4rZ+VrcaEpbehMCgIb2c0o709WGjCRfzjy/TtIz+FAGCLG17WhKvf
	 OMg0oUfnK+qFnK/3sHCRgIdoTI6Xkxw0jNrv42dp7y6Kwuofym0kkKRm3IivPd6UxI
	 HWwIiFBxEp1fu2Z8Dlm7hvL0UTkGQtYpmnob0jJC6JmozrNWWGuLWPl3i5+0MDMPxQ
	 +Y6PYW3fD2vTw==
Date: Thu, 17 Sep 2026 10:09:28 +0200
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
Subject: Re: [PATCH v2 02/20] dt-bindings: arm: ux500: Drop NR_DOMAINS
Message-ID: <20260917-arrogant-onyx-weasel-e59f06@quoll>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
 <20260914-ux500-power-domains-v7-1-v2-2-9d0c17e1f816@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-2-9d0c17e1f816@kernel.org>

On Mon, Sep 14, 2026 at 01:54:30PM +0200, Linus Walleij wrote:
> Keep the internal Ux500 PM domain count local to the only driver
> that uses it.
> 
> Do not expose this implementation detail through the DT binding header.
> 
> Assisted-by: LLM
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>

I would say Suggested-by, because it is not a bug, just preference.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


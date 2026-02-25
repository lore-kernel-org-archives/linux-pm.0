Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6A38F946;
	Wed, 25 Feb 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772016289; cv=none; b=glo6dKXy1Dt8C8FmB4uuvRmKH9gBSoqURFrYPn5qbTT2Y9LR00k44L8BBXsEZegeuhNGYvwH1mzz/Veu8VQV+0xcOhJPPxBLNbbtNEyKdr/V/kUv3dPJtBT0+m7ykzG9jGuYRgFcDgr85z0uWtKd93PWW2TO2nX8Zduby6McwCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772016289; c=relaxed/simple;
	bh=KyCLMU3AVldJTAilKqpLlpOgqYOCYCEaaZ7788+5WuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTGzZRnc+BhPstS5UCPo6uVnFtQQeB8mhHbL22or920lP4ExGqqUvw4ScAlPgwPDZkO0y8dbjAuKkfQbOEjVP+J6ckcUNGgnt5paXpcLl4JpAx8/KO7cbmvBMz96KYoUYkmzV8wt3f7usa8GQXlKT3PzT4tVH+XWQl7u4efx82M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlVqE54u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlVqE54u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36CDC116D0;
	Wed, 25 Feb 2026 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772016289;
	bh=KyCLMU3AVldJTAilKqpLlpOgqYOCYCEaaZ7788+5WuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YlVqE54ukITA0aDTd8VxkGNArXaXsfsan4niE0yvhPtNYg8YE0zoKR2vGZa864lmQ
	 fcfsjVPzN0CEKBLqaXr5arlX18IO8g0vQ4vp6gbyoOhd10j0mcx98409m8N3ulX/xM
	 lcDiDSt/ZVpM+9s3Z8VEh61vEtcy3qUrP488XNMge0f+3/tdVqgbxx4OLMqLhENMOX
	 xSNGRqcx3VQi74lehWIEgMw8XoLFpCX07AoKUo7yGjdf3J1tI5AufxSguTSUQDDOzG
	 x8Wl601lTLfubip+dMuyTrh13zBS55aHPv5psqMk7s2GCg76OXPKCfEv5x7Wmni7eN
	 ct3oopxr12Xnw==
Date: Wed, 25 Feb 2026 11:44:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Nam Tran <trannamatk@gmail.com>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 04/13] dt-bindings: power: supply: document Samsung
 S2M series PMIC charger device
Message-ID: <20260225-secret-amusing-cuttlefish-d3bee5@quoll>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
 <20260225-s2mu005-pmic-v3-4-b4afee947603@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225-s2mu005-pmic-v3-4-b4afee947603@disroot.org>

On Wed, Feb 25, 2026 at 12:45:06AM +0530, Kaustabh Chakraborty wrote:
> +
> +  This is a part of device tree bindings for S2M and S5M family of Power
> +  Management IC (PMIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
> +  additional information and example.
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,s2mu005-charger

Review from v1 still applies. I think you ignored several reviews, so I
will mark entire patchset as changes requested.

Best regards,
Krzysztof


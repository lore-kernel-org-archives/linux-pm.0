Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794830340;
	b=uOicX5quINkSS4meH4TWZPuoOpu4falK0yaha9InK71qoXtaOtyvmuji2F1uXVeOMbea
	 ke5bUB9WcnMgGQBn8AWdm+/S7qBkIcsKiES4bKimDiJ1Jj4AhARJbLQ839gRZ7Mv30eTa
	 X5kHMig47BY2O7b5C4OcT6xnzA7HASIbWU7jYT07T1OxCMRcBRQ4znS8NrguJaoCAKwZl
	 GWP78KwvWN4ZoOAkl49Aqt3f0VNGeQc6KznPT8TV+RyhUsEkLcAzhvZfsrg1YjOxdDWOv
	 IKIJ3R5DwBSQqmGCFCcKseUfVIL8AXXTIk8nqpWYvwuzkAJl5+1v/cmrhyXR7y5PkAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794830340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KXBcB6uNW5ouM37NwNEoi+ql5ySZLImh0lVzkayzOW8=;
	b=4VgvJJZRQuo6+6wEsoiaOMWFF0Oh4WOoRcvP758nUp+6wliyg1yK9xqJ7O8oBklMHzSY
	 HqWaUlY1OR+8zqx2K4pqkUrXbcAbCdz3voxZpBnyEH7QG7OMo97KflstkKW2iRw75HRik
	 2rcJsKNpbaWZX14zKIR1KZzeWuU1qrUzaE/MptKUliKAXcE31vcGwzaePrr/gsvvnh3d4
	 x6ZlbbMpqI4iG2s3Bm9jYeCaKgbE6iOjIxmwRdhxMgUZHPeWF7tK4dJs5gX6pr/Tgh/4L
	 ICOcigLP5GuOeFW2Sy6pSTpnQhn6ifWJIbrAgUUqRj5Z9chwJunsBmE2uUgAzsZgmYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiSN7I8z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E95606A32F;
	Mon, 16 Nov 2026 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BiSN7I8z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B61F000C4;
	Mon, 16 Nov 2026 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794830340;
	bh=KXBcB6uNW5ouM37NwNEoi+ql5ySZLImh0lVzkayzOW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BiSN7I8zzul/TLEoVVXXETvMPwnfgHpJ3hMMm2vBW5DCJhPoowDg9uxZSCVz6P8/x
	 Rjw2LXfBbTYvB2WOSlLGKL/hMpW+cxPfVg/D0IlgIGyMCpT5xtq1VbvI7rEzXf66y6
	 xotCsLsU6WNAxhM8EqudlvxJ6C+H//scMQTnwBRfrHCWZr+NzXtSSea7e5RzPc+/LU
	 pFcaJ9YT3RC8yKV/+1LmFzryG1CUzQ1NSuJjn/XoBbkLtrf9XXejx8usok+LVLJGE9
	 tx9IyRQpKgz/B0QiU386uxOw82bn3ey9VDZx6/CSszGrBjz8TCbAbz3W/HQm7kP9bb
	 6ifnMAojaFwWg==
Date: Mon, 16 Nov 2026 12:58:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: power: domain-idle-state: Add
 system-state
Message-ID: <20261116-icy-free-lionfish-c3eed8@quoll>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
 <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261113-s2idle_state-v2-1-ad604182e7e7@oss.qualcomm.com>

On Fri, Nov 13, 2026 at 10:25:25AM +0530, Maulik Shah wrote:
> Some domain idle states require system-wide coordination and are not
> applicable while the platform is up and running.

You repeated the property description. Say something more. Why they are
not applicable when platform is running? So if not running, when are
they applicable? Why?

> 
> Add a boolean system-state property to describe these states.
> 
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/power/domain-idle-state.yaml       | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/domain-idle-state.yaml b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> index 4dd4f59bbbec..b19952f6225d 100644
> --- a/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> +++ b/Documentation/devicetree/bindings/power/domain-idle-state.yaml
> @@ -45,6 +45,12 @@ patternProperties:
>            state will yield power benefits, after overcoming the overhead while
>            entering the idle state.
>  
> +      system-state:
> +        description:
> +          When present, this state requires system-wide coordination and is
> +          not applicable while the platform is up and running.

So when is it applicable if not when up and running?

Best regards,
Krzysztof


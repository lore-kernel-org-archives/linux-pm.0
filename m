Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A571DE3B7;
	Wed, 15 Apr 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289698; cv=none; b=aogV9K87xQTFnHAHWECy4T3lWiZrOOymbr+cO8GbFE4TvDejKoyAQnflxnMt/T1FW6ZKqnVnStk5g6n7cISfJiEtHF02n73dDUsKHuKsvt8QxM7XkbW3U78DrS12V2kcTE+zdDc5kRbownR3oene1fAhvJKC/S67+7rY7MeXcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289698; c=relaxed/simple;
	bh=gAPjSmYjlAZJG9i+cMI+wy3rlcXaGDsPq4l5oXukpWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXKy46qJuDXBEEnA+NMJpo94eWmsEBwrMwJHl2TOWYZ4aKxkIFhUKuuc9NxFA80Df5DZRELAfjsDl/W0WFR3Ih5AIj9MKzZFZ4492sykQHn5IqyQFOpMM1RTazEgNQnoZaCEqjjSmZnjY3iz4+RFizOVCYl1wbN3lnhRRn3JJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akOXoQdp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akOXoQdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E72C19424;
	Wed, 15 Apr 2026 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776289697;
	bh=gAPjSmYjlAZJG9i+cMI+wy3rlcXaGDsPq4l5oXukpWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akOXoQdpYx6F35U2Oi8V/sfnOibsWcJeDCkUV1hZaLCMahRZS7/fN506jwYd9lRQn
	 lU9jov35+5SdAZlC7KczMJm8VO45bBWR7qFyN6uWUDn3nWbQgUmxkdaHpgORFV4amQ
	 XppiywyWSYqj0cZLzTZmGTcHE5WIQFLpnw2yjEtxaYHMcO4T4gKPGJSLRSXgDizRNr
	 2rgGC0+6Xa0n60nS8LN131nt/POlLg48AVdnbT9f8CnhT3Qe9wHH7KyOU2RX+FJJ7h
	 NqZ70IyRHdwn2ciRMFdOWCuiw/wiHhpSV2sWMQ3qE7MldvuRaBc5uxXVSOpo7YYedc
	 x+5uulJZ2jmEw==
Date: Wed, 15 Apr 2026 16:48:15 -0500
From: Rob Herring <robh@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Message-ID: <20260415214815.GA602572-robh@kernel.org>
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
 <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>

On Fri, Apr 03, 2026 at 06:08:34PM +0200, Ronald Claveau wrote:
> The Khadas VIM4 MCU register is slightly different
> from previous boards' MCU.
> This board also features a switchable power source for its fan.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> index 084960fd5a1fd..67769ef5d58b1 100644
> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - khadas,mcu # MCU revision is discoverable

The revision is no longer discoverable as was claimed?

> +      - khadas,vim4-mcu
>  
>    "#cooling-cells": # Only needed for boards having FAN control feature
>      const: 2
> @@ -25,6 +26,10 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  fan-supply:
> +    description: Phandle to the regulator that powers the fan.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
>  required:
>    - compatible
>    - reg
> 
> -- 
> 2.49.0
> 

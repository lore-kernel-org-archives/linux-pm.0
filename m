Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007161;
	b=VKcp4IcjjVYlHMaEj80hIYe979n1pOqJqKjAK/z+5e6jYaHBig9q8+3SUNW35UyunwJe
	 2T1OyHeaHjV8l6krzSKfynPdY5ZvI5GkWVHZljqOUpqtBPFMRrb1DCZouu87DMvXsIC6M
	 cfIb1VjuKD0EwpSQItPiQhfQw35ElPXjl4gyT2Dc+y6LsZMPk68NvB74yXCCzBL/8ilMQ
	 SkU0XMjn6jjw+RvttPPLbO1UvuJjaPP/fPkt06IB+jD9sFAirAC5iL6cgUZldKtfDxbd7
	 uCm3oHZDXzzAB2a0vHD0ND3a/o0kZuuApXRBUmbeFNOUKmQs+JnEWT/MHWF4Klc1Yqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007161;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gyTbs/W4mFLXc6WAFFE2ifs3hVfSY/BJtHwWTBj88bQ=;
	b=4OFy6kDohOD/9OnKg+VkanPef9HseAPza8GCKFJKPJwOYsQQXmP+IX7uMACbSRbiyGpf
	 W0AgtVohwVAmlrUx7iby+3hxIChfE96hlpKfvSBpM+q3QXx5ECwnlbif8KvPBINONEF4O
	 QvsTgObh1omTeYhe3SVyzZgl+ZMGIQHP4Q4DXY6qP4w6ipZLU3llukh9u9oYA4BeJmKRK
	 fUM71c3NLTNmzzPJmBehbFnA1PKBESgHsZo03EO57rObjpU+5C/97+OO9b8NNrLhAQUjl
	 qqYepKkhqh8MhWoxN8WPDW6xXK4HatFaaG4JCkVbsSjHHye+8zkw4QKpaSJ7VKsXGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTrh8iku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB260606A31A;
	Mon, 26 Oct 2026 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTrh8iku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5F31F01828;
	Mon, 26 Oct 2026 09:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007160;
	bh=gyTbs/W4mFLXc6WAFFE2ifs3hVfSY/BJtHwWTBj88bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XTrh8ikuzv3xBwXkdHjxEKOf9zr5of8K8EYbew46UW1bo3/dH2tHaosjjSvXVhFRg
	 5lu7YjiChNsy4yLt9elZ+Vtxa2FbDybyDF59Vm8NgeMiGQpQ7EjcWGwJkIdfo/ODOE
	 3igkBzm3EydRqldfUyTkg2n1uDe9GfiunnkOJhm51kbKzZ0S2tpk+jBAxpFpVFIMk4
	 BLp2vDr9MbFTfiFzStJ3j8G1aw+j5Vh9om83+pY6eA4OUFLLQG6QATAUWbOYKobRW9
	 xWLTgeaMQh+8eAy3xIa8xf06BJjUh+auSl/C51iSGv/bxEtRrrqmlQWZ7Pix/ueDLn
	 CB03P1guhshLw==
Date: Mon, 26 Oct 2026 10:32:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: power: supply: axp20x-usb-power: Add
 the AXP2101
Message-ID: <20261026-glaring-fanatic-kangaroo-313cae@quoll>
References: <20261023100401.67592-1-olivier@mgcrea.io>
 <20261023100401.67592-5-olivier@mgcrea.io>
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
In-Reply-To: <20261023100401.67592-5-olivier@mgcrea.io>

On Fri, Oct 23, 2026 at 12:03:58PM +0200, Olivier Louvignes wrote:
> The AXP2101's USB power supply reports whether VBUS is present and the
> input current limit, like the AXP717's; its registers differ, so it gets
> its own compatible.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml  | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> index 2ec036405ae4..1c582aa5e1d0 100644
> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
> @@ -25,6 +25,7 @@ properties:
>            - x-powers,axp223-usb-power-supply
>            - x-powers,axp717-usb-power-supply
>            - x-powers,axp813-usb-power-supply
> +          - x-powers,axp2101-usb-power-supply

Missing update for constraint of input limit.

Best regards,
Krzysztof


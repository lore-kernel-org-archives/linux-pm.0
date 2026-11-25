Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608069;
	b=iBR4ITRC3rKnnMLPRrqaToIh6oXD9eYqdpgy2+hJuaQnZbWYuw/06A7CyS+Pqpxd9w1D
	 m3DR5dq9Bj5wmyCzKy/HVF5/4rh3t5GC6IPqbQLdj1wadHj/TFK0m53WJxZRUwI37pD1L
	 jOPucn1XBgo7z1BN7thGUnGxsBj4vHRzmMp77UdIeJwpBR5B9pDigge5iKekrFwfdrrLt
	 6U1t66QNIcRxNfgSwhal002d6E2csWeME86BGVYiFXLtk0923z5I1VpiM6tI6lI/LebJi
	 w4rddNuOwYp32PV10NKBj1XkSeBp7fOBNyx7KjAhNeZOtof9FfaCFlAzEOI6GTvzJiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608069;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=bUwHBoFCV/3Z27mWEeTKGjzMbYasPj0mIvhyyLXjasY=;
	b=McyyDagMvyqabGcD6AJGYy2dMG/ycxSYGTEjybZWoYZ9DKkvR9rnZuRfmlltM6zAmYjo
	 0M/CBMisOGmq5fgd9ubsYR0K1tWqGx8OTAH753t5MsZgNpfC5omDvhhYPiQcRo9HsyFYk
	 sfalwcQUxLjy44ozN9VenAI+v4EcjiomOQX3abaZAPZkKVbQ+HQEk0oAHRT+wv+Mc/8QR
	 zUByv/x3+dz2k9yc8ecnPFbt7YKDzN5hQNFJxmGYE4lFwmof4UNvAbAJM85XOsecr4srV
	 7G6QWBP/8WHdNkE9Ympy897xkPVQNXZ8HTdGuF9qFDHDuZN5WBTyVMXF/Oc5ncWO+nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjuIEi9S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB6606A31E;
	Wed, 25 Nov 2026 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjuIEi9S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0AC1F000CA;
	Wed, 25 Nov 2026 12:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795608068;
	bh=bUwHBoFCV/3Z27mWEeTKGjzMbYasPj0mIvhyyLXjasY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=QjuIEi9Sc7PuxMQCTt1tdExnmDMPnhqPqVz1KD3ClP8PdYMtvoSWuOrO6HAYxmPAz
	 CNWlZ2wE9nMs5a4tkTI+4TA+A/PnLIRIm7ZqaeIl69RJ5j4oGwsLL8q1Gqx3qsBGHg
	 Kh5VidsI4cxzflBIqnsp0rWMn/t7bxHO869pzAm5sXNEnxQt2zN1Mqx44esZ0WjAfT
	 GRMCvuQmxemAuuCvhqOuS2OeaaVAD6SXFyc5lq2q5zVx4hvNYI0GkXC9twLWMHkDy2
	 SmzeE/2Pw3QodKnU/mr+Gf4dsi4jtMVvASpsVpnIyJURg97W+G1VcrYL+nsbU+pG//
	 ADodaVfb/v4Pw==
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH V4 1/3] dt-bindings: power: cw2015: add cw2215, cw2217,
 and cw2218
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 shawn.lin@rock-chips.com, linux-pm@vger.kernel.org, heiko@sntech.de, 
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, sre@kernel.org, 
 t.schramm@manjaro.org, xsf@rock-chips.com, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20261124191346.434143-2-macroalpha82@gmail.com>
References: <20261124191346.434143-1-macroalpha82@gmail.com>
 <20261124191346.434143-2-macroalpha82@gmail.com>
Date: Wed, 25 Nov 2026 13:01:06 +0100
Message-Id: <179560806608.84329.5895350466243051992.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-24 13:13 -0600, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add bindings for the Cellwise cw2215/cw2217/cw2218 i2C interface
> battery gauge. It is similar in function to the existing cw2015 but
> with a different register layout. Each of the cw2215, cw2217 and cw2218
> only really differ in the minor specs and the hardware ID they display
> when queried. shunt-resistor-micro-ohms is a property in use for
> multiple devices so not appending a vendor prefix to it.
> 
> Move the minItems and maxItems for the battery profile to a conditional
> based on the compatible string, as the new monitors require 80 bytes of
> firmware instead of 64 bytes.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/power/supply/cw2015_battery.yaml | 41 ++++++++++++++++---
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> index f7bde324153d..992cd5f6a216 100644
> --- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
> @@ -14,12 +14,13 @@ description: |
>    phandle in monitored-battery. If specified the driver uses the
>    charge-full-design-microamp-hours property of the battery.
>  
> -allOf:
> -  - $ref: power-supply.yaml#
> -
>  properties:
>    compatible:
> -    const: cellwise,cw2015
> +    enum:
> +      - cellwise,cw2015
> +      - cellwise,cw2215
> +      - cellwise,cw2217
> +      - cellwise,cw2218
>  
>    reg:
>      maxItems: 1
> @@ -31,8 +32,6 @@ properties:
>        it is to mail two batteries to a test facility of CellWise and receive
>        back a test report with the binary blob.
>      $ref: /schemas/types.yaml#/definitions/uint8-array
> -    minItems: 64
> -    maxItems: 64

Nothing improved. Broadest constraints always stay here (explained also
in writing bindings).

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>

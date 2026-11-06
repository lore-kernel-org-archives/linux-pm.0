Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970209;
	b=vokcaXylONkV7BCqGwkr8w6QLyhJ9DslWGLFlyxkvNXMetNlD2GBLZ/ixN0UmDUSuupB
	 JVzsZFlV6Fep0T2MN//Ung2dAjObN4HCOCVtXY6dHE61TaiGAtJHMgqGYSnsRmrDvkRBM
	 mf1GerDkvHeAbVxYz81YmAzbCt2mckWfXi0bMUejCKGng5deci5ZkKoGbhcxWjD6CWyrO
	 r+f5kMjVo6e8sEZRgp2iq5Qo7B62oHTT6XzuhuspQ4VcAVrcDcSEQbZ/KkvnFMgQ/0Y7m
	 HTagVcMc7o+ZnUnVDthh4ydfy2LgKKPiz2OO530UdcGEOh/VoeHjLhf3B8AXYdwST/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970209;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=G6d9Hyix50ohgjp+hGlcATwp07VnHaSAUW6T9XPYkFA=;
	b=2p7wY/RmTPuccmL/fbfpK+ljYnFKjUn9NksF5KoP5i0lRrL00X5fEkD90ieCotUlnZxu
	 nOzeIBjNvS2JGe12FJQqZ4ck/lXJ7ERJtUeRSZymNoAD+ZZN0EQv6ljgAyp3/5cSrtcND
	 psJjU6EMcwrsjQwqtUwSjE62LWU6EwNfLgJ3tpMr4Kws1KBQQo6qxFjiFH9lyix4+Q7aO
	 McRh986anDklL2bnUhqeqSxOS0+To6Sq2Ue0Is9S3ei9ZF2ifTIprxVuOjMb1aP8AWN3y
	 9ciK+cOPCHEZEnP955cJMg+YspoVrjnblFqOsGj1dsoRWZGmq0hJEA2UI2e1AAjg0QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwDYMQfq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25358606A326;
	Fri,  6 Nov 2026 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DwDYMQfq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CE51F0089F;
	Fri,  6 Nov 2026 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793970208;
	bh=G6d9Hyix50ohgjp+hGlcATwp07VnHaSAUW6T9XPYkFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DwDYMQfqvkMmg3WmeBWqF6ofkcJhvQ66ki9hUrk+LQtOVGt4Et+nsDBL2bwkNgsBn
	 vPEQ1nOzcj+Voc3wcqBhf8XwmXVQCXKyitNyvvPxStzKafKvNK6701rBxQad/lhnQo
	 3LXbwOQmCSsA9mwIyFvvdKxsQ/4qcxQAhz5zHTnRyH816j+G1sq/5PtpciopeFkhyX
	 wqf5ePvvynHVdApJLEmBkMI/32boX6HMnuTuOlDNNcH0TG8rD8V2Plw5/xxc2x2nfu
	 qyFXnoKgPEgg8nyRjIGK1wPc34lidKhmZ5xgNncnds84fxMRDOof8NL3sxotx8WkCV
	 E3AMjTWw8pphQ==
Date: Fri, 6 Nov 2026 14:03:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: Use signed integers for
 coefficients
Message-ID: <20261106-portable-alluring-hedgehog-9e2aed@quoll>
References: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>
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
In-Reply-To: <20261103214357.2700244-1-daniel.lezcano@oss.qualcomm.com>

On Tue, Nov 03, 2026 at 10:43:57PM +0100, Daniel Lezcano wrote:
> The coefficients property describes the coefficients of a linear
> equation used to derive a thermal zone temperature. Both the slope
> and the constant offset can be negative, and the thermal core stores
> them as signed integers.
> 
> Existing Device Trees already rely on signed values. OMAP4460 uses
> an offset of -9301, while OMAP5 uses offsets of -1791 and -2992.
> Broadcom platforms also use negative slopes. Declaring the property
> as uint32-array does not represent these values correctly.
> 
> Change the property type to int32-array so schema validation decodes
> the cells as signed 32-bit integers, matching their intended meaning
> and the thermal implementation. The cell width and binary encoding
> remain unchanged, preserving compatibility with existing Device
> Trees.
> 
> Fixes: 1202a442a31f ("dt-bindings: thermal: Add yaml bindings for thermal zones")
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

drivers/thermal/thermal_of.c still uses u32. Maybe we should have
of_property_read_s32_array() wrapper so the binding can match the ABI
code exactly?

Rob?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


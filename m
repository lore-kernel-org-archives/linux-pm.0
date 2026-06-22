Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC593783BE;
	Mon, 22 Jun 2026 11:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126419; cv=none; b=oIRiFY0TBvskAZ8D883xeziDfGh1CEW+gBZAKkliQ3nGpY/3cfcx7aGLJklMXJxWwhc3r3Zs3hKEvm/btJSKDc5EWCyb7tmnnubwsqfv9/nJt9FroqPJU2FSeA4Tg18W4JhmM560pyy42SXLqbAIlcDtT6+aVJ3j2w2oQJG9+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126419; c=relaxed/simple;
	bh=H3OtbWKIQdcXN72LryqeX9mMIKMbKHa/YGAW8mtibSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QS+3qNCSFwwtxeMFjFEemFFbO7a8VNtatJvooQ2hBdyB+eL4AyVlzr41cODmYIRQmbOxaDrx8McYVTbuXJEkfpxs6cWy52TB+4hNULmOpLpl8hU8ZA9CnXUI3g+oI4lSWEE7YlidZ8aO8AnXFHjPwMfVyfuayHnbtKaCkiGf3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHRFKqkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHRFKqkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD641F000E9;
	Mon, 22 Jun 2026 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782126417;
	bh=oHKjtb6fT61seAkFCx1+4G+n51UfUaaQfsTP82qzf/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LHRFKqkg0UpsQp3g0duGOI4kQDhge3W457tFI857JbXU+K1g9X3XOqL03baaUIY0Z
	 ZFChklZnxyixE7jPhf8VLlqxC62+ckrgp3xJ+7HsaIWBClr9gZFGPUaVHnr9QdVeUR
	 bg3T+ptJtDueUgD19CAuadEnC7pvo0NFhM8Y86r/XWzJLJmDJLM4KWrjDpZgb17ymA
	 3l1S9n2CSUSgkFmjd+tVZC8FZBg8al84ma+dfgjjFH1H0pF6NnrQc0+vzMssrlAXqD
	 5wljh8o9//92SRjaAO+IwjOVSbv1oojpa2MWQcRMjay7Z7dOtOVWp5VVFJ45jUVnHy
	 SEWIHzYzqwpNw==
Date: Mon, 22 Jun 2026 13:06:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@axis.com, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: Add TI BQ25630 charger
Message-ID: <20260622-whimsical-inescapable-pronghorn-5f94bb@quoll>
References: <cover.1781789320.git.waqarh@axis.com>
 <96b7d1a0aa0c00929f0fef2847db116b54079a30.1781789320.git.waqarh@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <96b7d1a0aa0c00929f0fef2847db116b54079a30.1781789320.git.waqarh@axis.com>

On Thu, Jun 18, 2026 at 03:37:59PM +0200, Waqar Hameed wrote:
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,bq25630
> +
> +  reg:
> +    const: 0x6b
> +    description:
> +      Device I2C address.

Drop description, obvious.

> +
> +  interrupts:
> +    maxItems: 1
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Device sends active low 256 =C2=B5s pulse. Type should therefore be
> +      IRQ_TYPE_EDGE_FALLING.
> +
> +  monitored-battery: true

Drop this one

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - monitored-battery
> +
> +additionalProperties: false

And here use 'unevaluatedProperties: false' instead.

With these fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


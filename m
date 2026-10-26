Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007200;
	b=uH1k6z54A/q7XRnZMKYqU6nYgURRuAxu6dtnFDTlSX4yXetd3Jx/Chh5XJSXf1skQOfB
	 zfacKzAgljeh3AncPkaO7M1udAw3ze5ioJvq3QpqljBIwdjW2hTRUr3+Tvd+CP4JGZYT+
	 TBU0y7cY5qBPcdhbdS7+oYR7foPD7PhRNAhqBRlJvOE7oV6xjejW2kKImqsuHDGAVWsvS
	 0jyHkibDFRPA4cfhjEvmO/A4eWwtOqyUi1ww500kR81/UcJ1ZbfxeIDMK5DeJQm1RhGMm
	 oFQQCWTurCDU3iq8qTvpLuXJJLWoFdqdmn66aIRIrDo8JvERfxmOkzmfKKU1ZJwuKrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007200;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/65MG6TY1IxlI+54oX3n3a9kcJsUVE1cpf7+Xy4EseU=;
	b=h20d2LZP+q+Gq2iO7avS6q3oB8RoQdcPRW96+endOw044omZEtqsDzWMBnTZPC0DI4Mm
	 lZdwMPsHjX33OwW48dW8jI4Ki8CTLm3G7dtIOvlAYuB9saRMCOTfTu3YO7pQ6ZOY6kSDk
	 bhwv0I3R6ftp4pSL8udCBNDkD+yBBkhxGFr8F9GsR1CB/gnvxpgFmnl5GTfkagJwxZE4I
	 Q2AXRFph4y3ntbPfPQBzNsOa9BJ9vjnFpS+H3bjqLqoffBGhM8rt3rFuiBN3iqPk/gbE8
	 gZ6zKcWVXhj3eCIr8XlhNUy16MR0zs4zTreQB3MRngaScbaVVMIf0Yw0qoJuYkzQQSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiExYlT9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A1606A31A;
	Mon, 26 Oct 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kiExYlT9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759601F01825;
	Mon, 26 Oct 2026 09:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007199;
	bh=/65MG6TY1IxlI+54oX3n3a9kcJsUVE1cpf7+Xy4EseU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kiExYlT9M/6zZrtyq8bu9vgkM095T5aHNhu1EbnkiVCzNEqlpe4JIewxmeUmPEvu6
	 PDoYynBy9sydwmeksJRu9zR9e06CInAqIsjywCHAeQblsHqXiNO2WBINiewXE4PeWq
	 YegDNaG8lhXEp+l0rSSQHCGVcC/LDsVghthyUxPIiHs9F0Vi4tiQCz48agb+o5mK8F
	 94uK7ekPfHE5gS/+ViI5UKfob4trFJNX2jImWRV7qHSMRzAOtmt+cvLmy7huw5G96C
	 6sQVHpnQYU/W6S5d+pRSvDpxTrNDimo550nUTrfreoodVo15Nlaxg28wSPDniw+A95
	 6ipuwitsMx9YQ==
Date: Mon, 26 Oct 2026 10:33:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: power: supply: axp20x-battery: Add the
 AXP2101
Message-ID: <20261026-calculating-evasive-eagle-1c750f@quoll>
References: <20261023100401.67592-1-olivier@mgcrea.io>
 <20261023100401.67592-7-olivier@mgcrea.io>
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
In-Reply-To: <20261023100401.67592-7-olivier@mgcrea.io>

On Fri, Oct 23, 2026 at 12:04:00PM +0200, Olivier Louvignes wrote:
> The AXP2101's charger is programmed from the monitored battery and its
> registers differ from the other models', so it gets its own compatible.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../power/supply/x-powers,axp20x-battery-power-supply.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


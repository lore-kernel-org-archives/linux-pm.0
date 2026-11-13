Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568438;
	b=FzxmM9mUSXY5qIC5GxWVUOWUfX61v2vCVZXQPiog0qWym//OPCQvLlpMvCJF7ofLqrTD
	 TEFGiq4+1Me8K/BpOrA84pBf92z9UCx06Bwt3bhBIUpAGQ+vsGZdMACN3S5GwhZPJSJud
	 FFgFJ3k5b+CnwMnxCl4EI1oyWBKZFYtoa2WSv+/qkwTYguV8xh5ySGZmSIFaq/JVjVUCx
	 RUyKsgKf9G8z0lJUT69zmByifDMZJ2oafiqMtd8QlMEJyYeEIWqT+nzlWY+9Vte+8TGRO
	 zZPylRZH2pOHe4z6l8FXQrCi9E8BwfwsnBIC/LASmHu08SjINUqSuXervd9vMHG2S9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568438;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y3FPWWAh+XQ+2S0Pz3gDOIXu/qT9hKjIxiZNoW7QkJI=;
	b=zwdYQZ06PU8raV+a/D+WJX4e3r79Yl7uglqbvH0YAP35pfTRYnveiLVQvWGlJn98CUNi
	 4cI9xHOrYZRFxgc7FtLWpK1asdp18z6wtvyWSn5GnnwCvNg4WLhr8HEXpTzgppqRM2ZcW
	 j8NR7c/kQs5wVSQSPGPnmUZRMaenr3tJzWg/KLqq9YjE5b7r+zG11SVTsf9Nk4BujRE8y
	 kidiRZe1ZbCHUZO4hH3s34qkNqZ+L95d+uNNufAH9khYPc3BR5LPfAIKZWhpXnZ2WJ3I5
	 QGYatj6aY6OCeuz0n81hlk1Fj1Ur3s5yzshOaXybXDB6xBW7i2zdt+jcLzIGUIOVAjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejxNbzvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686D1606A31C;
	Fri, 13 Nov 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ejxNbzvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355701F000C4;
	Fri, 13 Nov 2026 11:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568438;
	bh=y3FPWWAh+XQ+2S0Pz3gDOIXu/qT9hKjIxiZNoW7QkJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ejxNbzvJykUJdmXXU7mV3nntqpauhii1G/iQkTNy0J9UAmWUQOBZOLhtC4/ewQd7+
	 9P7oLMsqlavGCLNFMPSIh+q29NgUzXcnfHlTgJ7om/cFLGhx0pbIQJWkClKNAMTOCE
	 emCBZVd23uwJEB9TvP26O3r3fyoSW5CCfx6ZL3/bkp5CW4uqPcKOknIqNGUyC9uQ2T
	 e/06w9oFn+oGozFNwG7GIyIYo0VIhVfMgW/AL1SiBZHq+PWRVwh2hGjuPTMoPhhMUx
	 pEvGl2zGEliBMD8v/YOef3fx5sjN33attpSBomDC6rsuNZ0gPvS4PHvNZHDO2fWwAv
	 J30xQj6QBMEhg==
Date: Fri, 13 Nov 2026 12:13:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Asdlerto Korry <korryasdlerto@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: Add Silicon Mitus SM5714 fuel gauge
 driver
Message-ID: <20261113-fuzzy-awesome-shellfish-2d93c0@quoll>
References: <20261111-sm5714-fuel-gauge-v1-0-b9d163fff6ff@gmail.com>
 <20261111-sm5714-fuel-gauge-v1-2-b9d163fff6ff@gmail.com>
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
In-Reply-To: <20261111-sm5714-fuel-gauge-v1-2-b9d163fff6ff@gmail.com>

On Wed, Nov 11, 2026 at 05:35:00PM +0200, Asdlerto Korry wrote:
> Add a driver for the fuel gauge of the Silicon Mitus SM5714. The gauge
> keeps its results in an internal SRAM that is read through an address
> and a data register. The driver only reads: it reports the state of
> charge, the battery voltage (now, average and open-circuit), the current
> (now and average) and the temperature. The conversions follow the vendor
> driver.
> 
> The temperature reported by the gauge rises with the charge current, so
> the battery temperature is read from the thermistor ADC channel when the
> devicetree provides one.
> 
> The gauge interrupt is not used, power_supply_changed() is reported once
> a minute.
> 
> Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
> ---
>  MAINTAINERS                              |   7 +
>  drivers/power/supply/Kconfig             |  13 ++
>  drivers/power/supply/Makefile            |   1 +
>  drivers/power/supply/sm5714_fuel_gauge.c | 315 +++++++++++++++++++++++++++++++
>  4 files changed, 336 insertions(+)
>

This was already sent.

Best regards,
Krzysztof


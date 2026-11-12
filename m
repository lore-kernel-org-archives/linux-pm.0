Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482388;
	b=CnaLOdABJfjrKbteKYZqXZR5ql9gOnDGxxGI7c8ltCHwQoY3r7SmR7PYpT2PiD9pv4L0
	 QF270K0s+QMlyzjpCpgZhXO5/I7ferzNDgF7LDSvNr6pcCViA+o60Qz41wUyMWlqSc1un
	 mKz33xTu8vikjLAu9NVBumj7AsBiE+mOvPPWj5AvmEhVWvs7HU1RG1R7C0R/VFeXnbhLN
	 5+TYqvTo5E3Fi18h8nEaBf/b8wpBIfiZrtTf7ARKgNV8OP85l6LluuO+w/lVpL/D7jixB
	 LzSkKMxtLYAEFh/HlK4JXA1hGjXd7gioSQdo5mm+Wy0P9V+XL2dl4/HOJ5RNYGRX32g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482388;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eFRlbNnsFxNJDdSSOhcrT+egUX9CqhMx215OxhLWiXY=;
	b=OyAQ/iqngfJjSlXlfeb4IOvpvwD152qqTc2BOw0fc4rfk+CMhfvqhr3EV+JWvoR9h3rs
	 KF18iZ2+vZiBSd065vmFL90HxX74muiCIvD+q5BoD3Z4mjLO5fMSB1pRu21w/78A1eJos
	 T/b//iLi816lgO6Xx9/ipeYdHF9s+D+biBryfQoaQP4Hdx+I+fuMM2gmcWW/DvOn07Jls
	 vho+ubllSwf6vA3epfOD+PgKe6rYof/Uma8RchtkvrhK1DGdnCZbHEO2apeFSqp3Y8+eV
	 RrQ3lj3BhNDz3SN++B2Ik9Cq8j1Kb+HFwViqHHoJc6fRuhO3SqQZswCAx95dUAqKZwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jz5MiQxV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C84606A323;
	Thu, 12 Nov 2026 11:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jz5MiQxV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DFC1F00A0A;
	Thu, 12 Nov 2026 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482388;
	bh=eFRlbNnsFxNJDdSSOhcrT+egUX9CqhMx215OxhLWiXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jz5MiQxVJJlSCIKYLVWCoAV605YByg24tHs7OKmthsdjt0B9LmJZ58O/UwxlOyWon
	 N7ZsC6lyDP4ad4Rip2n2w0+Vo2QEjULa1aSvwX+tfZAWrzUkb9YvyvZkOH0iGXyq+h
	 mKfaGhVppoTxEWr+MUnIjDtyYYwNvJGDnOD9TmdH7MqK5+Fl2v5jBY0Cb+8hY6x2ln
	 o1mpfJf5ehGim4I+B35LIFKztmkvu4dRsorFM2yQvCwpDorvtRbyGiHSdujMFVzalW
	 MoPdJ6GWlLW/emr/9e1tMkp7pH/S+Q1JyvhuoO7Vt1zPUgMQUTlsObS57bh6r4jfA6
	 YD6J4CteyZvDg==
Date: Thu, 12 Nov 2026 12:19:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nizat Mikayilli <nacht@dxdmail.cc>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Silicon Mitus SM5714
 fuel gauge
Message-ID: <20261112-big-vehement-sidewinder-1b6c7e@quoll>
References: <20261108-b4-sm5714-fuel-gauge-v1-0-c659b6c0884a@dxdmail.cc>
 <20261108-b4-sm5714-fuel-gauge-v1-1-c659b6c0884a@dxdmail.cc>
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
In-Reply-To: <20261108-b4-sm5714-fuel-gauge-v1-1-c659b6c0884a@dxdmail.cc>

On Sun, Nov 08, 2026 at 12:22:25PM +0100, Nizat Mikayilli wrote:
> The Silicon Mitus SM5714 includes a MUIC, a charger and a fuel gauge,
> each at its own I2C address. Add a binding for the fuel gauge as a
> separate device, like the MAX77705 fuel gauge.
> 
> Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
> ---
>  .../supply/siliconmitus,sm5714-fuel-gauge.yaml     | 47 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 53 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


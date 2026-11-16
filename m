Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832718;
	b=foeC6bWsjDykmgpxzhtdQkZ/SzW4vBZ9/KcM6SgSEgyXeWNadIf7g8M4wOIucRDcRzvY
	 cr+MzfFgC/49G/ZyIpC0PLd/WC3wK9LaUszVGKWgVrVBLYGCowJHpT84oHJppc8tyyPNd
	 fYo4X7qQTui1GDmLqqohhjG538HBl1iB2n93/cOoiOAeIN/2lvJFIjre3o0QWek6n6o1g
	 FmmKhZE6363kM1yNik91kizt4RzA4g34Tlx8B7rGG+ATQgQzN5Q1tu/XqWj8h2YJfCpg5
	 PF/Jx01r/MKLViPYBRHPTwblGQ6pm/IitiDHn7XmzpJieF5TRICokuIQTiBMeuSrDZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832718;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=chRPPZEtkQsZpGPK+GYVVc3scG1OO897Sopq3GeE2eU=;
	b=liV60Kqs50SAigJqxP/JUfnWaTc+uAane8p1u1JB3m2E13OSDgz5fRymKUHWmeOMVtfb
	 tOvQmBdKb+eWbLAfATfweJjNtoe+0wI7XcVxS03J2M4RcOqFpsamWVSBdmqJ7UiHFm88P
	 3UYUvbS4zWjoELRX+H9M35Uq3VA4kVN1DUlQR9PYyAZXsRIU2Vr0vFCe17PQPnxA4+alR
	 PsJnyPvWnaLG+OIrPA2zN5+wPitDs51R1XcPYv6jHuYiGUB875kqGQ7zdez5hICcYY3ru
	 czH5P+qe596Dl77Y7HoX/5PtpmGRM51SsSerFVJoeauoFVmn+YURgRVkOYVCqN34LGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvpSMzdE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B0C606A31C;
	Mon, 16 Nov 2026 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvpSMzdE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B281F000C4;
	Mon, 16 Nov 2026 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832718;
	bh=chRPPZEtkQsZpGPK+GYVVc3scG1OO897Sopq3GeE2eU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WvpSMzdEdd7vZEMxfqXvIxzXkzgXh+I/KiPyNEts7rqi2MOKm0mI/KKJzdv2d84GU
	 t/2LWzMADvkf9z375s9YTyA1jUxkkRX3fcWijHZVAoV3c0z+binSYsnZvEFJkoYhwK
	 WJDQj96gdvmLFa3FzxNHRR2aPVG8GLMlKP4iTGfyEWkervIKoA0O7Q9Fe+ZaPh0FuL
	 TIPb4ZKZ40WvqKqA+gsjVNTcvfZxuisjlzzNrnHBoDpmZIcWtWAGQa7wi5020GeNyJ
	 6Q8lnWJvj5wfYjvCcORMzL70C0qXhSPyepj87pdinW7H3ZmB1Tj854QV9BCM/wHVEl
	 UAMJdY6YzVPMA==
Date: Mon, 16 Nov 2026 13:38:33 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] dt-bindings: power: supply: axp20x-usb-power: Add
 the AXP2101
Message-ID: <20261116-furious-cheerful-ferret-cbc7cb@quoll>
References: <20261115171150.64431-1-olivier@mgcrea.io>
 <20261115171150.64431-5-olivier@mgcrea.io>
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
In-Reply-To: <20261115171150.64431-5-olivier@mgcrea.io>

On Sun, Nov 15, 2026 at 06:11:47PM +0100, Olivier Louvignes wrote:
> The AXP2101's USB power supply reports whether VBUS is present and the
> input current limit, like the AXP717's; its registers differ, so it gets
> its own compatible.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../supply/x-powers,axp20x-usb-power-supply.yaml     | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


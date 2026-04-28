Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CAE2E5B21;
	Tue, 28 Apr 2026 06:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356005; cv=none; b=OTj7uqKBetug23evYY8Df4XyLL2p2TgY6+rDxTsc8L8jtodIz/fJ99X18zKAeBP5GoqkTWZZQ/mQDLfas47bUsHXjB9ETP9/ItnrnH85L0ab4Mp4SH+h6/HGjsp+lk9X2ucbvbNQI3e0E/a+13eh5OoUrmvxGjslsrX/mSTg4ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356005; c=relaxed/simple;
	bh=eI1lt4QmD2i531JZciYQQXa42LvA228/bB3kvxT5YYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5XG22ak7yM0TDFRpy0Oog/FyYZQdzPvSdw1xOEgJns7O2RPGvgqUO5+VC8e3O9tI0K1gtjEKXJvMRj+mT3/XHndF0s5dQzdM9ZX6pQOYJBrl5e4irAzBroSBUKU1mSpwxQVZQtVeB9MNWH+w3Bt2wzcViJeIrcPAEljK2QKVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsAgBtff; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsAgBtff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3674AC2BCAF;
	Tue, 28 Apr 2026 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777356004;
	bh=eI1lt4QmD2i531JZciYQQXa42LvA228/bB3kvxT5YYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LsAgBtffZz5gwO4JY4gQsJ0+Mo8GSbS67z4Bosv4imV+6i07brNf8FcAEbJSxetpf
	 YdB15OSP6FU4N3XvOYTojgJObkyAQigPffSoBk9FkXei9NoRx0Xh2v+MUUm++ks41A
	 ACt8AIe0UyrlAuUQGS0asPfg28RRSV8gCDcIh4RtEyQ8AgfXScZo1UJABEqIUgXOfG
	 ZP/VLV24HcEqeMzckbltFu6KPnIjp2a82BCp3fhGJD8I1shDMfOSwf0DTX/LDWMHS/
	 VWEh/rJpXa+1DHmxD4CICMNt4MzKwWnVoyvmwlKE4qLLMtkCkpm9cbx544oVfrE2bD
	 yusBFoxQkVf3g==
Date: Tue, 28 Apr 2026 08:00:02 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Nam Tran <trannamatk@gmail.com>, =?utf-8?B?xYF1a2FzeiBMZWJpZWR6acWEc2tp?= <kernel@lvkasz.us>, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 02/11] dt-bindings: extcon: document Samsung S2M
 series PMIC extcon device
Message-ID: <20260428-blond-meerkat-of-gaiety-4bfed4@quoll>
References: <20260424-s2mu005-pmic-v5-0-fcbc9da5a004@disroot.org>
 <20260424-s2mu005-pmic-v5-2-fcbc9da5a004@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424-s2mu005-pmic-v5-2-fcbc9da5a004@disroot.org>

On Fri, Apr 24, 2026 at 01:09:01AM +0530, Kaustabh Chakraborty wrote:
> Certain Samsung S2M series PMICs have a MUIC device which reports
> various cable states by measuring the ID-GND resistance with an internal
> ADC. Document the devicetree schema for this device.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/extcon/samsung,s2mu005-muic.yaml      | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792482531;
	b=rTIpL9K0FLXEcs4RWCwQ+Om/17v4Dlxh98156AhcrcY4r2ohmyaDnUieWrlw3H84F1jZ
	 44cqKGcjJpOezmoi5b8rHK2dCzk3XC6SwmrPcnPmx24qDQb5OuFzkaqFCKm1FOY4vunJy
	 z+yTOQoq0NPe84wijIf/yxHi4MeodpKviuSOn6NIb5L2YP6yAp+GRyneNwzhU0S3ZA1EH
	 9Cq0JHpJPiOiLZqJ2uPhEeyZ39JXzd1y6FXsrCGnYqLhBvMFPKlCqEPnyGje+I+yP0mWc
	 A+WEtxfz9G8LGTbs46KhAMujlM1Fzmm8zKcoZ9QiJoUCptpVOPfLBG5eiUlWuwAAu/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792482531;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5WJejRQ1dgLFBOCLqpRd0Ns7FKSaoNZt5CDN08Xrzlg=;
	b=jG+9hkQJ14h/R03BF3v+jF9nKwuHigQX8+V4bkQpM97EflfhTRpKui1byQydz8dau7or
	 N2kpICL8BsTAwcSEmoXz+e8WJQ26oW4cW/hakC9lu2gO7IerKcusN+hufWX/YHuCgR6+Y
	 xmayDHK0tHMZNB2Z7AVGAa4m1EQ/zFQtK2BKH+E/bPXeVceXfgLkjMqAOxY2Ql6ctbrHA
	 6y6GcRwLMV6/0H9sQ0VO22O6UNqadaeQo2NUPZE2IL/uTeWjNqzfjhP6ANK7yExdmHr04
	 6rSBH3fyYa3aZLdy/XUrS9EaEfNQ5ddt1MYYerwwFbK4NGtn8UIb3LrWXJ141nlVdrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJO1cqhE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D940606A31C;
	Tue, 20 Oct 2026 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jJO1cqhE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB251F000C4;
	Tue, 20 Oct 2026 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792482531;
	bh=5WJejRQ1dgLFBOCLqpRd0Ns7FKSaoNZt5CDN08Xrzlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJO1cqhER9m24y9G2WFTQFQJdrrtrclU9RWpPBRzwdUVmkBtDYu6m7LVWHPxqidR6
	 fojzGOjbfBrfmOcvkduyH66Kv2koCMbw9v44ZzxHHOcmw7H9qn4NNLd920zevtNDek
	 XB6mg4tqeIUW0G6xHamk4UjHadf40YN4ZOfJ2ZU+hTOkZpMzX7HX+vJ/SerbNunK6n
	 xAfP5uCGnsFxjc0L/2kSe8sgdFrwCY5OJtpGfgJbZwlpiHIDttBGR6IvTKB1lbiGbl
	 AEQJyJjTeEKTP6C9LcWJQff6sPPrn7pKSBTs9o6LljU/6Vlq7LEf+M5CerSYsu8Mrf
	 phwBuvPRP27Uw==
Date: Tue, 20 Oct 2026 09:48:48 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linghui Wu <linghui.wu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: regulator: qcom,wcn3990-pmu: document
Message-ID: <20261020-fearless-boobook-of-philosophy-f64de4@quoll>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
 <20261019093911.3199891-1-linghui.wu@oss.qualcomm.com>
 <20261019093911.3199891-2-linghui.wu@oss.qualcomm.com>
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
In-Reply-To: <20261019093911.3199891-2-linghui.wu@oss.qualcomm.com>

On Mon, Oct 19, 2026 at 05:39:09PM +0800, Linghui Wu wrote:
> The SW_CTRL GPIO can be used as a wake signal on platforms where the WCN
> device needs to wake the application processor.
> 

Subject is incomplete and this is somehow buried in RFC huge thread. I
guess this is still RFC.

> Document wakeup-source and require the existing swctrl-gpios property
> when wakeup-source is present.

Best regards,
Krzysztof


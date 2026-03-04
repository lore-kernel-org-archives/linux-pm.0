Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAA36AB40;
	Wed,  4 Mar 2026 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624198; cv=none; b=tLVoODo8xxjIGO5yCv9T++9peFyo+6HHky4pPzlYQ2epR3qliZuH396IuXJ0C2lAvbGMqEDL/fZ/bWQIi2uXFzV0d/GwHSiIKQNHgBUcogbSJB/8Ic012hOAl8Ui4l9oFFqpbOwTvwiHKeeJhNU0aPMcy9K6Gv5hUI9IT1GZZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624198; c=relaxed/simple;
	bh=fVa2FI2dmPWrKtEOJmEyVjPJeA/foOm5/Q0jw7iXxek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lt3gKnxFbiE8efCa/LnEvoL6+11kz+gOxDtWzLG+pkrqyM2cHZQYwDisny3oOWTP3GFdQUBme/KrUwZWGYVCIZov/f1QFtIn3qV9o8BhkXrha6wkpmYC4kdArPUVjO6xi+QYlwnA0X1A+qrMLt+Vq5zZN1PjImXe1TSunQFHdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvmMP9gA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvmMP9gA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7920C2BC87;
	Wed,  4 Mar 2026 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772624198;
	bh=fVa2FI2dmPWrKtEOJmEyVjPJeA/foOm5/Q0jw7iXxek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvmMP9gA0GssHmtBPON5JEeQJuSLVeu5NXmEVMbrdRKr5AnWqdcB+Ay9LX5RnbPfD
	 QOuXdkKkuOXRqR8uVhmk8mV/6fGKcS9z6sCt2XlwmiWxGc6Iit0X50z/8XY0PUU3Vs
	 jsu6O1EjldggUixchqLHn2ALouWE0IzuYSz8nbEBKJMB/DqxArkmM2nbbppEZWpeLm
	 e/OYmev6Jo0unA/XN3TTJEAh9kfGVr7KzK0ytxpo7bK1N0VXtIxVhXyRByftUAOmPE
	 vkJcllMQGTYU61TpPQsGJmaTzCc198pLSDA93nfeIxQH6C6uS0ATeA8N/vNmPE9Amp
	 HQ9F9/SxiDFIw==
Date: Wed, 4 Mar 2026 12:36:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Support for Allwinner A733
 PCK600 Power Domain Controller
Message-ID: <20260304-succinct-russet-stoat-fab9e3@quoll>
References: <20260304-b4-pck600-a733-v1-0-2f54efdb8cc2@gmail.com>
 <20260304-b4-pck600-a733-v1-1-2f54efdb8cc2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304-b4-pck600-a733-v1-1-2f54efdb8cc2@gmail.com>

On Wed, Mar 04, 2026 at 03:43:44AM +0000, Yuanshen Cao wrote:
> The A733 PCK600, similar to A523 PCK600, is likely a customized version
> of ARM PCK-600 power controller. They share the same BSP drivers in the
> package provided by Radxa, with the only difference being the lack of
> resets.
> 
> Therefore, document A733 compatible and make resets required only for
> the other models, as well as prepare the PD definitions for future
> device trees.
> 
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
> ---
>  .../bindings/power/allwinner,sun20i-d1-ppu.yaml        | 17 ++++++++++++++++-
>  .../dt-bindings/power/allwinner,sun60i-a733-pck-600.h  | 18 ++++++++++++++++++
>  2 files changed, 34 insertions(+), 1 deletion(-)

Thanks for the patch, nice explanation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


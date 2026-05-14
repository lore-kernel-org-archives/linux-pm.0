Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F143D813D;
	Thu, 14 May 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778764823; cv=none; b=RZqpAIseer454QPgMAxZqqUhGDGpSxmUWopnPAs8S0X7y4/XzqR5ZR12TxX667tCU9/6MlxSpgLuiBk8xW5xHhnGu/IkfCh4MPChdCBWOvXROIutu9XKr3kzbA7p5Poj+acCgTriqdzbCRWzF5ATfoFwvJnwQEGpB8xVWGSUrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778764823; c=relaxed/simple;
	bh=pR9BOXtYiFjzO6X76WSQtBq8aCv5MCF6r7vrgFaR8Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJCjp6/hSg8f284oh8JsXQzc8sdlInFw33o1SAftVz9moI8tTiVNc13gkajDu31gvNOPa4uJTYRins0s5rEAnNEl9E8GIBSz9SNXkJ/i16EOXTgmWwxqnR0RCxs9GjMoBEmpyidfr4dqZ5d6QsAVpK02RrTMVf/ZMWoPPaxur04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LImBuYoP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LImBuYoP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E3C2BCB3;
	Thu, 14 May 2026 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778764822;
	bh=pR9BOXtYiFjzO6X76WSQtBq8aCv5MCF6r7vrgFaR8Qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LImBuYoPWhHUqrmOqycIrL78+O4wPmLD2rcwyDU9o+hy2HWQnfdPSGmPuPXAMEulB
	 kXtkb/AxfRRBEaEovssZXkA1hBrdf5v6jmK4RTOkbJaksIscBRLJr001+jt7HSs+MM
	 1CNIJU7WeZcA3ll6PxYSi1Gg266l6cXZ0x1ci8ibEZaeFsXpGKK5JYS7+8nc7nzyRc
	 8wFTbkz+twU85BkEhIJ/4keizknO2kqrDMQXcT9wrwW05Uvf/Nwk4EBSW7xeFKvBbn
	 88jFT8I9DlM0ZNNELKmheSsjaLR9epdO4z9wh1LOp4jb4PImER6noSdjK2CUZGdB8X
	 wrKiEa2RScpHA==
Date: Thu, 14 May 2026 15:20:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Lee Jones <lee@kernel.org>, Srinivas Kandagatla <srini@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: mt6359: add mt6323 PMIC
 AUXADC
Message-ID: <20260514-elite-shrew-of-prosperity-b6a25c@quoll>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-2-3efcba579e88@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512-mt6323-v2-2-3efcba579e88@protonmail.com>

On Tue, May 12, 2026 at 08:18:16AM +0300, Roman Vivchar wrote:
> The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
> temperature, and other internal measurements.
> 
> Add the devicetree binding documentation and the associated header file
> defining the ADC channel constants.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |  1 +
>  .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   | 24 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


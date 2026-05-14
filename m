Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF642275B15;
	Thu, 14 May 2026 12:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763447; cv=none; b=GhtmsHAARwcXl/PHc74tirvZrbZ544pYn7cc2xyr5DGiStK3Q9wodMFMJ6F/arkRlwEBN5MMp/kJnyp/qgM4jE32IDA7diirEN0rwsI4rSvEkWGuqTfO5yt+TUOxNuxUg5oDjD/81IF5kaMMBnn1AdYBL2BYDel3ujR1W78y9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763447; c=relaxed/simple;
	bh=AKwZQs2wlVU5d66RzEN5Yeb4ReFmnHAO0+173C7d698=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kps4j4uXctpo+/QN/WqwVhaOKrmsq4ZzWoFNF7b/QqUMRgeZBh/EBxlnxK+wuOCtGmW2XHfD5lfRTTCrHQsgWhDvaXp+tYM734UKmwvo9LbnWFUDGeyMqgRYtFVsPCDz0ZnVV6YnDdlNRu+3gwMKkWRQ2aTcML1JLsijJ/cFsoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWHqLlK/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWHqLlK/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39F1C2BCB3;
	Thu, 14 May 2026 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763447;
	bh=AKwZQs2wlVU5d66RzEN5Yeb4ReFmnHAO0+173C7d698=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWHqLlK/wIwM/uCBb2Q7orVLvYK+1zY65FUJExviSdXrbpFG3rZp2RkmRNGEA9xLy
	 vUlzRSt2sjt4Omv2vT3nHOZV4QLnETOk8XwsbcrTVjjIHjMiAkdzNX9nAHPIZAPvBZ
	 fvFTsNC2+etSzMbeMG1XqkGkCbeDivxa2L5MMOMvUYoEjqkk/4tNS0yh/BxO61h5WT
	 jFYVylaVULZdpPU46QKFfiAn6jH7lantX+Qte39+kTFwjApgi+zhy9i2EAqPP7seqG
	 4GbFfz+2ly06YxzppyjZ7D2JBdjUfgsOaS+fwyH84bFJaF1a8FXlUfUufs6zDZf5Qv
	 aFSS24mrSXWlg==
Date: Thu, 14 May 2026 14:57:25 +0200
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
Subject: Re: [PATCH v2 01/16] dt-bindings: iio: adc: mt6359: generalize
 description for mt63xx series
Message-ID: <20260514-abiding-honored-mammoth-78dda0@quoll>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
 <20260512-mt6323-v2-1-3efcba579e88@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512-mt6323-v2-1-3efcba579e88@protonmail.com>

On Tue, May 12, 2026 at 08:18:15AM +0300, Roman Vivchar wrote:
> Update binding title to the MT63xx, since the list of compatibles already
> includes mt6363 and mt6373 which don't belong to the mt6350 family.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> index 5d4ab701f51a..2e8857e104f5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: MediaTek MT6350 series PMIC AUXADC
> +title: MediaTek MT63xx series PMIC AUXADC

Honestly that's close to churn... Do it while adding new compatibles.

Best regards,
Krzysztof


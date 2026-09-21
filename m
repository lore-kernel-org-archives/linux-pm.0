Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103483C1081;
	Mon, 21 Sep 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987063; cv=none; b=XYQQtAQQtjeNqGj+yPn3Q66JNCQ7Gp2S3UhtllDmmww4cvbKlFQhS5EavJ58RqDsZcI2LopST83irTq8c3Qkw8e0XJY7Vw6IRV1m20zPcdNhl1j25VsSdQr4V0qNV+pfLyOJe/aPVO56buBVaFMUB+zHB3bCo7uE2wh/bF2arSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987063; c=relaxed/simple;
	bh=s5tfGQ9gAxXHj++YoLLRdSqIzPeYCvALiQy+qEXoTMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgIlaExi9mlkQAjxkoWjNFqJLV4a41DiNreRx4uVNRqDE6IMxT3c3J6evlJ+678hPtvjXNlS5UiFwpObJV2/L4WTB3Xu+pb6tbp0T4BnoRdhwOfA1vbERZW0zPg1uWl/RzIsw1vWr0m8NW97bHJjZotM5qaAEm9nTsvL18rIp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zqfpw35g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zqfpw35g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789987056;
	bh=s5tfGQ9gAxXHj++YoLLRdSqIzPeYCvALiQy+qEXoTMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zqfpw35gzxYJv+ToFK9pr0yMyQPJ3kDMtZdJUaMn/t996IR/WqfwAl5g5SIVPttvv
	 qj8CBE9BfRwPS4jkvkLV0ShzmdcUNURqGUjGoh7pYJSltmmFI2anQqMVPe7suo40aM
	 IiIiWA8/jUBcU68L/8FeCsYUw6yQhNCar3eWjjOeUJjT9l2uP/yv00U6MxEI5aOedC
	 f7x4pk4ftC4hxVD8Ehtfvd/wVYGDTzkO6nuXYE9ySsU3lA/Ac6/yGphhQrc+m2+yck
	 r4VEyjWCu3iJcp9MtvystFeWvep3xAh5bAC60MLJDJku/e8dov8R56I8AwsvpceSk+
	 btcS9NSBByVug==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E630317E03B6;
	Mon, 21 Sep 2026 12:37:35 +0200 (CEST)
Message-ID: <8fd92e56-85c6-41f2-98d0-3b3422ef2c1a@collabora.com>
Date: Mon, 21 Sep 2026 12:37:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mfd: mediatek: mt6397: describe the
 RTC's nvmem layout
To: Ryan Brue <ryanbrue.dev@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Eddie Huang <eddie.huang@mediatek.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rtc@vger.kernel.org
References: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-0-558b8f95cfbc@gmail.com>
 <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260917-rbrue-suez-upstreaming-mt6397-rtc-nvmem-v1-1-558b8f95cfbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 06:57, Ryan Brue wrote:
> Four of the MT6397 RTC's alarm registers use only their low bits; the
> high byte of each is storage the clock and the alarm don't touch.
> MediaTek's documentation names them RTC_NEW_SPARE0 to RTC_NEW_SPARE3 and
> assigns the first to a fuel gauge, which is what a battery driver reads
> at boot so that the reported capacity does not jump across a reboot.
> 
> They sit in the RTC's always-on domain, so the driver can offer them as
> a battery-backed nvmem provider. Allow a board to lay cells out over
> them.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>

Makes a lot of sense to me.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> index 3cbc0dc12c31..5c89c589b53c 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
> @@ -81,6 +81,15 @@ properties:
>   
>         start-year: true
>   
> +      nvmem-layout:
> +        $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
> +        description:
> +          The RTC carries four bytes of storage that neither the clock nor the
> +          alarm uses, in the high half of four of the alarm registers, and
> +          offers them as a battery-backed nvmem provider. MediaTek's
> +          documentation names them RTC_NEW_SPARE0 to RTC_NEW_SPARE3 and gives
> +          the first to a fuel gauge.
> +
>       required:
>         - compatible
>   
> 

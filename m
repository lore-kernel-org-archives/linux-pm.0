Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBB37C90A
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350386; cv=none; b=DsvqEvStNLjZ7hxZ5unVvTG7OSXNn5TWHC0FCFNrDAhN0x4X1YnLPAbia9iUk+pP2xs3aEL6ZXMBu1FnRi7ikKzh3yyPtjyzUt7eemiOhwuS6hDiwa2AeNLVyZ9nwHC5BCQw28UVg1l9iY5wsEG+Q92tagXx+OMmPaYB7YJQTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350386; c=relaxed/simple;
	bh=en9TJCaqy1MuIvhKYReP2ayHhrKYlB5jdQFzgnSb/ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UeQEQhNu3plTXbXc6cZ+EMFHqKnsyVbtLQq85MZhfmy0a9EV9EfsAm+KJXkqxRZVUf7ccfHRQVFw08lQQEwBamI+HG+gX2lSulrYaJVtfrC3spFU+o+aQvbammxrxq/25S0UHAytculcETRdXz+qNtgqO93Z1zxTeA4oL5CSA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VxphIvmd; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VxphIvmd"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b77b150aso29631935e9.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Jul 2026 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783350384; x=1783955184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7QdVjoOKtxuvUEU767FFuHnfqMD1JnXubUuX2zL/s8=;
        b=VxphIvmd6CTWR2UrEPfwKkOcYvx3jMESPBlkXuVSt6gZ2OsG55BtpltZWQauLWuubP
         5OsnmJ2lxJkqIcUKGpg7ieg5I+3AYt9Ro0e0J7CktHkWITtCz2FZYET8S7d6vJfu+CQi
         P0N1hNDzn+M7xCdUPxl1V4Lwe8kkjZlEh1gNZk2ptIZjgZvz/7XYssX6jXxJCwre48wQ
         ReGp3c17eaB5dRv1uJs8PdoJfqNo/YWGTgDNZbOLH0fgWKDyk8jO1CDP30yl8Z0EA/zW
         CZhXYHLA1Cd5QnqvFTLkS+FfqVxiI4DxMnszVqA2WQ4u9dYBfhrrlOZcKQsWDbGGaXG1
         sbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350384; x=1783955184;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7QdVjoOKtxuvUEU767FFuHnfqMD1JnXubUuX2zL/s8=;
        b=klGiPCJ3/UsCPQQ8oWrw1rPsh4whv3i+ACS54bWoGHMcgDV2B553ZIOSTAqDlEn9TY
         Z5ieXvGaxqY8xuX5COjbRygweQSNTcwovgJ7YysEa9/bxtHd4cjWtplHoV6bauSThq74
         3anAAKCnsZrOqnl365ztA7RDxpWrL8zKWJYBTJiJc3gR0LE8Qm01IQFW6XcehhlFvfsw
         h07XRnCwa0MX2ExMwYK8r3TnTWJUyYRGCCHbzJhU1yTOrakg+6REkIn217OE+iMWdFcz
         mpAVS1a8gjnHnt7laBIHOwNHdpT7rSltdbEpw1alskpVf2DXFJ7i1qg8qmenrgq28jxb
         RdJA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0+EiccfXA0KH2jR7P4+XMaJ1M4YGGmlDbHjuXkP1+SWkWmsnxO7od1BhuW8An9Kuq+RXzM8KepQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OhLIdbYoLqpWM5+z0IgZsGqBs9EJTcSCazSeJvVS12uqmKyS
	uAvVOQlo5UJGgPW3K3y2TrdOphsk6wZmGsQ77dSA41dSp573Jbkm1U55hzJNNGFwG14=
X-Gm-Gg: AfdE7ckPQjV/GbKk266erFiFDbX4MLC5PMxKF0U1NI3PIjCB38ifIYyghOWT4NtemJs
	S4Z3FmdKWd2JOybyn50xeUhSiCfGC4MWt+/F1FxeWRKCGDn5MW7nUyJPtulIUvsq+KqSjZ4JtWV
	JOaykL86e1laChh0xOCN7QDbgbqokXUyq+YwUWa1x423KqpI+xPBjJee7mIzNuKcl1yXnuKYi4e
	2ksEQ7g2lFHPGraHATqBs0TWi6St/PbWVP1gaa0iwl/ecXxcA4PSdVaWArYiXaIr4cD3rORQz0x
	FKSY9nRQEtIZz5ZGpAx8S1AokpSrebrD6AwyUP6qeMG7/tPS+FqKhMmwW1qUxxXWvTIbNJ29/s9
	D9W8iUEJ75K68uEmYXJ29uf3XmaSKLHPlHhVHwzOqv3UkkYSAjXHESeitJPDqfHKnMD4laJ9c44
	Eo0ZhdUAlNu1bANuR6C/9tKA8h+avwLrQxi1iHQ8qJM9HpYyJFzpBeH/QULmzr
X-Received: by 2002:a05:600c:6990:b0:493:915b:dc4a with SMTP id 5b1f17b1804b1-493df055999mr10670715e9.8.1783350382884;
        Mon, 06 Jul 2026 08:06:22 -0700 (PDT)
Received: from [192.168.1.136] (48.85-85-171.dynamic.clientes.euskaltel.es. [85.85.171.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm291903115e9.1.2026.07.06.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 08:06:22 -0700 (PDT)
Message-ID: <a275b0b4-30c6-4a9e-bcd1-56de269423de@suse.com>
Date: Mon, 6 Jul 2026 17:06:17 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: power: mediatek: Add support for MT8196
 direct HFRP
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 ulfh@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, nfraprado@collabora.com, irving-ch.lin@mediatek.com,
 macpaul.lin@mediatek.com, aford173@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 justin.yeh@mediatek.com, kernel@collabora.com
References: <20260701121920.19347-1-angelogioacchino.delregno@collabora.com>
 <20260701121920.19347-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260701121920.19347-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2026 14:19, AngeloGioacchino Del Regno wrote:
> Add support for the HFRPSYS direct control power domains in the
> MT8196 SoC, controlling power for the DisplayPort and for the
> Embedded DisplayPort Transmitter IPs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   .../devicetree/bindings/power/mediatek,power-controller.yaml  | 1 +
>   include/dt-bindings/power/mediatek,mt8196-power.h             | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 07f046277f8a..070c6e5666dc 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -34,6 +34,7 @@ properties:
>         - mediatek,mt8189-power-controller
>         - mediatek,mt8192-power-controller
>         - mediatek,mt8195-power-controller
> +      - mediatek,mt8196-hfrp-power-controller
>         - mediatek,mt8196-hwv-hfrp-power-controller
>         - mediatek,mt8196-hwv-scp-power-controller
>         - mediatek,mt8196-power-controller
> diff --git a/include/dt-bindings/power/mediatek,mt8196-power.h b/include/dt-bindings/power/mediatek,mt8196-power.h
> index 0f622a93c807..085790bf8124 100644
> --- a/include/dt-bindings/power/mediatek,mt8196-power.h
> +++ b/include/dt-bindings/power/mediatek,mt8196-power.h
> @@ -30,6 +30,10 @@
>   #define MT8196_POWER_DOMAIN_MM_PROC_DORMANT		0
>   #define MT8196_POWER_DOMAIN_SSR				1
>   
> +/* HFRPSYS Multimedia Power Control (MMPC) - Direct Control */
> +#define MT8196_POWER_DOMAIN_EDPTX			0
> +#define MT8196_POWER_DOMAIN_DPTX			1
> +
>   /* HFRPSYS MultiMedia Power Control (MMPC) - HW Voter */
>   #define MT8196_POWER_DOMAIN_VDE0			0
>   #define MT8196_POWER_DOMAIN_VDE1			1


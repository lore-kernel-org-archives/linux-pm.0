Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730B4387361;
	Wed, 15 Jul 2026 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109423; cv=none; b=aON++IqF6d0O+DAt68+PN5cInvqNp8Yq+yHEo46t2/qsrewJ3lYwe114SokqmvJrS5cIkOY76QiqFxV2hHs5SueqdML2aCfbuMDIwQi7lVUQwTHrvbAa9s11j8naQamg48WZ1jKLk7XCFFKw4mNtz2Ria4a48IF1dAdladmph5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109423; c=relaxed/simple;
	bh=OW/79ZzwiOczh73BlYcxy3dAlykMdIAPkOsugBdp0Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LD64DRcYFLpGcDEVIbM8miVQYqf6jzKc/20M/KM1EtCIn560aMqqVxJGfOhtY04X88W1IfAZzS3PLUVY2sMZban+iNl8FP4Fzok/AJVR9DaCTgHGIDZ56oX8wxmQh0oEaxf9crPUl73tZg3OpG0ZsTRnFAKN5r308pk/NmF6L2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pSe05non; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pSe05non"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784109420;
	bh=OW/79ZzwiOczh73BlYcxy3dAlykMdIAPkOsugBdp0Zw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pSe05nonurkAhJsuBt2yEIQ5fPi41vauOhuIe9sf0w1XEIalfqMYITjaeZL9pFlMm
	 ekZjq00uuCno1aOoslDMoOsi9A3ewW0fpirsf9zZlSfLuXFEkUCIuQYpfspuy2+wJK
	 WYldNiOD8XceM9PxzSXBCdg0Uz2vWPwtTLGoPyPHhz/7+X0VX+/AKRbBQaRJqCNt1a
	 YId3go6YxasMtI/DvWlg7EtGURu9CTkUm3fB3rvgT9MfU6V2Hu457xi7TGD8v20lVn
	 m4hCQDv01OpY8ewAg8iWOISTyt0eAdON8lvD6F0IPQf04ncOb5x+Zdhu9tafNbt+DV
	 t003zfAbnqEfA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0839B17E07F8;
	Wed, 15 Jul 2026 11:56:59 +0200 (CEST)
Message-ID: <9a4c815f-8db4-40c3-8f02-5c66eb5b0fc6@collabora.com>
Date: Wed, 15 Jul 2026 11:56:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] pmdomain: mediatek: Add support for MT6858 SoC
To: nikolai.burov@jolla.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
 Nikolai Burov <nikolai.burov+review@abscue.de>
References: <20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com>
 <20260714-mt6858-pmdomain-v1-3-4f09bbb822e0@jolla.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260714-mt6858-pmdomain-v1-3-4f09bbb822e0@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 15:43, Nikolai Burov via B4 Relay wrote:
> From: Nikolai Burov <nikolai.burov@jolla.com>
> 
> Add support for the power domains found in the MediaTek MT6858 SoC.
> 
> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
> ---
>   drivers/pmdomain/mediatek/mt6858-pm-domains.h | 462 ++++++++++++++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    |   5 +
>   3 files changed, 472 insertions(+)
> 
> diff --git a/drivers/pmdomain/mediatek/mt6858-pm-domains.h b/drivers/pmdomain/mediatek/mt6858-pm-domains.h
> new file mode 100644
> index 000000000000..6d85835115b4
> --- /dev/null
> +++ b/drivers/pmdomain/mediatek/mt6858-pm-domains.h
> @@ -0,0 +1,462 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    KY Liu <ky.liu@mediatek.com>
> + * Copyright (c) 2026 Jolla Mobile Ltd
> + *                    Nikolai Burov <nikolai.burov@jolla.com>
> + */

..snip..

> +static const struct scpsys_domain_data scpsys_domain_data_mt6858[] = {
> +	[MT6858_POWER_DOMAIN_MD] = {
> +		.name = "md",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.ctl_offs = 0xe00,
> +		.pwr_sta_offs = 0xe00,
> +		.pwr_sta2nd_offs = 0xe00,
> +		.ext_buck_iso_offs = 0xf20,
> +		.ext_buck_iso_mask = GENMASK(1, 0),
> +		.caps = MTK_SCPD_MODEM_SECURE | MTK_SCPD_EXT_BUCK_ISO |

MTK_SCPD_MODEM_SECURE_PWRSEQ

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> +			MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},

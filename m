Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8603B9DA8
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628301; cv=none; b=BMhK8KpFUJnI3xldDYznnsAY+yMP/bW4UvV15Mr83tx9DvUPzSzostgY/KulXGfzeFGNFoo72IFdj6H9gx0HmEAVpzp/Vp4R4BwzbPQTOOyUx+mzvqCj1GpSdUsJWUALZ21adgCYOHBo7ftYJ54dhfXE1lZDEgsRvl4L6ZvTuMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628301; c=relaxed/simple;
	bh=c2mbIJ23muyg/XH86YqNHsHgv2SvmkDFFGP/6yzLkIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qY/dp2lW3DVJ9X4chPdlx0EA449l+9AOCxXfzzp9UkQyuzhPutSXGwCttmWsvMd88MuQQkq+Q6XtEg1uePuUmnXkOE+aBHTmkkjL6FtLIoAWNrLc2k9/0bXX2eGuYfHNeVT67a2jCK59ir9otx1jb23G6MVDoF2/J+FsZtiGB/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GbBehys/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GbBehys/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so19773225e9.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784628297; x=1785233097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MvCJoNx6P8JyO2gQ+de8z3mTHIzAT8UjKxCOt5SwOI=;
        b=GbBehys/B/49khbd48VyMjxuYtcDBn77IBh31gwAv1sPMRh31oSY5RAKzvdI/C46eV
         uXBpGCjY3kjmXs7OZ5zWJJz/aYWuKCYth3p1wZdt7n+c4ZGg6eG/fFTkN2EUgzraM+gY
         Oj8oFGtQdSOHYw8NXIUkrMYHHDYygH7YYPK1ZzCWd04EEXBmw7QkJa2Cqu+Bg21YwsZ0
         P5uk3eaz2Cicssd+KPkswWX7/5MIRDQFTYahKno46OzTHQGyvaZSvSEOw9Xkp8kfW/wU
         rVNTrh1Hy48HObHSFdtn6GgEgeQkrnbzCfpUxSmZ9qhkUXWxmUDC4WoVy5JCfn8dfFwp
         0QBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784628297; x=1785233097;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+MvCJoNx6P8JyO2gQ+de8z3mTHIzAT8UjKxCOt5SwOI=;
        b=gUusKFfYG/8+5nyzGL+c/a7BoHr3M2R8a1WURIEztQTQIn5NSjddsIMncAaxnsVNuy
         coldtQNxrc7p+iNSSCTzJ/LRDjCL6w3v7rsFDaOg+fDQpADaB+F2ypnRmcLRauTmHL10
         ehkXlra+LG6vRN4+EG5ih57EGu8mfGANfu4K+Hq1ByvTM+BNX5sMSyPE7YiMPoqlU7st
         n3siYvDpt3UOWJzhVujhNx7Ri3Ai5S8s+Xn/CkvWPhRHLfqGSOwNwmGXn0hgUj7tAeDD
         QNgOIys0ktJZcYASDhcuzDpl6qhyL2DhoptuSWKl53IrkneCqVZXeKLGJrtpGCQVmsZY
         QSbA==
X-Forwarded-Encrypted: i=1; AHgh+RqoOUf5GYaAFvxhuKPYNDfOQjifRiLMQpY8HMoRxDdpEXXWTwxcU8IYCQAFKSy7fN/3epYYRHQryA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpydjMw3J5wq089eUUOI1O9Gn3h+gG0pPM+BSJ0wB4oPRkB6C
	AInZGFbLS9sGVUbFPI6z80/YJHGpgiguWDoqbEPqrRJalHd1MG8ptC5jAf5Tf/5h820=
X-Gm-Gg: AfdE7ckawKpXO/a+yL6gISr/pQTqfVd5lp64UtGAXHr5Y2uyAS2PMGiJ1uQErOBH9M6
	W0CxowJwsJPt8STa+u9j46AGLCjDLE+JJEjknOuI8nnKACerol77v0EIZGVjIEgQc+2ciQeR4ta
	u9NcHNorJIP1CFjx2r6JbnXaEHIZ7keosFu88VV2cali4YnJf3EIa/QEH8Xjg0MqQ0FRuoRtjzo
	5oiQDbmkzGn/cHfK/Rz4FrWmAs/VeQgJFclUYVQK+0/ujLYKj7g5613WBNBfEnujmTyreFTk2MS
	8kuWs7Ps11sizOjlte2ujRcCumSBCi9sr+S2ArxTiahj6x6yFL6y5emc+8HMpbxrIDmMliQ0cK1
	lkRDsf6mzh2XPZr8PF+PafSXnmYq6Kp/Ws6ZbaXLekybt/qzCD4rHaigQZ9XaNUe+5D4AqNSBH7
	7Y31N1oDHL/z66IPPxFdIKiRoyMM1A03pilFZ4oPjD7qWdKyJaI8L1X66RPwTy
X-Received: by 2002:a05:600c:19c7:b0:495:5e3d:15e1 with SMTP id 5b1f17b1804b1-4955e3d1937mr95248675e9.16.1784628297079;
        Tue, 21 Jul 2026 03:04:57 -0700 (PDT)
Received: from [192.168.2.177] (48.85-85-171.dynamic.clientes.euskaltel.es. [85.85.171.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547323bsm58981695e9.4.2026.07.21.03.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 03:04:56 -0700 (PDT)
Message-ID: <73f21476-7416-4d28-8d8d-e80d951ebd3a@suse.com>
Date: Tue, 21 Jul 2026 12:04:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] pmdomain: mediatek: Add support for MT6858 SoC
To: nikolai.burov@jolla.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pm@vger.kernel.org, Nikolai Burov <nikolai.burov+review@abscue.de>
References: <20260720-mt6858-pmdomain-v3-0-8966d8de93c8@jolla.com>
 <20260720-mt6858-pmdomain-v3-3-8966d8de93c8@jolla.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260720-mt6858-pmdomain-v3-3-8966d8de93c8@jolla.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/07/2026 22:46, Nikolai Burov via B4 Relay wrote:
> From: Nikolai Burov <nikolai.burov@jolla.com>
> 
> Add support for the power domains found in the MediaTek MT6858 SoC.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/pmdomain/mediatek/mt6858-pm-domains.h | 466 ++++++++++++++++++++++++++
>   drivers/pmdomain/mediatek/mtk-pm-domains.c    |   5 +
>   drivers/pmdomain/mediatek/mtk-pm-domains.h    |   5 +
>   3 files changed, 476 insertions(+)
> 
> diff --git a/drivers/pmdomain/mediatek/mt6858-pm-domains.h b/drivers/pmdomain/mediatek/mt6858-pm-domains.h
> new file mode 100644
> index 000000000000..177b2e86ab1e
> --- /dev/null
> +++ b/drivers/pmdomain/mediatek/mt6858-pm-domains.h
> @@ -0,0 +1,466 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + *                    KY Liu <ky.liu@mediatek.com>
> + * Copyright (c) 2026 Jolla Mobile Ltd
> + *                    Nikolai Burov <nikolai.burov@jolla.com>
> + */
> +
> +#ifndef __SOC_MEDIATEK_MT6858_PM_DOMAINS_H
> +#define __SOC_MEDIATEK_MT6858_PM_DOMAINS_H
> +
> +#include "mtk-pm-domains.h"
> +#include <dt-bindings/power/mediatek,mt6858-power.h>
> +
> +/* TOP_AXI registers */
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET		0x0c14
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR		0x0c18
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY		0x0c1c
> +
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_DIS0		(BIT(0) | BIT(1) | BIT(18))
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_ISP_IPE	BIT(2)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_ISP_IMG1	BIT(3)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_VEN0		BIT(12)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_VDE0		BIT(20)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CAM_MAIN	(BIT(30) | BIT(31))
> +
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET		0x0c24
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR		0x0c28
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY		0x0c2c
> +
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_ISP_IMG1	BIT(7)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_ISP_IPE	BIT(8)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CAM_MAIN	(BIT(9) | BIT(10))
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_VEN0		BIT(12)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_VDE0		BIT(13)
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_MM_INFRA	(GENMASK(3, 1) | BIT(6))
> +#define MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND	(BIT(0) | BIT(5) | GENMASK(15, 7))
> +
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_SET	0x0c44
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_CLR	0x0c48
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_RDY	0x0c4c
> +
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_CONN	BIT(8)
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_MM_INFRA	BIT(16)
> +
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_SET	0x0c54
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_CLR	0x0c58
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_RDY	0x0c5c
> +
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_MM_INFRA	BIT(11)
> +#define MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_CONN	BIT(12)
> +
> +#define MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_SET		0x0c64
> +#define MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_CLR		0x0c68
> +#define MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_RDY		0x0c6c
> +
> +#define MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_MM_INFRA	(BIT(20) | BIT(21))
> +
> +#define MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_SET	0x0c84
> +#define MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_CLR	0x0c88
> +#define MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_RDY	0x0c8c
> +
> +#define MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_AUDIO	BIT(6)
> +#define MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_SSUSB	BIT(7)
> +
> +#define MT6858_TOP_AXI_PROT_EN_MCU_STA_0_SET		0x0c94
> +#define MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CLR		0x0c98
> +#define MT6858_TOP_AXI_PROT_EN_MCU_STA_0_RDY		0x0c9c
> +
> +#define MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CONN		BIT(1)
> +#define MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CONN_2ND	BIT(0)
> +
> +/* {IMG,IPE,CAM}_SUBx registers */
> +#define MT6858_SUBx_PROT_EN_SET				0x03c4
> +#define MT6858_SUBx_PROT_EN_CLR				0x03c8
> +#define MT6858_SUBx_PROT_EN_STA				0x03cc
> +
> +#define MT6858_IMG_SUB0_PROT_EN_SMI_ISP_IMG1		(BIT(0) | BIT(1))
> +
> +#define MT6858_IPE_SUB0_PROT_EN_SMI_ISP_IPE		(BIT(0) | BIT(1))
> +
> +#define MT6858_CAM_SUB0_PROT_EN_SMI_CAM_MAIN		BIT(0)
> +#define MT6858_CAM_SUB0_PROT_EN_SMI_CAM_SUBB		BIT(1)
> +
> +#define MT6858_CAM_SUB1_PROT_EN_SMI_CAM_MAIN		BIT(0)
> +#define MT6858_CAM_SUB1_PROT_EN_SMI_CAM_SUBA		BIT(1)
> +
> +/* VLP_AXI registers */
> +#define MT6858_VLP_AXI_PROT_EN_SET			0x0214
> +#define MT6858_VLP_AXI_PROT_EN_CLR			0x0218
> +#define MT6858_VLP_AXI_PROT_EN_STA			0x021c
> +
> +#define MT6858_VLP_AXI_PROT_EN_MM_PROC			BIT(8)
> +#define MT6858_VLP_AXI_PROT_EN_MM_PROC_2ND		(BIT(9) | BIT(10))
> +
> +/* PWR_CON registers */
> +#define MT6858_PWR_ACK					BIT(30)
> +#define MT6858_PWR_ACK_2ND				BIT(31)
> +
> +static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt6858[] = {
> +	BUS_PROT_BLOCK_INFRA,
> +	BUS_PROT_BLOCK_IMG_SUB0,
> +	BUS_PROT_BLOCK_CAM_SUB1,
> +	BUS_PROT_BLOCK_CAM_SUB0,
> +	BUS_PROT_BLOCK_IPE_SUB0,
> +	BUS_PROT_BLOCK_VLP,
> +};
> +
> +static const struct scpsys_domain_data scpsys_domain_data_mt6858[] = {
> +	[MT6858_POWER_DOMAIN_MD] = {
> +		.name = "md",
> +		/*
> +		 * Note: the PWR_ACK_2ND bit is not used for the modem domain.
> +		 * Skip it and fall back to checking the 1st bit twice.
> +		 */
> +		.sta_mask = MT6858_PWR_ACK,
> +		.ctl_offs = 0xe00,
> +		.pwr_sta_offs = 0xe00,
> +		.pwr_sta2nd_offs = 0xe00,
> +		.ext_buck_iso_offs = 0xf20,
> +		.ext_buck_iso_mask = GENMASK(1, 0),
> +		.caps = MTK_SCPD_MODEM_SECURE_PWRSEQ | MTK_SCPD_EXT_BUCK_ISO |
> +			MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe04,
> +		.pwr_sta_offs = 0xe04,
> +		.pwr_sta2nd_offs = 0xe04,
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CONN,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_CONN,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CONN_2ND,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MCU_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_CONN,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_RDY),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_AUDIO] = {
> +		.name = "audio",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe18,
> +		.pwr_sta_offs = 0xe18,
> +		.pwr_sta2nd_offs = 0xe18,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_AUDIO,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_RDY),
> +		},
> +	},
> +	[MT6858_POWER_DOMAIN_ISP_IMG1] = {
> +		.name = "isp-img1",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe28,
> +		.pwr_sta_offs = 0xe28,
> +		.pwr_sta2nd_offs = 0xe28,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_ISP_IMG1,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_ISP_IMG1,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(IMG_SUB0,
> +					MT6858_IMG_SUB0_PROT_EN_SMI_ISP_IMG1,
> +					MT6858_SUBx_PROT_EN_SET,
> +					MT6858_SUBx_PROT_EN_CLR,
> +					MT6858_SUBx_PROT_EN_STA),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_ISP_IMG2] = {
> +		.name = "isp-img2",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe2c,
> +		.pwr_sta_offs = 0xe2c,
> +		.pwr_sta2nd_offs = 0xe2c,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_ISP_IPE] = {
> +		.name = "isp-ipe",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe30,
> +		.pwr_sta_offs = 0xe30,
> +		.pwr_sta2nd_offs = 0xe30,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_ISP_IPE,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_ISP_IPE,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(IPE_SUB0,
> +					MT6858_IPE_SUB0_PROT_EN_SMI_ISP_IPE,
> +					MT6858_SUBx_PROT_EN_SET,
> +					MT6858_SUBx_PROT_EN_CLR,
> +					MT6858_SUBx_PROT_EN_STA),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_VDE0] = {
> +		.name = "vde0",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe34,
> +		.pwr_sta_offs = 0xe34,
> +		.pwr_sta2nd_offs = 0xe34,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_VDE0,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_VDE0,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +		},
> +	},
> +	[MT6858_POWER_DOMAIN_VEN0] = {
> +		.name = "ven0",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe3c,
> +		.pwr_sta_offs = 0xe3c,
> +		.pwr_sta2nd_offs = 0xe3c,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_VEN0,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_VEN0,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +		},
> +	},
> +	[MT6858_POWER_DOMAIN_CAM_MAIN] = {
> +		.name = "cam-main",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe44,
> +		.pwr_sta_offs = 0xe44,
> +		.pwr_sta2nd_offs = 0xe44,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CAM_MAIN,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CAM_MAIN,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(CAM_SUB0,
> +					MT6858_CAM_SUB0_PROT_EN_SMI_CAM_MAIN,
> +					MT6858_SUBx_PROT_EN_SET,
> +					MT6858_SUBx_PROT_EN_CLR,
> +					MT6858_SUBx_PROT_EN_STA),
> +			BUS_PROT_WR_IGN(CAM_SUB1,
> +					MT6858_CAM_SUB1_PROT_EN_SMI_CAM_MAIN,
> +					MT6858_SUBx_PROT_EN_SET,
> +					MT6858_SUBx_PROT_EN_CLR,
> +					MT6858_SUBx_PROT_EN_STA),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_CAM_SUBA] = {
> +		.name = "cam-suba",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe4c,
> +		.pwr_sta_offs = 0xe4c,
> +		.pwr_sta2nd_offs = 0xe4c,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(CAM_SUB1,
> +					MT6858_CAM_SUB1_PROT_EN_SMI_CAM_SUBA,
> +					MT6858_SUBx_PROT_EN_SET,
> +					MT6858_SUBx_PROT_EN_CLR,
> +					MT6858_SUBx_PROT_EN_STA),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_CAM_SUBB] = {
> +		.name = "cam-subb",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe50,
> +		.pwr_sta_offs = 0xe50,
> +		.pwr_sta2nd_offs = 0xe50,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(CAM_SUB0,
> +					MT6858_CAM_SUB0_PROT_EN_SMI_CAM_SUBB,
> +					MT6858_SUBx_PROT_EN_SET,
> +					MT6858_SUBx_PROT_EN_CLR,
> +					MT6858_SUBx_PROT_EN_STA),
> +		},
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_DIS0] = {
> +		.name = "dis0",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe6c,
> +		.pwr_sta_offs = 0xe6c,
> +		.pwr_sta2nd_offs = 0xe6c,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_DIS0,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_0_RDY),
> +		},
> +	},
> +	[MT6858_POWER_DOMAIN_MM_INFRA] = {
> +		.name = "mm-infra",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe74,
> +		.pwr_sta_offs = 0xe74,
> +		.pwr_sta2nd_offs = 0xe74,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_MM_INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_MM_INFRA,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_SET,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_CLR,
> +					MT6858_TOP_AXI_PROT_EN_MMSYS_STA_1_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_MM_INFRA,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_INFRASYS_STA_0_RDY),
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_MM_INFRA,
> +					MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_EMISYS_STA_0_RDY),
> +		},
> +	},
> +	[MT6858_POWER_DOMAIN_MM_PROC_DORMANT] = {
> +		.name = "mm-proc-dormant",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe78,
> +		.pwr_sta_offs = 0xe78,
> +		.pwr_sta2nd_offs = 0xe78,
> +		.sram_pdn_bits = BIT(9),
> +		.sram_pdn_ack_bits = BIT(13),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(VLP,
> +					MT6858_VLP_AXI_PROT_EN_MM_PROC,
> +					MT6858_VLP_AXI_PROT_EN_SET,
> +					MT6858_VLP_AXI_PROT_EN_CLR,
> +					MT6858_VLP_AXI_PROT_EN_STA),
> +			BUS_PROT_WR_IGN(VLP,
> +					MT6858_VLP_AXI_PROT_EN_MM_PROC_2ND,
> +					MT6858_VLP_AXI_PROT_EN_SET,
> +					MT6858_VLP_AXI_PROT_EN_CLR,
> +					MT6858_VLP_AXI_PROT_EN_STA),
> +		},
> +		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_SRAM_PDN_INVERTED,
> +	},
> +	[MT6858_POWER_DOMAIN_CSI_RX] = {
> +		.name = "csi-rx",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xe98,
> +		.pwr_sta_offs = 0xe98,
> +		.pwr_sta2nd_offs = 0xe98,
> +		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT6858_POWER_DOMAIN_SSUSB] = {
> +		.name = "ssusb",
> +		.sta_mask = MT6858_PWR_ACK,
> +		.sta2nd_mask = MT6858_PWR_ACK_2ND,
> +		.ctl_offs = 0xea4,
> +		.pwr_sta_offs = 0xea4,
> +		.pwr_sta2nd_offs = 0xea4,
> +		.sram_pdn_bits = BIT(8),
> +		.sram_pdn_ack_bits = BIT(12),
> +		.bp_cfg = {
> +			BUS_PROT_WR_IGN(INFRA,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_SSUSB,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_SET,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_CLR,
> +					MT6858_TOP_AXI_PROT_EN_PERISYS_STA_0_RDY),
> +		},
> +	},
> +};
> +
> +static const struct scpsys_soc_data mt6858_scpsys_data = {
> +	.domains_data = scpsys_domain_data_mt6858,
> +	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt6858),
> +	.bus_prot_blocks = scpsys_bus_prot_blocks_mt6858,
> +	.num_bus_prot_blocks = ARRAY_SIZE(scpsys_bus_prot_blocks_mt6858),
> +	.type = SCPSYS_MTCMOS_TYPE_DIRECT_CTL,
> +};
> +
> +#endif /* __SOC_MEDIATEK_MT6858_PM_DOMAINS_H */
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index 5b4d860318a4..b43f8b4a6a01 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -20,6 +20,7 @@
>   
>   #include "mt6735-pm-domains.h"
>   #include "mt6795-pm-domains.h"
> +#include "mt6858-pm-domains.h"
>   #include "mt6893-pm-domains.h"
>   #include "mt8167-pm-domains.h"
>   #include "mt8173-pm-domains.h"
> @@ -1288,6 +1289,10 @@ static const struct of_device_id scpsys_of_match[] = {
>   		.compatible = "mediatek,mt6795-power-controller",
>   		.data = &mt6795_scpsys_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt6858-power-controller",
> +		.data = &mt6858_scpsys_data,
> +	},
>   	{
>   		.compatible = "mediatek,mt6893-power-controller",
>   		.data = &mt6893_scpsys_data,
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> index 8690690335ad..45da83e9d649 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
> @@ -66,6 +66,11 @@ enum scpsys_bus_prot_block {
>   	BUS_PROT_BLOCK_INFRA_NAO,
>   	BUS_PROT_BLOCK_SMI,
>   	BUS_PROT_BLOCK_SPM,
> +	BUS_PROT_BLOCK_IMG_SUB0,
> +	BUS_PROT_BLOCK_CAM_SUB1,
> +	BUS_PROT_BLOCK_CAM_SUB0,
> +	BUS_PROT_BLOCK_IPE_SUB0,
> +	BUS_PROT_BLOCK_VLP,
>   	BUS_PROT_BLOCK_COUNT,
>   };
>   
> 


Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067A424679;
	Mon, 20 Jul 2026 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554039; cv=none; b=mVb9isIZ5EGlea9Zez4LKjTJZKnMSkAr66sAQFHiOYh68crN8gnJjLTwst0RpvxNJ2QC/es3q7cmNZ7uovzL1CUxK2ep2g+6I4rlGqDm1ZG/nxdfmvwQxHKwV012UG1niXf/zz3yPLtAlqaLD0pJydasDnhRbezPbfp9hGRViWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554039; c=relaxed/simple;
	bh=CWf9vH4uIsZLi7Sumt/lSWotP0IVoWqthIVkXhbSDqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uoH0cxcO3o2lY1Eu92FMGW1ppsFXv5enDwrGOCSB649w8IwBCdlYqHnX7zeqvG8Qtvn7sBk5RtsBS9dJLku81aFrkX2Yil/cdR0tOTdEwjA7KSfEu+uAkko4cSp/XbzVC4h/CYABHBuf5bnAUZ4eN5/RMtOnRFDuB7MWTa6dWCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=erxZ2Rj6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="erxZ2Rj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784554035;
	bh=CWf9vH4uIsZLi7Sumt/lSWotP0IVoWqthIVkXhbSDqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=erxZ2Rj6ccYppRidRZ5jBf0ckQM6nOIWlbnq91e8X4ZP+CsqD+s5Wy2UuAGOimsEo
	 5e53E8baapf2oC6LQYLjCYAGwHmONU9cXnzMeYwIikh2m+8Lw/VddE5GvxvDFfqBmu
	 xwCWw7Gw/J+ARMf2RUFQCWwPkyXvJyW8ICzsBf/S5cCTJkD0k/TRjfNWSA1vKwT/5i
	 5hqAYXeAJVtNkLnbMf9nw2KVa48ttAHwCjQSqY11Kkqdxmg8ScaI/PJYVZJhCNHYXY
	 8SzUWJ4iPOl8czojy4jPOrXW0nRDkheLg6aMWTG7QnMP8tGbMEChq92IGS2LA3gF8/
	 h/8ux72NDpLtg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 47C4617E0564;
	Mon, 20 Jul 2026 15:27:15 +0200 (CEST)
Message-ID: <9b685d1f-e1c7-4ca9-98a0-8261e845228c@collabora.com>
Date: Mon, 20 Jul 2026 15:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] soc: mediatek: pwrap: add MT6589 PWARP and MT6320
 PMIC support
To: Akari Tsuyukusa <akkun11.open@gmail.com>, Sen Chu <sen.chu@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Cc: "open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS"
 <linux-pm@vger.kernel.org>,
 "open list:MULTIFUNCTION DEVICES (MFD)" <mfd@lists.linux.dev>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>
References: <20260716171733.300885-1-akkun11.open@gmail.com>
 <20260716171733.300885-4-akkun11.open@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260716171733.300885-4-akkun11.open@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 19:17, Akari Tsuyukusa wrote:
> Add support for MediaTek MT6589 PWRAP and MT6320 PMIC which are used
> together.
> 
> Since the PWRAP Bridge hardware on MT6589 is identical to the one on
> MT8135, refactor the existing register definitions:
> - Rename the MT8135-specific "PWRAP_MT8135_BRIDGE_" prefix to a generic
>    "PWRAP_BRIDGE_" prefix to reflect that they are shared across SoCs.
> - Add the full set of PWRAP Bridge registers to match the hardware
>    specification, rather than defining only a subset of them.
> 
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 292 +++++++++++++++++++++------
>   1 file changed, 235 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 0bcd85826375..3a5b007d60f5 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -17,15 +17,31 @@
>   #define PWRAP_POLL_DELAY_US	10
>   #define PWRAP_POLL_TIMEOUT_US	10000
>   
> -#define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
> -#define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
> -#define PWRAP_MT8135_BRIDGE_INIT_DONE3		0x14
> -#define PWRAP_MT8135_BRIDGE_WACS4_EN		0x24
> -#define PWRAP_MT8135_BRIDGE_INIT_DONE4		0x28
> -#define PWRAP_MT8135_BRIDGE_INT_EN		0x38
> -#define PWRAP_MT8135_BRIDGE_TIMER_EN		0x48
> -#define PWRAP_MT8135_BRIDGE_WDT_UNIT		0x50
> -#define PWRAP_MT8135_BRIDGE_WDT_SRC_EN		0x54

Yeah I understand why you're renaming those, but choose:

a. You avoid renaming and add the rest as PWRAP_MT8135_XXXX; or
b. You make two commits, one for the rename (and explaining why) and one
    for introducing MT6589 support.

Your choice.

> +/* MT6589 and MT8135 specific PWARP Bridge registers */
> +#define PWRAP_BRIDGE_IARB_INIT		0x0
> +#define PWRAP_BRIDGE_IORD_ARB_EN	0x4
> +#define PWRAP_BRIDGE_IARB_STA0		0x8
> +#define PWRAP_BRIDGE_IARB_STA1		0xc
> +#define PWRAP_BRIDGE_WACS3_EN		0x10
> +#define PWRAP_BRIDGE_INIT_DONE3		0x14
> +#define PWRAP_BRIDGE_WACS3_CMD		0x18
> +#define PWRAP_BRIDGE_WACS3_RDATA	0x1c
> +#define PWRAP_BRIDGE_WACS3_VLDCLR	0x20
> +#define PWRAP_BRIDGE_WACS4_EN		0x24
> +#define PWRAP_BRIDGE_INIT_DONE4		0x28
> +#define PWRAP_BRIDGE_WACS4_CMD		0x2c
> +#define PWRAP_BRIDGE_WACS4_RDATA	0x30
> +#define PWRAP_BRIDGE_WACS4_VLDCLR	0x34
> +#define PWRAP_BRIDGE_INT_EN		0x38
> +#define PWRAP_BRIDGE_INT_FLG_RAW	0x3c
> +#define PWRAP_BRIDGE_INT_FLG		0x40
> +#define PWRAP_BRIDGE_INT_CLR		0x44
> +#define PWRAP_BRIDGE_TIMER_EN		0x48
> +#define PWRAP_BRIDGE_TIMER_STA		0x4c
> +#define PWRAP_BRIDGE_WDT_UNIT		0x50
> +#define PWRAP_BRIDGE_WDT_SRC_EN		0x54
> +#define PWRAP_BRIDGE_WDT_FLG		0x58
> +#define PWRAP_BRIDGE_DEBUG_INT_SEL	0x5c
>   
>   /* macro for wrapper status */
>   #define PWRAP_GET_WACS_RDATA(x)		(((x) >> 0) & 0x0000ffff)
> @@ -100,6 +116,24 @@ enum dew_regs {
>   	PWRAP_DEW_CIPHER_MODE,
>   	PWRAP_DEW_CIPHER_SWRST,
>   
> +	/* MT6320 only regs */
> +	PWRAP_DEW_CIPHER_IV0,
> +	PWRAP_DEW_CIPHER_IV1,
> +	PWRAP_DEW_CIPHER_IV2,
> +	PWRAP_DEW_CIPHER_IV3,
> +	PWRAP_DEW_CIPHER_IV4,
> +	PWRAP_DEW_CIPHER_IV5,
> +
> +	/* MT6320 and MT6397 only regs */
> +	PWRAP_DEW_EVENT_OUT_EN,
> +	PWRAP_DEW_EVENT_SRC_EN,
> +	PWRAP_DEW_EVENT_SRC,
> +	PWRAP_DEW_EVENT_FLAG,
> +	PWRAP_DEW_MON_FLAG_SEL,
> +	PWRAP_DEW_EVENT_TEST,
> +	PWRAP_DEW_CIPHER_LOAD,
> +	PWRAP_DEW_CIPHER_START,
> +
>   	/* MT6323 only regs */
>   	PWRAP_DEW_CIPHER_EN,
>   	PWRAP_DEW_RDDMY_NO,
> @@ -142,16 +176,34 @@ enum dew_regs {
>   	PWRAP_DEW_RG_WDATA_MASK,
>   	PWRAP_DEW_RG_SPI_RECORD_CLR,
>   	PWRAP_DEW_RG_CMD_ALERT_CLR,
> +};
>   
> -	/* MT6397 only regs */
> -	PWRAP_DEW_EVENT_OUT_EN,
> -	PWRAP_DEW_EVENT_SRC_EN,
> -	PWRAP_DEW_EVENT_SRC,
> -	PWRAP_DEW_EVENT_FLAG,
> -	PWRAP_DEW_MON_FLAG_SEL,
> -	PWRAP_DEW_EVENT_TEST,
> -	PWRAP_DEW_CIPHER_LOAD,
> -	PWRAP_DEW_CIPHER_START,
> +static const u32 mt6320_regs[] = {
> +	[PWRAP_DEW_EVENT_OUT_EN] =	0x0000,
> +	[PWRAP_DEW_DIO_EN] =		0x0002,
> +	[PWRAP_DEW_EVENT_SRC_EN] =	0x0004,
> +	[PWRAP_DEW_EVENT_SRC] =		0x0006,
> +	[PWRAP_DEW_EVENT_FLAG] =	0x0008,
> +	[PWRAP_DEW_READ_TEST] =		0x000a,
> +	[PWRAP_DEW_WRITE_TEST] =	0x000c,
> +	[PWRAP_DEW_CRC_EN] =		0x000e,
> +	[PWRAP_DEW_CRC_VAL] =		0x0010,
> +	[PWRAP_DEW_MON_GRP_SEL] =	0x0012,
> +	[PWRAP_DEW_MON_FLAG_SEL] =	0x0014,
> +	[PWRAP_DEW_EVENT_TEST] =	0x0016,
> +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0018,
> +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x001a,
> +	[PWRAP_DEW_CIPHER_LOAD] =	0x001c,
> +	[PWRAP_DEW_CIPHER_START] =	0x001e,
> +	[PWRAP_DEW_CIPHER_RDY] =	0x0020,
> +	[PWRAP_DEW_CIPHER_MODE] =	0x0022,
> +	[PWRAP_DEW_CIPHER_SWRST] =	0x0024,
> +	[PWRAP_DEW_CIPHER_IV0] =	0x0026,
> +	[PWRAP_DEW_CIPHER_IV1] =	0x0028,
> +	[PWRAP_DEW_CIPHER_IV2] =	0x002a,
> +	[PWRAP_DEW_CIPHER_IV3] =	0x002c,
> +	[PWRAP_DEW_CIPHER_IV4] =	0x002e,
> +	[PWRAP_DEW_CIPHER_IV5] =	0x0030,
>   };
>   
>   static const u32 mt6323_regs[] = {
> @@ -386,6 +438,22 @@ enum pwrap_regs {
>   	PWRAP_EINT_STA1_ADR,
>   	PWRAP_SWINF_2_WDATA_31_0,
>   	PWRAP_SWINF_2_RDATA_31_0,
> +	PWRAP_DVFS_ADR0,
> +	PWRAP_DVFS_WDATA0,
> +	PWRAP_DVFS_ADR1,
> +	PWRAP_DVFS_WDATA1,
> +	PWRAP_DVFS_ADR2,
> +	PWRAP_DVFS_WDATA2,
> +	PWRAP_DVFS_ADR3,
> +	PWRAP_DVFS_WDATA3,
> +	PWRAP_DVFS_ADR4,
> +	PWRAP_DVFS_WDATA4,
> +	PWRAP_DVFS_ADR5,
> +	PWRAP_DVFS_WDATA5,
> +	PWRAP_DVFS_ADR6,
> +	PWRAP_DVFS_WDATA6,
> +	PWRAP_DVFS_ADR7,
> +	PWRAP_DVFS_WDATA7,
>   
>   	/* MT2701 only regs */
>   	PWRAP_ADC_CMD_ADDR,
> @@ -394,6 +462,24 @@ enum pwrap_regs {
>   	PWRAP_ADC_RDATA_ADDR1,
>   	PWRAP_ADC_RDATA_ADDR2,
>   
> +	/* MT6589 only regs */
> +	PWRAP_CIPHER_IV0,
> +	PWRAP_CIPHER_IV1,
> +	PWRAP_CIPHER_IV2,
> +
> +	/* MT6589 and MT8135 only regs */
> +	PWRAP_CSHEXT,
> +	PWRAP_EVENT_IN_EN,
> +	PWRAP_EVENT_DST_EN,
> +	PWRAP_RRARB_INIT,
> +	PWRAP_RRARB_EN,
> +	PWRAP_RRARB_STA0,
> +	PWRAP_RRARB_STA1,
> +	PWRAP_EVENT_STA,
> +	PWRAP_EVENT_STACLR,
> +	PWRAP_CIPHER_LOAD,
> +	PWRAP_CIPHER_START,
> +
>   	/* MT7622 only regs */
>   	PWRAP_STA,
>   	PWRAP_CLR,
> @@ -422,38 +508,9 @@ enum pwrap_regs {
>   	PWRAP_DVFS_STEP_CTRL2,
>   	PWRAP_SPI2_CTRL,
>   
> -	/* MT8135 only regs */
> -	PWRAP_CSHEXT,
> -	PWRAP_EVENT_IN_EN,
> -	PWRAP_EVENT_DST_EN,
> -	PWRAP_RRARB_INIT,
> -	PWRAP_RRARB_EN,
> -	PWRAP_RRARB_STA0,
> -	PWRAP_RRARB_STA1,
> -	PWRAP_EVENT_STA,
> -	PWRAP_EVENT_STACLR,
> -	PWRAP_CIPHER_LOAD,
> -	PWRAP_CIPHER_START,
> -

Why are you reordering stuff around? I don't understand.

If you have a reason, make sure it's a good one, and make a different commit
just for the reordering, because otherwise the diff for this one gets a bit
hard to read.


Cheers,
Angelo

>   	/* MT8173 only regs */
>   	PWRAP_RDDMY,
>   	PWRAP_SI_CK_CON,
> -	PWRAP_DVFS_ADR0,
> -	PWRAP_DVFS_WDATA0,
> -	PWRAP_DVFS_ADR1,
> -	PWRAP_DVFS_WDATA1,
> -	PWRAP_DVFS_ADR2,
> -	PWRAP_DVFS_WDATA2,
> -	PWRAP_DVFS_ADR3,
> -	PWRAP_DVFS_WDATA3,
> -	PWRAP_DVFS_ADR4,
> -	PWRAP_DVFS_WDATA4,
> -	PWRAP_DVFS_ADR5,
> -	PWRAP_DVFS_WDATA5,
> -	PWRAP_DVFS_ADR6,
> -	PWRAP_DVFS_WDATA6,
> -	PWRAP_DVFS_ADR7,
> -	PWRAP_DVFS_WDATA7,
>   	PWRAP_SPMINF_STA,
>   	PWRAP_CIPHER_EN,

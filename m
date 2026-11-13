Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595854;
	b=SaCSc+w3fS3x8Azs36CcrstG6KAN5Sj5OstxgBJEGHRPs+AL9GI9rUA5zhEgXRPmKGXI
	 zuqBbCVw5wjDJyMqNBDuBw0ocIcwmqUlJ3s9jFTBa0Q548F3Aqaj/YYlV2tk22JN+BFC+
	 XDVZzUjALARb4/JkbK1FY67U3XbwPaFqWree5D6/Fgq7L55K2vzSZB3YzbQNo5oSgloH0
	 sJrbY9kjdRh4BDHD1XAONOEf2JW+amOgDS7oeRQnYvPLTLC33clZjkV6TYIaW3/3RCUgG
	 c+6pWY6A+ec7r/+9JoL+a7tOqzowCzy4cKN59BY1BuVTM4hEHErseVq+CL6FCGq/hTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595854;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cjhG7Bzi1tsnaOBL0/3qmbPStuw8rhrR+V7LVA+Ywdw=;
	b=Sf/VmtsGhYxVR+wrcuO4ozUAaZkArRB+6EK6yn089n/eyO+SMMXvMvgS6cfSJvFuf6eU
	 siruBYamcp6ma6qRb2LQh8z1GPtszFxmA8RxVDp2lSQaf16gHBC4KwFnw1Vz2eMNwYwpw
	 qw7EW3BJUm2vCKWITAb5ZkKIumkhRwx2D9MbjgkCnelxz/U6Lbyl5CYnRyDYVHRiQPG5i
	 RKprXOUF2NMJVEIgcLUILVGxDpVEUl/JemMAIhlW1pjp89JifdPLrJ7RmCiVs7bR0Ry6p
	 m3dEe9Fny/uTZe4LqJ27jR1OgsiwQuq0KUSecv/8nmyhcxmK+Npq3DYVOkAkZeyc23Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVgpn0Wz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CF606A32D;
	Fri, 13 Nov 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVgpn0Wz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342F01F000C4;
	Fri, 13 Nov 2026 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595854;
	bh=cjhG7Bzi1tsnaOBL0/3qmbPStuw8rhrR+V7LVA+Ywdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVgpn0WzoFhIdaDcho/bQqb7ril090RQfOnX/VijF+DvoHH0Y72fNWgWhmJ4EvAR8
	 4zB5sg31cdpBewBdyn8bfzlTgTH/KOEF1QRjM1XOD9FCg6KNRBbJtdE6+Cqo1mWjbX
	 38lAMLpT3Yt7J5idBo0tzpGbZ1p+khrdFloyuFRdEzDKcG/Zp0OOqgVzxtsX0tLy1/
	 zG7WTraWKezTiSqkqkGEI2tiSXS3SH7bYP67wneO48jTvX5X9m8nmo5z4EmSXyuf/b
	 ko6fK5PwhpOf2QGvdms7NSFTthaukAKDvXokMjw8kmpKkedd0qmWApWV0S+Xrm97UK
	 afrnnnALFIbvQ==
Date: Fri, 13 Nov 2026 18:50:47 +0000
From: Lee Jones <lee@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pm@vger.kernel.org, mfd@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 2/2] rtc: mt6397: provide the 32 kHz output as a clock
Message-ID: <20261113185047.GH6323@joneslee-macbookpro.roam.internal>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
 <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>

On Sun, 01 Nov 2026, Ryan Brue wrote:

> The RTC's 32 kHz output is gated by RTC_CON.F32KOB, which the vendor
> kernel clears before it powers the Wi-Fi/Bluetooth combo chip. Mainline
> never touches it, so on a board whose bootloader leaves it set, such a
> chip has no sleep clock and does not come up.
> 
> Register the output as a clock when the RTC node has #clock-cells, so
> the chip's power sequence can enable it.
> 
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
>  drivers/rtc/rtc-mt6397.c       | 85 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6397/rtc.h |  6 +++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index d6e156516aa6..5130fecffa7b 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/array_size.h>
>  #include <linux/bitfield.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/mt6397/core.h>
> @@ -317,6 +318,84 @@ static int mtk_rtc_nvram_write(void *priv, unsigned int offset, void *val,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_COMMON_CLK
> +static int mtk_rtc_clkout_set(struct clk_hw *hw, bool on)
> +{
> +	struct mt6397_rtc *rtc = container_of(hw, struct mt6397_rtc, clkout);
> +	int ret;
> +
> +	mutex_lock(&rtc->lock);
> +	ret = regmap_update_bits(rtc->regmap, rtc->addr_base + rtc->data->con,
> +				 RTC_CON_F32KOB, on ? 0 : RTC_CON_F32KOB);
> +	if (!ret)
> +		ret = mtk_rtc_write_trigger(rtc);
> +	mutex_unlock(&rtc->lock);
> +
> +	return ret;
> +}
> +
> +static int mtk_rtc_clkout_prepare(struct clk_hw *hw)
> +{
> +	return mtk_rtc_clkout_set(hw, true);
> +}
> +
> +static void mtk_rtc_clkout_unprepare(struct clk_hw *hw)
> +{
> +	mtk_rtc_clkout_set(hw, false);
> +}
> +
> +static int mtk_rtc_clkout_is_prepared(struct clk_hw *hw)
> +{
> +	struct mt6397_rtc *rtc = container_of(hw, struct mt6397_rtc, clkout);
> +	u32 con;
> +
> +	if (regmap_read(rtc->regmap, rtc->addr_base + rtc->data->con, &con))
> +		return 0;
> +
> +	return !(con & RTC_CON_F32KOB);
> +}
> +
> +static unsigned long mtk_rtc_clkout_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	return 32768;
> +}
> +
> +static const struct clk_ops mtk_rtc_clkout_ops = {
> +	.prepare = mtk_rtc_clkout_prepare,
> +	.unprepare = mtk_rtc_clkout_unprepare,
> +	.is_prepared = mtk_rtc_clkout_is_prepared,
> +	.recalc_rate = mtk_rtc_clkout_recalc_rate,
> +};
> +
> +/* The 32 kHz output the PMIC drives to other chips, such as a combo chip */
> +static int mtk_rtc_register_clkout(struct device *dev, struct mt6397_rtc *rtc)
> +{
> +	struct clk_init_data init = {
> +		.name = "mt6397-rtc-32k",
> +		.ops = &mtk_rtc_clkout_ops,
> +	};
> +	int ret;
> +
> +	if (!rtc->data->con || !of_property_present(dev->of_node, "#clock-cells"))
> +		return 0;
> +
> +	rtc->clkout.init = &init;
> +
> +	ret = devm_clk_hw_register(dev, &rtc->clkout);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
> +					   &rtc->clkout);
> +}
> +#else
> +static int mtk_rtc_register_clkout(struct device *dev, struct mt6397_rtc *rtc)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int mtk_rtc_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -380,6 +459,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = mtk_rtc_register_clkout(&pdev->dev, rtc);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to register the 32k clock\n");
> +
>  	nvmem_cfg.priv = rtc;
>  
>  	return devm_rtc_nvmem_register(rtc->rtc_dev, &nvmem_cfg);
> @@ -416,6 +500,7 @@ static const struct mtk_rtc_data mt6358_rtc_data = {
>  
>  static const struct mtk_rtc_data mt6397_rtc_data = {
>  	.wrtgr = RTC_WRTGR_MT6397,
> +	.con = RTC_CON_MT6397,
>  };
>  
>  static const struct of_device_id mt6397_rtc_of_match[] = {
> diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
> index f4da579ec638..a8130d726c59 100644
> --- a/include/linux/mfd/mt6397/rtc.h
> +++ b/include/linux/mfd/mt6397/rtc.h
> @@ -9,6 +9,7 @@
>  #ifndef _LINUX_MFD_MT6397_RTC_H_
>  #define _LINUX_MFD_MT6397_RTC_H_
>  
> +#include <linux/clk-provider.h>
>  #include <linux/jiffies.h>
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
> @@ -22,6 +23,9 @@
>  #define RTC_WRTGR_MT6397       0x003c
>  #define RTC_WRTGR_MT6323       RTC_WRTGR_MT6397
>  
> +#define RTC_CON_MT6397         0x003e
> +#define RTC_CON_F32KOB         BIT(5)
> +
>  #define RTC_IRQ_STA            0x0002
>  #define RTC_IRQ_STA_AL         BIT(0)
>  #define RTC_IRQ_STA_LP         BIT(3)
> @@ -72,6 +76,7 @@
>  
>  struct mtk_rtc_data {
>  	u32                     wrtgr;
> +	u32                     con;

These are terrible variable names.

The nomenclature should be self-describing.

>  };
>  
>  struct mt6397_rtc {
> @@ -83,6 +88,7 @@ struct mt6397_rtc {
>  	int                     irq;
>  	u32                     addr_base;
>  	const struct mtk_rtc_data *data;
> +	struct clk_hw           clkout;
>  };
>  
>  #endif /* _LINUX_MFD_MT6397_RTC_H_ */
> 
> -- 
> 2.55.0
> 

-- 
Lee Jones

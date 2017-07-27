From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 3/4] thermal: mediatek: extend calibration data for
 mt2712 chip
Date: Thu, 27 Jul 2017 17:46:44 +0200
Message-ID: <f11a8633-79cb-42f7-eb7c-b4e929829568@gmail.com>
References: <1501134417-3505-1-git-send-email-louis.yu@mediatek.com>
 <1501134417-3505-4-git-send-email-louis.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33000 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0Pqr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 11:46:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id y43so24644928wrd.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Jul 2017 08:46:46 -0700 (PDT)
In-Reply-To: <1501134417-3505-4-git-send-email-louis.yu@mediatek.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: louis.yu@mediatek.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dawei.chien@mediatek.com, fan.chen@mediatek.com, eddie.huang@mediatek.com, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com



On 07/27/2017 07:46 AM, louis.yu@mediatek.com wrote:
> From: Louis Yu <louis.yu@mediatek.com>
> 
> This patch adds support for mt2712 chip thermal calibration data
> and calculation.
> 
> Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> ---
>   drivers/thermal/mtk_thermal.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index e35d28d..f2a7155 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -126,6 +126,8 @@
>   #define MT8173_CALIB_BUF2_VTS_TSABB(x)	(((x) >> 14) & 0x1ff)
>   #define MT8173_CALIB_BUF0_DEGC_CALI(x)	(((x) >> 1) & 0x3f)
>   #define MT8173_CALIB_BUF0_O_SLOPE(x)	(((x) >> 26) & 0x3f)
> +#define MT8173_CALIB_BUF0_O_SLOPE_SIGN(x)	(((x) >> 7) & 0x1)
> +#define MT8173_CALIB_BUF1_ID(x)	(((x) >> 9) & 0x1)

Why do define them as MT8173_* is this calibration computation generic to 
all/some SoCs?

Regards,
Matthias

>   
>   /* MT2701 thermal sensors */
>   #define MT2701_TS1	0
> @@ -609,7 +611,11 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>   		mt->vts[MT8173_TS4] = MT8173_CALIB_BUF2_VTS_TS4(buf[2]);
>   		mt->vts[MT8173_TSABB] = MT8173_CALIB_BUF2_VTS_TSABB(buf[2]);
>   		mt->degc_cali = MT8173_CALIB_BUF0_DEGC_CALI(buf[0]);
> -		mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
> +		if (MT8173_CALIB_BUF1_ID(buf[1]) &
> +		    MT8173_CALIB_BUF0_O_SLOPE_SIGN(buf[0]))
> +			mt->o_slope = -MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
> +		else
> +			mt->o_slope = MT8173_CALIB_BUF0_O_SLOPE(buf[0]);
>   	} else {
>   		dev_info(dev, "Device not calibrated, using default calibration values\n");
>   	}
> 

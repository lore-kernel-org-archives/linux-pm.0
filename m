From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v1 06/16] rtc: mediatek: remove unnecessary parentheses
Date: Fri, 23 Mar 2018 11:21:23 +0100
Message-ID: <20180323102123.GG3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
 <92d07e90f43899981a82fbc684c3d15aaecaf591.1521794177.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <92d07e90f43899981a82fbc684c3d15aaecaf591.1521794177.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, eddie.huang@mediatek.com, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23/03/2018 at 17:15:03 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Remove unnecessary parentheses due to explicit C operator precedence.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index 0df7ccd..4411c08 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -106,7 +106,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
>  	int ret;
>  
>  	ret = regmap_read(rtc->regmap, rtc->addr_base + RTC_IRQ_STA, &irqsta);
> -	if ((ret >= 0) && (irqsta & RTC_IRQ_STA_AL)) {
> +	if (ret >= 0 && irqsta & RTC_IRQ_STA_AL) {

I don't think this makes the code particularly clearer.

>  		rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
>  		irqen = irqsta & ~RTC_IRQ_EN_AL;
>  		mutex_lock(&rtc->lock);
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

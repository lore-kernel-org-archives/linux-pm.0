From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH] thermal: rockchip: improve the warning log
Date: Mon, 10 Oct 2016 11:53:20 +0800
Message-ID: <57FB10B0.8080503@gmail.com>
References: <1476017358-26143-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35887 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcJJDxX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Oct 2016 23:53:23 -0400
Received: by mail-pa0-f65.google.com with SMTP id rw4so1470096pab.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Oct 2016 20:53:22 -0700 (PDT)
In-Reply-To: <1476017358-26143-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>
Cc: linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org


On 2016年10月09日 20:49, Shawn Lin wrote:
> There is no necessary to print warning agian and
> again if we don't add rockchip,grf for dt, otherwise
> I saw the following log when doning suspend-2-resume.
> We only need to print it once when parsing dt. It looks
> quite trivial but the log is apparently verbose.
>
> [   26.615415] PM: early resume of devices complete after 1.539 msecs
> [   26.622002] rk_tsadcv2_initialize: Missing rockchip,grf property
> [   26.629359] rk_gmac-dwmac ff290000.ethernet: init for RGMII
> [   26.639794] PM: resume of devices complete after 18.109 msecs
> [   26.646925] Restarting tasks ... done.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Caesar Wang <wxt@rock-chips.com>

> ---
>
>   drivers/thermal/rockchip_thermal.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index e227a9f..b811b0f 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -524,11 +524,6 @@ static void rk_tsadcv2_initialize(struct regmap *grf, void __iomem *regs,
>   		       regs + TSADCV2_AUTO_PERIOD_HT);
>   	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
>   		       regs + TSADCV2_HIGHT_TSHUT_DEBOUNCE);
> -
> -	if (IS_ERR(grf)) {
> -		pr_warn("%s: Missing rockchip,grf property\n", __func__);
> -		return;
> -	}
>   }
>   
>   /**
> @@ -971,6 +966,8 @@ static int rockchip_configure_from_dt(struct device *dev,
>   	 * need this property.
>   	 */
>   	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +	if (IS_ERR(thermal->grf))
> +		dev_warn(dev, "Missing rockchip,grf property\n");
>   
>   	return 0;
>   }


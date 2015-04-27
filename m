From: Doug Anderson <dianders@chromium.org>
Subject: Re: [patch] thermal: rockchip: fix an error code
Date: Mon, 27 Apr 2015 10:50:14 -0700
Message-ID: <CAD=FV=VT5v_X=yXKF+WooFpHy=9=x6jVMp3RKhVGfrP1e_S81w@mail.gmail.com>
References: <20150421093410.GE12098@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33634 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932817AbbD0RuP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 13:50:15 -0400
Received: by igbpi8 with SMTP id pi8so73244135igb.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2015 10:50:14 -0700 (PDT)
In-Reply-To: <20150421093410.GE12098@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Caesar Wang <caesar.wang@rock-chips.com>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, kernel-janitors@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Dan,

On Tue, Apr 21, 2015 at 2:34 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> There is a copy and paste bug, "->clk" vs "->pclk", so we return the
> wrong error code here.
>
> Fixes: cbac8f639437 ('thermal: rockchip: add driver for thermal')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 3aa46ac..cd8f5f93 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -529,7 +529,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>
>         thermal->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
>         if (IS_ERR(thermal->pclk)) {
> -               error = PTR_ERR(thermal->clk);
> +               error = PTR_ERR(thermal->pclk);
>                 dev_err(&pdev->dev, "failed to get apb_pclk clock: %d\n",
>                         error);
>                 return error;

Thanks!  :)  An obvious fix, but just in case it helps feel free to add:

Reviewed-by: Doug Anderson <dianders@chromium.org>

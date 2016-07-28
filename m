From: Stephen Barber <smbarber@chromium.org>
Subject: Re: [PATCH 2/2] thermal: rockchip: optimize sensor auto accessing period
Date: Thu, 28 Jul 2016 14:53:28 -0700
Message-ID: <CADR9n4__hcQosSOM5w0PMw8ck_gPi4Sc5ixbN6CiKKGia2gd7A@mail.gmail.com>
References: <1469628643-29661-1-git-send-email-wxt@rock-chips.com> <1469628643-29661-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:38783 "EHLO
	mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbcG1Vxs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jul 2016 17:53:48 -0400
Received: by mail-it0-f49.google.com with SMTP id j124so92973043ith.1
        for <linux-pm@vger.kernel.org>; Thu, 28 Jul 2016 14:53:48 -0700 (PDT)
In-Reply-To: <1469628643-29661-2-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Rocky Hao <rocky.hao@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Jul 27, 2016 at 7:10 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> From: Rocky Hao <rocky.hao@rock-chips.com>
>
> In less than 10 ms, the temperature of soc will arise 10 degree. 250 ms
> is too big for soc tempeture control. Setting 2.5 ms will speed up
> temperature accessing speed but introduce no more cpu's computing overhead.
> We set AUTO_PERIOD_TIME and TSADCV3_AUTO_PERIOD_HT_TIME the same value,
> because normal temperature update speed is also our consern in IPA.
>
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-pm@vger.kernel.org
>
> ---
>
>  drivers/thermal/rockchip_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index a90423d..1f165c9 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -213,8 +213,8 @@ struct rockchip_thermal_data {
>  #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT     4
>  #define TSADCV2_AUTO_PERIOD_TIME               250 /* 250ms */
>  #define TSADCV2_AUTO_PERIOD_HT_TIME            50  /* 50ms */
> -#define TSADCV3_AUTO_PERIOD_TIME               187500 /* 250ms */
> -#define TSADCV3_AUTO_PERIOD_HT_TIME            37500  /* 50ms */
> +#define TSADCV3_AUTO_PERIOD_TIME               1875 /* 2.5ms */
> +#define TSADCV3_AUTO_PERIOD_HT_TIME            1875 /* 2.5ms */
>
>  #define TSADCV2_USER_INTER_PD_SOC              0x340 /* 13 clocks */
>
> --
> 1.9.1
>


Tested-by: Stephen Barber <smbarber@chromium.org>

Steve

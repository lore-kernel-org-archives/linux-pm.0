From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH] thermal: rockchip: disable thermal->clk in err case
Date: Thu, 3 Mar 2016 11:34:40 +0800
Message-ID: <56D7B0D0.7090605@gmail.com>
References: <1455503242-19907-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33717 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcCCDeq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 22:34:46 -0500
In-Reply-To: <1455503242-19907-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>

Hi ,

Sorry for the missing it.

=E5=9C=A8 2016=E5=B9=B402=E6=9C=8815=E6=97=A5 10:27, Shawn Lin =E5=86=99=
=E9=81=93:
> Disable thermal->clk when enabling pclk fails in
> resume routine.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Caesar Wang <wxt@rock-chips.com>

> ---
>
>   drivers/thermal/rockchip_thermal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/roc=
kchip_thermal.c
> index 9787e8a..b54f6db 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -656,8 +656,10 @@ static int __maybe_unused rockchip_thermal_resum=
e(struct device *dev)
>   		return error;
>  =20
>   	error =3D clk_enable(thermal->pclk);
> -	if (error)
> +	if (error) {
> +		clk_disable(thermal->clk);
>   		return error;
> +	}
>  =20
>   	rockchip_thermal_reset_controller(thermal->reset);
>  =20


--=20
Thanks,
Caesar


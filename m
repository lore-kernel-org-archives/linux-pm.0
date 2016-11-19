From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH 2/3] thermal: rockchip: improve conversion error messages
Date: Sat, 19 Nov 2016 11:31:39 +0800
Message-ID: <b6da9490-9a27-4330-7988-cb25724ba345@rock-chips.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <1479513177-81504-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479513177-81504-2-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Brian,

在 2016年11月19日 07:52, Brian Norris 写道:
> These error messages don't give much information about what went wrong.
> It would be nice, for one, to see what invalid temperature was being
> requested when conversion fails. It's also good to return an error when
> we can't handle a conversion properly.
>
> While we're at it, fix the grammar too.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Note: it'd probably be even nicer to know which sensor this was, but we've
> kinda abstracted that one away by this point...
>
>   drivers/thermal/rockchip_thermal.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index e227a9f0acf7..35554d146b9d 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -424,7 +424,8 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
>   	}
>   
>   exit:
> -	pr_err("Invalid the conversion, error=%d\n", error);
> +	pr_err("%s: invalid temperature, temp=%d error=%d\n",
> +		__func__, temp, error);

I have do some similar for rockchip inside thermal driver.  Forget to 
send for upstream. :(
exit:
     pr_err("%s: Invalid conversion table: code=%d, temperature=%d\n",
            __func__, error, temp);

>   	return error;
>   }
>   
> @@ -475,7 +476,9 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
>   		}
>   		break;
>   	default:
> -		pr_err("Invalid the conversion table\n");
> +		pr_err("%s: invalid conversion table, mode=%d\n",
> +			__func__, table.mode);
> +		return -EINVAL;
>   	}
>   
>   	/*

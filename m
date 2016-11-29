From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 1/5] thermal: rockchip: improve conversion error
 messages
Date: Mon, 28 Nov 2016 17:51:55 -0800
Message-ID: <20161129015155.GA3329@localhost.localdomain>
References: <1480331524-18741-1-git-send-email-wxt@rock-chips.com>
 <1480331524-18741-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36735 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbcK2Bv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Nov 2016 20:51:58 -0500
Content-Disposition: inline
In-Reply-To: <1480331524-18741-2-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: rui.zhang@intel.com, heiko@sntech.de, smbarber@chromium.org, briannorris@chromium.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org

Hello,

On Mon, Nov 28, 2016 at 07:12:00PM +0800, Caesar Wang wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> These error messages don't give much information about what went wrong.
> It would be nice, for one, to see what invalid temperature was being
> requested when conversion fails. It's also good to return an error when
> we can't handle a conversion properly.
> 
> While we're at it, fix the grammar too.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> 
> ---
> 
> Changes in v3: None
> Changes in v2: None
> Changes in v1:
> - The original Brian posted on https://patchwork.kernel.org/patch/9437686
>   Note: it'd probably be even nicer to know which sensor this was, but we've
>   kinda abstracted that one away by this point...
> 
>  drivers/thermal/rockchip_thermal.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index b811b0f..26c247c 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -424,7 +424,8 @@ static u32 rk_tsadcv2_temp_to_code(struct chip_tsadc_table table,
>  	}
>  
>  exit:
> -	pr_err("Invalid the conversion, error=%d\n", error);
> +	pr_err("%s: invalid temperature, temp=%d error=%d\n",
> +	       __func__, temp, error);
>  	return error;
>  }
>  
> @@ -475,7 +476,9 @@ static int rk_tsadcv2_code_to_temp(struct chip_tsadc_table table, u32 code,
>  		}
>  		break;
>  	default:
> -		pr_err("Invalid the conversion table\n");
> +		pr_err("%s: invalid conversion table, mode=%d\n",
> +		       __func__, table.mode);

Given that we are improving messages, would it be more informative to
say that you have an invalid table mode?

> +		return -EINVAL;
>  	}
>  
>  	/*
> -- 
> 2.7.4
> 

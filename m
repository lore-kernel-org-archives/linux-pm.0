From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH] power: supply: sbs-message: double left shift bug in
 sbsm_select()
Date: Tue, 7 Nov 2017 23:18:49 +0800
Message-ID: <6bf6a1bf-9f45-7ca3-214c-cbe554dad433@electromag.com.au>
References: <20171107124322.mm3fqkrggw3zidrx@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:49032 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965291AbdKGPSy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Nov 2017 10:18:54 -0500
In-Reply-To: <20171107124322.mm3fqkrggw3zidrx@mwanda>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Sebastian Reichel <sre@kernel.org>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org

On 7/11/2017 20:43, Dan Carpenter wrote:
> The original code does this: "1 << (1 << 11)" which is undefined in C.
> 
> Fixes: dbc4deda03fe ("power: Adds support for Smart Battery System Manager")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>>From static analysis.  Not tested.
> 
> diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
> index ccb4217b9638..cb6e8f66c7a2 100644
> --- a/drivers/power/supply/sbs-manager.c
> +++ b/drivers/power/supply/sbs-manager.c
> @@ -183,7 +183,7 @@ static int sbsm_select(struct i2c_mux_core *muxc, u32 chan)
>   		return ret;
>   
>   	/* chan goes from 1 ... 4 */
> -	reg = 1 << BIT(SBSM_SMB_BAT_OFFSET + chan);
> +	reg = BIT(SBSM_SMB_BAT_OFFSET + chan);
>   	ret = sbsm_write_word(data->client, SBSM_CMD_BATSYSSTATE, reg);
>   	if (ret)
>   		dev_err(dev, "Failed to select channel %i\n", chan);
> 
> 
Oops. That's my fault.

Reviewed-by: Phil Reid <preid@electromag.com.au>

-- 
Regards
Phil Reid

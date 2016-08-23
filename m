From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq_cooling: no need to check state with negative
 number
Date: Tue, 23 Aug 2016 14:08:26 +0900
Message-ID: <57BBDA4A.3030805@samsung.com>
References: <CGME20160822081333epcas1p1d61dc80a90c8961ac5fca0686bc79b48@epcas1p1.samsung.com>
 <1471853286-10432-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60042 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750783AbcHWFI2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 01:08:28 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OCC00YV5JM27IA0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Tue, 23 Aug 2016 14:08:26 +0900 (KST)
In-reply-to: <1471853286-10432-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org

Hi,

On 2016년 08월 22일 17:08, Shawn Lin wrote:
> We could see that state is defined as unsigned type, so it
> should never be less than zero. Let' remove this check.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/thermal/devfreq_cooling.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
> index 01f0015..81631b1 100644
> --- a/drivers/thermal/devfreq_cooling.c
> +++ b/drivers/thermal/devfreq_cooling.c
> @@ -312,7 +312,7 @@ static int devfreq_cooling_state2power(struct thermal_cooling_device *cdev,
>  	unsigned long freq;
>  	u32 static_power;
>  
> -	if (state < 0 || state >= dfc->freq_table_size)
> +	if (state >= dfc->freq_table_size)
>  		return -EINVAL;
>  
>  	freq = dfc->freq_table[state];
> 

As the description, the 'state' variable is unsigned type.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi

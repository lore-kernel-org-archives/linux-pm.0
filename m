From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] PM / devfreq: constify attribute_group structures.
Date: Mon, 03 Jul 2017 19:17:14 +0900
Message-ID: <595A19AA.3060105@samsung.com>
References: <CGME20170703101025epcas4p151a0c496ae3410031c27f4da7ab9714f@epcas4p1.samsung.com>
        <a4e33dd6c72dac67a227e896044b2ee3c1f8825a.1499076508.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54674 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdGCKRR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 06:17:17 -0400
In-reply-to: <a4e33dd6c72dac67a227e896044b2ee3c1f8825a.1499076508.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017년 07월 03일 19:10, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     621	    176	      0	    797	    31d	drivers/devfreq/governor_userspace.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    670	    144	      0	    814	    32e	drivers/devfreq/governor_userspace.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/devfreq/governor_userspace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 1769760..77028c2 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -86,7 +86,7 @@ static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
>  	&dev_attr_set_freq.attr,
>  	NULL,
>  };
> -static struct attribute_group dev_attr_group = {
> +static const struct attribute_group dev_attr_group = {
>  	.name	= "userspace",
>  	.attrs	= dev_entries,
>  };
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

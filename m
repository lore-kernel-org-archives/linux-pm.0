From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq_stats: constify attribute_group
 structures.
Date: Mon, 3 Jul 2017 14:30:17 +0530
Message-ID: <20170703090017.GC3532@vireshk-i7>
References: <8211aa191c9b5924a804e4a3304cfb7534b77a13.1499068637.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32780 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbdGCJAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 05:00:20 -0400
Received: by mail-pg0-f50.google.com with SMTP id k14so16381942pgr.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Jul 2017 02:00:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8211aa191c9b5924a804e4a3304cfb7534b77a13.1499068637.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 03-07-17, 13:29, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    1655	    256	      4	   1915	    77b	drivers/cpufreq/cpufreq_stats.o
> 
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    1695	    192	      4	   1891	    763	drivers/cpufreq/cpufreq_stats.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index f570ead..d362739 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -135,7 +135,7 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
>  	&trans_table.attr,
>  	NULL
>  };
> -static struct attribute_group stats_attr_group = {
> +static const struct attribute_group stats_attr_group = {
>  	.attrs = default_attrs,
>  	.name = "stats"
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

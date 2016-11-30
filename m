From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add support for zx296718
Date: Wed, 30 Nov 2016 13:38:55 +0530
Message-ID: <20161130080855.GL3288@vireshk-i7>
References: <1480491329-5242-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33136 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754686AbcK3II7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 03:08:59 -0500
Received: by mail-pf0-f170.google.com with SMTP id d2so37810560pfd.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Nov 2016 00:08:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1480491329-5242-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: rjw@rjwysocki.net, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 30-11-16, 15:35, Baoyou Xie wrote:
> Add the compatible string for supporting the generic cpufreq driver on
> the ZTE's zx296718 SoC.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 7126762..c0a28e23b 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -81,6 +81,8 @@ static const struct of_device_id machines[] __initconst = {
>  
>  	{ .compatible = "xlnx,zynq-7000", },
>  
> +	{ .compatible = "zte,zx296718", },
> +
>  	{ }
>  };

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

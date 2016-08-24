From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] cpufreq: dt: Add terminate entry for of_device_id
 tables
Date: Wed, 24 Aug 2016 18:04:56 +0530
Message-ID: <20160824123456.GE25143@ubuntu>
References: <1471794104-31436-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34462 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755149AbcHXMnc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Aug 2016 08:43:32 -0400
Received: by mail-pa0-f52.google.com with SMTP id fi15so6327060pac.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Aug 2016 05:43:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1471794104-31436-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

On 21-08-16, 15:41, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Make sure of_device_id tables are NULL terminated.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Fixes: f56aad1d98f1 ("cpufreq: dt: Add generic platform-device creation support")
CC: <stable@vger.kernel.org> #4.7+

> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 470db30..285ed3e 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -75,6 +75,8 @@ static const struct of_device_id machines[] __initconst = {
>  	{ .compatible = "ti,omap5", },
>  
>  	{ .compatible = "xlnx,zynq-7000", },
> +
> +	{ }
>  };
>  
>  static int __init cpufreq_dt_platdev_init(void)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

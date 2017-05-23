From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: Add support for hi3660
Date: Tue, 23 May 2017 12:35:17 +0530
Message-ID: <20170523070517.GL6510@vireshk-i7>
References: <1495521263-84196-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32930 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935697AbdEWHFU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 03:05:20 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so105590943pfh.0
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 00:05:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495521263-84196-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com

On 23-05-17, 14:34, Tao Wang wrote:
> Add the compatible string for supporting the generic device tree cpufreq-dt
> driver on Hisilicon's 3660 SoC.
> 
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 921b4a6..b54e610 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -32,6 +32,7 @@
>  	{ .compatible = "arm,integrator-cp", },
>  
>  	{ .compatible = "hisilicon,hi6220", },
> +	{ .compatible = "hisilicon,hi3660", },

In alphabetical order please.

>  
>  	{ .compatible = "fsl,imx27", },
>  	{ .compatible = "fsl,imx51", },
> -- 
> 1.7.9.5

-- 
viresh

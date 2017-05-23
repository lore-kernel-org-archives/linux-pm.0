From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Patch v2] cpufreq: dt: Add support for hi3660
Date: Tue, 23 May 2017 14:00:43 +0530
Message-ID: <20170523083043.GM6510@vireshk-i7>
References: <20170523070517.GL6510@vireshk-i7>
 <1495527198-125891-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36826 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966688AbdEWIas (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 04:30:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id m17so107665536pfg.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 01:30:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495527198-125891-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com

On 23-05-17, 16:13, Tao Wang wrote:
> Add the compatible string for supporting the generic device tree cpufreq-dt
> driver on Hisilicon's 3660 SoC.
> 
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> ---
> Changes in v2:
> - changed order according to Viresh's suggestion
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 921b4a6..1c26292 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -31,6 +31,7 @@
>  	{ .compatible = "arm,integrator-ap", },
>  	{ .compatible = "arm,integrator-cp", },
>  
> +	{ .compatible = "hisilicon,hi3660", },
>  	{ .compatible = "hisilicon,hi6220", },
>  
>  	{ .compatible = "fsl,imx27", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH -next] cpufreq: brcmstb-avs-cpufreq: remove unnecessary
 platform_set_drvdata()
Date: Wed, 8 Feb 2017 08:49:37 +0530
Message-ID: <20170208031936.GA14503@vireshk-i7>
References: <20170207155645.5455-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33074 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdBHDTo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 22:19:44 -0500
Received: by mail-pf0-f175.google.com with SMTP id y143so38261708pfb.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Feb 2017 19:19:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170207155645.5455-1-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07-02-17, 15:56, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> index c943606..7281a2c 100644
> --- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
> +++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
> @@ -878,7 +878,6 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
>  	iounmap(priv->avs_intr_base);
>  unmap_base:
>  	iounmap(priv->base);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return ret;
>  }
> @@ -1042,7 +1041,6 @@ static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
>  	priv = platform_get_drvdata(pdev);
>  	iounmap(priv->base);
>  	iounmap(priv->avs_intr_base);
> -	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

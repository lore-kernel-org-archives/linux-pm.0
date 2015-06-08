From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC
 name does not match.
Date: Mon, 08 Jun 2015 10:31:00 +0200
Message-ID: <20150608103100.57f0473b@amdc2363>
References: <1432519780-2910-1-git-send-email-shailendra.capricorn@gmail.com>
 <20150525073149.GF9992@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33155 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbbFHIbJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 04:31:09 -0400
In-reply-to: <20150525073149.GF9992@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Viresh,

> On 25-05-15, 07:39, Shailendra Verma wrote:
> > During probe free the memory allocated to "exynos_info" in case of
> > unknown SOC type.
> > 
> > Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> > ---
> >  drivers/cpufreq/exynos-cpufreq.c |    6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > b/drivers/cpufreq/exynos-cpufreq.c index 82d2fbb..8682378 100644
> > --- a/drivers/cpufreq/exynos-cpufreq.c
> > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > @@ -182,7 +182,7 @@ static int exynos_cpufreq_probe(struct
> > platform_device *pdev) ret = exynos5250_cpufreq_init(exynos_info);
> >  	} else {
> >  		pr_err("%s: Unknown SoC type\n", __func__);
> > -		return -ENODEV;
> > +		ret = -ENODEV;
> >  	}
> >  
> >  	if (ret)
> > @@ -190,12 +190,14 @@ static int exynos_cpufreq_probe(struct
> > platform_device *pdev) 
> >  	if (exynos_info->set_freq == NULL) {
> >  		dev_err(&pdev->dev, "No set_freq function
> > (ERR)\n");
> > +		ret = -EINVAL;
> >  		goto err_vdd_arm;
> >  	}
> >  
> >  	arm_regulator = regulator_get(NULL, "vdd_arm");
> >  	if (IS_ERR(arm_regulator)) {
> >  		dev_err(&pdev->dev, "failed to get resource
> > vdd_arm\n");
> > +		ret = -EINVAL;
> >  		goto err_vdd_arm;
> >  	}
> >  
> > @@ -227,7 +229,7 @@ err_cpufreq_reg:
> >  	regulator_put(arm_regulator);
> >  err_vdd_arm:
> >  	kfree(exynos_info);
> > -	return -EINVAL;
> > +	return ret;
> >  }
> >  
> >  static struct platform_driver exynos_cpufreq_platdrv = {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC name does not match.
Date: Tue, 09 Jun 2015 01:30:35 +0200
Message-ID: <8344426.BL3KyufMos@vostro.rjw.lan>
References: <1432519780-2910-1-git-send-email-shailendra.capricorn@gmail.com> <20150525073149.GF9992@linux> <20150608103100.57f0473b@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45104 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751888AbbFHXEs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 19:04:48 -0400
In-Reply-To: <20150608103100.57f0473b@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Shailendra Verma <shailendra.capricorn@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, June 08, 2015 10:31:00 AM Lukasz Majewski wrote:
> Hi Viresh,
> 
> > On 25-05-15, 07:39, Shailendra Verma wrote:
> > > During probe free the memory allocated to "exynos_info" in case of
> > > unknown SOC type.
> > > 
> > > Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
> > > ---
> > >  drivers/cpufreq/exynos-cpufreq.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/exynos-cpufreq.c
> > > b/drivers/cpufreq/exynos-cpufreq.c index 82d2fbb..8682378 100644
> > > --- a/drivers/cpufreq/exynos-cpufreq.c
> > > +++ b/drivers/cpufreq/exynos-cpufreq.c
> > > @@ -182,7 +182,7 @@ static int exynos_cpufreq_probe(struct
> > > platform_device *pdev) ret = exynos5250_cpufreq_init(exynos_info);
> > >  	} else {
> > >  		pr_err("%s: Unknown SoC type\n", __func__);
> > > -		return -ENODEV;
> > > +		ret = -ENODEV;
> > >  	}
> > >  
> > >  	if (ret)
> > > @@ -190,12 +190,14 @@ static int exynos_cpufreq_probe(struct
> > > platform_device *pdev) 
> > >  	if (exynos_info->set_freq == NULL) {
> > >  		dev_err(&pdev->dev, "No set_freq function
> > > (ERR)\n");
> > > +		ret = -EINVAL;
> > >  		goto err_vdd_arm;
> > >  	}
> > >  
> > >  	arm_regulator = regulator_get(NULL, "vdd_arm");
> > >  	if (IS_ERR(arm_regulator)) {
> > >  		dev_err(&pdev->dev, "failed to get resource
> > > vdd_arm\n");
> > > +		ret = -EINVAL;
> > >  		goto err_vdd_arm;
> > >  	}
> > >  
> > > @@ -227,7 +229,7 @@ err_cpufreq_reg:
> > >  	regulator_put(arm_regulator);
> > >  err_vdd_arm:
> > >  	kfree(exynos_info);
> > > -	return -EINVAL;
> > > +	return ret;
> > >  }
> > >  
> > >  static struct platform_driver exynos_cpufreq_platdrv = {
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> 
> Acked-by: Lukasz Majewski <l.majewski@samsung.com>

I'm assuming that it will go it through the Samsung tree.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

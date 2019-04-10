Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9C3C10F14
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4BE20830
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OujTAQQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfDJKdU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:33:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35297 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfDJKdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 06:33:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so1181920plp.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o6MP4MD2XvqRqDBpI14/SbmM5jumQB8YX4MXAiMxcgg=;
        b=OujTAQQPHwq+Rr4uTnK74C/W70fLAhCmbeQzs7wLTUnxJN8i+7ARsbfJ8C2uFQK2VW
         EWKctw7l0crAZJc430ajsnAkdBEKVrS0lAcIyeAJE41I1QqRZQhaGTavEHn8az8FxP9w
         xIlDRhyb0pB3LwN8fqXS3Efiiv/cG1GIUFwHbgcCikgJtorgUi8miWSIxpTkVb1YB2HQ
         Enc6wk+PYVv0VSXhA/B80gD5yfT+qNeoxUdIQbXxMdCW026nx27ebhaHYxBkf3HAtcTK
         CQGessLwHtGH0qRAcf2vjXGHHG5Irfgyq0gQIeoes6n7/B2H7KTTF/MrECqqayMgyTSB
         lXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o6MP4MD2XvqRqDBpI14/SbmM5jumQB8YX4MXAiMxcgg=;
        b=F90OfI3cUTL/sgfI2P7AKC1ESBPoHyYi/tsDrGsLHcDAD54EL+IdgTvnMNxxn92X9q
         zD4aPnjz0viB32FJO+4h4vTCp0hK6AXkzH0kh9sSDvOxyvqLaCspz8tw/DQW3mUdGSQ7
         66SAb3//7OUZr+H/Bk58DbaN3Yhz+1wfmqXMsnZvIhTYEAW73CZ0VLgv4H4U803zLc1v
         rv7YwzoORZWiF6bnT2mmh/7eOo66MPXmAFjulvATrIvJOlwmy1C9CDC7AmS6a5U1Ta0i
         RRpOKVHkLClTcdwk9G7IUNEPSf234+zOHC6JRnXTFipxLo/H2wjNGmJIrfLilDRQtgg7
         PCwQ==
X-Gm-Message-State: APjAAAVPOMRC4Di+BmuQrPH2MmfejbP0m1bE8K47Qh3V16lhNYT0LbAp
        4Q9xo/bFxIgojgtLVeBGywPo/Q==
X-Google-Smtp-Source: APXvYqw+Nx1Y+7H23kBikUygsyauL9xa46UprB/ftsk+YWYHtSqDL/XDQtgzY94OU/Wa7WZrRXj7kQ==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr43337462plb.155.1554892399613;
        Wed, 10 Apr 2019 03:33:19 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id d68sm50349990pfg.16.2019.04.10.03.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 03:33:18 -0700 (PDT)
Date:   Wed, 10 Apr 2019 16:03:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     robh+dt@kernel.org, andy.gross@linaro.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        cw00.choi@samsung.com, linux-pm@vger.kernel.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        dianders@chromium.org
Subject: Re: [PATCH RFC 7/9] cpufreq: qcom: Add support to update cpu node's
 OPP tables
Message-ID: <20190410103316.sxev2f54klemq2p6@vireshk-i7>
References: <20190328152822.532-1-sibis@codeaurora.org>
 <20190328152822.532-8-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190328152822.532-8-sibis@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190410103316.SYC1d3MEvjIXYEnNx7pYvipSZ3cG-eI_PKhPzNgsURA@z>

On 28-03-19, 20:58, Sibi Sankar wrote:
> Add support to parse and update OPP tables attached to the cpu nodes.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 4b0b50403901..5c268dd2346c 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -73,6 +73,25 @@ static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
>  	return policy->freq_table[index].frequency;
>  }
>  
> +static int qcom_find_update_opp(struct device *cpu_dev, unsigned long freq,
> +				unsigned long volt)
> +{
> +	int ret;
> +	struct dev_pm_opp *opp;
> +
> +	opp = dev_pm_opp_find_freq_exact(cpu_dev, freq, true);
> +	if (IS_ERR(opp)) {
> +		ret = dev_pm_opp_add(cpu_dev, freq, volt);

With my comment on the other patch, you can just call
dev_pm_opp_update_voltage() and if that fails then call dev_pm_opp_add().

> +	} else {
> +		dev_pm_opp_disable(cpu_dev, freq);
> +		ret = dev_pm_opp_update_voltage(cpu_dev, freq, volt);
> +		dev_pm_opp_enable(cpu_dev, freq);

Perhaps no one else should be using the CPU OPP table at this point of time and
so we can get away with disable and enable stuff ? Just add a comment on why
that works.

> +		dev_pm_opp_put(opp);
> +	}
> +
> +	return ret;
> +}
> +
>  static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  				    struct cpufreq_policy *policy,
>  				    void __iomem *base)
> @@ -81,11 +100,16 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  	u32 volt;
>  	unsigned int max_cores = cpumask_weight(policy->cpus);
>  	struct cpufreq_frequency_table	*table;
> +	int ret;
>  
>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;
>  
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (ret)
> +		dev_dbg(cpu_dev, "Couldn't add OPP table\n");
> +
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>  		data = readl_relaxed(base + REG_FREQ_LUT +
>  				      i * LUT_ROW_SIZE);
> @@ -104,7 +128,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  
>  		if (freq != prev_freq && core_count == max_cores) {
>  			table[i].frequency = freq;
> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			qcom_find_update_opp(cpu_dev, freq * 1000, volt);
>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
>  		} else {
> @@ -125,7 +149,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  			if (prev_cc != max_cores) {
>  				prev->frequency = prev_freq;
>  				prev->flags = CPUFREQ_BOOST_FREQ;
> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
> +				qcom_find_update_opp(cpu_dev, prev_freq * 1000,
> +						     volt);
>  			}
>  
>  			break;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project

-- 
viresh

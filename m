Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D1BC282E1
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EDB20656
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMKnq+EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfDVIYB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:24:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34223 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVIYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2019 04:24:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id y6so5501345plt.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2019 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LEXha91MwU9tCp9MNU9ctoQZ4RFYokBegHvyW+s18S0=;
        b=VMKnq+EAWZoFReyRQPeBEDtjxor+KivyBGJbIXi87yG+a9cMKEta9Xko5nNJfMIYLv
         eXi6ZaAnbaytaJTzoRGr62qxMS9D5JkyAXzx1hT7Em1KsbhM9xZIa0dPlbC9xlQRNz9p
         HnKS9NxymwmduAmbUzWjReiMn1ycEGcGoT9+bKKKCKlOV6yNA5HAfeYmEaJDD5Or7RHs
         7VS1mw6u/sPUOQnltKXrVKiMlk/2kPBSKFTzpqhl//XU4HcBxHKmtl8VszL3BeMlHzy8
         osRCUjmpd3PwW2iiNXYU/KLYcq2b1TqK3Q/MD/F9OW97a7Sd8P4bXJ4QAeFIFeaOitBF
         56QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LEXha91MwU9tCp9MNU9ctoQZ4RFYokBegHvyW+s18S0=;
        b=LTa6D5AtlGFkSDuygn/uJiiSsKc1BiVNCLlF2b5wZoyia/dvq8E6A37F7rlHjvkWRN
         /M+zGgAU64oAdynJV2rvUDTULgS+Od5ikPA9Ew65W4DuKSOuIJdS1L7J10e4Kz3o7+hj
         /duNqjRt4bu6fzf4k0LWPfxdwdtbUVejmtT6g2+Ca1ZwZ8UYhH2mUWqRG6l+dfmHBtoM
         tm5XJ7+GRmr8F6I+JZc4AXjGnqn2QzI1WsE3tI3rckT05ii2wT877/Xxd95mUkcanJIX
         liMEcRscqYXwjMt4qY5nanmzppk8969wmL+j6QQczsL0Evx1T0amP+0oHQmv4xryAkMg
         5lew==
X-Gm-Message-State: APjAAAWNef6u35u+fa5FFLi1A6mkiCC8qIG4KUYNnymC+rMmwV0jiBkb
        9vMEje5NKmi7A85A+a4FGbi/yg==
X-Google-Smtp-Source: APXvYqxIA4csbUuux4msC2LY9+FiG0gGiwOzv6Jbss4xz5c//KkxNlsTUx9ojBFougXOhBIKXtQfDA==
X-Received: by 2002:a17:902:e793:: with SMTP id cp19mr12792560plb.65.1555921440658;
        Mon, 22 Apr 2019 01:24:00 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id b128sm15189377pga.50.2019.04.22.01.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:23:59 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:53:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Expose real_cpus out to userspace
Message-ID: <20190422082357.zwrpbbzjevz4kaq4@vireshk-i7>
References: <20190419062759.8524-1-zbestahu@gmail.com>
 <20190419062759.8524-2-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419062759.8524-2-zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-04-19, 14:27, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currently, there are 3 CPU masks, let's expose real_cpus just like the
> others if user want to know related CPUs that are actually present.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index c6187f1..0322cce 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -824,6 +824,11 @@ static ssize_t show_affected_cpus(struct cpufreq_policy *policy, char *buf)
>  	return cpufreq_show_cpus(policy->cpus, buf);
>  }
>  
> +static ssize_t show_real_cpus(struct cpufreq_policy *policy, char *buf)
> +{
> +	return cpufreq_show_cpus(policy->real_cpus, buf);
> +}
> +
>  static ssize_t store_scaling_setspeed(struct cpufreq_policy *policy,
>  					const char *buf, size_t count)
>  {
> @@ -873,6 +878,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>  cpufreq_freq_attr_ro(bios_limit);
>  cpufreq_freq_attr_ro(related_cpus);
>  cpufreq_freq_attr_ro(affected_cpus);
> +cpufreq_freq_attr_ro(real_cpus);
>  cpufreq_freq_attr_rw(scaling_min_freq);
>  cpufreq_freq_attr_rw(scaling_max_freq);
>  cpufreq_freq_attr_rw(scaling_governor);
> @@ -886,6 +892,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>  	&scaling_max_freq.attr,
>  	&affected_cpus.attr,
>  	&related_cpus.attr,
> +	&real_cpus.attr,
>  	&scaling_governor.attr,
>  	&scaling_driver.attr,
>  	&scaling_available_governors.attr,

The same information can be looked into (indirectly though) by looking
at related_cpus and online_cpus isn't it ? Why expose it then ? I am a
bit against it as it is only used for internal reasons right now.

-- 
viresh

Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B7CC282E1
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D2220656
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9rQe5Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfDVITG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:19:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41678 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVITG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2019 04:19:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id f6so5502511pgs.8
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2019 01:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bm1CIuCeZeSy4hfWrM2eKzoNPXwYitYIYWuvHHswoPg=;
        b=M9rQe5Uj3mq0zUvWJ1aQ9ibgG+T8l/ZfHXBTbQpMdwCwTQDOEdTbkXo3S3uKmkk2x/
         eVdkJ4lyw0b7mi1x6dvecYyrxmlE0ea3k1gGvjtfwuo/A0vaFjQcSbI52ryaG486LJkh
         ID1fLH8q6+JQNw8Oi5kvCRIC9qXMveTMIT4iUJQQa4jUZnuHlFiFs5Tjtr+4vq2nVkCC
         NtGYwMu53Ov6zrAGGs4YZFdAhh/MH53r0EgU9puc6hQA4HUqLUkmly04lUEUyTz+EIaq
         vMtkyBKM1i8AsoqWhEWqNeIyOfXf3yI0o3VggcUtTOScuglsY/CKW4at6kIz9wUwuq9L
         PKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bm1CIuCeZeSy4hfWrM2eKzoNPXwYitYIYWuvHHswoPg=;
        b=BaPsixseTFwsvYb4QN5FYtW2Gg8OV/UjFiCQouSkhDVnqcCJPehIDfoGuJwpJMCC3d
         HGJIMWkbKdWB/co9w/NLigDxh5xXhfuAj4ekalwoVD6xV82+bamv17zhs8SwVhqtYxov
         r8I/0hqgfhabi6xKGOR/TJylLimyWswLGP+zDpoSUgDrhtsAyyjy/mlz4oej0XVKWw/+
         roe6Boa76R1A3vk6J8kZrcuVDX5/9eCzZdw/5S9lVYBZ5+KIvgUa6O0bUo0ALGi3FviP
         77HRjUabWjo9qLslejCbthXLkFpN/KHN5Mq6gexl0CF5B+w59TkSwReA3oXUMGwQ/7jJ
         gXVg==
X-Gm-Message-State: APjAAAX+3DP2iGPaRQJvGbB4J/WgOM9myYDi20Bn+aKZTUKA03DwmCP6
        9//PtyNoqMnwsU0TTQ46RuAzJg==
X-Google-Smtp-Source: APXvYqzHVan+PBJZ8pgNuvIUvHiSiq1W3O2OxbQ+g/zV+gL69fcj85RjaGfxLztRjmTuk0qvBFmH8w==
X-Received: by 2002:aa7:928b:: with SMTP id j11mr19342856pfa.200.1555921145563;
        Mon, 22 Apr 2019 01:19:05 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id p26sm29569492pfa.49.2019.04.22.01.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:19:04 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:49:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Move ->get callback check outside of
 __cpufreq_get()
Message-ID: <20190422081902.xeiu66gpspcjbrol@vireshk-i7>
References: <20190419062759.8524-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419062759.8524-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19-04-19, 14:27, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Currenly, __cpufreq_get() called by show_cpuinfo_cur_freq() will check
> ->get callback. That is needless since cpuinfo_cur_freq attribute will
> not be created if ->get is not set. So let's drop it in __cpufreq_get().
> Also keep this check in cpufreq_get().
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 047662b..c6187f1 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1548,7 +1548,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
>  {
>  	unsigned int ret_freq = 0;
>  
> -	if (unlikely(policy_is_inactive(policy)) || !cpufreq_driver->get)
> +	if (unlikely(policy_is_inactive(policy)))
>  		return ret_freq;
>  
>  	ret_freq = cpufreq_driver->get(policy->cpu);
> @@ -1586,7 +1586,8 @@ unsigned int cpufreq_get(unsigned int cpu)
>  
>  	if (policy) {
>  		down_read(&policy->rwsem);
> -		ret_freq = __cpufreq_get(policy);
> +		if (cpufreq_driver->get)
> +			ret_freq = __cpufreq_get(policy);
>  		up_read(&policy->rwsem);
>  
>  		cpufreq_cpu_put(policy);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

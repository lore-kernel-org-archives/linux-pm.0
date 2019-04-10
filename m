Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2500AC10F14
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 04:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A2D20850
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 04:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qGZdbjga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfDJEKJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 00:10:09 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39671 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfDJEKJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 00:10:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id a96so549942pla.6
        for <linux-pm@vger.kernel.org>; Tue, 09 Apr 2019 21:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I1hUJsZeUNhEFZwhF7q+JnsawPC3UHDZU6KqeakLNtk=;
        b=qGZdbjgawqb++IYhdGJ6eH/UYhSuShrqeQaguaKE7dxSOBIHBgGpY5ue/qCIj6ZWZB
         fJ5SDIiwwpZ12xPLLf06vWpoX4ihKCO8e9i9wlgKXbZYTwWKHK0LgMOCFHNshqb+8drH
         eZ584IH+7cSbNDahyL0rQFMDT0PcbXr6QEzFGAri6aLMGhsT/1mF0XIakq465hCRgAqO
         35EJGCpp4vPl7b2k9tgGP+2dBgdwtBwTo5P6gHXP8jsWIAMCYV0N+14rQ4D6kSTGXSgk
         7lo3lWRRyRLmK6rynVY0FL/nbZ83kcmppt9KrYLHrgFzNvdhwVypT2u3JQw5FSsesmsa
         KzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I1hUJsZeUNhEFZwhF7q+JnsawPC3UHDZU6KqeakLNtk=;
        b=MQiT7jVbGOqyUNVg4X7z6qES1jRGsVokWhOYChVQ+ZEYdqv7J4W+Jj6KKJW6aex8/f
         Dz4V9bC/7ZniroUmNMSDaFaPxJ3TgL1rB709HK5FxmDIQgQVbkaKloe1X/t1dPQWPCmC
         /iddhqwhlpXwN7HueAG/WiJP1AmnE9fksg3ABfU7c6Efdic6soFa/X13iI/38ElFUiLo
         GAB7OSMY/B8SQXmhBIZfLC4QjBDUpCbGWRe9SGBj0GQ1+bIpQV+s2qX8GkFb45QBV3p0
         eKpfmklGhXuDztrywybsLkZKY8gUIpflKClgb7ny0d2oUyo3opBw/IKKEvqT5Hi0yCK4
         8i9g==
X-Gm-Message-State: APjAAAVs3UnU3cULHbc/hETyioBQ4zR+m8h/4bXLnJUyKhlkidVxZh56
        IWNdvhVDKGf+Lgr6kTfWF67JNg==
X-Google-Smtp-Source: APXvYqxudYlyIttnPuIrzscTaMB5fy/6w1fWwb6g+cZ4aLRGAWSE31UCweH/B2C8l3q2IDH4KwQqcw==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr3362267pla.275.1554869408399;
        Tue, 09 Apr 2019 21:10:08 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id x9sm55163632pfn.60.2019.04.09.21.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 21:10:07 -0700 (PDT)
Date:   Wed, 10 Apr 2019 09:40:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq / boost: Remove CONFIG_CPU_FREQ_BOOST_SW Kconfig
 option
Message-ID: <20190410041005.iwuppsv7je5oa537@vireshk-i7>
References: <20190410035952.5728-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410035952.5728-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10-04-19, 11:59, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Commit 2fb4719b2560 ("cpufreq / boost: Kconfig: Support for
> software-managed BOOST") added the CONFIG_CPU_FREQ_BOOST_SW config.
> However EXYNOS based cpufreq drivers have been removed because of
> switching to cpufreq-dt driver which will set boost-attr if required.
> 
> So, let's remove this option and update cpufreq_generic_attr[].
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/Kconfig      | 4 ----
>  drivers/cpufreq/freq_table.c | 3 ---
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index b22e6bb..4d2b33a 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -26,10 +26,6 @@ config CPU_FREQ_GOV_COMMON
>  	select IRQ_WORK
>  	bool
>  
> -config CPU_FREQ_BOOST_SW
> -	bool
> -	depends on THERMAL
> -
>  config CPU_FREQ_STAT
>  	bool "CPU frequency transition statistics"
>  	help
> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> index 3a8cc99..e7be0af 100644
> --- a/drivers/cpufreq/freq_table.c
> +++ b/drivers/cpufreq/freq_table.c
> @@ -290,9 +290,6 @@ static ssize_t scaling_boost_frequencies_show(struct cpufreq_policy *policy,
>  
>  struct freq_attr *cpufreq_generic_attr[] = {
>  	&cpufreq_freq_attr_scaling_available_freqs,
> -#ifdef CONFIG_CPU_FREQ_BOOST_SW
> -	&cpufreq_freq_attr_scaling_boost_freqs,
> -#endif
>  	NULL,
>  };
>  EXPORT_SYMBOL_GPL(cpufreq_generic_attr);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

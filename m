Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE3C10F13
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 02:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6159206B6
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 02:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtBpCDKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDOCcv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:32:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34666 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDOCcu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Apr 2019 22:32:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so7820995pfd.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Apr 2019 19:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KHBnELxFBiLS+V72fIhEkMD7pPDCdAysxM99hURq5ws=;
        b=vtBpCDKu1Yaiaopg3yYUziyso9EpBsvFbRq1WFSSjtNewLr3LMg/+PVJo1yXpaxG2Q
         tkRuy7QttYz5AUcR/LNn29stLnFMra+rvwXW9qYGHchoTFjet029xVX4sFdK9Kxljx1d
         /Nrz58TjHHB72lTx5XrQ/JrWKAko8UAefnB3V7JohrRR/Wzaj+Y/mDmE1MAe1be3anOr
         PE5CAUMlROhdPHP4PCwqO2H/qmt+8NHzcNlGvj9blxjlnLj1eZxI1BIn5534rOZ9x/Ik
         1eeWu0TpKRtTP1ZJ1juLh1DWKeEBX0IJKhy264E+hhwM3bqsPQRPtj0hFHkHoJKpwyb4
         VTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHBnELxFBiLS+V72fIhEkMD7pPDCdAysxM99hURq5ws=;
        b=OaZE6lccRKjvF4AyPjtkqmmiLpyVA8VxV3vp2C/ECgn1BENRnJE4cLvLDGbVRvTaEB
         GTqbZOBTZlaeeCsFTzWY6t5wwrsuoTpFTKwIk6/0187k9EblpVbRPNOqYNqMxoKGTQqC
         T3/UqSvddby7KwSR0mSYCc1QfcaAANoqLa0Yd6K4n5Wpq1gVumkD6JF614YyJmuWx6W8
         Q27FM9gYzP0qON1LgND0pjnzi4dZIMirI94c09NnYiAqX1hQe+gnQiFCYV+2q6E49aYs
         5CdWXvr0iLHZyxXHXF94vIpDEFFeWVfuwjHaINuZY5cjlcRefDNANRyxtQiBP6t15nua
         8Z0Q==
X-Gm-Message-State: APjAAAVxr33tEzehK9zzHt4hs+Tfeulur/VLZmIuOa/OBQEBZ7Bs0TIN
        0N8x0uPCxB/IQrbKdKJ6ZUQlRPUwJ+4=
X-Google-Smtp-Source: APXvYqypavwNcy/hbuJm+4RZRm9LLA5V8mA+VWj2TmE/6bPkjuxUBUv32lNedleLMIYwIXYnXa3LpQ==
X-Received: by 2002:a62:1215:: with SMTP id a21mr71841694pfj.126.1555295569937;
        Sun, 14 Apr 2019 19:32:49 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id 143sm83154904pge.50.2019.04.14.19.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 19:32:48 -0700 (PDT)
Date:   Mon, 15 Apr 2019 08:02:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org
Subject: Re: [PATCH] drivers/cpufreq/acpi-cpufreq.c: This fixes the following
 checkpatch warning
Message-ID: <20190415023246.dleoxfczkauebsme@vireshk-i7>
References: <1555243658-11196-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555243658-11196-1-git-send-email-mohankumar718@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14-04-19, 15:07, Mohan Kumar wrote:
> WARNING: Prefer using '"%s...", __func__' to using function's name, in a
> string
> 
> Switch hardcoded function name with a reference to __func__ making the
> code more maintainable
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c72258a..8030dcd 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -366,7 +366,7 @@ static u32 get_cur_val(const struct cpumask *mask, struct acpi_cpufreq_data *dat
>  
>  	val = drv_read(data, mask);
>  
> -	pr_debug("get_cur_val = %u\n", val);
> +	pr_debug("%s = %u\n", __func__, val);
>  
>  	return val;
>  }
> @@ -378,7 +378,7 @@ static unsigned int get_cur_freq_on_cpu(unsigned int cpu)
>  	unsigned int freq;
>  	unsigned int cached_freq;
>  
> -	pr_debug("get_cur_freq_on_cpu (%d)\n", cpu);
> +	pr_debug("%s (%d)\n", __func__, cpu);
>  
>  	policy = cpufreq_cpu_get_raw(cpu);
>  	if (unlikely(!policy))
> @@ -458,8 +458,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  	if (acpi_pstate_strict) {
>  		if (!check_freqs(policy, mask,
>  				 policy->freq_table[index].frequency)) {
> -			pr_debug("acpi_cpufreq_target failed (%d)\n",
> -				policy->cpu);
> +			pr_debug("%s (%d)\n",
> +				__func__, policy->cpu);

Why break line here ?

-- 
viresh

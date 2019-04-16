Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A96C10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 13:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D0D20693
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 13:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw1Ya/TM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfDPNA0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:00:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33351 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfDPNA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 09:00:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so10334335pgh.0
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2019 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SrZnRTtpXja7O8UIo+SLRHe9ho6I7VkaYfLcpfAeuCQ=;
        b=Iw1Ya/TMOANmqGbju8lSCb7TmaHRdIjAYSznP+8mYDsJhPPU4RW5WdveuGwRUoGp9i
         18dkYYpgwofHghiJhSFhQmguFvpE9taWEkg8sO+OnsJhUZhgpt5j11Al49w8NlOjPxtN
         AfaRQXO+rElhvCAAWYQjaYp1ICrTZrS3hwx3K1of69/RABEHw6SilDRR3pAkysY0z9dh
         Ky11jI7opHz0gdteA/jNEU8EFQNU6F4LUhnnb+E7QnNhk4BRAkWXj4gm1f3E5CSyc0D5
         pXxBUUvr74qs3B4GsIOyzvHlXnLLjDyuRLftx27q2wxtnMw7nAmQ4fckM0D+8b7oP/1f
         qlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SrZnRTtpXja7O8UIo+SLRHe9ho6I7VkaYfLcpfAeuCQ=;
        b=LiU+Chu6QF2ROXgRj/6Y955JfDMnh5rHu20XVKcVUXl5x9+t37caX2D+cws/lYB7il
         kxUthPBllVL/vOGm7lPFJL8onvp2uxic8lpQyGFhAmgWazMEckvfQjLG77uT8W0Txw1Z
         XLNPaz85mSCxV3oz/PzemaC2xdwTD36Dn2Sh9B0BG5Fd5WBv/OrETWJeREIWLUr++A1y
         Qx8FtzrNAeSzIGNH5BYfWE/VL6tgdTsp2N6SJIdrPbYaANCJfdgo9nocZoaO/2LLpKBx
         aZ8MVMq9Rt3OQ2rb/whNV7uFmevCDlhKxd0xQiPvtMEADiURhj2AM5dzfClu+3f5pIHP
         MNoQ==
X-Gm-Message-State: APjAAAV+BDQFnEYvvkYcB/t+TkMibuVsZ6NzgmZQfyRCGaeBrQLsmNjT
        rLfIjW2h+X4+iIdtgpOQjJfezg==
X-Google-Smtp-Source: APXvYqzCerjH3fgfQyXSV1tr1AgZVy8V8kJ5AcLS+6noFG159zNefTgPyumcacBLDE4NOHde0NTuCw==
X-Received: by 2002:a63:7943:: with SMTP id u64mr75612662pgc.91.1555419625861;
        Tue, 16 Apr 2019 06:00:25 -0700 (PDT)
Received: from localhost ([43.229.100.82])
        by smtp.gmail.com with ESMTPSA id f1sm77221487pgl.35.2019.04.16.06.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 06:00:24 -0700 (PDT)
Date:   Tue, 16 Apr 2019 18:30:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     rjw@rjwysocki.net, rafael.j.wysocki@intel.com,
        linux-pm@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Remove needless bios_limit check in
 show_bios_limit()
Message-ID: <20190416130021.jwyxykx4blilskew@vireshk-mac-ubuntu>
References: <20190416024027.6516-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416024027.6516-1-zbestahu@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-04-19, 10:40, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Initially, bios_limit attribute will be created if driver->bios_limit
> is set in cpufreq_add_dev_interface(). So remove the redundant check
> for latter show operation.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/cpufreq/cpufreq.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d9123de..047662b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -857,11 +857,9 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
>  {
>  	unsigned int limit;
>  	int ret;
> -	if (cpufreq_driver->bios_limit) {
> -		ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
> -		if (!ret)
> -			return sprintf(buf, "%u\n", limit);
> -	}
> +	ret = cpufreq_driver->bios_limit(policy->cpu, &limit);
> +	if (!ret)
> +		return sprintf(buf, "%u\n", limit);
>  	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
>  }
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

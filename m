Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAADC10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EC420848
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 09:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWbbdUKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfDOJfD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:35:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40663 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfDOJfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 05:35:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so8292244pgl.7
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAyfIb9ZrzX+l2dOZ0b8wapF+5Q/uxTW/bi6bJ0D9BA=;
        b=yWbbdUKiP4MNLS9wyndgsZ5Bj6ncKk3UoigwQF5DF4VBxHEFa3t8keBI1uu1SodLo6
         Jn0Xz2QNiVinXKzqubQHq65iqhcEAFFB0ld1eYmPCbqGO7BLl1PVCNBk64Jzxlw35yvR
         IH7ALyC5YyD+U03CrpHeIohOvgs9VznovQ3nm0hZ70Ifh5ysDVUk3P7uocIrD+mEsQ44
         jeZKF7frDRAK1TbdNNeGJtT+xaD1LK9fZYkZHcs/Rqwa7hm96QqCN2lh1vZUJ6rIzfiT
         fP6rhiNkDUpsBrbkrkl0A1//UnKj+QRqozzHTru5sM9X4rsOe5a0z2C1Vu/UaXIgdiXx
         2i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAyfIb9ZrzX+l2dOZ0b8wapF+5Q/uxTW/bi6bJ0D9BA=;
        b=EgRPQoWEC5gIACRfzl3Pdcjo5tJ31hMbk063YClQumvbU+8oOBjoufH9OIRbWbCTF9
         aZGb1tbj2CQIF/UgypKbjvxNaiHBouK27Hvt7Mwh86Dly5c5c31zG8BoCyENcF+a7EsL
         FDsOZ0Ac0uDpSkwRjR2TuuxGoaT+SMFeOAbeYSPvvtcpWEn/Tr7WLkd21B+X1tWVrMfn
         ScifkjIuhQN0Hu3x3R2sa4DD1JfQ18XFcBEB7ZyfEachAcqMjhW3bUBXoud0Zsv+y+SJ
         VI6R5br0vhHecDsXLMcVTEOmm/Yb8RT8bpRP5STOS4QeWC3sYRKjZYMlYipme0yhk8NP
         dbOw==
X-Gm-Message-State: APjAAAUmxN2rhBJdDlnYkL06D1VDqwIEamMiz8YkAAwBPjYP9xehivkT
        1juQM9pqI6QDh24xsZHqjdU4QA==
X-Google-Smtp-Source: APXvYqzMZpF+2Y9aofb9SfeXFXVrK2czLxNytr6appYoWekBS3UPCtZkHNa4XUFS0i6znia3P1xErQ==
X-Received: by 2002:a63:2c3:: with SMTP id 186mr67260617pgc.161.1555320902194;
        Mon, 15 Apr 2019 02:35:02 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id e7sm46560116pfc.132.2019.04.15.02.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 02:35:01 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:04:59 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mohan Kumar <mohankumar718@gmail.com>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org
Subject: Re: [PATCH] drivers/cpufreq/acpi-cpufreq.c: This fixes the remove
 the unnecessary line break.
Message-ID: <20190415093459.o5zhovuludmnxb26@vireshk-mac-ubuntu>
References: <1555243658-11196-1-git-send-email-mohankumar718@gmail.com>
 <1555320116-6071-1-git-send-email-mohankumar718@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555320116-6071-1-git-send-email-mohankumar718@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-04-19, 12:21, Mohan Kumar wrote:
> Remove the unnecessary line break.
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 8030dcd..73bb2aa 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -458,8 +458,7 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  	if (acpi_pstate_strict) {
>  		if (!check_freqs(policy, mask,
>  				 policy->freq_table[index].frequency)) {
> -			pr_debug("%s (%d)\n",
> -				__func__, policy->cpu);
> +			pr_debug("%s (%d)\n", __func__, policy->cpu);
>  			result = -EAGAIN;
>  		}
>  	}

Please fix the earlier patch with this and resend.

-- 
viresh

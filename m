Return-Path: <SRS0=3FgU=57=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5A4C2BB85
	for <linux-pm@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 176882078A
	for <linux-pm@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMDZHZs1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408091AbgDOIeu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408089AbgDOIer (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2020 04:34:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE7C061A0E
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 01:34:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v2so992656plp.9
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2020 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+q9fhhXPPAI7xxs/9paMNG32NDbx6qowMd0HgUTJNtQ=;
        b=VMDZHZs1bvqz6PiZYIWZ+woRZRnHL6I1fpiW+L4HvfygeUqSu6Ii1p5NAf45V6eARl
         z+UyKYu2Yk4TOIEALs30LSMo28PPAvKD+f6fG3Kig06kRdFrRUav4fixpF9OT8tJ2xHo
         6Ki2asDTK1znR+MWJo94R2r+Y499EyKqr7SVIplFOWDXK07GAfMzPZWomr8np813v70o
         +SrV5GJnZqp+kUIymHq2vrx4L4gA0orij7Nb0c1jNXIUrj6QkdvyErnyq4MHxI5enEY5
         jG5s5q/BQDGIIxt4aFToHbsiSlCulRVNZAaydltkwT97FZmuKX7NeNIu0C6HyaPy4jGM
         LHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+q9fhhXPPAI7xxs/9paMNG32NDbx6qowMd0HgUTJNtQ=;
        b=nAhI724KnN2QBYCqn7Q9RBoTLfhG5k43/IUKSrcdTEgCd0nFitkubapCRtY23TxPTB
         s2sFaR2r0uchTZ33OsXB+QemuUd9fOcwKUBFlhQtexRLc4QpzlhMAyLhWbBtS3ptAU+h
         mSyAq1bbd1MZKKZc7xCpXlaPpl2VNX+bGO6dDjSnPomp+qSZiQaltuTO4oqa3eF95Orb
         NRDN1aozX+tWqgQnSnKC6hn7HHw9PYAU2dS5obOPp9HAQRZ0QPGt4dA6dB/5eKx3Qw0D
         te0Ep5uk5OjaftTArhfxJadS5FYf6wATVV0RvKOWO5utOXLfs7svu61a+Ed8cAmZvh0A
         E03g==
X-Gm-Message-State: AGi0Pub2TDxHnpmFiw2YdoFV87YIonNtX2rx13mzl/7ZTGs+avMIVsxS
        hJUMkF6L86ge9gNf82ugWjbEa2L8c2M=
X-Google-Smtp-Source: APiQypLXlvIf9iAE5/Jo4UuQtf7n/lK3XHyTG3fumOIXJV/vUkc1I5jkiiE3V1Ixruw7tVE1wddAeQ==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr4926706pjb.116.1586939685903;
        Wed, 15 Apr 2020 01:34:45 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id c190sm12840456pfa.66.2020.04.15.01.34.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 01:34:45 -0700 (PDT)
Date:   Wed, 15 Apr 2020 14:04:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: omap: Build driver by default for ARCH_OMAP2PLUS
Message-ID: <20200415083443.mb4ayu5ioyqljojn@vireshk-i7>
References: <20200415081600.29904-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415081600.29904-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-04-20, 10:15, Anders Roxell wrote:
> When building the mult_v7_defconfig, ARM_TI_CPUFREQ doesn't get enabled
> evenwhen ARCH_OMAP(3|4) is selected. Build ARM_TI_CPUFREQ by default for
> ARCH_OMAP2PLUS.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 15c1a1231516..9481292981f0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -317,6 +317,7 @@ config ARM_TEGRA186_CPUFREQ
>  config ARM_TI_CPUFREQ
>  	bool "Texas Instruments CPUFreq support"
>  	depends on ARCH_OMAP2PLUS
> +	default ARCH_OMAP2PLUS
>  	help
>  	  This driver enables valid OPPs on the running platform based on
>  	  values contained within the SoC in use. Enable this in order to

Applied. Thanks.

-- 
viresh

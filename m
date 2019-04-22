Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA5C282E3
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27E620656
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRX5aSNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfDVIbH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:31:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45760 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVIbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2019 04:31:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id o5so1159107pls.12
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2019 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V4IK6/LbTG+pV15gAybXjSOxXA+cfXdQyo/voA2qF90=;
        b=pRX5aSNnEO6HydPKb/DaMq8xerPdRAjcvmwQn6olPCVKhtmP/IzJ0EVPkUPMZt11xc
         8vzf95muBZVfXvHdV9uJUec21UBK8i48xg6sQdpo1ERCVj3cPVtzkJDBeRYtF6yW9ZIg
         qI3pinyPnl3waXpftKbdOCy5ATEuitXS0jtVg/GyRaLrzZdcALIHBrJn4ujYof8PYeGI
         aip1kBmLvArBpshV8bjYKbKeIBfxdXkMFIda3vM/8QA0nnsbtG6+Sk38ydw1gmnNuVBQ
         FRmlP2MJrdSyUA1LvcnaZX+aijbNPlbuFCwE7bxG5cQZujtaV4w9er0Vcp5hP/sQCgN6
         zWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V4IK6/LbTG+pV15gAybXjSOxXA+cfXdQyo/voA2qF90=;
        b=uY8PoFm4gZbRvXxcQQefn1b7+gKxdQ1D6SYm8x28I2pH6UI1q89H9Bfh/PFJZcRakZ
         bEhJhsyHtIrHI0lzHS5zbYp7S44eHJoqF1cQwmEq5yHCOnzIrmQpj65D5+Ky9+J52uxQ
         BD4jrqAd3yHDwUpAxu5Y7ooEU27/X6YPXFQXp9cWPVdSS3OspkOF6GJkvK1LZI5vgf9u
         T12QPZ63iOhHR8dwqzr3kHnrymmj/CgJz0I/1WqyJmxx8cEsoPGSILHv/KUDz0Xv1N6C
         WKUzabftEfq6lsUiHTTq7wjyd1vRG9QLE1rOqzE2PJgfD1VtgQ/fD1frLpBK05sB8ssW
         y2Jw==
X-Gm-Message-State: APjAAAVdsNJfzvY0iODsAiLAIR/2ZMjQCWfm1tVhotDxyvh/CX1RlGrV
        /Tvmf+YrXdrmTs6+SgLgk2refA==
X-Google-Smtp-Source: APXvYqxHgGqR7kXCCHJAZFIAd57VZHkZib+y49hqEOvyopyE5CH3pNlF7d5S1lTm0e+VYmnSxRDbAA==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr18964713plr.84.1555921866253;
        Mon, 22 Apr 2019 01:31:06 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id p6sm15229242pfd.122.2019.04.22.01.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:31:05 -0700 (PDT)
Date:   Mon, 22 Apr 2019 14:01:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PM / Domains: Enable
 genpd_dev_pm_attach_by_id|name() for single PM domain
Message-ID: <20190422083103.xnuvmap5zgbdyk4v@vireshk-i7>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-4-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190422083103.kJn3XD9Q_VXtmbsJXNxvl1_-y0-S7hrzGmpTHLY6T80@z>

On 18-04-19, 12:27, Ulf Hansson wrote:
> If a call to dev_pm_domain_attach() succeeds to attach a device to its
> single PM domain, the important point is to prevent following calls to
> dev_pm_domain_attach_by_name|id() to fail. This is managed by checking the
> dev->pm_domain pointer and then return -EEXIST, rather than continue
> calling genpd_dev_pm_attach_by_id|name().
> 
> For this reason, let's enable genpd_dev_pm_attach_by_id|name() to be used
> for also single PM domains. This simplifies for future users to solely make
> use of dev_pm_domain_attach_by_id|name() rather than having to combine it
> with dev_pm_domain_attach().
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 801f31c87d16..1b026704a8fc 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2512,10 +2512,10 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	if (!dev->of_node)
>  		return NULL;
>  
> -	/* Deal only with devices using multiple PM domains. */
> +	/* Verify that the index is within a valid range. */
>  	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
>  						 "#power-domain-cells");
> -	if (num_domains < 2 || index >= num_domains)
> +	if (index >= num_domains)
>  		return NULL;
>  
>  	/* Allocate and register device on the genpd bus. */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

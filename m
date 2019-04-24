Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3699FC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D858E21773
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTIpmdra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfDXL3D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:29:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42836 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfDXL27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 07:28:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id i186so2586363lji.9
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 04:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zpPSRLRBcyEqIGmktIrdBgDpqqRpEiCH6Crl7bTU3UA=;
        b=bTIpmdradLnpLzBM7YP1RVNVFZ0QsZ4jEYaJE/LUn5pXz1hnC27Mvon1cq/dOfNgdf
         yIchW05XeRH+NONN4sZvVKRVloxINARkgO+ukbvCYMPprysL3jaRvTSDYOUgh56fYRiY
         tquEPkKu82elaEldCzsnnoKHKOKEAFgV4/twy/bRQFArlp3x1htX2el5MxJBXIr0Lyk/
         58VrnT/lznZ8FWJ+RSyfRWf1AgM7LU6/wfrJuZRWKy0zhgDeIl5aJ9nLvbtUfCntjEez
         NlKEIRF/cQaE0xjl8RWnvVOMd9xCI1XWRlzr2Svv+1pcENq3I+rlFuRp+RIqHeoV6Lce
         ZjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zpPSRLRBcyEqIGmktIrdBgDpqqRpEiCH6Crl7bTU3UA=;
        b=DqMxnqJwcCJrWGTIuNxfGNmNsMp3wvj3Q9AjiZHF45cMZoTXtM519XxlIc/22IKDBK
         k3dIzKV3DUw/2kdbPo4vUyseunLUIvSh1qv6tGkevqx95UBmjnmreCtvlvaLmKORLhjt
         jyPhE6C1nWM+fRBeXBEVi5coq93VmtNGqC3DsmsF3c+uxx2ca8O2Jltg4tle5Qil0Pr4
         kQ1jxgkk4nAOzyMq1NUV7s/uXGDVQ8HA1jGbE62iL0Uo1XjFfNBv0s4r4c6i/J28o7Mk
         EI59I4jaWSm84D4Q8iyKhiJLOVdD6JQw0Rr7YvC5dywJKNy7hX3xJmGt+MOaNKsL2gI2
         pbiQ==
X-Gm-Message-State: APjAAAV2JZ7x+8Bek7R+NQS4grJlIsgxlUF6Z/1eU/6i2I0GWcrnQb8K
        +6my8BOZuS6bg0c24yxxHM7tPg==
X-Google-Smtp-Source: APXvYqyFU5bR3HJZqu6EXiTK117Zn0neKbs/DPxre9uviJoFF/dAKpHCF74YAx3MTuDH8nmDD5zatw==
X-Received: by 2002:a2e:90c9:: with SMTP id o9mr17696263ljg.102.1556105336951;
        Wed, 24 Apr 2019 04:28:56 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id f1sm3831573ljc.73.2019.04.24.04.28.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 04:28:56 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:28:53 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PM / Domains: Enable
 genpd_dev_pm_attach_by_id|name() for single PM domain
Message-ID: <20190424112853.GC30710@centauri.ideon.se>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424112853.L6DLLZzG3b8k-x2SBBQh5Jp1tIdLuoJ_dVJLrkyyrDM@z>

On Thu, Apr 18, 2019 at 12:27:57PM +0200, Ulf Hansson wrote:
> If a call to dev_pm_domain_attach() succeeds to attach a device to its
> single PM domain, the important point is to prevent following calls to

nit: s/prevent/ensure/

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
> -- 
> 2.17.1
> 

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

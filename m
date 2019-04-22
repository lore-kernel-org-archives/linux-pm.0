Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A48C282E1
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC75E20656
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 08:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kt5S6/He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfDVI3W (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 04:29:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46412 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfDVI3W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2019 04:29:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so5361756pfj.13
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2019 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m3PGwlPpsgyUOyS06ZuqKyJ0QDPzAiZx9VGT4pfrN3k=;
        b=kt5S6/HeQFZb+baPgbDeRQaq1ulahzGuOJnfMnVqlAYkPa40GW9OGm16ZSxpA2MUnJ
         lNs6EDNHvDKLFg/4kSqJ2Pe3h/f7VlQolgDk0vNgRhpN652pH5h4QgqKT3eUR1+gzcVE
         IAR7ogU6SG981PUrqZ22F7evcnHNurzPUZM4eb/WD4ZRLgNSFbIsIt2SR/R6bAQNmXbs
         IgXv4SEq/uto1skDWV7yGjZXledAxnAB3ja2HyIUvxMrE/BmZ1f3WM/f4haDiPfxLF6O
         uihHbqwPwkav1cMfssJkrGMh+6yzE9wspUz8yk+hPtf54QnWZN+yFyG5Y6fAYk9IrzqA
         MKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3PGwlPpsgyUOyS06ZuqKyJ0QDPzAiZx9VGT4pfrN3k=;
        b=h/9amaFGbQbfpQxAYrFlylYb8fXV1lrz02UUXdF9kuJf+iL6jWNVTOJVc/16hQcsfD
         5ME3aKlR2klp5F5VJl2vAq/ylIgWX5u9THn3qRYvPJKkPu/8HqbMboW/ljROgjKG6MCq
         2Pa3z0cFQUy6Gvy3xauUgympodIpMOGnuaB0DeugVM88nrvtYXYD6gQsnKEOrAUd4gQz
         G95FZ79wCDTku6ALrgcJ1eZeLvJVBOl7xYoaz4ifjsZUuUnSmWOsLqMITPRA8UtivG6O
         lW+R1+3cOGll2RONNZ97L47sHqrmRgx1sx6dqQmEzBPOegEuKpcKoFYONwDN41xyAXtD
         qtaA==
X-Gm-Message-State: APjAAAWlg+GtFyEhPTaSk2U8NPdDoivAYx4B6pPBUEAi09bGqAV45lJf
        IHkGGW036Yms5q3bDnD48vER5Q==
X-Google-Smtp-Source: APXvYqxRhWeNadSfGx1RNQ762BUfDm9v4pE2iRD77jFhEyvbPYeLx4Farovulzgg8yCjdhq6nC3ttA==
X-Received: by 2002:a62:1b03:: with SMTP id b3mr19112503pfb.150.1555921761145;
        Mon, 22 Apr 2019 01:29:21 -0700 (PDT)
Received: from localhost ([122.166.139.136])
        by smtp.gmail.com with ESMTPSA id d38sm14812418pgd.40.2019.04.22.01.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 01:29:19 -0700 (PDT)
Date:   Mon, 22 Apr 2019 13:59:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] PM / Domains: Allow OF lookup for multi PM domain
 case from ->attach_dev()
Message-ID: <20190422082917.3yaxzyg643sdjsji@vireshk-i7>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-3-ulf.hansson@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190422082917.2Xe5plsSOuFFqP7FYi1N7yteL18HtSdHmooaWDxK2sA@z>

On 18-04-19, 12:27, Ulf Hansson wrote:
> A genpd provider that uses the ->attach_dev() callback to lookup resources
> for a device, fails to do so when the device has multiple PM domains. This
> is because when genpd invokes the ->attach_dev() callback, it passes the
> allocated virtual device as the in-parameter.
> 
> To address this problem, let's simply assign the dev->of_node for the
> virtual device, based upon the original device's OF node.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 7fec69aebf46..801f31c87d16 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2345,6 +2345,7 @@ EXPORT_SYMBOL_GPL(of_genpd_remove_last);
>  
>  static void genpd_release_dev(struct device *dev)
>  {
> +	of_node_put(dev->of_node);
>  	kfree(dev);
>  }
>  
> @@ -2406,14 +2407,14 @@ static void genpd_dev_pm_sync(struct device *dev)
>  	genpd_queue_power_off_work(pd);
>  }
>  
> -static int __genpd_dev_pm_attach(struct device *dev, struct device_node *np,
> -				 unsigned int index, bool power_on)
> +static int __genpd_dev_pm_attach(struct device *dev, unsigned int index,
> +				 bool power_on)
>  {
>  	struct of_phandle_args pd_args;
>  	struct generic_pm_domain *pd;
>  	int ret;
>  
> -	ret = of_parse_phandle_with_args(np, "power-domains",
> +	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
>  				"#power-domain-cells", index, &pd_args);
>  	if (ret < 0)
>  		return ret;
> @@ -2481,7 +2482,7 @@ int genpd_dev_pm_attach(struct device *dev)
>  				       "#power-domain-cells") != 1)
>  		return 0;
>  
> -	return __genpd_dev_pm_attach(dev, dev->of_node, 0, true);
> +	return __genpd_dev_pm_attach(dev, 0, true);
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  
> @@ -2525,6 +2526,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	dev_set_name(virt_dev, "genpd:%u:%s", index, dev_name(dev));
>  	virt_dev->bus = &genpd_bus_type;
>  	virt_dev->release = genpd_release_dev;
> +	virt_dev->of_node = of_node_get(dev->of_node);
>  
>  	ret = device_register(virt_dev);
>  	if (ret) {
> @@ -2533,7 +2535,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  	}
>  
>  	/* Try to attach the device to the PM domain at the specified index. */
> -	ret = __genpd_dev_pm_attach(virt_dev, dev->of_node, index, false);
> +	ret = __genpd_dev_pm_attach(virt_dev, index, false);
>  	if (ret < 1) {
>  		device_unregister(virt_dev);
>  		return ret ? ERR_PTR(ret) : NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

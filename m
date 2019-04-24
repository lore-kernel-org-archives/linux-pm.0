Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BAEC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75032218B0
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfOV/TLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfDXL2m (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:28:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44207 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfDXL2l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 07:28:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id h18so14326269lfj.11
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 04:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JLAt8vXpMzvmVMwhnN+jHxhJwJGzPfS5OLUsC0yAZUA=;
        b=CfOV/TLnhnkg1juwsOsG01zyv6OsZwNul3cYLmIlKkBzEQNPYchHfDfrA1XG8UFTZg
         Zisj5nIZLhM5tsg9LCkTabeJAL5U33AcPixX04OkFH2k3arFVBKKp+2akXurJEtquQUy
         GuvVvkrTVxnu7DUYUqccHH4sT3+2335dtWIAIpfiCRNtZucw1BbUXUwGPq/BheyfH1Eq
         i+P6br0gOv+2BaX+ESt1RsRyC1Kn+sKjV5oxki+OrER8yjkdywfBuT+NEEhbzwG6raKa
         0SQ2cX5uNo+4DKF4BKovq2QuYusUJyWNjlNDpn3kyxrCuEHFV47CrLGFnz4A0rv6vhWr
         fpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JLAt8vXpMzvmVMwhnN+jHxhJwJGzPfS5OLUsC0yAZUA=;
        b=XBewqD6FH3U8joahkJitrqP8ozGP6evfv2AqFo5bRpm1u/A5ktao0pKuoZadGIqggV
         afzYKv2+fgbpmZWfEu7lC3fuKeYcKlAPiVUn2blstuWvcIt6s0mrWgS9OsJB+hv9jW5+
         s75OxU5gD4tMobEuAH11EdtWddBKRFH04HRNtVYpXPr87vvPXBBzcTRjp0iLSjM+l9dY
         bQ+hLzT8D84MVrVW4mCT3KGIE2JpGaX0peauN3MRf1CtF6c+BzCOhLy9BxWVQl9/SUCg
         JlyxPZwhK9s4xYykj+Bg0hYFvBIvfsN02U1gxYiG8xaCgvxebrWzlpwX/NbhYQyMYKfH
         E9Kw==
X-Gm-Message-State: APjAAAXIMdy42hdr46Ejbzxdd0DYkAJOvYb+svc2+qDtLLeXPyTyyqHM
        hKpJUoigN85X6EXfJlvq3hxRxQ==
X-Google-Smtp-Source: APXvYqyXYE+d2mJ/Y3bIRxfDu7tFy+jH5o51AUMUHYw2Dw0uZUcir5eojjpE21qgwwPUcicQTdEiCw==
X-Received: by 2002:a19:4b51:: with SMTP id y78mr16907674lfa.152.1556105319570;
        Wed, 24 Apr 2019 04:28:39 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id g5sm1179521ljk.59.2019.04.24.04.28.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 04:28:38 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:28:31 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] PM / Domains: Allow OF lookup for multi PM domain
 case from ->attach_dev()
Message-ID: <20190424112831.GB30710@centauri.ideon.se>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-3-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-3-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424112831.OX2A5HfjEE1NnjCmBce7tQglrjvadzQTMtAKcJp6-U0@z>

On Thu, Apr 18, 2019 at 12:27:56PM +0200, Ulf Hansson wrote:
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
> -- 
> 2.17.1
> 

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

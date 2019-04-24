Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D3C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEF021773
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvFgMT0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfDXL2Y (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:28:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41539 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfDXL2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 07:28:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id t30so14364330lfd.8
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zzvC/I/Gu9rK4bmZmQZJou+6+hsvOOS4ENInmjNp8gE=;
        b=fvFgMT0HFBUbT6XcwleukJ1uTKZ7GnMk+kJBkPIB2CxyQgYqxvL2ic0eIzKnM0xnX6
         creck7YFBKo8cucKEQQWWfIiBnzxNc9bLad9CXJWHfnoePjqAcmOJpdIEDgM91h7LuoS
         1g6UYE11IERvENpFobkhwvmRD4ANGDR7bNwvhZqriHoIEAkBpamIlpaIYG/9bMdD1iMP
         zO9+nAXRKmSE8i2yEVJ2+Fz51F0Es+G8Y9/fPrhja4rWo54MAiSJXxum1+JT2UGtgjKq
         UfCgzawENXAuV0fiyWcj1sCrUHQ7a7vj4uiUce2rvZMoA8SP1YNIoOu2j0tvIHN87Jl4
         BKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zzvC/I/Gu9rK4bmZmQZJou+6+hsvOOS4ENInmjNp8gE=;
        b=moDhtZ1mIfHPdDHXeSPxn3V84jF/NXvoTEveEXvXSH+bPCYRHELNpKOloI6wkBpZ5O
         EmaUdflNcM8oK/2hZpApQ/+prvlL2HCKouuisGrhhL6RvrRDUv2RX/8T87XGPMmwY8ox
         qhtu4QD0SWjaBSU+P5Jrxagx5i8RdnkjLPS5qUCsKhsfSfkvd7ag96GgWq6PNKujaZOD
         cJZGrqqhflPbsEPlOO8aZAv8vfHx+cjKKeBSGIJsBex9k5wdB7GxqZYYh9mgjaqP2Ol/
         7JBUEYNEuJKvNHZ3KuupvGL2YWp3sbNSfMBaLX4HqFZ7Pqm3JShiaKvxR4HtiKshdZpr
         D8VA==
X-Gm-Message-State: APjAAAUYN8OHWa8loSRj0hkqvsvBIjfISwyGq14S0pakNTl4/7z9XAVU
        Dtwny+knFfch/ZmI5kl+UW6iHTEZLYc=
X-Google-Smtp-Source: APXvYqxS0A1Xt4Hd7k29/jDCI2DLTZzsQWJDtTo5H0Z1BdSV9/s7/JLM1h++Ap00K5VSYRlVUvUBbg==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr17974012lfi.46.1556105301834;
        Wed, 24 Apr 2019 04:28:21 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id k73sm467649ljb.6.2019.04.24.04.28.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 04:28:21 -0700 (PDT)
Date:   Wed, 24 Apr 2019 13:28:18 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] PM / Domains: Don't kfree() the virtual device in
 the error path
Message-ID: <20190424112818.GA30710@centauri.ideon.se>
References: <20190418102757.1246-1-ulf.hansson@linaro.org>
 <20190418102757.1246-2-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190418102757.1246-2-ulf.hansson@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190424112818.3RxBd22wsxD6AAeA7lvKaph1bEPG3xz1sj_tLEetO94@z>

On Thu, Apr 18, 2019 at 12:27:55PM +0200, Ulf Hansson wrote:
> It's not correct to call kfree(dev) when device_register(dev) has failed.
> Fix this by calling put_device(dev) instead.
> 
> Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index ecac03dcc9b2..7fec69aebf46 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2528,7 +2528,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>  
>  	ret = device_register(virt_dev);
>  	if (ret) {
> -		kfree(virt_dev);
> +		put_device(virt_dev);
>  		return ERR_PTR(ret);
>  	}
>  
> -- 
> 2.17.1
> 

Acked-by: Niklas Cassel <niklas.cassel@linaro.org>

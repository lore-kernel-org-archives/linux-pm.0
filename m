Return-Path: <SRS0=KcDj=TD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA6EC43219
	for <linux-pm@archiver.kernel.org>; Fri,  3 May 2019 06:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DB12089E
	for <linux-pm@archiver.kernel.org>; Fri,  3 May 2019 06:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8WzAVLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfECGxC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 May 2019 02:53:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33093 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfECGxC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 02:53:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so2435157pfk.0
        for <linux-pm@vger.kernel.org>; Thu, 02 May 2019 23:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MP2a4YZJGQDVStI8DCNt3Bb4JMtSaXiamt8eEg636qY=;
        b=C8WzAVLn1cK8SE1HxrOghgvjvtCHczimxGc6hhkdarY+m9Pmzj3IPei0uCs+p48zrx
         erR42wsR0VSkdrK8dPvk1DhVl8HXjXfwzeRgob4UvnYZjE15LH2WSaOr58VzeJ6cwdkb
         B6xwP1F5oyYK/FXml2IpeWTFCNnKKZwispuwfvXqtT0O3NQtgCGQPxUwIGJcTkPJgJ0N
         w0KVZyiVnh7M6cIe2jtdnKLcTVRnlimLYF6itX7qABZ2PC4s9kn3EZaKUGZAiZhaS8v3
         VfcEjePuzZAB1s19zrVNJqxXw5XdLuUxO9vEcyXWTywafEMygGUhIc45VV6ZmOOJeYIK
         XWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MP2a4YZJGQDVStI8DCNt3Bb4JMtSaXiamt8eEg636qY=;
        b=C0kmbpl/4hRJMT0yfxyVJom56/rzvPzJi9F3hopawHxRP0vbzo/1YAZoVmQ68/7Vpm
         1GVaNElzU/88319NCws2+zo11yNWad41jD0EJWJb2CJKyQp+WwUQ2IRGItOqVjB/lipb
         dsoQbepXMSHAjf+QPRUqcdA0TmO+I9/aHpexApWrlx5E71L0WY9HOr5BJiUeyOdEapjh
         iVSu8j652tewPi0lVW7254C47KJ9wNZu3kmN2Bdc+PoyqHurmHUoqDRv8nUPyqSq0Odf
         BwhQpG7O5VMTj5xJTVq0If4KTb+SmmXB78aiQhcAfsTEzwlmIZThdjF6bIsKM9uvpfJ8
         0m3w==
X-Gm-Message-State: APjAAAUTv9x5I4NsnrzAgj90aSXQnP2BXrvhT6fOA1T82GTX+pW7ENC6
        jETEIZ6ZVfuwp7ehqGyqqaqxzQ==
X-Google-Smtp-Source: APXvYqy/yNdFMlGpc+MelsaSJ6NGegMvTDuo1pqPx2mpX1Qaf0do7XWnYscKVQgvcZ+75ybb7c00qw==
X-Received: by 2002:a63:90c7:: with SMTP id a190mr8589262pge.23.1556866381464;
        Thu, 02 May 2019 23:53:01 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id k65sm1337441pfj.141.2019.05.02.23.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 23:53:00 -0700 (PDT)
Date:   Fri, 3 May 2019 12:22:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mm: Add cpu speed grading and all
 OPPs
Message-ID: <20190503065258.vdlrz3wsr5oq5nwj@vireshk-i7>
References: <cover.1556836868.git.leonard.crestez@nxp.com>
 <cb0329b83347e551911f3d474cf512f3fe10cde4.1556836868.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cb0329b83347e551911f3d474cf512f3fe10cde4.1556836868.git.leonard.crestez@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190503065258.uJBCcUliEzKVWy5bGf8vYDJ_gErp1nhekknxj0RZLvo@z>

On 02-05-19, 22:44, Leonard Crestez wrote:
> Add a nvmem cell on cpu node referencing speed grade and the 1.8 Ghz
> cpufreq opp.
> 
> The imx-cpufreq-dt driver will read speed grade and disable higher opps
> if unsupported.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

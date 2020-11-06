Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D9C55178
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 19:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9B820882
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604689696;
	bh=DXLwmQHHpDo9nFRDXHoMT90Hc+3mtsce7YFWWpdmOBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ptaj2phtOv4/I6rDs0qGj/8UT2v4VrLmxD0pAsv05ha2YvuEP7Lgyq3yxIN2BFFce
	 Woujz8PixpNO3ZuxdNsZgPnwU9SiefpchPWEN4YRBz14GznR+I1CYIQgwfsmS7PzWJ
	 gqd6vCWnGZiBHIOlm1ceKI2gq8q/i0n42Z1iWmx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgKFTIB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:08:01 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:43994 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFTIA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:08:00 -0500
Received: by mail-ej1-f68.google.com with SMTP id k3so3378420ejj.10;
        Fri, 06 Nov 2020 11:07:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSRlYHuywdWRpC+6sKjWuShna66ePHGcqQt+y1/po+0=;
        b=YnSe2WzhD3lIuyNfeJBxmNC6BwBf2tH0cf2saXSV0RCNmgspnPGw6FeEyhtT5xexiq
         3k1lrbe/GvJqEKsGwkc980uO+rMUggHTPp2WMFPEhIlMgKrlizQ+W23+AYZSeNJnPwDv
         P5ryRlRK3fP7kWV9SPdFpyF2DFDzMLFRS5xSRBJeTBmQmP08nY6mng/EiCw6YQkk2wK0
         j7OObEC27aFq/xg/ENZpbBCRET4JjgL5YvgP33PiRKsM1UassMs/nIfwHEyu2kSTCDrw
         UAOOl8+1tlMTkD5bIdLiYjlpWJckUR8UL39KrbMqe8GtFOBx6AJHuvW+mEC9fOUnawkK
         +8wg==
X-Gm-Message-State: AOAM530DXkVU9VUlj50rBU+AYuVrrlxoQpSGSVBmIdx4Gl6nwhZsGv2L
        x/Ju8ErxDAJ0Gj7Elxi34ls=
X-Google-Smtp-Source: ABdhPJzFa68ebDwk5lalVoltFD4aMGkh6HgSZordIoLzyIQ6wpTge+Rgk+a9czQkI4VGwM2RcAkE5w==
X-Received: by 2002:a17:906:d94:: with SMTP id m20mr3492001eji.279.1604689678622;
        Fri, 06 Nov 2020 11:07:58 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n1sm1676128edt.66.2020.11.06.11.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:07:57 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:07:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 33/47] memory: tegra20-emc: Make driver modular
Message-ID: <20201106190755.GY65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-34-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-34-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:09PM +0300, Dmitry Osipenko wrote:
> Add modularization support to the Tegra20 EMC driver, which now can be
> compiled as a loadable kernel module.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/Kconfig       |  2 +-
>  drivers/memory/tegra/tegra20-emc.c | 17 ++++++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)

Thanks, applied.

Best regards,
Krzysztof


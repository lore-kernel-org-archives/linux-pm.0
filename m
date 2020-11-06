Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4FC2D0A3
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B00520B80
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 19:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604689556;
	bh=zzEgAt84b9pnsCMBdecSb4OyDMO0SG4g9v+I7CCNf4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hLY/gALxPU8vyQUj4YU4mrefPSP4TD+J88nUM4FdmhsksjRdF/IEOyi94L7zmah6P
	 xafeN4mex1BtSJwMq1y5FpOXUTfHaRGf4jZUXywM0ajmy3COic2YidRSeYP7a0bMBd
	 xR/afRxgVFBfBl3k3sHBiXISkwl5pd6VZQG4klTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKFTFz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:05:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43888 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgKFTEU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 14:04:20 -0500
Received: by mail-ed1-f66.google.com with SMTP id b9so2327620edu.10;
        Fri, 06 Nov 2020 11:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OYoeHJD5uO+sjh4LU5bBd2tSOxd4znP/rBtSzv6s3jE=;
        b=QTpuCRPuUnnYaEzaTtm5h09GPzmxg1WUblkkrlShLX+cn9/cETTshUtbtwwBiBhrlm
         yhU/G1FxJnaV9Y1RCv2JRwOLregtcsF10BjlrLoBbUMLdUtS3tqJWXWPKis4IMKL98xS
         ivS4p95wfibfUwFfaY6+v9KRAzcukiKqOjgpvqGFxTGzrYbPXU0ch286KguQrEv72Z1Y
         Py+tOIVQ4Pz7YfvChh+0QpkUU/bA9zfUnWqOWPOyr2I1ho7MN55fDDuSvv2zJfPj18OP
         28y0GvKyzQEwJDwzbnF5vhoDm7kimZ1godX5sVbaAiOFK+9dsPNGIN4GImTdewedUPTN
         JpnA==
X-Gm-Message-State: AOAM530/5/JvB01N88YEm2+WGPUjxTmQ15JqSSjb9sFrMpERKYXNc85D
        sXaHXZuoqHuzyojYbwFAPDY=
X-Google-Smtp-Source: ABdhPJweanm0OOnvcB9aFJuyXOJm4oH/48y7DTX2fQEoxC2KJiI8dXLP4F/k1VTns2KMJPkHkBngvA==
X-Received: by 2002:a50:c945:: with SMTP id p5mr3499724edh.55.1604689457685;
        Fri, 06 Nov 2020 11:04:17 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id e13sm1690688edc.9.2020.11.06.11.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:04:16 -0800 (PST)
Date:   Fri, 6 Nov 2020 20:04:15 +0100
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
Subject: Re: [PATCH v7 30/47] memory: tegra: Remove superfluous error
 messages around platform_get_irq()
Message-ID: <20201106190415.GV65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-31-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-31-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:49:06PM +0300, Dmitry Osipenko wrote:
> The platform_get_irq() prints error message telling that interrupt is
> missing, hence there is no need to duplicated that message in the drivers.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/mc.c          | 4 +---
>  drivers/memory/tegra/tegra20-emc.c | 1 -
>  drivers/memory/tegra/tegra30-emc.c | 5 ++---

Thanks, applied.

Best regards,
Krzysztof


Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CECC388F9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F1C2231B
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 10:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603794436;
	bh=lYLO5Fe+o6OEdoG9129m1u7DZ86BqyXgk0VfVwNX4zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A1UOPnYcJhbEBzHuV3VIRQl17P4RhxMWPYsoFeTvzoOV1stNn5flwAsMNU1qz7Aqy
	 Q13CvzPKeSQEUkdY+drIQFKLs/YYnys94PuTSUyBNRlswWRSCfUbr/op/x+O4EHQRd
	 bSGVwrkwf7+/unwfYogCwTjWpLqh/AjMrPeFfUjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898109AbgJ0K1O (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:27:14 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37915 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898088AbgJ0K1N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 06:27:13 -0400
Received: by mail-ej1-f66.google.com with SMTP id ce10so1452429ejc.5;
        Tue, 27 Oct 2020 03:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GA4OG+9SkS1dLHEsjc3Yoh5BLzXMpIvERF6qvUQNUY4=;
        b=YAAHhQsyCGuwceyID1pvebu0hBqjx9cqJdplZSmf1a54PjabEYmiPCoVqUHlk8AGjn
         LyGPJzXzIFZzLfz+UhQRRV4fsuqrIbx9cz+K+Ufn2MUNKoOTL7HWLeF+6z2gHi1rgqKX
         hBOSPVPPYkbgEU3OEzxEmzSEaJ0wh2FY68d9cWKFA9TrWu/AUtRP9GJ/TRgwgAbRvoCe
         SMr9VML3FaOil9SExdLJcAmCBljc9sG2Yjpgh3lhewmOuvzTEVbTSO1mhUMsVisONR5k
         9nSZZ8GPQ5LbCvNG1HzGf+Eiz5/eJu8Nkd2kotLskUd2/ohOS8D88a+rR13MQIN7V3/d
         9rmg==
X-Gm-Message-State: AOAM530UDQHtRqCQAPkkZrjkT2p80p1K6KxEwA0Y0MrPe/6998JPN6YM
        1A5HuqWUmVNszmrcbpijMuo=
X-Google-Smtp-Source: ABdhPJwIxxoNhNQ2HMjdRGaVcneAee1se1I+5gUMBtanj7k+CUK0Tcdt0/GUf0w3biz06LUetV9mlw==
X-Received: by 2002:a17:906:1e45:: with SMTP id i5mr1606932ejj.203.1603794431491;
        Tue, 27 Oct 2020 03:27:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id u8sm752822ejt.46.2020.10.27.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:27:10 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:27:07 +0100
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
Subject: Re: [PATCH v6 41/52] memory: tegra124-emc: Use
 devm_platform_ioremap_resource()
Message-ID: <20201027102707.GC17089@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-42-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-42-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:17:24AM +0300, Dmitry Osipenko wrote:
> Use devm_platform_ioremap_resource() helper which makes code a bit
> cleaner.

Such cleanups (and few other in this patchset) should be at beginning of
patchset or even as part of a separate one.  I think there is not much
stopping anyone from applying these... except that you put them in the
middle of big dependency.

Best regards,
Krzysztof


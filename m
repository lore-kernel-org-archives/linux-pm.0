Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E9DC1B0D8
	for <linux-pm@archiver.kernel.org>; Wed,  9 Dec 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC86239D1
	for <linux-pm@archiver.kernel.org>; Wed,  9 Dec 2020 20:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbgLIUSA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:18:00 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38429 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgLIURy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2020 15:17:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id b62so2667366otc.5;
        Wed, 09 Dec 2020 12:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQJE8H8jL0GuVk4uta0YS9al3HMoyg6NYYR824t9oo4=;
        b=jaDVgY2oWTSQLJ3u6gU3QzSK7j42Y/xCyhSthGMvye4FS9CKjoNdShiFaN9Hq5v+4E
         t9G7iJlzgIJcjxrZO6DMOhhJqzoSz7EFO92aT18qhkLGKlspFVq0sG1jWPOpTUd+pLdM
         YgbY2F84Cs8gTQh9cXt2lAZo9KGo5JBRrftjwEkZsihvboEp/LCafZ+puinvynnA7xPh
         1q+L6jPSj0QeJ5VttgGI9wR/V2lEvhbUdmPa/9i5ouDsT1Y8WOGTuSnjTjU3pYNfUejB
         qxkpSHB3/19q8Ztb8ce1scQu+J8nwdCA8EMyhEMb0RFsvcO2ESHmuL3tvmCdLZ4DcQJo
         PSgQ==
X-Gm-Message-State: AOAM530N5i5Ge1woNF8vFaCeDumnMGaQzIeOd/JE/WXTsFaq3g2XSrdD
        9UFvW71XqXU8Q0OhnoOrpA==
X-Google-Smtp-Source: ABdhPJzdsQhV4dln150sXm2W8SFoCWPsrRVllQ2LeGuEnPn5uQhzfTQIRRsvSJDo1MvP2BtF8BbYew==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr3317872ots.336.1607545032918;
        Wed, 09 Dec 2020 12:17:12 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 11sm595360otg.34.2020.12.09.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:17:12 -0800 (PST)
Received: (nullmailer pid 869734 invoked by uid 1000);
        Wed, 09 Dec 2020 20:17:09 -0000
Date:   Wed, 9 Dec 2020 14:17:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        dri-devel@lists.freedesktop.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v11 01/10] dt-bindings: memory: tegra20: emc: Document
 opp-supported-hw property
Message-ID: <20201209201709.GA869677@robh.at.kernel.org>
References: <20201203192439.16177-1-digetx@gmail.com>
 <20201203192439.16177-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203192439.16177-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 03 Dec 2020 22:24:30 +0300, Dmitry Osipenko wrote:
> Document opp-supported-hw property, which is not strictly necessary to
> have on Tegra20, but it's very convenient to have because all other SoC
> core devices will use hardware versioning, and thus, it's good to maintain
> the consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt      | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A12C2D0A3
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F83A20B80
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687366;
	bh=5diTxGw2AEqgzb0jXMT3dN+6sowN5xKIFcAVKI109v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QN9dIiiZLRLSXIOAqSmUbPxo5+02KGDMzGDOVHPIkmld23udWwXCp3CKyM+dfz9F7
	 ghDfI74iZ+5kpIHEiwweTD+8rF3+b5dtylsuFKh48tE9CifhciW4QFpBibgRdv49ue
	 hZzxFdsFskgXPEIYAPKR+gHXtorVbpTYBV+PWgos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgKFS3W (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:29:22 -0500
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42046 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFS3V (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:29:21 -0500
Received: by mail-ej1-f67.google.com with SMTP id i19so3234541ejx.9;
        Fri, 06 Nov 2020 10:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wp1Q6KNiL9YKZH7bSvi2WyVUJFnoIVwyd49z4fxloYA=;
        b=mxePGZfiwfhjX5m7IdM4soQ0y8y5J/Nvmdo2wJ1QnGJbooojxCrLuL59BDil/XCseB
         ckWx7P1PE09a7ENWOJT3Df0JHH5+T9FcBbOiri2VKO4af30ipqIiOT4dHyfsiOG2QndK
         E354Blu8I/voJGezoKkmkqvY3vkgSHZjMrVs56BtNa4ufjM2gFUTU0ojkGnMe9dAcJPS
         v9d2E5CpNcioL4dGOlR9Tmxc+xnZiUo82fZLjuycKUhwwfzxPXtn4/IRMeXPTQpahFVI
         pAbUtbnBD/rM6SdcA26FN1ruOib7eekkXiRG7NcQkmf6YjZi9rM9QfhesVvNTKa0NBEA
         D1Qw==
X-Gm-Message-State: AOAM530slq7J9jV5vnasLICQlmem158Xobfbamx/x4pyS0v383U7XKyx
        g7kb7Xr7S2Or59NQdOpZYKA=
X-Google-Smtp-Source: ABdhPJwKB3kkwuN91Iv9ZSc+KN8sH7TKYii9j8H0M+uTpYlKqNSgp81NFCnF8WEz3Paw4KtpAx5EdQ==
X-Received: by 2002:a17:906:4712:: with SMTP id y18mr3306818ejq.51.1604687359083;
        Fri, 06 Nov 2020 10:29:19 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x8sm1589921edv.43.2020.11.06.10.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:29:17 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:29:16 +0100
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
Subject: Re: [PATCH v7 05/47] dt-bindings: memory: tegra20: emc: Document
 nvidia,memory-controller property
Message-ID: <20201106182916.GE65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-6-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:41PM +0300, Dmitry Osipenko wrote:
> Tegra20 External Memory Controller talks to DRAM chips and it needs to be
> reprogrammed when memory frequency changes. Tegra Memory Controller sits
> behind EMC and these controllers are tightly coupled. This patch adds the
> new phandle property which allows to properly express connection of EMC
> and MC hardware in a device-tree, it also put the Tegra20 EMC binding on
> par with Tegra30+ EMC bindings, which is handy to have.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 ++

Thanks, applied.

Best regards,
Krzysztof


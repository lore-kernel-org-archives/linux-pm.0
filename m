Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1454AC2D0A3
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACD121D81
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687824;
	bh=3RSM3MXneLxwb+3HlMjUvWz4PFPDFHoc57ONKsxgeWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvIsHlaHwLqP8YQGvtd9+2HnFCSgLzxEOscTgAjwjoiKYJtMRIiKvzda5oD5gEnLI
	 hY9qYMtyN5XKAZcg0sZj0Xs8J8a2PUWHa8WnjnUxkCfpIG8eiLlEFvT7sy7NbHiZlk
	 UvKaxfq9Ub6PrFoVhJhVv8M10TRRe1ZD3H8Xcf78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgKFShB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:37:01 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41755 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFShA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:37:00 -0500
Received: by mail-ej1-f68.google.com with SMTP id cw8so3273775ejb.8;
        Fri, 06 Nov 2020 10:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eVuXfSi6dXqHZAsAebY9YsjeYiR6CGt+Ck/Jel1E2RI=;
        b=olA3x9zl4NIeZ9QaPHO5HsDC45s3G/CtXwVjKbENtbNODYmLtXan+xgC9aIE6cKnQy
         2WEV4QRJ1iOBJQb0pNqEjllX6gPS2eyjG3Y7j7RXKouyHLDN/2TTMYh780ePNkU8rceY
         WXhzgxaXhquS2/pF/MpdHWVxml0S6dQnAXzSftOI+qEoZgzvQ9aG7zBGe1+DD8b+ZFvg
         DPkWJjgMYMS7jFyF5gn8QzUvUmrRhZ1u587cajy2d5c2pQbn8TNguSD7rOO6nvzOy+gK
         h13WlOAumv/1k/JalaqlaM9OOB8lB/GwI9TVGXAjnqBrCmBHLs7CuGqq3vcZIGLCst3F
         PJ6A==
X-Gm-Message-State: AOAM532GftMutatHSf3EZiB/511cfndvYPjW6vqQ+d7QI9En+pDSiNTR
        2PUFAL9x5T8fqgFy/BOlI/0=
X-Google-Smtp-Source: ABdhPJwPUrSMVeCYqxnUBZgYyr2K6ZYpoE0trApTbuOdsRiIJ/AyInjfwpXVjmsroGkQgNNQawtfIQ==
X-Received: by 2002:a17:906:d8b0:: with SMTP id qc16mr3331993ejb.268.1604687817174;
        Fri, 06 Nov 2020 10:36:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z13sm1488997ejp.30.2020.11.06.10.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:36:55 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:36:54 +0100
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
Subject: Re: [PATCH v7 14/47] dt-bindings: memory: tegra124: emc: Document
 OPP table and voltage regulator
Message-ID: <20201106183654.GP65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-15-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-15-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:50PM +0300, Dmitry Osipenko wrote:
> Document new OPP table and voltage regulator properties which are needed
> for supporting dynamic voltage-frequency scaling of the memory controller.
> Some boards may have a fixed core voltage regulator, hence it's optional
> because frequency scaling still may be desired.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../memory-controllers/nvidia,tegra124-emc.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Thanks, applied.

Best regards,
Krzysztof


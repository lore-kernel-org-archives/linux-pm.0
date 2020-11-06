Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F8CC55178
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7E220B80
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687340;
	bh=a/IqsJkXmbGfBkNlHhiZJnrxcbBgoq0ZTK/MaoyKaLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=becRCc5Ir+LUAPM6VZ4uEOBMiplqtaVGkNPB7yBjuosd7kG8OyTUy972TRsRL4KB0
	 bGI6zA3L/MYMvzoNjZVo9qJyoI0fKHhA5NPXXHbFlt+nuLjJxN18xU3ZvJz18NQWzp
	 byOVKT5BrdeMG6+1pz24K0Y5VAoQfc2eNoAnettU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgKFS27 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:28:59 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45913 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgKFS27 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:28:59 -0500
Received: by mail-ed1-f66.google.com with SMTP id q3so2224045edr.12;
        Fri, 06 Nov 2020 10:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZOBcjXzmP3XQp5e/mQVnWSkEumMVDyvqA4wd3UBnBhU=;
        b=d4ZETQ1WkPDPWWBmttdlcBul0lqOCtEA+3fAJK/WVvodl7+CVhzF1YO4/wNL8F5Qcz
         5mxqKu/R11uljI3zLTiG+7dq/7vOjhUyN4rxIBCM9ciIdG8dKqMlv4Hj9rg1R0Vi7uiO
         cnMmgTymh36UPfR/9KDMepv4WjXfDiA7mR3OFs2zOazYVNZryWqIRqfLX6+YAuJIE5b6
         aIB7o8b26IS5IXhzhs5nzJJ3S9TtVPtuDo7a71w5t84HyMJLrnt0Bq+Cem0gR5YRsqkN
         ejAA5vpJKx8r4u/Ys3eftOA+GkpZgDeYZe0EWDwbAUktNhE49EckjcdE0WihY4kvlGQb
         z04g==
X-Gm-Message-State: AOAM532ZE1bFaIEHOGiLlsJRT11FVT1+F6MmQtxUFQbzMfm1VSMHc+j9
        b9DBH8bQpaKyPZ5HT4vMkyo=
X-Google-Smtp-Source: ABdhPJxlNfW66GlVYjTFKyuC1Y2mc6OtyWllQWEOuFkwV8zbiJZ5x9lNaFBO1NvBXnQf8By8//MM+A==
X-Received: by 2002:a50:930d:: with SMTP id m13mr3346982eda.117.1604687336917;
        Fri, 06 Nov 2020 10:28:56 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id h2sm1461648ejx.55.2020.11.06.10.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:28:55 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:28:54 +0100
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
Subject: Re: [PATCH v7 04/47] dt-bindings: memory: tegra20: emc: Correct
 registers range in example
Message-ID: <20201106182854.GD65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-5-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:40PM +0300, Dmitry Osipenko wrote:
> There is superfluous zero in the registers base address and registers
> size should be twice bigger.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 +-

Thanks, applied.

Best regards,
Krzysztof


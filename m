Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F83C388F2
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA7522248
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687943;
	bh=604j15XEkpTZGG7cjd7XOUqZeEvyv3JQg15/7Oz6QbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MgrmLWw6m3HIjkU5F6h/7lZS7RJAId8kCmz4iRoeCCqcpN8dGoDzPq+M3fzKinJdh
	 Ox32ITiHp7BoWIfKic/KBnLxbzBGNbGTrs8AeWTmlLiirVRhQm+p1WZxVBMHnDCEzy
	 VGGgA3Ri6XS8NXVcjsXmecN0/yfcSva2g135mvFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgKFSjC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:39:02 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:47081 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbgKFSjC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:39:02 -0500
Received: by mail-ej1-f65.google.com with SMTP id w13so3257903eju.13;
        Fri, 06 Nov 2020 10:39:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS8UGMj8u7kmdp82DQZoU8AThXuv2qMeUIUJVXpPFg0=;
        b=e94JVBAn3RPDu0XaCx44MTmp0UNZPDcPx/dGqF6jtBtKQZyQKFQxh+3/XLy48vMswl
         0fJp06vJVvV3P/de+Z/rh7v/yeI+6WyoWypLxIaHx+wnL7D38nzldwgTSBtJYzcwN52b
         43lzsubK5ez8f5QEWW3itz31PKgUiP6+gsVKhBZX3khEOmf9YxKnAPC07TP8bzT9AKfn
         1cDFcxadfWeSBhk/gTcKod/J8T4qKJ2kf4rHoyK22QsnYuaQuK5lAtlaM0hhLSpECjvP
         yxOwLT2wb6QAzu05LBY7YlBzDeuQp09iY9S4bfweMdYGKUe7YHjVMc2QICOuAwPQ3jAj
         dlSg==
X-Gm-Message-State: AOAM531vyh8Msvu9X7w8p4f/mkYbmYVHTz+OlknA0sQSDBX1dlwbUn3B
        jwoUqDX9N4pRac+98o28/lQ=
X-Google-Smtp-Source: ABdhPJzcC1h3f6tV7eDIDeRR9kukru5SAGG3SVamlaZS7gKvC+aj5wNwyPVX1PaEI66NBMNPgbM//g==
X-Received: by 2002:a17:906:7f10:: with SMTP id d16mr3376737ejr.104.1604687940019;
        Fri, 06 Nov 2020 10:39:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id l8sm1545278ejr.106.2020.11.06.10.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:38:59 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:38:57 +0100
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
Subject: Re: [PATCH v7 18/47] dt-bindings: memory: tegra30: Add memory client
 IDs
Message-ID: <20201106183857.GR65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-19-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-19-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:54PM +0300, Dmitry Osipenko wrote:
> Each memory client has unique hardware ID, add these IDs.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/dt-bindings/memory/tegra30-mc.h | 67 +++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)

Thanks, applied.

Best regards,
Krzysztof


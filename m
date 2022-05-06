Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A780C433EF
	for <linux-pm@archiver.kernel.org>; Fri,  6 May 2022 04:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388915AbiEFEN5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 May 2022 00:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388911AbiEFEN4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 00:13:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCD5A2D5
        for <linux-pm@vger.kernel.org>; Thu,  5 May 2022 21:10:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i24so5281412pfa.7
        for <linux-pm@vger.kernel.org>; Thu, 05 May 2022 21:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HWTXD5zHq3nd78I0G2fQMtnfTf3zPffmr3z3YODc2yE=;
        b=aR0VAQ9OF8rz6eQoqyBQTSUoRG1tLt8chlxZ7ClCT/tuhYEdA3a5Gh/iaELz13eEkr
         PBavQpH1sdaY3bEweCwZWdgIhFSfB/YYlZl2qjgtO7BExLo5nu/9IO+RhHqMhDE5ZdbH
         vvnGCIfOhBJph1IlZfdMCOgYrJnnX9v5wDmlHyplO/9ZLQp/NUkxuWjWri+UdXFGVuv9
         b2J8stRaPwjuTj3Y69zqMCHZghk1X5tLqyTi38zyJOz6TZ13XByZe4OeAPc7ZvszAuaz
         UKpY4h35iS/5mRA9+AdvBVAMTNYCrNCPDeawqkhL7M34fFcF+936qQ+ZqmBBCkGu4lQt
         5Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HWTXD5zHq3nd78I0G2fQMtnfTf3zPffmr3z3YODc2yE=;
        b=g99F85hd/zmIfpzh5oDurTxPH2d5vX+klyLG1K1wciR1iOKXD7NM32Rs/V5GJCRmVr
         N0DXI1WUVkxplwvVG8PbmTsIapscIoucT/ekBGf5QP7aiuyRdKLCUkHR9xYA3pz3mwil
         zxL4S4q2qadcKTYkNvYALNhtMpGHlKk7V3JYFGyxJR6dPzvJvkx5pUQstvn5OVk2QMKz
         38iJJaKIwGnRMmvKp7UlC9PDyWQTBhRuR3FbbPYjRkNbDE3dcxjLFVK5FDaV12CdGmHL
         fvMe69j4EWjYqzKHghPufAwLE0GA9bejhtWnjU0ziiXDBGo0bryobizm4xzZqgxT1xP0
         qv+Q==
X-Gm-Message-State: AOAM531IwGKEVBlXnU13sIsL5KAaw1LKvwkY6dwhHRuadvR3FUDCDR46
        RovVNZfm4GPoPPoAtsvHJuyzWw==
X-Google-Smtp-Source: ABdhPJyPhc9ZE92xdZuHazul24NTSEAlSyUkTK1yoU17JLWDhr1xi6vZM3E6tgyq2zn7V0wXzXZyrg==
X-Received: by 2002:a05:6a00:bd9:b0:50e:dad:b285 with SMTP id x25-20020a056a000bd900b0050e0dadb285mr1439657pfu.40.1651810213390;
        Thu, 05 May 2022 21:10:13 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id iy11-20020a17090b16cb00b001dc37aef4ffsm2347771pjb.48.2022.05.05.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 21:10:12 -0700 (PDT)
Date:   Fri, 6 May 2022 09:40:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     rafael@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, khilman@baylibre.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 03/10] cpufreq: mediatek: Move voltage limits to
 platform data
Message-ID: <20220506041011.kbqawkzquyzo7yfq@vireshk-i7>
References: <20220505115226.20130-1-rex-bc.chen@mediatek.com>
 <20220505115226.20130-4-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505115226.20130-4-rex-bc.chen@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-05-22, 19:52, Rex-BC Chen wrote:
> Voltages and shifts are defined as macros originally.
> There are different requirements of these values for each MediaTek SoCs.
> Therefore, we add the platform data and move these values into it.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 84 +++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 26 deletions(-)

Applied. Thanks.

-- 
viresh

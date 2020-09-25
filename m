Return-Path: <SRS0=jdfX=DC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDDC4727D
	for <linux-pm@archiver.kernel.org>; Fri, 25 Sep 2020 15:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D72A22B2D
	for <linux-pm@archiver.kernel.org>; Fri, 25 Sep 2020 15:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTgbDyzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgIYPCs (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbgIYPCr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Sep 2020 11:02:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC317C0613CE;
        Fri, 25 Sep 2020 08:02:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so2715232ljd.10;
        Fri, 25 Sep 2020 08:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0NzDc3exkW/y42IG5/D7VdR5AKlK99AqiEVoVMdBfAo=;
        b=UTgbDyzufqlriN1Z/J87TXTtUgz2P1KS7SlOxvQGAVH1qmpAoAFgNXXJXPY2llRmIp
         52tLks5Y8SmCjlw9Wjw/BuB0sDjUaW8tSfCeNGE3FmGItTunUGS7eNz3/sqi0nXZqaUP
         nHk58RrYbehP3fbz4qKdzHfRl2NydXBzn13aPdeO4fZcFGuj9/i7IPjHt9u8UZdbtolX
         CkrdABuk0slGMroVRBaobhWNyUkxh8c2bI0Jl6Oo1T5cKUOPuamJm0Sgv6lIFo92yAvj
         tsMKElTjNMvgMmZvHBG9hUFejMnrv3qyOPLgbmWzNTd7sqHQgrhMfYTANK7mB+8FEUUX
         Yogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0NzDc3exkW/y42IG5/D7VdR5AKlK99AqiEVoVMdBfAo=;
        b=LGJudOYFtDwUjcvQcFtPSuKJPinrb25VE8/cywckxvmWNKcvM+b6on+991kg+aT2WO
         QgmX51QYxjugIemmP/oDtXHZgUh1OsVPE5Am/jo/wNINJKsU4h3+phXE6HRTAcBAMWg3
         7WRd00Kdvwphdr4JsBSGcdBmWQa3m2iv8pUiSVwtczcq0RAvxwmbEA9LdFPe1DhM3TIo
         QcO6zQ4aEooWD8ae9eMYWuosrs3wgTwpGtWAS626lW+mteBYS7N6rk7uP/XNvI7gS6VU
         iSFxlXY/hRUrD6nNlixGC75WaK5B+VAMlCubz0g6znpsxWXjhmUatmIDbBHU+OPeuEoq
         eLuw==
X-Gm-Message-State: AOAM530mZ7m5Ci6DuCdVopYrc7knmyoLpINWuSiJT9ZSyyeB3jVv5Wc7
        NknOKHGEvhGJKJQ8aHPjBP/7hjxES58=
X-Google-Smtp-Source: ABdhPJyMkCaVgiuqp61xQI05ft154L5Ma0JAz14uzcO7FsL3EXFoVUNaykxuFKyJAmwZ1U8AfnXd5w==
X-Received: by 2002:a05:651c:1128:: with SMTP id e8mr1602386ljo.436.1601046165190;
        Fri, 25 Sep 2020 08:02:45 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id i17sm2611741lja.45.2020.09.25.08.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 08:02:44 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] leds: Add driver for Acer Iconia Tab A500
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200906195103.1347-1-digetx@gmail.com>
 <20200906195103.1347-5-digetx@gmail.com> <20200924120041.GB3933@duo.ucw.cz>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <85b505a9-139b-13ab-0bc8-2bf2cb90c5d4@gmail.com>
Date:   Fri, 25 Sep 2020 18:02:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924120041.GB3933@duo.ucw.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

24.09.2020 15:00, Pavel Machek пишет:
> On Sun 2020-09-06 22:51:02, Dmitry Osipenko wrote:
>> Acer Iconia Tab A500 is an Android tablet device which has two LEDs
>> embedded into the Power Button. Orange LED indicates "battery charging"
>> status and white LED indicates "wake-up/charge-done" status. The new LED
>> driver provides control over both LEDs to userspace.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Thanks, applied.

Thank you :)

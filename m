Return-Path: <SRS0=QwoY=AE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE64C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5ACA207FF
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592938973;
	bh=6uTLrbtvnF4WK5NUKMTvr1YpsgO03unIgbgvT5gU56A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LyqxVoLcj9jMS+h4lvqcBCTihqN1wepj7HBVyt41nTc7l+JGLI8q0+tNMAl8kQ7N7
	 h8jrhR07UQjvs8CVUzpcJfUv8X0mqBSRcyb5agS8E5uRa9oa1XMvDz9a3ul18EN9/B
	 RmQVHKWFW/oxMbQ7kxVDyDZL/jcyVvVywFzgi2ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbgFWTCx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733138AbgFWTCx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 15:02:53 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA28220809;
        Tue, 23 Jun 2020 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592938972;
        bh=6uTLrbtvnF4WK5NUKMTvr1YpsgO03unIgbgvT5gU56A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=obugMCWm9igqKMDyu3UAMnYWLTikyXJrEKloLzn1lt5zrtwmX/7hkQIagcLCHO16L
         B8mXqrIdxPY15qBgA0okQlPicXDA5DozQMyXkhM5CoxOzSOavOxAgLGSLqx1nI5pGc
         P4+9Q+P7Wd9YFm+V82jQJGRuY1u9UdgeMh1X8Erc=
Received: by mail-lj1-f171.google.com with SMTP id y11so24697491ljm.9;
        Tue, 23 Jun 2020 12:02:51 -0700 (PDT)
X-Gm-Message-State: AOAM530aEAB+vCUwo1p49w7JxGS4YLFP61AgeZOvxcrg/b1ORfTdhG5N
        oj0CL9RtbtAH1NZtRHkU/yuP0h305FdRzkq/zew=
X-Google-Smtp-Source: ABdhPJxY1+C/zLjQJyd2Ymj4G6d8Wzq5Bs4FqPSVJmQ9FDB2q1YXX8klB/eUrUeCS99qDdDseTgbShhP7jOWHMXFvMI=
X-Received: by 2002:a2e:3a17:: with SMTP id h23mr11444296lja.7.1592938970213;
 Tue, 23 Jun 2020 12:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200623164733.qbhua7b6cg2umafj@macmini.local>
In-Reply-To: <20200623164733.qbhua7b6cg2umafj@macmini.local>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 23 Jun 2020 21:02:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
Message-ID: <CAJKOXPeLuq81NC2xZh3y32EB-_APbDAchZD4OW_eCgQKKO+p8w@mail.gmail.com>
Subject: Re: brocken devfreq simple_ondemand for Odroid XU3/4?
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Jun 2020 at 18:47, Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> Hi everybody,
>
> Is DVFS for memory bus really working on Odroid XU3/4 board?
> Using a simple microbenchmark that is doing only memory accesses, memory DVFS
> seems to not working properly:
>
> The microbenchmark is doing pointer chasing by following index in an array.
> Indices in the array are set to follow a random pattern (cutting prefetcher),
> and forcing RAM access.
>
> git clone https://github.com/wwilly/benchmark.git \
>   && cd benchmark \
>   && source env.sh \
>   && ./bench_build.sh \
>   && bash source/scripts/test_dvfs_mem.sh
>
> Python 3, cmake and sudo rights are required.
>
> Results:
> DVFS CPU with performance governor
> mem_gov = simple_ondemand at 165000000 Hz in idle, should be bumped when the
> benchmark is running.
> - on the LITTLE cluster it takes 4.74308 s to run (683.004 c per memory access),
> - on the big cluster it takes 4.76556 s to run (980.343 c per moemory access).
>
> While forcing DVFS memory bus to use performance governor,
> mem_gov = performance at 825000000 Hz in idle,
> - on the LITTLE cluster it takes 1.1451 s to run (164.894 c per memory access),
> - on the big cluster it takes 1.18448 s to run (243.664 c per memory access).
>
> The kernel used is the last 5.7.5 stable with default exynos_defconfig.

Thanks for the report. Few thoughts:
1. What trans_stat are saying? Except DMC driver you can also check
all other devfreq devices (e.g. wcore) - maybe the devfreq events
(nocp) are not properly assigned?
2. Try running the measurement for ~1 minutes or longer. The counters
might have some delay (which would require probably fixing but the
point is to narrow the problem).
3. What do you understand by "mem_gov"? Which device is it?

Best regards,
Krzysztof

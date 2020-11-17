Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506DEC6379F
	for <linux-pm@archiver.kernel.org>; Tue, 17 Nov 2020 04:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03D2D24671
	for <linux-pm@archiver.kernel.org>; Tue, 17 Nov 2020 04:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5MwZyGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKQEgE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Nov 2020 23:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgKQEgE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2020 23:36:04 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD7BC0617A7
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:36:03 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c66so16331999pfa.4
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2020 20:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GXmmDGf+Ql390cIFcG7bVcYsBCCOZ8KyowjvFWUw4do=;
        b=W5MwZyGZouVl3P4IMf7TuS8nrhz1X2sfj6Tx5PDGw7b8zEslxsX4DD6Wc/d3f63Lh9
         jWuWdWnKjhrPsWfHRRG4PBQGyGJ4gARr+xcJ+fDBV10gD9O0ywrJctsAlOh+eCHYt380
         bzwzHipfMZ9fWxQHyTTW7W0CgL6g9GyPCHhQvY/sn3Kci005p1xeb7svbNFUBnkQWB1K
         S+JbwwJ4vgukWB3zFnNPzpBUMctsk+ItOa1aYjRhg8WlLhJyOSmTgmXKb2rf4YVqLD4Q
         vWuVV9rzvNyzLsqVQjPtSXH9KpRlK9lLFOmSBLGMLYsu2xFhlCOYDC4j6PjH5ceqDKBB
         wqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GXmmDGf+Ql390cIFcG7bVcYsBCCOZ8KyowjvFWUw4do=;
        b=HO++PgDMg4RhJpR9Qjd3ifWsBKf0Junz0mn3rL52ep0b+bJ8RDmbhu8ll/zzEc+JSj
         4qKZfyKmIeJScfP8SK6BNhcwLHlJVkkUWAognVbCgYsqc5bABP5HSH/4YjZHU76yPHk6
         J4STxnJ6CJ7dmIyCTP7DMbIeRvIWSqt+5ovHEf+gv9STcLheccJgQVn87wBJDURcN07n
         hZh1Uzlz1oFIp2rEgyprHF+2p3H4ZvrYKuMka3vLQgr8khJPTuU/3unLO9REmTpKvnkJ
         4URiTkIak1qWEZyMmYZIabH6rz/IBUh6SwJ8+Z4CsmkkJzs6Po5R85KA0auHATp00RzX
         kEag==
X-Gm-Message-State: AOAM5326Etn2M6six72AQEuWGQbZ3WALy4SsY31ldy+dTXXZUi4MFY1I
        kJx8FitZYPJi0l/SNjQUNngRmA==
X-Google-Smtp-Source: ABdhPJwCsvKqJnATAFc1CG4/cKeaAaFwvK+9nVK27eKk0paNUS1Td2ckt/DKW6KQHHvYpgHJu2bbmg==
X-Received: by 2002:a17:90a:df93:: with SMTP id p19mr2783061pjv.170.1605587762764;
        Mon, 16 Nov 2020 20:36:02 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id s21sm5726680pgm.65.2020.11.16.20.36.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 20:36:01 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:06:00 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sumit Gupta <sumitg@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: tegra186: Fix get frequency callback
Message-ID: <20201117043600.bqzr3zmw6n7vj3fj@vireshk-i7>
References: <20201103115514.547047-1-jonathanh@nvidia.com>
 <20201104093349.l3r3eftwyvaoqjf2@vireshk-i7>
 <c4c384cd-2d8f-6f19-cd6b-18450cbf957b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c384cd-2d8f-6f19-cd6b-18450cbf957b@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16-11-20, 15:55, Jon Hunter wrote:
> Hi Rafael,
> 
> On 04/11/2020 09:33, Viresh Kumar wrote:
> > On 03-11-20, 11:55, Jon Hunter wrote:
> >> Commit b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
> >> implemented the CPUFREQ 'get' callback to determine the current
> >> operating frequency for each CPU. This implementation used a simple
> >> looked up to determine the current operating frequency. The problem
> >> with this is that frequency table for different Tegra186 devices may
> >> vary and so the default boot frequency for Tegra186 device may or may
> >> not be present in the frequency table. If the default boot frequency is
> >> not present in the frequency table, this causes the function
> >> tegra186_cpufreq_get() to return 0 and in turn causes cpufreq_online()
> >> to fail which prevents CPUFREQ from working.
> >>
> >> Fix this by always calculating the CPU frequency based upon the current
> >> 'ndiv' setting for the CPU. Note that the CPU frequency for Tegra186 is
> >> calculated by reading the current 'ndiv' setting, multiplying by the
> >> CPU reference clock and dividing by a constant divisor.
> >>
> >> Fixes: b89c01c96051 ("cpufreq: tegra186: Fix initial frequency")
> >>
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >> ---
> >>  drivers/cpufreq/tegra186-cpufreq.c | 33 +++++++++++++++++++-----------
> >>  1 file changed, 21 insertions(+), 12 deletions(-)
> > 
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Rafael: This needs to go in the next rc and so I am not applying it
> > in my tree as this is the only fix I have for now.
> 
> 
> Are you able to pick this up for v5.10 fixes?

Applied to my tree now, will send a PULL request soon.

-- 
viresh

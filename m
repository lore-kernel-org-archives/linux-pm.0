Return-Path: <SRS0=W2EQ=EP=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C3C5517A
	for <linux-pm@archiver.kernel.org>; Mon,  9 Nov 2020 07:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CBA20789
	for <linux-pm@archiver.kernel.org>; Mon,  9 Nov 2020 07:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0rnrVje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgKIHB5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 9 Nov 2020 02:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIHB4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 Nov 2020 02:01:56 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C7DC0613D3
        for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2020 23:01:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so6328504pgh.6
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2020 23:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+md9yIVOWU2vwRWktFQYPICHSpOBwQe+c7giXRAXFCo=;
        b=l0rnrVjeW9d3uICePjAEjZ9yUbnLYtTGiFu/t7BnIg9XQJ5VlFGm5BcHjO4udNK9Gj
         vv9tdg2H8SK/ALOFylILgIQYJhPDLR33qX/blgaN5BGsV4hFHOQNcTWmZZ8Mvet986Es
         JkhDh9x2Q4cSgaKJtS+EiVs1XDuidY4elkSVTnOeEFozewwzWAHDXM/VC90RwoVE8Wpk
         1SUeHeEYkavgLGnImyKKIArD6es31xUbUGkub6FMWCPoQnYSdRWHwIUIHfDPvMW4SQ+f
         BngcG31RTbahUjUG+gsKhvpObFeUcYMQglZ26J41+0ucpGAlfr152MOJrQufM1uO/2FV
         apOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+md9yIVOWU2vwRWktFQYPICHSpOBwQe+c7giXRAXFCo=;
        b=bO3p3a5U/44cQ8JtsTLleDe/uGZGy6qK5r3NYS2+eZeH1ylqWxDvtprCqiCXuxoBqc
         CzP2R6jZ4ch1Kj39YkSlpyrqhmzlHU9vKBVUZ6k+7/xOe5lKx1GvyhFc+Aq/9SzqdQzn
         mrFR27uHG54mbproejK13UhG/qEs9kXSKsSftT8UyOtxvA0XBAY/mHDZM2Epm7w6RbTq
         68Hg11849F5kgsbiuwjM5lE4uP2jMG9+2wfNwCsvDXQakaj4rn+8IBxa+1JBvmsjZC5d
         3o1i1xwXybSgvAKfQLWYzOsBR0b6dG/vpwh3jO643V1e+ry1IAJ8HqaQWJLJvF9Vl8UZ
         WOuA==
X-Gm-Message-State: AOAM532iIWZbJj8sYZ7HMaUyTrylrPcpB6xBkagU0AETbsv0wqqKBFtK
        FgFYCMBr2r3Rkj7FxiNoPghvNQ==
X-Google-Smtp-Source: ABdhPJwlVLkD+NYi3FQePIWPYNIHpruO2oAOkAarFXl4X1F2cdq83bIcnkdkpcJRL5Qu1ITdSMB7TA==
X-Received: by 2002:a17:90a:f993:: with SMTP id cq19mr11896101pjb.173.1604905315719;
        Sun, 08 Nov 2020 23:01:55 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id t9sm10284590pjo.4.2020.11.08.23.01.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 23:01:55 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:31:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] cppc_cpufreq: simplify use of performance
 capabilities
Message-ID: <20201109070153.uczztnbt6jbgl6vc@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> The CPPC performance capabilities are used significantly throughout
> the driver. Simplify the use of them by introducing a local pointer
> "caps" to point to cpu_data->perf_caps, in functions that access
> performance capabilities often.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 40 +++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
